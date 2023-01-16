# Initial Setup for Pi

1. Set up Pi with Raspberry Pi OS
2. Clone home-lab Repository `/home/pi/git`
3. Create `secrets.yml` file in `./vars` similarly to `example_secrets.yml`
4. Run the `initialSetup.sh` script

The script will install Python 3, Ansible and setup `raspiPlaybook.yaml` to be run every time the pi starts. The playbook installs docker, updates the OS, updates the repository and starts docker containers located in `./containers`.