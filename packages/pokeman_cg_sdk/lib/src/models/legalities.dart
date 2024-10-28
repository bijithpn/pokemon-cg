import 'package:pokeman_cg_sdk/src/type_aliases.dart';

class SetLegalities {
  SetLegalities({
    required this.unlimited,
    required this.expanded,
  });

  factory SetLegalities.fromJson(JsonMap json) {
    return SetLegalities(
      unlimited: json['unlimited'],
      expanded: json['expanded'],
    );
  }

  final String? unlimited;

  final String? expanded;
}
