import 'package:flutter/cupertino.dart';
import 'package:html/dom.dart' as dom;
import 'package:provider/provider.dart';

import '../models/User.dart';
import '../view_models/profile_detail_view_model.dart';
import '../widgets/user_widget.dart';

class ProfileDetailView extends StatelessWidget {
  const ProfileDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileDetailViewModel>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(viewModel.handle),
      ),
      child: SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<User>(
                    future: viewModel.future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // 배경 + 프로필
                            profileHeader(context, snapshot),
                            // 패딩
                            SizedBox(height: 70),
                            Container(
                              padding: EdgeInsets.only(left: 30),
                              child: Column(
                                children: [
                                  handle(context, snapshot),
                                  organizations(context, snapshot),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      solvedCount(context, snapshot),
                                      SizedBox(width: 10),
                                      reverseRivalCount(context, snapshot),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Spacer(),
                                zandi(context, snapshot),
                                Spacer(),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          padding:
                              EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              profileHeader(context, snapshot),
                            ],
                          ),
                        );
                      }
                    }),
                FutureBuilder<dom.Document>(
                    future: viewModel.futureTop,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.only(left: 30, right: 30, top: 20),
                              child: top100(context, snapshot),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension ProfileDetailViewExtension on ProfileDetailView {
  Widget profileHeader(BuildContext context, AsyncSnapshot<User> snapshot) {
    return CupertinoPageScaffold(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          backgroundImage(context, snapshot),
          Positioned(
            left: 25,
            bottom: -50,
            child: Stack(clipBehavior: Clip.none, children: <Widget>[
              profileImage(context, snapshot),
              Positioned(left: 38, top: 65, child: tiers(context, snapshot)),
            ]),
          ),
        ],
      ),
    );
  }
}
