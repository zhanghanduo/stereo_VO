echo "Configuring and building Thirdparty/DBoW2 ..."

cd Thirdparty/DBoW2
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j8

cd ../../g2o

echo "Configuring and building Thirdparty/g2o ..."

mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j8

cd ../../../

echo "Uncompress vocabulary ..."

cd Vocabulary
tar -xf ORBvoc.txt.tar.gz
cd ..

echo "Configuring and building Stereo_VO ..."

mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j8

cd ../Examples/ROS/Stereo_VO/
mkdir build
cd build
cmake .. -DROS_BUILD_TYPE=Release
make -j8


# export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:/home/path/stereo_VO/Examples/ROS
