import 'package:refilc/helpers/subject.dart';
import 'package:refilc/models/settings.dart';
import 'package:refilc/theme/colors/colors.dart';
import 'package:refilc_kreta_api/models/homework.dart';
import 'package:refilc/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class HomeworkTile extends StatelessWidget {
  const HomeworkTile(
    this.homework, {
    super.key,
    this.onTap,
    this.padding,
    this.censored = false,
  });

  final Homework homework;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final bool censored;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.only(left: 8.0, right: 12.0),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        leading: SizedBox(
          width: 44,
          height: 44,
          child: censored
              ? Container(
                  decoration: BoxDecoration(
                    color: AppColors.of(context).text.withValues(alpha: .55),
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Icon(
                    SubjectIcon.resolveVariant(
                        subject: homework.subject, context: context),
                    size: 28.0,
                    color: AppColors.of(context).text.withValues(alpha: .75),
                  ),
                ),
        ),
        title: censored
            ? Wrap(
                children: [
                  Container(
                    width: 160,
                    height: 15,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).text.withValues(alpha: .85),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              )
            : Text(
                homework.subject.renamedTo ?? homework.subject.name.capital(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: homework.subject.isRenamed &&
                            settingsProvider.renamedSubjectsItalics
                        ? FontStyle.italic
                        : null),
              ),
        subtitle: censored
            ? Wrap(
                children: [
                  Container(
                    width: 100,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).text.withValues(alpha: .45),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              )
            : Text(
                homework.content.escapeHtml().replaceAll('\n', ' '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
        trailing: censored
            ? Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: AppColors.of(context).text.withValues(alpha: .45),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              )
            : Icon(
                FeatherIcons.home,
                color: AppColors.of(context).text.withValues(alpha: .75),
              ),
        minLeadingWidth: 0,
      ),
    );
  }
}
