# Use IasCable to create a VPC and a Red Hat OpenShift cluster on IBM Cloud

The following list represents the modules which are referenced in the example [IBM ROKS Bill of Materials](https://github.com/cloud-native-toolkit/iascable#ibm-roks-bill-of-materials) for [IasCable](https://github.com/cloud-native-toolkit/iascable).

* [IBM VPC `ibm-vpc`](https://github.com/cloud-native-toolkit/terraform-ibm-vpc)
* [IBM VPC Subnets `ibm-vpc-subnets`](https://github.com/cloud-native-toolkit/terraform-ibm-vpc-subnets)
* [IBM Cloud VPC Public Gateway `ibm-vpc-gateways`](https://github.com/cloud-native-toolkit/terraform-ibm-vpc-gateways)
* [IBM OpenShift VPC cluster `ibm-ocp-vpc`](https://github.com/cloud-native-toolkit/terraform-ibm-ocp-vpc)

## Pre-requisites for the example

Following tools need to be installed on your local computer to follow the step by step instructions.

* Terraform
* Git

That is the cloud environment we will use.

* IBM Cloud

## Step by step example setup

### Step 1: Write the `Bill of Material` BOM file

```sh
nano my-vpc-roks-bom.yaml
```

Copy and past the following content intoo the `my-vpc-roks-bom.yaml` file.

```yaml
apiVersion: cloudnativetoolkit.dev/v1alpha1
kind: BillOfMaterial
metadata:
  name: my-ibm-vpc-roks
spec:
  modules:
    - name: ibm-vpc
    - name: ibm-vpc-subnets
    - name: ibm-vpc-gateways
    - name: ibm-ocp-vpc
      variables:
        - name: worker_count
          value: 1
```

### Step 2: Create the template based on `Bill of Material` BOM file

```sh
iascable build -i my-vpc-roks-bom.yaml
```
