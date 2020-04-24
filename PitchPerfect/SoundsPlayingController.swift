//
//  SoundsPlayingController.swift
//  PitchPerfect
//
//  Created by Abdoulaye Diallo on 3/28/20.
//  Copyright © 2020 Abdoulaye Diallo. All rights reserved.
//

import UIKit
import AVFoundation


class SoundsPlayingController: UIViewController {

    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopPlaybackButton: UIButton!
    var recordedAudioURL : URL!
    
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer : Timer!
    
    enum PlayBackButton : Int{
        case highPitch
        case lowPitch
        case slow
        case fast
        case reverb
        case echo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playbackRecording(_ sender: UIButton) {
        switch(PlayBackButton(rawValue: sender.tag)!){
        case .highPitch:
            playSound(pitch: 1500)//play high pitch
            return
        case .lowPitch:
            playSound(pitch: -1500)//play low pitch
            return
        case .slow:
            playSound(rate: 0.5)//play slow sound
            return
        case .fast:
            playSound(rate:1.5)//play fast sound
            return
        case .reverb:
            playSound(reverb: true)//reverberate sound
            return
        case .echo:
            playSound(echo: true)//make sound echo
            return
        default: break
        }
        
        configureUI(.playing)
    }
    
    
    @IBAction func stopPlayback(_ sender: UIButton) {
        stopAudio()
    }
    

}
