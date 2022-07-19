class TrackLyricsResp {
  Message? message;

  TrackLyricsResp({message});

  TrackLyricsResp.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  Header? header;
  Body? body;

  Message({header, body});

  Message.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (header != null) {
      data['header'] = header!.toJson();
    }
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class Header {
  int? statusCode;
  double? executeTime;

  Header({statusCode, executeTime});

  Header.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    executeTime = json['execute_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['execute_time'] = executeTime;
    return data;
  }
}

class Body {
  Lyrics? lyrics;

  Body({lyrics});

  Body.fromJson(Map<String, dynamic> json) {
    lyrics = json['lyrics'] != null ? Lyrics.fromJson(json['lyrics']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lyrics != null) {
      data['lyrics'] = lyrics!.toJson();
    }
    return data;
  }
}

class Lyrics {
  int? lyricsId;
  int? explicit;
  String? lyricsBody;
  String? scriptTrackingUrl;
  String? pixelTrackingUrl;
  String? lyricsCopyright;
  String? updatedTime;

  Lyrics(
      {lyricsId,
      explicit,
      lyricsBody,
      scriptTrackingUrl,
      pixelTrackingUrl,
      lyricsCopyright,
      updatedTime});

  Lyrics.fromJson(Map<String, dynamic> json) {
    lyricsId = json['lyrics_id'];
    explicit = json['explicit'];
    lyricsBody = json['lyrics_body'];
    scriptTrackingUrl = json['script_tracking_url'];
    pixelTrackingUrl = json['pixel_tracking_url'];
    lyricsCopyright = json['lyrics_copyright'];
    updatedTime = json['updated_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lyrics_id'] = lyricsId;
    data['explicit'] = explicit;
    data['lyrics_body'] = lyricsBody;
    data['script_tracking_url'] = scriptTrackingUrl;
    data['pixel_tracking_url'] = pixelTrackingUrl;
    data['lyrics_copyright'] = lyricsCopyright;
    data['updated_time'] = updatedTime;
    return data;
  }
}
