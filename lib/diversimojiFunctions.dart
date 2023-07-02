import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'diversimoji_assets/clothes/clothes.dart';
import 'diversimoji_assets/face/eyebrow/eyebrow.dart';
import 'diversimoji_assets/face/eyes/eyes.dart';
import 'diversimoji_assets/face/mouth/mouth.dart';
import 'diversimoji_assets/face/nose/nose.dart';
import 'diversimoji_assets/diversimojimodel.dart';
import 'diversimoji_assets/skin.dart';
import 'diversimoji_assets/style.dart';
import 'diversimoji_assets/top/accessories/glasses.dart';
import 'diversimoji_assets/top/accessories/necklaces.dart';
import 'diversimoji_assets/top/accessories/earrings.dart';
import 'diversimoji_assets/top/facialHair/facialHair.dart';
import 'diversimoji_assets/top/hairStyles/hairStyle.dart';

class DiversimojiFunctions {
  late Map<String, int> _decodedList;
  DiversimojiFunctions() {
    _decodedList = {
      'topType': 4,
      'glassesType': 0,
      'necklacesType': 0,
      'earringsType': 0,
      'hairColor': 1,
      'facialHairType': 0,
      'facialHairColor': 1,
      'clotheType': 4,
      'eyeType': 0,
      'eyebrowType': 0,
      'mouthType': 1,
      'skinColor': 0,
      'clotheColor': 1,
      'style': 0,
      'graphicType': 0
    };
  }

  String _getDiversimojiProperty(String type) {
    return diversimojiProperties[type]!
        .property!
        .elementAt(_decodedList[type]!);
  }

  /// Erase diversimoji String and Map from local storage
  Future<List<bool>> clearDiversimoji() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return Future.wait([
      pref.remove('diversimojiSelectedOptions'),
      pref.remove('diversimoji'),
    ]);
  }

  /// Decode your string containing the attributes to a SVG and render it
  /// by enclosing this string with a SvgPicture.string()
  String decodeDiversimojifromString(String encodedData) {
    if (encodedData != '') _decodedList = Map.from(jsonDecode(encodedData));

    String _diversimojiStyle =
        diversimojiStyle[_getDiversimojiProperty('style')]!;
    String _clothe = Clothes.generateClothes(
        clotheType: _getDiversimojiProperty('clotheType'),
        clColor: _getDiversimojiProperty('clotheColor'))!;
    String _facialhair = FacialHair.generateFacialHair(
        facialHairType: _getDiversimojiProperty('facialHairType'),
        fhColor: _getDiversimojiProperty('facialHairColor'))!;
    String _mouth = mouth['${_getDiversimojiProperty('mouthType')}'];
    String _nose = nose['Default'];
    String _eyes = eyes['${_getDiversimojiProperty('eyeType')}'];
    String _eyebrows = eyebrow['${_getDiversimojiProperty('eyebrowType')}'];
    String _glasses = glasses[_getDiversimojiProperty('glassesType')];
    String _necklaces = necklaces[_getDiversimojiProperty('necklacesType')];
    String _earrings = earrings[_getDiversimojiProperty('earringsType')];
    String _hair = HairStyle.generateHairStyle(
        hairType: _getDiversimojiProperty('topType'),
        hColor: _getDiversimojiProperty('hairColor'))!;
    String _skin = skin[_getDiversimojiProperty('skinColor')];
    String _completeSVG = '''
<svg width="264px" height="280px" viewBox="0 0 264 280" version="1.1"
xmlns="http://www.w3.org/2000/svg"
xmlns:xlink="http://www.w3.org/1999/xlink">
<desc>Diversimoji on pub.dev</desc>
<defs>
<circle id="path-1" cx="120" cy="120" r="120"></circle>
<path d="M12,160 C12,226.27417 65.72583,280 132,280 C198.27417,280 252,226.27417 252,160 L264,160 L264,-1.42108547e-14 L-3.19744231e-14,-1.42108547e-14 L-3.19744231e-14,160 L12,160 Z" id="path-3"></path>
<path d="M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 L44,56 L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z" id="path-5"></path>
</defs>
<g id="Diversimoji" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
<g transform="translate(-825.000000, -1100.000000)" id="Diversimoji/Circle">
<g transform="translate(825.000000, 1100.000000)">''' +
        _diversimojiStyle +
        '''
<g id="Mask"></g>
<g id="Diversimoji" stroke-width="1" fill-rule="evenodd">
<g id="Body" transform="translate(32.000000, 36.000000)">

<mask id="mask-6" fill="white">
<use xlink:href="#path-5"></use>
</mask>
<use fill="#D0C6AC" xlink:href="#path-5"></use>''' +
        _skin +
        '''<path d="M156,79 L156,102 C156,132.927946 130.927946,158 100,158 C69.072054,158 44,132.927946 44,102 L44,79 L44,94 C44,124.927946 69.072054,150 100,150 C130.927946,150 156,124.927946 156,94 L156,79 Z" id="Neck-Shadow" opacity="0.100000001" fill="#000000" mask="url(#mask-6)"></path></g>''' +
        _clothe +
        '''<g id="Face" transform="translate(76.000000, 82.000000)" fill="#000000">''' +
        _mouth +
        _facialhair +
        _nose +
        _eyes +
        _eyebrows +
        _glasses +
        '''</g>''' +
        _earrings +
        _hair +
        _necklaces +
        '''</g></g></g></g></svg>''';
    return _completeSVG;
  }

  /// Retrieve the local user's diversimoji attributes from local storage
  /// and encode them to a Map of attributes
  ///
  /// returns a Future, you have to await on function call
  Future<Map<String, dynamic>> encodeMySVGtoMap() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? _diversimojiOptions = pref.getString('diversimojiSelectedOptions');
    if (_diversimojiOptions == null || _diversimojiOptions == '') {
      Map<String, int> _diversimojiOptionsMap =
          Map.from(defaultDiversimojiOptions);
      await pref.setString(
          'diversimojiSelectedOptions', jsonEncode(_diversimojiOptionsMap));

      return _diversimojiOptionsMap;
    }

    return Map.from(jsonDecode(_diversimojiOptions));
  }

  /// Retrieve the local user's diversimoji attributes from local storage
  /// and encode them to a String containing a Map of attributes
  ///
  /// returns a Future, you have to await on function call
  Future<String> encodeMySVGtoString() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? _diversimojiOptions = pref.getString('diversimojiSelectedOptions');
    if (_diversimojiOptions == null || _diversimojiOptions == '') {
      Map<String, int> _diversimojiOptionsMap =
          Map.from(defaultDiversimojiOptions);
      await pref.setString(
          'diversimojiSelectedOptions', jsonEncode(_diversimojiOptionsMap));
      return jsonEncode(_diversimojiOptionsMap);
    }
    return _diversimojiOptions;
  }
}
