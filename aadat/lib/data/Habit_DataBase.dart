import 'package:aadat/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

//refer box
final _myBox = Hive.box("Habit_DataBase");

class HabitDataBase {
  List todayHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};
  //create defaukt data
  void createDefaultData() {
    todayHabitList = [
      ["Coding", false],
      ["Reading", false],
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  //load date
  void loadData() {
    //if new day
    if (_myBox.get(todaysDateFormatted()) == null) {
      todayHabitList = _myBox.get("CURRENT_HABIT_LIST");
      //set all habit completed to false since it's a new day
      for (int i = 0; i < todayHabitList.length; i++) {
        todayHabitList[i][1] = false;
      }
    }
    //if not new day
    else {
      todayHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  //update database
  void updateDataBase() {
    _myBox.put(todaysDateFormatted(), todayHabitList);

    //update universal habit list in case
    _myBox.put("CURRENT_HABIT_LIST", todayHabitList);

    //CALculate habit capmlete percentages for each day
    calculateHabitPercentage();

    //load heat map
    loadHeatMap();
  }

  void calculateHabitPercentage() {
    int countCompleted = 0;
    for (int i = 0; i < todayHabitList.length; i++) {
      if (todayHabitList[i][1] == true) {
        countCompleted++;
      }
      ;
    }
    String percent = todayHabitList.isEmpty
        ? "0.0"
        : (countCompleted / todayHabitList.length).toStringAsFixed(1);

    //key: "PERCENTAGE_SUMMARY_YYYYMMDD"
    //sTRING of 1dp number between 0-1 inclusive
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDataTimeObject(_myBox.get("START_DATE"));

    //Count the number if days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = converDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      //year
      int year = startDate.add(Duration(days: i)).year;

      //month
      int month = startDate.add(Duration(days: i)).month;

      //day
      int day = startDate.add(Duration(days: i)).day;

      final percentFroEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentFroEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
