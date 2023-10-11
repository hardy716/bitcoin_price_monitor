import 'dart:convert';
import 'package:web_socket_channel/io.dart';

class BitcoinPriceRemoteDataSource {
  late final channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/btcusdt@trade');

  Stream<double> get bitcoinPriceStream {
    return channel.stream.map((event) {
      final obj = json.decode(event);
      return double.parse(obj['p']);
    });
  }
}
