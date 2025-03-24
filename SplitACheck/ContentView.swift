//
//  ContentView.swift
//  SplitACheck
//
//  Created by Emil Mescheryakov on 24.03.2025.
//

import SwiftUI

struct ContentView: View {

	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 20

	@FocusState private var amountIsFocused: Bool

	let tipPercentages = [10, 15, 20, 25, 30, 0]
	let currencyCode = Locale.current.currency?.identifier ?? "USD"

	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople + 2)
		let tipSelection = Double(tipPercentage)

		let tipValue = checkAmount / 100  * tipSelection
		let grandTotal = checkAmount + tipValue
		let amountPerPerson = grandTotal / peopleCount

		return amountPerPerson
	}

	var totalCheckAmount: Double {
		let peopleCount = Double(numberOfPeople + 2)
		let tipSelection = Double(tipPercentage)

		let tipValue = checkAmount / 100  * tipSelection
		let grandTotal = checkAmount + tipValue

		return grandTotal
	}

	var body: some View {
		NavigationStack {
			Form {
				Section("Amount") {
					TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
						.keyboardType(.decimalPad)
						.focused($amountIsFocused)
				}

				Section("Tips percentage") {
					Picker("Tips percentage", selection: $tipPercentage) {
						ForEach(tipPercentages, id: \.self) {
							Text($0, format: .percent)
						}
					}
					.pickerStyle(.segmented)
				}

				Section("How many of you are there?") {
					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(2 ..< 100) {
							Text("\($0) people")
						}
					}
					.pickerStyle(.menu)
				}

				Section("Each should pay") {
					Text(totalPerPerson, format: .currency(code: currencyCode))
				}

				Section("Total check amount") {
					Text(totalCheckAmount, format: .currency(code: currencyCode))
				}
			}
			.navigationTitle("SplitACheck")
			.toolbar {
				if amountIsFocused {
					Button("Done") {
						amountIsFocused = false
					}
				}
			}
		}
	}
}
