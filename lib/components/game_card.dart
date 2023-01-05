import 'package:flutter/material.dart';
import '../controller/game_controller.dart';

Widget gameCard(GameController _controller, int index) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8.0),
      image: DecorationImage(
        image: AssetImage(
            (_controller.playList![index].status == CardStatus.open) ||
                    (_controller.playList![index].status == CardStatus.matched)
                ? _controller.playList![index].image!
                : _controller.defaultCard),
        fit: BoxFit.contain,
      ),
    ),
  );
}
