# Stereo_VO
**Authors:**
[Zhang Handuo](hzhang032@e.ntu.edu.sg), [Raul Mur-Artal](http://webdiis.unizar.es/~raulmur/) ([ORBSLAM2](https://github.com/raulmur/ORB_SLAM2)), and [Dorian Galvez-Lopez](http://doriangalvez.com/) ([DBoW2](https://github.com/dorian3d/DBoW2))

**Current version:** 1.0.0

Stereo_VO is a real-time VO library for **Stereo** cameras that computes the camera trajectory and a sparse 3D reconstruction. It is able to detect loops and relocalize the camera in real time.

#####Videos showing ORB-SLAM2:
<a href="http://www.youtube.com/watch?feature=player_embedded&v=dF7_I2Lin54
" target="_blank"><img src="http://img.youtube.com/vi/dF7_I2Lin54/0.jpg"
alt="Tsukuba Dataset" width="240" height="180" border="10" /></a>
<a href="http://www.youtube.com/watch?feature=player_embedded&v=51NQvg5n-FE
" target="_blank"><img src="http://img.youtube.com/vi/51NQvg5n-FE/0.jpg"
alt="KITTI Dataset" width="240" height="180" border="10" /></a>
<a href="http://www.youtube.com/watch?feature=player_embedded&v=LnbAI-o7YHk
" target="_blank"><img src="http://img.youtube.com/vi/LnbAI-o7YHk/0.jpg"
alt="TUM RGBD Dataset" width="240" height="180" border="10" /></a>
<a href="http://www.youtube.com/watch?feature=player_embedded&v=MUyNOEICrf8
" target="_blank"><img src="http://img.youtube.com/vi/MUyNOEICrf8/0.jpg"
alt="EuRoC Dataset (V1_02, V1_03)" width="240" height="180" border="10" /></a>
<a href="http://www.youtube.com/watch?feature=player_embedded&v=xXt90wZejwk
" target="_blank"><img src="http://img.youtube.com/vi/xXt90wZejwk/0.jpg"
alt="EuRoC Dataset (V1_02, V1_03)" width="240" height="180" border="10" /></a>

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

#3. Building ORB-SLAM2 library and TUM/KITTI examples

Clone the repository:
```
git clone https://github.com/christlurker/VO_ugv.git ORB_SLAM2
```

We provide a script `build.sh` to build the *Thirdparty* libraries and *ORB-SLAM2*. Please make sure you have installed all required dependencies (see section 2). Execute:
```
cd ORB_SLAM2
chmod +x build.sh
./build.sh
```

This will create **libORB_SLAM.so**  at *lib* folder.


#4. ROS Examples

### Building the nodes for mono, stereo
1. Add the path including *Examples/ROS/ORB_SLAM2* to the ROS_PACKAGE_PATH environment variable. Open .bashrc file and add at the end the following line. Replace PATH by the folder where you cloned ORB_SLAM2:

  ```
  export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:PATH/ORB_SLAM2/Examples/ROS
  ```

2. Go to *Examples/ROS/ORB_SLAM2* folder and execute:

  ```
  mkdir build
  cd build
  cmake .. -DROS_BUILD_TYPE=Release
  make -j
  ```

### Running Monocular Node
For a monocular input from topic `/camera/image_raw` run node ORB_SLAM2/Mono. You will need to provide the vocabulary file and a settings file. See the monocular examples above.

  ```
  rosrun ORB_SLAM2 Mono PATH_TO_VOCABULARY PATH_TO_SETTINGS_FILE
  ```

### Running Stereo Node
For a stereo input from topic `/camera/left/image_raw` and `/camera/right/image_raw` run node ORB_SLAM2/Stereo. You will need to provide the vocabulary file and a settings file. If you **provide rectification matrices** (see Examples/Stereo/EuRoC.yaml example), the node will recitify the images online, **otherwise images must be pre-rectified**.

  ```
  rosrun ORB_SLAM2 Stereo PATH_TO_VOCABULARY PATH_TO_SETTINGS_FILE ONLINE_RECTIFICATION
  ```

**Example**: Download a rosbag (e.g. V1_01_easy.bag) from the EuRoC dataset (http://projects.asl.ethz.ch/datasets/doku.php?id=kmavvisualinertialdatasets). Open 3 tabs on the terminal and run the following command at each tab:
  ```
  roscore
  ```

  ```
  rosrun ORB_SLAM2 Stereo Vocabulary/ORBvoc.txt Examples/Stereo/EuRoC.yaml true
  ```

  ```
  rosbag play --pause V1_01_easy.bag /cam0/image_raw:=/camera/left/image_raw /cam1/image_raw:=/camera/right/image_raw
  ```

Once ORB-SLAM2 has loaded the vocabulary, press space in the rosbag tab. Enjoy!. Note: a powerful computer is required to run the most exigent sequences of this dataset.
