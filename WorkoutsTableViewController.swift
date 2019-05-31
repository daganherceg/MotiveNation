/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import HealthKit

class WorkoutsTableViewController: UITableViewController {
    
    private enum WorkoutsSegues: String {
        case showCreateWorkout
        case finishedCreatingWorkout
    }
    
    private var workouts: [HKWorkout]?
    
    private let MotiveNationWorkoutCellID = "MotiveNationWorkoutCell"
    
    lazy var dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadWorkouts()
    }
    
    func reloadWorkouts() {
        WorkoutDataStore.loadWorkouts { (workouts, error) in
            self.workouts = workouts
            self.tableView.reloadData()
        }
    }
    
}

// HASH MAP of workout types to Workout names
var workoutTypeHash = [
    36 : "Rugby",
    71 : "Wheelchair Run Pace",
    46 : "Swimming",
    20 : "Functional Strength Training",
    55 : "Water Sports",
    40 : "Snow Sports",
    63 : "High Intensity Interval Training",
    69 : "Step Training",
    13 : "Cycling",
    22 : "Gymnastics",
    43 : "Squash",
    62 : "Flexibility",
    35 : "Rowing",
    65 : "Kickboxing",
    16 : "Elliptical",
    34 : "Racquetball",
    32 : "Play",
    3000 : "Other",
    18 : "Fencing",
    60 : "Cross Country Skiing",
    52 : "Walking",
    11 : "Cross Training",
    66 : "pilates",
    58 : "barre",
    45 : "Surfing Sports",
    50 : "Traditional Strength Training",
    23 : "handball",
    3 : "australianFootball",
    49 : "trackAndField",
    30 : "mixedMetabolicCardioTraining",
    27 : "lacrosse",
    28 : "martialArts",
    29 : "mindAndBody",
    15 : "danceInspiredTraining",
    4 : "badminton",
    54 : "waterPolo",
    25 : "hockey",
    7 : "bowling",
    68 : "stairs",
    70 : "wheelchairWalkPace",
    59 : "coreTraining",
    33 : "preparationAndRecovery",
    21 : "golf",
    51 : "volleyball",
    38 : "sailing",
    24 : "hiking",
    1 : "americanFootball",
    44 : "stairClimbing",
    41 : "soccer",
    37 : "Running",
    17 : "equestrianSports",
    42 : "softball",
    47 : "tableTennis",
    2 : "archery",
    6 : "basketball",
    57 : "yoga",
    72 : "taiChi",
    73 : "Mixed Cardio",
    67 : "snowboarding",
    56 : "wrestling",
    53 : "waterFitness",
    5 : "baseball",
    8 : "boxing",
    9 : "climbing",
    39 : "skatingSports",
    26 : "hunting",
    19 : "fishing",
    48 : "tennis",
    61 : "downhillSkiing",
    64 : "jumpRope",
    14 : "dance",
    74 : "handCycling",
    12 : "curling",
    10 : "cricket",
    31 : "paddleSports"
]


// MARK: - UITableViewDataSource
extension WorkoutsTableViewController {
    
    
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return workouts?.count ?? 0
    }
    
    
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let workouts = workouts else {
            fatalError("""
      CellForRowAtIndexPath should \
      not get called if there are no workouts
      """)
        }
        
        //1. Get a cell to display the workout in
        let cell = tableView.dequeueReusableCell(withIdentifier:
            MotiveNationWorkoutCellID, for: indexPath)
        
        //2. Get the workout corresponding to this row
        let workout = workouts[indexPath.row]
        
        //3. Show the workout's start date in the label
        cell.textLabel?.text = workoutTypeHash[Int(workout.workoutActivityType.rawValue)]

        //4. Show the Calorie burn in the lower label
//        var caloriesBurned = 0.0;
        
        
        if let caloriesBurned =
            workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) {
            let formattedCalories = String(format: "Pointes Gained: %.2f",
                                           caloriesBurned)
            
            cell.detailTextLabel?.text = formattedCalories + " for workout @ " + dateFormatter.string(from: workout.startDate)
        }
        
        //5. Show score in the workout
//        cell.text = String(caloriesBurned);
        
        
        return cell
    }
    
}


