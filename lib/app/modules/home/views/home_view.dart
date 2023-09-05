import 'package:flutter/material.dart';
import 'package:flutter_issues/app/modules/home/views/issue_item_view.dart';
import 'package:flutter_issues/app/modules/home/views/search_view.dart';
import 'package:get/get.dart';
import '../../../data/issue_response_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Text('Flutter Issues', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Obx(() {
          return Column(
            children: [
              const SearchView(),
              Flexible(
                child: ListView.separated(
                    controller: controller.scrollController,
                    itemBuilder: (_, index) {
                      Issue issue = controller.issues[index];
                      return IssueItemView(issue: issue);
                    },
                    separatorBuilder: (_, __) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(),
                    ),
                    itemCount: controller.issues.length
                ),
              ),
              if (!controller.isIssueLoading() && controller.issues.isEmpty) const SizedBox(
                height: 400,
                child: Text(
                    "No Issue Found!",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0
                    )
                ),
              ),
              if (controller.isIssueLoading())  const CircularProgressIndicator()
            ],
          );
        }),
      ),
    );
  }
}
