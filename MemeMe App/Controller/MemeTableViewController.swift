import UIKit

class MemeTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var memeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeTable.delegate = self
        memeTable.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // To reload tableView data to show new memes
        memeTable.reloadData()
        //To show tabBar
        tabBarController?.tabBar.isHidden = false
    }
    
    
    //Create Meme array:
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    //How many cell did we have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.share.memes.count
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //Cell appearance
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMeme", for: indexPath) as! MemeCellTableView
        
        //get the specific eliment in the array
        let memeObj = AppDelegate.share.memes[indexPath.row]
        
        //how to appears the cell with the array data
        cell.titleCellT.text = memeObj.textFiledTop+"  "+memeObj.textFiledBottom
        cell.imgCellT.image = memeObj.memeImage

        return cell
    }
    
    
    @IBAction func CreateMem(_ sender: Any) {
        performSegue(withIdentifier: "NewMemeCell", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "DeatilsVC")as! MemeDetailesViewController
        
        detailsVC.meme = AppDelegate.share.memes[indexPath.row]
       
        // Push the new controller onto the stack
        self.navigationController!.pushViewController(detailsVC, animated: true)
        
        
    }


}
