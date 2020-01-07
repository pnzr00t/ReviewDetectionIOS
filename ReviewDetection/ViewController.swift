//
//  ViewController.swift
//  ReviewDetection
//
//  Created by 	Oleg2 on 07.01.2020.
//  Copyright © 2020 Oleg Pustoshkin. All rights reserved.
//

import UIKit
import CoreML
import NaturalLanguage

class ViewController: UIViewController {
    @IBOutlet weak var textForReview: UITextView!
    
    @IBOutlet weak var defaultScoreValue: UILabel!
    @IBOutlet weak var digitScoreValue: UILabel!
    @IBOutlet weak var bngScoreValue: UILabel!
    
    let reviewClassifierDefault: NLModel? = {
        let model = try? NLModel(mlModel: ReviewClassifier_default().model)
        return model
    }()
    
    let reviewClassifierBNG: NLModel? = {
        let model = try? NLModel(mlModel: ReviewClassifier_Bad_Good_Normal().model)
        return model
    }()
    
    let reviewClassifierDigitScore: NLModel? = {
        let model = try? NLModel(mlModel: ReviewClassifier_Score_As_String().model)
        return model
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        debugPrint("Hello!")
    }
}

extension ViewController {
    @IBAction func onDetectButtonPush(_ sender: UIButton) {
        guard let stringForReview = self.textForReview.text else {
            debugPrint("Cant get textForReview", #function, #line, #file)
            return
        }
        
        let stringForReviewTrimmed = stringForReview.trimmingCharacters(in: .whitespacesAndNewlines)
        if stringForReviewTrimmed.count == 0 {
            debugPrint("Empty string review after trim text", #function, #line, #file)
            return
        }
                
        if let defaultPredictValue = self.reviewClassifierDefault?.predictedLabel(for: stringForReviewTrimmed) {
            self.defaultScoreValue.text = defaultPredictValue
        }
        
        if let digitPredictValue = self.reviewClassifierDigitScore?.predictedLabel(for: stringForReviewTrimmed) {
            self.digitScoreValue.text = digitPredictValue
        }
        
        if let bngPredictValue = self.reviewClassifierBNG?.predictedLabel(for: stringForReviewTrimmed) {
            self.bngScoreValue.text = bngPredictValue
        }
    }
}
