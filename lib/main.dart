import 'package:cliente_server_tcp/binding/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/conect_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GlobalBinding(),
      title: 'Material App',
      home: const SimpleView(),
    );
  }
}
