import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../data/datasources/bitcoin_price_remote_data_source.dart';
import '../../data/repositories/bitcoin_price_repository_impl.dart';
import '../../domain/usecases/get_bitcoin_price.dart';
import '../widgets/animated_number_text.dart';
import '../widgets/line_chart.dart';

class BitcoinScreen extends StatefulWidget {
  const BitcoinScreen({super.key});

  @override
  State<BitcoinScreen> createState() => BitcoinScreenState();
}

class BitcoinScreenState extends State<BitcoinScreen> {
  final GetBitcoinPrice getBitcoinPrice = GetBitcoinPrice(
      BitcoinPriceRepositoryImpl(BitcoinPriceRemoteDataSource()));

  String priceString = "Loading";
  final List<double> priceList = [
    27240.35,
    27239.51,
    27240.87,
    27241.98,
    27241.98,
    27240.36,
    27238.61,
    27238.62,
    27238.62,
    27238.55,
  ];

  final intervalDuration = 1.seconds;
  DateTime lastUpdatedTime = DateTime.now();

  @override
  void initState() {
    getBitcoinPrice.execute().listen((bitcoinPrice) {
      if (DateTime.now().difference(lastUpdatedTime) > intervalDuration) {
        lastUpdatedTime = DateTime.now();
        setState(() {
          priceList.add(bitcoinPrice.price);
          if (priceList.length > 11) {
            priceList.removeAt(0);
          }
          priceString = bitcoinPrice.price.toStringAsFixed(2);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "The Price of Bitcoin right now is...".text.make(),
            AnimatedNumberText(
              priceString,
              textStyle:
                  const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              duration: 30.milliseconds,
            ),
            const SizedBox(
              height: 100.0,
            ),
            LineChartWidget(priceList),
            const SizedBox(
              height: 100.0,
            ),
            Row(
              children: [
                if (priceList.isNotEmpty) ...[
                  const Spacer(),
                  "minValue : ${priceList.reduce((value, element) => value < element ? value : element).toStringAsFixed(2)}"
                      .text
                      .make(),
                  const Spacer(),
                  "maxValue : ${priceList.reduce((value, element) => value > element ? value : element).toStringAsFixed(2)}"
                      .text
                      .make(),
                  const Spacer(),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
