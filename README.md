# altro_cpp

A C++ implementation for the ALTRO algorithm. The intent of `altro_cpp` is for it to eventually be both useable as a library and developed within a self-contained environment through the use of a Dockerfile. For now, though, this repo will contain only a working implementation for a few examples utilizing MIT and Toyota Research Institute's Drake toolbox. The hope in including Drake is to use it for already established dynamical systems atop which ALTRO could be used for control, and/or develop new dynamical models for custom robots using Drake's API.

## Configuring the development environment
1. Navigate to to the `altro_cpp` directory.
2. Execute
```bash
./docker_scripts/create_environment_profile.sh
```
3. Open VSCode and click in the lower left corner to "Reopen in Container". This should pull the container from Dockerhub and open the development environment.
4. Begin developing.

## Setting up Drake
### Installing dependencies
First run
```bash
cd drake && \
   sudo ./setup/ubuntu/install_prereqs.sh -y
```
The password for the guest account is
```bash
guest
```
This will install all prerequisite dependencies for Drake.

### Building Drake
To build Drake using bazel, do

```bash
cd /workspaces/altro_cpp/drake
bazel-6.3.0 build //...
```
This may take a while. These instructions were adapted from https://drake.mit.edu/bazel.html#developing-drake-using-bazel. 

### Running Drake Examples
First follow the instructions at the following website for running the MeshCat LCM Display Server (MeLDiS): https://drake.mit.edu/pydrake/pydrake.visualization.meldis.html

To run the visualizer, execute
```bash
cd /workspaces/altro_cpp/drake
bazel-6.3.0 run //tools:meldis &
```
This will launch a visualizer within your default browser at
```bash
localhost:7000
```

Open a new terminal. We will use the Acrobot as an example and run the following to run its passive dynamics:

```bash
cd /workspaces/altro_cpp/drake
bazel-6.3.0 run //examples/acrobot:run_passive
```

Switching over to the browser window at `localhost:7000`, you should see a primitive rendering of what is basically a simulated double pendulum (an unactuated Acrobot).

### Drake tutorials and resources
Below are some good resources for Drake tutorials:
* https://github.com/guzhaoyuan/drake-tutorial

Drake API Docs:
* C++ API Documentation: https://drake.mit.edu/doxygen_cxx/index.html
* Python API Documentation: https://drake.mit.edu/pydrake/

If you need to convert from a mesh format to the better-supported mesh format for Drake (.obj), use https://www.meshlab.net/ .
