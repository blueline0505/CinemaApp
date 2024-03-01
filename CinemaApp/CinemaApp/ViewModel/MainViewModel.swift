//
//  MainViewModel.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/2/27.
//

import Foundation
import Combine

class MainViewModel: ViewModel {
    let input: Input
    let output: Output
    
    
    private let inputSubject = PassthroughSubject<Void, Never>()
    private let outputSubject = CurrentValueSubject<[Movie], Never>([])
    
    init() {
        
        
        self.output = Output(movies: outputSubject)
        self.input = Input(onAppear: inputSubject)
    }
}

extension MainViewModel {
    struct Input {
        let onAppear: PassthroughSubject<Void, Never>
    }
    
    struct Output {
        let movies: CurrentValueSubject<[Movie], Never>
    }
    
}
