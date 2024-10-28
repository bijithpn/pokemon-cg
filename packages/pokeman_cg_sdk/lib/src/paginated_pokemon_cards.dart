import 'package:flutter/foundation.dart';
import 'package:pokeman_cg_sdk/pokeman_cg_sdk.dart';
import 'package:pokeman_cg_sdk/src/models/card.dart';

class PaginatedPokemonCards with ChangeNotifier {
  PaginatedPokemonCards(this.cards, this.api);

  final List<PokemonCard> cards;

  final PokemonTcgApi api;

  int pageNum = 0;

  Future<void> loadMore({
    int page = 0,
  }) async {
    pageNum = page;
    var cards = await api.getCards(page: page);
    this.cards.addAll(cards);
    notifyListeners();
  }

  Future<void> loadMoreForSet(
    String setId, {
    int page = 0,
  }) async {
    pageNum = page;
    var cards = await api.getCardsForSet(
      setId,
      page: page,
    );
    this.cards.addAll(cards);
    notifyListeners();
  }
}
