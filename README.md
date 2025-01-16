# Taskify

Taskify is a feature-rich task management app that helps users stay organized, manage their daily tasks efficiently, and improve productivity. With its intuitive user interface and powerful features like date-based task filtering, task creation with custom colors, and dark mode, Taskify is the ultimate app for personal task management.

---

## **✨ Features**

### **1. 📝 Task Management**
- Add new tasks with titles, descriptions, and custom colors.
- Assign specific dates to tasks for better organization.
- View tasks for a selected date using the date selector.
- Scrollable task list for easy navigation.

### **2. 🎨 Customization**
- Choose custom colors for each task card to visually categorize tasks.
- Adaptive text color for improved readability on light or dark task card backgrounds.

### **3. 🌙 Dark Mode**
- Toggle between light and dark themes for a comfortable user experience.
- Save the theme preference using SQLite for persistent settings.

### **4. ⏰ Time Management**
- Automatically record the time when a task is added.
- Display the task time on the home screen.

### **5. 🗑️ Task Deletion**
- Swipe left to delete a task from the home page.
- Confirm deletion with a Snackbar notification.

### **6. 💾 Data Persistence**
- Store tasks and user settings locally using SQLite for reliable offline access.
- Maintain tasks and theme preferences even after restarting the app.

---

## **🛠️ Technologies Used**

### **Frontend**
- **Flutter**: For creating a beautiful and responsive user interface.

### **Backend**
- **SQLite**: For storing tasks, user settings, and theme preferences locally.

---

## **🚀 Installation**

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/username/taskify.git
   ```

2. **Navigate to the Project Directory**:
   ```bash
   cd taskify
   ```

3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the App**:
   ```bash
   flutter run
   ```

---

## **📱 App Structure**

### **Key Directories**
- `lib/` - Contains all the Dart code for the app.
  - `features/auth/` - Login and signup functionality.
  - `features/home/` - Main task management screens and widgets.
  - `model/` - SQLite database helper for managing local data.
  - `constants/` - Utilities and reusable configurations.

---

## **📖 How to Use**

### **1. 🆕 Adding a New Task**
- Tap the **add (+)** icon on the home screen to open the task creation page.
- Enter the title and description.
- Select a date for the task using the date picker in the app bar.
- Choose a color for the task card.
- Tap the **Submit** button to save the task.

### **2. 📅 Viewing Tasks**
- Use the date selector on the home page to filter tasks by date.
- Scroll through the task list to view all tasks for the selected date.

### **3. 🗑️ Deleting a Task**
- Swipe a task to the left to delete it.
- A Snackbar notification will confirm the deletion.

### **4. 🌙 Toggle Dark Mode**
- Use the **switch** in the app bar on the home screen to toggle between light and dark mode.
- The selected theme is saved and restored when the app is reopened.

---

## **🎯 Future Enhancements**
- **🔔 Notifications**: Add reminders for tasks based on date and time.
- **🔄 Recurring Tasks**: Enable recurring tasks for daily, weekly, or monthly schedules.
- **📊 Priority Levels**: Allow users to set priority levels for tasks.
- **☁️ Cloud Sync**: Sync tasks across devices using cloud storage.

---

## **📸 Screenshots**
_Add screenshots of the app here (e.g., home page, add task page, etc.)._

---

## **🤝 Contributors**
- **Your Name** - [GitHub](https://github.com/yourusername)

Feel free to contribute by submitting issues or pull requests.

---

## **📜 License**
This project is licensed under the MIT License. See the `LICENSE` file for details.

