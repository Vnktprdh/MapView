//
//  MusicViewController.swift
//  Initials_Lab_Test_2
//
//  Created by Venkat 101287100 on 2021-01-22.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {
    
    private var audioPlayer : AVAudioPlayer!
    
    @IBOutlet weak var playButton: UIButton!
    
    var audioStat:Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try loadSoundTrack()
        }catch{
            print(error)
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func playOrPause(_ sender: Any) {
        
        if(audioStat == false)
        {
            audioStat = true
            audioPlayer.play()
            playButton.setTitle("Pause", for: .normal)
            
        }
        else if(audioStat == true)
        {
            audioStat = false
            audioPlayer.pause()
            playButton.setTitle("Play", for: .normal)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MusicViewController{
    
    func loadSoundTrack() throws{
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        let path = Bundle.main.path(forResource: "Ala", ofType: "mp3")
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        audioPlayer.prepareToPlay()
    }
    
    
    
}
