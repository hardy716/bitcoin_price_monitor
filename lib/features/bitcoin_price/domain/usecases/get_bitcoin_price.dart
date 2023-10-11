import '../../data/repositories/bitcoin_price_repository_impl.dart';
import '../entities/bitcoin_price.dart';

class GetBitcoinPrice {
  final BitcoinPriceRepositoryImpl repository;

  GetBitcoinPrice(this.repository);

  Stream<BitcoinPrice> execute() {
    return repository.bitcoinPriceStream.map((model) {
      return BitcoinPrice(model.price);
    });
  }
}
