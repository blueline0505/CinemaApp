//
//  BaseViewModel.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/2/27.
//

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    var input: Input { get }
    var output: Output { get }
}
