import numpy as np
import pickle

std_scaler = pickle.load(open("C:/Users/sharma/Downloads/scaler.sav", "rb"))
loaded_model = pickle.load(open("C:/Users/sharma/Downloads/trained_model.sav", "rb"))

input_data = (0,137,40,35,168,43.1,2.288,33)

# change the input_data as numpy array
input_array = np.asarray(input_data)

# reshape the array as we predicting for one instance
input_reshaped = input_array.reshape(1, -1)

# standardize the input data
std_data = std_scaler.transform(input_reshaped)

prediction = loaded_model.predict(std_data)
print(prediction)

if (prediction[0] == 0):
  print("The person is not diabetic")
else:
  print("The person is diabetic")
