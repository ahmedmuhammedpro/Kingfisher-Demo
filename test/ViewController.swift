import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moviesTableView: UITableView!
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        fetchData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let movie = movies[indexPath.row]
        cell.movieImageView.kf.indicatorType = .activity
        cell.movieImageView.kf.setImage(with: URL(string: movie.imageURL!))
        cell.movieTitleLabel.text = movie.title!
        cell.movieRatingLabel.text = "\(movie.rating)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView = storyboard?.instantiateViewController(identifier: "detailsView") as! DetailsViewController
        detailsView.movie = movies[indexPath.row]
        navigationController?.pushViewController(detailsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    private func fetchData() {
        let request = URLRequest(url: URL(string: "https://api.androidhive.info/json/movies.json")!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: Any]]
                
                for element in json {
                    let imageURL = element["image"] as! String
                    let title = element["title"] as! String
                    let rating = element["rating"] as! Double
                    let releaseDate = element["releaseYear"] as! Int
                    let genre = self.getGenre(element["genre"] as! [String])
                    
                    let movie = Movie(imageURL: imageURL, title: title, rating: rating, releaseDate: releaseDate, genre: genre)
                    self.movies.append(movie)
                }
                
                DispatchQueue.main.async {
                    self.moviesTableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    private func getGenre(_ arr: [String]) -> String {
        var genre = ""
        
        for value in arr[0..<(arr.count - 1)] {
            genre += value + ", "
        }
        
        genre += arr[arr.count - 1]
        
        return genre
    }
    
}

