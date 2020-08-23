//
//  LasVegasViewController.swift
//  DatePickerPractice
//
//  Created by Tai Chin Huang on 2020/8/18.
//

import UIKit

class LasVegasViewController: UIViewController {

    //連線Outlet物件ImageView/datePicker/dateLabel/dateSlider
    @IBOutlet weak var timeLapseImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateSlider: UISlider!
    //設定變數在 @IBAction func yearChangeSlider 中使用
    var sliderNumber = 0
    //設定變數在 func compare和@IBAction func autoTimer 中使用
    var imageNumber = 0
    //讀取系統日期
    let dateformatter = DateFormatter()
    //利用Array對應Assets圖片名稱
    let image = [1984, 1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time() // 讓系統開始讀取時間執行比對
        dateformatter.dateFormat = "yyyy/mm/dd"
        // Do any additional setup after loading the view.
    }
    
    //利用 switch 與 image array 取元件的對應 抓取日期與文字的呈現
    //以下三個 func 均與 autoSwitch 的作用有關。尤其與 timer()搭配的應用
    var dateString : String = ""
    func choosePicture (num1 : Int){
        switch num1 {
        case 0:
            dateString = "1984/01/01"
//            dateString = "1984/01/20"
        case 1:
            dateString = "1985/01/01"
        case 2:
            dateString = "1986/01/01"
        case 3:
            dateString = "1987/01/01"
        case 4:
            dateString = "1988/01/01"
        case 5:
            dateString = "1989/01/01"
        case 6:
            dateString = "1990/01/01"
        case 7:
            dateString = "1991/01/01"
        case 8:
            dateString = "1992/01/01"
        case 9:
            dateString = "1993/01/01"
        case 10:
            dateString = "1994/01/01"
        case 11:
            dateString = "1995/01/01"
        case 12:
            dateString = "1996/01/01"
        case 13:
            dateString = "1997/01/01"
        case 14:
            dateString = "1998/01/01"
        case 15:
            dateString = "1999/01/01"
        case 16:
            dateString = "2000/01/01"
        case 17:
            dateString = "2001/01/01"
        case 18:
            dateString = "2002/01/01"
        case 19:
            dateString = "2003/01/01"
        case 20:
            dateString = "2004/01/01"
        case 21:
            dateString = "2005/01/01"
        case 22:
            dateString = "2006/01/01"
        case 23:
            dateString = "2007/01/01"
        case 24:
            dateString = "2008/01/01"
        case 25:
            dateString = "2009/01/01"
        case 26:
            dateString = "2010/01/01"
        case 27:
            dateString = "2011/01/01"
        case 28:
            dateString = "2012/01/01"
        case 29:
            dateString = "2013/01/01"
        case 30:
            dateString = "2014/01/01"
        case 31:
            dateString = "2015/01/01"
        case 32:
            dateString = "2016/01/01"
        case 33:
            dateString = "2017/01/01"
        case 34:
            dateString = "2018/01/01"
        default:
            dateString = "1984/01/01"
        }
        let date = dateformatter.date(from: dateString)
        datePicker.date = date!
        
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let year = dateComponents.year!
        dateLabel.text = "\(year)"
    }
    //啟動時間timer的寫法
    var timer : Timer?
    func time () {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.compare()
        })
    }
    //利用 if else 比較陣列圖片，用在 @IBAction func autoTimer 上
    func compare () {
        if imageNumber >= image.count {
            imageNumber = 0
            choosePicture(num1: imageNumber)
            timeLapseImageView.image = UIImage(named: String(image[imageNumber]))
        } else {
            choosePicture(num1: imageNumber)
            timeLapseImageView.image = UIImage(named: String(image[imageNumber]))
        }
        dateSlider.value = Float(imageNumber)
        imageNumber += 1
    }
    //讓使用者可以改變日期後對應image/label/slider的更改
    @IBAction func yearChangeDatePicker(_ sender: UIDatePicker) {
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let year = dateComponents.year!
        let pictureDate = "\(year)"
        timeLapseImageView.image = UIImage(named: pictureDate)
        dateSlider.value = Float(year - 1984)
        dateLabel.text = "\(year)"
    }
    //滑動slider後使image/label/datapicker的更改
    @IBAction func yearChangeSlider(_ sender: UISlider) {
        sender.value = round(sender.value)
        let newDate = DateComponents(calendar: Calendar.current, year: image[sliderNumber]).date
        datePicker.date = newDate!
        sender.value.round()
        sliderNumber = Int(dateSlider.value)
        dateLabel.text = String(image[sliderNumber])
//        timeLapseImageView.image = UIImage(named: "\(Int(dateSlider.value))")
        timeLapseImageView.image = UIImage(named: String(image[sliderNumber]))
    }
    //autoSwitch的寫法
    @IBAction func autoTimer(_ sender: UISwitch) {
        if sender.isOn {
            time()
            imageNumber = sliderNumber
            dateSlider.value = Float(imageNumber)
        } else {
            timer?.invalidate()
        }
    }
    
    //程式結束執行後 要 disable timer
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
