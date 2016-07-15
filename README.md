# Stereo_VO
**Authors:**
[Zhang Handuo](hzhang032@e.ntu.edu.sg), [Raul Mur-Artal](http://webdiis.unizar.es/~raulmur/) ([ORBSLAM2](https://github.com/raulmur/Stereo_VO)), and [Dorian Galvez-Lopez](http://doriangalvez.com/) ([DBoW2](https://github.com/dorian3d/DBoW2))

**Current version:** 1.0.0

Stereo_VO is a real-time VO library for **Stereo** cameras that computes the camera trajectory and a sparse 3D reconstruction. It is able to detect loops and relocalize the camera in real time.

###Related Publications:

[1] Raúl Mur-Artal, J. M. M. Montiel and Juan D. Tardós. **ORB-SLAM: A Versatile and Accurate Monocular SLAM System**. *IEEE Transactions on Robotics,* vol. 31, no. 5, pp. 1147-1163, 2015. **[PDF](http://webdiis.unizar.es/~raulmur/MurMontielTardosTRO15.pdf)**

[2] Dorian Gálvez-López and Juan D. Tardós. **Bags of Binary Words for Fast Place Recognition in Image Sequences**. *IEEE Transactions on Robotics,* vol. 28, no. 5, pp.  1188-1197, 2012. **[PDF](http://doriangalvez.com/php/dl.php?dlp=GalvezTRO12.pdf)**


# Prerequisites
We have tested the library in **Ubuntu 14.04**, but it should be easy to compile in other platforms. A powerful computer (e.g. i7) will ensure real-time performance and provide more stable and accurate results.

## C++11 or C++0x Compiler
We use the new thread and chrono functionalities of C++11.

## Pangolin
We use [Pangolin](https://github.com/stevenlovegrove/Pangolin) for visualization and user interface. Dowload and install instructions can be found at: https://github.com/stevenlovegrove/Pangolin.

## OpenCV
We use [OpenCV](http://opencv.org) to manipulate images and features. Dowload and install instructions can be found at: http://opencv.org. **Required at leat 2.4.11. Tested with OpenCV 2.4.13**.

## Eigen3
Required by g2o (see below). Download and install instructions can be found at: http://eigen.tuxfamily.org. **Required at least 3.1.0**.

## BLAS and LAPACK
[BLAS](http://www.netlib.org/blas) and [LAPACK](http://www.netlib.org/lapack) libraries are requiered by g2o (see below). On ubuntu:
```
sudo apt-get install libblas-dev
sudo apt-get install liblapack-dev
```

## DBoW2 and g2o (Included in Thirdparty folder)
We use modified versions of the [DBoW2](https://github.com/dorian3d/DBoW2) library to perform place recognition and [g2o](https://github.com/RainerKuemmerle/g2o) library to perform non-linear optimizations. Both modified libraries (which are BSD) are included in the *Thirdparty* folder.

## ROS
A version Hydro or newer is needed.

# 1. Clone the repository:

```
git clone https://github.com/christlurker/VO_ugv.git Stereo_VO
```

# 2. ROS Examples

### Building the nodes for mono, stereo
1. Add the path including *Examples/ROS/Stereo_VO* to the ROS_PACKAGE_PATH environment variable. Open .bashrc file and add at the end the following line. Replace PATH by the folder where you cloned Stereo_VO:

  ```
  export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:PATH/Stereo_VO/Examples/ROS
  ```

2. Build stereo_VO library and ROS Examples

We provide a script `build.sh` to build the *Thirdparty* libraries and *stereo_VO*. Please make sure you have installed all required dependencies (see section 2). Execute:
```
cd Stereo_VO
chmod +x build.sh
./build.sh
```

This will create **libstero_VO.so**  at *lib* folder.

### Running Stereo Node
For a stereo input from topic `/camera/left/image_raw` and `/camera/right/image_raw` run node Stereo_VO/Stereo. You will need to provide the vocabulary file and a settings file. If you **provide rectification matrices** (see Examples/Stereo/EuRoC.yaml example), the node will recitify the images online, **otherwise images must be pre-rectified**.

  ```
  rosrun Stereo_VO Stereo
  ```

**Example**: A rosbag (e.g. V1_01_easy.bag). Open 3 tabs on the terminal and run the following command at each tab:
  ```
  roscore
  ```

  ```
  rosrun Stereo_VO Stereo
  ```

  ```
  rosbag play --pause V1_01_easy.bag /cam0/image_raw:=/camera/left/image_raw /cam1/image_raw:=/camera/right/image_raw
  ```

Once stereo_VO has loaded the vocabulary, press space in the rosbag tab. Enjoy!. Note: a powerful computer is required to run the most exigent sequences of this dataset.
