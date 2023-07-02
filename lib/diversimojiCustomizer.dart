import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:diversimoji/defaults.dart';
import 'package:diversimoji/diversimojiSaveWidget.dart';
import 'package:diversimoji/diversimojiThemeData.dart';
import 'diversimoji_assets/diversimojimodel.dart';
import 'package:get/get.dart';
import 'diversimojiController.dart';

/// This widget provides the user with a UI for customizing their Diversimoji
///
///*****
///Note: \
/// It is advised that a [DiversimojiCircleAvatar] also be present in the same page.
/// to show the user a preview of the changes being made.
class DiversimojiCustomizer extends StatefulWidget {
  /// Creates a widget UI to customize the Diversimoji
  ///
  /// You may provide a [DiversimojiThemeData] instance to adjust the appearance of this
  /// widget to your app's theme.
  ///
  /// Accepts optional [scaffoldHeight] and [scaffoldWidth] attributes
  /// to override the default layout.
  ///
  ///*****
  ///Note: \
  /// It is advised that a [DiversimojiCircleAvatar] also be present in the same page.
  /// to show the user a preview of the changes being made.
  DiversimojiCustomizer({
    Key? key,
    this.scaffoldHeight,
    this.scaffoldWidth,
    DiversimojiThemeData? theme,
    List<String>? attributeTitles,
    List<String>? attributeIcons,
    this.autosave = true,
  })  : assert(
          attributeTitles == null || attributeTitles.length == attributesCount,
          "List of Attribute Titles must be of length $attributesCount.\n"
          " You need to provide titles for all attributes",
        ),
        assert(
          attributeIcons == null || attributeIcons.length == attributesCount,
          "List of Attribute Icon paths must be of length $attributesCount.\n"
          " You need to provide icon paths for all attributes",
        ),
        this.theme = theme ?? DiversimojiThemeData.standard,
        this.attributeTitles = attributeTitles ?? defaultAttributeTitles,
        this.attributeIcons = attributeIcons ?? defaultAttributeIcons,
        super(key: key);

  final double? scaffoldHeight;
  final double? scaffoldWidth;

  /// Configuration for the overall visual theme for this widget
  /// and the components within it.
  final DiversimojiThemeData theme;

  /// List of titles that are rendered at the top of the widget, indicating
  /// which attribute the user is customizing.
  ///
  /// Overrides the default titles specified in [defaultAttributeTitles]
  ///
  /// Length of [attributeTitles] must be **11**
  final List<String> attributeTitles;

  /// List of icons that are rendered in the bottom row, indicating
  /// the attributes available to modify.
  ///
  /// Overrides the default icons specified in [defaultAttributeIcons]
  ///
  /// Length of [attributeIcons] must be **11**
  ///
  /// Ensure that the path to the icons is valid and that the resources
  /// are included  as an asset in *pubspec.yaml*.
  ///
  /// **Only SVG files are supported as of now.**
  final List<String> attributeIcons;

  /// Will save the selection automatically everytime the user selects
  /// something when set to `true` .
  ///
  /// If set to `false` you may want to implement a [DiversimojiSaveWidget]
  /// in your app to let users save their selection manually.
  final bool autosave;

  static const int attributesCount = 13;

  @override
  _DiversimojiCustomizerState createState() => _DiversimojiCustomizerState();
}

