import UIKit

let json = """
[{"id":"id01","name":"you_know_who","job_title":"new Dev","age":16,"mentor":{"id":"id987","name":"Hạnh","position":"PM","age":20}},{"id":"id02","name":"Hướng","job_title":"Fresher cứng","age":19,"mentor":{"id":"id089","name":"Bắc","job_title":"Team Lít","age":25}},{"id":"id987","name":"Hạnh","job_title":"PM","age":20,"mentee":{"name":"TuanB","position":"new Dev","age":16}},{"id":"id0981","name":"Nam","job_title":"Dev","age":25,"mentor":{"id":"id321","name":"Hanh","position":"PM","age":20}},{"id":"id089","name":"Bắc","job_title":"Team Lít","age":25,"mentor":{"id":"id321","name":"Kiên","position":"SM","age":27},"mentee":{"id":"id02","name":"Hướng","job_title":"Fresher cứng","age":19}}]
"""

class Employee {
    var idUser: String = ""
    var name: String = ""
    var job_title: String = ""
    var age: Int = 0
    var mentor: Mentor?
    var mentee: Mentee?
    
    init(){
    }
    
    init(idUser:String,name:String,job_title:String,age:Int,mentor:Mentor?,mentee:Mentee?) {
        self.idUser = idUser
        self.name = name
        self.job_title = job_title
        self.age = age
        self.mentor = mentor
        self.mentee = mentee
    }
    
    func addMenter(menter: Mentor?) -> Void {
        self.mentor = menter
    }
    
    func addMentee(mentee: Mentee?) -> Void {
        self.mentee = mentee
    }
    
    func delMenter() -> Void {
        self.mentor = nil
    }
    
    func delMentee() -> Void {
        self.mentee = nil
    }
    
    func updateNameMentor(name: String?) -> Void {
        self.mentor?.name = name!
    }
    
    func updateNameMentee(name: String?) -> Void {
        self.mentee?.name = name!
    }

}

class Mentor {
    var id: String = ""
    var name: String = ""
    var position: String = ""
    var age: Int = 0
    
    init() {
    }
    
    required init(id: String, name: String, position: String, age: Int){
        self.id = id
        self.name = name
        self.position = position
        self.age = age
    }
}

class Mentee {
    var id: String = ""
    var name: String = ""
    var job_title: String = ""
    var age: Int = 0
    
    init() {

    }
    
    required init(id: String, name: String, position: String, age: Int){
        self.id = id
        self.name = name
        self.job_title = position
        self.age = age
    }
}

var employee: [Employee] = []

extension String {
    func convertToDictionary() -> [Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

func convertDataToMentorClass(dict: [String : AnyObject]) -> Mentor {
    
    let mentorModel = Mentor()
    
    if let id = dict["id"] as? String {
        mentorModel.id = id
    }
    
    if let name = dict["name"] as? String{
        mentorModel.name = name
    }
    
    if let position = dict["position"] as? String{
        mentorModel.position = position
    }
    
    if let age = dict["age"] as? Int{
        mentorModel.age = age
    }
    
    return mentorModel
}

func convertDataToMenteeClass(dict: [String : AnyObject]) -> Mentee {
    
    let menteeModel = Mentee()
    
    if let id = dict["id"] as? String {
        menteeModel.id = id
    }
    
    if let name = dict["name"] as? String{
        menteeModel.name = name
    }
    
    if let job_title = dict["job_title"] as? String{
        menteeModel.job_title = job_title
    }
    
    if let age = dict["age"] as? Int{
        menteeModel.age = age
    }
    
    return menteeModel
}

for itemEmp in json.convertToDictionary() as! [Dictionary<String,AnyObject>]{
    
    let emp = Employee()
    
    if let id = itemEmp["id"] as? String {
        emp.idUser = id
    }
    
    if let name = itemEmp["name"] as? String{
        emp.name = name
    }
    
    if let job_title = itemEmp["job_title"] as? String{
        emp.job_title = job_title
    }
    
    if let age = itemEmp["age"] as? Int{
        emp.age = age
    }
    
    if let mentor = itemEmp["mentor"] as? [String : AnyObject] {
        let mentorModel = convertDataToMentorClass(dict: mentor)
        emp.mentor = mentorModel
    }
    
    if let mentee = itemEmp["mentee"] as? [String : AnyObject] {
        let menteeModel = convertDataToMenteeClass(dict: mentee)
        emp.mentee = menteeModel
    }
    
    employee.append(emp)
}

class IOS_04 {

    func addMentor(id: String, mentor: Mentor) -> Void{
        for emp in employee {
            if emp.idUser == id {
                if emp.mentor != nil {
                    print("Emp had a mentor")
                }else{
                    emp.addMenter(menter: mentor)
                    if let name = emp.mentor?.name {
                        print("Add success mentee \(name)")
                    }
                }
            }
        }
    }
    
    func addMentee(id: String, mentee: Mentee) -> Void {
        for emp in employee {
            if emp.idUser == id {
                if emp.mentee != nil {
                    print("Emp had a mentee")
                }else{
                    emp.addMentee(mentee: mentee)
                    if let name = emp.mentee?.name {
                        print("Add success mentee \(name)")
                    }
                }
            }
        }
    }
    
    func delMentor(id: String) -> Void{
        for emp in employee {
            if emp.idUser == id {
                if emp.mentor != nil {
                    if let name = emp.mentor?.name {
                        print("Delete mentor \(name)")
                    }
                    emp.delMenter()
                }else{
                    print("Emp had no mentor")
                }
            }
        }
    }
    
    func delMentee(id: String) -> Void {
        for emp in employee {
            if emp.idUser == id {
                if emp.mentee != nil {
                    if let name = emp.mentee?.name {
                        print("Delete mentee \(name)")
                    }
                    emp.delMentee()
                }else{
                    print("Emp had no mentee")
                }
            }
        }
    }
    
    func updateMentor(id: String, name: String) -> Void {
        for emp in employee {
            if emp.idUser == id {
                if emp.mentor != nil {
                    emp.updateNameMentor(name: name)
                    if let name = emp.mentor?.name{
                        print("Updated mentor \(name)")
                    }
                }else{
                    print("Emp had no mentor")
                }
            }
        }
    }
    
    func updateMentee(id: String, name: String) -> Void {
        for emp in employee {
            if emp.idUser == id {
                if emp.mentee != nil {
                    emp.updateNameMentee(name: "Tran Hoang Long")
                    if let name = emp.mentee?.name{
                        print("Updated mentee \(name)")
                    }
                }else{
                    print("Emp had no mentee")
                }
            }
        }
    }
}



let id = "id089"
let ios04 =  IOS_04()

ios04.delMentor(id: id)
ios04.delMentee(id: id)

let mentee = Mentee(id: "2", name: "Hue C", position: "ReactNative Developer", age: 16)
let mentor = Mentor(id: "1", name: "Long", position: "Android Developer", age: 16)
ios04.addMentee(id: id,mentee: mentee)
ios04.addMentor(id: id,mentor: mentor)

ios04.updateMentor(id: id, name: "Vu Van Hanh")
ios04.updateMentee(id: id, name: "Tran Hoang Long")
