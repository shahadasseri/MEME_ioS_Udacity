import UIKit

class MemeCellTableView: UITableViewCell {

    
    @IBOutlet weak var imgCellT: UIImageView!
    @IBOutlet weak var titleCellT: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
