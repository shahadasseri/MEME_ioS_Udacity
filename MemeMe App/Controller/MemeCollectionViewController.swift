import UIKit

class MemeCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionMemes: UICollectionView!

    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!


    //Create Meme array:
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionMemes.delegate = self
        collectionMemes.dataSource = self
        
        let space:CGFloat = 3.0
         let dimension = (view.frame.size.width - (2*space)) / 3.0
        
         flowLayout.minimumInteritemSpacing = space
         flowLayout.minimumLineSpacing = space
         flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        collectionMemes.reloadData()
        
        tabBarController?.tabBar.isHidden = false
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return AppDelegate.share.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCellCollectionView", for: indexPath) as! MemeCellCollectionView
        let memeObj2 = AppDelegate.share.memes[indexPath.row]
        
        cellCollection.imgCellC.image = memeObj2.memeImage
     
        return cellCollection
    }
    
    @IBAction func CreatNewMemeColleaction(_ sender: Any) {
        
        performSegue(withIdentifier: "CollecionSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "DeatilsVC")as! MemeDetailesViewController
        
        detailsVC.meme = AppDelegate.share.memes[indexPath.row]
       
        // Push the new controller onto the stack
        self.navigationController!.pushViewController(detailsVC, animated: true)
    }
    


}
