Return-Path: <stable+bounces-154710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8872ADF83B
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 22:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347251BC12CF
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 20:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1521CC64;
	Wed, 18 Jun 2025 20:58:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from constellation.wizardsworks.org (wizardsworks.org [24.234.38.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1A21B182;
	Wed, 18 Jun 2025 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.234.38.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280290; cv=none; b=NixHe8elo+B6x5uZZdmA8ITZ8ZE7bzsE60buwZaKwJvptvbL+Si9nWMtxKCGUInNwHh3NRgHCFRgln3lMm72Oe9sPguVSf36FVxZwXdS3+NylrjnJHB5Vvyh3YyHZYnHiLI5Evg0pMUm83nDlUAKShRTcBCoKM0TylNTZqw0mTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280290; c=relaxed/simple;
	bh=1k9VFCeT8i70/zfDjDKKK3w/a+2fyOY+onWIoGTobN8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mOEANE8fmlZ5MFZDeXppRkFlazzePhCucBAT2zikJZIqPpij9DYa8ODxBKNrziT261XbFMVCwtvjZWX93smIecANWC8ncUeSrYkGZDQtuHel31EFF2sjMONEFoPz4EPQE/RGa4y+CJR3ReLcMLMSDfilQya4G3GTgwfkrbhlyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org; spf=pass smtp.mailfrom=wizardsworks.org; arc=none smtp.client-ip=24.234.38.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizardsworks.org
Received: from mail.wizardsworks.org (localhost [127.0.0.1])
	by constellation.wizardsworks.org (8.18.1/8.18.1) with ESMTP id 55IKxecn005511;
	Wed, 18 Jun 2025 13:59:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Jun 2025 13:59:40 -0700
From: Greg Chandler <chandleg@wizardsworks.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
 <385f2469f504dd293775d3c39affa979@wizardsworks.org>
 <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com>
 <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
 <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com>
Message-ID: <a3d8ee993b73b826b537f374d78084ad@wizardsworks.org>
X-Sender: chandleg@wizardsworks.org
Content-Type: multipart/mixed;
 boundary="=_0b0e99b6138c62d90d0bbbbf1f94e876"

--=_0b0e99b6138c62d90d0bbbbf1f94e876
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

On 2025/06/17 11:22, Florian Fainelli wrote:
> (please no top posting)
> 
> On 6/17/25 11:19, Greg Chandler wrote:
>> 
>> Hmm...  I'm wondering if that means it's an alpha-only issue then, 
>> which would make this a much larger headache than it already is.
>> Also thank you for checking, I appreciate you taking the time.
>> 
>> I assume the those interfaces actually work right? (simple ping over 
>> that interface would be enough)  I posted in a subsequent message that 
>> mine do not appear to at all.
> 
> Oh yeah, they work just fine:
> 
> udhcpc: broadcasting discover
> [   19.197697] net eth0: Setting full-duplex based on MII#1 link 
> partner capability of cde1
> 
> # ping -c 1 192.168.254.123
> PING 192.168.254.123 (192.168.254.123): 56 data bytes
> 64 bytes from 192.168.254.123: seq=0 ttl=64 time=2.902 ms
> 
> --- 192.168.254.123 ping statistics ---
> 1 packets transmitted, 1 packets received, 0% packet loss
> round-trip min/avg/max = 2.902/2.902/2.902 ms
> 
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.03  sec  39.6 MBytes  33.1 Mbits/sec    0            
> sender
> [  5]   0.00-10.07  sec  39.8 MBytes  33.1 Mbits/sec receiver
> 
> 
>> 
>> My next step is to build that driver as a module, and see if it 
>> changes anything (I'm doubting it will).
>> Then after that go dig up a different adapter, and see if it's the 
>> network stack or the driver.
>> 
>> I've been hard pressed over the last week to get a lot of diagnosing 
>> time.
> 
> Let me know if I can run experiments, I can load any kernel version on 
> this Cobalt Qube2 meaning that bisections are possible.
> 
> Good luck!




I thought I replied to the whole list, not just the sender, sorry for 
the repeat....
(full config is attached)


As a module, the system booted up but did not probe the module.
This may be from a variety of issues, not limited to the fact I am still 
rolling this distro from scratch, and not all of the tools are 100% 
working yet.
I'm having some issues with gcc/gdb so I have a large number of 
debugging options turned on in the kernel as well.


When the module is loaded with insmod:

[  213.363172] tulip 0000:00:09.0: vgaarb: pci_notify
[  213.363172] tulip 0000:00:09.0: assign IRQ: got 29
[  213.363172] tulip 0000:00:09.0: enabling Mem-Wr-Inval
[  213.369031] tulip0: EEPROM default media type Autosense
[  213.369031] tulip0: Index #0 - Media 10baseT (#0) described by a 
21142 Serial PHY (2) block
[  213.369031] tulip0: Index #1 - Media 10baseT-FDX (#4) described by a 
21142 Serial PHY (2) block
[  213.370007] tulip0: Index #2 - Media 100baseTx (#3) described by a 
21143 SYM PHY (4) block
[  213.370007] tulip0: Index #3 - Media 100baseTx-FDX (#5) described by 
a 21143 SYM PHY (4) block
[  213.376843] net eth1: Digital DS21142/43 Tulip rev 65 at MMIO 
0xa120000, 08:00:2b:86:ab:b1, IRQ 29
[  213.377820] tulip 0000:00:09.0: vgaarb: pci_notify
[  213.377820] tulip 0000:00:0b.0: vgaarb: pci_notify
[  213.377820] tulip 0000:00:0b.0: assign IRQ: got 30
[  213.377820] tulip 0000:00:0b.0: enabling Mem-Wr-Inval
[  213.384656] tulip1: EEPROM default media type Autosense
[  213.384656] tulip1: Index #0 - Media 10baseT (#0) described by a 
21142 Serial PHY (2) block
[  213.384656] tulip1: Index #1 - Media 10baseT-FDX (#4) described by a 
21142 Serial PHY (2) block
[  213.384656] tulip1: Index #2 - Media 100baseTx (#3) described by a 
21143 SYM PHY (4) block
[  213.384656] tulip1: Index #3 - Media 100baseTx-FDX (#5) described by 
a 21143 SYM PHY (4) block
[  213.391492] net eth2: Digital DS21142/43 Tulip rev 65 at MMIO 
0xa121000, 08:00:2b:86:a8:5b, IRQ 30



root@bigbang:/lib/modules/6.12.12-SMP# mii-tool eth1
eth1: no link

root@bigbang:/lib/modules/6.12.12-SMP# mii-tool eth2
eth2: autonegotiation failed, link ok



When I pulled the plug I did not get the crash..
When I plugged it back in, I did not get a dmesg/kernel line for the 
link.



I bound the IP addresses to both, and did a ping test to the default 
gateway, resulting in:
(I promise the network is properly configured)

root@bigbang:/lib/modules/6.12.12-SMP# ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
 From 192.168.1.75 icmp_seq=1 Destination Host Unreachable
 From 192.168.1.75 icmp_seq=2 Destination Host Unreachable
 From 192.168.1.75 icmp_seq=3 Destination Host Unreachable



Upon pulling the cord out of the switch **after** the IP address was 
bound, we are back to this:
[  593.769227] ------------[ cut here ]------------
[  593.769227] WARNING: CPU: 0 PID: 33 at kernel/time/timer.c:1657 
__timer_delete_sync+0x10c/0x150
[  593.769227] Modules linked in: tulip
[  593.769227] CPU: 0 UID: 0 PID: 33 Comm: lock_torture_wr Not tainted 
6.12.12-SMP #1
[  593.769227]        fffffc0002aeba40 fffffc00011b0ac0 fffffc000032a4f0 
fffffc0000f8f181
[  593.769227]        0000000000000000 0000000000000000 fffffc000032a688 
fffffc000119c690
[  593.769227]        0000000000000000 fffffc0000f8f181 fffffc00003d297c 
fffffc000125c7e0
[  593.769227]        fffffffc0082f1c4 00000000efe4b99a fffffc00003d297c 
fffffc000b03b490
[  593.769227]        fffffc000b03b490 0000000000000000 fffffffff8668000 
fffffd000a120000
[  593.769227]        fffffc0000366888 fffffc000020ce00 fffffc000020ce00 
0000000000000008
[  593.769227] Trace:
[  593.769227] [<fffffc000032a4f0>] __warn+0x190/0x1a0
[  593.769227] [<fffffc000032a688>] warn_slowpath_fmt+0x188/0x240
[  593.769227] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
[  593.769227] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
[  593.769227] [<fffffc0000366888>] wakeup_preempt+0xb8/0xd0
[  593.769227] [<fffffc0000366950>] ttwu_do_activate.isra.0+0xb0/0x1a0
[  593.769227] [<fffffc0000369030>] try_to_wake_up+0x370/0x700
[  593.769227] [<fffffc0000e29470>] 
_raw_spin_unlock_irqrestore+0x20/0x40
[  593.769227] [<fffffc000036e1c4>] task_tick_fair+0x74/0x370
[  593.769227] [<fffffc00003d46dc>] enqueue_hrtimer.isra.0+0x5c/0xc0
[  593.769227] [<fffffc000037bc1c>] task_non_contending+0xcc/0x4f0
[  593.769227] [<fffffc00003a1a80>] __handle_irq_event_percpu+0x60/0x190
[  593.769227] [<fffffc000036d598>] 
sched_balance_update_blocked_averages+0xc8/0x2a0
[  593.769227] [<fffffc00003a1cb8>] handle_irq_event+0x68/0x110
[  593.769227] [<fffffc00003a8108>] handle_level_irq+0x108/0x240
[  593.769227] [<fffffc00003158e0>] handle_irq+0x70/0xe0
[  593.769227] [<fffffc0000320820>] dp264_srm_device_interrupt+0x30/0x50
[  593.769227] [<fffffc0000315af4>] do_entInt+0x1a4/0x200
[  593.769227] [<fffffc0000310d00>] ret_from_sys_call+0x0/0x10
[  593.769227] [<fffffc0000392164>] 
torture_spin_lock_write_delay+0x74/0x180
[  593.769227] [<fffffc00003d7cc8>] ktime_get+0x58/0x160
[  593.769227] [<fffffc0000317fd0>] read_rpcc+0x0/0x10
[  593.769227] [<fffffc0000317fd0>] read_rpcc+0x0/0x10
[  593.769227] [<fffffc0000430aa8>] stutter_wait+0x88/0x110
[  593.769227] [<fffffc0000391904>] lock_torture_writer+0x1d4/0x450
[  593.769227] [<fffffc00003918cc>] lock_torture_writer+0x19c/0x450
[  593.769227] [<fffffc000035a980>] kthread+0x150/0x190
[  593.769227] [<fffffc0000391730>] lock_torture_writer+0x0/0x450
[  593.769227] [<fffffc00003110d8>] ret_from_kernel_thread+0x18/0x20
[  593.769227] [<fffffc000035a830>] kthread+0x0/0x190

[  593.769227] ---[ end trace 0000000000000000 ]---



Adding some machine relevant stuff here (for the sake of being thorough)

The machine is a DEC DS10

root@bigbang:/lib/modules/6.12.12-SMP# lspci -vvv
00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA 
Bridge [Aladdin IV/V/V+] (rev c3)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort+ <MAbort+ >SERR- <PERR- INTx-
         Latency: 0

00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
         Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 
bytes
         Interrupt: pin A routed to IRQ 29
         Region 0: I/O ports at 8400 [size=128]
         Region 1: Memory at 0a120000 (32-bit, non-prefetchable) 
[size=1K]
         Expansion ROM at 0a000000 [disabled] [size=256K]
         Kernel driver in use: tulip
         Kernel modules: tulip

00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
         Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 
bytes
         Interrupt: pin A routed to IRQ 30
         Region 0: I/O ports at 8480 [size=128]
         Region 1: Memory at 0a121000 (32-bit, non-prefetchable) 
[size=1K]
         Expansion ROM at 0a040000 [disabled] [size=256K]
         Kernel driver in use: tulip
         Kernel modules: tulip

00:0d.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c1) (prog-if 
f0)
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 255 (500ns min, 1000ns max)
         Interrupt: pin A routed to IRQ 255
         Region 0: I/O ports at 01f0 [size=8]
         Region 1: I/O ports at 03f4
         Region 2: I/O ports at 0170 [size=8]
         Region 3: I/O ports at 0374
         Region 4: I/O ports at 8880 [size=16]
         Kernel driver in use: pata_ali

00:0e.0 VGA compatible controller: Texas Instruments TVP4020 [Permedia 
2] (rev 01) (prog-if 00 [VGA controller])
         Subsystem: Elsa AG GLoria Synergy
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 255 (48000ns min, 48000ns max)
         Interrupt: pin A routed to IRQ 35
         Region 0: Memory at 0a080000 (32-bit, non-prefetchable) 
[size=128K]
         Region 1: Memory at 09000000 (32-bit, non-prefetchable) 
[size=8M]
         Region 2: Memory at 09800000 (32-bit, non-prefetchable) 
[size=8M]
         Expansion ROM at 0a100000 [disabled] [size=64K]
         Kernel driver in use: pm2fb

00:0f.0 USB controller: VIA Technologies, Inc. VT82xx/62xx/VX700/8x0/900 
UHCI USB 1.1 Controller (rev 61) (prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. USB 1.1 UHCI controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 255, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 39
         Region 4: I/O ports at 8800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: uhci_hcd

00:0f.1 USB controller: VIA Technologies, Inc. VT82xx/62xx/VX700/8x0/900 
UHCI USB 1.1 Controller (rev 61) (prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. USB 1.1 UHCI controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 255, Cache Line Size: 64 bytes
         Interrupt: pin B routed to IRQ 38
         Region 4: I/O ports at 8820 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: uhci_hcd

00:0f.2 USB controller: VIA Technologies, Inc. USB 2.0 EHCI-Compliant 
Host-Controller (rev 63) (prog-if 20 [EHCI])
         Subsystem: VIA Technologies, Inc. USB 2.0 EHCI controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 255, Cache Line Size: 64 bytes
         Interrupt: pin C routed to IRQ 37
         Region 0: Memory at 0a122000 (32-bit, non-prefetchable) 
[size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: ehci-pci

00:10.0 Ethernet controller: Intel Corporation 82544EI Gigabit Ethernet 
Controller (Fiber) (rev 02)
         Subsystem: Intel Corporation PRO/1000 XF Server Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 252 (63750ns min), Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 43
         Region 0: Memory at 0a0a0000 (32-bit, non-prefetchable) 
[size=128K]
         Region 1: Memory at 0a0c0000 (32-bit, non-prefetchable) 
[size=128K]
         Region 2: I/O ports at 8840 [size=32]
         Expansion ROM at 0a0e0000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [e4] PCI-X non-bridge device
                 Command: DPERE- ERO+ RBC=512 OST=1
                 Status: Dev=00:00.0 64bit+ 133MHz+ SCD- USC- DC=simple 
DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
         Capabilities: [f0] MSI: Enable- Count=1/1 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Kernel driver in use: e1000

00:11.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE/SATA 
Controller (rev 50)
         Subsystem: VIA Technologies, Inc. VT6421 IDE/SATA Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 240
         Interrupt: pin A routed to IRQ 47
         Region 0: I/O ports at 8890 [size=16]
         Region 1: I/O ports at 88a0 [size=16]
         Region 2: I/O ports at 88b0 [size=16]
         Region 3: I/O ports at 88c0 [size=16]
         Region 4: I/O ports at 8860 [size=32]
         Region 5: I/O ports at 8000 [size=256]
         Expansion ROM at 0a110000 [disabled] [size=64K]
         Capabilities: [e0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: sata_via


root@bigbang:/lib/modules/6.12.12-SMP# cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : EV6
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Tsunami
system variation        : Webbrick
system revision         : 0
system serial number    : 4004DQMZ1055
cycle frequency [Hz]    : 462437186 est.
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 911.32
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : AlphaServer DS10 466 MHz
cpus detected           : 1
cpus active             : 1
cpu active mask         : 0000000000000001
L1 Icache               : 64K, 2-way, 64b line
L1 Dcache               : 64K, 2-way, 64b line
L2 cache                : 2048K, 1-way, 64b line
L3 cache                : n/a





I also ran this setup again, with the USB/video/Intel NIC yanked out, 
and it's the same...
Once the IPs are bound, a link loss pops the message:
(with the other PCI cards pulled)


[  363.702938] ------------[ cut here ]------------
[  363.702938] WARNING: CPU: 0 PID: 34 at kernel/time/timer.c:1657 
__timer_delete_sync+0x10c/0x150
[  363.702938] Modules linked in: tulip
[  363.702938] CPU: 0 UID: 0 PID: 34 Comm: lock_torture_wr Not tainted 
6.12.12-SMP #1
[  363.702938]        fffffc0002aefa70 fffffc00011b0ac0 fffffc000032a4f0 
fffffc0000f8f181
[  363.702938]        0000000000000000 0000000000000000 fffffc000032a688 
fffffc000119c690
[  363.702938]        0000000000000000 fffffc0000f8f181 fffffc00003d297c 
fffffc000125c7e0
[  363.702938]        fffffffc008251c4 00000000fa83b2da fffffc00003d297c 
fffffc0003ded490
[  363.702938]        fffffc0003ded490 0000000000000000 fffffffff8668000 
fffffd000a0c0000
[  363.702938]        00000054ae626ca0 fffffc000285a600 fffffc000036692c 
fffffc000285af80
[  363.702938] Trace:
[  363.702938] [<fffffc000032a4f0>] __warn+0x190/0x1a0
[  363.702938] [<fffffc000032a688>] warn_slowpath_fmt+0x188/0x240
[  363.702938] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
[  363.702938] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
[  363.702938] [<fffffc000036692c>] ttwu_do_activate.isra.0+0x8c/0x1a0
[  363.702938] [<fffffc0000369030>] try_to_wake_up+0x370/0x700
[  363.702938] [<fffffc0000368e70>] try_to_wake_up+0x1b0/0x700
[  363.702938] [<fffffc00003d43f8>] hrtimer_wakeup+0x28/0x40
[  363.702938] [<fffffc00003d43d0>] hrtimer_wakeup+0x0/0x40
[  363.702938] [<fffffc00003c31a4>] rcu_sched_clock_irq+0x714/0xea0
[  363.702938] [<fffffc00003a1a80>] __handle_irq_event_percpu+0x60/0x190
[  363.702938] [<fffffc00003e6758>] tick_handle_periodic+0x38/0xd0
[  363.702938] [<fffffc00003731e8>] enqueue_task_fair+0x358/0x8b0
[  363.702938] [<fffffc00003a1cb8>] handle_irq_event+0x68/0x110
[  363.702938] [<fffffc00003a8108>] handle_level_irq+0x108/0x240
[  363.702938] [<fffffc00003158e0>] handle_irq+0x70/0xe0
[  363.702938] [<fffffc0000320820>] dp264_srm_device_interrupt+0x30/0x50
[  363.702938] [<fffffc0000372538>] pick_task_fair+0x88/0x100
[  363.702938] [<fffffc0000315af4>] do_entInt+0x1a4/0x200
[  363.702938] [<fffffc0000310d00>] ret_from_sys_call+0x0/0x10
[  363.702938] [<fffffc00003923dc>] __torture_rt_boost+0x5c/0x100
[  363.702938] [<fffffc0000e291d8>] _raw_spin_lock+0x18/0x30
[  363.702938] [<fffffc0000390330>] do_raw_spin_lock+0x0/0x140
[  363.702938] [<fffffc00003903a0>] do_raw_spin_lock+0x70/0x140
[  363.702938] [<fffffc0000e291d8>] _raw_spin_lock+0x18/0x30
[  363.702938] [<fffffc0000390ac0>] 
torture_spin_lock_write_lock+0x20/0x40
[  363.702938] [<fffffc000039183c>] lock_torture_writer+0x10c/0x450
[  363.702938] [<fffffc000035a980>] kthread+0x150/0x190
[  363.702938] [<fffffc0000391730>] lock_torture_writer+0x0/0x450
[  363.702938] [<fffffc00003110d8>] ret_from_kernel_thread+0x18/0x20
[  363.702938] [<fffffc000035a830>] kthread+0x0/0x190

[  363.702938] ---[ end trace 0000000000000000 ]---




I'm going to try one more thing, which is compile a non-specific alpha 
kernel, and try it, but I don't think it'll change anything.

--=_0b0e99b6138c62d90d0bbbbf1f94e876
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=config
Content-Disposition: attachment;
 filename=config;
 size=63572

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4L2Fs
cGhhIDYuMTIuMTIgS2VybmVsIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfQ0NfVkVSU0lPTl9URVhU
PSJhbHBoYS1saW51eC1nbnUtZ2NjIChHQ0MpIDE0LjIuMCIKQ09ORklHX0NDX0lTX0dDQz15CkNP
TkZJR19HQ0NfVkVSU0lPTj0xNDAyMDAKQ09ORklHX0NMQU5HX1ZFUlNJT049MApDT05GSUdfQVNf
SVNfR05VPXkKQ09ORklHX0FTX1ZFUlNJT049MjQ0MDAKQ09ORklHX0xEX0lTX0JGRD15CkNPTkZJ
R19MRF9WRVJTSU9OPTI0NDAwCkNPTkZJR19MTERfVkVSU0lPTj0wCkNPTkZJR19SVVNUQ19WRVJT
SU9OPTEwODQwMQpDT05GSUdfUlVTVENfTExWTV9WRVJTSU9OPTE5MDEwNQpDT05GSUdfQ0NfQ0FO
X0xJTks9eQpDT05GSUdfQ0NfQ0FOX0xJTktfU1RBVElDPXkKQ09ORklHX0NDX0hBU19BU01fSU5M
SU5FPXkKQ09ORklHX0NDX0hBU19OT19QUk9GSUxFX0ZOX0FUVFI9eQpDT05GSUdfUEFIT0xFX1ZF
UlNJT049MTI5CkNPTkZJR19JUlFfV09SSz15CgojCiMgR2VuZXJhbCBzZXR1cAojCkNPTkZJR19J
TklUX0VOVl9BUkdfTElNSVQ9MzIKIyBDT05GSUdfQ09NUElMRV9URVNUIGlzIG5vdCBzZXQKIyBD
T05GSUdfV0VSUk9SIGlzIG5vdCBzZXQKQ09ORklHX0xPQ0FMVkVSU0lPTj0iLVNNUCIKQ09ORklH
X0xPQ0FMVkVSU0lPTl9BVVRPPXkKQ09ORklHX0JVSUxEX1NBTFQ9IiIKQ09ORklHX0RFRkFVTFRf
SU5JVD0iIgpDT05GSUdfREVGQVVMVF9IT1NUTkFNRT0iKG5vbmUpIgpDT05GSUdfU1lTVklQQz15
CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15CkNPTkZJR19QT1NJWF9NUVVFVUU9eQpDT05GSUdfUE9T
SVhfTVFVRVVFX1NZU0NUTD15CiMgQ09ORklHX1dBVENIX1FVRVVFIGlzIG5vdCBzZXQKQ09ORklH
X0NST1NTX01FTU9SWV9BVFRBQ0g9eQpDT05GSUdfVVNFTElCPXkKQ09ORklHX0FVRElUPXkKQ09O
RklHX0hBVkVfQVJDSF9BVURJVFNZU0NBTEw9eQpDT05GSUdfQVVESVRTWVNDQUxMPXkKCiMKIyBJ
UlEgc3Vic3lzdGVtCiMKQ09ORklHX0dFTkVSSUNfSVJRX1BST0JFPXkKQ09ORklHX0dFTkVSSUNf
SVJRX1NIT1c9eQpDT05GSUdfQVVUT19JUlFfQUZGSU5JVFk9eQpDT05GSUdfSVJRX0RPTUFJTj15
CkNPTkZJR19JUlFfRE9NQUlOX0hJRVJBUkNIWT15CkNPTkZJR19HRU5FUklDX01TSV9JUlE9eQoj
IGVuZCBvZiBJUlEgc3Vic3lzdGVtCgpDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5UUz15CkNPTkZJ
R19DT05URVhUX1RSQUNLSU5HPXkKQ09ORklHX0NPTlRFWFRfVFJBQ0tJTkdfSURMRT15CgojCiMg
VGltZXJzIHN1YnN5c3RlbQojCkNPTkZJR19IWl9QRVJJT0RJQz15CiMgQ09ORklHX05PX0haX0lE
TEUgaXMgbm90IHNldAojIENPTkZJR19OT19IWiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJR0hfUkVT
X1RJTUVSUyBpcyBub3Qgc2V0CiMgZW5kIG9mIFRpbWVycyBzdWJzeXN0ZW0KCkNPTkZJR19CUEY9
eQoKIwojIEJQRiBzdWJzeXN0ZW0KIwojIENPTkZJR19CUEZfU1lTQ0FMTCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEJQRiBzdWJzeXN0ZW0KCkNPTkZJR19QUkVFTVBUX05PTkVfQlVJTEQ9eQpDT05GSUdf
UFJFRU1QVF9OT05FPXkKCiMKIyBDUFUvVGFzayB0aW1lIGFuZCBzdGF0cyBhY2NvdW50aW5nCiMK
Q09ORklHX1RJQ0tfQ1BVX0FDQ09VTlRJTkc9eQpDT05GSUdfQlNEX1BST0NFU1NfQUNDVD15CiMg
Q09ORklHX0JTRF9QUk9DRVNTX0FDQ1RfVjMgaXMgbm90IHNldAojIENPTkZJR19UQVNLU1RBVFMg
aXMgbm90IHNldAojIENPTkZJR19QU0kgaXMgbm90IHNldAojIGVuZCBvZiBDUFUvVGFzayB0aW1l
IGFuZCBzdGF0cyBhY2NvdW50aW5nCgojIENPTkZJR19DUFVfSVNPTEFUSU9OIGlzIG5vdCBzZXQK
CiMKIyBSQ1UgU3Vic3lzdGVtCiMKQ09ORklHX1RSRUVfUkNVPXkKIyBDT05GSUdfUkNVX0VYUEVS
VCBpcyBub3Qgc2V0CkNPTkZJR19UUkVFX1NSQ1U9eQpDT05GSUdfUkNVX1NUQUxMX0NPTU1PTj15
CkNPTkZJR19SQ1VfTkVFRF9TRUdDQkxJU1Q9eQojIGVuZCBvZiBSQ1UgU3Vic3lzdGVtCgpDT05G
SUdfSUtDT05GSUc9eQpDT05GSUdfSUtDT05GSUdfUFJPQz15CiMgQ09ORklHX0lLSEVBREVSUyBp
cyBub3Qgc2V0CkNPTkZJR19MT0dfQlVGX1NISUZUPTE0CkNPTkZJR19MT0dfQ1BVX01BWF9CVUZf
U0hJRlQ9MTIKCiMKIyBTY2hlZHVsZXIgZmVhdHVyZXMKIwojIGVuZCBvZiBTY2hlZHVsZXIgZmVh
dHVyZXMKCkNPTkZJR19DQ19IQVNfSU5UMTI4PXkKQ09ORklHX0NDX0lNUExJQ0lUX0ZBTExUSFJP
VUdIPSItV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTUiCkNPTkZJR19HQ0MxMF9OT19BUlJBWV9CT1VO
RFM9eQpDT05GSUdfQ0NfTk9fQVJSQVlfQk9VTkRTPXkKQ09ORklHX0dDQ19OT19TVFJJTkdPUF9P
VkVSRkxPVz15CkNPTkZJR19DQ19OT19TVFJJTkdPUF9PVkVSRkxPVz15CiMgQ09ORklHX0NHUk9V
UFMgaXMgbm90IHNldApDT05GSUdfTkFNRVNQQUNFUz15CkNPTkZJR19VVFNfTlM9eQpDT05GSUdf
SVBDX05TPXkKQ09ORklHX1VTRVJfTlM9eQpDT05GSUdfUElEX05TPXkKQ09ORklHX05FVF9OUz15
CiMgQ09ORklHX0NIRUNLUE9JTlRfUkVTVE9SRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDSEVEX0FV
VE9HUk9VUCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9JTklUUkQgaXMgbm90IHNldAojIENPTkZJR19CT09UX0NPTkZJRyBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOSVRSQU1GU19QUkVTRVJWRV9NVElNRSBpcyBub3Qgc2V0CkNPTkZJR19DQ19PUFRJ
TUlaRV9GT1JfUEVSRk9STUFOQ0U9eQojIENPTkZJR19DQ19PUFRJTUlaRV9GT1JfU0laRSBpcyBu
b3Qgc2V0CkNPTkZJR19TWVNDVEw9eQpDT05GSUdfSEFWRV9QQ1NQS1JfUExBVEZPUk09eQojIENP
TkZJR19FWFBFUlQgaXMgbm90IHNldApDT05GSUdfTVVMVElVU0VSPXkKQ09ORklHX1NZU0ZTX1NZ
U0NBTEw9eQpDT05GSUdfRkhBTkRMRT15CkNPTkZJR19QT1NJWF9USU1FUlM9eQpDT05GSUdfUFJJ
TlRLPXkKQ09ORklHX0JVRz15CkNPTkZJR19FTEZfQ09SRT15CkNPTkZJR19QQ1NQS1JfUExBVEZP
Uk09eQpDT05GSUdfRlVURVg9eQpDT05GSUdfRlVURVhfUEk9eQpDT05GSUdfRVBPTEw9eQpDT05G
SUdfU0lHTkFMRkQ9eQpDT05GSUdfVElNRVJGRD15CkNPTkZJR19FVkVOVEZEPXkKQ09ORklHX1NI
TUVNPXkKQ09ORklHX0FJTz15CkNPTkZJR19JT19VUklORz15CkNPTkZJR19BRFZJU0VfU1lTQ0FM
TFM9eQpDT05GSUdfTUVNQkFSUklFUj15CkNPTkZJR19DQUNIRVNUQVRfU1lTQ0FMTD15CkNPTkZJ
R19LQUxMU1lNUz15CiMgQ09ORklHX0tBTExTWU1TX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklH
X0tBTExTWU1TX0FMTD15CkNPTkZJR19IQVZFX1BFUkZfRVZFTlRTPXkKCiMKIyBLZXJuZWwgUGVy
Zm9ybWFuY2UgRXZlbnRzIEFuZCBDb3VudGVycwojCkNPTkZJR19QRVJGX0VWRU5UUz15CiMgQ09O
RklHX0RFQlVHX1BFUkZfVVNFX1ZNQUxMT0MgaXMgbm90IHNldAojIGVuZCBvZiBLZXJuZWwgUGVy
Zm9ybWFuY2UgRXZlbnRzIEFuZCBDb3VudGVycwoKQ09ORklHX1BST0ZJTElORz15CgojCiMgS2V4
ZWMgYW5kIGNyYXNoIGZlYXR1cmVzCiMKQ09ORklHX1ZNQ09SRV9JTkZPPXkKIyBlbmQgb2YgS2V4
ZWMgYW5kIGNyYXNoIGZlYXR1cmVzCiMgZW5kIG9mIEdlbmVyYWwgc2V0dXAKCkNPTkZJR19BTFBI
QT15CkNPTkZJR182NEJJVD15CkNPTkZJR19NTVU9eQpDT05GSUdfR0VORVJJQ19DQUxJQlJBVEVf
REVMQVk9eQpDT05GSUdfR0VORVJJQ19JU0FfRE1BPXkKQ09ORklHX1BHVEFCTEVfTEVWRUxTPTMK
Q09ORklHX0FVRElUX0FSQ0g9eQoKIwojIFN5c3RlbSBzZXR1cAojCiMgQ09ORklHX0FMUEhBX0dF
TkVSSUMgaXMgbm90IHNldAojIENPTkZJR19BTFBIQV9BTENPUiBpcyBub3Qgc2V0CkNPTkZJR19B
TFBIQV9EUDI2ND15CiMgQ09ORklHX0FMUEhBX0VJR0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxQ
SEFfTFgxNjQgaXMgbm90IHNldAojIENPTkZJR19BTFBIQV9NQVJWRUwgaXMgbm90IHNldAojIENP
TkZJR19BTFBIQV9NSUFUQSBpcyBub3Qgc2V0CiMgQ09ORklHX0FMUEhBX01JS0FTQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0FMUEhBX05BVVRJTFVTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxQSEFfTk9S
SVRBS0UgaXMgbm90IHNldAojIENPTkZJR19BTFBIQV9QQzE2NCBpcyBub3Qgc2V0CiMgQ09ORklH
X0FMUEhBX1JBV0hJREUgaXMgbm90IHNldAojIENPTkZJR19BTFBIQV9SVUZGSUFOIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQUxQSEFfUlgxNjQgaXMgbm90IHNldAojIENPTkZJR19BTFBIQV9TWDE2NCBp
cyBub3Qgc2V0CiMgQ09ORklHX0FMUEhBX1NBQkxFIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxQSEFf
U0hBUksgaXMgbm90IHNldAojIENPTkZJR19BTFBIQV9UQUtBUkEgaXMgbm90IHNldAojIENPTkZJ
R19BTFBIQV9USVRBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FMUEhBX1dJTERGSVJFIGlzIG5vdCBz
ZXQKQ09ORklHX0lTQT15CkNPTkZJR19JU0FfRE1BX0FQST15CkNPTkZJR19BTFBIQV9FVjY9eQpD
T05GSUdfQUxQSEFfVFNVTkFNST15CiMgQ09ORklHX0FMUEhBX0VWNjcgaXMgbm90IHNldApDT05G
SUdfR0VORVJJQ19IV0VJR0hUPXkKQ09ORklHX1ZHQV9IT1NFPXkKIyBDT05GSUdfQUxQSEFfUUVN
VSBpcyBub3Qgc2V0CkNPTkZJR19BTFBIQV9TUk09eQpDT05GSUdfQVJDSF9NQVlfSEFWRV9QQ19G
REM9eQpDT05GSUdfU01QPXkKQ09ORklHX05SX0NQVVM9NAojIENPTkZJR19BUkNIX1NQQVJTRU1F
TV9FTkFCTEUgaXMgbm90IHNldAojIENPTkZJR19BTFBIQV9XVElOVCBpcyBub3Qgc2V0CkNPTkZJ
R19WRVJCT1NFX01DSEVDSz15CkNPTkZJR19WRVJCT1NFX01DSEVDS19PTj0xCiMgQ09ORklHX0ha
XzMyIGlzIG5vdCBzZXQKIyBDT05GSUdfSFpfNjQgaXMgbm90IHNldAojIENPTkZJR19IWl8xMjgg
aXMgbm90IHNldAojIENPTkZJR19IWl8yNTYgaXMgbm90IHNldApDT05GSUdfSFpfMTAyND15CiMg
Q09ORklHX0haXzEyMDAgaXMgbm90IHNldApDT05GSUdfSFo9MTAyNApDT05GSUdfU1JNX0VOVj15
CiMgZW5kIG9mIFN5c3RlbSBzZXR1cAoKQ09ORklHX0RVTU1ZX0NPTlNPTEU9eQpDT05GSUdfQ1BV
X01JVElHQVRJT05TPXkKQ09ORklHX0FSQ0hfSEFTX0RNQV9PUFM9eQoKIwojIEdlbmVyYWwgYXJj
aGl0ZWN0dXJlLWRlcGVuZGVudCBvcHRpb25zCiMKQ09ORklHX0hBVkVfNjRCSVRfQUxJR05FRF9B
Q0NFU1M9eQpDT05GSUdfR0VORVJJQ19TTVBfSURMRV9USFJFQUQ9eQpDT05GSUdfQVJDSF8zMkJJ
VF9VU1RBVF9GX1RJTk9ERT15CkNPTkZJR19IQVZFX0FTTV9NT0RWRVJTSU9OUz15CkNPTkZJR19N
TVVfR0FUSEVSX05PX1JBTkdFPXkKQ09ORklHX01NVV9HQVRIRVJfTUVSR0VfVk1BUz15CkNPTkZJ
R19NTVVfTEFaWV9UTEJfUkVGQ09VTlQ9eQpDT05GSUdfQVJDSF9IQVZFX05NSV9TQUZFX0NNUFhD
SEc9eQpDT05GSUdfQVJDSF9XQU5UX0lQQ19QQVJTRV9WRVJTSU9OPXkKQ09ORklHX0xUT19OT05F
PXkKQ09ORklHX0hBVkVfVklSVF9DUFVfQUNDT1VOVElOR19HRU49eQpDT05GSUdfSEFWRV9NT0Rf
QVJDSF9TUEVDSUZJQz15CkNPTkZJR19NT0RVTEVTX1VTRV9FTEZfUkVMQT15CkNPTkZJR19IQVZF
X1BBR0VfU0laRV84S0I9eQpDT05GSUdfUEFHRV9TSVpFXzhLQj15CkNPTkZJR19QQUdFX1NJWkVf
TEVTU19USEFOXzY0S0I9eQpDT05GSUdfUEFHRV9TSVpFX0xFU1NfVEhBTl8yNTZLQj15CkNPTkZJ
R19QQUdFX1NISUZUPTEzCkNPTkZJR19JU0FfQlVTX0FQST15CkNPTkZJR19PRERfUlRfU0lHQUNU
SU9OPXkKQ09ORklHX09MRF9TSUdTVVNQRU5EPXkKIyBDT05GSUdfQ09NUEFUXzMyQklUX1RJTUUg
aXMgbm90IHNldApDT05GSUdfQVJDSF9OT19QUkVFTVBUPXkKQ09ORklHX0NQVV9OT19FRkZJQ0lF
TlRfRkZTPXkKCiMKIyBHQ09WLWJhc2VkIGtlcm5lbCBwcm9maWxpbmcKIwojIGVuZCBvZiBHQ09W
LWJhc2VkIGtlcm5lbCBwcm9maWxpbmcKCkNPTkZJR19GVU5DVElPTl9BTElHTk1FTlQ9MApDT05G
SUdfQ0NfSEFTX01JTl9GVU5DVElPTl9BTElHTk1FTlQ9eQpDT05GSUdfQ0NfSEFTX1NBTkVfRlVO
Q1RJT05fQUxJR05NRU5UPXkKIyBlbmQgb2YgR2VuZXJhbCBhcmNoaXRlY3R1cmUtZGVwZW5kZW50
IG9wdGlvbnMKCkNPTkZJR19SVF9NVVRFWEVTPXkKQ09ORklHX01PRFVMRVM9eQpDT05GSUdfTU9E
VUxFX0ZPUkNFX0xPQUQ9eQpDT05GSUdfTU9EVUxFX1VOTE9BRD15CkNPTkZJR19NT0RVTEVfRk9S
Q0VfVU5MT0FEPXkKIyBDT05GSUdfTU9EVUxFX1VOTE9BRF9UQUlOVF9UUkFDS0lORyBpcyBub3Qg
c2V0CiMgQ09ORklHX01PRFZFUlNJT05TIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9EVUxFX1NSQ1ZF
UlNJT05fQUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9EVUxFX1NJRyBpcyBub3Qgc2V0CiMgQ09O
RklHX01PRFVMRV9DT01QUkVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFVMRV9BTExPV19NSVNT
SU5HX05BTUVTUEFDRV9JTVBPUlRTIGlzIG5vdCBzZXQKQ09ORklHX01PRFBST0JFX1BBVEg9Ii9z
YmluL21vZHByb2JlIgojIENPTkZJR19UUklNX1VOVVNFRF9LU1lNUyBpcyBub3Qgc2V0CkNPTkZJ
R19NT0RVTEVTX1RSRUVfTE9PS1VQPXkKQ09ORklHX0JMT0NLPXkKQ09ORklHX0JMT0NLX0xFR0FD
WV9BVVRPTE9BRD15CkNPTkZJR19CTEtfSUNRPXkKIyBDT05GSUdfQkxLX0RFVl9CU0dMSUIgaXMg
bm90IHNldAojIENPTkZJR19CTEtfREVWX0lOVEVHUklUWSBpcyBub3Qgc2V0CkNPTkZJR19CTEtf
REVWX1dSSVRFX01PVU5URUQ9eQojIENPTkZJR19CTEtfREVWX1pPTkVEIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX1dCVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19TRURfT1BBTCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19JTkxJTkVfRU5DUllQVElPTiBpcyBub3Qgc2V0CgojCiMgUGFydGl0aW9u
IFR5cGVzCiMKQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRD15CiMgQ09ORklHX0FDT1JOX1BBUlRJ
VElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FJWF9QQVJUSVRJT04gaXMgbm90IHNldApDT05GSUdf
T1NGX1BBUlRJVElPTj15CiMgQ09ORklHX0FNSUdBX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09O
RklHX0FUQVJJX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ19QQVJUSVRJT04gaXMg
bm90IHNldApDT05GSUdfTVNET1NfUEFSVElUSU9OPXkKQ09ORklHX0JTRF9ESVNLTEFCRUw9eQoj
IENPTkZJR19NSU5JWF9TVUJQQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19TT0xBUklTX1g4
Nl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19VTklYV0FSRV9ESVNLTEFCRUwgaXMgbm90
IHNldAojIENPTkZJR19MRE1fUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfU0dJX1BBUlRJ
VElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VMVFJJWF9QQVJUSVRJT04gaXMgbm90IHNldAojIENP
TkZJR19TVU5fUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfS0FSTUFfUEFSVElUSU9OIGlz
IG5vdCBzZXQKQ09ORklHX0VGSV9QQVJUSVRJT049eQojIENPTkZJR19TWVNWNjhfUEFSVElUSU9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ01ETElORV9QQVJUSVRJT04gaXMgbm90IHNldAojIGVuZCBv
ZiBQYXJ0aXRpb24gVHlwZXMKCkNPTkZJR19CTEtfTVFfUENJPXkKCiMKIyBJTyBTY2hlZHVsZXJz
CiMKQ09ORklHX01RX0lPU0NIRURfREVBRExJTkU9eQpDT05GSUdfTVFfSU9TQ0hFRF9LWUJFUj15
CkNPTkZJR19JT1NDSEVEX0JGUT15CiMgZW5kIG9mIElPIFNjaGVkdWxlcnMKCkNPTkZJR19BU04x
PXkKQ09ORklHX1VOSU5MSU5FX1NQSU5fVU5MT0NLPXkKCiMKIyBFeGVjdXRhYmxlIGZpbGUgZm9y
bWF0cwojCkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0VMRkNPUkU9eQpDT05GSUdfQ09SRV9E
VU1QX0RFRkFVTFRfRUxGX0hFQURFUlM9eQpDT05GSUdfQklORk1UX1NDUklQVD15CkNPTkZJR19C
SU5GTVRfTUlTQz15CkNPTkZJR19DT1JFRFVNUD15CiMgZW5kIG9mIEV4ZWN1dGFibGUgZmlsZSBm
b3JtYXRzCgojCiMgTWVtb3J5IE1hbmFnZW1lbnQgb3B0aW9ucwojCkNPTkZJR19TV0FQPXkKIyBD
T05GSUdfWlNXQVAgaXMgbm90IHNldAoKIwojIFNsYWIgYWxsb2NhdG9yIG9wdGlvbnMKIwpDT05G
SUdfU0xVQj15CkNPTkZJR19TTEFCX01FUkdFX0RFRkFVTFQ9eQojIENPTkZJR19TTEFCX0ZSRUVM
SVNUX1JBTkRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NMQUJfRlJFRUxJU1RfSEFSREVORUQgaXMg
bm90IHNldAojIENPTkZJR19TTEFCX0JVQ0tFVFMgaXMgbm90IHNldAojIENPTkZJR19TTFVCX1NU
QVRTIGlzIG5vdCBzZXQKQ09ORklHX1NMVUJfQ1BVX1BBUlRJQUw9eQojIENPTkZJR19SQU5ET01f
S01BTExPQ19DQUNIRVMgaXMgbm90IHNldAojIGVuZCBvZiBTbGFiIGFsbG9jYXRvciBvcHRpb25z
CgojIENPTkZJR19TSFVGRkxFX1BBR0VfQUxMT0NBVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09N
UEFUX0JSSyBpcyBub3Qgc2V0CkNPTkZJR19GTEFUTUVNPXkKQ09ORklHX1NQTElUX1BURV9QVExP
Q0tTPXkKQ09ORklHX0NPTVBBQ1RJT049eQpDT05GSUdfQ09NUEFDVF9VTkVWSUNUQUJMRV9ERUZB
VUxUPTEKQ09ORklHX1BBR0VfUkVQT1JUSU5HPXkKQ09ORklHX01JR1JBVElPTj15CkNPTkZJR19Q
Q1BfQkFUQ0hfU0NBTEVfTUFYPTUKQ09ORklHX1BIWVNfQUREUl9UXzY0QklUPXkKIyBDT05GSUdf
S1NNIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfTU1BUF9NSU5fQUREUj00MDk2CiMgQ09ORklH
X0NNQSBpcyBub3Qgc2V0CiMgQ09ORklHX0lETEVfUEFHRV9UUkFDS0lORyBpcyBub3Qgc2V0CkNP
TkZJR19BUkNIX0hBU19DVVJSRU5UX1NUQUNLX1BPSU5URVI9eQpDT05GSUdfWk9ORV9ETUE9eQpD
T05GSUdfVk1fRVZFTlRfQ09VTlRFUlM9eQojIENPTkZJR19QRVJDUFVfU1RBVFMgaXMgbm90IHNl
dAoKIwojIEdVUF9URVNUIG5lZWRzIHRvIGhhdmUgREVCVUdfRlMgZW5hYmxlZAojCiMgQ09ORklH
X0RNQVBPT0xfVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19NRU1GRF9DUkVBVEU9eQojIENPTkZJR19B
Tk9OX1ZNQV9OQU1FIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNFUkZBVUxURkQgaXMgbm90IHNldAoj
IENPTkZJR19MUlVfR0VOIGlzIG5vdCBzZXQKQ09ORklHX0xPQ0tfTU1fQU5EX0ZJTkRfVk1BPXkK
Q09ORklHX0VYRUNNRU09eQoKIwojIERhdGEgQWNjZXNzIE1vbml0b3JpbmcKIwojIENPTkZJR19E
QU1PTiBpcyBub3Qgc2V0CiMgZW5kIG9mIERhdGEgQWNjZXNzIE1vbml0b3JpbmcKIyBlbmQgb2Yg
TWVtb3J5IE1hbmFnZW1lbnQgb3B0aW9ucwoKQ09ORklHX05FVD15CkNPTkZJR19TS0JfRVhURU5T
SU9OUz15CgojCiMgTmV0d29ya2luZyBvcHRpb25zCiMKQ09ORklHX1BBQ0tFVD15CiMgQ09ORklH
X1BBQ0tFVF9ESUFHIGlzIG5vdCBzZXQKQ09ORklHX1VOSVg9eQpDT05GSUdfQUZfVU5JWF9PT0I9
eQojIENPTkZJR19VTklYX0RJQUcgaXMgbm90IHNldApDT05GSUdfVExTPXkKIyBDT05GSUdfVExT
X0RFVklDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RMU19UT0UgaXMgbm90IHNldApDT05GSUdfWEZS
TT15CkNPTkZJR19YRlJNX0FMR089eQojIENPTkZJR19YRlJNX1VTRVIgaXMgbm90IHNldAojIENP
TkZJR19YRlJNX0lOVEVSRkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGUk1fU1VCX1BPTElDWSBp
cyBub3Qgc2V0CiMgQ09ORklHX1hGUk1fTUlHUkFURSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGUk1f
U1RBVElTVElDUyBpcyBub3Qgc2V0CkNPTkZJR19YRlJNX0FIPXkKQ09ORklHX1hGUk1fRVNQPXkK
Q09ORklHX1hGUk1fSVBDT01QPXkKIyBDT05GSUdfTkVUX0tFWSBpcyBub3Qgc2V0CkNPTkZJR19O
RVRfSEFORFNIQUtFPXkKQ09ORklHX0lORVQ9eQpDT05GSUdfSVBfTVVMVElDQVNUPXkKIyBDT05G
SUdfSVBfQURWQU5DRURfUk9VVEVSIGlzIG5vdCBzZXQKQ09ORklHX0lQX1BOUD15CkNPTkZJR19J
UF9QTlBfREhDUD15CkNPTkZJR19JUF9QTlBfQk9PVFA9eQpDT05GSUdfSVBfUE5QX1JBUlA9eQoj
IENPTkZJR19ORVRfSVBJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUEdSRV9ERU1VWCBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRfSVBfVFVOTkVMPXkKIyBDT05GSUdfSVBfTVJPVVRFIGlzIG5vdCBz
ZXQKQ09ORklHX1NZTl9DT09LSUVTPXkKIyBDT05GSUdfTkVUX0lQVlRJIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX0ZPVSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GT1VfSVBfVFVOTkVMUyBpcyBu
b3Qgc2V0CkNPTkZJR19JTkVUX0FIPXkKQ09ORklHX0lORVRfRVNQPXkKIyBDT05GSUdfSU5FVF9F
U1BfT0ZGTE9BRCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfRVNQSU5UQ1AgaXMgbm90IHNldApD
T05GSUdfSU5FVF9JUENPTVA9eQpDT05GSUdfSU5FVF9UQUJMRV9QRVJUVVJCX09SREVSPTE2CkNP
TkZJR19JTkVUX1hGUk1fVFVOTkVMPXkKQ09ORklHX0lORVRfVFVOTkVMPXkKIyBDT05GSUdfSU5F
VF9ESUFHIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfQURWQU5DRUQgaXMgbm90IHNldApD
T05GSUdfVENQX0NPTkdfQ1VCSUM9eQpDT05GSUdfREVGQVVMVF9UQ1BfQ09ORz0iY3ViaWMiCkNP
TkZJR19UQ1BfU0lHUE9PTD15CkNPTkZJR19UQ1BfQU89eQpDT05GSUdfVENQX01ENVNJRz15CkNP
TkZJR19JUFY2PXkKIyBDT05GSUdfSVBWNl9ST1VURVJfUFJFRiBpcyBub3Qgc2V0CiMgQ09ORklH
X0lQVjZfT1BUSU1JU1RJQ19EQUQgaXMgbm90IHNldApDT05GSUdfSU5FVDZfQUg9eQpDT05GSUdf
SU5FVDZfRVNQPXkKIyBDT05GSUdfSU5FVDZfRVNQX09GRkxPQUQgaXMgbm90IHNldAojIENPTkZJ
R19JTkVUNl9FU1BJTlRDUCBpcyBub3Qgc2V0CkNPTkZJR19JTkVUNl9JUENPTVA9eQojIENPTkZJ
R19JUFY2X01JUDYgaXMgbm90IHNldApDT05GSUdfSU5FVDZfWEZSTV9UVU5ORUw9eQpDT05GSUdf
SU5FVDZfVFVOTkVMPXkKIyBDT05GSUdfSVBWNl9WVEkgaXMgbm90IHNldApDT05GSUdfSVBWNl9T
SVQ9eQojIENPTkZJR19JUFY2X1NJVF82UkQgaXMgbm90IHNldApDT05GSUdfSVBWNl9ORElTQ19O
T0RFVFlQRT15CkNPTkZJR19JUFY2X1RVTk5FTD15CiMgQ09ORklHX0lQVjZfTVVMVElQTEVfVEFC
TEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNl9NUk9VVEUgaXMgbm90IHNldAojIENPTkZJR19J
UFY2X1NFRzZfTFdUVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19JUFY2X1NFRzZfSE1BQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQVjZfUlBMX0xXVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBW
Nl9JT0FNNl9MV1RVTk5FTCBpcyBub3Qgc2V0CiMgQ09ORklHX01QVENQIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUV09SS19TRUNNQVJLIGlzIG5vdCBzZXQKQ09ORklHX05FVF9QVFBfQ0xBU1NJRlk9
eQojIENPTkZJR19ORVRXT1JLX1BIWV9USU1FU1RBTVBJTkcgaXMgbm90IHNldAojIENPTkZJR19O
RVRGSUxURVIgaXMgbm90IHNldAojIENPTkZJR19JUF9EQ0NQIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVBfU0NUUCBpcyBub3Qgc2V0CiMgQ09ORklHX1JEUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RJUEMg
aXMgbm90IHNldAojIENPTkZJR19BVE0gaXMgbm90IHNldAojIENPTkZJR19MMlRQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQlJJREdFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0RTQSBpcyBub3Qgc2V0
CiMgQ09ORklHX1ZMQU5fODAyMVEgaXMgbm90IHNldAojIENPTkZJR19MTEMyIGlzIG5vdCBzZXQK
IyBDT05GSUdfQVRBTEsgaXMgbm90IHNldAojIENPTkZJR19YMjUgaXMgbm90IHNldAojIENPTkZJ
R19MQVBCIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhPTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfNkxP
V1BBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lFRUU4MDIxNTQgaXMgbm90IHNldAojIENPTkZJR19O
RVRfU0NIRUQgaXMgbm90IHNldAojIENPTkZJR19EQ0IgaXMgbm90IHNldApDT05GSUdfRE5TX1JF
U09MVkVSPXkKIyBDT05GSUdfQkFUTUFOX0FEViBpcyBub3Qgc2V0CiMgQ09ORklHX09QRU5WU1dJ
VENIIGlzIG5vdCBzZXQKIyBDT05GSUdfVlNPQ0tFVFMgaXMgbm90IHNldAojIENPTkZJR19ORVRM
SU5LX0RJQUcgaXMgbm90IHNldAojIENPTkZJR19NUExTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X05TSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hTUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TV0lU
Q0hERVYgaXMgbm90IHNldAojIENPTkZJR19ORVRfTDNfTUFTVEVSX0RFViBpcyBub3Qgc2V0CiMg
Q09ORklHX1FSVFIgaXMgbm90IHNldAojIENPTkZJR19ORVRfTkNTSSBpcyBub3Qgc2V0CkNPTkZJ
R19QQ1BVX0RFVl9SRUZDTlQ9eQpDT05GSUdfTUFYX1NLQl9GUkFHUz0xNwpDT05GSUdfUlBTPXkK
Q09ORklHX1JGU19BQ0NFTD15CkNPTkZJR19TT0NLX1JYX1FVRVVFX01BUFBJTkc9eQpDT05GSUdf
WFBTPXkKQ09ORklHX05FVF9SWF9CVVNZX1BPTEw9eQpDT05GSUdfQlFMPXkKQ09ORklHX05FVF9G
TE9XX0xJTUlUPXkKCiMKIyBOZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJR19ORVRfUEtUR0VOIGlz
IG5vdCBzZXQKIyBlbmQgb2YgTmV0d29yayB0ZXN0aW5nCiMgZW5kIG9mIE5ldHdvcmtpbmcgb3B0
aW9ucwoKIyBDT05GSUdfSEFNUkFESU8gaXMgbm90IHNldAojIENPTkZJR19DQU4gaXMgbm90IHNl
dAojIENPTkZJR19CVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FGX1JYUlBDIGlzIG5vdCBzZXQKIyBD
T05GSUdfQUZfS0NNIGlzIG5vdCBzZXQKQ09ORklHX1NUUkVBTV9QQVJTRVI9eQojIENPTkZJR19N
Q1RQIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lSRUxFU1MgaXMgbm90IHNldAojIENPTkZJR19SRktJ
TEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfOVAgaXMgbm90IHNldAojIENPTkZJR19DQUlGIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ0VQSF9MSUIgaXMgbm90IHNldAojIENPTkZJR19ORkMgaXMgbm90
IHNldAojIENPTkZJR19QU0FNUExFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lGRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0xXVFVOTkVMIGlzIG5vdCBzZXQKQ09ORklHX0RTVF9DQUNIRT15CkNPTkZJ
R19HUk9fQ0VMTFM9eQpDT05GSUdfTkVUX1NFTEZURVNUUz15CkNPTkZJR19ORVRfU09DS19NU0c9
eQojIENPTkZJR19GQUlMT1ZFUiBpcyBub3Qgc2V0CkNPTkZJR19FVEhUT09MX05FVExJTks9eQoK
IwojIERldmljZSBEcml2ZXJzCiMKQ09ORklHX0hBVkVfUENJPXkKQ09ORklHX0ZPUkNFX1BDST15
CkNPTkZJR19HRU5FUklDX1BDSV9JT01BUD15CkNPTkZJR19QQ0k9eQpDT05GSUdfUENJX0RPTUFJ
TlM9eQpDT05GSUdfUENJX1NZU0NBTEw9eQojIENPTkZJR19QQ0lFUE9SVEJVUyBpcyBub3Qgc2V0
CkNPTkZJR19QQ0lFQVNQTT15CkNPTkZJR19QQ0lFQVNQTV9ERUZBVUxUPXkKIyBDT05GSUdfUENJ
RUFTUE1fUE9XRVJTQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRUFTUE1fUE9XRVJfU1VQRVJT
QVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRUFTUE1fUEVSRk9STUFOQ0UgaXMgbm90IHNldAoj
IENPTkZJR19QQ0lFX1BUTSBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfTVNJPXkKQ09ORklHX1BDSV9R
VUlSS1M9eQpDT05GSUdfUENJX0RFQlVHPXkKIyBDT05GSUdfUENJX1NUVUIgaXMgbm90IHNldAoj
IENPTkZJR19QQ0lfSU9WIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX1BSSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1BDSV9QQVNJRCBpcyBub3Qgc2V0CkNPTkZJR19WR0FfQVJCPXkKQ09ORklHX1ZHQV9B
UkJfTUFYX0dQVVM9MTYKIyBDT05GSUdfSE9UUExVR19QQ0kgaXMgbm90IHNldAoKIwojIFBDSSBj
b250cm9sbGVyIGRyaXZlcnMKIwoKIwojIENhZGVuY2UtYmFzZWQgUENJZSBjb250cm9sbGVycwoj
CiMgZW5kIG9mIENhZGVuY2UtYmFzZWQgUENJZSBjb250cm9sbGVycwoKIwojIERlc2lnbldhcmUt
YmFzZWQgUENJZSBjb250cm9sbGVycwojCiMgQ09ORklHX1BDSV9NRVNPTiBpcyBub3Qgc2V0CiMg
Q09ORklHX1BDSUVfRFdfUExBVF9IT1NUIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGVzaWduV2FyZS1i
YXNlZCBQQ0llIGNvbnRyb2xsZXJzCgojCiMgTW9iaXZlaWwtYmFzZWQgUENJZSBjb250cm9sbGVy
cwojCiMgZW5kIG9mIE1vYml2ZWlsLWJhc2VkIFBDSWUgY29udHJvbGxlcnMKCiMKIyBQTERBLWJh
c2VkIFBDSWUgY29udHJvbGxlcnMKIwojIGVuZCBvZiBQTERBLWJhc2VkIFBDSWUgY29udHJvbGxl
cnMKIyBlbmQgb2YgUENJIGNvbnRyb2xsZXIgZHJpdmVycwoKIwojIFBDSSBFbmRwb2ludAojCiMg
Q09ORklHX1BDSV9FTkRQT0lOVCBpcyBub3Qgc2V0CiMgZW5kIG9mIFBDSSBFbmRwb2ludAoKIwoj
IFBDSSBzd2l0Y2ggY29udHJvbGxlciBkcml2ZXJzCiMKIyBDT05GSUdfUENJX1NXX1NXSVRDSFRF
QyBpcyBub3Qgc2V0CiMgZW5kIG9mIFBDSSBzd2l0Y2ggY29udHJvbGxlciBkcml2ZXJzCgojIENP
TkZJR19DWExfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUENDQVJEIGlzIG5vdCBzZXQKIyBDT05G
SUdfUkFQSURJTyBpcyBub3Qgc2V0CgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucwojCkNPTkZJ
R19VRVZFTlRfSEVMUEVSPXkKQ09ORklHX1VFVkVOVF9IRUxQRVJfUEFUSD0iIgpDT05GSUdfREVW
VE1QRlM9eQpDT05GSUdfREVWVE1QRlNfTU9VTlQ9eQojIENPTkZJR19ERVZUTVBGU19TQUZFIGlz
IG5vdCBzZXQKQ09ORklHX1NUQU5EQUxPTkU9eQpDT05GSUdfUFJFVkVOVF9GSVJNV0FSRV9CVUlM
RD15CgojCiMgRmlybXdhcmUgbG9hZGVyCiMKQ09ORklHX0ZXX0xPQURFUj15CkNPTkZJR19FWFRS
QV9GSVJNV0FSRT0iIgojIENPTkZJR19GV19MT0FERVJfVVNFUl9IRUxQRVIgaXMgbm90IHNldAoj
IENPTkZJR19GV19MT0FERVJfQ09NUFJFU1MgaXMgbm90IHNldAojIENPTkZJR19GV19VUExPQUQg
aXMgbm90IHNldAojIGVuZCBvZiBGaXJtd2FyZSBsb2FkZXIKCkNPTkZJR19BTExPV19ERVZfQ09S
RURVTVA9eQojIENPTkZJR19ERUJVR19EUklWRVIgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19E
RVZSRVMgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19URVNUX0RSSVZFUl9SRU1PVkUgaXMgbm90
IHNldAojIENPTkZJR19URVNUX0FTWU5DX0RSSVZFUl9QUk9CRSBpcyBub3Qgc2V0CkNPTkZJR19H
RU5FUklDX0NQVV9WVUxORVJBQklMSVRJRVM9eQojIENPTkZJR19GV19ERVZMSU5LX1NZTkNfU1RB
VEVfVElNRU9VVCBpcyBub3Qgc2V0CiMgZW5kIG9mIEdlbmVyaWMgRHJpdmVyIE9wdGlvbnMKCiMK
IyBCdXMgZGV2aWNlcwojCiMgQ09ORklHX01ISV9CVVMgaXMgbm90IHNldAojIENPTkZJR19NSElf
QlVTX0VQIGlzIG5vdCBzZXQKIyBlbmQgb2YgQnVzIGRldmljZXMKCiMKIyBDYWNoZSBEcml2ZXJz
CiMKIyBlbmQgb2YgQ2FjaGUgRHJpdmVycwoKIyBDT05GSUdfQ09OTkVDVE9SIGlzIG5vdCBzZXQK
CiMKIyBGaXJtd2FyZSBEcml2ZXJzCiMKCiMKIyBBUk0gU3lzdGVtIENvbnRyb2wgYW5kIE1hbmFn
ZW1lbnQgSW50ZXJmYWNlIFByb3RvY29sCiMKIyBlbmQgb2YgQVJNIFN5c3RlbSBDb250cm9sIGFu
ZCBNYW5hZ2VtZW50IEludGVyZmFjZSBQcm90b2NvbAoKIyBDT05GSUdfR09PR0xFX0ZJUk1XQVJF
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU1YX1NDTUlfTUlTQ19EUlYgaXMgbm90IHNldAoKIwojIFF1
YWxjb21tIGZpcm13YXJlIGRyaXZlcnMKIwojIGVuZCBvZiBRdWFsY29tbSBmaXJtd2FyZSBkcml2
ZXJzCgojCiMgVGVncmEgZmlybXdhcmUgZHJpdmVyCiMKIyBlbmQgb2YgVGVncmEgZmlybXdhcmUg
ZHJpdmVyCiMgZW5kIG9mIEZpcm13YXJlIERyaXZlcnMKCiMgQ09ORklHX0dOU1MgaXMgbm90IHNl
dAojIENPTkZJR19NVEQgaXMgbm90IHNldAojIENPTkZJR19PRiBpcyBub3Qgc2V0CkNPTkZJR19B
UkNIX01JR0hUX0hBVkVfUENfUEFSUE9SVD15CiMgQ09ORklHX1BBUlBPUlQgaXMgbm90IHNldApD
T05GSUdfUE5QPXkKQ09ORklHX1BOUF9ERUJVR19NRVNTQUdFUz15CgojCiMgUHJvdG9jb2xzCiMK
Q09ORklHX0lTQVBOUD15CkNPTkZJR19CTEtfREVWPXkKIyBDT05GSUdfQkxLX0RFVl9OVUxMX0JM
SyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0ZEPXkKIyBDT05GSUdfQkxLX0RFVl9GRF9SQVdD
TUQgaXMgbm90IHNldApDT05GSUdfQ0RST009eQojIENPTkZJR19CTEtfREVWX1BDSUVTU0RfTVRJ
UDMyWFggaXMgbm90IHNldAojIENPTkZJR19aUkFNIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZf
TE9PUD15CkNPTkZJR19CTEtfREVWX0xPT1BfTUlOX0NPVU5UPTgKIyBDT05GSUdfQkxLX0RFVl9E
UkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9OQkQgaXMgbm90IHNldAojIENPTkZJR19C
TEtfREVWX1JBTSBpcyBub3Qgc2V0CiMgQ09ORklHX0NEUk9NX1BLVENEVkQgaXMgbm90IHNldAoj
IENPTkZJR19BVEFfT1ZFUl9FVEggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1JCRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVUJMSyBpcyBub3Qgc2V0CgojCiMgTlZNRSBTdXBwb3J0
CiMKIyBDT05GSUdfQkxLX0RFVl9OVk1FIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZNRV9GQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05WTUVfVENQIGlzIG5vdCBzZXQKIyBlbmQgb2YgTlZNRSBTdXBwb3J0
CgojCiMgTWlzYyBkZXZpY2VzCiMKIyBDT05GSUdfRFVNTVlfSVJRIGlzIG5vdCBzZXQKIyBDT05G
SUdfUEhBTlRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1RJRk1fQ09SRSBpcyBub3Qgc2V0CiMgQ09O
RklHX0VOQ0xPU1VSRV9TRVJWSUNFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQX0lMTyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NSQU0gaXMgbm90IHNldAojIENPTkZJR19EV19YREFUQV9QQ0lFIGlzIG5v
dCBzZXQKIyBDT05GSUdfUENJX0VORFBPSU5UX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19YSUxJ
TlhfU0RGRUMgaXMgbm90IHNldAojIENPTkZJR19DMlBPUlQgaXMgbm90IHNldAoKIwojIEVFUFJP
TSBzdXBwb3J0CiMKIyBDT05GSUdfRUVQUk9NXzkzQ1g2IGlzIG5vdCBzZXQKIyBlbmQgb2YgRUVQ
Uk9NIHN1cHBvcnQKCiMgQ09ORklHX0NCNzEwX0NPUkUgaXMgbm90IHNldAoKIwojIFRleGFzIElu
c3RydW1lbnRzIHNoYXJlZCB0cmFuc3BvcnQgbGluZSBkaXNjaXBsaW5lCiMKIyBlbmQgb2YgVGV4
YXMgSW5zdHJ1bWVudHMgc2hhcmVkIHRyYW5zcG9ydCBsaW5lIGRpc2NpcGxpbmUKCiMKIyBBbHRl
cmEgRlBHQSBmaXJtd2FyZSBkb3dubG9hZCBtb2R1bGUgKHJlcXVpcmVzIEkyQykKIwojIENPTkZJ
R19HRU5XUUUgaXMgbm90IHNldAojIENPTkZJR19FQ0hPIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNN
X1ZLIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19BTENPUl9QQ0kgaXMgbm90IHNldAojIENPTkZJ
R19NSVNDX1JUU1hfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19SVFNYX1VTQiBpcyBub3Qg
c2V0CiMgQ09ORklHX1BWUEFOSUMgaXMgbm90IHNldAojIENPTkZJR19LRUJBX0NQNTAwIGlzIG5v
dCBzZXQKIyBlbmQgb2YgTWlzYyBkZXZpY2VzCgojCiMgU0NTSSBkZXZpY2Ugc3VwcG9ydAojCkNP
TkZJR19TQ1NJX01PRD15CiMgQ09ORklHX1JBSURfQVRUUlMgaXMgbm90IHNldApDT05GSUdfU0NT
SV9DT01NT049eQpDT05GSUdfU0NTST15CkNPTkZJR19TQ1NJX0RNQT15CkNPTkZJR19TQ1NJX1BS
T0NfRlM9eQoKIwojIFNDU0kgc3VwcG9ydCB0eXBlIChkaXNrLCB0YXBlLCBDRC1ST00pCiMKQ09O
RklHX0JMS19ERVZfU0Q9eQojIENPTkZJR19DSFJfREVWX1NUIGlzIG5vdCBzZXQKQ09ORklHX0JM
S19ERVZfU1I9eQojIENPTkZJR19DSFJfREVWX1NHIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RF
Vl9CU0cgaXMgbm90IHNldAojIENPTkZJR19DSFJfREVWX1NDSCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDU0lfQ09OU1RBTlRTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9MT0dHSU5HIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9TQ0FOX0FTWU5DIGlzIG5vdCBzZXQKCiMKIyBTQ1NJIFRyYW5zcG9y
dHMKIwojIENPTkZJR19TQ1NJX1NQSV9BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRkNf
QVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lTQ1NJX0FUVFJTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9TQVNfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBU19MSUJTQVMg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NSUF9BVFRSUyBpcyBub3Qgc2V0CiMgZW5kIG9mIFND
U0kgVHJhbnNwb3J0cwoKIyBDT05GSUdfU0NTSV9MT1dMRVZFTCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDU0lfREggaXMgbm90IHNldAojIGVuZCBvZiBTQ1NJIGRldmljZSBzdXBwb3J0CgpDT05GSUdf
QVRBPXkKQ09ORklHX1NBVEFfSE9TVD15CkNPTkZJR19QQVRBX1RJTUlOR1M9eQpDT05GSUdfQVRB
X1ZFUkJPU0VfRVJST1I9eQpDT05GSUdfQVRBX0ZPUkNFPXkKIyBDT05GSUdfU0FUQV9QTVAgaXMg
bm90IHNldAoKIwojIENvbnRyb2xsZXJzIHdpdGggbm9uLVNGRiBuYXRpdmUgaW50ZXJmYWNlCiMK
IyBDT05GSUdfU0FUQV9BSENJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9BSENJX1BMQVRGT1JN
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUhDSV9EV0MgaXMgbm90IHNldAojIENPTkZJR19TQVRBX0lO
SUMxNjJYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9BQ0FSRF9BSENJIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0FUQV9TSUwyNCBpcyBub3Qgc2V0CkNPTkZJR19BVEFfU0ZGPXkKCiMKIyBTRkYgY29u
dHJvbGxlcnMgd2l0aCBjdXN0b20gRE1BIGludGVyZmFjZQojCiMgQ09ORklHX1BEQ19BRE1BIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0FUQV9RU1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU1g0
IGlzIG5vdCBzZXQKQ09ORklHX0FUQV9CTURNQT15CgojCiMgU0FUQSBTRkYgY29udHJvbGxlcnMg
d2l0aCBCTURNQQojCiMgQ09ORklHX0FUQV9QSUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9N
ViBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfTlYgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1BS
T01JU0UgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NJTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NB
VEFfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TVlcgaXMgbm90IHNldAojIENPTkZJR19T
QVRBX1VMSSBpcyBub3Qgc2V0CkNPTkZJR19TQVRBX1ZJQT15CiMgQ09ORklHX1NBVEFfVklURVNT
RSBpcyBub3Qgc2V0CgojCiMgUEFUQSBTRkYgY29udHJvbGxlcnMgd2l0aCBCTURNQQojCkNPTkZJ
R19QQVRBX0FMST15CiMgQ09ORklHX1BBVEFfQU1EIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9B
UlRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9BVFA4NjdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DTUQ2NFggaXMgbm90IHNldAoj
IENPTkZJR19QQVRBX0NZUFJFU1MgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0VGQVIgaXMgbm90
IHNldAojIENPTkZJR19QQVRBX0hQVDM2NiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSFBUMzdY
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQzWDJOIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFU
QV9IUFQzWDMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0lUODIxMyBpcyBub3Qgc2V0CiMgQ09O
RklHX1BBVEFfSVQ4MjFYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9KTUlDUk9OIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9NQVJWRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9ORVRDRUxM
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OSU5KQTMyIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFU
QV9OUzg3NDE1IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PTERQSUlYIGlzIG5vdCBzZXQKIyBD
T05GSUdfUEFUQV9PUFRJRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QREMyMDI3WCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfUERDX09MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUkFE
SVNZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUkRDIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFU
QV9TQ0ggaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NFUlZFUldPUktTIGlzIG5vdCBzZXQKIyBD
T05GSUdfUEFUQV9TSUw2ODAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NJUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1BBVEFfVE9TSElCQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVFJJRkxFWCBp
cyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9XSU5C
T05EIGlzIG5vdCBzZXQKCiMKIyBQSU8tb25seSBTRkYgY29udHJvbGxlcnMKIwojIENPTkZJR19Q
QVRBX0NNRDY0MF9QQ0kgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0lTQVBOUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1BBVEFfTVBJSVggaXMgbm90IHNldAojIENPTkZJR19QQVRBX05TODc0MTAgaXMg
bm90IHNldAojIENPTkZJR19QQVRBX09QVEkgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1FESSBp
cyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUloxMDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9X
SU5CT05EX1ZMQiBpcyBub3Qgc2V0CgojCiMgR2VuZXJpYyBmYWxsYmFjayAvIGxlZ2FjeSBkcml2
ZXJzCiMKIyBDT05GSUdfQVRBX0dFTkVSSUMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0xFR0FD
WSBpcyBub3Qgc2V0CiMgQ09ORklHX01EIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFSR0VUX0NPUkUg
aXMgbm90IHNldAojIENPTkZJR19GVVNJT04gaXMgbm90IHNldAoKIwojIElFRUUgMTM5NCAoRmly
ZVdpcmUpIHN1cHBvcnQKIwojIENPTkZJR19GSVJFV0lSRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZJ
UkVXSVJFX05PU1kgaXMgbm90IHNldAojIGVuZCBvZiBJRUVFIDEzOTQgKEZpcmVXaXJlKSBzdXBw
b3J0CgpDT05GSUdfTkVUREVWSUNFUz15CkNPTkZJR19NSUk9eQpDT05GSUdfTkVUX0NPUkU9eQoj
IENPTkZJR19CT05ESU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfRFVNTVkgaXMgbm90IHNldAojIENP
TkZJR19XSVJFR1VBUkQgaXMgbm90IHNldAojIENPTkZJR19FUVVBTElaRVIgaXMgbm90IHNldAoj
IENPTkZJR19ORVRfRkMgaXMgbm90IHNldAojIENPTkZJR19ORVRfVEVBTSBpcyBub3Qgc2V0CiMg
Q09ORklHX01BQ1ZMQU4gaXMgbm90IHNldAojIENPTkZJR19JUFZMQU4gaXMgbm90IHNldAojIENP
TkZJR19WWExBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0dFTkVWRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0JBUkVVRFAgaXMgbm90IHNldAojIENPTkZJR19HVFAgaXMgbm90IHNldAojIENPTkZJR19QRkNQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfQU1UIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDU0VDIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUQ09OU09MRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RVTiBpcyBub3Qg
c2V0CiMgQ09ORklHX1RVTl9WTkVUX0NST1NTX0xFIGlzIG5vdCBzZXQKIyBDT05GSUdfVkVUSCBp
cyBub3Qgc2V0CiMgQ09ORklHX05MTU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDTkVUIGlzIG5v
dCBzZXQKQ09ORklHX0VUSEVSTkVUPXkKIyBDT05GSUdfTkVUX1ZFTkRPUl8zQ09NIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BREFQVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9BR0VSRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQUxBQ1JJVEVDSCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQUxURU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxU
RVJBX1RTRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQU1BWk9OIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX1ZFTkRPUl9BTUQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FR
VUFOVElBIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BUkMgaXMgbm90IHNldAojIENP
TkZJR19ORVRfVkVORE9SX0FTSVggaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FUSEVS
T1MgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0JST0FEQ09NIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1ZFTkRPUl9DQURFTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9D
QVZJVU0gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0NIRUxTSU8gaXMgbm90IHNldAoj
IENPTkZJR19ORVRfVkVORE9SX0NJUlJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1Jf
Q0lTQ08gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0NPUlRJTkEgaXMgbm90IHNldAoj
IENPTkZJR19ORVRfVkVORE9SX0RBVklDT00gaXMgbm90IHNldAojIENPTkZJR19ETkVUIGlzIG5v
dCBzZXQKQ09ORklHX05FVF9WRU5ET1JfREVDPXkKQ09ORklHX05FVF9UVUxJUD15CiMgQ09ORklH
X0RFMjEwNFggaXMgbm90IHNldApDT05GSUdfVFVMSVA9bQpDT05GSUdfVFVMSVBfTVdJPXkKQ09O
RklHX1RVTElQX01NSU89eQpDT05GSUdfVFVMSVBfTkFQST15CkNPTkZJR19UVUxJUF9OQVBJX0hX
X01JVElHQVRJT049eQojIENPTkZJR19XSU5CT05EXzg0MCBpcyBub3Qgc2V0CiMgQ09ORklHX0RN
OTEwMiBpcyBub3Qgc2V0CiMgQ09ORklHX1VMSTUyNlggaXMgbm90IHNldAojIENPTkZJR19ORVRf
VkVORE9SX0RMSU5LIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9FTVVMRVggaXMgbm90
IHNldAojIENPTkZJR19ORVRfVkVORE9SX0VOR0xFREVSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1ZFTkRPUl9FWkNISVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0ZVTkdJQkxFIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9HT09HTEUgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX0hVQVdFSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfSTgyNVhYIGlz
IG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfSU5URUw9eQpDT05GSUdfRTEwMD15CkNPTkZJR19F
MTAwMD15CiMgQ09ORklHX0UxMDAwRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lHQiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lHQlZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSVhHQkUgaXMgbm90IHNldAojIENP
TkZJR19JWEdCRVZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSTQwRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0k0MEVWRiBpcyBub3Qgc2V0CiMgQ09ORklHX0lDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZNMTBL
IGlzIG5vdCBzZXQKIyBDT05GSUdfSUdDIGlzIG5vdCBzZXQKIyBDT05GSUdfSURQRiBpcyBub3Qg
c2V0CiMgQ09ORklHX0pNRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTElURVggaXMg
bm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX01BUlZFTEwgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX01FTExBTk9YIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NRVRBIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NSUNSRUwgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX01JQ1JPQ0hJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTUlDUk9T
RU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NSUNST1NPRlQgaXMgbm90IHNldAoj
IENPTkZJR19ORVRfVkVORE9SX01ZUkkgaXMgbm90IHNldAojIENPTkZJR19GRUFMTlggaXMgbm90
IHNldAojIENPTkZJR19ORVRfVkVORE9SX05JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRP
Ul9OQVRTRU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9ORVRFUklPTiBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTkVUUk9OT01FIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1ZFTkRPUl9OVklESUEgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX09LSSBpcyBub3Qg
c2V0CiMgQ09ORklHX0VUSE9DIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9QQUNLRVRf
RU5HSU5FUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUEVOU0FORE8gaXMgbm90IHNl
dAojIENPTkZJR19ORVRfVkVORE9SX1FMT0dJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5E
T1JfQlJPQ0FERSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUVVBTENPTU0gaXMgbm90
IHNldAojIENPTkZJR19ORVRfVkVORE9SX1JEQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5E
T1JfUkVBTFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUkVORVNBUyBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUk9DS0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9TQU1TVU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TRUVRIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TSUxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5E
T1JfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TT0xBUkZMQVJFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TTVNDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRP
Ul9TT0NJT05FWFQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NUTUlDUk8gaXMgbm90
IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NVTiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5E
T1JfU1lOT1BTWVMgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1RFSFVUSSBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9WRU5ET1JfVEkgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9S
X1ZFUlRFWENPTSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfVklBIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX1ZFTkRPUl9XQU5HWFVOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRP
Ul9XSVpORVQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1hJTElOWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZEREkgaXMgbm90IHNldAojIENPTkZJR19ISVBQSSBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9TQjEwMDAgaXMgbm90IHNldApDT05GSUdfUEhZTElCPXkKIyBDT05GSUdfRklYRURf
UEhZIGlzIG5vdCBzZXQKCiMKIyBNSUkgUEhZIGRldmljZSBkcml2ZXJzCiMKIyBDT05GSUdfQUlS
X0VOODgxMUhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EX1BIWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0FESU5fUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQURJTjExMDBfUEhZIGlzIG5vdCBzZXQK
IyBDT05GSUdfQVFVQU5USUFfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQVg4ODc5NkJfUEhZIGlz
IG5vdCBzZXQKIyBDT05GSUdfQlJPQURDT01fUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNNNTQx
NDBfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNNN1hYWF9QSFkgaXMgbm90IHNldAojIENPTkZJ
R19CQ004NDg4MV9QSFkgaXMgbm90IHNldAojIENPTkZJR19CQ004N1hYX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0NJQ0FEQV9QSFkgaXMgbm90IHNldAojIENPTkZJR19DT1JUSU5BX1BIWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RBVklDT01fUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfSUNQTFVTX1BI
WSBpcyBub3Qgc2V0CiMgQ09ORklHX0xYVF9QSFkgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9Y
V0FZX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0xTSV9FVDEwMTFDX1BIWSBpcyBub3Qgc2V0CiMg
Q09ORklHX01BUlZFTExfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFSVkVMTF8xMEdfUEhZIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUFSVkVMTF84OFEyWFhYX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklH
X01BUlZFTExfODhYMjIyMl9QSFkgaXMgbm90IHNldAojIENPTkZJR19NQVhMSU5FQVJfR1BIWSBp
cyBub3Qgc2V0CiMgQ09ORklHX01FRElBVEVLX0dFX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01J
Q1JFTF9QSFkgaXMgbm90IHNldAojIENPTkZJR19NSUNST0NISVBfVDFTX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX01JQ1JPQ0hJUF9QSFkgaXMgbm90IHNldAojIENPTkZJR19NSUNST0NISVBfVDFf
UEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUk9TRU1JX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklH
X01PVE9SQ09NTV9QSFkgaXMgbm90IHNldAojIENPTkZJR19OQVRJT05BTF9QSFkgaXMgbm90IHNl
dAojIENPTkZJR19OWFBfQ0JUWF9QSFkgaXMgbm90IHNldAojIENPTkZJR19OWFBfQzQ1X1RKQTEx
WFhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTkNOMjYwMDBfUEhZIGlzIG5vdCBzZXQKIyBDT05G
SUdfUUNBODNYWF9QSFkgaXMgbm90IHNldAojIENPTkZJR19RQ0E4MDhYX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX1FTRU1JX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1JFQUxURUtfUEhZIGlzIG5v
dCBzZXQKIyBDT05GSUdfUkVORVNBU19QSFkgaXMgbm90IHNldAojIENPTkZJR19ST0NLQ0hJUF9Q
SFkgaXMgbm90IHNldAojIENPTkZJR19TTVNDX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NURTEw
WFAgaXMgbm90IHNldAojIENPTkZJR19URVJBTkVUSUNTX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0RQODM4MjJfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfRFA4M1RDODExX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0RQODM4NDhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfRFA4Mzg2N19QSFkgaXMg
bm90IHNldAojIENPTkZJR19EUDgzODY5X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODNURDUx
MF9QSFkgaXMgbm90IHNldAojIENPTkZJR19EUDgzVEc3MjBfUEhZIGlzIG5vdCBzZXQKIyBDT05G
SUdfVklURVNTRV9QSFkgaXMgbm90IHNldAojIENPTkZJR19YSUxJTlhfR01JSTJSR01JSSBpcyBu
b3Qgc2V0CkNPTkZJR19NRElPX0RFVklDRT15CkNPTkZJR19NRElPX0JVUz15CkNPTkZJR19NRElP
X0RFVlJFUz15CiMgQ09ORklHX01ESU9fQklUQkFORyBpcyBub3Qgc2V0CiMgQ09ORklHX01ESU9f
QkNNX1VOSU1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX01ESU9fTVZVU0IgaXMgbm90IHNldAojIENP
TkZJR19NRElPX1RIVU5ERVIgaXMgbm90IHNldAoKIwojIE1ESU8gTXVsdGlwbGV4ZXJzCiMKCiMK
IyBQQ1MgZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJR19QQ1NfWFBDUyBpcyBub3Qgc2V0CiMgZW5k
IG9mIFBDUyBkZXZpY2UgZHJpdmVycwoKIyBDT05GSUdfUFBQIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0xJUCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfTkVUX0RSSVZFUlM9eQojIENPTkZJR19VU0JfQ0FU
QyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfS0FXRVRIPXkKQ09ORklHX1VTQl9QRUdBU1VTPXkKQ09O
RklHX1VTQl9SVEw4MTUwPXkKQ09ORklHX1VTQl9SVEw4MTUyPXkKIyBDT05GSUdfVVNCX0xBTjc4
WFggaXMgbm90IHNldAojIENPTkZJR19VU0JfVVNCTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0lQSEVUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1dMQU4gaXMgbm90IHNldAojIENPTkZJR19XQU4g
aXMgbm90IHNldAoKIwojIFdpcmVsZXNzIFdBTgojCiMgQ09ORklHX1dXQU4gaXMgbm90IHNldAoj
IGVuZCBvZiBXaXJlbGVzcyBXQU4KCiMgQ09ORklHX1ZNWE5FVDMgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfRkFJTE9WRVIgaXMgbm90IHNldAojIENPTkZJR19JU0ROIGlzIG5vdCBzZXQKCiMKIyBJ
bnB1dCBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19JTlBVVD15CiMgQ09ORklHX0lOUFVUX0ZGX01F
TUxFU1MgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9TUEFSU0VLTUFQIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfTUFUUklYS01BUCBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9WSVZBTERJRk1B
UD15CgojCiMgVXNlcmxhbmQgaW50ZXJmYWNlcwojCkNPTkZJR19JTlBVVF9NT1VTRURFVj15CkNP
TkZJR19JTlBVVF9NT1VTRURFVl9QU0FVWD15CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5f
WD0xMDI0CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWT03NjgKIyBDT05GSUdfSU5QVVRf
Sk9ZREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfRVZERVYgaXMgbm90IHNldAojIENPTkZJ
R19JTlBVVF9FVkJVRyBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMKIwpDT05G
SUdfSU5QVVRfS0VZQk9BUkQ9eQpDT05GSUdfS0VZQk9BUkRfQVRLQkQ9eQojIENPTkZJR19LRVlC
T0FSRF9MS0tCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX05FV1RPTiBpcyBub3Qgc2V0
CiMgQ09ORklHX0tFWUJPQVJEX09QRU5DT1JFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJE
X1NUT1dBV0FZIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfU1VOS0JEIGlzIG5vdCBzZXQK
IyBDT05GSUdfS0VZQk9BUkRfWFRLQkQgaXMgbm90IHNldApDT05GSUdfSU5QVVRfTU9VU0U9eQpD
T05GSUdfTU9VU0VfUFMyPXkKQ09ORklHX01PVVNFX1BTMl9BTFBTPXkKQ09ORklHX01PVVNFX1BT
Ml9CWUQ9eQpDT05GSUdfTU9VU0VfUFMyX0xPR0lQUzJQUD15CkNPTkZJR19NT1VTRV9QUzJfU1lO
QVBUSUNTPXkKQ09ORklHX01PVVNFX1BTMl9DWVBSRVNTPXkKQ09ORklHX01PVVNFX1BTMl9UUkFD
S1BPSU5UPXkKIyBDT05GSUdfTU9VU0VfUFMyX0VMQU5URUNIIGlzIG5vdCBzZXQKIyBDT05GSUdf
TU9VU0VfUFMyX1NFTlRFTElDIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfUFMyX1RPVUNIS0lU
IGlzIG5vdCBzZXQKQ09ORklHX01PVVNFX1BTMl9GT0NBTFRFQ0g9eQojIENPTkZJR19NT1VTRV9T
RVJJQUwgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9BUFBMRVRPVUNIIGlzIG5vdCBzZXQKIyBD
T05GSUdfTU9VU0VfQkNNNTk3NCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0lOUE9SVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01PVVNFX0xPR0lCTSBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1BD
MTEwUEFEIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfVlNYWFhBQSBpcyBub3Qgc2V0CiMgQ09O
RklHX01PVVNFX1NZTkFQVElDU19VU0IgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9KT1lTVElD
SyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RBQkxFVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
UFVUX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfTUlTQyBpcyBub3Qgc2V0
CiMgQ09ORklHX1JNSTRfQ09SRSBpcyBub3Qgc2V0CgojCiMgSGFyZHdhcmUgSS9PIHBvcnRzCiMK
Q09ORklHX1NFUklPPXkKQ09ORklHX0FSQ0hfTUlHSFRfSEFWRV9QQ19TRVJJTz15CkNPTkZJR19T
RVJJT19JODA0Mj15CkNPTkZJR19TRVJJT19TRVJQT1JUPXkKIyBDT05GSUdfU0VSSU9fUENJUFMy
IGlzIG5vdCBzZXQKQ09ORklHX1NFUklPX0xJQlBTMj15CiMgQ09ORklHX1NFUklPX1JBVyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFUklPX0FMVEVSQV9QUzIgaXMgbm90IHNldAojIENPTkZJR19TRVJJ
T19QUzJNVUxUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fQVJDX1BTMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTRVJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0dBTUVQT1JUIGlzIG5vdCBzZXQKIyBl
bmQgb2YgSGFyZHdhcmUgSS9PIHBvcnRzCiMgZW5kIG9mIElucHV0IGRldmljZSBzdXBwb3J0Cgoj
CiMgQ2hhcmFjdGVyIGRldmljZXMKIwpDT05GSUdfVFRZPXkKQ09ORklHX1ZUPXkKQ09ORklHX0NP
TlNPTEVfVFJBTlNMQVRJT05TPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdfVlRfSFdfQ09O
U09MRV9CSU5ESU5HPXkKQ09ORklHX1VOSVg5OF9QVFlTPXkKQ09ORklHX0xFR0FDWV9QVFlTPXkK
Q09ORklHX0xFR0FDWV9QVFlfQ09VTlQ9MjU2CkNPTkZJR19MRUdBQ1lfVElPQ1NUST15CkNPTkZJ
R19MRElTQ19BVVRPTE9BRD15CgojCiMgU2VyaWFsIGRyaXZlcnMKIwpDT05GSUdfU0VSSUFMX0VB
UkxZQ09OPXkKQ09ORklHX1NFUklBTF84MjUwPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBfREVQUkVD
QVRFRF9PUFRJT05TIGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF84MjUwX1BOUD15CkNPTkZJR19T
RVJJQUxfODI1MF8xNjU1MEFfVkFSSUFOVFM9eQojIENPTkZJR19TRVJJQUxfODI1MF9GSU5URUsg
aXMgbm90IHNldApDT05GSUdfU0VSSUFMXzgyNTBfQ09OU09MRT15CiMgQ09ORklHX1NFUklBTF84
MjUwX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX0VYQVIgaXMgbm90IHNldApD
T05GSUdfU0VSSUFMXzgyNTBfTlJfVUFSVFM9NApDT05GSUdfU0VSSUFMXzgyNTBfUlVOVElNRV9V
QVJUUz00CiMgQ09ORklHX1NFUklBTF84MjUwX0VYVEVOREVEIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VSSUFMXzgyNTBfUENJMVhYWFggaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfODI1MF9EVyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX1JUMjg4WCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFUklBTF84MjUwX1BFUklDT00gaXMgbm90IHNldAoKIwojIE5vbi04MjUwIHNlcmlhbCBwb3J0
IHN1cHBvcnQKIwojIENPTkZJR19TRVJJQUxfVUFSVExJVEUgaXMgbm90IHNldApDT05GSUdfU0VS
SUFMX0NPUkU9eQpDT05GSUdfU0VSSUFMX0NPUkVfQ09OU09MRT15CiMgQ09ORklHX1NFUklBTF9K
U00gaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfU0NDTlhQIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VSSUFMX0FMVEVSQV9KVEFHVUFSVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9BTFRFUkFf
VUFSVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9BUkMgaXMgbm90IHNldAojIENPTkZJR19T
RVJJQUxfUlAyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0ZTTF9MUFVBUlQgaXMgbm90IHNl
dAojIENPTkZJR19TRVJJQUxfRlNMX0xJTkZMRVhVQVJUIGlzIG5vdCBzZXQKIyBlbmQgb2YgU2Vy
aWFsIGRyaXZlcnMKCiMgQ09ORklHX1NFUklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0CiMgQ09O
RklHX05fR1NNIGlzIG5vdCBzZXQKIyBDT05GSUdfTk9aT01JIGlzIG5vdCBzZXQKIyBDT05GSUdf
TlVMTF9UVFkgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfREVWX0JVUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1ZJUlRJT19DT05TT0xFIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBNSV9IQU5ETEVSIGlz
IG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9NIGlzIG5vdCBzZXQKIyBDT05GSUdfRFRMSyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FQUExJQ09NIGlzIG5vdCBzZXQKQ09ORklHX0RFVk1FTT15CkNPTkZJ
R19ERVZQT1JUPXkKIyBDT05GSUdfVENHX1RQTSBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTExZQlVT
IGlzIG5vdCBzZXQKIyBDT05GSUdfWElMTFlVU0IgaXMgbm90IHNldAojIGVuZCBvZiBDaGFyYWN0
ZXIgZGV2aWNlcwoKIwojIEkyQyBzdXBwb3J0CiMKIyBDT05GSUdfSTJDIGlzIG5vdCBzZXQKIyBl
bmQgb2YgSTJDIHN1cHBvcnQKCiMgQ09ORklHX0kzQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NQTUkgaXMgbm90IHNldAojIENPTkZJR19IU0kgaXMgbm90IHNl
dApDT05GSUdfUFBTPXkKIyBDT05GSUdfUFBTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTlRQ
X1BQUyBpcyBub3Qgc2V0CgojCiMgUFBTIGNsaWVudHMgc3VwcG9ydAojCiMgQ09ORklHX1BQU19D
TElFTlRfS1RJTUVSIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBTX0NMSUVOVF9MRElTQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BQU19DTElFTlRfR1BJTyBpcyBub3Qgc2V0CgojCiMgUFBTIGdlbmVyYXRv
cnMgc3VwcG9ydAojCgojCiMgUFRQIGNsb2NrIHN1cHBvcnQKIwpDT05GSUdfUFRQXzE1ODhfQ0xP
Q0s9eQpDT05GSUdfUFRQXzE1ODhfQ0xPQ0tfT1BUSU9OQUw9eQoKIwojIEVuYWJsZSBQSFlMSUIg
YW5kIE5FVFdPUktfUEhZX1RJTUVTVEFNUElORyB0byBzZWUgdGhlIGFkZGl0aW9uYWwgY2xvY2tz
LgojCiMgQ09ORklHX1BUUF8xNTg4X0NMT0NLX01PQ0sgaXMgbm90IHNldAojIGVuZCBvZiBQVFAg
Y2xvY2sgc3VwcG9ydAoKIyBDT05GSUdfUElOQ1RSTCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9M
SUIgaXMgbm90IHNldAojIENPTkZJR19XMSBpcyBub3Qgc2V0CiMgQ09ORklHX1BPV0VSX1JFU0VU
IGlzIG5vdCBzZXQKIyBDT05GSUdfUE9XRVJfU0VRVUVOQ0lORyBpcyBub3Qgc2V0CiMgQ09ORklH
X1BPV0VSX1NVUFBMWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hXTU9OIGlzIG5vdCBzZXQKIyBDT05G
SUdfVEhFUk1BTCBpcyBub3Qgc2V0CiMgQ09ORklHX1dBVENIRE9HIGlzIG5vdCBzZXQKQ09ORklH
X1NTQl9QT1NTSUJMRT15CiMgQ09ORklHX1NTQiBpcyBub3Qgc2V0CkNPTkZJR19CQ01BX1BPU1NJ
QkxFPXkKIyBDT05GSUdfQkNNQSBpcyBub3Qgc2V0CgojCiMgTXVsdGlmdW5jdGlvbiBkZXZpY2Ug
ZHJpdmVycwojCiMgQ09ORklHX01GRF9NQURFUkEgaXMgbm90IHNldAojIENPTkZJR19NRkRfRExO
MiBpcyBub3Qgc2V0CiMgQ09ORklHX0xQQ19JQ0ggaXMgbm90IHNldAojIENPTkZJR19MUENfU0NI
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0pBTlpfQ01PRElPIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX0tFTVBMRCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NVDYzOTcgaXMgbm90IHNldAojIENP
TkZJR19NRkRfVklQRVJCT0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SREMzMjFYIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1NNNTAxIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NZU0NPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9UUU1YODYgaXMgbm90IHNldAojIENPTkZJR19NRkRfVlg4
NTUgaXMgbm90IHNldAojIGVuZCBvZiBNdWx0aWZ1bmN0aW9uIGRldmljZSBkcml2ZXJzCgojIENP
TkZJR19SRUdVTEFUT1IgaXMgbm90IHNldAojIENPTkZJR19SQ19DT1JFIGlzIG5vdCBzZXQKCiMK
IyBDRUMgc3VwcG9ydAojCiMgQ09ORklHX01FRElBX0NFQ19TVVBQT1JUIGlzIG5vdCBzZXQKIyBl
bmQgb2YgQ0VDIHN1cHBvcnQKCiMgQ09ORklHX01FRElBX1NVUFBPUlQgaXMgbm90IHNldAoKIwoj
IEdyYXBoaWNzIHN1cHBvcnQKIwpDT05GSUdfQVBFUlRVUkVfSEVMUEVSUz15CkNPTkZJR19WSURF
Tz15CiMgQ09ORklHX0FVWERJU1BMQVkgaXMgbm90IHNldAojIENPTkZJR19BR1AgaXMgbm90IHNl
dAojIENPTkZJR19EUk0gaXMgbm90IHNldAoKIwojIEZyYW1lIGJ1ZmZlciBEZXZpY2VzCiMKQ09O
RklHX0ZCPXkKIyBDT05GSUdfRkJfQ0lSUlVTIGlzIG5vdCBzZXQKQ09ORklHX0ZCX1BNMj15CkNP
TkZJR19GQl9QTTJfRklGT19ESVNDT05ORUNUPXkKIyBDT05GSUdfRkJfQ1lCRVIyMDAwIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfQVNJTElBTlQgaXMgbm90IHNldAojIENPTkZJR19GQl9JTVNUVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX1RHQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX09QRU5DT1JF
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1MxRDEzWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
TlZJRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUklWQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
X0k3NDAgaXMgbm90IHNldAojIENPTkZJR19GQl9NQVRST1ggaXMgbm90IHNldAojIENPTkZJR19G
Ql9SQURFT04gaXMgbm90IHNldAojIENPTkZJR19GQl9BVFkxMjggaXMgbm90IHNldAojIENPTkZJ
R19GQl9BVFkgaXMgbm90IHNldAojIENPTkZJR19GQl9TMyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
X1NBVkFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
X05FT01BR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfS1lSTyBpcyBub3Qgc2V0CiMgQ09ORklH
X0ZCXzNERlggaXMgbm90IHNldAojIENPTkZJR19GQl9WT09ET08xIGlzIG5vdCBzZXQKIyBDT05G
SUdfRkJfVlQ4NjIzIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVFJJREVOVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZCX0FSSyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1BNMyBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX0NBUk1JTkUgaXMgbm90IHNldAojIENPTkZJR19GQl9TTVNDVUZYIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfVURMIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSUJNX0dYVDQ1MDAgaXMgbm90
IHNldAojIENPTkZJR19GQl9WSVJUVUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTUVUUk9OT01F
IGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTUI4NjJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NJ
TVBMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NNNzEyIGlzIG5vdCBzZXQKQ09ORklHX0ZCX0NP
UkU9eQpDT05GSUdfRkJfTk9USUZZPXkKIyBDT05GSUdfRklSTVdBUkVfRURJRCBpcyBub3Qgc2V0
CkNPTkZJR19GQl9ERVZJQ0U9eQpDT05GSUdfRkJfQ0ZCX0ZJTExSRUNUPXkKQ09ORklHX0ZCX0NG
Ql9DT1BZQVJFQT15CkNPTkZJR19GQl9DRkJfSU1BR0VCTElUPXkKIyBDT05GSUdfRkJfRk9SRUlH
Tl9FTkRJQU4gaXMgbm90IHNldApDT05GSUdfRkJfSU9NRU1fRk9QUz15CiMgQ09ORklHX0ZCX01P
REVfSEVMUEVSUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1RJTEVCTElUVElORyBpcyBub3Qgc2V0
CiMgZW5kIG9mIEZyYW1lIGJ1ZmZlciBEZXZpY2VzCgojCiMgQmFja2xpZ2h0ICYgTENEIGRldmlj
ZSBzdXBwb3J0CiMKIyBDT05GSUdfTENEX0NMQVNTX0RFVklDRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0JBQ0tMSUdIVF9DTEFTU19ERVZJQ0UgaXMgbm90IHNldAojIGVuZCBvZiBCYWNrbGlnaHQgJiBM
Q0QgZGV2aWNlIHN1cHBvcnQKCiMKIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKIwpD
T05GSUdfVkdBX0NPTlNPTEU9eQojIENPTkZJR19NREFfQ09OU09MRSBpcyBub3Qgc2V0CkNPTkZJ
R19EVU1NWV9DT05TT0xFX0NPTFVNTlM9ODAKQ09ORklHX0RVTU1ZX0NPTlNPTEVfUk9XUz0yNQpD
T05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRT15CiMgQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVf
TEVHQUNZX0FDQ0VMRVJBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNP
TEVfREVURUNUX1BSSU1BUlkgaXMgbm90IHNldAojIENPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xF
X1JPVEFUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRV9ERUZFUlJF
RF9UQUtFT1ZFUiBpcyBub3Qgc2V0CiMgZW5kIG9mIENvbnNvbGUgZGlzcGxheSBkcml2ZXIgc3Vw
cG9ydAoKQ09ORklHX0xPR089eQpDT05GSUdfTE9HT19MSU5VWF9NT05PPXkKQ09ORklHX0xPR09f
TElOVVhfVkdBMTY9eQpDT05GSUdfTE9HT19MSU5VWF9DTFVUMjI0PXkKQ09ORklHX0xPR09fREVD
X0NMVVQyMjQ9eQojIGVuZCBvZiBHcmFwaGljcyBzdXBwb3J0CgojIENPTkZJR19TT1VORCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9TVVBQT1JUIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9PSENJX0xJ
VFRMRV9FTkRJQU49eQpDT05GSUdfVVNCX1NVUFBPUlQ9eQpDT05GSUdfVVNCX0NPTU1PTj15CiMg
Q09ORklHX1VTQl9VTFBJX0JVUyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfQVJDSF9IQVNfSENEPXkK
Q09ORklHX1VTQj15CkNPTkZJR19VU0JfUENJPXkKIyBDT05GSUdfVVNCX1BDSV9BTUQgaXMgbm90
IHNldApDT05GSUdfVVNCX0FOTk9VTkNFX05FV19ERVZJQ0VTPXkKCiMKIyBNaXNjZWxsYW5lb3Vz
IFVTQiBvcHRpb25zCiMKQ09ORklHX1VTQl9ERUZBVUxUX1BFUlNJU1Q9eQojIENPTkZJR19VU0Jf
RkVXX0lOSVRfUkVUUklFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9EWU5BTUlDX01JTk9SUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PVEdfUFJPRFVDVExJU1QgaXMgbm90IHNldApDT05GSUdf
VVNCX0FVVE9TVVNQRU5EX0RFTEFZPTIKQ09ORklHX1VTQl9ERUZBVUxUX0FVVEhPUklaQVRJT05f
TU9ERT0xCiMgQ09ORklHX1VTQl9NT04gaXMgbm90IHNldAoKIwojIFVTQiBIb3N0IENvbnRyb2xs
ZXIgRHJpdmVycwojCiMgQ09ORklHX1VTQl9DNjdYMDBfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1hIQ0lfSENEIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9FSENJX0hDRD15CkNPTkZJR19VU0Jf
RUhDSV9ST09UX0hVQl9UVD15CkNPTkZJR19VU0JfRUhDSV9UVF9ORVdTQ0hFRD15CkNPTkZJR19V
U0JfRUhDSV9QQ0k9eQojIENPTkZJR19VU0JfRUhDSV9GU0wgaXMgbm90IHNldAojIENPTkZJR19V
U0JfRUhDSV9IQ0RfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19VU0JfT1hVMjEwSFBfSENE
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDExNlhfSENEIGlzIG5vdCBzZXQKQ09ORklHX1VT
Ql9PSENJX0hDRD15CkNPTkZJR19VU0JfT0hDSV9IQ0RfUENJPXkKQ09ORklHX1VTQl9PSENJX0hD
RF9QTEFURk9STT15CkNPTkZJR19VU0JfVUhDSV9IQ0Q9eQojIENPTkZJR19VU0JfU0w4MTFfSENE
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1I4QTY2NTk3X0hDRCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9IQ0RfVEVTVF9NT0RFIGlzIG5vdCBzZXQKCiMKIyBVU0IgRGV2aWNlIENsYXNzIGRyaXZl
cnMKIwojIENPTkZJR19VU0JfQUNNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1BSSU5URVIgaXMg
bm90IHNldAojIENPTkZJR19VU0JfV0RNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1RNQyBpcyBu
b3Qgc2V0CgojCiMgTk9URTogVVNCX1NUT1JBR0UgZGVwZW5kcyBvbiBTQ1NJIGJ1dCBCTEtfREVW
X1NEIG1heQojCgojCiMgYWxzbyBiZSBuZWVkZWQ7IHNlZSBVU0JfU1RPUkFHRSBIZWxwIGZvciBt
b3JlIGluZm8KIwpDT05GSUdfVVNCX1NUT1JBR0U9eQojIENPTkZJR19VU0JfU1RPUkFHRV9ERUJV
RyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU1RPUkFHRV9SRUFMVEVLPXkKIyBDT05GSUdfVVNCX1NU
T1JBR0VfREFUQUZBQiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0ZSRUVDT00gaXMg
bm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9JU0QyMDAgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU1RPUkFHRV9VU0JBVCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU1RPUkFHRV9TRERSMDk9eQpD
T05GSUdfVVNCX1NUT1JBR0VfU0REUjU1PXkKIyBDT05GSUdfVVNCX1NUT1JBR0VfSlVNUFNIT1Qg
aXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9BTEFVREEgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfU1RPUkFHRV9PTkVUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0tB
Uk1BIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfQ1lQUkVTU19BVEFDQiBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0VORV9VQjYyNTAgaXMgbm90IHNldApDT05GSUdfVVNC
X1VBUz15CgojCiMgVVNCIEltYWdpbmcgZGV2aWNlcwojCiMgQ09ORklHX1VTQl9NREM4MDAgaXMg
bm90IHNldAojIENPTkZJR19VU0JfTUlDUk9URUsgaXMgbm90IHNldAojIENPTkZJR19VU0JJUF9D
T1JFIGlzIG5vdCBzZXQKCiMKIyBVU0IgZHVhbC1tb2RlIGNvbnRyb2xsZXIgZHJpdmVycwojCiMg
Q09ORklHX1VTQl9DRE5TX1NVUFBPUlQgaXMgbm90IHNldAojIENPTkZJR19VU0JfTVVTQl9IRFJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RXQzMgaXMgbm90IHNldAojIENPTkZJR19VU0JfRFdD
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DSElQSURFQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9JU1AxNzYwIGlzIG5vdCBzZXQKCiMKIyBVU0IgcG9ydCBkcml2ZXJzCiMKQ09ORklHX1VTQl9T
RVJJQUw9eQpDT05GSUdfVVNCX1NFUklBTF9DT05TT0xFPXkKQ09ORklHX1VTQl9TRVJJQUxfR0VO
RVJJQz15CiMgQ09ORklHX1VTQl9TRVJJQUxfU0lNUExFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9BSVJDQUJMRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQVJLMzExNiBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQkVMS0lOIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9DSDM0MSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfV0hJVEVIRUFU
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9ESUdJX0FDQ0VMRVBPUlQgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX0NQMjEwWCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJ
QUxfQ1lQUkVTU19NOCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRU1QRUcgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0ZURElfU0lPIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9WSVNPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfSVBBUSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfSVIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFM
X0VER0VQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9FREdFUE9SVF9USSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRjgxMjMyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9GODE1M1ggaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0dBUk1JTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfSVBXIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NF
UklBTF9JVVUgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fUERBIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9LTFNJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LT0JJTF9TQ1QgaXMg
bm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX01DVF9VMjMyIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9NRVRSTyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTU9TNzcyMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTU9TNzg0MCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9TRVJJQUxfTVhVUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTkFWTUFO
IGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TRVJJQUxfUEwyMzAzPXkKIyBDT05GSUdfVVNCX1NFUklB
TF9PVEk2ODU4IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9RQ0FVWCBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9TRVJJQUxfUVVBTENPTU0gaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VS
SUFMX1NQQ1A4WDUgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1NBRkUgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX1NJRVJSQVdJUkVMRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9TWU1CT0wgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1RJIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9DWUJFUkpBQ0sgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU0VSSUFMX09QVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfT01OSU5FVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfT1BUSUNPTiBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9TRVJJQUxfWFNFTlNfTVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1dJU0hC
T05FIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9TU1UxMDAgaXMgbm90IHNldAojIENP
TkZJR19VU0JfU0VSSUFMX1FUMiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfVVBENzhG
MDczMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfWFIgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfU0VSSUFMX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBVU0IgTWlzY2VsbGFuZW91cyBkcml2
ZXJzCiMKIyBDT05GSUdfVVNCX0VNSTYyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0VNSTI2IGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0FEVVRVWCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVZT
RUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEVHT1RPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0xDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DWVBSRVNTX0NZN0M2MyBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9DWVRIRVJNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lETU9VU0UgaXMg
bm90IHNldAojIENPTkZJR19VU0JfQVBQTEVESVNQTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQ
TEVfTUZJX0ZBU1RDSEFSR0UgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0lTVVNCVkdBIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1RSQU5DRVZJQlJB
VE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lPV0FSUklPUiBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0VIU0VUX1RFU1RfRklYVFVSRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9JU0lHSFRGVyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ZVVJF
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FWlVTQl9GWDIgaXMgbm90IHNldAojIENPTkZJR19V
U0JfTElOS19MQVlFUl9URVNUIGlzIG5vdCBzZXQKCiMKIyBVU0IgUGh5c2ljYWwgTGF5ZXIgZHJp
dmVycwojCiMgQ09ORklHX05PUF9VU0JfWENFSVYgaXMgbm90IHNldAojIGVuZCBvZiBVU0IgUGh5
c2ljYWwgTGF5ZXIgZHJpdmVycwoKIyBDT05GSUdfVVNCX0dBREdFVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RZUEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JPTEVfU1dJVENIIGlzIG5vdCBzZXQK
IyBDT05GSUdfTU1DIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9VRlNIQ0QgaXMgbm90IHNldAoj
IENPTkZJR19NRU1TVElDSyBpcyBub3Qgc2V0CiMgQ09ORklHX05FV19MRURTIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUNDRVNTSUJJTElUWSBpcyBub3Qgc2V0CkNPTkZJR19SVENfTElCPXkKQ09ORklH
X1JUQ19NQzE0NjgxOF9MSUI9eQpDT05GSUdfUlRDX0NMQVNTPXkKQ09ORklHX1JUQ19IQ1RPU1lT
PXkKQ09ORklHX1JUQ19IQ1RPU1lTX0RFVklDRT0icnRjMCIKQ09ORklHX1JUQ19TWVNUT0hDPXkK
Q09ORklHX1JUQ19TWVNUT0hDX0RFVklDRT0icnRjMCIKIyBDT05GSUdfUlRDX0RFQlVHIGlzIG5v
dCBzZXQKQ09ORklHX1JUQ19OVk1FTT15CgojCiMgUlRDIGludGVyZmFjZXMKIwpDT05GSUdfUlRD
X0lOVEZfU1lTRlM9eQpDT05GSUdfUlRDX0lOVEZfUFJPQz15CkNPTkZJR19SVENfSU5URl9ERVY9
eQojIENPTkZJR19SVENfSU5URl9ERVZfVUlFX0VNVUwgaXMgbm90IHNldAojIENPTkZJR19SVENf
RFJWX1RFU1QgaXMgbm90IHNldAoKIwojIEkyQyBSVEMgZHJpdmVycwojCgojCiMgU1BJIFJUQyBk
cml2ZXJzCiMKCiMKIyBTUEkgYW5kIEkyQyBSVEMgZHJpdmVycwojCgojCiMgUGxhdGZvcm0gUlRD
IGRyaXZlcnMKIwpDT05GSUdfUlRDX0RSVl9BTFBIQT15CiMgQ09ORklHX1JUQ19EUlZfRFMxMjg2
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE1MTEgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX0RTMTU1MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNjg1X0ZBTUlMWSBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNzQyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9EUzI0MDQgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1NUSzE3VEE4IGlzIG5vdCBz
ZXQKQ09ORklHX1JUQ19EUlZfTTQ4VDg2PXkKIyBDT05GSUdfUlRDX0RSVl9NNDhUMzUgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX000OFQ1OSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
TVNNNjI0MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlA1QzAxIGlzIG5vdCBzZXQKCiMK
IyBvbi1DUFUgUlRDIGRyaXZlcnMKIwojIENPTkZJR19SVENfRFJWX0ZUUlRDMDEwIGlzIG5vdCBz
ZXQKCiMKIyBISUQgU2Vuc29yIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfUlRDX0RSVl9HT0xERklT
SCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQURFVklDRVMgaXMgbm90IHNldAoKIwojIERNQUJVRiBv
cHRpb25zCiMKIyBDT05GSUdfU1lOQ19GSUxFIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1BQlVGX0hF
QVBTIGlzIG5vdCBzZXQKIyBlbmQgb2YgRE1BQlVGIG9wdGlvbnMKCiMgQ09ORklHX1VJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZGSU8gaXMgbm90IHNldAojIENPTkZJR19WSVJUX0RSSVZFUlMgaXMg
bm90IHNldAojIENPTkZJR19WSVJUSU9fTUVOVSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZEUEEgaXMg
bm90IHNldAojIENPTkZJR19WSE9TVF9NRU5VIGlzIG5vdCBzZXQKCiMKIyBNaWNyb3NvZnQgSHlw
ZXItViBndWVzdCBzdXBwb3J0CiMKIyBlbmQgb2YgTWljcm9zb2Z0IEh5cGVyLVYgZ3Vlc3Qgc3Vw
cG9ydAoKIyBDT05GSUdfR1JFWUJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTUVESSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NUQUdJTkcgaXMgbm90IHNldAojIENPTkZJR19HT0xERklTSCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NaTklDX1BMQVRGT1JNUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTU1PTl9D
TEsgaXMgbm90IHNldApDT05GSUdfSFdTUElOTE9DSz15CgojCiMgQ2xvY2sgU291cmNlIGRyaXZl
cnMKIwpDT05GSUdfSTgyNTNfTE9DSz15CkNPTkZJR19DTEtCTERfSTgyNTM9eQojIGVuZCBvZiBD
bG9jayBTb3VyY2UgZHJpdmVycwoKIyBDT05GSUdfTUFJTEJPWCBpcyBub3Qgc2V0CkNPTkZJR19J
T01NVV9TVVBQT1JUPXkKCiMKIyBHZW5lcmljIElPTU1VIFBhZ2V0YWJsZSBTdXBwb3J0CiMKIyBl
bmQgb2YgR2VuZXJpYyBJT01NVSBQYWdldGFibGUgU3VwcG9ydAoKIyBDT05GSUdfSU9NTVVGRCBp
cyBub3Qgc2V0CgojCiMgUmVtb3RlcHJvYyBkcml2ZXJzCiMKIyBDT05GSUdfUkVNT1RFUFJPQyBp
cyBub3Qgc2V0CiMgZW5kIG9mIFJlbW90ZXByb2MgZHJpdmVycwoKIwojIFJwbXNnIGRyaXZlcnMK
IwojIENPTkZJR19SUE1TR19WSVJUSU8gaXMgbm90IHNldAojIGVuZCBvZiBScG1zZyBkcml2ZXJz
CgojCiMgU09DIChTeXN0ZW0gT24gQ2hpcCkgc3BlY2lmaWMgRHJpdmVycwojCgojCiMgQW1sb2dp
YyBTb0MgZHJpdmVycwojCiMgZW5kIG9mIEFtbG9naWMgU29DIGRyaXZlcnMKCiMKIyBCcm9hZGNv
bSBTb0MgZHJpdmVycwojCiMgZW5kIG9mIEJyb2FkY29tIFNvQyBkcml2ZXJzCgojCiMgTlhQL0Zy
ZWVzY2FsZSBRb3JJUSBTb0MgZHJpdmVycwojCiMgZW5kIG9mIE5YUC9GcmVlc2NhbGUgUW9ySVEg
U29DIGRyaXZlcnMKCiMKIyBmdWppdHN1IFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgZnVqaXRzdSBT
b0MgZHJpdmVycwoKIwojIGkuTVggU29DIGRyaXZlcnMKIwojIGVuZCBvZiBpLk1YIFNvQyBkcml2
ZXJzCgojCiMgRW5hYmxlIExpdGVYIFNvQyBCdWlsZGVyIHNwZWNpZmljIGRyaXZlcnMKIwojIGVu
ZCBvZiBFbmFibGUgTGl0ZVggU29DIEJ1aWxkZXIgc3BlY2lmaWMgZHJpdmVycwoKIyBDT05GSUdf
V1BDTTQ1MF9TT0MgaXMgbm90IHNldAoKIwojIFF1YWxjb21tIFNvQyBkcml2ZXJzCiMKIyBlbmQg
b2YgUXVhbGNvbW0gU29DIGRyaXZlcnMKCiMgQ09ORklHX1NPQ19USSBpcyBub3Qgc2V0CgojCiMg
WGlsaW54IFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgWGlsaW54IFNvQyBkcml2ZXJzCiMgZW5kIG9m
IFNPQyAoU3lzdGVtIE9uIENoaXApIHNwZWNpZmljIERyaXZlcnMKCiMKIyBQTSBEb21haW5zCiMK
CiMKIyBBbWxvZ2ljIFBNIERvbWFpbnMKIwojIGVuZCBvZiBBbWxvZ2ljIFBNIERvbWFpbnMKCiMK
IyBCcm9hZGNvbSBQTSBEb21haW5zCiMKIyBlbmQgb2YgQnJvYWRjb20gUE0gRG9tYWlucwoKIwoj
IGkuTVggUE0gRG9tYWlucwojCiMgZW5kIG9mIGkuTVggUE0gRG9tYWlucwoKIwojIFF1YWxjb21t
IFBNIERvbWFpbnMKIwojIGVuZCBvZiBRdWFsY29tbSBQTSBEb21haW5zCiMgZW5kIG9mIFBNIERv
bWFpbnMKCiMgQ09ORklHX1BNX0RFVkZSRVEgaXMgbm90IHNldAojIENPTkZJR19FWFRDT04gaXMg
bm90IHNldAojIENPTkZJR19NRU1PUlkgaXMgbm90IHNldAojIENPTkZJR19JSU8gaXMgbm90IHNl
dAojIENPTkZJR19OVEIgaXMgbm90IHNldAojIENPTkZJR19QV00gaXMgbm90IHNldAoKIwojIElS
USBjaGlwIHN1cHBvcnQKIwojIENPTkZJR19MQU45NjZYX09JQyBpcyBub3Qgc2V0CiMgZW5kIG9m
IElSUSBjaGlwIHN1cHBvcnQKCiMgQ09ORklHX0lQQUNLX0JVUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1JFU0VUX0NPTlRST0xMRVIgaXMgbm90IHNldAoKIwojIFBIWSBTdWJzeXN0ZW0KIwojIENPTkZJ
R19HRU5FUklDX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1BIWV9DQU5fVFJBTlNDRUlWRVIgaXMg
bm90IHNldAoKIwojIFBIWSBkcml2ZXJzIGZvciBCcm9hZGNvbSBwbGF0Zm9ybXMKIwojIENPTkZJ
R19CQ01fS09OQV9VU0IyX1BIWSBpcyBub3Qgc2V0CiMgZW5kIG9mIFBIWSBkcml2ZXJzIGZvciBC
cm9hZGNvbSBwbGF0Zm9ybXMKCiMgQ09ORklHX1BIWV9QWEFfMjhOTV9IU0lDIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEhZX1BYQV8yOE5NX1VTQjIgaXMgbm90IHNldAojIGVuZCBvZiBQSFkgU3Vic3lz
dGVtCgojIENPTkZJR19QT1dFUkNBUCBpcyBub3Qgc2V0CiMgQ09ORklHX01DQiBpcyBub3Qgc2V0
CgojCiMgUGVyZm9ybWFuY2UgbW9uaXRvciBzdXBwb3J0CiMKIyBDT05GSUdfRFdDX1BDSUVfUE1V
IGlzIG5vdCBzZXQKIyBlbmQgb2YgUGVyZm9ybWFuY2UgbW9uaXRvciBzdXBwb3J0CgojIENPTkZJ
R19SQVMgaXMgbm90IHNldAojIENPTkZJR19VU0I0IGlzIG5vdCBzZXQKCiMKIyBBbmRyb2lkCiMK
IyBDT05GSUdfQU5EUk9JRF9CSU5ERVJfSVBDIGlzIG5vdCBzZXQKIyBlbmQgb2YgQW5kcm9pZAoK
IyBDT05GSUdfTElCTlZESU1NIGlzIG5vdCBzZXQKIyBDT05GSUdfREFYIGlzIG5vdCBzZXQKQ09O
RklHX05WTUVNPXkKQ09ORklHX05WTUVNX1NZU0ZTPXkKIyBDT05GSUdfTlZNRU1fTEFZT1VUUyBp
cyBub3Qgc2V0CiMgQ09ORklHX05WTUVNX1JNRU0gaXMgbm90IHNldAoKIwojIEhXIHRyYWNpbmcg
c3VwcG9ydAojCiMgQ09ORklHX1NUTSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1RIIGlzIG5v
dCBzZXQKIyBlbmQgb2YgSFcgdHJhY2luZyBzdXBwb3J0CgojIENPTkZJR19GUEdBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0lPWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NMSU1CVVMgaXMgbm90IHNldAoj
IENPTkZJR19JTlRFUkNPTk5FQ1QgaXMgbm90IHNldAojIENPTkZJR19DT1VOVEVSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEVDSSBpcyBub3Qgc2V0CiMgQ09ORklHX0hURSBpcyBub3Qgc2V0CiMgZW5k
IG9mIERldmljZSBEcml2ZXJzCgojCiMgRmlsZSBzeXN0ZW1zCiMKIyBDT05GSUdfVkFMSURBVEVf
RlNfUEFSU0VSIGlzIG5vdCBzZXQKQ09ORklHX0ZTX0lPTUFQPXkKQ09ORklHX0JVRkZFUl9IRUFE
PXkKQ09ORklHX0xFR0FDWV9ESVJFQ1RfSU89eQpDT05GSUdfRVhUMl9GUz15CkNPTkZJR19FWFQy
X0ZTX1hBVFRSPXkKQ09ORklHX0VYVDJfRlNfUE9TSVhfQUNMPXkKQ09ORklHX0VYVDJfRlNfU0VD
VVJJVFk9eQpDT05GSUdfRVhUM19GUz15CkNPTkZJR19FWFQzX0ZTX1BPU0lYX0FDTD15CkNPTkZJ
R19FWFQzX0ZTX1NFQ1VSSVRZPXkKQ09ORklHX0VYVDRfRlM9eQpDT05GSUdfRVhUNF9GU19QT1NJ
WF9BQ0w9eQpDT05GSUdfRVhUNF9GU19TRUNVUklUWT15CiMgQ09ORklHX0VYVDRfREVCVUcgaXMg
bm90IHNldApDT05GSUdfSkJEMj15CiMgQ09ORklHX0pCRDJfREVCVUcgaXMgbm90IHNldApDT05G
SUdfRlNfTUJDQUNIRT15CiMgQ09ORklHX1JFSVNFUkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfR0ZT
Ml9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JUUkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTklM
RlMyX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRjJGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JD
QUNIRUZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0ZTX1BPU0lYX0FDTD15CkNPTkZJR19FWFBPUlRG
Uz15CkNPTkZJR19FWFBPUlRGU19CTE9DS19PUFM9eQpDT05GSUdfRklMRV9MT0NLSU5HPXkKIyBD
T05GSUdfRlNfRU5DUllQVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZTX1ZFUklUWSBpcyBub3Qg
c2V0CkNPTkZJR19GU05PVElGWT15CkNPTkZJR19ETk9USUZZPXkKQ09ORklHX0lOT1RJRllfVVNF
Uj15CkNPTkZJR19GQU5PVElGWT15CkNPTkZJR19RVU9UQT15CiMgQ09ORklHX1FVT1RBX05FVExJ
TktfSU5URVJGQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfUVVPVEFfREVCVUcgaXMgbm90IHNldAoj
IENPTkZJR19RRk1UX1YxIGlzIG5vdCBzZXQKIyBDT05GSUdfUUZNVF9WMiBpcyBub3Qgc2V0CkNP
TkZJR19RVU9UQUNUTD15CiMgQ09ORklHX0FVVE9GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZV
U0VfRlMgaXMgbm90IHNldAojIENPTkZJR19PVkVSTEFZX0ZTIGlzIG5vdCBzZXQKCiMKIyBDYWNo
ZXMKIwojIGVuZCBvZiBDYWNoZXMKCiMKIyBDRC1ST00vRFZEIEZpbGVzeXN0ZW1zCiMKQ09ORklH
X0lTTzk2NjBfRlM9eQpDT05GSUdfSk9MSUVUPXkKQ09ORklHX1pJU09GUz15CkNPTkZJR19VREZf
RlM9eQojIGVuZCBvZiBDRC1ST00vRFZEIEZpbGVzeXN0ZW1zCgojCiMgRE9TL0ZBVC9FWEZBVC9O
VCBGaWxlc3lzdGVtcwojCkNPTkZJR19GQVRfRlM9eQpDT05GSUdfTVNET1NfRlM9eQpDT05GSUdf
VkZBVF9GUz15CkNPTkZJR19GQVRfREVGQVVMVF9DT0RFUEFHRT00MzcKQ09ORklHX0ZBVF9ERUZB
VUxUX0lPQ0hBUlNFVD0iaXNvODg1OS0xIgojIENPTkZJR19GQVRfREVGQVVMVF9VVEY4IGlzIG5v
dCBzZXQKQ09ORklHX0VYRkFUX0ZTPXkKQ09ORklHX0VYRkFUX0RFRkFVTFRfSU9DSEFSU0VUPSJ1
dGY4IgojIENPTkZJR19OVEZTM19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX05URlNfRlMgaXMgbm90
IHNldAojIGVuZCBvZiBET1MvRkFUL0VYRkFUL05UIEZpbGVzeXN0ZW1zCgojCiMgUHNldWRvIGZp
bGVzeXN0ZW1zCiMKQ09ORklHX1BST0NfRlM9eQpDT05GSUdfUFJPQ19LQ09SRT15CkNPTkZJR19Q
Uk9DX1NZU0NUTD15CkNPTkZJR19QUk9DX1BBR0VfTU9OSVRPUj15CiMgQ09ORklHX1BST0NfQ0hJ
TERSRU4gaXMgbm90IHNldApDT05GSUdfS0VSTkZTPXkKQ09ORklHX1NZU0ZTPXkKQ09ORklHX1RN
UEZTPXkKIyBDT05GSUdfVE1QRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfVE1QRlNf
WEFUVFIgaXMgbm90IHNldAojIENPTkZJR19UTVBGU19JTk9ERTY0IGlzIG5vdCBzZXQKIyBDT05G
SUdfVE1QRlNfUVVPVEEgaXMgbm90IHNldAojIENPTkZJR19DT05GSUdGU19GUyBpcyBub3Qgc2V0
CiMgZW5kIG9mIFBzZXVkbyBmaWxlc3lzdGVtcwoKIyBDT05GSUdfTUlTQ19GSUxFU1lTVEVNUyBp
cyBub3Qgc2V0CkNPTkZJR19ORVRXT1JLX0ZJTEVTWVNURU1TPXkKQ09ORklHX05GU19GUz15CkNP
TkZJR19ORlNfVjI9eQpDT05GSUdfTkZTX1YzPXkKQ09ORklHX05GU19WM19BQ0w9eQpDT05GSUdf
TkZTX1Y0PXkKQ09ORklHX05GU19TV0FQPXkKIyBDT05GSUdfTkZTX1Y0XzEgaXMgbm90IHNldApD
T05GSUdfUk9PVF9ORlM9eQpDT05GSUdfTkZTX1VTRV9MRUdBQ1lfRE5TPXkKQ09ORklHX05GU19E
SVNBQkxFX1VEUF9TVVBQT1JUPXkKQ09ORklHX05GU0Q9eQpDT05GSUdfTkZTRF9WMj15CkNPTkZJ
R19ORlNEX1YyX0FDTD15CkNPTkZJR19ORlNEX1YzX0FDTD15CkNPTkZJR19ORlNEX1Y0PXkKQ09O
RklHX05GU0RfUE5GUz15CkNPTkZJR19ORlNEX0JMT0NLTEFZT1VUPXkKQ09ORklHX05GU0RfU0NT
SUxBWU9VVD15CkNPTkZJR19ORlNEX0ZMRVhGSUxFTEFZT1VUPXkKQ09ORklHX05GU0RfTEVHQUNZ
X0NMSUVOVF9UUkFDS0lORz15CkNPTkZJR19HUkFDRV9QRVJJT0Q9eQpDT05GSUdfTE9DS0Q9eQpD
T05GSUdfTE9DS0RfVjQ9eQpDT05GSUdfTkZTX0FDTF9TVVBQT1JUPXkKQ09ORklHX05GU19DT01N
T049eQpDT05GSUdfTkZTX0NPTU1PTl9MT0NBTElPX1NVUFBPUlQ9eQpDT05GSUdfTkZTX0xPQ0FM
SU89eQpDT05GSUdfU1VOUlBDPXkKQ09ORklHX1NVTlJQQ19HU1M9eQpDT05GSUdfU1VOUlBDX1NX
QVA9eQpDT05GSUdfUlBDU0VDX0dTU19LUkI1PXkKQ09ORklHX1JQQ1NFQ19HU1NfS1JCNV9FTkNU
WVBFU19BRVNfU0hBMT15CiMgQ09ORklHX1JQQ1NFQ19HU1NfS1JCNV9FTkNUWVBFU19DQU1FTExJ
QSBpcyBub3Qgc2V0CiMgQ09ORklHX1JQQ1NFQ19HU1NfS1JCNV9FTkNUWVBFU19BRVNfU0hBMiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NVTlJQQ19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0NFUEhf
RlMgaXMgbm90IHNldAojIENPTkZJR19DSUZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU01CX1NFUlZF
UiBpcyBub3Qgc2V0CiMgQ09ORklHX0NPREFfRlMgaXMgbm90IHNldAojIENPTkZJR19BRlNfRlMg
aXMgbm90IHNldApDT05GSUdfTkxTPXkKQ09ORklHX05MU19ERUZBVUxUPSJpc284ODU5LTEiCkNP
TkZJR19OTFNfQ09ERVBBR0VfNDM3PXkKIyBDT05GSUdfTkxTX0NPREVQQUdFXzczNyBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV83NzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfODUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBB
R0VfODU3IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19DT0RFUEFHRV84NjEgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
ODYyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19DT0RFUEFHRV84NjQgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY1
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NiBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19DT0RFUEFHRV84NjkgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTM2IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19DT0RFUEFHRV85MzIgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTQ5IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg3NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19J
U084ODU5XzggaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfMTI1MCBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV8xMjUxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0FTQ0lJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMSBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19JU084ODU5XzIgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8zIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0lTTzg4NTlfNCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzUg
aXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV82IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0lTTzg4NTlfNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzkgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfSVNPODg1OV8xMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzE0
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTUgaXMgbm90IHNldAojIENPTkZJR19O
TFNfS09JOF9SIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfVSBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19NQUNfUk9NQU4gaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0NFTFRJQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19NQUNfQ0VOVEVVUk8gaXMgbm90IHNldAojIENPTkZJR19OTFNf
TUFDX0NST0FUSUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19DWVJJTExJQyBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19NQUNfR0FFTElDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19H
UkVFSyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfSUNFTEFORCBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19NQUNfSU5VSVQgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX1JPTUFOSUFOIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19UVVJLSVNIIGlzIG5vdCBzZXQKQ09ORklHX05MU19V
VEY4PXkKIyBDT05GSUdfVU5JQ09ERSBpcyBub3Qgc2V0CkNPTkZJR19JT19XUT15CiMgZW5kIG9m
IEZpbGUgc3lzdGVtcwoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwpDT05GSUdfS0VZUz15CiMgQ09O
RklHX0tFWVNfUkVRVUVTVF9DQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BFUlNJU1RFTlRfS0VZ
UklOR1MgaXMgbm90IHNldAojIENPTkZJR19CSUdfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RS
VVNURURfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VOQ1JZUFRFRF9LRVlTIGlzIG5vdCBzZXQK
IyBDT05GSUdfS0VZX0RIX09QRVJBVElPTlMgaXMgbm90IHNldAojIENPTkZJR19TRUNVUklUWV9E
TUVTR19SRVNUUklDVCBpcyBub3Qgc2V0CkNPTkZJR19QUk9DX01FTV9BTFdBWVNfRk9SQ0U9eQoj
IENPTkZJR19QUk9DX01FTV9GT1JDRV9QVFJBQ0UgaXMgbm90IHNldAojIENPTkZJR19QUk9DX01F
TV9OT19GT1JDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VDVVJJVFlGUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hBUkRFTkVEX1VTRVJDT1BZIGlzIG5v
dCBzZXQKIyBDT05GSUdfU1RBVElDX1VTRVJNT0RFSEVMUEVSIGlzIG5vdCBzZXQKQ09ORklHX0RF
RkFVTFRfU0VDVVJJVFlfREFDPXkKQ09ORklHX0xTTT0ibGFuZGxvY2ssbG9ja2Rvd24seWFtYSxs
b2FkcGluLHNhZmVzZXRpZCxpcGUsYnBmIgoKIwojIEtlcm5lbCBoYXJkZW5pbmcgb3B0aW9ucwoj
CgojCiMgTWVtb3J5IGluaXRpYWxpemF0aW9uCiMKQ09ORklHX0NDX0hBU19BVVRPX1ZBUl9JTklU
X1BBVFRFUk49eQpDT05GSUdfQ0NfSEFTX0FVVE9fVkFSX0lOSVRfWkVST19CQVJFPXkKQ09ORklH
X0NDX0hBU19BVVRPX1ZBUl9JTklUX1pFUk89eQpDT05GSUdfSU5JVF9TVEFDS19OT05FPXkKIyBD
T05GSUdfSU5JVF9TVEFDS19BTExfUEFUVEVSTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOSVRfU1RB
Q0tfQUxMX1pFUk8gaXMgbm90IHNldAojIENPTkZJR19JTklUX09OX0FMTE9DX0RFRkFVTFRfT04g
aXMgbm90IHNldAojIENPTkZJR19JTklUX09OX0ZSRUVfREVGQVVMVF9PTiBpcyBub3Qgc2V0CkNP
TkZJR19DQ19IQVNfWkVST19DQUxMX1VTRURfUkVHUz15CiMgQ09ORklHX1pFUk9fQ0FMTF9VU0VE
X1JFR1MgaXMgbm90IHNldAojIGVuZCBvZiBNZW1vcnkgaW5pdGlhbGl6YXRpb24KCiMKIyBIYXJk
ZW5pbmcgb2Yga2VybmVsIGRhdGEgc3RydWN0dXJlcwojCiMgQ09ORklHX0xJU1RfSEFSREVORUQg
aXMgbm90IHNldAojIENPTkZJR19CVUdfT05fREFUQV9DT1JSVVBUSU9OIGlzIG5vdCBzZXQKIyBl
bmQgb2YgSGFyZGVuaW5nIG9mIGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMKCkNPTkZJR19SQU5EU1RS
VUNUX05PTkU9eQojIGVuZCBvZiBLZXJuZWwgaGFyZGVuaW5nIG9wdGlvbnMKIyBlbmQgb2YgU2Vj
dXJpdHkgb3B0aW9ucwoKQ09ORklHX0NSWVBUTz15CgojCiMgQ3J5cHRvIGNvcmUgb3IgaGVscGVy
CiMKQ09ORklHX0NSWVBUT19BTEdBUEk9eQpDT05GSUdfQ1JZUFRPX0FMR0FQSTI9eQpDT05GSUdf
Q1JZUFRPX0FFQUQ9eQpDT05GSUdfQ1JZUFRPX0FFQUQyPXkKQ09ORklHX0NSWVBUT19TSUcyPXkK
Q09ORklHX0NSWVBUT19TS0NJUEhFUj15CkNPTkZJR19DUllQVE9fU0tDSVBIRVIyPXkKQ09ORklH
X0NSWVBUT19IQVNIPXkKQ09ORklHX0NSWVBUT19IQVNIMj15CkNPTkZJR19DUllQVE9fUk5HPXkK
Q09ORklHX0NSWVBUT19STkcyPXkKQ09ORklHX0NSWVBUT19STkdfREVGQVVMVD15CkNPTkZJR19D
UllQVE9fQUtDSVBIRVIyPXkKQ09ORklHX0NSWVBUT19BS0NJUEhFUj15CkNPTkZJR19DUllQVE9f
S1BQMj15CkNPTkZJR19DUllQVE9fS1BQPXkKQ09ORklHX0NSWVBUT19BQ09NUDI9eQpDT05GSUdf
Q1JZUFRPX01BTkFHRVI9eQpDT05GSUdfQ1JZUFRPX01BTkFHRVIyPXkKIyBDT05GSUdfQ1JZUFRP
X1VTRVIgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX01BTkFHRVJfRElTQUJMRV9URVNUUz15CkNP
TkZJR19DUllQVE9fTlVMTD15CkNPTkZJR19DUllQVE9fTlVMTDI9eQojIENPTkZJR19DUllQVE9f
UENSWVBUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NSWVBURCBpcyBub3Qgc2V0CkNPTkZJ
R19DUllQVE9fQVVUSEVOQz15CiMgQ09ORklHX0NSWVBUT19URVNUIGlzIG5vdCBzZXQKIyBlbmQg
b2YgQ3J5cHRvIGNvcmUgb3IgaGVscGVyCgojCiMgUHVibGljLWtleSBjcnlwdG9ncmFwaHkKIwpD
T05GSUdfQ1JZUFRPX1JTQT15CkNPTkZJR19DUllQVE9fREg9eQpDT05GSUdfQ1JZUFRPX0RIX1JG
Qzc5MTlfR1JPVVBTPXkKQ09ORklHX0NSWVBUT19FQ0M9eQpDT05GSUdfQ1JZUFRPX0VDREg9eQpD
T05GSUdfQ1JZUFRPX0VDRFNBPXkKQ09ORklHX0NSWVBUT19FQ1JEU0E9eQpDT05GSUdfQ1JZUFRP
X0NVUlZFMjU1MTk9eQojIGVuZCBvZiBQdWJsaWMta2V5IGNyeXB0b2dyYXBoeQoKIwojIEJsb2Nr
IGNpcGhlcnMKIwpDT05GSUdfQ1JZUFRPX0FFUz15CkNPTkZJR19DUllQVE9fQUVTX1RJPXkKIyBD
T05GSUdfQ1JZUFRPX0FOVUJJUyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fQVJJQT15CkNPTkZJ
R19DUllQVE9fQkxPV0ZJU0g9eQpDT05GSUdfQ1JZUFRPX0JMT1dGSVNIX0NPTU1PTj15CkNPTkZJ
R19DUllQVE9fQ0FNRUxMSUE9eQpDT05GSUdfQ1JZUFRPX0NBU1RfQ09NTU9OPXkKQ09ORklHX0NS
WVBUT19DQVNUNT15CkNPTkZJR19DUllQVE9fQ0FTVDY9eQpDT05GSUdfQ1JZUFRPX0RFUz15CkNP
TkZJR19DUllQVE9fRkNSWVBUPXkKIyBDT05GSUdfQ1JZUFRPX0tIQVpBRCBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19TRUVEIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19TRVJQRU5UPXkKQ09O
RklHX0NSWVBUT19TTTQ9eQpDT05GSUdfQ1JZUFRPX1NNNF9HRU5FUklDPXkKIyBDT05GSUdfQ1JZ
UFRPX1RFQSBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fVFdPRklTSD15CkNPTkZJR19DUllQVE9f
VFdPRklTSF9DT01NT049eQojIGVuZCBvZiBCbG9jayBjaXBoZXJzCgojCiMgTGVuZ3RoLXByZXNl
cnZpbmcgY2lwaGVycyBhbmQgbW9kZXMKIwpDT05GSUdfQ1JZUFRPX0FESUFOVFVNPXkKIyBDT05G
SUdfQ1JZUFRPX0FSQzQgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0NIQUNIQTIwPXkKQ09ORklH
X0NSWVBUT19DQkM9eQpDT05GSUdfQ1JZUFRPX0NUUj15CkNPTkZJR19DUllQVE9fQ1RTPXkKQ09O
RklHX0NSWVBUT19FQ0I9eQpDT05GSUdfQ1JZUFRPX0hDVFIyPXkKQ09ORklHX0NSWVBUT19LRVlX
UkFQPXkKQ09ORklHX0NSWVBUT19MUlc9eQpDT05GSUdfQ1JZUFRPX1BDQkM9eQpDT05GSUdfQ1JZ
UFRPX1hDVFI9eQpDT05GSUdfQ1JZUFRPX1hUUz15CkNPTkZJR19DUllQVE9fTkhQT0xZMTMwNT15
CiMgZW5kIG9mIExlbmd0aC1wcmVzZXJ2aW5nIGNpcGhlcnMgYW5kIG1vZGVzCgojCiMgQUVBRCAo
YXV0aGVudGljYXRlZCBlbmNyeXB0aW9uIHdpdGggYXNzb2NpYXRlZCBkYXRhKSBjaXBoZXJzCiMK
Q09ORklHX0NSWVBUT19BRUdJUzEyOD15CkNPTkZJR19DUllQVE9fQ0hBQ0hBMjBQT0xZMTMwNT15
CkNPTkZJR19DUllQVE9fQ0NNPXkKQ09ORklHX0NSWVBUT19HQ009eQpDT05GSUdfQ1JZUFRPX0dF
TklWPXkKQ09ORklHX0NSWVBUT19TRVFJVj15CkNPTkZJR19DUllQVE9fRUNIQUlOSVY9eQpDT05G
SUdfQ1JZUFRPX0VTU0lWPXkKIyBlbmQgb2YgQUVBRCAoYXV0aGVudGljYXRlZCBlbmNyeXB0aW9u
IHdpdGggYXNzb2NpYXRlZCBkYXRhKSBjaXBoZXJzCgojCiMgSGFzaGVzLCBkaWdlc3RzLCBhbmQg
TUFDcwojCkNPTkZJR19DUllQVE9fQkxBS0UyQj15CkNPTkZJR19DUllQVE9fQ01BQz15CkNPTkZJ
R19DUllQVE9fR0hBU0g9eQpDT05GSUdfQ1JZUFRPX0hNQUM9eQpDT05GSUdfQ1JZUFRPX01END15
CkNPTkZJR19DUllQVE9fTUQ1PXkKQ09ORklHX0NSWVBUT19NSUNIQUVMX01JQz15CkNPTkZJR19D
UllQVE9fUE9MWVZBTD15CkNPTkZJR19DUllQVE9fUE9MWTEzMDU9eQpDT05GSUdfQ1JZUFRPX1JN
RDE2MD15CkNPTkZJR19DUllQVE9fU0hBMT15CkNPTkZJR19DUllQVE9fU0hBMjU2PXkKQ09ORklH
X0NSWVBUT19TSEE1MTI9eQpDT05GSUdfQ1JZUFRPX1NIQTM9eQpDT05GSUdfQ1JZUFRPX1NNMz15
CkNPTkZJR19DUllQVE9fU00zX0dFTkVSSUM9eQpDT05GSUdfQ1JZUFRPX1NUUkVFQk9HPXkKQ09O
RklHX0NSWVBUT19WTUFDPXkKQ09ORklHX0NSWVBUT19XUDUxMj15CkNPTkZJR19DUllQVE9fWENC
Qz15CkNPTkZJR19DUllQVE9fWFhIQVNIPXkKIyBlbmQgb2YgSGFzaGVzLCBkaWdlc3RzLCBhbmQg
TUFDcwoKIwojIENSQ3MgKGN5Y2xpYyByZWR1bmRhbmN5IGNoZWNrcykKIwpDT05GSUdfQ1JZUFRP
X0NSQzMyQz15CkNPTkZJR19DUllQVE9fQ1JDMzI9eQpDT05GSUdfQ1JZUFRPX0NSQ1QxMERJRj15
CkNPTkZJR19DUllQVE9fQ1JDNjRfUk9DS1NPRlQ9eQojIGVuZCBvZiBDUkNzIChjeWNsaWMgcmVk
dW5kYW5jeSBjaGVja3MpCgojCiMgQ29tcHJlc3Npb24KIwpDT05GSUdfQ1JZUFRPX0RFRkxBVEU9
eQpDT05GSUdfQ1JZUFRPX0xaTz15CkNPTkZJR19DUllQVE9fODQyPXkKQ09ORklHX0NSWVBUT19M
WjQ9eQpDT05GSUdfQ1JZUFRPX0xaNEhDPXkKQ09ORklHX0NSWVBUT19aU1REPXkKIyBlbmQgb2Yg
Q29tcHJlc3Npb24KCiMKIyBSYW5kb20gbnVtYmVyIGdlbmVyYXRpb24KIwpDT05GSUdfQ1JZUFRP
X0FOU0lfQ1BSTkc9eQpDT05GSUdfQ1JZUFRPX0RSQkdfTUVOVT15CkNPTkZJR19DUllQVE9fRFJC
R19ITUFDPXkKIyBDT05GSUdfQ1JZUFRPX0RSQkdfSEFTSCBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19EUkJHX0NUUiBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fRFJCRz15CkNPTkZJR19DUllQ
VE9fSklUVEVSRU5UUk9QWT15CkNPTkZJR19DUllQVE9fSklUVEVSRU5UUk9QWV9NRU1PUllfQkxP
Q0tTPTY0CkNPTkZJR19DUllQVE9fSklUVEVSRU5UUk9QWV9NRU1PUllfQkxPQ0tTSVpFPTMyCkNP
TkZJR19DUllQVE9fSklUVEVSRU5UUk9QWV9PU1I9MQojIGVuZCBvZiBSYW5kb20gbnVtYmVyIGdl
bmVyYXRpb24KCiMKIyBVc2Vyc3BhY2UgaW50ZXJmYWNlCiMKQ09ORklHX0NSWVBUT19VU0VSX0FQ
ST15CkNPTkZJR19DUllQVE9fVVNFUl9BUElfSEFTSD15CkNPTkZJR19DUllQVE9fVVNFUl9BUElf
U0tDSVBIRVI9eQpDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX1JORz15CiMgQ09ORklHX0NSWVBUT19V
U0VSX0FQSV9STkdfQ0FWUCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fVVNFUl9BUElfQUVBRD15
CkNPTkZJR19DUllQVE9fVVNFUl9BUElfRU5BQkxFX09CU09MRVRFPXkKIyBlbmQgb2YgVXNlcnNw
YWNlIGludGVyZmFjZQoKIyBDT05GSUdfQ1JZUFRPX0hXIGlzIG5vdCBzZXQKIyBDT05GSUdfQVNZ
TU1FVFJJQ19LRVlfVFlQRSBpcyBub3Qgc2V0CgojCiMgQ2VydGlmaWNhdGVzIGZvciBzaWduYXR1
cmUgY2hlY2tpbmcKIwojIENPTkZJR19TWVNURU1fQkxBQ0tMSVNUX0tFWVJJTkcgaXMgbm90IHNl
dAojIGVuZCBvZiBDZXJ0aWZpY2F0ZXMgZm9yIHNpZ25hdHVyZSBjaGVja2luZwoKIwojIExpYnJh
cnkgcm91dGluZXMKIwojIENPTkZJR19QQUNLSU5HIGlzIG5vdCBzZXQKQ09ORklHX0JJVFJFVkVS
U0U9eQpDT05GSUdfR0VORVJJQ19TVFJOQ1BZX0ZST01fVVNFUj15CkNPTkZJR19HRU5FUklDX1NU
Uk5MRU5fVVNFUj15CkNPTkZJR19HRU5FUklDX05FVF9VVElMUz15CkNPTkZJR19DT1JESUM9eQpD
T05GSUdfUFJJTUVfTlVNQkVSUz15CkNPTkZJR19BUkNIX1VTRV9DTVBYQ0hHX0xPQ0tSRUY9eQoK
IwojIENyeXB0byBsaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0NSWVBUT19MSUJfVVRJTFM9eQpD
T05GSUdfQ1JZUFRPX0xJQl9BRVM9eQpDT05GSUdfQ1JZUFRPX0xJQl9HRjEyOE1VTD15CkNPTkZJ
R19DUllQVE9fTElCX0JMQUtFMlNfR0VORVJJQz15CkNPTkZJR19DUllQVE9fTElCX0NIQUNIQV9H
RU5FUklDPXkKQ09ORklHX0NSWVBUT19MSUJfQ0hBQ0hBPXkKQ09ORklHX0NSWVBUT19MSUJfQ1VS
VkUyNTUxOV9HRU5FUklDPXkKQ09ORklHX0NSWVBUT19MSUJfQ1VSVkUyNTUxOT15CkNPTkZJR19D
UllQVE9fTElCX0RFUz15CkNPTkZJR19DUllQVE9fTElCX1BPTFkxMzA1X1JTSVpFPTEKQ09ORklH
X0NSWVBUT19MSUJfUE9MWTEzMDVfR0VORVJJQz15CkNPTkZJR19DUllQVE9fTElCX1BPTFkxMzA1
PXkKQ09ORklHX0NSWVBUT19MSUJfQ0hBQ0hBMjBQT0xZMTMwNT15CkNPTkZJR19DUllQVE9fTElC
X1NIQTE9eQpDT05GSUdfQ1JZUFRPX0xJQl9TSEEyNTY9eQojIGVuZCBvZiBDcnlwdG8gbGlicmFy
eSByb3V0aW5lcwoKQ09ORklHX0NSQ19DQ0lUVD15CkNPTkZJR19DUkMxNj15CkNPTkZJR19DUkNf
VDEwRElGPXkKQ09ORklHX0NSQzY0X1JPQ0tTT0ZUPXkKQ09ORklHX0NSQ19JVFVfVD15CkNPTkZJ
R19DUkMzMj15CiMgQ09ORklHX0NSQzMyX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklHX0NSQzMy
X1NMSUNFQlk4PXkKIyBDT05GSUdfQ1JDMzJfU0xJQ0VCWTQgaXMgbm90IHNldAojIENPTkZJR19D
UkMzMl9TQVJXQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMzJfQklUIGlzIG5vdCBzZXQKQ09O
RklHX0NSQzY0PXkKQ09ORklHX0NSQzQ9eQpDT05GSUdfQ1JDNz15CkNPTkZJR19MSUJDUkMzMkM9
eQpDT05GSUdfQ1JDOD15CkNPTkZJR19YWEhBU0g9eQojIENPTkZJR19SQU5ET00zMl9TRUxGVEVT
VCBpcyBub3Qgc2V0CkNPTkZJR184NDJfQ09NUFJFU1M9eQpDT05GSUdfODQyX0RFQ09NUFJFU1M9
eQpDT05GSUdfWkxJQl9JTkZMQVRFPXkKQ09ORklHX1pMSUJfREVGTEFURT15CkNPTkZJR19MWk9f
Q09NUFJFU1M9eQpDT05GSUdfTFpPX0RFQ09NUFJFU1M9eQpDT05GSUdfTFo0X0NPTVBSRVNTPXkK
Q09ORklHX0xaNEhDX0NPTVBSRVNTPXkKQ09ORklHX0xaNF9ERUNPTVBSRVNTPXkKQ09ORklHX1pT
VERfQ09NTU9OPXkKQ09ORklHX1pTVERfQ09NUFJFU1M9eQpDT05GSUdfWlNURF9ERUNPTVBSRVNT
PXkKQ09ORklHX1haX0RFQz15CkNPTkZJR19YWl9ERUNfWDg2PXkKQ09ORklHX1haX0RFQ19QT1dF
UlBDPXkKQ09ORklHX1haX0RFQ19BUk09eQpDT05GSUdfWFpfREVDX0FSTVRIVU1CPXkKQ09ORklH
X1haX0RFQ19BUk02ND15CkNPTkZJR19YWl9ERUNfU1BBUkM9eQpDT05GSUdfWFpfREVDX1JJU0NW
PXkKQ09ORklHX1haX0RFQ19NSUNST0xaTUE9eQpDT05GSUdfWFpfREVDX0JDSj15CkNPTkZJR19Y
Wl9ERUNfVEVTVD15CkNPTkZJR19HRU5FUklDX0FMTE9DQVRPUj15CkNPTkZJR19BU1NPQ0lBVElW
RV9BUlJBWT15CkNPTkZJR19IQVNfSU9NRU09eQpDT05GSUdfSEFTX0lPUE9SVD15CkNPTkZJR19I
QVNfSU9QT1JUX01BUD15CkNPTkZJR19IQVNfRE1BPXkKQ09ORklHX0RNQV9PUFNfSEVMUEVSUz15
CkNPTkZJR19ORUVEX1NHX0RNQV9MRU5HVEg9eQpDT05GSUdfTkVFRF9ETUFfTUFQX1NUQVRFPXkK
Q09ORklHX0FSQ0hfRE1BX0FERFJfVF82NEJJVD15CkNPTkZJR19ETUFfTkVFRF9TWU5DPXkKIyBD
T05GSUdfRE1BX0FQSV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19TR0xfQUxMT0M9eQpDT05GSUdf
Q1BVX1JNQVA9eQpDT05GSUdfRFFMPXkKQ09ORklHX0dMT0I9eQpDT05GSUdfR0xPQl9TRUxGVEVT
VD15CkNPTkZJR19OTEFUVFI9eQpDT05GSUdfQ0xaX1RBQj15CiMgQ09ORklHX0lSUV9QT0xMIGlz
IG5vdCBzZXQKQ09ORklHX01QSUxJQj15CkNPTkZJR19ESU1MSUI9eQpDT05GSUdfT0lEX1JFR0lT
VFJZPXkKQ09ORklHX0ZPTlRfU1VQUE9SVD15CiMgQ09ORklHX0ZPTlRTIGlzIG5vdCBzZXQKQ09O
RklHX0ZPTlRfOHg4PXkKQ09ORklHX0ZPTlRfOHgxNj15CkNPTkZJR19TR19QT09MPXkKQ09ORklH
X0FSQ0hfTk9fU0dfQ0hBSU49eQpDT05GSUdfU0JJVE1BUD15CiMgQ09ORklHX0xXUV9URVNUIGlz
IG5vdCBzZXQKIyBlbmQgb2YgTGlicmFyeSByb3V0aW5lcwoKIwojIEtlcm5lbCBoYWNraW5nCiMK
CiMKIyBwcmludGsgYW5kIGRtZXNnIG9wdGlvbnMKIwojIENPTkZJR19QUklOVEtfVElNRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BSSU5US19DQUxMRVIgaXMgbm90IHNldAojIENPTkZJR19TVEFDS1RS
QUNFX0JVSUxEX0lEIGlzIG5vdCBzZXQKQ09ORklHX0NPTlNPTEVfTE9HTEVWRUxfREVGQVVMVD03
CkNPTkZJR19DT05TT0xFX0xPR0xFVkVMX1FVSUVUPTQKQ09ORklHX01FU1NBR0VfTE9HTEVWRUxf
REVGQVVMVD00CiMgQ09ORklHX0JPT1RfUFJJTlRLX0RFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFlOQU1JQ19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RZTkFNSUNfREVCVUdfQ09SRSBpcyBu
b3Qgc2V0CkNPTkZJR19TWU1CT0xJQ19FUlJOQU1FPXkKIyBlbmQgb2YgcHJpbnRrIGFuZCBkbWVz
ZyBvcHRpb25zCgpDT05GSUdfREVCVUdfS0VSTkVMPXkKQ09ORklHX0RFQlVHX01JU0M9eQoKIwoj
IENvbXBpbGUtdGltZSBjaGVja3MgYW5kIGNvbXBpbGVyIG9wdGlvbnMKIwpDT05GSUdfREVCVUdf
SU5GTz15CkNPTkZJR19BU19IQVNfTk9OX0NPTlNUX1VMRUIxMjg9eQojIENPTkZJR19ERUJVR19J
TkZPX05PTkUgaXMgbm90IHNldApDT05GSUdfREVCVUdfSU5GT19EV0FSRl9UT09MQ0hBSU5fREVG
QVVMVD15CiMgQ09ORklHX0RFQlVHX0lORk9fRFdBUkY0IGlzIG5vdCBzZXQKIyBDT05GSUdfREVC
VUdfSU5GT19EV0FSRjUgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19JTkZPX1JFRFVDRUQgaXMg
bm90IHNldApDT05GSUdfREVCVUdfSU5GT19DT01QUkVTU0VEX05PTkU9eQojIENPTkZJR19ERUJV
R19JTkZPX0NPTVBSRVNTRURfWkxJQiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0lORk9fQ09N
UFJFU1NFRF9aU1REIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfSU5GT19TUExJVCBpcyBub3Qg
c2V0CkNPTkZJR19QQUhPTEVfSEFTX1NQTElUX0JURj15CkNPTkZJR19QQUhPTEVfSEFTX0xBTkdf
RVhDTFVERT15CiMgQ09ORklHX0dEQl9TQ1JJUFRTIGlzIG5vdCBzZXQKQ09ORklHX0ZSQU1FX1dB
Uk49MjA0OAojIENPTkZJR19TVFJJUF9BU01fU1lNUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFQURB
QkxFX0FTTSBpcyBub3Qgc2V0CiMgQ09ORklHX0hFQURFUlNfSU5TVEFMTCBpcyBub3Qgc2V0CiMg
Q09ORklHX0RFQlVHX1NFQ1RJT05fTUlTTUFUQ0ggaXMgbm90IHNldApDT05GSUdfU0VDVElPTl9N
SVNNQVRDSF9XQVJOX09OTFk9eQojIENPTkZJR19ERUJVR19GT1JDRV9XRUFLX1BFUl9DUFUgaXMg
bm90IHNldAojIGVuZCBvZiBDb21waWxlLXRpbWUgY2hlY2tzIGFuZCBjb21waWxlciBvcHRpb25z
CgojCiMgR2VuZXJpYyBLZXJuZWwgRGVidWdnaW5nIEluc3RydW1lbnRzCiMKQ09ORklHX01BR0lD
X1NZU1JRPXkKQ09ORklHX01BR0lDX1NZU1JRX0RFRkFVTFRfRU5BQkxFPTB4MQpDT05GSUdfTUFH
SUNfU1lTUlFfU0VSSUFMPXkKQ09ORklHX01BR0lDX1NZU1JRX1NFUklBTF9TRVFVRU5DRT0iIgoj
IENPTkZJR19ERUJVR19GUyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0tDU0FOX0NPTVBJTEVSPXkK
IyBlbmQgb2YgR2VuZXJpYyBLZXJuZWwgRGVidWdnaW5nIEluc3RydW1lbnRzCgojCiMgTmV0d29y
a2luZyBEZWJ1Z2dpbmcKIwpDT05GSUdfREVCVUdfTkVUPXkKIyBlbmQgb2YgTmV0d29ya2luZyBE
ZWJ1Z2dpbmcKCiMKIyBNZW1vcnkgRGVidWdnaW5nCiMKIyBDT05GSUdfUEFHRV9FWFRFTlNJT04g
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19QQUdFQUxMT0MgaXMgbm90IHNldApDT05GSUdfU0xV
Ql9ERUJVRz15CiMgQ09ORklHX1NMVUJfREVCVUdfT04gaXMgbm90IHNldAojIENPTkZJR19QQUdF
X1BPSVNPTklORyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX09CSkVDVFMgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19TVEFDS19VU0FHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDSEVEX1NUQUNL
X0VORF9DSEVDSyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1ZNIGlzIG5vdCBzZXQKQ09ORklH
X0RFQlVHX01FTU9SWV9JTklUPXkKIyBDT05GSUdfREVCVUdfUEVSX0NQVV9NQVBTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUVNX0FMTE9DX1BST0ZJTElORyBpcyBub3Qgc2V0CkNPTkZJR19DQ19IQVNf
V09SS0lOR19OT1NBTklUSVpFX0FERFJFU1M9eQojIGVuZCBvZiBNZW1vcnkgRGVidWdnaW5nCgoj
IENPTkZJR19ERUJVR19TSElSUSBpcyBub3Qgc2V0CgojCiMgRGVidWcgT29wcywgTG9ja3VwcyBh
bmQgSGFuZ3MKIwpDT05GSUdfUEFOSUNfT05fT09QUz15CkNPTkZJR19QQU5JQ19PTl9PT1BTX1ZB
TFVFPTEKQ09ORklHX1BBTklDX1RJTUVPVVQ9MApDT05GSUdfTE9DS1VQX0RFVEVDVE9SPXkKQ09O
RklHX1NPRlRMT0NLVVBfREVURUNUT1I9eQpDT05GSUdfQk9PVFBBUkFNX1NPRlRMT0NLVVBfUEFO
SUM9eQpDT05GSUdfSEFWRV9IQVJETE9DS1VQX0RFVEVDVE9SX0JVRERZPXkKQ09ORklHX0hBUkRM
T0NLVVBfREVURUNUT1I9eQojIENPTkZJR19IQVJETE9DS1VQX0RFVEVDVE9SX1BFUkYgaXMgbm90
IHNldApDT05GSUdfSEFSRExPQ0tVUF9ERVRFQ1RPUl9CVUREWT15CiMgQ09ORklHX0hBUkRMT0NL
VVBfREVURUNUT1JfQVJDSCBpcyBub3Qgc2V0CkNPTkZJR19IQVJETE9DS1VQX0RFVEVDVE9SX0NP
VU5UU19IUlRJTUVSPXkKQ09ORklHX0JPT1RQQVJBTV9IQVJETE9DS1VQX1BBTklDPXkKQ09ORklH
X0RFVEVDVF9IVU5HX1RBU0s9eQpDT05GSUdfREVGQVVMVF9IVU5HX1RBU0tfVElNRU9VVD02MAoj
IENPTkZJR19CT09UUEFSQU1fSFVOR19UQVNLX1BBTklDIGlzIG5vdCBzZXQKQ09ORklHX1dRX1dB
VENIRE9HPXkKIyBDT05GSUdfV1FfQ1BVX0lOVEVOU0lWRV9SRVBPUlQgaXMgbm90IHNldAojIENP
TkZJR19URVNUX0xPQ0tVUCBpcyBub3Qgc2V0CiMgZW5kIG9mIERlYnVnIE9vcHMsIExvY2t1cHMg
YW5kIEhhbmdzCgojCiMgU2NoZWR1bGVyIERlYnVnZ2luZwojCkNPTkZJR19TQ0hFRF9JTkZPPXkK
Q09ORklHX1NDSEVEU1RBVFM9eQojIGVuZCBvZiBTY2hlZHVsZXIgRGVidWdnaW5nCgojCiMgTG9j
ayBEZWJ1Z2dpbmcgKHNwaW5sb2NrcywgbXV0ZXhlcywgZXRjLi4uKQojCkNPTkZJR19ERUJVR19S
VF9NVVRFWEVTPXkKQ09ORklHX0RFQlVHX1NQSU5MT0NLPXkKQ09ORklHX0RFQlVHX01VVEVYRVM9
eQpDT05GSUdfREVCVUdfUldTRU1TPXkKQ09ORklHX0RFQlVHX0xPQ0tJTkdfQVBJX1NFTEZURVNU
Uz15CkNPTkZJR19MT0NLX1RPUlRVUkVfVEVTVD15CkNPTkZJR19XV19NVVRFWF9TRUxGVEVTVD15
CkNPTkZJR19TQ0ZfVE9SVFVSRV9URVNUPXkKQ09ORklHX0NTRF9MT0NLX1dBSVRfREVCVUc9eQpD
T05GSUdfQ1NEX0xPQ0tfV0FJVF9ERUJVR19ERUZBVUxUPXkKIyBlbmQgb2YgTG9jayBEZWJ1Z2dp
bmcgKHNwaW5sb2NrcywgbXV0ZXhlcywgZXRjLi4uKQoKIyBDT05GSUdfREVCVUdfSVJRRkxBR1Mg
aXMgbm90IHNldAojIENPTkZJR19XQVJOX0FMTF9VTlNFRURFRF9SQU5ET00gaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19LT0JKRUNUIGlzIG5vdCBzZXQKCiMKIyBEZWJ1ZyBrZXJuZWwgZGF0YSBz
dHJ1Y3R1cmVzCiMKIyBDT05GSUdfREVCVUdfTElTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X1BMSVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU0cgaXMgbm90IHNldAojIENPTkZJR19E
RUJVR19OT1RJRklFUlMgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19NQVBMRV9UUkVFIGlzIG5v
dCBzZXQKIyBlbmQgb2YgRGVidWcga2VybmVsIGRhdGEgc3RydWN0dXJlcwoKIwojIFJDVSBEZWJ1
Z2dpbmcKIwpDT05GSUdfVE9SVFVSRV9URVNUPXkKIyBDT05GSUdfUkNVX1NDQUxFX1RFU1QgaXMg
bm90IHNldAojIENPTkZJR19SQ1VfVE9SVFVSRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNV
X1JFRl9TQ0FMRV9URVNUIGlzIG5vdCBzZXQKQ09ORklHX1JDVV9DUFVfU1RBTExfVElNRU9VVD0y
MQpDT05GSUdfUkNVX0VYUF9DUFVfU1RBTExfVElNRU9VVD0wCiMgQ09ORklHX1JDVV9DUFVfU1RB
TExfQ1BVVElNRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9UUkFDRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1JDVV9FUVNfREVCVUcgaXMgbm90IHNldAojIGVuZCBvZiBSQ1UgRGVidWdnaW5nCgojIENP
TkZJR19ERUJVR19XUV9GT1JDRV9SUl9DUFUgaXMgbm90IHNldAojIENPTkZJR19TQU1QTEVTIGlz
IG5vdCBzZXQKCiMKIyBhbHBoYSBEZWJ1Z2dpbmcKIwpDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09O
RklHX0FMUEhBX0xFR0FDWV9TVEFSVF9BRERSRVNTPXkKQ09ORklHX01BVEhFTVU9eQojIGVuZCBv
ZiBhbHBoYSBEZWJ1Z2dpbmcKCiMKIyBLZXJuZWwgVGVzdGluZyBhbmQgQ292ZXJhZ2UKIwojIENP
TkZJR19LVU5JVCBpcyBub3Qgc2V0CiMgQ09ORklHX05PVElGSUVSX0VSUk9SX0lOSkVDVElPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZBVUxUX0lOSkVDVElPTiBpcyBub3Qgc2V0CkNPTkZJR19DQ19I
QVNfU0FOQ09WX1RSQUNFX1BDPXkKQ09ORklHX1JVTlRJTUVfVEVTVElOR19NRU5VPXkKIyBDT05G
SUdfVEVTVF9ESFJZIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9NSU5fSEVBUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1RFU1RfRElWNjQgaXMgbm90IHNldAojIENPTkZJR19URVNUX01VTERJVjY0IGlz
IG5vdCBzZXQKIyBDT05GSUdfQkFDS1RSQUNFX1NFTEZfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1JCVFJFRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVFRF9TT0xPTU9OX1RFU1QgaXMgbm90
IHNldAojIENPTkZJR19JTlRFUlZBTF9UUkVFX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19QRVJD
UFVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUT01JQzY0X1NFTEZURVNUIGlzIG5vdCBzZXQK
IyBDT05GSUdfVEVTVF9IRVhEVU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9LU1RSVE9YIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEVTVF9QUklOVEYgaXMgbm90IHNldAojIENPTkZJR19URVNUX1ND
QU5GIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9CSVRNQVAgaXMgbm90IHNldAojIENPTkZJR19U
RVNUX1VVSUQgaXMgbm90IHNldAojIENPTkZJR19URVNUX1hBUlJBWSBpcyBub3Qgc2V0CiMgQ09O
RklHX1RFU1RfTUFQTEVfVFJFRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfUkhBU0hUQUJMRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfSURBIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9MS00g
aXMgbm90IHNldAojIENPTkZJR19URVNUX0JJVE9QUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1Rf
Vk1BTExPQyBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfQlBGIGlzIG5vdCBzZXQKIyBDT05GSUdf
VEVTVF9CTEFDS0hPTEVfREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfRklORF9CSVRfQkVOQ0hNQVJL
IGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9GSVJNV0FSRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RF
U1RfU1lTQ1RMIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9VREVMQVkgaXMgbm90IHNldAojIENP
TkZJR19URVNUX1NUQVRJQ19LRVlTIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9LTU9EIGlzIG5v
dCBzZXQKIyBDT05GSUdfVEVTVF9NRU1DQVRfUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfTUVN
SU5JVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfRlJFRV9QQUdFUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1RFU1RfT0JKUE9PTCBpcyBub3Qgc2V0CiMgZW5kIG9mIEtlcm5lbCBUZXN0aW5nIGFuZCBD
b3ZlcmFnZQoKIwojIFJ1c3QgaGFja2luZwojCiMgZW5kIG9mIFJ1c3QgaGFja2luZwojIGVuZCBv
ZiBLZXJuZWwgaGFja2luZwo=
--=_0b0e99b6138c62d90d0bbbbf1f94e876--

