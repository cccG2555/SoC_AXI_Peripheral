# SoC_AXI_Peripheral

## 📌 Project Overview
이 프로젝트는 AXI 인터페이스를 기반으로 SPI와 I2C 프로토콜의 Master/Slave 모듈을 직접 설계하고 통합 검증한 하드웨어 시스템입니다. C 프로그램을 이용하여 Microblaze CPU에서 AXI 통신을 거쳐 각 통신 프로토콜의 Master 모듈로 데이터를 전송하고 제어합니다. 특히, UVM 환경에서 타이밍 이슈를 해결하며 하드웨어 데이터 흐름과 설계의 완성도 및 검증의 중요성을 확인할 수 있었습니다.

## 🛠️ Protocols & Architecture

### 1. AXI Concept
* Advanced eXtensible Interface(AXI)는 고성능 Point-to-Point 통신 표준 프로토콜입니다.
* 5개의 독립적인 채널을 가지며, Burst 데이터 전송 및 Handshaking 방식을 사용합니다.
* 본 프로젝트에서는 AXI4-Lite 규격을 사용했습니다.

### 2. AXI + SPI Protocol
* **SPI Concept**
  * SPI(Serial Peripheral Interface)는 동기식 전이중(full-duplex) 4선식 시리얼 통신 프로토콜입니다.
  * 근거리 통신 환경에서 고속 데이터 교환을 위해 사용됩니다.
  * CPOL과 CPHA 값(0 또는 1)의 조합에 따라 4가지 모드의 타이밍(Rising/Falling edge 샘플링)을 지원합니다.
* **Design**
  * `cfg_reg`, `w_reg`, `r_reg` 레지스터를 포함하는 AXI Slave 모듈과 SPI Master 모듈이 연결됩니다.
  * GPIO 인터페이스를 통해 4개의 버튼, 7-segment, 8개의 스위치와 연결됩니다.
* **Implementation**
  * Basys-3 보드를 활용하여 Master와 Slave 환경을 구현했습니다.
  * Master의 U 버튼을 누르면 SPI 데이터 전송이 시작됩니다.
  * Master의 8개 스위치 입력 값은 MOSI 핀을 통해 전달되어 Slave의 FND(0-255)에 출력됩니다.
  * Slave의 8개 스위치 입력 값은 MISO 핀을 통해 전달되어 Master의 FND(0-255)에 출력됩니다.
  * SPI READ와 WRITE 작업이 동시에 수행됩니다.
* **Verification (UVM)**
  * UVM을 활용하여 1000회의 시퀀스를 생성해 Master와 Slave 간 동시 송수신(MOSI, MISO)을 검증했습니다.
  * 송신 데이터(`tx_data`)는 8비트 랜덤 값으로 생성되었으며, AXI 프로토콜을 통해 SPI Master를 제어했습니다.
  * Scoreboard를 통해 Master 및 Slave의 `tx_data`가 각각 상대방의 `rx_data`와 정확히 일치하는지(PASS/FAIL) 확인했습니다.
  * 특이한 패턴을 가진 값(0x00, 0xff, 0x55, 0xaa, 0x01, 0x80)과 각 범위(0x00~0xff)별 데이터 Coverage가 모두 검증되었습니다.

### 3. AXI + I2C Protocol
* **I2C Concept**
  * I2C(Inter-Integrated Circuit)는 동기식 반이중(half-duplex) 2선식(SDA, SCL) 시리얼 통신 프로토콜입니다.
  * 근거리 통신에 적합하며, Multi-master 및 Multi-slave 환경을 지원합니다.
* **Design**
  * `cmd_reg`, `tx_reg`, `rx_reg`, `sig_reg` 레지스터를 가지는 AXI Slave 모듈과 I2C Master 모듈이 연결된 형태입니다.
  * 10us 주기로 Interrupt를 발생시켜 10usec Up-counter를 증가시키는 Timer 기능이 포함되어 있습니다.
* **Implementation**
  * Basys-3 보드의 Master U 버튼을 사용하여 카운터를 Run/Stop 할 수 있습니다.
  * Master의 스위치 15번(`switch[15]`)을 조작하여 WRITE 모드와 READ 모드를 토글합니다.
  * Slave의 스위치 0번(`switch[0]`)을 통해 Slave 측 카운터를 활성화 또는 비활성화할 수 있습니다.
  * WRITE 모드에서는 Master의 카운터 값이 Master와 Slave 보드의 FND에 출력됩니다.
  * READ 모드에서는 Slave의 카운터 값이 Master와 Slave 보드의 FND에 출력됩니다.
* **Verification (UVM)**
  * 2000회의 시퀀스를 생성하여 랜덤하게 WRITE(Master → Slave) 또는 READ(Slave → Master)를 수행했습니다.
  * 송신 데이터(8-bit `tx_data`)와 연속 데이터 송수신 횟수(1~16회)를 모두 랜덤으로 생성하여 검증을 진행했습니다.
  * Scoreboard를 통해 WRITE 시 Master의 송신 데이터가 Slave의 수신 데이터와 일치하는지 검사했습니다.
  * READ 시에는 Slave의 송신 데이터가 Master의 수신 데이터와 일치하는지 확인하여 PASS/FAIL을 판별했습니다.
  * 데이터 값에 대한 특이 패턴 및 범위 Coverage와 더불어, 연속 데이터 송수신 횟수(1-8회, 9-16회)에 대한 Coverage도 완벽히 달성했습니다.

## 🔍 Trouble Shooting
* **AXI WSTRB** 이슈: 개발 및 검증 과정에서 발생한 AXI Write Strobe 관련 문제를 식별하고 해결하여 데이터 송수신의 안정성을 확보했습니다.
