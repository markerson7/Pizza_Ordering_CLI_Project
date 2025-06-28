class Customer {
  String _name;
  String _address;
  String _phoneNumber;

  Customer(this._name, this._address, this._phoneNumber);

  String get name => _name;
  set name(String value) => _name = value;

  String get address => _address;
  set address(String value) => _address = value;

  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) => _phoneNumber = value;

  Map<String, String> toJson() => {
    'name': _name,
    'address': _address,
    'phoneNumber': _phoneNumber,
  };
}
