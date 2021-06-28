//
//  ViewController.swift
//  voiceplayback
//
//  Created by Bodepudi, Roopkishan on 6/15/21.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var avAudioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    @IBAction func stopRecording(_ sender: Any) {
        recordingLabel.text = "Tap to Record"
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        avAudioRecorder.stop()
    }
    
    @IBAction func startRecording(_ sender: Any) {
        recordingLabel.text = "Recording In Progess"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let fileName = "record.wav"
        let audioPath = [documentPath, fileName].joined(separator: "/")
        print(audioPath)
        let url = URL(string: audioPath)
        try! AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
        try! AVAudioSession.sharedInstance().setActive(true)
        try! avAudioRecorder = AVAudioRecorder(url: url!, settings: [:])
        avAudioRecorder.isMeteringEnabled = true
        avAudioRecorder.prepareToRecord()
        avAudioRecorder.record()
    }
}

