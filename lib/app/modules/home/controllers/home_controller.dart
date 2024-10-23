import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wavefunction/app/modules/home/views/cell.dart';
import 'package:wavefunction/app/modules/home/views/tile.dart';

class HomeController extends GetxController {
  TextStyle collapseStyle(bool collapsed) {
    return TextStyle(
      fontSize: 15,
      color: (collapsed) ? Colors.green : Colors.white,
    );
  }

  int dim = 7;

  var index = 0.obs;

  RxList<Cell> grid = RxList.empty();

  List<Tile> tiles = [
    Tile(edges: ['aba', 'aaa', 'aba', 'aba']),
    Tile(edges: ['aba', 'aaa', 'aba', 'aaa']),
    Tile(edges: ['aaa', 'aba', 'aba', 'aaa']),
    Tile(edges: ['aaa', 'aaa', 'aaa', 'aba']),
    Tile(edges: ['aaa', 'aba', 'aaa', 'aba']),
    Tile(edges: ['aba', 'aba', 'aba', 'aba']),
    Tile(edges: ['aba', 'aaa', 'aaa', 'aba']),
    Tile(edges: ['aaa', 'aaa', 'aba', 'aaa']),
    Tile(edges: ['aaa', 'aaa', 'aba', 'aba']),
    Tile(edges: ['aaa', 'aba', 'aba', 'aba']),
    Tile(edges: ['aba', 'aba', 'aaa', 'aaa']),
    Tile(edges: ['aba', 'aba', 'aaa', 'aba']),
    Tile(edges: ['aaa', 'aaa', 'aaa', 'aaa']),
    Tile(edges: ['aba', 'aaa', 'aaa', 'aaa']),
    Tile(edges: ['aba', 'aba', 'aba', 'aaa']),
  ];

  void createConstraint() {
    Random random = Random();
    int start = (dim * dim) ~/ 2;
    for (var i = 0; i < start; i++) {
      int randomNum = random.nextInt(grid.length);
      Cell pickedGrid = grid[randomNum];
      pickedGrid.collapsed.value = true;
      pickedGrid.options.value = [12];
      pickCell(randomNum);
    }
  }

  void Setup() {
    List<Cell> temp_grid = List.generate(
        dim * dim,
        (value) => Cell(
            collapsed: RxBool(false),
            options: RxList.generate(tiles.length, (index) => index)));

    grid = RxList.generate(
      dim * dim,
      (value) => Cell(
        collapsed: RxBool(false),
        options: RxList.generate(tiles.length, (index) => index),
      ),
    );

    for (var tile in tiles) {
      tile.CreateAdjancecy(tiles);
    }
    createConstraint();
  }

  List checkValid(List arr, List valid) {
    List element = [];
    for (var i in arr) {
      if (valid.contains(i)) {
        element.add(i);
      }
    }
    return element;
  }

  void pickCell(int index) {
    Random random = Random();
    int len = grid.length;
    Cell pickedCell = grid[index];

    int pickedOption =
        pickedCell.options[random.nextInt(pickedCell.options.length)];

    pickedCell.options = RxList([pickedOption]);
    pickedCell.collapsed.value = true;

    // CHECKING UP
    if (!(index - dim < 0)) {
      Cell up = grid[index - dim];
      List validOptions = checkValid(up.options, tiles[pickedOption].up);
      if (up.collapsed.value == false) up.options = RxList(validOptions);
      grid[index - dim] = up;
      if (up.options.length == 1) up.collapsed.value = true;
    }
    // CHECKING DOWN
    if ((index + dim < grid.length)) {
      Cell down = grid[index + dim];
      List validOptions = checkValid(down.options, tiles[pickedOption].down);
      if (down.collapsed.value == false) down.options = RxList(validOptions);
      grid[index + dim] = down;
      if (down.options.length == 1) down.collapsed.value = true;
    }
    // CHECKING LEFT
    if (!(index % dim == 0)) {
      Cell left = grid[index - 1];
      List validOptions = checkValid(left.options, tiles[pickedOption].left);
      if (left.collapsed.value == false) left.options = RxList(validOptions);
      grid[index - 1] = left;
      if (left.options.length == 1) left.collapsed.value = true;
    }
    // CHECKING RIGHT
    if (!(index % dim == (dim - 1))) {
      Cell right = grid[index + 1];
      List validOptions = checkValid(right.options, tiles[pickedOption].right);
      if (right.collapsed.value == false) right.options = RxList(validOptions);
      grid[index + 1] = right;
      if (right.options.length == 1) right.collapsed.value = true;
    }
  }

  @override
  void onInit() {
    Setup();
    // createConstraint();
    super.onInit();
  }
}
