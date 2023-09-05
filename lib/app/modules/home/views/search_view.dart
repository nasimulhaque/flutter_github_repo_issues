import 'package:flutter/material.dart';
import 'package:flutter_issues/app/utils/app_logger.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../controllers/home_controller.dart';

class SearchView extends GetView<HomeController> {

  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TextFieldTags(
      textfieldTagsController: controller.tagsController,
      textSeparators: const [','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (controller.tagsController.getTags!.contains(tag)) {
          return 'You already entered that';
        }
        return null;
      },
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
        return ((context, sc, tags, onTagDelete) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 74, 137, 92),
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 74, 137, 92),
                    width: 1.0,
                  ),
                ),
                helperText: '',
                helperStyle: const TextStyle(
                  color: Color.fromARGB(255, 74, 137, 92),
                ),
                hintText: controller.tagsController.hasTags ? '' : "Search by Labels - Separated by comma(,)",
                errorText: error,
                prefixIconConstraints: BoxConstraints(maxWidth: width - 80),
                prefixIcon: SingleChildScrollView(
                  controller: sc,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                        children: tags.map((String tag) {
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              color: Color.fromARGB(255, 32, 125, 229),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    tag,
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                  onTap: () {
                                    AppLogger.instance.logger.d("$tag selected");
                                  },
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: Color.fromARGB(
                                        255, 233, 233, 233),
                                  ),
                                  onTap: () {
                                    onTagDelete(tag);
                                    String labels = controller.tagsController.getTags!.toString().replaceAll(", ", ",").replaceAll("[", "").replaceAll("]", "");
                                    controller.getIssues(labels: labels);
                                  },
                                )
                              ],
                            ),
                          );
                        }).toList()),
                  ),
                ),
              ),
              onChanged: onChanged,
              onSubmitted: (String text) {
                if (onSubmitted != null) {
                  onSubmitted(text);
                }
                String labels = controller.tagsController.getTags!.toString().replaceAll(", ", ",").replaceAll("[", "").replaceAll("]", "");
                AppLogger.instance.logger.d("Submitted text: $labels");
                controller.getIssues(labels: labels);
              },
            ),
          );
        });
      },
    );
  }
}
