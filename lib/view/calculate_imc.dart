import 'package:cliente_server_tcp/controllers/calculate_imc_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculateIMC extends StatefulWidget {
  const CalculateIMC({super.key});

  @override
  State<CalculateIMC> createState() => _CalculateIMCState();
}

class _CalculateIMCState extends State<CalculateIMC> {
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;
  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
  }

  final controller = CalculateImcController.to;

  calculateImc() {
    final response = controller.writeDataServer(_weightController.text, _heightController.text);
    if (response) {
      Get.snackbar("Error", "Verifique que los datos ingresados sean correctos");

      return;
    }
    Get.snackbar("Ok", "Datos enviados");
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * .1),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  hintText: "0.0",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  hintText: "0.0",
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Text("IMC : ${controller.dataServer} ")),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: calculateImc,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(150, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Calcular"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
