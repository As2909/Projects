import numpy as np
import pickle
import streamlit as st

std_scaler = pickle.load(open("C:/Users/sharma/Downloads/scaler.sav", "rb"))
loaded_model = pickle.load(open("C:/Users/sharma/Downloads/trained_model.sav", "rb"))


def diabetics_prediction(input_data):
    # change the input_data as numpy array
    input_array = np.asarray(input_data)

    # reshape the array as we predicting for one instance
    input_reshaped = input_array.reshape(1, -1)

    # standardize the input data
    std_data = std_scaler.transform(input_reshaped)

    prediction = loaded_model.predict(std_data)

    if (prediction[0] == 0):
        return "The person is not diabetic"
    else:
        return "The person is diabetic"

if __name__=="__main__":
    # Giving the Title
    st.title("Diabetes Prediction Web App")

    # Getting the input data from the user
    Pregnancies = st.text_input("Number of Pregancies")
    Glucose = st.text_input("Glucose Level")
    BloodPressure = st.text_input("Blood Pressure value")
    SkinThickness = st.text_input("SkinThickness value")
    Insulin = st.text_input("Insulin Level: ")
    BMI = st.text_input("BMI value")
    DiabetesPedigreeFunction = st.text_input("Diabetes Pedigree Function value")
    Age = st.text_input("Age of the Person")
    
    # Code for Prediction
    diagnosis = ""

    # Creating a button for Prediction
    if st.button("Diabetes Test Result"):
        diagnosis = diabetics_prediction([Pregnancies,Glucose,BloodPressure,SkinThickness,Insulin,BMI,DiabetesPedigreeFunction,Age])

    st.success(diagnosis)