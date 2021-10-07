# ServiceStack Flutter client

This is the client for the [ServiceStack Test Server](https://github.
com/thommy66/ServiceStackTestServer) project. 

It is a very simple flutter application demonstrating problems with Serialization of Exceptions and 
`ResponseStatus` objects.

## Infrastructure
This app was created with the following settings / infrastructure

* Mac running the latest version of BigSur (macOS 11.6 darwin-x64).
* Flutter 2.5.1
* Android Studio 2020.3
* iOS Emulator for an iPhone 11 Pro
* ServiceStack Reference V 2.0.0
## What is inside
This app shows a simple list of addresses. Depending on the code on the server (read this [readme](https://github.com/thommy66/ServiceStackTestServer/blob/main/README.md) for details) it should show exceptions and error information in a SnackBar. Unfortunately the error messages are empty (null).
## Remarks
This project uses the [get_it](https://pub.dev/packages/get_it) service locator to eaysily inject services and other stuff.

`Null safety` is enabled in this project.

The client model uses an `address` class which has **non-nullable** members only. It uses a factory constructor to create an instance from a ServiceStack DTO.
