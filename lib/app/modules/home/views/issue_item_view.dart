import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/issue_response_model.dart';

class IssueItemView extends GetView {

  final Issue issue;

  const IssueItemView({Key? key, required this.issue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                  child: Text(
                      issue.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                      )
                  )
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      DateFormat('MM/dd/yyyy').format(issue.createdAt),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold
                      )
                  ),
                  const SizedBox(height: 4.0),
                  Text(issue.user.login)
                ],
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            issue.body ?? "N\\A",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            height: 30,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: HexColor(issue.labels[index].color),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 0.25,
                    ),
                  ],
                ),
                child: Center(
                    child: Text(
                        issue.labels[index].name,
                        style: const TextStyle(color: Colors.white)
                    )
                ),
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 8.0),
              itemCount: issue.labels.length
            ),
          )
        ],
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}