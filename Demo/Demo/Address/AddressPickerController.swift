import UIKit
import Utils_Tools
import Utils_Cache

class AddressPickerController: UIViewController {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var finishButton: UIButton!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    private var completion: ((_ code: Int) -> Void)?
    
    private var titles: [String] = [] //最后保存的地址 ["北京","朝阳区"...]
    private var selected: [Int] = [0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // 过渡动画
        containerView.transform = .init(translationX: 0, y: 400)
        UIView.beginAnimations("", context: nil)
        UIView.setAnimationDuration(0.3)
        containerView.transform = .identity
        UIView.commitAnimations()
    }
    
    private func setup() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        hide(true)
    }
    
    @IBAction func finishAction(_ sender: Any) {
        let code = recursion().last?.code ?? ""
        completion?(Int(code) ?? 0)
        hide(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        defer { super.touchesBegan(touches, with: event) }
        guard touches.first?.view == view else { return }
        hide(true)
    }
    
    static func instance(_ completion: @escaping (_ code: Int) -> Void) -> Self {
        let controller = instance()
        controller.completion = completion
        return controller
    }
    
    private static func instance() -> Self {
        return StoryBoard.main.instance()
    }
}

extension AddressPickerController {
    
    private func recursion(_ next: [Address.Model] = Address.list,
                           _ index: Int = 0,
                           _ result: [Address.Model] = []) -> [Address.Model] {
        guard selected.count > index else {
            return result
        }
        let address = next[selected[index]]
        guard let childs = address.children else {
            return result + [address]
        }
        return recursion(childs, index + 1, result + [address])
    }
}

// MARK: - UIPickerViewDelegate
extension AddressPickerController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.bounds.width / 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return Address.list[row].name
            
        case 1:
            return Address.list[safe: selected[0]]?
                .children?[row].name
            
        case 2:
            return Address.list[safe: selected[0]]?
                .children?[safe: selected[1]]?
                .children?[row].name
            
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selected[0] = row
            selected[1] = 0
            selected[2] = 0
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        case 1:
            selected[1] = row
            selected[2] = 0
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        case 2:
            selected[2] = row
            
        default:
            break
        }
    }
}

// MARK: - UIPickerViewDataSource
extension AddressPickerController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return selected.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return Address.list.count
            
        case 1:
            return Address.list[safe: selected[0]]?
                .children?.count ?? 0
            
        case 2:
            return Address.list[safe: selected[0]]?
                .children?[safe: selected[1]]?
                .children?.count ?? 0
            
        default:
            return 0
        }
    }
}

// MARK: - ShowChildControllerable
extension AddressPickerController: ShowChildControllerable {}

fileprivate extension Collection {

    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
