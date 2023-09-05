import 'package:flutter/material.dart';
import 'package:flutter_issues/app/modules/home/providers/home_provider.dart';
import 'package:flutter_issues/app/utils/app_logger.dart';
import 'package:flutter_issues/app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../data/issue_response_model.dart';

class HomeController extends GetxController {

  late TextfieldTagsController tagsController;
  late ScrollController scrollController;
  RxBool isIssueLoading = false.obs;
  String? labels;
  int page = 1;
  List<Issue> issues = <Issue>[].obs;

  @override
  void onInit() async {
    getIssues();
    tagsController = TextfieldTagsController();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset >= scrollController.position.maxScrollExtent
            && !scrollController.position.outOfRange
            && !isIssueLoading()
        ) {
          getIssues(loadMore: true);
        }
      });
    super.onInit();
  }

  getIssues({String? labels, bool loadMore = false}) async {
    try {
      AppLogger.instance.logger.d("label: $labels");
      isIssueLoading.value = true;
      if (loadMore) {
        labels = this.labels;
        page = (issues.length / perPage).round() + 1;
      } else {
        this.labels = labels;
        page = 1;
        issues.clear();
      }
      List<Issue>? response = await HomeProvider().getIssues(labels: labels, page: page);
      isIssueLoading.value = false;
      if (response == null) {
        Get.snackbar(
            "Something went wrong",
            "Please try again later",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.close, color: Colors.white),
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM
        );
        return;
      }
      if (response.isEmpty) return;

      // AppLogger.instance.logger.d(response.toString());
      issues.addAll(response);
    } catch(error) {
      isIssueLoading.value = false;
      AppLogger.instance.logger.d(error);
    }
  }
}
