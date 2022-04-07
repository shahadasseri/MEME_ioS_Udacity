import Foundation
import UIKit

struct Meme{
    
    var textFiledTop : String
    var textFiledBottom : String
    var memeImage: UIImage
    var originMeme: UIImage
    
    init(textFiledTop: String,textFiledBottom :String,memeImage :UIImage,originMeme: UIImage){
        self.textFiledTop = textFiledTop
        self.textFiledBottom = textFiledBottom
        self.memeImage = memeImage
        self.originMeme = originMeme
    }
}
