//
//  SoundsRecordingController.swift
//  PitchPerfect
//
//  Created by Abdoulaye Diallo on 3/28/20.
//  Copyright © 2020 Abdoulaye Diallo. All rights reserved.
//

import UIKit
import AVFoundation

class SoundsRecordingController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder : AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false //disables stop recording button
        stopLabel.isHidden = true //Hide Stop Label
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }


    @IBAction func recordAudio(_ sender: AnyObject) {
        
        stopRecordingButton.isEnabled = true //enables stopRecording button
        stopLabel.isHidden = false
        recordingButton.isEnabled = false
        recordingLabel.text = "Recording in Progress"
        setUpAnimation()
        initializeRecorder()
    }
    @IBAction func stopRecording(_ sender: UIButton	) {
        stopRecordingButton.isEnabled = false
        stopLabel.isHidden = true
        recordingButton.isEnabled = true
        recordingLabel.text = "Tap to Record"
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
        
    }
    
    func setUpAnimation(){
        self.recordingButton.alpha = 0.0
        
        
        UIView.animate(withDuration: 2.0, animations: {
            self.recordingButton.alpha = 0.0
        }) { (finished) in
            
            UIView.animate(withDuration: 2.0, animations: {
                self.recordingButton.alpha = 1.0
                //fade in button
            })
        }
    }
    
    func initializeRecorder() {
    
    
        let directory =  NSSearchPathForDirectoriesInDomains(.documentDirectory,	 FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let recordingName = "myRecording.wav"
        let pathArray = [directory, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))//filepath is an optional URL
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
       
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "recordingFinished", sender: audioRecorder.url)
        }
        else {
            print("Recording failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recordingFinished"{
            let soundPlayingVC = segue.destination as! SoundsPlayingController
            let recordedUrl = sender as! URL
            soundPlayingVC.recordedAudioURL = recordedUrl
        }
    }

}


