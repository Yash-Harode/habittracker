import 'package:aadat/components/monthly_summary.dart';
import 'package:aadat/components/my_alert_box.dart';
import 'package:aadat/components/my_float.dart';
import 'package:aadat/data/Habit_DataBase.dart';
import 'package:flutter/material.dart';
import 'package:aadat/components/habit_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //instace of database
  HabitDataBase db = HabitDataBase();
  final _myBox = Hive.box("Habit_DataBase");
  @override
  void initState() {
    //if there is already data in database
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }
    //else it is not the first time you entered in app so load
    else {
      db.loadData();
    }
    //update the database
    db.updateDataBase();

    super.initState();
  }

  //checkBox Tapped
  void checkBoxTapped(bool? val, int index) {
    setState(() {
      db.todayHabitList[index][1] = val;
    });
    db.updateDataBase();
  }

  final _newHabitNameController = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          //hintText: "Enter Habit Name",
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  void saveNewHabit() {
    setState(() {
      db.todayHabitList.add([_newHabitNameController.text, false]);
    });

    //clear bro navigation pop kr rha h
    _newHabitNameController.clear();
    //pop alert box
    Navigator.of(context).pop();

    db.updateDataBase();
  }

  void cancelDialogBox() {
    //clear bro navigation pop kr rha h
    _newHabitNameController.clear();
    //pop alert box
    Navigator.of(context).pop();
  }

  //open habit name edit settings
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          //hintText: "Enter New Habit", //todayHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  //save the existing habit
  void saveExistingHabit(int index) {
    setState(() {
      db.todayHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDataBase();
  }

  //delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todayHabitList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      backgroundColor: Colors.grey[300],
      body: ListView(
        children: [
          //monthly Summary
          MonthlySummary(
              datasets: db.heatMapDataSet, startDate: _myBox.get("START_DATE")),

          //list of habits
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: db.todayHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: db.todayHabitList[index][0],
                habitCompleted: db.todayHabitList[index][1],
                onChanged: (val) => checkBoxTapped(val, index),
                settingTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
