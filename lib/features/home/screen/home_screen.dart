import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_solved/components/styles/color.dart';
import 'package:my_solved/components/styles/font.dart';
import 'package:my_solved/features/home/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MySolvedColor.secondaryBackground,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: MySolvedColor.secondaryBackground,
        actions: [
          IconButton(
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: HomeView(),
          ),
        ],
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(InitHome());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: BlocProvider.of<HomeBloc>(context),
      listener: (context, state) {
        if (state.status.isFailure) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("네트워크 오류가 발생했어요"),
                content: Text("잠시 후 다시 시도해주세요"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("확인"),
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state.status.isSuccess && state.user != null) {
          return Column(
            children: [
              _profileAndBackgroundImage(
                profileImageURL: state.user!.profileImageUrl ??
                    "https://static.solved.ac/misc/360x360/default_profile.png",
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: MySolvedColor.background,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        state.handle,
                        style: MySolvedTextStyle.title5,
                      ),
                    ),
                    Text(state.isShowIllustBackground.toString()),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: MySolvedColor.main,
            ),
          );
        }
      },
    );
  }

  Widget _profileAndBackgroundImage({required String profileImageURL}) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(color: Colors.red),
            ),
            SizedBox(height: 50),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 16),
            SizedBox(
              width: 80,
              height: 80,
              child: ClipOval(
                child: ExtendedImage.network(profileImageURL),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
