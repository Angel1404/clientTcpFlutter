import 'package:cliente_server_tcp/server/connect_server_tcp.dart';
import 'package:get/get.dart';

import '../models/status_service_emun.dart';

class ConnectServiceController extends GetxController {
  static ConnectServiceController get to => Get.find<ConnectServiceController>();

  final ConnectServerTcp _connectServerTcp;

  ConnectServiceController({required ConnectServerTcp connectServerTcp}) : _connectServerTcp = connectServerTcp;

  final statusService = StatusService.disconect.obs;

  Future<bool> connectService(String ip, String port) async {
    try {
      if (!ip.isIPv4 || port.length > 4 || ip.isEmpty || port.isEmpty || !port.isNum) return true;
      await _connectServerTcp.conectServer(ip, port);
      _connectServerTcp.writeDataIpAndPort(ip, port);
      listenDataServiceConnect();
      return false;
    } catch (e) {
      return true;
    }
  }

  listenDataServiceConnect() {
    _connectServerTcp.listeningData((data) {
      statusService.value = data;
    });
  }
}
