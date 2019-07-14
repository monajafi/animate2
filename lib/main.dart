import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
                ..addStatusListener((status){
                  if(status == AnimationStatus.completed){
                    controller.reverse();
                  }else if(status == AnimationStatus.dismissed){
                    controller.forward();
                  }
                })
                ..addStatusListener((state) => print("$state")
                );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(
      animation: animation,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
   final Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: animation.value,
        height: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
