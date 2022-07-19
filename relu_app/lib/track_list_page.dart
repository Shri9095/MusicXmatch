import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relu_app/common_function.dart';
import 'package:relu_app/tack_details_page.dart';
import 'package:relu_app/models/track_resp.dart';

class TrackListPage extends StatefulWidget {
  const TrackListPage({Key? key}) : super(key: key);

  @override
  State<TrackListPage> createState() => _TrackListPageState();
}

class _TrackListPageState extends State<TrackListPage> {
  ValueNotifier<List<TrackList>> trackList = ValueNotifier<List<TrackList>>([]);

  @override
  void initState() {
    super.initState();
    getListOfTrack();
  }

  Future<void> getListOfTrack() async {
    const url =
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7';
    await CommonFunction.checkInternet().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        final resp = await http.get(Uri.parse(url));
        final TrackResp trackResp = TrackResp.fromJson(json.decode(resp.body));
        if (trackResp.message != null &&
            trackResp.message!.body != null &&
            trackResp.message!.body!.trackList != null &&
            trackResp.message!.body!.trackList!.isNotEmpty) {
          trackList.value = trackResp.message!.body!.trackList!;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'No Internet',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track List'),
      ),
      body: ValueListenableBuilder(
        valueListenable: trackList,
        builder: (context, List<TrackList> list, index) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.music_note),
                  trailing: Text(list[index].track!.artistName ?? ''),
                  onTap: () {
                    if (list[index].track!.trackId != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TrackDetailPage(
                                trackId: list[index].track!.trackId!);
                          },
                        ),
                      );
                    }
                  },
                  title: Text(
                    list[index].track?.trackName ?? '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
