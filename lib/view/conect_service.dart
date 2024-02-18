import 'package:cliente_server_tcp/controllers/connect_service_controller.dart';
import 'package:cliente_server_tcp/models/status_service_emun.dart';
import 'package:cliente_server_tcp/view/calculate_imc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleView extends StatefulWidget {
  const SimpleView({
    super.key,
  });

  @override
  State<SimpleView> createState() => _SimpleViewState();
}

class _SimpleViewState extends State<SimpleView> {
  late final TextEditingController _ipController;
  late final TextEditingController _portController;
  @override
  void initState() {
    super.initState();
    _ipController = TextEditingController();
    _portController = TextEditingController();
  }

  final controller = ConnectServiceController.to;

  conectService() async {
    final response = await controller.connectService(_ipController.text, _portController.text);
    if (response) {
      Get.snackbar("Error", "Verifique que los datos ingresados sean correctos");
      return;
    }
    await 2.delay();
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CalculateIMC(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cliente IMC"),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(26),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: size.height * .1),
              TextFormField(
                controller: _ipController,
                decoration: const InputDecoration(
                  hintText: "IP",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _portController,
                decoration: const InputDecoration(
                  hintText: "Puerto",
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                final isConnect = controller.statusService.value == StatusService.connect;
                return Text(
                  "Estado: ${controller.statusService.value.status} ",
                  style: TextStyle(color: isConnect ? Colors.green : null),
                );
              }),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: conectService,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(150, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Conectar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
