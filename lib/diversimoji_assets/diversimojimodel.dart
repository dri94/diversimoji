import 'package:flutter/foundation.dart';

/// Maps attribute keys to the attribute value list
final Map<String, DiversimojiPropertyItem> diversimojiProperties = {
  "style": DiversimojiPropertyItem(title: "Style", property: DiversimojiStyle),
  "topType": DiversimojiPropertyItem(title: "Hair", property: TopType),
  "glassesType":
      DiversimojiPropertyItem(title: "Glasses", property: GlassesType),
  "necklacesType":
      DiversimojiPropertyItem(title: "Necklaces", property: NecklacesType),
  "earringsType":
      DiversimojiPropertyItem(title: "Earrings", property: EarringsType),
  "hairColor":
      DiversimojiPropertyItem(title: "Hair\nColor", property: HairColor),
  "facialHairType":
      DiversimojiPropertyItem(title: "Facial\nHair", property: FacialHairType),
  "facialHairColor": DiversimojiPropertyItem(
      title: "F-Hair\nColor", property: FacialHairColor),
  "clotheType": DiversimojiPropertyItem(title: "Outfit", property: ClotheType),
  "clotheColor":
      DiversimojiPropertyItem(title: "Outfit\nColor", property: ClotheColor),
  "eyeType": DiversimojiPropertyItem(title: "Eye", property: EyeType),
  "eyebrowType":
      DiversimojiPropertyItem(title: "Eyebrow", property: EyebrowType),
  "mouthType": DiversimojiPropertyItem(title: "Mouth", property: MouthType),
  "skinColor": DiversimojiPropertyItem(title: "Skin", property: SkinColor),
};

/// Models the metadata needed for rendering widgets in the UI
///
/// 'ExpandedDiversimojiCardItem' has been renamed to Attribute Item
class AttributeItem {
  String title;
  String? key;
  String? iconAsset;
  double? iconsize;
  AttributeItem(
      {this.iconsize, this.title = "Unnamed", this.key, this.iconAsset});
}

class DiversimojiPropertyItem extends ChangeNotifier {
  String title;
  int choice;
  List<String>? property;
  DiversimojiPropertyItem({
    this.title = "Unnamed",
    this.choice = 0,
    this.property,
  });
}

const String emptySVGIcon = '''
<svg xmlns="http://www.w3.org/2000/svg"  viewBox="-20 -20 80 80" width="80px" height="80px"><path fill="#dff0fe" stroke="#4788c7" stroke-miterlimit="10" d="M20,1C9.507,1,1,9.507,1,20s8.507,19,19,19s19-8.507,19-19 S30.493,1,20,1z M6,20c0-7.732,6.268-14,14-14c2.963,0,5.706,0.926,7.968,2.496L8.496,27.968C6.926,25.706,6,22.963,6,20z M20,34 c-2.963,0-5.706-0.926-7.968-2.496l19.472-19.472C33.074,14.294,34,17.037,34,20C34,27.732,27.732,34,20,34z"/></svg>
''';

const Map<String, int> defaultDiversimojiOptions = {
  'topType': 24,
  'glassesType': 0,
  'necklacesType': 0,
  'earringsType': 0,
  'hairColor': 1,
  'facialHairType': 0,
  'facialHairColor': 1,
  'clotheType': 4,
  'eyeType': 6,
  'eyebrowType': 10,
  'mouthType': 8,
  'skinColor': 3,
  'clotheColor': 8,
  'style': 0,
  'graphicType': 0
};

const List<String> DiversimojiStyle = [
  'Transparent',
  'Circle',
];

const List<String> TopType = [
  'Bald',
  'Eyepatch',
  'Hijab',
  'Turban',
  'Hat',
  'I\'m not bald',
  'Flat',
  'from School',
  'Short n waved',
  'Short n curly',
  'The caesar',
  'Another caeser',
  'Short w/ dreads',
  'Short w/ lots of dreads',
  'Bob cut',
  'Bun',
  'Fro',
  'Its not short',
  'Long (Female)',
  'Curvy',
  'Shaggy',
  'Short w/ frizzle',
  'LongHairStraight',
  'LongHairStraight2',
  'LongHairStraightStrand',
  'Curly (Female)',
  'Long w/ dreads',
  'Frida',
  'Fro w/ band',
  'Long w/ shaved sides',
  'Mia Wallace',
  'WinterHat1',
  'WinterHat2',
  'Santa Hat',
  'Santa Hat w/ ears',
  'hair1',
  'hair2',
  'hair3',
  'hair4',
  'hair5',
  'hair6',
  'hair7',
  'hair8',
  'hair9',
  'hair10',
  'hair11',
  'hair12',

];

