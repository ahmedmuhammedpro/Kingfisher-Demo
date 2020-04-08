import UIKit

struct Movie {
    
    var imageURL: String?
    var title: String?
    var rating: Double
    var releaseDate: Int
    var genre: String
    
    init(imageURL: String, title: String, rating: Double, releaseDate: Int, genre: String) {
        self.imageURL = imageURL
        self.title = title
        self.rating = rating
        self.releaseDate = releaseDate
        self.genre = genre
    }
    
}
