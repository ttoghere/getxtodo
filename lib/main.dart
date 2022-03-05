import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getxtodo/app/data/services/services.dart';
import 'package:getxtodo/app/modules/home/bindings/home_binding.dart';
import 'app/routes/app_pages.dart';

void main() async {
  //Fast, extra-light and synchronous key-value pair in memory
  //that backs up data to disk on every transaction.
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    ),
  );
}
