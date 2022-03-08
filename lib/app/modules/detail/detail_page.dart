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
                    homeCtrl.changeTask(null);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0.wp,
            ),
            child: Row(
              children: [
                Icon(
                  IconData(
                    task.icon,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: color,
                ),
                SizedBox(
                  width: 3.0.sp,
                ),
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Obx(() {
            var totalTodos =
                homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0.wp,
                top: 3.0.wp,
                right: 16.0.wp,
              ),
              child: Row(
                children: [
                  Text(
                    'Total tasks: $totalTodos',
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
