import 'package:flutter/material.dart';

class SwitchPanel extends StatelessWidget {
  const SwitchPanel({
    super.key,
    required this.isSwitchOn,
    required this.switchCallback,
    required this.title,
    this.subTitle,
  });

  final bool isSwitchOn;
  final Function(bool) switchCallback;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: isSwitchOn,
      onChanged: (isChecked) {
        switchCallback(isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: getSubtitle(context),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }

  Text? getSubtitle(BuildContext context) {
    if (subTitle != null) {
      return Text(
        subTitle!,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      );
    } else {
      return null;
    }
  }
}
