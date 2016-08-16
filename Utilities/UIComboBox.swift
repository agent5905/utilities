//
//  UIComboBox.swift
//  Utilities
//
//  Created by Daniel Garcia on 6/29/16.
//  Copyright © 2016 Daniel Garcia. All rights reserved.
//

import UIKit

enum UIComboBoxStyle: Int {
    case DropDownComboBox = 0
    case SimpleComboBox = 1
    case DropDownList = 2
}

@IBDesignable class UIComboBox: UITextField, UITableViewDataSource, UITableViewDelegate {
    
    // *** Public IB Properties ***
    @IBInspectable var dropDownHeight:CGFloat = 100.0
    @IBInspectable var displayArrow:Bool = true {
        didSet{
            
        }
    }
    

    // *** Private Properties ***
    private let cornerRadius:CGFloat = 5.0
    private var listVisible:Bool = false
    private let borderWith:CGFloat = 0.5
    private var borderColor:CGColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0).CGColor//UIColor.lightGrayColor().CGColor
        //UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0).CGColor
    
    
    // *** Public Properties ***
    public var sorted:Bool = false
    public var displayButton:Bool = true
    
    
    // *** Private Variables ***
    let arrowView = UIView()
    let comboBoxListView = UITableView()
    private var tapGesture :UITapGestureRecognizer!
    
    // *** Public Variables ***
    public var items:[String] = []
    public var listIndex:Int = -1
    public var listCount = 0
    public var selText:String = ""
    public var notificationCenter = NSNotificationCenter.defaultCenter()
    
    
    // *** Public Events ***
    public let ComboBoxTextChangedNotification = "ComboBoxTextChangedNotification"
    public let ComboBoxSelectedIndexChangedNotification = "ComboBoxSelectedIndexChangedNotification"
    public let ComboBoxGotFocusNotification = "ComboBoxGotFocusNotification"
    public let ComboBoxLostFocusNotification = "ComboBoxLostFocusNotification"
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    
    func setup(){
        super.clipsToBounds = false
        tapGesture = UITapGestureRecognizer(target: self, action: "comboBoxButtonTapped")
        drawArrow()
        drawList()
        
    }
    
    func drawArrow(){
        
        arrowView.frame = CGRectMake(self.frame.width - self.frame.height, 0.0 , self.frame.height, self.frame.height)
        arrowView.backgroundColor = UIColor.lightGrayColor()
        //arrowView.layer.cornerRadius = 5.0
    
        
        let buttonMaskLayer = CAShapeLayer()
        buttonMaskLayer.frame = arrowView.bounds
        buttonMaskLayer.path = UIBezierPath(roundedRect: arrowView.bounds, byRoundingCorners: [.TopRight, .BottomRight], cornerRadii: CGSize(width: 5.0, height: 5.0)).CGPath
        arrowView.layer.mask = buttonMaskLayer
        
        
        let xPos:CGFloat = 15.0
        let yPos:CGFloat = 20.0
        let size:CGFloat = 7.5
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, xPos, yPos)
        
        CGPathAddLineToPoint(path, nil, xPos + size, yPos - size)
        CGPathAddLineToPoint(path, nil, xPos - size, yPos - size)
        CGPathAddLineToPoint(path, nil, xPos, yPos)
        
        let triangle = CAShapeLayer()
        triangle.frame = arrowView.bounds
        triangle.path = path
        triangle.lineWidth = 0.5
        triangle.strokeColor = UIColor.darkGrayColor().CGColor
        triangle.fillColor = UIColor.darkGrayColor().CGColor
        
        arrowView.layer.insertSublayer(triangle, atIndex: 0)
        
        
        self.addSubview(arrowView)
        
        
        arrowView.addGestureRecognizer(tapGesture)
    }
    
    func drawList(){
        comboBoxListView.frame = CGRectMake(0.0, self.frame.height + 3.0, self.frame.width, 100.0)
        
        comboBoxListView.layer.cornerRadius = self.cornerRadius
        comboBoxListView.layer.borderWidth = self.borderWith
        comboBoxListView.layer.borderColor = self.borderColor
        comboBoxListView.hidden = !listVisible
        
        comboBoxListView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ComboBoxTableCell")
        comboBoxListView.delegate = self
        comboBoxListView.dataSource = self
        
        self.addSubview(comboBoxListView)
        
        
        
        
    }
    
    // *** Private Methods ***
    internal func comboBoxButtonTapped() {
        if !listVisible {
            listVisible = true
            showList()
            
        }else{
            listVisible = false
            hideList()
        }
    }
    
    private func showList() {
        print("showList")
        
        UIView.animateWithDuration(0.5, animations: {
            self.comboBoxListView.hidden = !self.listVisible
            self.comboBoxListView.alpha = 1.0
        })
    }
    
    private func hideList() {
        print("hideList")
        UIView.animateWithDuration(0.5, animations: {
            self.comboBoxListView.alpha = 0.0
        }, completion: { (value: Bool) in
             self.comboBoxListView.hidden = !self.listVisible
        })
    }
    
    // *** Public Methods ***
    internal func add(item:String) {
        items.append(item)
    }
    
    internal func remove(index:Int) {
        items.removeAtIndex(index)
    }
    
    internal func clear() {
        items.removeAll()
    }
    
    
    // *** Events ***
    
    private func comboBoxTextChanged(selectedIndex:Int, selectedText: String) -> Void {
        self.listIndex = selectedIndex
        self.text = selectedText
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ComboBoxCell") as UITableViewCell!
        
        if cell == nil {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ComboBoxCell")
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ComboBoxCell")
        }
        
        print(items.count)
        print(self.items[indexPath.row])
        cell.textLabel?.text = self.items[indexPath.row]
        cell.textLabel?.font = self.font
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}



class ComboBoxTableViewController: UITableViewController {
    
    
    var comboBoxStyle:UIComboBoxStyle = UIComboBoxStyle.DropDownList
    
    
    
    //Events
    var itemSelected: ((selectedIndex:Int, selectedText: String) -> Void)?
    
    
    var items: [String] = [] {
        didSet{
            
        }
    }
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "ComboBoxTableCell")
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "ComboBoxTableCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    
    
}

