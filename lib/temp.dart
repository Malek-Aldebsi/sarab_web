import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ShadowDemo(),
      ),
    );
  }
}

class ShadowDemo extends StatefulWidget {
  @override
  _ShadowDemoState createState() => _ShadowDemoState();
}

class _ShadowDemoState extends State<ShadowDemo> {
  var _image = AssetImage('images/labtob.png');

  var _opacity = 1.0;
  var _xOffset = 0.0;
  var _yOffset = 0.0;
  var _blurRadius = 0.0;
  var _spreadRadius = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            child: InkWell(
              onTap: () {
                print(_opacity);
                print(_xOffset);
                print(_yOffset);
                print(_blurRadius);
                print(_spreadRadius);
              },
              child: Image(
                image: _image,
                height: 500,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Column(
              children: <Widget>[
                Spacer(),
                Slider(
                    value: _opacity,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (newValue) {
                      {
                        setState(() => _opacity = newValue);
                      }
                    }),
                Slider(
                  value: _xOffset,
                  min: -100,
                  max: 100,
                  onChanged: (newValue) {
                    setState(() => _xOffset = newValue);
                  },
                ),
                Slider(
                  value: _yOffset,
                  min: -100,
                  max: 100,
                  onChanged: (newValue) {
                    setState(() => _yOffset = newValue);
                  },
                ),
                Slider(
                  value: _blurRadius,
                  min: 0,
                  max: 100,
                  onChanged: (newValue) {
                    print(newValue);
                    setState(() => _blurRadius = newValue);
                  },
                ),
                Slider(
                  value: _spreadRadius,
                  min: 0,
                  max: 100,
                  onChanged: (newValue) {
                    print(newValue);
                    setState(() => _spreadRadius = newValue);
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
