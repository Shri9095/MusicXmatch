import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:relu_app/common_function.dart';
import 'package:http/http.dart' as http;
import 'package:relu_app/models/track_detail_resp.dart';
import 'package:relu_app/models/track_lyrics_resp.dart';

class TrackDetailPage extends StatefulWidget {
  final int trackId;

  const TrackDetailPage({super.key, required this.trackId});

  @override
  State<TrackDetailPage> createState() => _TrackDetailPageState();
}

class _TrackDetailPageState extends State<TrackDetailPage> {
  Track? track;
  String? lyrics;
  @override
  void initState() {
    super.initState();
    getTrackDetails();
    getTrackLyrics();
  }

  Future<void> getTrackDetails() async {
    String url =
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=${widget.trackId}&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7';

    await CommonFunction.checkInternet().then(
      (isInternetAvailable) async {
        if (isInternetAvailable) {
          final resp = await http.get(Uri.parse(url));
          if (mounted) {
            setState(() {
              TrackDetailResp trackResp =
                  TrackDetailResp.fromJson(json.decode(resp.body));
              if (trackResp.message != null &&
                  trackResp.message!.body != null &&
                  trackResp.message!.body!.track != null) {
                track = trackResp.message!.body!.track!;
              }
            });
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
      },
    );
  }

  Future<void> getTrackLyrics() async {
    String url =
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${widget.trackId}&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7';

    await CommonFunction.checkInternet().then(
      (isInternetAvailable) async {
        if (isInternetAvailable) {
          final resp = await http.get(Uri.parse(url));

          if (mounted) {
            setState(() {
              TrackLyricsResp trackResp =
                  TrackLyricsResp.fromJson(json.decode(resp.body));
              if (trackResp.message != null &&
                  trackResp.message!.body != null &&
                  trackResp.message!.body!.lyrics != null &&
                  trackResp.message!.body!.lyrics!.lyricsBody != null) {
                lyrics = trackResp.message!.body!.lyrics!.lyricsBody;
              }
            });
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Details'),
      ),
      body: track != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text('Name'),
                    subtitle: Text(track!.trackName ?? ''),
                  ),
                  ListTile(
                    title: const Text('Artist'),
                    subtitle: Text(track!.artistName ?? ''),
                  ),
                  ListTile(
                    title: const Text('Album Anme'),
                    subtitle: Text(track!.albumName ?? ''),
                  ),
                  ListTile(
                    title: const Text('Explicit'),
                    subtitle: Text(track!.explicit.toString()),
                  ),
                  ListTile(
                    title: const Text('Rating'),
                    subtitle: Text(track!.trackRating.toString()),
                  ),
                  ListTile(
                    title: const Text('Lyrics'),
                    subtitle: Text(track!.trackRating.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      lyrics ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
