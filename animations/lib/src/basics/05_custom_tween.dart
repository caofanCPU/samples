import 'package:flutter/material.dart';

class TypewriterTween extends Tween<String> {
  TypewriterTween({String begin = '', String end})
      : super(begin: begin, end: end);

  String lerp(double t) {
    var cutoff = (end.length * t).round();
    return end.substring(0, cutoff);
  }
}

class CustomTweenDemo extends StatefulWidget {
  static const String routeName = '/basics/custom_tweens';

  _CustomTweenDemoState createState() => _CustomTweenDemoState();
}

class _CustomTweenDemoState extends State<CustomTweenDemo>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 3);
  static const String message = loremIpsum;
  AnimationController controller;
  Animation<String> animation;

  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: _duration)
      ..addListener(() {
        // Marks the widget tree as dirty
        setState(() {});
      });
    animation = TypewriterTween(end: message).animate(controller);
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            child: Text(
              controller.status == AnimationStatus.completed
                  ? 'Delete Essay'
                  : 'Write Essay',
            ),
            textColor: Colors.white,
            onPressed: () {
              if (controller.status == AnimationStatus.completed) {
                controller.reverse();
              } else {
                controller.forward();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text('${animation.value}',
                      style:
                          TextStyle(fontSize: 16, fontFamily: 'SpecialElite')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String loremIpsum = '''
Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium
doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore
veritatis et quasi architecto beatae vitae dicta sunt, explicabo. Nemo enim
ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia
consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque
porro quisquam est, qui dolorem ipsum, quia dolor sit amet consectetur
adipisci[ng] velit, sed quia non-numquam [do] eius modi tempora inci[di]dunt, ut
labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam,
quis nostrum[d] exercitationem ullam corporis suscipit laboriosam, nisi ut
aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit, qui in
ea voluptate velit esse, quam nihil molestiae consequatur, vel illum, qui
dolorem eum fugiat, quo voluptas nulla pariatur?
''';
