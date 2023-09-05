import 'package:flutter_issues/app/utils/app_logger.dart';
import 'package:flutter_issues/app/utils/constants.dart';
import 'package:get/get.dart';

import '../../../data/issue_response_model.dart';

class HomeProvider extends GetConnect {

  getIssues({String? labels, int page = 1}) async {
    try {
      Response response = await get(url,
          contentType: "application/json",
          query: {
            "labels": labels,
            "per_page": perPage.toString(),
            "page": page.toString()
          }
      );

      if(response.hasError) {
        return;
      }

      AppLogger.instance.logger.d(response.body);
      return issueResponseModelFromJson(response.body);
    } catch (error) {
      AppLogger.instance.logger.e(error);
    }
  }
}
