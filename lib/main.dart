import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:servicestack/servicestack.dart';
import 'package:servicestack_rest_client/models/client_address.dart';
import 'package:servicestack_rest_client/services/address_service.dart';
import 'package:servicestack_rest_client/util/snackbar_builder.dart';

import '../util/enums.dart' as Enums;
import 'locator.dart';

void main() {
  // We use a service locator tool (similar to simple IOC container)
  initLocator();

  runApp(const ResponseStatus());
}

class ResponseStatus extends StatelessWidget {
  const ResponseStatus({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ServiceStack REST',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ClientAddress> addrList = [];
  StringBuffer message = StringBuffer();
  bool hasError = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.download),
              onPressed: () async {
                setState(() {
                  message.clear();
                  addrList.clear();
                });

                try {
                  var response = await locator<AddressService>().getAddresses();
                  if (response.responseStatus != null) {
                    //there was an error
                    String message = response.responseStatus?.message as String;
                    SnackBar sb = SnackbarBuilder(
                            context: context,
                            message: message,
                            durationSeconds: 10,
                            messageType: Enums.infoMessageType.Error)
                        .buildSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(sb);
                  } else if (response.addresses != null && response.addresses!.isNotEmpty) {
                    // Success
                    hasError = false;
                    setState(() {
                      addrList.clear();
                      response.addresses!.forEach((element) {
                        var ca = ClientAddress.fromDto(element);
                        addrList.add(ca);
                      });
                    });
                    message.writeln('Successfully retrieved ${addrList.length} addresses from the server.');
                  } else {
                    var msg =
                        'Got nothing from server!\n ResponseStatus: ${response.responseStatus}\nAddress List: ${response
                        .addresses}';
                    SnackBar sb = SnackbarBuilder(
                            context: context,
                            message: msg,
                            durationSeconds: 10,
                            messageType: Enums.infoMessageType.Warning)
                        .buildSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(sb);
                  }
                } on WebServiceException catch (e) {
                  hasError = true;
                  message.writeln('Caught a WebServiceException! Content:');
                  message.writeln('Status: ${e.statusCode}');
                  message.writeln('Status description: ${e.statusDescription}');
                  message.writeln('Message: ${e.message}');

                  if (e.responseStatus != null) {
                    message.writeln('ResponseStatus.Message: ${e.responseStatus!.message}');
                    message.writeln('ResponseStatus.ErrorCode: ${e.responseStatus!.errorCode}');
                    message.writeln('ResponseStatus.Context: ${e.responseStatus!.context}');
                    message.writeln('ResponseStatus.Errors (count only): ${e.responseStatus!.errors?.length}');
                    message.writeln('ResponseStatus.Meta dictionary count: ${e.responseStatus!.meta?.length}');
                  } else {
                    message.writeln('\nResponseStatus object is NULL.');
                  }
                } catch (error) {
                  message.writeln('Unexpected error: ${error.toString()}');
                  hasError = true;
                } finally {
                  if (hasError) {
                    SnackBar sb = SnackbarBuilder(
                        context: context, message: message.toString(), durationSeconds: 20,
                        messageType: Enums.infoMessageType.Error)
                        .buildSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(sb);
                  } else {
                    SnackBar sb = SnackbarBuilder(
                        context: context, message: message.toString(), durationSeconds: 2,
                        messageType: Enums.infoMessageType.Success)
                        .buildSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(sb);
                  }
                }
              },
              label: const Text('Get Address List'),
            ),
          ),
          Expanded(
            child: _buildAddressListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressListView() {
    List<ListTile> list = <ListTile>[];

    return ListView.separated(
        itemCount: addrList.length,
        padding: const EdgeInsets.all(5.0),
        separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
        itemBuilder: (context, index) {
          var clientAddr = addrList[index];
          if (clientAddr == null) return Text('List is empty!');
          return ListTile(
            title: Text(
              'Address No ${index+1}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${clientAddr.street} | ${clientAddr.zip} | ${clientAddr.city}'),
            leading: CircleAvatar(),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              print('Going to display details of address\n ${clientAddr.toString()}');
            },
          );
        });
  }
}
