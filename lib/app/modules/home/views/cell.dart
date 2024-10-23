import 'package:get/get.dart';

class Cell {
  var collapsed = false.obs;
  var options = [].obs;
  Cell({required this.collapsed, required this.options});
}
