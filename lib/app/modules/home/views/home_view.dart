import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wavefunction/app/modules/home/views/cell.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.width * 0.5,
          height: Get.height,
          child: buildGridView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.Setup();
        },
        child: Icon(Icons.restore),
      ),
    );
  }

  Widget buildGridView() {
    return Obx(
      () => GridView.builder(
        padding: EdgeInsets.all(0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: controller.dim,
            childAspectRatio: 1,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0),
        itemCount: controller.grid.length,
        itemBuilder: (context, index) {
          Cell model = controller.grid[index];
          return InkWell(
            onDoubleTap: () {
              controller.pickCell(index);
              for (var i = 0; i < controller.grid.length; i++) {
                for (var element in controller.grid) {
                  if (element.collapsed.value == true) {
                    controller.pickCell(controller.grid.indexOf(element));
                  }
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.grey,
                image: DecorationImage(
                    image: (model.collapsed.value || model.options.length == 1)
                        ? AssetImage(
                            'assets/images/tile (${model.options[0] + 1}).png')
                        : AssetImage('assets/images/tile (13).png'),
                    fit: BoxFit.fill),
              ),
              child: Obx(
                () => Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.options.length}',
                        style: controller
                            .collapseStyle(model.collapsed.value)
                            .copyWith(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
