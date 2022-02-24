import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => ZoomDrawer.of(context)!.toggle(), icon: Icon(Icons.menu));
  }

}