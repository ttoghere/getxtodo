import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodo/app/core/utils/extensions.dart';
import 'package:getxtodo/app/modules/home/controllers/home_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../data/models/task.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    var squareWidth = Get.width - 12.0.wp;
    final color = HexColor.fromHex(task.color);
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 7,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //T0D0 change to dynamic after finish todo Crud
          StepProgressIndicator(
            totalSteps: 100,
            currentStep: 88,
            size: 5,
            padding: 0,
            selectedGradientColor: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.5), color],
            ),
            unselectedGradientColor: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Icon(
              IconData(task.icon, fontFamily: 'MaterialIcons'),
              color: color,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style:
                      TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 2.0.wp,
                ),
                Text(
                  '${task.todos?.length ?? 0} tasks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
