import 'package:pranavnanaware/services/Apibrain.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class Carousel extends StatefulWidget {
  final List<Path> pathList;
  const Carousel({Key key, this.pathList}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Carousel();
  }
}

class _Carousel extends State<Carousel> {
  @override
  void didUpdateWidget(Carousel oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.pathList.length - 1,
      itemBuilder: (context, index) {
        if (widget.pathList.length == 0) {
          return Center(child: CircularProgressIndicator());
        }
        return Title(path: widget.pathList.elementAt(index));
      },
    );
  }
}

class Title extends StatefulWidget {
  final Path path;
  const Title({Key key, this.path}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Title();
  }
}

class _Title extends State<Title> {
  ItemScrollController itemScrollController;
  PageController pageController;

  @override
  void initState() {
    super.initState();

    itemScrollController = ItemScrollController();
    pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  void didUpdateWidget(Title oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: kbackgroundColor,
      padding: EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.path.title,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ktitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.path.subPaths.length} Sub Paths",
                      style: kSmallTextStyle.copyWith(fontSize: 10),
                    ),
                  ],
                ),
                ButtonTheme(
                  height: 28,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.black,
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'Open Path',
                      style: buttonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Cards(
            subPaths: widget.path.subPaths,
            scrollController: itemScrollController,
            pageController: pageController,
          ),
        ],
      ),
    );
  }
}

class Cards extends StatefulWidget {
  final List<SubPath> subPaths;
  final ItemScrollController scrollController;
  final PageController pageController;
  Cards(
      {@required this.subPaths,
      @required this.scrollController,
      @required this.pageController});

  @override
  State<StatefulWidget> createState() {
    return _CardsState();
  }
}

class _CardsState extends State<Cards> {
  int selectedPage = 0;
  bool flag = true;

  check(a) {
    flag = true;
  }

  highlightText(int value, String caller) {
    if (caller == 'text') {
      setState(
        () {
          flag = false;
          selectedPage = value;
          widget.pageController
              .animateToPage(value,
                  duration: Duration(seconds: 1), curve: Curves.easeInOut)
              .then(check);
        },
      );
    } else {
      setState(
        () {
          selectedPage = value;
          widget.scrollController.scrollTo(
              index: value,
              duration: Duration(microseconds: 50),
              curve: Curves.easeInOut);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Stack(
        children: <Widget>[
          PageView.builder(
              onPageChanged: (int value) {
                if (flag) highlightText(value, 'page');
              },
              controller: widget.pageController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.subPaths.length - 1,
              itemBuilder: (context, index) {
                return FadeInImage.assetNetwork(
                  image: widget.subPaths.elementAt(index).image,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                  placeholder: "",
                );
              }),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 60,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ScrollablePositionedList.builder(
                    itemScrollController: widget.scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.subPaths.length - 1,
                    itemBuilder: (context, index) {
                      return Row(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              highlightText(index, 'text');
                            },
                            child: Text(
                              widget.subPaths.elementAt(index).title,
                              style: kTitleStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: selectedPage == index
                                    ? ktitleColor
                                    : kopenpath,
                              ),
                            ),
                          ),
                          index != widget.subPaths.length - 2
                              ? Icon(
                                  Icons.arrow_forward,
                                  color: ktitleColor,
                                )
                              : SizedBox.shrink(),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
