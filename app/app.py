import findspark 
findspark.init()

import pyspark 
from pyspark.sql import SparkSession
from flask import Flask, jsonify

spark = SparkSession.builder \
   .appName("GoldenLine Pyspark") \
   .getOrCreate()
   ##.config("spark.ui.enable", "true") \

app = Flask(__name__)

@app.route('/')
def pyspark_app():
   data = [("Hello world",)]
   df = spark.createDataFrame(data, ["message"])
   df.show()
   json_data = df.toJSON().collect()
   return jsonify(json_data)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
    
    
    

