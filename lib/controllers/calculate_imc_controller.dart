import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../server/connect_server_tcp.dart';

class CalculateImcController extends GetxController {
  CalculateImcController({required ConnectServerTcp connectServerTcp}) : _connectServerTcp = connectServerTcp;

  static CalculateImcController get to => Get.find<CalculateImcController>();

  final ConnectServerTcp _connectServerTcp;

  bool writeDataServer(String weitgh, String height) {
    if (weitgh.isEmpty || height.isEmpty || !height.isNum || !weitgh.isNum) return true;
    if (double.parse(weitgh) < 1 || double.parse(height) < 1) return true;
    _connectServerTcp.writeDataIMC(weitgh, height);
    listenDataServer();

    return false;
  }

  final dataServer = "".obs;
  listenDataServer() {
    _connectServerTcp.listeningData((data) {
      debugPrint(data);
      dataServer.value = data;
    });
  }
}
