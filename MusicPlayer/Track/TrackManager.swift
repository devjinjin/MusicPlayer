//
//  TrackManager.swift
//  MusicPlayer
//
//  Created by jylee-mac on 2021/05/04.
//

import UIKit
import AVFoundation

class TrackManager {
    // TODO: 프로퍼티 정의하기 - 트랙들, 앨범들, 오늘의 곡
    var tracks : [AVPlayerItem] = []
    var albums: [Album] = []
    var todayTrack: AVPlayerItem?
    
    // TODO: 생성자 정의하기
    init() {
        let tracts = loadTracks()
        self.tracks = tracts
        self.albums = loadAlbums(tracks: tracts)
        self.todayTrack = self.tracks.randomElement()
    }

    // TODO: 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
//        let items = urls.map{ AVPlayerItem(url: $0)}
        let items = urls.map{ url in
            return AVPlayerItem(url: url)
        }
        return items
    }
    
    // TODO: 인덱스에 맞는 트랙 로드하기
    func track(at index: Int) -> Track? {
        
        let playerItem = self.tracks[index]
        
        return playerItem.convertToTrack()
    }

    // TODO: 앨범 로딩메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        
        let trackList : [Track] = tracks.compactMap { $0.convertToTrack()}
        let albumDics = Dictionary(grouping: trackList, by: { (track) in track.albumName })
        
        var albums : [Album] = []
        for (key, value) in albumDics {
            
            let title = key
            let tracks = value
    
            albums.append(Album.init(title: title, tracks: tracks))
        }
        
        return albums
    }

    // TODO: 오늘의 트랙 랜덤으로 선책
    func loadOtherTodaysTrack() {
        self.todayTrack = self.tracks.randomElement()
    }
}
