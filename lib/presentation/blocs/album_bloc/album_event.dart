import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbumsEvent extends AlbumEvent {
  const LoadAlbumsEvent();
}

class RefreshAlbumsEvent extends AlbumEvent {
  const RefreshAlbumsEvent();
}
