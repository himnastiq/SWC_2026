# Computer Networks Lecture Notes

## Session 1: Introduction to Networking, Devices & OSI Model

---

### I. Fundamentals of Networking

#### 1. Network

- **Definition:** A group of interconnected autonomous computing devices configured to share resources, exchange data, and facilitate communication using common rules (protocols).
- **Key Components:**
  - **Hosts (End Systems):** Devices running applications (PCs, servers, smartphones).
  - **Transmission Media:** Physical paths carrying signals (Copper wires, fiber-optic cables, wireless radio).
  - **Connecting Devices:** Intermediary devices directing traffic (Hubs, switches, routers).
  - **Protocols:** Standardized rules governing data transmission (TCP/IP, HTTP).

#### 2. MAC Address (Physical Address)

- **Definition:** A globally unique, hardware-level identifier permanently burned into a Network Interface Card (NIC) by the manufacturer during production.
- **OSI Layer:** Data Link Layer (Layer 2).
- **Format:** 48-bit (6 bytes) hexadecimal format, usually separated by colons or hyphens (e.g., `00:1A:2B:3C:4D:5E`).
- **Scope:** Used strictly for local network delivery (within the same LAN segment).

#### 3. IP Address (Logical Address)

- **Definition:** A software-assigned logical address used to uniquely identify a device and locate its network position globally across interconnected networks.
- **OSI Layer:** Network Layer (Layer 3).
- **Format:** IPv4 (32-bit dotted-decimal, e.g., `192.168.1.1`) or IPv6 (128-bit hexadecimal, e.g., `2001:db8::ff00:42:8329`).
- **Scope:** Used for routing packets across different subnets and the global Internet.

#### 4. Summary Table: MAC Address vs. IP Address

| Comparison Feature      | MAC Address (Media Access Control)     | IP Address (Internet Protocol)               |
| :---------------------- | :------------------------------------- | :------------------------------------------- |
| **OSI Layer**           | Data Link Layer (Layer 2)              | Network Layer (Layer 3)                      |
| **Type**                | Hardcoded physical address (Permanent) | Software-defined logical address (Temporary) |
| **Size**                | 48 bits (6 octets)                     | 32 bits (IPv4) or 128 bits (IPv6)            |
| **Resolution Protocol** | ARP resolves IP to MAC                 | DNS / DHCP                                   |

---

### II. Core Network Devices & Operations

#### 1. Hub

- **Definition:** A basic, non-intelligent hardware device that connects multiple Ethernet devices in a star topology, operating as a multi-port repeater.
- **OSI Layer:** Layer 1 (Physical).
- **Operational Behavior:** Blind broadcasting. When a packet enters one port, the hub duplicates it and forwards it out to all other ports, regardless of the destination.
- **Key Characteristics:**
  - **Collision Domain:** A single shared collision domain. If two devices transmit at the same time, a collision occurs.
  - **Duplex:** Half-duplex only (devices cannot transmit and receive simultaneously).
  - **Efficiency:** Highly inefficient; wastes bandwidth and exposes traffic to all connected devices.

#### 2. Switch

- **Definition:** An intelligent network device that connects multiple local devices and uses hardware addresses (MAC addresses) to forward data link frames selectively to the correct destination port.
- **OSI Layer:** Layer 2 (Data Link).
- **Operational Behavior:** Unicasting via MAC table. It maintains a **CAM (Content Addressable Memory) Table** that maps MAC addresses to their corresponding physical ports. When a frame arrives, the switch looks up the destination MAC address and forwards it only to the target port.
- **Key Characteristics:**
  - **Collision Domain:** Every single port on a switch is a separate collision domain. Collisions are eliminated under full-duplex operation.
  - **Broadcast Domain:** A single broadcast domain (broadcasts from one port are sent to all other ports).
  - **Duplex:** Supports full-duplex (simultaneous transmission and reception).

#### 3. Router

- **Definition:** A specialized network device that forwards data packets between different computer networks using logical IP addressing and routing algorithms to choose the best path.
- **OSI Layer:** Layer 3 (Network).
- **Operational Behavior:** Routing via IP table. It reads destination IP addresses, references its **Routing Table**, and runs routing protocols (like OSPF or BGP) to determine the optimal path for packets.
- **Key Characteristics:**
  - **Collision Domain:** Each interface is a separate collision domain.
  - **Broadcast Domain:** Each interface is a separate broadcast domain (routers block Layer 2 broadcasts).
  - **Functionality:** Performs Network Address Translation (NAT) and packet filtering (firewall functions).

#### 4. Summary Table: Hub vs. Switch vs. Router

