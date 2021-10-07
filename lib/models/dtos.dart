/* Options:
Date: 2021-10-07 09:34:36
Version: 5.121
Tip: To override a DTO option, remove "//" prefix before updating
BaseUrl: https://localhost:5001

GlobalNamespace: dtos
//AddServiceStackTypes: True
//AddResponseStatus: False
//AddImplicitVersion: 
//AddDescriptionAsComments: True
//IncludeTypes: 
//ExcludeTypes: 
//DefaultImports: package:servicestack/servicestack.dart
*/


library dtos;
import 'package:servicestack/servicestack.dart';

class Address implements IConvertible
{
    String? addrId;
    String? street;
    String? zip;
    String? city;

    Address({this.addrId,this.street,this.zip,this.city});
    Address.fromJson(Map<String, dynamic> json) { fromMap(json); }

    fromMap(Map<String, dynamic> json) {
        addrId = json['addrId'];
        street = json['street'];
        zip = json['zip'];
        city = json['city'];
        return this;
    }

    Map<String, dynamic> toJson() => {
        'addrId': addrId,
        'street': street,
        'zip': zip,
        'city': city
    };

    getTypeName() => "Address";
    TypeContext? context = _ctx;
}

class GetAddressListResponse implements IConvertible
{
    List<Address>? addresses;
    ResponseStatus? status;

    GetAddressListResponse({this.addresses,this.status});
    GetAddressListResponse.fromJson(Map<String, dynamic> json) { fromMap(json); }

    fromMap(Map<String, dynamic> json) {
        addresses = JsonConverters.fromJson(json['addresses'],'List<Address>',context!);
        status = JsonConverters.fromJson(json['status'],'ResponseStatus',context!);
        return this;
    }

    Map<String, dynamic> toJson() => {
        'addresses': JsonConverters.toJson(addresses,'List<Address>',context!),
        'status': JsonConverters.toJson(status,'ResponseStatus',context!)
    };

    getTypeName() => "GetAddressListResponse";
    TypeContext? context = _ctx;
}

class GetAddressResponse implements IConvertible
{
    Address? address;
    ResponseStatus? status;

    GetAddressResponse({this.address,this.status});
    GetAddressResponse.fromJson(Map<String, dynamic> json) { fromMap(json); }

    fromMap(Map<String, dynamic> json) {
        address = JsonConverters.fromJson(json['address'],'Address',context!);
        status = JsonConverters.fromJson(json['status'],'ResponseStatus',context!);
        return this;
    }

    Map<String, dynamic> toJson() => {
        'address': JsonConverters.toJson(address,'Address',context!),
        'status': JsonConverters.toJson(status,'ResponseStatus',context!)
    };

    getTypeName() => "GetAddressResponse";
    TypeContext? context = _ctx;
}

// @Route("/addresses")
class GetAddressList implements IReturn<GetAddressListResponse>, IConvertible
{
    GetAddressList();
    GetAddressList.fromJson(Map<String, dynamic> json) : super();
    fromMap(Map<String, dynamic> json) {
        return this;
    }

    Map<String, dynamic> toJson() => {};
    createResponse() => GetAddressListResponse();
    getResponseTypeName() => "GetAddressListResponse";
    getTypeName() => "GetAddressList";
    TypeContext? context = _ctx;
}

// @Route("/address")
class GetAddress implements IReturn<GetAddressResponse>, IConvertible
{
    String? addressId;

    GetAddress({this.addressId});
    GetAddress.fromJson(Map<String, dynamic> json) { fromMap(json); }

    fromMap(Map<String, dynamic> json) {
        addressId = json['addressId'];
        return this;
    }

    Map<String, dynamic> toJson() => {
        'addressId': addressId
    };

    createResponse() => GetAddressResponse();
    getResponseTypeName() => "GetAddressResponse";
    getTypeName() => "GetAddress";
    TypeContext? context = _ctx;
}

TypeContext _ctx = TypeContext(library: 'dtos', types: <String, TypeInfo> {
    'Address': TypeInfo(TypeOf.Class, create:() => Address()),
    'GetAddressListResponse': TypeInfo(TypeOf.Class, create:() => GetAddressListResponse()),
    'List<Address>': TypeInfo(TypeOf.Class, create:() => <Address>[]),
    'GetAddressResponse': TypeInfo(TypeOf.Class, create:() => GetAddressResponse()),
    'GetAddressList': TypeInfo(TypeOf.Class, create:() => GetAddressList()),
    'GetAddress': TypeInfo(TypeOf.Class, create:() => GetAddress()),
});

