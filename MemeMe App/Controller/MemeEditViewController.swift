
import UIKit

class MemeEditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {

    //Outlets:
        @IBOutlet weak var imagePickerView: UIImageView!
        @IBOutlet weak var cameraButton: UIBarButtonItem!
        @IBOutlet weak var textTop: UITextField!
        @IBOutlet weak var textBottom: UITextField!
        @IBOutlet weak var shareButton: UIBarButtonItem!
        @IBOutlet weak var toolBar: UIToolbar!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Default text value:
            textTop.text = "TOP"
            textBottom.text = "BOTTOM"
            
            //Text Fileds Alignemnt:
            textTop.textAlignment = .center
            textBottom.textAlignment = .center
            
            //To enabale remove devault value and dismiss Keybord:
            textTop.delegate = self
            textBottom.delegate = self
            
            //Edit textFiled
            editingTextField(textField: textTop)
            editingTextField(textField: textBottom)
            
            //Hidden Share Button:
            shareButton.isEnabled = false


        }
        
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            
            //To disable the camera button if device hasn't camera
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
            
            subscribeToKeyboardNotifications()
        }
        
        override func viewWillDisappear(_ animated: Bool) {

            super.viewWillDisappear(animated)
            unsubscribeFromKeyboardNotifications()
        }

        
        //Tells the delegate that the users can see pickerview to pick image from photo ibrary
        @IBAction func pickAnImage(_ sender: Any) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            present(pickerController,animated: true,completion: nil)
        }
        
        //Tells the delegate that the users can slect  pick image from camera
        @IBAction func pickImageCamera(_ sender: Any) {
            
            let imagePicker = UIImagePickerController()
                   imagePicker.delegate = self
                   imagePicker.sourceType = .camera
                   present(imagePicker, animated: true, completion: nil)
        }
        
        //Tells the delegate that the user picked a still image or movie
        func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            imagePickerView.image = image
            //Enable Share Button
            self.shareButton.isEnabled = true
        //Call cancel func to dismiss UIImagePickerController
            imagePickerControllerDidCancel(picker)
        }
        
        
        //Tells the delegate that the user cancelled the pick operation:
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
        //When start Editeng remove default value of textfileds:
         func textFieldDidBeginEditing(_ textField: UITextField) {
             if  textField == textTop{
                textField.text = " "
            }else if textField == textBottom{
                textField.text = " "
            }
             
         }

        
        //When user presses return, the keyboard should be dismissed:
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == textTop{
                textField.resignFirstResponder()
            }else if textField == textBottom{
                textField.resignFirstResponder()
            }
            return true
        }
        
        

       //Enable editing on text fileds:
        func editingTextField(textField: UITextField) {
            
            let memeTextAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                NSAttributedString.Key.strokeWidth: -3
            ]

            textField.defaultTextAttributes = memeTextAttributes
            textField.textAlignment = .center
            
        }
        
        
        //To move the view up when start editing bottom textField:
        @objc func keyboardWillShow(_ notification:Notification) {
            if textBottom.isFirstResponder{
                view.frame.origin.y = -getKeyboardHeight(notification)
                }
           
        }
        
        
        //show the keyboard when start edit text fildes:
        func subscribeToKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
    
    
        func unsubscribeFromKeyboardNotifications() {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        }
        
    
        @objc  func keyboardWillHide(_ notification:Notification){
            view.frame.origin.y = 0
        }
        
      
        //Get keybord size
        func getKeyboardHeight(_ notification:Notification) -> CGFloat {
           let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
           return keyboardSize.cgRectValue.height
       }
        
        
        //Helps to original image combined with the overlayed text
        func generateMemedImage() -> UIImage {

            //  Hide toolbar and navbar
            self.toolBar.isHidden = true

            // Render view to an image
            UIGraphicsBeginImageContext(self.view.frame.size)
            view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
            let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            // Show toolbar and navbar
            self.toolBar.isHidden = false

            return memedImage
        }
        
        //Save Meme object
        func save(memeImage : UIImage) {
                // Create the meme
            let meme = Meme(textFiledTop: textTop.text!, textFiledBottom: textBottom.text!, memeImage:memeImage, originMeme:imagePickerView.image!)
            
            // Add it to the memes array in the Application Delegate
                AppDelegate.share.memes.append(meme)
        }
        
        //Share Meme:
        @IBAction func share(_ sender: Any) {
            let image = generateMemedImage()
            
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            
            activityViewController.completionWithItemsHandler =  { (activityType, completed, returnedItems, activityError) -> Void in
                    if completed {
                     //call save method
                        self.save(memeImage: image)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
                present(activityViewController, animated: true)
        }
        

    }
