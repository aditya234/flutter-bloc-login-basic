class Validations {
  String validateName(String value) {
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value.trim()))
      return ' Please enter only alphabetical characters.';
    return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) return ' Email is required.';
    final RegExp nameExp = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value.trim())) return ' Invalid email address';
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'Please choose a password.';
    if (value.length < 8) return 'Password must contain atleast 8 characters.';
    return null;
  }

  String validatePhoneNumber(String value) {
    if (value.isEmpty) return 'Phone Number is required';
    final RegExp phoneExp = new RegExp(r'[2-9]{2}\d{8}');
    if (!phoneExp.hasMatch(value.trim()) && value.length == 10)
      return 'Invalid phone number';
    return null;
  }

  String validateDate(String value) {
    if (value.isEmpty) return 'Date is required.';
    final RegExp nameExp = new RegExp(
        r'^([1-9]|1[012])[- /.]([1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d$');
    if (!nameExp.hasMatch(value)) return 'Date format should be dd-mm-yyyy.';
    return null;
  }
}
