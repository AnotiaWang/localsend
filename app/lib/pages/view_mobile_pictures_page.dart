import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:localsend_app/provider/network/send_provider.dart';

class ViewMobilePicturesPage extends StatefulWidget {
  @override
  _ViewMobilePicturesPageState createState() => _ViewMobilePicturesPageState();
}

class _ViewMobilePicturesPageState extends State<ViewMobilePicturesPage> {
  @override
  Widget build(BuildContext context) {
    final sendState = context.watch<SendNotifier>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text('View Mobile Pictures'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: sendState.entries.map((entry) {
          final picture = entry.value;
          return GestureDetector(
            onTap: () {
              // Handle tap on picture
            },
            child: GridTile(
              child: Image.memory(picture.bytes),
            ),
          );
        }).toList(),
      ),
    );
  }
}
