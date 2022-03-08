import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/utils/extensions.dart';
import '/app/modules/home/controllers/home_controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
          ? Column(
              children: [
                Image.asset(
                  'assets/images/task.jpg',
                  fit: BoxFit.cover,
                  width: 65.0.wp,
                ),
                Text(
                  'Add Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0.sp,
                  ),
                )
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingTodos
                    .map(
                      (element) => Row(
                        children: [
                          SizedBox(
                            width: 20.0.sp,
                            height: 20.0.sp,
                          ),
                          Checkbox(
                            value: element["done"],
                            onChanged: (value) {
                              homeCtrl.doneTodo(
                                element["title"],
                              );
                            },
                            fillColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.grey),
                          ),
                          Text(
                            element["title"],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                    .toList(),
                if (homeCtrl.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
              ],
            ),
    );
  }
}
