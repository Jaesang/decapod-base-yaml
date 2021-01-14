# decapod-base-yaml
This project provides an easy way to create/maintain complex YAML files using kustomize and kustomize plugin.  
It works with [decapod-site-yaml](https://github.com/openinfradev/decapod-site-yaml) which contain differences between each environment (_e.g. development, staging and production environment_).  

## Features
* `base-yaml` and `site-yaml` structure
  * `base-yaml` is containig YAML resources and [overlays](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#overlay).
  * `site-yaml` contains a [site value](docs/glossary#site-value) and [variant](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#variant).
* Qualified [product](docs/glossary.md#product)
  * LMA(Logging, Monitoring, Alert)
  * OpenStack
  * Cloud Console

## Documents
* [Quick start](docs/quickstart.md)
* [Concept](docs/concept.md)
* [Glossary](docs/glossary.md)
* [Contribution](docs/contribution.md)

## Example
### Layout 
An example of decapod-base-yaml:
```
 product
 ├── base
 │   ├── kustomization.yaml
 │   ├── resources.yaml
 │   └── site-values.yaml
 ├── image
 │   └── image-values.yaml 
 └── storage
     ├── ceph.yaml
     └── local-path.yaml
```

An example of decapod-site-yaml:
```
 product
 ├── site
 │   ├── kustomization.yaml
 │   ├── ceph.yaml
 │   └── site-values.yaml
 └── output
     └── product-manifest.yaml 
```

### Render a [variant](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#variant)

**Base**  
_decapod-base-yaml/lma/base/resources.yaml_:
```yaml
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: elasticsearch-operator
spec:
  chart:
    repository: https://openinfradev.github.io/hanu-helm-repo
    name: elasticsearch-operator
    version: 1.0.3
  releaseName: elasticsearch-operator
  targetNamespace: elastic-system
  values:
    elasticsearchOperator:
      nodeSelector: {} # TO_BE_FIXED
```

**Site**  
_decapod-site-yaml/lma/site/dev/site-values.yaml_:
```yaml
apiVersion: openinfradev.github.com/v1
kind: HelmValuesTransformer
metadata:
  name: site

global:
  nodeSelector:
    taco-lma: enabled

charts:
- name: elasticsearch-operator
  override:
    elasticsearchOperator.nodeSelector: $(nodeSelector)
```

**Variant** 
_decapod-site-yaml/lma/output/dev/lma-manifest.yaml_:
```yaml
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: elasticsearch-operator
spec:
  chart:
    repository: https://openinfradev.github.io/hanu-helm-repo
    name: elasticsearch-operator
    version: 1.0.3
  releaseName: elasticsearch-operator
  targetNamespace: elastic-system
  values:
    elasticsearchOperator:
      nodeSelector:
        taco-lma: enabled
```