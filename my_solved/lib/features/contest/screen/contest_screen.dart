import 'package:flutter/material.dart';
import 'package:my_solved/components/molecules/segmented_control/segmented_control.dart';

class ContestScreen extends StatelessWidget {
  const ContestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: MySolvedSegmentedControl(
            defaultIndex: 0,
            screenTitles: ["진행중인 대회", "예정된 대회"],
            onSelected: (index) {
              print(index);
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
        ],
        leadingWidth: 240,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: ContestView(),
          )
        ],
      ),
    );
  }
}

class ContestView extends StatefulWidget {
  const ContestView({super.key});

  @override
  State<ContestView> createState() => _ContestViewState();
}

class _ContestViewState extends State<ContestView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Contest View"),
    );
  }
}
