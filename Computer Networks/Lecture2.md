# Computer Networks Lecture Notes

## Session 2: CDN, DHCP (DORA), and APIPA

---

### I. CDN (Content Delivery Network)

#### 1. CDN

- **Definition:** A geographically distributed group of caching servers (Edge Servers or Points of Presence - PoPs) that work collaboratively to deliver web content quickly by serving it from a node closest to the client.
- **Core Objective:** To decrease spatial distance between content requests and content delivery, minimizing network latency.

#### 2. How a CDN Works

1.  **Request Redirection:** When a user requests content (e.g., an image, video, or script) from a website using a CDN, the DNS system redirects the user's request from the origin server to the closest CDN Edge Server.
2.  **Caching:** If the Edge Server has the requested file cached locally, it returns it immediately (cache hit).
3.  **Origin Fetching:** If the file is not cached (cache miss), the Edge Server fetches the content from the origin server, saves a copy locally for future requests, and delivers it to the user.

#### 3. Technical Benefits

- **Latency Reduction:** Dramatically decreases Round-Trip Time (RTT) by serving files from nearby edge servers.
- **Origin Offloading:** Relieves bandwidth consumption and processing load from the central origin server.
- **DDOS Mitigation:** Distributes massive traffic spikes and traffic-heavy attacks across multiple edge nodes, protecting the core infrastructure from crashing.

---

### II. DHCP (Dynamic Host Configuration Protocol)

#### 1. DHCP

- **Definition:** A client-server network protocol that dynamically and automatically configures IP addresses and other key configuration settings (like subnet mask, gateway, DNS) on IP devices on a network.
- **Architecture:** Client-Server model.
- **Ports:** Operates over **UDP**.
  - **DHCP Server:** Listens on port **67**.
  - **DHCP Client:** Listens on port **68**.

#### 2. The DORA Process (IP Address Leasing)

- **Definition (DORA):** The four-step handshake sequence (Discover, Offer, Request, Acknowledge) used by a client to query a DHCP server, receive an IP address lease, and bind its IP configuration.

##### DORA Steps:

##### 1. D - Discover (Client $\rightarrow$ Server)

- **Type:** Broadcast (Destination IP: `255.255.255.255`, Destination MAC: `FF:FF:FF:FF:FF:FF`).
- **Details:** The client has no IP address, so it sends a `DHCPDISCOVER` packet out on the local segment to identify any active DHCP servers.

##### 2. O - Offer (Server $\rightarrow$ Client)

- **Type:** Unicast or Broadcast (depends on server implementation and client flags).
- **Details:** Every DHCP server that receives the discovery message reserves an IP address from its configured IP address pool (scope) and sends a `DHCPOFFER` containing the proposed IP address, subnet mask, lease duration, and server identifier.

##### 3. R - Request (Client $\rightarrow$ Server)

- **Type:** Broadcast (Destination IP: `255.255.255.255`).
- **Details:** The client selects one offer (typically the fastest received) and broadcasts a `DHCPREQUEST` message. Broadcasting this notifies the selected server of acceptance, while letting all other DHCP servers know they can release their reserved addresses back into their pools.

##### 4. A - Acknowledgment (Server $\rightarrow$ Client)

- **Type:** Unicast or Broadcast.
- **Details:** The chosen DHCP server commits the lease information to its database and returns a `DHCPACK` (Acknowledgment) packet containing the final lease agreement and configuration settings. The client then binds the IP.

---

### III. APIPA (Automatic Private IP Addressing)

#### 1. APIPA

- **Definition:** An operating system utility (also known as **ABIPPA**) that automatically self-assigns a temporary link-local IP address to a client configured for DHCP when no active DHCP server responds to its requests.
- **Standard IP Range:** `169.254.0.1` to `169.254.255.254` (Reserved CIDR block: `169.254.0.0/16`).
- **Subnet Mask:** `255.255.0.0`.

#### 2. How it works

1.  **DHCP Failure:** A client is configured to obtain its IP address automatically via DHCP, but fails to receive a response during the DORA process (e.g., the DHCP server is offline, or there is a physical cabling disconnect).
2.  **Self-Assignment:** The client operating system selects a random IP address from the `169.254.0.0/16` range.
3.  **Conflict Detection:** The client sends out local **Gratuitous ARP (Address Resolution Protocol)** requests to check if another host on the local network segment is already using that address. If a conflict is detected, it selects another random address and repeats the process.

#### 3. Key Limitations

- **No Routing:** APIPA addresses do not assign a **default gateway**. Therefore, traffic cannot cross routers or reach external subnets.
- **Local Only:** Communication is strictly restricted to hosts on the same physical switch or LAN segment that also have APIPA addresses.
- **Internet Inaccessibility:** The host cannot access the WAN or the Internet.