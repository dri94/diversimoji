import 'package:flutter/material.dart';
import 'package:diversimoji/diversimojiController.dart';
import 'package:diversimoji/diversimojiThemeData.dart';
import 'package:get/get.dart';

/// Renders a save button by default OR can be used as a [InkWell]
/// wrapper for the [child] widget.
///
/// Additonal callbacks may be triggered by passing a
/// Function to [onTap].
class DiversimojiSaveWidget extends StatelessWidget {
  /// Pass in your `theme` to customize the appearance of the default
  /// save button.
  final DiversimojiThemeData theme;

  /// Additonal callbacks to be triggered on tapping the widget
  /// after the save operation is executed.
  /// *******
  /// Example: \
  /// You may pass a function that triggers a snackbar saying "Saved!" on
  /// the screen.
  final Function? onTap;

  /// A widget to render as the child of a [InkWell].
  ///
  /// If [null], then a default save button is shown to the user.
  final Widget? child;

  /// Find an instance of the [DiversimojiController] to use
  ///
  /// Note: This expects the controller to be added to `Get`
  /// previously during runtime.
  final diversimojiController = Get.find<DiversimojiController>();

  final InteractiveInkFeatureFactory? splashFactory;

  final Color? splashColor;

  final double? radius;

  DiversimojiSaveWidget({
    Key? key,
    DiversimojiThemeData? theme,
    this.onTap,
    this.child,
    this.splashFactory,
    this.splashColor,
    this.radius,
  })  : theme = theme ?? DiversimojiThemeData.standard,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await diversimojiController.setDiversimoji();
        if (onTap != null) onTap!();
      },
      splashFactory: splashFactory,
      radius: radius,
      splashColor: splashColor,
      child: child == null
          ? Icon(
              Icons.save,
              color: theme.iconColor,
            )
          : child,
    );
  }
}
