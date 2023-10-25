//
//  TeamTableViewCell.swift
//  Football_Chants
//
//  Created by Sihan on 4/10/23.
//

import UIKit

protocol TeamTableViewDelegate: AnyObject {
    func didTapPlayBack(for team: Team)
}

class TeamTableViewCell: UITableViewCell {

    static let cellId = "TeamTableViewCell"
    
    private weak var delegate: TeamTableViewDelegate?
    private var team: Team?
    
    private lazy var containerVw: UIView = {
       let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private lazy var contentStac: UIStackView = {
       let stackVw = UIStackView()
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        stackVw.spacing = 4
        stackVw.axis = .vertical
        return stackVw
    }()
    
    private lazy var badgeImage: UIImageView = {
       let imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        return imgVw
    }()
    
    private lazy var playBack: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white
        return btn
    }()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var foundedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private lazy var jobLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    
    override func layoutSubviews() {
        containerVw.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.team = nil
        self.delegate = nil
        self.containerVw.subviews.forEach{ $0.removeFromSuperview()}
    }
    
    func configure(with item: Team, delegate: TeamTableViewDelegate) {
//        containerVw.backgroundColor = TeamType.arsenal.background
        //containerVw.layer.cornerRadius = 10
        
        addContent(items: item)
        
//        containerVw.backgroundColor = item.id.background
//        badgeImage.image = item.id.badge
        
        self.team = item
        self.delegate = delegate
        
        playBack.addTarget(self, action: #selector(didTapPlayBack), for: .touchUpInside)
        playBack.setImage(item.isPlaying ? Assets.pause : Assets.play, for: .normal)
        
//        nameLabel.text = item.name
//        jobLabel.text = "Current \(item.manager.job.rawValue): Mikel Arteta"
//        foundedLabel.text = item.founded
//        infoLabel.text = item.info
                
        self.contentView.addSubview(containerVw)
        
        containerVw.addSubview(contentStac)
        containerVw.addSubview(badgeImage)
        containerVw.addSubview(playBack)
        
        contentStac.addArrangedSubview(nameLabel)
        contentStac.addArrangedSubview(jobLabel)
        contentStac.addArrangedSubview(foundedLabel)
        contentStac.addArrangedSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            containerVw.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 8),
            containerVw.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -8),
            containerVw.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            containerVw.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -8),
            
            badgeImage.heightAnchor.constraint(equalToConstant: 50),
            badgeImage.widthAnchor.constraint(equalToConstant: 50),
            badgeImage.topAnchor.constraint(equalTo: contentStac.topAnchor),
            badgeImage.leadingAnchor.constraint(equalTo: containerVw.leadingAnchor,constant: 8),
            
            
            contentStac.topAnchor.constraint(equalTo: containerVw.topAnchor, constant: 16),
            contentStac.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: -16),
            contentStac.leadingAnchor.constraint(equalTo: badgeImage.trailingAnchor, constant: 8),
            contentStac.trailingAnchor.constraint(equalTo: playBack.leadingAnchor, constant: -8),
            
//            playBack.heightAnchor.constraint(equalToConstant: 50),
//            playBack.widthAnchor.constraint(equalToConstant: 50),
//            playBack.topAnchor.constraint(equalTo: badgeImage.bottomAnchor,constant: 20),
//            playBack.leadingAnchor.constraint(equalTo: containerVw.leadingAnchor,constant: 8),
            
            playBack.heightAnchor.constraint(equalToConstant: 44),
            playBack.widthAnchor.constraint(equalToConstant: 44),
            playBack.trailingAnchor.constraint(equalTo: containerVw.trailingAnchor,constant: -8),
            playBack.topAnchor.constraint(equalTo: contentStac.topAnchor)
            //playBack.centerYAnchor.constraint(equalTo: containerVw.centerYAnchor),
        ])
    }
    
    func addContent(items: Team){
        containerVw.backgroundColor = items.id.background
        badgeImage.image = items.id.badge
        
        nameLabel.text = items.name
        jobLabel.text = "Current \(items.manager.job.rawValue): \(items.manager.name)"
        foundedLabel.text = items.founded
        infoLabel.text = items.info
    }
    
    @objc func didTapPlayBack(){
        if let team = team {
            delegate?.didTapPlayBack(for: team)
        }
    }

}