class _DiversimojiCustomizerState extends State<DiversimojiCustomizer>
    with SingleTickerProviderStateMixin {
  late DiversimojiController diversimojiController;
  late TabController tabController;
  final attributesCount = 13;
  var heightFactor = 0.4, widthFactor = 0.95;

  @override
  void initState() {
    super.initState();

    var _diversimojiController;
    Get.put(DiversimojiController());
    _diversimojiController = Get.find<DiversimojiController>();

    setState(() {
      tabController = TabController(length: attributesCount, vsync: this);
      diversimojiController = _diversimojiController;
    });

    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // This ensures that unsaved edits are reverted
    diversimojiController.restoreState();
    super.dispose();
  }

  void onTapOption(int index, int? i, AttributeItem attribute) {
    if (index != i) {
      setState(() {
        diversimojiController.selectedOptions[attribute.key] = index;
      });
      diversimojiController.updatePreview();
      if (widget.autosave) diversimojiController.setDiversimoji();
    }
  }

  void onArrowTap(bool isLeft) {
    int _currentIndex = tabController.index;
    if (isLeft)
      tabController
          .animateTo(_currentIndex > 0 ? _currentIndex - 1 : _currentIndex);
    else
      tabController.animateTo(_currentIndex < attributesCount - 1
          ? _currentIndex + 1
          : _currentIndex);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: widget.scaffoldHeight ?? (size.height * heightFactor),
      width: widget.scaffoldWidth ?? size.width,
      child: body(
        attributes: List<AttributeItem>.generate(
            attributesCount,
            (index) => AttributeItem(
                iconAsset: widget.attributeIcons[index],
                title: widget.attributeTitles[index],
                key: attributeKeys[index]),
            growable: false),
      ),
    );
  }

  Container bottomNavBar(List<Widget> navbarWidgets) {
    return Container(
      color: widget.theme.primaryBgColor,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        labelPadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        indicatorColor: widget.theme.selectedIconColor,
        indicatorPadding: EdgeInsets.all(2),
        tabs: navbarWidgets,
      ),
    );
  }

  AppBar appbar(List<AttributeItem> attributes) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: widget.theme.primaryBgColor,
      automaticallyImplyLeading: false,
      title: Text(
        attributes[tabController.index].title,
        style: widget.theme.labelTextStyle,
        textAlign: TextAlign.center,
      ),
      leading: arrowButton(true),
      actions: [
        arrowButton(false),
      ],
    );
  }

  Widget arrowButton(bool isLeft) {
    return Visibility(
      visible: isLeft
          ? tabController.index > 0
          : tabController.index < attributesCount - 1,
      child: IconButton(
        // splashRadius: 20,
        icon: Icon(
          isLeft
              ? Icons.arrow_back_ios_new_rounded
              : Icons.arrow_forward_ios_rounded,
          color: widget.theme.iconColor,
        ),
        onPressed: () => onArrowTap(isLeft),
      ),
    );
  }

  /// Widget that renders an expanded layout for customization
  /// Accepts a [cardTitle] and a [attributes].
  ///
  /// [attribute] is an object with the fields attributeName and attributeKey
  Widget body({required List<AttributeItem> attributes}) {
    var size = MediaQuery.of(context).size;

    var attributeGrids = <Widget>[];
    var navbarWidgets = <Widget>[];

    for (var attributeIndex = 0;
        attributeIndex < attributes.length;
        attributeIndex++) {
      var attribute = attributes[attributeIndex];
      if (!diversimojiController.selectedOptions.containsKey(attribute.key)) {
        diversimojiController.selectedOptions[attribute.key] = 0;
      }

      /// Number of options available for said [attribute]
      /// Eg: "Hairstyle" attribue has 38 options
      var attributeListLength =
          diversimojiProperties[attribute.key!]!.property!.length;

      /// Number of tiles per horizontal row,
      int gridCrossAxisCount;

      /// Set the number of tiles per horizontal row,
      /// depending on the [attributeListLength]
      if (attributeListLength < 12)
        gridCrossAxisCount = 3;
      else if (attributeListLength < 9)
        gridCrossAxisCount = 2;
      else
        gridCrossAxisCount = 4;

      int? i = diversimojiController.selectedOptions[attribute.key];

      /// Build the main Tile Grid with all the options from the attribute
      var _tileGrid = GridView.builder(
        physics: widget.theme.scrollPhysics,
        itemCount: attributeListLength,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCrossAxisCount,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (BuildContext context, int index) => InkWell(
          onTap: () => onTapOption(index, i, attribute),
          child: Container(
            decoration: index == i
                ? widget.theme.selectedTileDecoration
                : widget.theme.unselectedTileDecoration,
            margin: widget.theme.tileMargin,
            padding: widget.theme.tilePadding,
            child: SvgPicture.string(
           //   fit: BoxFit.contain,
              diversimojiController.getComponentSVG(attribute.key, index),
             // alignment: Alignment.center,
               height: 20,

              semanticsLabel: 'Your Diversimoji',
              placeholderBuilder: (context) => Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          ),
        ),
      );

      /// Builds the icon for the attribute to be placed in the bottom row
      var bottomNavWidget = Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
          child: SvgPicture.asset(
            attribute.iconAsset!,
            package: 'diversimoji',
            height: attribute.iconsize ??
                (widget.scaffoldHeight != null
                    ? widget.scaffoldHeight! / heightFactor * 0.03
                    : size.height * 0.03),
            colorFilter: ColorFilter.mode(
                attributeIndex == tabController.index
                    ? widget.theme.selectedIconColor
                    : widget.theme.unselectedIconColor,
                BlendMode.srcIn),
            semanticsLabel: attribute.title,
          ));

      /// Add all the initialized widgets to the state
      attributeGrids.add(_tileGrid);
      navbarWidgets.add(bottomNavWidget);
    }

    return Container(
      decoration: widget.theme.boxDecoration,
      clipBehavior: Clip.hardEdge,
      child: DefaultTabController(
        length: attributeGrids.length,
        child: Scaffold(
          key: const ValueKey('FMojiCustomizer'),
          backgroundColor: widget.theme.secondaryBgColor,
          appBar: appbar(attributes),
          body: TabBarView(
            physics: widget.theme.scrollPhysics,
            controller: tabController,
            children: attributeGrids,
          ),
          bottomNavigationBar: bottomNavBar(navbarWidgets),
        ),
      ),
    );
  }
}
