import 'package:flutter/material.dart';
import '../util/enums.dart' as Enums;

class SnackbarBuilder {
  final String message;
  final int durationSeconds;
  final Enums.infoMessageType messageType;
  BuildContext context;

  SnackbarBuilder({
    required this.context,
    required this.message,
    required this.messageType,
    this.durationSeconds = 5,
  });

  SnackBar buildSnackBar() {
    Color sbColor;
    Color sbTextColor = Colors.white;
    Icon sbIcon = const Icon(Icons.feedback);

    switch (messageType) {
      case Enums.infoMessageType.Error:
        sbColor = Colors.redAccent;
        sbIcon = const Icon(
          Icons.error,
        );
        break;
      case Enums.infoMessageType.Warning:
        sbColor = Colors.amber;
        sbTextColor = Colors.black;
        sbIcon = const Icon(
          Icons.warning,
        );
        break;
      case Enums.infoMessageType.Success:
        sbColor = Colors.green;
        sbIcon = const Icon(
          Icons.check_circle,
        );
        break;
    }

    return SnackBar(
      width: MediaQuery.of(context).size.width - 100,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Row(
        children: [
          sbIcon,
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              message,
              softWrap: true,
              style: TextStyle(color: sbTextColor),
            ),
          ),
        ],
      ),
      backgroundColor: sbColor,
      duration: const Duration(seconds: 10),
    );
  }
}
