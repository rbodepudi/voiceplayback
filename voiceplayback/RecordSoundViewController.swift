//
//  RecordSoundViewController.swift
//  voiceplayback
//
//  Created by Bodepudi, Roopkishan on 6/15/21.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

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
        try! AVAudioSession.sharedInstance().setActive(false)
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
        avAudioRecorder.delegate = self
        avAudioRecorder.isMeteringEnabled = true
        avAudioRecorder.prepareToRecord()
        avAudioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        performSegue(withIdentifier: "stopRecordingSegue", sender: avAudioRecorder.url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingSegue" {
            if let controller = segue.destination as? PlaySoundViewController {
                controller.recordedAudioURL = sender as? URL
            }
        }
    }
}

