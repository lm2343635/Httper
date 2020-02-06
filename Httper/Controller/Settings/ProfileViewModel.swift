//
//  ProfileViewModel.swift
//  Httper
//
//  Created by Meng Li on 2020/2/4.
//  Copyright © 2020 MuShare. All rights reserved.
//

import RxCocoa
import RxDataSourcesSingleSection
import RxSwift

class ProfileViewModel: BaseViewModel {
    
    private let reloadRelay = PublishRelay<Void>()
    
    var title: Observable<String> {
        .just("Profile")
    }
    
    var section: Observable<SingleSection<Selection>> {
        reloadRelay.map { _ in
            [
                Selection(icon: R.image.email(), title: UserManager.shared.displayEmail),
                Selection(icon: R.image.name(), title: UserManager.shared.name)
            ]
        }.map {
            SingleSection.create($0)
        }
    }
    
    func reload() {
        reloadRelay.accept(())
    }
    
}
