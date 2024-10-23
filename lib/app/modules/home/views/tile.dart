import 'package:get/get.dart';

class Tile {
  List edges;
  List up = [].obs;
  List right = [].obs;
  List down = [].obs;
  List left = [].obs;

  Tile({required this.edges});

  void CreateAdjancecy(List<Tile> tiles) {
    for (var i = 0; i < tiles.length; i++) {
      if (compareEdge(tiles[i].edges[2], this.edges[0])) {
        this.up.add(i);
      }
      if (compareEdge(tiles[i].edges[3], this.edges[1])) {
        this.right.add(i);
      }
      if (compareEdge(tiles[i].edges[0], this.edges[2])) {
        this.down.add(i);
      }
      if (compareEdge(tiles[i].edges[1], this.edges[3])) {
        this.left.add(i);
      }
    }
  }
}

bool compareEdge(String a, String b) {
  return a == b.split('').reversed.join();
}
