# Fundamental Containers

### Joel Berger

---

# Part 1:

## Applications

---

### Common Problems in DevOps

* Infrastructure as Code
  - Committable Deployment
  - Repeatable Deployment
* Consistent Development/Deployment
* Dependency Hell
* Process Isolation

===

### Infrastructure as Code

* Version controlled instructions
  - Building
  - Deploying
* Human readable
  - Replace (or augment) documentation
* Machine usable

===

### Consistent Deployment

* "It worked on my development system"
* "We have to deploy on a different OS"
* "We need to be sure we validate the EXACT production code pre-prod."

===

### Dependency Hell

* Multiple app need the same dependency but
  - Different versions
  - Incompatible libraries
  - Deeper/system dependencies

* Installation of a particular dependency is hard b/c
  - Priviledges
  - OS/packaging
  - Tricky

note: we'll see some examples of this later

===

### Process Isolation

Processes:
* Accessing/affecting each other
* Consuming shared resources
* Seeing/leaking private information

note: Again, we'll see some examples of this later but I mention this now because I'm actually going to start our story here ...

---

### (Incomplete) History<br>of Process Isolation

* Procedures
* User isolation/Time sharing (Unix, 1970s)
* Shared Hosting (1990s)
* FreeBSD Jails (2000)
* Hardware Virtualization/VMs (~2005)
* OS Isolation (namespace (2002), cgroups (2008))
* Docker (2013) / OCI (2015)

---

### Hardware Virtualization

* Good isolation
* Large overhead (Guest OS)
  - resources
  - maintenance
* Does not address IaC/Deployment
  - still need make/ansible/etc

---

### OS Isolation

* Kernel features:
  - namespaces - limits what process can see/use
  - cgroups - limits how much the process can use
* Kernel level, no guest OS

<small><https://stackoverflow.com/a/34825184/468327></small>

===

### OS Isolation: Namespaces

* Mounts (mnt)
* Process ID (pid)
* Network (net)
* Interprocess Communication (ipc)
* Hostname/Domain (uts)
* User ID (user)
* cgroup
* Time

note: example later

===

### OS Isolation: cgroups

* Resource limiting: memory, fs cache, i/o, cpu
* Prioritization: cpu, i/o
* Accounting (say for billing)
* Process control

note: again, example later

===

### OS Isolation

Not end-user friendly

* Create namespaces
* Populate the mounted main volume
* Create cgroup and set limits
* Start the process

---

### Containers

High-level abstraction for OS Isolation

* Start with sane defaults
* Dockerfile to populate the main volume
* Other resources via cli options at start

---

## Building an Image

===

### Application

<pre>
  <code
    class="javascript"
    data-url="public/ex/simple/app.js"
  ></code>
</pre>

===

### package.js (deps)

<pre>
  <code
    class="json"
    data-url="public/ex/simple/package.json"
  ></code>
</pre>

===

### Dockerfile

<pre>
  <code
    class="dockerfile"
    data-url="public/ex/simple/Dockerfile"
  ></code>
</pre>

===

### Using

* Build the image
```shell
$ docker build . -t simple
```

* Run a container
```shell
$ docker run --rm --name simple -d -p 8080:8080 simple 
```

===

### Useful Docker Commands

| Command | Result |
|----|----|
|` build`         | build image                        |
| `run`           |  start a new container from image  |
| `exec`          | attach to running container        |
| `system prune`  | cleanup old objects                |

===

### Useful Docker Commands

| Command | Result |
|----|----|
| `pull`         | get image from registry            |
| `push`         | push image to registry             |
| `login`        | login to registry                  |

---

### Layers

Each command in the Dockerfile

* Creates a layer
* Has a unique hash
* Is cachable if previous layers are unchanged

===

### Bad Caching

<pre>
  <code
    class="dockerfile"
    data-url="public/ex/simple/Dockerfile"
    data-line-numbers="|3|5"
  ></code>
</pre>

===

### Better Caching

<pre>
  <code
    class="dockerfile"
    data-url="public/ex/caching/Dockerfile"
    data-line-numbers="|3,5|7"
  ></code>
</pre>

---

### Multistage Dockerfile

<pre>
  <code
    class="dockerfile"
    data-url="public/ex/multistage/Dockerfile"
    data-line-numbers="|1-4|6-9"
  ></code>
</pre>

* Image is only 721kB!
* Has almost nothing but the application

---

# Part 2:

## Coordination

---

### Some Remaining Problems

* `docker` command arguments
* coordination of services

---

### Docker Compose

<pre>
  <code
    class="yaml"
    data-url="public/ex/wordpress/docker-compose.yaml"
    data-line-numbers="|4-8,14-15,18-20,26-31|10,17|11-13,22-24"
  ></code>
</pre>

---

## Examples

---

### Memory Protection

<pre>
  <code
    class="yaml"
    data-url="public/ex/oom/docker-compose.yaml"
    data-line-numbers="|14|15-23"
  ></code>
</pre>

---

### Filesystem Leaks

===

### An Application with very secret files

<pre>
  <code
    class="dockerfile"
    data-url="public/ex/traversal/Dockerfile.protected"
  ></code>
</pre>

===

### An Application with very bad filesystem access

<pre>
  <code
    class="dockerfile"
    data-url="public/ex/traversal/Dockerfile.unsafe"
  ></code>
</pre>

===

<pre>
  <code
    class="yaml"
    data-url="public/ex/traversal/docker-compose.yaml"
  ></code>
</pre>

---

### Last Remaining Problem

===

# Part 3:

## Production Deployment / Clustering

===

## ...

===

# Kubernetes

(Coming Soon!) <!-- .element: class="fragment" data-fragment-index="2" -->
