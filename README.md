# weaviate-aws-fargate

## NOTE: Running the setup.sh script more than once will break python module dependencies at this time.
## Creating a new notebook instance and re-running the full script is the recommended troubleshooting.

1. Clone this repository.
2. Use chmod to make the setup.sh script executable.
```
chmod 755 setup.sh
```
3. Run setup.sh.
```
./setup.sh
```
4. Record your weaviate IP address. It will be stored in the environment variable WEAVIATE_IP.
5. A sample python script is included in this repo, weaviate-example.py.