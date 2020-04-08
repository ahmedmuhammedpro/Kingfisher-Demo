import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let validMovie = movie {
            movieImageView.kf.setImage(with: URL(string: validMovie.imageURL!))
            movieTitleLabel.text = validMovie.title
            movieRatingLabel.text = "Rating: \(validMovie.rating)"
            movieReleaseDateLabel.text = "Release year: \(validMovie.releaseDate)"
            movieGenreLabel.text = "Genre: " + validMovie.genre
        }
    }

}
