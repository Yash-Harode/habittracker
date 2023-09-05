//return today data formmatted yyyymmdd
String todaysDateFormatted() {
  //today
  var dataTimeObject = DateTime.now();

  //year in daye formate yyyy
  String year = dataTimeObject.year.toString();

  //month in the formate of mm
  String month = dataTimeObject.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }

  //day in the formate of dd
  String day = dataTimeObject.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }

  //final
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

//convert string yyyymmdd into  datetime object
DateTime createDataTimeObject(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}

//convert the DateTime to a string yyyymmdd
String converDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  //if month is single num like 2 >>> 02
  if (month.length == 1) month = '0$month';
  //if day is single num like 2 >>> 02
  String day = dateTime.day.toString();
  if (day.length == 1) day = '0$day';

  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
// DateTime.now()-> 2023/2/11 -> 20230211