| Attribute             | Hub                  | Switch                | Router                     |
| :-------------------- | :------------------- | :-------------------- | :------------------------- |
| **OSI Layer**         | Layer 1 (Physical)   | Layer 2 (Data Link)   | Layer 3 (Network)          |
| **Address Used**      | None (Physical bits) | MAC Address           | IP Address                 |
| **Data Unit**         | Bits                 | Frames                | Packets                    |
| **Collision Domains** | 1 (Shared)           | Multiple (1 per port) | Multiple (1 per interface) |
| **Broadcast Domains** | 1 (Shared)           | 1 (Shared)            | Multiple (1 per interface) |
| **Duplex Mode**       | Half-duplex          | Full-duplex           | Full-duplex                |

---

### III. The OSI Reference Model

#### 1. OSI Model

- **Definition:** A 7-layer theoretical and structural standard developed by the ISO to describe, organize, and standardize the network communications process between heterogeneous computer systems.
- **Mnemonic (Top to Bottom):** **A**ll **P**eople **S**eem **T**o **N**eed **D**ata **P**rocessing
- **Layers:** Application (7) $\rightarrow$ Presentation (6) $\rightarrow$ Session (5) $\rightarrow$ Transport (4) $\rightarrow$ Network (3) $\rightarrow$ Data Link (2) $\rightarrow$ Physical (1)

#### 2. Detailed Layer Operations

##### Layer 7: Application Layer

- **Definition:** The top layer of the OSI model that serves as the entry point for software applications to access network capabilities.
- **Responsibilities:** Resource sharing, remote file access, directory services, and network management.
- **Protocols:** HTTP (Web), FTP (File transfer), SMTP (Email), DNS (Domain resolution).

##### Layer 6: Presentation Layer

- **Definition:** The layer that translates data formatting, syntax, and semantics between the network application and lower layers.
- **Responsibilities:** Data translation/formatting, data encryption/decryption (for security), and data compression.
- **Protocols/Standards:** SSL/TLS, ASCII, EBCDIC, JPEG, GIF.

##### Layer 5: Session Layer

- **Definition:** The layer responsible for establishing, managing, synchronizing, and terminating communication sessions between applications.
- **Responsibilities:** Dialogue control (half-duplex or full-duplex), session checkpointing and recovery.
- **Protocols:** NetBIOS, RPC (Remote Procedure Call), PPTP.

##### Layer 4: Transport Layer

- **Definition:** The layer that ensures reliable, end-to-end data delivery, error correction, and flow control between source and destination hosts.
- **Responsibilities:** Segmentation (breaking application data into segments), reassembly, flow control (preventing sender from overwhelming receiver), error control, and port-address multiplexing.
- **Protocols:**
  - **TCP (Transmission Control Protocol):** Connection-oriented, reliable, guarantees delivery and ordering.
  - **UDP (User Datagram Protocol):** Connectionless, lightweight, fast, no guarantees (best-effort).
- **Data Unit:** Segment.

##### Layer 3: Network Layer

- **Definition:** The layer responsible for establishing network paths, routing packets between different logical subnets, and managing logical IP addressing.
- **Responsibilities:** Logical addressing (assigning IP addresses) and path determination (routing protocols determining best path).
- **Protocols:** IPv4, IPv6, ICMP (ping), ARP, OSPF, BGP.
- **Devices:** Routers, Layer 3 switches.
- **Data Unit:** Packet.

##### Layer 2: Data Link Layer

- **Definition:** The layer that manages the transmission of frames across a single physical link and provides physical MAC addressing, flow control, and error detection.
- **Responsibilities:** Framing (packaging bits into frames), physical addressing (MAC), flow control, error detection (using FCS/CRC check).
- **Sublayers:**
  - **LLC (Logical Link Control):** Manages flow and error control, identifies network layer protocols.
  - **MAC (Media Access Control):** Controls access to physical transmission media (CSMA/CD or CSMA/CA).
- **Protocols:** Ethernet (802.3), Wi-Fi (802.11), PPP.
- **Devices:** Switches, Network Interface Cards (NICs), Bridges.
- **Data Unit:** Frame.

##### Layer 1: Physical Layer

- **Definition:** The bottom-most layer that physically transmits and receives raw, unstructured bit streams over physical media (cables, copper wires, fiber, or radio waves).
- **Responsibilities:** Electrical/optical signals conversion, physical topologies (star, bus), bit synchronization, transmission rate control.
- **Media/Hardware:** Coaxial cable, twisted pair (CAT6), fiber optics, RJ45 connectors.
- **Devices:** Hubs, Repeaters, Transceivers.
- **Data Unit:** Bits.