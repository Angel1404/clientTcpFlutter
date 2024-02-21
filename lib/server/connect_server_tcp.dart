import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';

class ConnectServerTcp {
  static ConnectServerTcp get to => Get.find<ConnectServerTcp>();

  late final Socket _socket;

  Future conectServer(String ip, String port) async {
    _socket = await Socket.connect(ip, int.parse(port));
  }

  writeDataIMC(String weitgh, String height) async {
    final dataSend = {"weitgh": weitgh, "height": height, "connect": false};

    _socket.write(json.encode(dataSend));
  }

  writeDataIpAndPort(String ip, String port) async {
    final dataSend = {"ip": ip, "port": port, "connect": true};

    _socket.write(json.encode(dataSend));
  }

  listeningData(void Function(dynamic)? onData) {
    final transformer = StreamTransformer<Uint8List, dynamic>.fromHandlers(
      handleData: (Uint8List data, EventSink<dynamic> sink) {
        var str = utf8.decoder.convert(data);
        sink.add(str);
      },
    );
    _socket.transform(transformer).listen(onData);
  }

  destroy() {
    _socket.destroy();
  }
}
