import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WatchlistBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Watchlist"),
          backgroundColor: Colors.black,
        ),
        body: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            return ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                context
                    .read<WatchlistBloc>()
                    .add(ReorderStocks(oldIndex, newIndex));
              },
              children: [
                for (int i = 0; i < state.stocks.length; i++)
                  ListTile(
                    key: ValueKey(state.stocks[i].name),
                    leading: const Icon(Icons.drag_handle),
                    title: Text(state.stocks[i].name),
                    subtitle: Text(state.stocks[i].exchange),
                    trailing: Text(
                      state.stocks[i].price.toString(),
                      style: TextStyle(
                        color: state.stocks[i].change >= 0
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