const List<String> GlassesType = [
  'Nothing',
  'PrescriptionGlasses',
  'Another pair of prescriptions',
  'Round',
  'Sunglasses',
  'Wayfarers',
  'Kurt',
];

const List<String> NecklacesType = [
  'Nothing',
  'Gold Chain',
];

const List<String> EarringsType = [
  'Nothing',
  'Gold Studs',
  'earring1'
];
const List<String> HairColor = [
  'Auburn',
  'Black',
  'Brown',
  'Blonde',
  'BlondeGolden',
  'BrownDark',
  'PastelPink',
  'Platinum',
  'Red',
  'SilverGray',
];

//This is the property I skipped on purpose
const List<String> HatColor = [
  'Black',
  'Blue01',
  'Blue02',
  'Blue03',
  'Gray01',
  'Gray02',
  'Heather',
  'PastelBlue',
  'PastelGreen',
  'PastelOrange',
  'PastelRed',
  'PastelYellow',
  'Pink',
  'Red',
  'White',
];

const List<String> FacialHairType = [
  'Nothing',
  'Full Beard',
  'Beard, Light',
  'Moustache, Fancy',
  'That 80\'s moustache',
];

const List<String> FacialHairColor = [
  'Auburn',
  'Black',
  'Blonde',
  'BlondeGolden',
  'Brown',
  'BrownDark',
  'Platinum',
  'Red',
];

const List<String> ClotheType = [
  'Crew Neck Tee',
  'GraphicShirt',
  'Scoop-neck Tee',
  'Hoodie',
  'CollarSweater',
  'Overall',
  'Blazer + T-Shirt',
  'BlazerSweater',
  'ShirtVNeck',
  'cloth1',
  'cloth2',
  'cloth3',
  'cloth4',
  'cloth5',
  'cloth6',
  'cloth7',
  'cloth8',
  'cloth9',
  'cloth10',
];

const List<String> ClotheColor = [
  'Blue01',
  'Blue02',
  'PastelYellow',
  'PastelGreen',
  'Gray02',
  'Black',
  'Blue03',
  'Gray01',
  'Heather',
  'PastelBlue',
  'PastelOrange',
  'PastelRed',
  'Pink',
  'Red',
  'White',
];

//Not implemented
const List<String> GraphicType = [
  'Cumbia',
  'Hola',
  'Bat',
  'Deer',
  'Diamond',
  'Pizza',
  'Resist',
  'Selena',
  'Bear',
  'SkullOutline',
  'Skull',
];

const List<String> EyeType = [
  'Default',
  'Happy',
  'Squint',
  'Close',
  'Cry',
  'Dizzy',
  'EyeRoll',
  'Hearts',
  'Side',
  'Surprised',
  'Wink',
  'WinkWacky',
  'eye1',
  'eye2',
  'eye3'
];

const List<String> EyebrowType = [
  'Default',
  'FlatNatural',
  'Angry',
  'AngryNatural',
  'DefaultNatural',
  'RaisedExcited',
  'RaisedExcitedNatural',
  'SadConcerned',
  'SadConcernedNatural',
  'UnibrowNatural',
  'UpDown',
  'UpDownNatural',
];

const List<String> MouthType = [
  'Concerned',
  'Default',
  'Sad',
  'Disbelief',
  'Eating',
  'Grimace',
  'ScreamOpen',
  'Serious',
  'Smile',
  'Tongue',
  'Twinkle',
  'Vomit',
  'mouth1',
  'mouth2'
];

const List<String> SkinColor = [
  'Ivory',
  'Porcelain',
  'WarmIvory',
  'Sand',
  'RoseBeige',
  'Limestone',
  'Beige',
  'Sienna',
  'Honey',
  'Band',
  'Almond',
  'Chestnut',
  'Bronze',
  'Umber',
  'Golden',
  'Espresso',
  'Ebony',
];
