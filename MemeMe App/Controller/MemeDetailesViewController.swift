import UIKit

class MemeDetailesViewController: UIViewController {

    var meme : Meme?
    
    @IBOutlet weak var imgDetailes: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sent Meme"

        tabBarController?.tabBar.isHidden = false

        
        imgDetailes.image = meme?.memeImage

    }


}
