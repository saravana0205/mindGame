import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/game_card.dart';
import '../components/info_card.dart';
import '../controller/game_controller.dart';

class GameScreen extends StatelessWidget {
  final _controller = Get.put(GameController());

  GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<GameController>(
        init: _controller,
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 75,
            ),
            const Center(
              child: Text(
                "Memory",
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            SizedBox(
              width: 280,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  infoCard("MOVES", "${_controller.moves ~/ 2}"),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 330,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  itemCount: _controller.playList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _controller.getGridCount,
                    mainAxisExtent: 128,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (_controller.playList![index].status !=
                            CardStatus.matched) {
                          _controller.moves++;
                          if (_controller.playList![index].status ==
                              CardStatus.open) {
                            _controller.playList![index].status =
                                CardStatus.closed;
                          } else if (_controller.playList![index].status ==
                              CardStatus.closed) {
                            _controller.playList![index].status =
                                CardStatus.open;
                          }
                          _controller.update();
                          if (_controller.moves != 0 &&
                              _controller.moves % 2 == 0) {
                            if (_controller.playList![index].cardId ==
                                    _controller
                                        .playList![_controller.clickedIndex]
                                        .cardId &&
                                index != _controller.clickedIndex) {
                              _controller.playList![index].status =
                                  CardStatus.matched;
                              _controller.playList![_controller.clickedIndex]
                                  .status = CardStatus.matched;
                              _controller.update();
                              var count = _controller.playList!
                                  .where((c) => c.status == CardStatus.matched)
                                  .length;
                              if (count == _controller.cardCount) {
                                openDialog();
                              }
                            } else {
                              await Future.delayed(
                                  const Duration(milliseconds: 800), () {
                                _controller.playList![index].status =
                                    CardStatus.closed;
                                _controller.playList![_controller.clickedIndex]
                                    .status = CardStatus.closed;
                              });
                            }
                          }
                          _controller.clickedIndex = index;
                          _controller.update();
                        }
                      },
                      child: gameCard(_controller, index),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  void openDialog() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game over'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Text(
              'You finished the game with ${_controller.moves ~/ 2} moves'),
          actions: [
            TextButton(
              child: const Text("Play again"),
              onPressed: () {
                _controller.onInit();
                _controller.update();
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
