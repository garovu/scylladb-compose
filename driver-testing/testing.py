from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider
import ssl


def test_ssl_connection(host, port, username, password):
    ssl_context = ssl.create_default_context()

    # Disable SSL certificate validation
    ssl_context.check_hostname = False
    ssl_context.verify_mode = ssl.CERT_NONE

    auth_provider = PlainTextAuthProvider(username=username, password=password)

    cluster = Cluster(
        [host],
        port=port,
        auth_provider=auth_provider,
        ssl_context=ssl_context
    )

    try:
        cluster.connect()
        print("SSL connection successful!")
    except Exception as e:
        print("SSL connection failed:", str(e))
    finally:
        cluster.shutdown()


# Replace these values with your ScyllaDB server's details
host = '10.17.1.61'
port = 9042
username = 'cassandra'
password = 'cassandra'

test_ssl_connection(host, port, username, password)
