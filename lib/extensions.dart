extension DateTimeFormatter on DateTime {

  String counterFormat() {
    final now = DateTime.now();
    final difference = this.difference(now);

    int days = difference.inDays;
    int hours = difference.inHours;
    int minutes = difference.inMinutes;
    int seconds = difference.inSeconds;

    if (days >= 1) {
      return "$days days";
    }
    
    if(hours >= 1) {

      return "$hours hours ${minutes - (hours * 60)} mins";
    }
    
    if(minutes >= 1) {
      return "$minutes mins ${seconds - (minutes * 60)}s";
    }

    return "$seconds s";
  }

  String fancyDateFormat() {

    var ordinal = "th";
    if(day.toString().endsWith('1') && !day.toString().endsWith('11')) ordinal = 'st';
    if(day.toString().endsWith('2') && !day.toString().endsWith('12')) ordinal = 'nd';
    if(day.toString().endsWith('3') && !day.toString().endsWith('13')) ordinal = 'rd';

    String monthInWords = '';

    switch (month) {
      case 1:
        monthInWords = 'Jan';
        break;
      case 2:
        monthInWords = 'Feb';
        break;
      case 3:
        monthInWords = 'Mar';
        break;
      case 4:
        monthInWords = 'Apr';
        break;
      case 5:
        monthInWords = 'May';
        break;
      case 6:
        monthInWords = 'June';
        break;
      case 7:
        monthInWords = 'July';
        break;
      case 8:
        monthInWords = 'Aug';
        break; 
      case 9:
        monthInWords = 'Sept';
        break;
      case 10:
        monthInWords = 'Oct';
        break;
      case 11:
        monthInWords = 'Nov';
        break;
      case 12:
        monthInWords = 'Dec';
        break;   
    }
    
    return "$day$ordinal $monthInWords, $year";
  }

  String fancyTimeFormat() {

    var meridiem = "am";
    if(hour > 12) meridiem = 'pm';

    
    
    return "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")} $meridiem";
  }
}