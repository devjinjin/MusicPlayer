//
//  ViewController.swift
//  MusicPlayer
//
//  Created by jylee-mac on 2021/05/04.
//

import UIKit

class HomeViewController: UIViewController {
    
    let trackManager = TrackManager()
    // TODO: 트랙관리 객체 추가
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    // 몇개 표시 할까?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: 트랙매니저에서 트랙갯수 가져오기
        return trackManager.tracks.count
    }
    
    // 셀 어떻게 표시 할까?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: 셀 구성하기
        

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollecionViewCell", for: indexPath) as?
                TrackCollecionViewCell else {
                    return UICollectionViewCell()
                }
        
        let tract = trackManager.track(at: indexPath.row)
        cell.updateUI(item: tract)
  
        
        return cell
    }
    
    // 헤더뷰 어떻게 표시할까?
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            guard let item = trackManager.todayTrack else {
                return UICollectionReusableView()
            }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else {
                return UICollectionReusableView()
            }
            
            header.update(with: item)
            
            header.tapHandler = {item -> Void in
                //
                
                print("\(String(describing: item.convertToTrack()?.title))")
            }
            // TODO: 헤더 구성하기
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    // 클릭했을때 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 곡 클릭시 플레이어뷰 띄우기
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 20 - card(width) - 20 - card(width) - 20
        // TODO: 셀사이즈 구하기
        let spacing : CGFloat = 20
        let margin : CGFloat = 20
        let width = (collectionView.bounds.width - spacing - margin * 2)/2
        let height = width + 60
        
        return CGSize(width: width, height: height)
    }
}

