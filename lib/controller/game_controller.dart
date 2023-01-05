import 'package:get/get.dart';

enum CardStatus { open, closed, matched }

class GameController extends GetxController {
  int cardCount = 12;
  int clickedIndex = -1;
  int moves = 0;

  List<CardList>? playList = [];
  List<CardList>? gameList;

  final String defaultCard = "assets/images/default.png";

  List<CardList> cardsList = [
    CardList(image: "assets/images/circle.png", cardId: 1),
    CardList(image: "assets/images/heart.png", cardId: 2),
    CardList(image: "assets/images/rectangle.png", cardId: 3),
    CardList(image: "assets/images/right.png", cardId: 4),
    CardList(image: "assets/images/star.png", cardId: 5),
    CardList(image: "assets/images/think.png", cardId: 6),
    CardList(image: "assets/images/triangle.png", cardId: 7),
    CardList(image: "assets/images/uparrow.png", cardId: 8),
  ];

  @override
  void onInit() {
    super.onInit();
    moves = 0;
    cardsList.shuffle();
    gameList = cardsList.take(cardCount ~/ 2).toList();
    playList = gameList!.map((p) => CardList.clone(p)).toList() +
        gameList!.map((p) => CardList.clone(p)).toList();
    playList!.shuffle();
  }

  int get getGridCount {
    if (GetPlatform.isWeb) {
      return 4;
    } else {
      return 3;
    }
  }
}

class CardList {
  String? image;
  int? cardId;
  CardStatus status;
  CardList(
      {required this.image,
      required this.cardId,
      this.status = CardStatus.closed});

  factory CardList.clone(CardList source) {
    return CardList(image: source.image, cardId: source.cardId);
  }
  @override
  String toString() {
    return image! + cardId.toString();
  }
}
