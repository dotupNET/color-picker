import 'package:color_picker/lang/lang.dart';
import 'package:color_picker/screens/color_info/color_info.dart';
import 'package:color_picker/widgets/opacity_slider.dart';
import 'package:color_picker/widgets/scroll_initial.dart';
import 'package:flutter/material.dart';

import 'value_home.dart';

class RGBValuePicker extends StatefulWidget {
  RGBValuePicker({Key key}) : super(key: key);

  @override
  _RGBValuePickerState createState() => _RGBValuePickerState();
}

class _RGBValuePickerState extends State<RGBValuePicker>
    with AutomaticKeepAliveClientMixin {
  double opacity = 1;
  int red, green, blue;

  @override
  void initState() {
    super.initState();
    red = green = blue = 0;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Language lang = Language.of(context);
    return ScrollInitial(
      initialHeight: initialHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Spacer(),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Field(
                value: red.toDouble(),
                onChanged: (value) => setState(() => red = value.toInt()),
                color: Colors.redAccent,
                label: lang.red,
              ),
              Field(
                value: green.toDouble(),
                onChanged: (value) => setState(() => green = value.toInt()),
                color: Colors.green,
                label: lang.green,
              ),
              Field(
                value: blue.toDouble(),
                onChanged: (value) => setState(() => blue = value.toInt()),
                color: Colors.blue,
                label: lang.blue,
              ),
            ],
          ),
          MediaQuery.of(context).orientation == Orientation.portrait
              ? Spacer()
              : Container(),
          Divider(),
          ColorInfo(
            color: Color.fromARGB(
              255,
              red,
              green,
              blue,
            ).withOpacity(opacity),
            slider: OpacitySlider(
              onChanged: (value) => setState(() => opacity = value),
              value: opacity,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Field extends StatelessWidget {
  const Field({
    Key key,
    @required this.color,
    @required this.label,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  final Color color;
  final String label;
  final double value;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[50],
      child: Row(
        children: <Widget>[
          Expanded(
            child: Slider(
              value: value,
              onChanged: onChanged,
              max: 255,
              min: 0,
              label: label,
              activeColor: color,
              inactiveColor: color.withOpacity(0.2),
            ),
          ),
          Text(
            value.toInt().toString(),
            style: DefaultTextStyle.of(context).style,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
