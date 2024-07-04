//
//  ContentView.swift
//  StudyRegex
//
//  Created by Jaehwi Kim on 2024/06/24.
//

import SwiftUI
import Foundation
import RegexBuilder

struct ContentView: View {
    @State var pasword: String = ""
    @State var isValid: Bool = false
    
    var body: some View {
        VStack {
            TextField(text: $pasword) {
                Text("Password")
            }
            .onChange(of: pasword) { newValue in
                isValid = InputRegex.passwordSpecialCharacter.isValid(newValue) && InputRegex.passwordLength.isValid(newValue) && InputRegex.passwordAlphabetDigit.isValid(newValue)
            }
            .background(isValid ? .blue.opacity(0.2) : .red.opacity(0.2))
        }
        .padding()
    }
}

public extension String {
    // 8 ~ 20 자리 이하
    // let passwordRegex1 = /^.{8,20}$/
    func lengthCheck(min: Int, max: Int) -> Bool {
        let lengthRegex = Regex {
            Repeat(min...max) {
                .any
            }
        }.anchorsMatchLineEndings()
        return self.wholeMatch(of: lengthRegex)?.output != nil
    }
    
    // 숫자 하나 이상, 영어 문자 하나 이상
    // let passwordRegex2 = /^(?=.*[a-zA-Z])(?=.*\d).+$/
    
    
    // 특수문자 하나 이상
    // let passwordRegex3 = /^(?=.*[{}\[\]?.,;:|)*~!^+\\\-<>@#$%&=('\"]).+$/
    func specialCharacterCheck() -> Bool {
        let specialCharacterRegex = Regex {
            Lookahead {
                ZeroOrMore(.any)
                One(.anyOf("{}[]?.,;:|)*~!^+\\-<>@#$%&=('\""))
            }
            OneOrMore(.any)
        }.anchorsMatchLineEndings()
        return self.wholeMatch(of: specialCharacterRegex)?.output != nil
    }
}

public enum InputRegex {
    case passwordLength
    case passwordAlphabetDigit
    case passwordSpecialCharacter
    
    private var regex: Regex<Substring> {
        switch self {
        case .passwordLength:
            let lengthRegex = Regex {
                Repeat(8...20) {
                    .any
                }
            }.anchorsMatchLineEndings()
            return lengthRegex
        case .passwordAlphabetDigit:
            let alphabetNumberRegex: Regex = Regex {
                Lookahead {
                    ZeroOrMore(.any)
                    CharacterClass(
                        ("a"..."z"),
                        ("A"..."Z")
                    )
                }
                Lookahead {
                    ZeroOrMore(.any)
                    One(.digit)
                }
                ZeroOrMore(.any)
            }.anchorsMatchLineEndings()
            return alphabetNumberRegex
        case .passwordSpecialCharacter:
            let specialCharacterRegex = Regex {
                Lookahead {
                    ZeroOrMore(.any)
                    One(.anyOf("`~!@#$%^&*()_+     {}[]?.,;:|)*~!^+\\-<>@#$%&=('\""))
                    One(.anyOf("{}[]?.,;:|)*~!^+\\-<>@#$%&=('\""))
                }
                ZeroOrMore(.any)
            }.anchorsMatchLineEndings()
            return specialCharacterRegex
        }
    }
    
    public func isValid(_ inputString: String) -> Bool {
        return inputString.wholeMatch(of: self.regex)?.output != nil
    }
}
