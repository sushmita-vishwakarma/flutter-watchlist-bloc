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
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Watchlist"),
          backgroundColor: Colors.black,
          elevation: 0,
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
                  Container(
                    key: ValueKey(state.stocks[i].name),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // LEFT SIDE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.stocks[i].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              state.stocks[i].exchange,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // RIGHT SIDE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              state.stocks[i].price.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${state.stocks[i].change}%",
                              style: TextStyle(
                                color: state.stocks[i].change >= 0
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
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
