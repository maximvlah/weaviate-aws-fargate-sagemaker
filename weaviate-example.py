import os
import weaviate
import weaviate.classes as wvc

weaviate_url = os.getenv("WEAVIATE_IP")

client = weaviate.connect_to_custom(
    http_host=weaviate_url,
    http_port="8080",
    http_secure=False,
    grpc_host=weaviate_url,
    grpc_port="50051",
    grpc_secure=False
)

collection = client.collections.create(
    name="TestCollection",
    properties=[
        wvc.config.Property(
            name="title",
            data_type=wvc.config.DataType.TEXT
        )
    ]
)
print("Created collection.")
collections = client.collections.list_all()
print(collections)
client.close()