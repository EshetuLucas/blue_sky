class PhoneNumberLengthChecker {
  PhoneNumberLengthChecker();

  String phoneValidator(String phone) {
    String phoneNumber;
    if (!phone.startsWith('09')) {
      phoneNumber = "Phone numbe must start with 09";
    } else if (phone.length != 10) {
      phoneNumber = "Phone numbe must be 10 digits";
    } else {
      phoneNumber = "correct";
    }
    return phoneNumber;
  }
}
