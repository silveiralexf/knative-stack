# knative-stack

Local environment for experiments with the Knative stack.

This is still **a work in progress**, which means, things can break. For now
the only demo application is borrowed from Knative official documentation.

The goal however is playing around with it a bit and eventually trying things
out on my own set of examples.

## Local Setup

Various tooling and tasks are automated within the [Taskfile runner](https://github.com/go-task/task/).
Configurations are done inside [Taskfile.yml](Taskfile.yml) file.

A list of tasks available can be viewed with `task -l`, as shown below:

```sh
$ task -l
* default:                                 List all of the available commands
* down:                                    Delete k3d cluster resources.
* up:                                      Bootstraps Knative Serving+Eventing on K3D cluster with Istio and Certmanager
* camel-k:cli:install:                     Install Camel-K CLI
* camel-k:install:                         Install Camel-K Operator
* certmanager:install:                     install certmanager
* demo:backend:                            install demo bookstore app node server
* demo:database:                           install demo bookstore database
* demo:frontend:                           install demo bookstore app frontend
* demo:mlservive:badwordfilter:            install demo bookstore ML service bad-word-filter
* demo:mlservive:sentment:                 install demo bookstore ML service sentment analysis
* demo:sequence:                           install demo bookstore sequence
* demo:up:                                 install demo bookstore app
* istio:install:                           Install Istio
* istio:install:cli:                       Install Istio CLI
* istio:install:verify:                    Verify Istio install
* istio:setup:injection:                   Enable Istio sidecar injection on all namespaces by adding required label
* k3d:install:                             Install k3d cluster
* knative:cli:install:                     Install Knative CLI
* knative:eventing:broker:                 Installs  a default Channel (messaging) layer using Kafka
* knative:eventing:channel:                Installs a default Channel (messaging) layer using Kafka
* knative:eventing:install:                install knative-service
* knative:eventing:kafka:controller:       Installs Knative Kafka Operator
* knative:eventing:kafka:sink:             Install the Kafka Sink data plane
* knative:eventing:kafka:source:           IInstall the Apache Kafka Source
* knative:operator:install:                install
* knative:serving:install:                 install knative serving with default DNS and HPA extension
* knative:serving:install:dns:             install knative serving default DNS (sslip.io)
* knative:serving:install:hpa:             install knative serving HPA extension
* knative:serving:setup:peerauth:          Set PeerAuthentication to PERMISSIVE on knative-serving system namespace
```

This project enforces conventional commits and some further quality checks using
[pre-commit](https://pre-commit.com), to install hooks locally and test,
execute as per below:

```sh
$ task precommit
✅ Precommit hooks successfully updated
Configuring pre-commit
check for required tooling...............................................Passed
trim trailing whitespace.................................................Passed
fix end of files.........................................................Passed
check for added large files..............................................Passed
yamlfmt..................................................................Passed
```

## Run Locally

To bootstrap the local environment, execute the following:

```sh
task up
INFO[0000] portmapping '9443:443' targets the loadbalancer: defaulting to [servers:*:proxy agents:*:proxy]
INFO[0000] portmapping '3000:3000' targets the loadbalancer: defaulting to [servers:*:proxy agents:*:proxy]
INFO[0000] portmapping '8000:8000' targets the loadbalancer: defaulting to [servers:*:proxy agents:*:proxy]
INFO[0000] portmapping '8080:80' targets the loadbalancer: defaulting to [servers:*:proxy agents:*:proxy]
INFO[0000] Prep: Network
INFO[0000] Created network 'k3d-knative-stack'
INFO[0000] Created image volume k3d-knative-stack-images
INFO[0000] Creating node 'k3d-knative-stack-registry'
INFO[0000] Successfully created registry 'k3d-knative-stack-registry'
INFO[0000] Starting new tools node...
INFO[0000] Starting node 'k3d-knative-stack-tools'
INFO[0001] Creating node 'k3d-knative-stack-server-0'
INFO[0001] Creating node 'k3d-knative-stack-agent-0'
INFO[0001] Creating node 'k3d-knative-stack-agent-1'
INFO[0001] Creating node 'k3d-knative-stack-agent-2'
INFO[0001] Creating LoadBalancer 'k3d-knative-stack-serverlb'
INFO[0001] Using the k3d-tools node to gather environment information
INFO[0001] HostIP: using network gateway 192.168.192.1 address
INFO[0001] Starting cluster 'knative-stack'
INFO[0001] Starting servers...
INFO[0001] Starting node 'k3d-knative-stack-server-0'
#
# [...] Skipping logs just to keep things brief...
#
📦 Installing Camel-K...
Camel K installed in namespace bookstore
pod/camel-k-operator-644ffcc888-rk9qh condition met
✅ Camel-K installed successfully.
        |\
        | \
        |  \
        |   \
      /||    \
     / ||     \
    /  ||      \
   /   ||       \
  /    ||        \
 /     ||         \
/______||__________\
____________________
  \__       _____/
     \_____/

✔ Istio core installed ⛵️
✔ Istiod installed 🧠
✔ Ingress gateways installed 🛬
✔ Installation complete                                                                                                                                                                                                                       Made this installation the default for cluster-wide operations.
#
# [...] Skipping logs just to keep things brief...
#
Checked 14 custom resource definitions
Checked 2 Istio Deployments
✔ Istio is installed and verified successfully
```

Verify if the cluster is up and running with the following:

```sh
export KUBECONFIG=$(pwd)/.kubeconfig
kube-system        coredns-6799fbcd5-rtd2d                        1/1     Running     0          2m28s   10.42.0.2    k3d-knative-stack-agent-0    <none>           <none>
cert-manager       cert-manager-d894bbbd4-vxcgv                   1/1     Running     0          2m27s   10.42.2.3    k3d-knative-stack-agent-2    <none>           <none>
kube-system        local-path-provisioner-6c86858495-njqfc        1/1     Running     0          2m28s   10.42.2.2    k3d-knative-stack-agent-2    <none>           <none>
cert-manager       cert-manager-cainjector-5fd6444f95-zndm5       1/1     Running     0          2m27s   10.42.1.3    k3d-knative-stack-agent-1    <none>           <none>
cert-manager       cert-manager-webhook-869674f96f-4fc7p          1/1     Running     0          2m26s   10.42.1.2    k3d-knative-stack-agent-1    <none>           <none>
bookstore          camel-k-operator-644ffcc888-rk9qh              1/1     Running     0          2m24s   10.42.1.4    k3d-knative-stack-agent-1    <none>           <none>
kube-system        metrics-server-54fd9b65b-tmmzn                 1/1     Running     0          2m28s   10.42.3.2    k3d-knative-stack-server-0   <none>           <none>
istio-system       istiod-56bf468489-lqf7s                        1/1     Running     0          2m3s    10.42.0.3    k3d-knative-stack-agent-0    <none>           <none>
kube-system        svclb-istio-ingressgateway-cb1cb4c5-ffzxh      3/3     Running     0          113s    10.42.0.4    k3d-knative-stack-agent-0    <none>           <none>
kube-system        svclb-istio-ingressgateway-cb1cb4c5-mzxhl      3/3     Running     0          113s    10.42.3.3    k3d-knative-stack-server-0   <none>           <none>
kube-system        svclb-istio-ingressgateway-cb1cb4c5-mpkh7      3/3     Running     0          113s    10.42.2.4    k3d-knative-stack-agent-2    <none>           <none>
kube-system        svclb-istio-ingressgateway-cb1cb4c5-qflw2      3/3     Running     0          113s    10.42.1.5    k3d-knative-stack-agent-1    <none>           <none>
istio-system       istio-ingressgateway-b5ffdf7f-vsh5g            1/1     Running     0          113s    10.42.3.4    k3d-knative-stack-server-0   <none>           <none>
knative-serving    autoscaler-6985c5b458-24k6v                    1/1     Running     0          96s     10.42.1.6    k3d-knative-stack-agent-1    <none>           <none>
knative-serving    activator-7cbf6b7785-fk6c7                     1/1     Running     0          96s     10.42.3.5    k3d-knative-stack-server-0   <none>           <none>
knative-serving    webhook-6cd8bdbdc7-g592q                       1/1     Running     0          96s     10.42.2.6    k3d-knative-stack-agent-2    <none>           <none>
knative-serving    controller-7b4cc86f6f-8ps9x                    1/1     Running     0          96s     10.42.2.5    k3d-knative-stack-agent-2    <none>           <none>
knative-serving    net-istio-controller-5f7df96bb4-dkjw8          1/1     Running     0          94s     10.42.1.7    k3d-knative-stack-agent-1    <none>           <none>
knative-serving    net-istio-webhook-58bd6fb45f-jrbz4             1/1     Running     0          94s     10.42.1.8    k3d-knative-stack-agent-1    <none>           <none>
knative-serving    autoscaler-hpa-7c5c4444c5-j9hzb                1/1     Running     0          92s     10.42.1.9    k3d-knative-stack-agent-1    <none>           <none>
knative-eventing   job-sink-5467f887c6-2dl6t                      1/1     Running     0          88s     10.42.1.10   k3d-knative-stack-agent-1    <none>           <none>
knative-eventing   kafka-controller-84cf6b879d-q6g4p              1/1     Running     0          86s     10.42.2.9    k3d-knative-stack-agent-2    <none>           <none>
knative-eventing   eventing-webhook-7557cd4f7-pxrt4               1/1     Running     0          88s     10.42.3.6    k3d-knative-stack-server-0   <none>           <none>
knative-eventing   kafka-webhook-eventing-7947685759-jvccs        1/1     Running     0          86s     10.42.1.11   k3d-knative-stack-agent-1    <none>           <none>
knative-eventing   knative-kafka-storage-version-migrator-sdphg   0/1     Completed   0          83s     10.42.1.13   k3d-knative-stack-agent-1    <none>           <none>
knative-serving    default-domain-66rsg                           0/1     Completed   0          93s     10.42.2.7    k3d-knative-stack-agent-2    <none>           <none>
knative-eventing   kafka-controller-post-install-zmlbq            0/1     Completed   0          83s     10.42.1.12   k3d-knative-stack-agent-1    <none>           <none>
knative-eventing   eventing-controller-7895c8b565-mjtk7           1/1     Running     0          88s     10.42.2.8    k3d-knative-stack-agent-2    <none>           <none>
knative-eventing   kafka-broker-receiver-68846f4976-q9xzt         1/1     Running     0          80s     10.42.0.5    k3d-knative-stack-agent-0    <none>           <none>
knative-eventing   kafka-sink-receiver-6cbdd8cfd8-fvntx           1/1     Running     0          78s     10.42.1.14   k3d-knative-stack-agent-1    <none>           <none>
knative-eventing   kafka-channel-receiver-946f4d65-c646n          1/1     Running     0          84s     10.42.3.7    k3d-knative-stack-server-0   <none>           <none>
knative-eventing   kafka-broker-dispatcher-0                      1/1     Running     0          78s     10.42.2.10   k3d-knative-stack-agent-2    <none>           <none>
knative-eventing   kafka-channel-dispatcher-0                     2/2     Running     0          74s     10.42.3.8    k3d-knative-stack-server-0   <none>           <none>
```

To bootstrap the demo application, execute the following:

```sh
task demo:up
```

To clean-up, execute the following:

```sh
task down
Deleting cluster knative-stack
INFO[0000] Deleting cluster 'knative-stack'
INFO[0008] Deleting cluster network 'k3d-knative-stack'
INFO[0008] Deleting 1 attached volumes...
INFO[0008] Removing cluster details from default kubeconfig...
INFO[0008] Removing standalone kubeconfig file (if there is one)...
INFO[0008] Successfully deleted cluster knative-stack!
```

### License & Credits

This repository contains mostly configuration settings, therefore licensing
for the demo application and the components used here, can be referenced at the
following links from Knative official docs:

- [github.com/knative/docs](https://github.com/knative/docs)
- [knative.dev/docs/bookstore](https://knative.dev/docs/bookstore/disclaimer/)
