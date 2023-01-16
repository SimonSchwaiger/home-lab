SCRIPTDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cp -r $SCRIPTDIR/../../vars/ $SCRIPTDIR/app/
docker build -t configure_pc .
rm -rf $SCRIPTDIR/app/vars/
docker run --net=host configure_pc