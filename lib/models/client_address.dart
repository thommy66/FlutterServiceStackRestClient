import 'package:servicestack_rest_client/models/dtos.dart';

class ClientAddress {
  String addrId;
  String street;
  String zip;
  String city;

  ClientAddress({
    this.addrId = '',
    this.street = '',
    this.zip = '',
    this.city = '',
  });

  factory ClientAddress.fromDto(Address address) {
    var ca = ClientAddress(
      addrId: address.addrId ?? '',
      street: address.street ?? '',
      zip: address.zip ?? '',
      city: address.zip ?? '',
    );

    return ca;
  }
}
