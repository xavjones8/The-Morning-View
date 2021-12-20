//
//  ViewController.swift
//  The Morning View
//
//  Created by Xavier Jones on 6/26/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum SectionLayoutKind: Int, CaseIterable {
        case topResults, normal
        }
    var articles: [NewsStream.Article] = [NewsStream.Article(source: NewsStream.Source(id: "hey", name: "hey"), author: "me", title: "purr", description: "my name is xavoer", url: nil, urlToImage: URL(string: "https://xavjones8.github.io/assets/img/NY.png"), publishedAt: "yuh"),NewsStream.Article(source: NewsStream.Source(id: "hey", name: "hey"), author: "me", title: "purr", description: "my name is xavoer", url: URL(string: "www.google.com"), urlToImage: URL(string: "https://xavjones8.github.io/assets/img/NY.png"), publishedAt: "yuh"),NewsStream.Article(source: NewsStream.Source(id: "hey", name: "hey"), author: "me", title: "purr", description: "my name is xavoer", url: URL(string: "www.bing.com"), urlToImage: URL(string: "https://xavjones8.github.io/assets/img/NY.png"), publishedAt: "yuh")]
    var topHeadlines = true
    lazy var topResults: [NewsStream.Article] = []
    var sections: [Section] = []
    let newsController = NewsController()
    var collectionViewDataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, NewsStream.Article>!
    
    var searchItemsSnapshot: NSDiffableDataSourceSnapshot<SectionLayoutKind,NewsStream.Article>{
        var snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind,NewsStream.Article>()
                SectionLayoutKind.allCases.forEach {
                    switch $0{
                    case .topResults:
                        snapshot.appendSections([$0])
                        snapshot.appendItems(articles, toSection: $0)
                        if topResults.isEmpty{
                            /*
                            print("broken")
                            break
                             */
                        }else{
                            /*
                            print("very broken")
                            snapshot.appendSections([$0])
                            snapshot.appendItems(topResults, toSection: $0)
                             */
                        }
                    case .normal:
                        
                        print("normal")
                        /*
                        snapshot.appendSections([$0])
                        snapshot.appendItems(articles, toSection: $0)
                         */
                    }
                }
        print(snapshot.sectionIdentifiers)
        print(snapshot.itemIdentifiers)
                return snapshot
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     /*
        let startingQuery = SearchTopHeadlines()
        DispatchQueue.main.async {
            self.newsController.fetchNews(search: .top_headlines, matching: startingQuery.createTopHeadlinesSearch()) { result in
                switch result{
                case .success(let stream):
                    self.articles = stream.articles
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        */
        collectionView.setCollectionViewLayout(generateResultsLayout(), animated: false)
        self.configureDataSource(self.collectionView)
        //self.collectionView.reloadData()
        }
         
        // Do any additional setup after loading the view.
      
    }
extension ViewController{
    /// - Tag: Top Results
    private func generateResultsLayout() -> UICollectionViewLayout{
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
            switch sectionLayoutKind {
            case .topResults:
                let spacing: CGFloat = 5
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(15.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)

                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = spacing
                section.orthogonalScrollingBehavior = .groupPagingCentered
                return section
            case .normal:
                /*
                let config = UICollectionLayoutListConfiguration(appearance: .plain)
                return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
                 */
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let spacing: CGFloat = 10.0

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(70.0)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitem: item,
                    count: 1
                )

                group.contentInsets = NSDirectionalEdgeInsets(
                    top: spacing,
                    leading: spacing,
                    bottom: 0,
                    trailing: spacing
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
             //   let layout = UICollectionViewCompositionalLayout(section: section)
                
                return section
            }
        }
         
        return layout
    }
}
   
extension ViewController{
    func configureDataSource(_ collectionView: UICollectionView){
        
        let topResultsRegistration = UICollectionView.CellRegistration<NewsTopResultCollectionViewCell,NewsStream.Article> { (cell, indexPath, article) in
            cell.configure(for: article, newsController: self.newsController)
            //Adjusts Appearance of the cell
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cell.layer.shadowRadius = 10.0
            cell.layer.shadowOpacity = 0.25
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        }
        
        let normalResultsRegistration = UICollectionView.CellRegistration<NewsTopResultCollectionViewCell,NewsStream.Article> { (cell, indexPath, article) in
            cell.configure(for: article, newsController: self.newsController)
            //Adjusts Appearance of the cell
        }
        
        collectionViewDataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, NewsStream.Article>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: NewsStream.Article) -> UICollectionViewCell? in
            
            print("yess it works")
            print(identifier)
            print("yess it works")
            // Return the cell.
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "top", for: indexPath) as! NewsTopResultCollectionViewCell
            cell.configure(for: identifier, newsController: self.newsController)
            return cell
            /* SectionLayoutKind(rawValue: indexPath.section)! == .topResults ?  collectionView.dequeueConfiguredReusableCell(using: topResultsRegistration, for: indexPath, item: identifier) : collectionView.dequeueConfiguredReusableCell(using: normalResultsRegistration, for: indexPath, item: identifier)
            */
        }
        
        collectionViewDataSource.apply(searchItemsSnapshot, animatingDifferences: false)
    }
    
    
    

}


