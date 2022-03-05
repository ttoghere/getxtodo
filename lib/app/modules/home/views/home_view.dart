import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxtodo/app/core/utils/extensions.dart';
import 'package:getxtodo/app/data/models/task.dart';
import 'package:getxtodo/app/modules/home/widgets/add_card.dart';
import 'package:getxtodo/app/modules/home/widgets/task_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                'My List',
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                TaskCard(
                  task: Task(
                    color: '#FF2B60E6',
                    icon: 0xe59c,
                    title: 'title',
                  ),
                ),
                AddCard(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
