import '../datasources/bitcoin_price_remote_data_source.dart';
import '../models/bitcoin_price_model.dart';

class BitcoinPriceRepositoryImpl {
  final BitcoinPriceRemoteDataSource remoteDataSource;

  BitcoinPriceRepositoryImpl(this.remoteDataSource);

  Stream<BitcoinPriceModel> get bitcoinPriceStream {
    return remoteDataSource.bitcoinPriceStream.map((price) {
      return BitcoinPriceModel(price);
    });
  }
}
