-- Table for storing patients data
CREATE TABLE Patients (
patient_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
date_of_birth DATE NOT NULL,
gender ENUM ('Male', 'Female') NOT NULL,
contact_number VARCHAR(20) UNIQUE,
email VARCHAR(100) UNIQUE
);

-- Table for storing doctors data
CREATE TABLE Doctors (
doctor_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
specialization VARCHAR(100) NOT NULL,
contact_number VARCHAR(20) UNIQUE,
email VARCHAR(100) UNIQUE
);

-- Table for clinic appointment slots
CREATE TABLE AppointmentSlots (
slot_id INT AUTO_INCREMENT PRIMARY KEY,
doctor_id INT NOT NULL,
slot_date DATE NOT NULL,
slot_time TIME NOT NULL,
is_available BOOLEAN DEFAULT TRUE,
FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id)
);

-- Table for booking appointments
CREATE TABLE Appointments (
appointment_id INT AUTO_INCREMENT PRIMARY KEY,
slot_id INT NOT NULL,
patient_id INT NOT NULL,
booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
status ENUM ('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
FOREIGN KEY (slot_id) REFERENCES AppointmentSlots (slot_id),
FOREIGN KEY (patient_id) REFERENCES Patients (patient_id),
UNIQUE (slot_id) -- To ensure one patient per slot
);

-- Table for storing prescriptions
CREATE TABLE Prescriptions (
prescription_id INT AUTO_INCREMENT PRIMARY KEY,
appointment_id INT NOT NULL,
doctor_id INT NOT NULL,
patient_id INT NOT NULL,
prescription_date DATE NOT NULL,
medication TEXT NOT NULL,
notes TEXT,
FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id),
FOREIGN KEY (patient_id) REFERENCES Patients (patient_id)
);
