 




import UIKit
 
let imageCache = NSCache<NSString, UIImage>()

 extension UIFont {
    var bold: UIFont {
        return with(.traitBold)
    }
    
    var italic: UIFont {
        return with(.traitItalic)
    }
    
    var boldItalic: UIFont {
        return with([.traitBold, .traitItalic])
    }
    
    
    
    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits)) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
    
    func without(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(self.fontDescriptor.symbolicTraits.subtracting(UIFontDescriptor.SymbolicTraits(traits))) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}



extension UIImageView {
    var isEmpty: Bool { image == nil }
    
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    
    
    
    
    
    func loadImageUsingCacheFromUrlString(urlString: String) {
        
         
         
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            
            return
        }
        
         
        
        let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if(error != nil){
                print(error?.localizedDescription)
                return
            }
            
            DispatchQueue.main.async{
                if let downloadedImage = UIImage(data: data!) {
                   
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    self.image = downloadedImage
                    
                }
                
                
            }
            
        }.resume()
        
        
    }
}























