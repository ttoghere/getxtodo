import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/task.dart';
import '/app/core/utils/extensions.dart';
import '/app/modules/home/controllers/home_controller.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(3.0.wp),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: color,
              ),
            ],
          )
        ],
      ),
    );
  }
}
