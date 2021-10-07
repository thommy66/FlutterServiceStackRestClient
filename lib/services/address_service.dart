import 'package:servicestack/client.dart';
import 'package:servicestack_rest_client/models/dtos.dart';

import '../locator.dart';

class AddressService {
  var client = locator<JsonServiceClient>();

  Future<GetAddressListResponse> getAddresses() async {
    var request = GetAddressList();

    try {
      var response = await client.get(request);
      return response;
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<GetAddressResponse> getAddress(String addressId) async {
    var request = GetAddress(addressId: addressId);

    try {
      var response = await client.get(request);
      return response;
    } catch (err) {
      var msg = 'Something went wrong!';
      return Future.error(msg);
    }
  }

}