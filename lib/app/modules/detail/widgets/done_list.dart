import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodo/app/core/utils/extensions.dart';
import 'package:getxtodo/app/core/values/colors.dart';
import 'package:getxtodo/app/modules/home/controllers/home_controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0.wp,
              ),
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Text(
                    'Completed: ${homeCtrl.doneTodos.length}',
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                  ...homeCtrl.doneTodos
                      .map(
                        (element) => Dismissible(
                          key: ObjectKey(element),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => homeCtrl.deleteDoneTodo(element),
                          background: Container(
                            color: Colors.red[900],
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 8.0.wp,
                              ),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20.0.wp,
                                height: 10.0.wp,
                                child: Icon(
                                  Icons.done,
                                  color: blue,
                                ),
                              ),
                              Text(
                                element["title"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            )
          : Container(),
    );
  }
}
