import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Scroller(screenHeight: screenHeight, screenWidth: screenWidth),
    );
  }
}

class Scroller extends StatefulWidget {
  double screenWidth;
  double screenHeight;

  Scroller({Key? key, required this.screenHeight, required this.screenWidth})
      : super(key: key);

  @override
  State<Scroller> createState() => _ScrollerState();
}

class _ScrollerState extends State<Scroller> {
  ScrollPhysics stop = const NeverScrollableScrollPhysics();
  ScrollPhysics move = const ScrollPhysics();

  List<ScrollController> subScroller = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController()
  ];

  List<double> subScrollerRead = [0, 0, 0, 0];
  List<double> _subScrollerRead = [0, 0, 0, 0];

  // 1516.800048828125
  // 758.4000244140625
  // 758.4000244140625
  // 2716.800048828125

  int scrollTurn = 0;

  late Image image1;
  late Image image2;
  late Image image3;

  double total = 0;
  double _total = 0;

  void reset() {
    int resetDist = 40;
    double lock = total - _total >= 0
        ? subScroller[0].position.maxScrollExtent +
            subScroller.last.position.maxScrollExtent / (subScroller.length - 2)
        : subScroller[0].position.maxScrollExtent;

    for (int i = 1; i < subScroller.length - 1; i++) {
      if (total > lock - resetDist && total < lock + resetDist) {
        subScroller.last.jumpTo((total - _total >= 0 ? i : i - 1) *
            subScroller.last.position.maxScrollExtent /
            (subScroller.length - 2));
        break;
      } else {
        lock += subScroller.last.position.maxScrollExtent /
                (subScroller.length - 2) +
            subScroller[i].position.maxScrollExtent;
      }
    }
  }

  void scrollLogic() {
    reset();

    double minimum = 0;
    double maximum = subScroller[0].position.maxScrollExtent;

    for (int i = 0; i <= subScroller.length; i++) {
      if (total >= minimum && total < maximum && total - _total >= 0) {
        setState(() {
          scrollTurn = i % 2 == 0 ? i ~/ 2 : subScroller.length - 1;
        });
        break;
      } else if (total > minimum && total <= maximum && total - _total < 0) {
        setState(() {
          scrollTurn = i % 2 == 0 ? i ~/ 2 : subScroller.length - 1;
        });
        break;
      } else {
        minimum = maximum;
        maximum += i % 2 == 0
            ? subScroller.last.position.maxScrollExtent /
                (subScroller.length - 2)
            : subScroller[(i - 1) ~/ 2].position.maxScrollExtent;
      }
    }
  }

  void scrollsRead() {
    for (int i = 0; i < subScroller.length; i++) {
      subScroller[i].addListener(() {
        setState(() {
          _subScrollerRead[i] = subScrollerRead[i];
          subScrollerRead[i] = subScroller[i].positions.last.pixels;
          _total = total;
          total += subScrollerRead[i] - _subScrollerRead[i];
        });
        scrollLogic();
      });
    }
  }

  @override
  void initState() {
    scrollsRead();
    super.initState();

    image1 = Image.asset("images/fstPage.jpg");
    image2 = Image.asset("images/scdPage.jpg");
    image3 = Image.asset("images/thirdPage.jpg");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
    precacheImage(image3.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            cacheExtent: 500000,
            controller: subScroller.last,
            physics: scrollTurn == subScroller.length - 1
                ? const ScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            children: [
              Container(
                width: widget.screenWidth,
                height: widget.screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image1.image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        controller: subScroller[0],
                        physics: scrollTurn == 0
                            ? const ScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        children: [
                          Container(
                            height: widget.screenHeight,
                          ),
                          Container(
                            height: widget.screenHeight,
                            child: const Center(
                              child: Text(
                                "An Easier Life For\nThe Blind",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 120,
                                    fontFamily: 'test1',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: widget.screenWidth,
                height: widget.screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image2.image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        controller: subScroller[1],
                        physics: scrollTurn == 1
                            ? const ScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        children: [
                          Container(
                            height: widget.screenHeight,
                          ),
                          Container(
                            height: widget.screenHeight,
                            child: const Center(
                              child: Text(
                                "Reading Anywhere,\nAnytime",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 120,
                                    fontFamily: 'test1',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: widget.screenWidth,
                height: widget.screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image3.image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    ListView(
                      controller: subScroller[2],
                      physics: scrollTurn == 2
                          ? const ScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          height: widget.screenHeight,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Image(
                                image: AssetImage('images/screen.png'),
                                height: 400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 50.0, left: 220.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: const [
                                  Image(
                                    image: AssetImage('images/iphone.png'),
                                    height: 200,
                                  ),
                                ],
                              ),
                              Column(
                                children: const [
                                  SizedBox(height: 300),
                                  Image(
                                    image: AssetImage('images/labtob.png'),
                                    height: 200,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Image(
                          image: AssetImage('images/boook.png'),
                          height: 400,
                        ),
                      ],
                    ),
                    Container(
                      height: widget.screenHeight,
                      child: const Center(
                        child: Text(
                          "Anything",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 120,
                              fontFamily: 'test1',
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: Color(0xffBDBCBF).withOpacity(0.3),
                          ),
                          child: const Center(
                              child: Image(
                            image: AssetImage('images/logo.png'),
                            width: 110,
                          )))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Button(
                      onPress: () {},
                      text: "Light",
                    ),
                    Button(
                      onPress: () {},
                      text: "Air",
                    ),
                    Button(
                      onPress: () {},
                      text: "Nebula",
                    ),
                    Button(
                      onPress: () {},
                      text: "Developer",
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xffBDBCBF).withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.account_circle_outlined,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xffBDBCBF).withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.translate_rounded,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  Function() onPress;
  String text;

  Button({Key? key, required this.onPress, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xffBDBCBF).withOpacity(0.5),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
