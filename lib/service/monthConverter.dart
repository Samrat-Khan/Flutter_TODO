class ConvertMonth {
  String monthConvert({required int month}) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "Invalid";
    }
  }

  final dayNow = DateTime.now().day;
  final monthNow = DateTime.now().month;
  final yearNow = DateTime.now().year;
  String compareDate(
      {required int day, required int month, required int year}) {
    if (yearNow == year && monthNow == month && dayNow == day) {
      return "Today";
    } else if ((yearNow < year || yearNow == year) &&
            (monthNow < month || monthNow == month) ||
        dayNow < day) {
      return "UpComing";
    } else
      return "Done";
  }
}
