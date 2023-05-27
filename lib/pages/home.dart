import 'package:flutter/material.dart';
import 'package:infinite_pagination/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _onRefresh() async {
    context.read<UserProvider>().refresh();
  }

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && context.read<UserProvider>().hasMore) {
      context.read<UserProvider>().fetchUser();
    }
  }

  @override
  void initState() {
    context.read<UserProvider>().fetchUser();
    super.initState();
    _scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Consumer<UserProvider>(builder: (_, state, __) {
          return ListView.builder(
              controller: _scrollController,
              itemCount:
                  state.hasMore ? state.users.length + 1 : state.users.length,
              itemBuilder: (context, index) {
                if (index < state.users.length) {
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.users[index].avatar ?? '')),
                    title: Text(state.users[index].name ?? ''),
                    subtitle: Text(state.users[index].email ?? ''),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }
              });
        }),
      ),
    );
  }
}
