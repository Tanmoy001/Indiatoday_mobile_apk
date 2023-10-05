import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class ViewArtical extends StatefulWidget {
  String? url;
  String? name;
  ViewArtical({super.key, required this.url, required this.name});

  @override
  State<ViewArtical> createState() => _ViewArticalState();
}

class _ViewArticalState extends State<ViewArtical> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // You can show a message or alternative content for desktop platforms here.
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.name!),
        ),
        body:const  Center(
          child: Text("Webview is not supported on desktop platforms."),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.name!),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
        ),
      );
    }
  }
}
