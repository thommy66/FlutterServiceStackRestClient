import 'package:get_it/get_it.dart';
import 'package:servicestack/client.dart';
import 'package:servicestack_rest_client/services/address_service.dart';

final locator = GetIt.instance;

void initLocator(){
  // register the classes
  var client = JsonServiceClient('http://localhost:5001');
  locator.registerSingleton<JsonServiceClient>(client);
  locator.registerSingleton<AddressService>(AddressService());
}