import 'package:pokeman_cg_sdk/src/type_aliases.dart';

class SetImages {
  SetImages({
    required this.symbol,
    required this.logo,
  });

  factory SetImages.fromJson(JsonMap json) {
    return SetImages(
      symbol: json['symbol'],
      logo: json['logo'],
    );
  }

  final String symbol;

  final String logo;
}
