/* Connection pins:
Arduino     MARG MPU-9150
  A5            SCL
  A4            SDA
  3.3V          VCC
  GND           GND
*/

/////////////////////////////////////////////////////////////////////////////////////////
//
//  This file is part of MPU9150Lib
//
//  Copyright (c) 2013 Pansenti, LLC
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of 
//  this software and associated documentation files (the "Software"), to deal in 
//  the Software without restriction, including without limitation the rights to use, 
//  copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the 
//  Software, and to permit persons to whom the Software is furnished to do so, 
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all 
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
/////////////////////////////////////////////////////////////////////////////////////////

#include <Wire.h>
#include "I2Cdev.h"
#include "MPU9150Lib.h"
#include "CalLib.h"
#include <dmpKey.h>
#include <dmpmap.h>
#include <inv_mpu.h>
#include <inv_mpu_dmp_motion_driver.h>
#include <EEPROM.h>



#define  DEVICE_TO_USE    0

MPU9150Lib MPU;                                             
#define MPU_UPDATE_RATE  (20)
#define MAG_UPDATE_RATE  (10)
#define  MPU_MAG_MIX_GYRO_ONLY          0                   // just use gyro yaw
#define  MPU_MAG_MIX_MAG_ONLY           1                   // just use magnetometer and no gyro yaw
#define  MPU_MAG_MIX_GYRO_AND_MAG       10                  // a good mix value 
#define  MPU_MAG_MIX_GYRO_AND_SOME_MAG  50                  // mainly gyros with a bit of mag correction 

#define MPU_LPF_RATE   40
#define  SERIAL_PORT_SPEED  115200//velocidad del puerto serial

void setup()
{
  pinMode(2,INPUT);
  digitalWrite(2,HIGH);
  Serial.begin(SERIAL_PORT_SPEED);

  Wire.begin();
  MPU.selectDevice(DEVICE_TO_USE);                        
  MPU.init(MPU_UPDATE_RATE, MPU_MAG_MIX_GYRO_AND_MAG, MAG_UPDATE_RATE, MPU_LPF_RATE);  //empieza a trabajar la IMU
}

void loop()
{  
  
  if (MPU.read()) {                                        // get the latest data if ready yet

  
    Serial.print(MPU.m_dmpEulerPose[0]); //Serial.print(",");
    Serial.print(",");
    Serial.print(MPU.m_dmpEulerPose[1]); //Serial.print(",");
    Serial.print(",");
    Serial.print(MPU.m_dmpEulerPose[2]); //Serial.println(",");
    Serial.print(",");
    // se escribe los valores de posiciones
    Serial.println(digitalRead(2));
    Serial.println();
  }
}
