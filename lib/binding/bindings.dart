import 'package:cliente_server_tcp/controllers/calculate_imc_controller.dart';
import 'package:cliente_server_tcp/controllers/connect_service_controller.dart';
import 'package:cliente_server_tcp/server/connect_server_tcp.dart';
import 'package:get/get.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectServerTcp>(() => ConnectServerTcp(), fenix: true);
    Get.lazyPut<ConnectServiceController>(() => ConnectServiceController(connectServerTcp: ConnectServerTcp.to), fenix: true);
    Get.lazyPut<CalculateImcController>(() => CalculateImcController(connectServerTcp: ConnectServerTcp.to), fenix: true);
  }
}
