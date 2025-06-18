Return-Path: <stable+bounces-154713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD82ADF9A3
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 00:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38C53BD3BA
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 22:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770FA27F015;
	Wed, 18 Jun 2025 22:58:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from constellation.wizardsworks.org (wizardsworks.org [24.234.38.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC0C27D773;
	Wed, 18 Jun 2025 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.234.38.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750287526; cv=none; b=nQpWJj5GIdSaxPcV1lo6CxhC3ThylhSLAJsHzebE26QHe9fxK4RcEuffRNAV7A/ge+9aUyCspNQm2RWEOc3o3foiw0IRcqg5nFYrmoUiNqy0qAblc+qGskMz8buZVXGDaaiyhCsOg/5BzXuwPdgGnSJQE6g9OMUnYzeksq44bsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750287526; c=relaxed/simple;
	bh=m6MO4hzKwY1KaxNRtkgIsPCqBHgofhSVTEuJnErRIzY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=H3Gtzqu/luJS3soPsz5N/3mWsG7NPsnIliuV+DJuNRYoMR6Vilvx4xNit52Snz6C3CcYpx8UEsw4FEyngH6fDEOpJ6qiaNsisk2afdTG47K/7BvRofu8kESyqkHd8LQM7GwfeTLIwiTB3X6oEVUUcBazfNAKrzu+zG7q6QT3BOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org; spf=pass smtp.mailfrom=wizardsworks.org; arc=none smtp.client-ip=24.234.38.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizardsworks.org
Received: from mail.wizardsworks.org (localhost [127.0.0.1])
	by constellation.wizardsworks.org (8.18.1/8.18.1) with ESMTP id 55IMp3Li025786;
	Wed, 18 Jun 2025 15:51:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Jun 2025 15:51:03 -0700
From: Greg Chandler <chandleg@wizardsworks.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <a3d8ee993b73b826b537f374d78084ad@wizardsworks.org>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
 <385f2469f504dd293775d3c39affa979@wizardsworks.org>
 <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com>
 <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
 <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com>
 <a3d8ee993b73b826b537f374d78084ad@wizardsworks.org>
Message-ID: <12ccf3e4c24e8db2545f6ccaba8ce273@wizardsworks.org>
X-Sender: chandleg@wizardsworks.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2025/06/18 13:59, Greg Chandler wrote:
> On 2025/06/17 11:22, Florian Fainelli wrote:
>> (please no top posting)
>> 
>> On 6/17/25 11:19, Greg Chandler wrote:
>>> 
>>> Hmm...  I'm wondering if that means it's an alpha-only issue then, 
>>> which would make this a much larger headache than it already is.
>>> Also thank you for checking, I appreciate you taking the time.
>>> 
>>> I assume the those interfaces actually work right? (simple ping over 
>>> that interface would be enough)  I posted in a subsequent message 
>>> that mine do not appear to at all.
>> 
>> Oh yeah, they work just fine:
>> 
>> udhcpc: broadcasting discover
>> [   19.197697] net eth0: Setting full-duplex based on MII#1 link 
>> partner capability of cde1
>> 
>> # ping -c 1 192.168.254.123
>> PING 192.168.254.123 (192.168.254.123): 56 data bytes
>> 64 bytes from 192.168.254.123: seq=0 ttl=64 time=2.902 ms
>> 
>> --- 192.168.254.123 ping statistics ---
>> 1 packets transmitted, 1 packets received, 0% packet loss
>> round-trip min/avg/max = 2.902/2.902/2.902 ms
>> 
>> - - - - - - - - - - - - - - - - - - - - - - - - -
>> [ ID] Interval           Transfer     Bitrate         Retr
>> [  5]   0.00-10.03  sec  39.6 MBytes  33.1 Mbits/sec    0            
>> sender
>> [  5]   0.00-10.07  sec  39.8 MBytes  33.1 Mbits/sec receiver
>> 
>> 
>>> 
>>> My next step is to build that driver as a module, and see if it 
>>> changes anything (I'm doubting it will).
>>> Then after that go dig up a different adapter, and see if it's the 
>>> network stack or the driver.
>>> 
>>> I've been hard pressed over the last week to get a lot of diagnosing 
>>> time.
>> 
>> Let me know if I can run experiments, I can load any kernel version on 
>> this Cobalt Qube2 meaning that bisections are possible.
>> 
>> Good luck!
> 
> 
> 
> 
> I thought I replied to the whole list, not just the sender, sorry for 
> the repeat....
> (full config is attached)
> 
> 
> As a module, the system booted up but did not probe the module.
> This may be from a variety of issues, not limited to the fact I am 
> still rolling this distro from scratch, and not all of the tools are 
> 100% working yet.
> I'm having some issues with gcc/gdb so I have a large number of 
> debugging options turned on in the kernel as well.
> 
> 
> When the module is loaded with insmod:
> 
> [  213.363172] tulip 0000:00:09.0: vgaarb: pci_notify
> [  213.363172] tulip 0000:00:09.0: assign IRQ: got 29
> [  213.363172] tulip 0000:00:09.0: enabling Mem-Wr-Inval
> [  213.369031] tulip0: EEPROM default media type Autosense
> [  213.369031] tulip0: Index #0 - Media 10baseT (#0) described by a 
> 21142 Serial PHY (2) block
> [  213.369031] tulip0: Index #1 - Media 10baseT-FDX (#4) described by a 
> 21142 Serial PHY (2) block
> [  213.370007] tulip0: Index #2 - Media 100baseTx (#3) described by a 
> 21143 SYM PHY (4) block
> [  213.370007] tulip0: Index #3 - Media 100baseTx-FDX (#5) described by 
> a 21143 SYM PHY (4) block
> [  213.376843] net eth1: Digital DS21142/43 Tulip rev 65 at MMIO 
> 0xa120000, 08:00:2b:86:ab:b1, IRQ 29
> [  213.377820] tulip 0000:00:09.0: vgaarb: pci_notify
> [  213.377820] tulip 0000:00:0b.0: vgaarb: pci_notify
> [  213.377820] tulip 0000:00:0b.0: assign IRQ: got 30
> [  213.377820] tulip 0000:00:0b.0: enabling Mem-Wr-Inval
> [  213.384656] tulip1: EEPROM default media type Autosense
> [  213.384656] tulip1: Index #0 - Media 10baseT (#0) described by a 
> 21142 Serial PHY (2) block
> [  213.384656] tulip1: Index #1 - Media 10baseT-FDX (#4) described by a 
> 21142 Serial PHY (2) block
> [  213.384656] tulip1: Index #2 - Media 100baseTx (#3) described by a 
> 21143 SYM PHY (4) block
> [  213.384656] tulip1: Index #3 - Media 100baseTx-FDX (#5) described by 
> a 21143 SYM PHY (4) block
> [  213.391492] net eth2: Digital DS21142/43 Tulip rev 65 at MMIO 
> 0xa121000, 08:00:2b:86:a8:5b, IRQ 30
> 
> 
> 
> root@bigbang:/lib/modules/6.12.12-SMP# mii-tool eth1
> eth1: no link
> 
> root@bigbang:/lib/modules/6.12.12-SMP# mii-tool eth2
> eth2: autonegotiation failed, link ok
> 
> 
> 
> When I pulled the plug I did not get the crash..
> When I plugged it back in, I did not get a dmesg/kernel line for the 
> link.
> 
> 
> 
> I bound the IP addresses to both, and did a ping test to the default 
> gateway, resulting in:
> (I promise the network is properly configured)
> 
> root@bigbang:/lib/modules/6.12.12-SMP# ping 192.168.1.1
> PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
> From 192.168.1.75 icmp_seq=1 Destination Host Unreachable
> From 192.168.1.75 icmp_seq=2 Destination Host Unreachable
> From 192.168.1.75 icmp_seq=3 Destination Host Unreachable
> 
> 
> 
> Upon pulling the cord out of the switch **after** the IP address was 
> bound, we are back to this:
> [  593.769227] ------------[ cut here ]------------
> [  593.769227] WARNING: CPU: 0 PID: 33 at kernel/time/timer.c:1657 
> __timer_delete_sync+0x10c/0x150
> [  593.769227] Modules linked in: tulip
> [  593.769227] CPU: 0 UID: 0 PID: 33 Comm: lock_torture_wr Not tainted 
> 6.12.12-SMP #1
> [  593.769227]        fffffc0002aeba40 fffffc00011b0ac0 
> fffffc000032a4f0 fffffc0000f8f181
> [  593.769227]        0000000000000000 0000000000000000 
> fffffc000032a688 fffffc000119c690
> [  593.769227]        0000000000000000 fffffc0000f8f181 
> fffffc00003d297c fffffc000125c7e0
> [  593.769227]        fffffffc0082f1c4 00000000efe4b99a 
> fffffc00003d297c fffffc000b03b490
> [  593.769227]        fffffc000b03b490 0000000000000000 
> fffffffff8668000 fffffd000a120000
> [  593.769227]        fffffc0000366888 fffffc000020ce00 
> fffffc000020ce00 0000000000000008
> [  593.769227] Trace:
> [  593.769227] [<fffffc000032a4f0>] __warn+0x190/0x1a0
> [  593.769227] [<fffffc000032a688>] warn_slowpath_fmt+0x188/0x240
> [  593.769227] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
> [  593.769227] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
> [  593.769227] [<fffffc0000366888>] wakeup_preempt+0xb8/0xd0
> [  593.769227] [<fffffc0000366950>] ttwu_do_activate.isra.0+0xb0/0x1a0
> [  593.769227] [<fffffc0000369030>] try_to_wake_up+0x370/0x700
> [  593.769227] [<fffffc0000e29470>] 
> _raw_spin_unlock_irqrestore+0x20/0x40
> [  593.769227] [<fffffc000036e1c4>] task_tick_fair+0x74/0x370
> [  593.769227] [<fffffc00003d46dc>] enqueue_hrtimer.isra.0+0x5c/0xc0
> [  593.769227] [<fffffc000037bc1c>] task_non_contending+0xcc/0x4f0
> [  593.769227] [<fffffc00003a1a80>] 
> __handle_irq_event_percpu+0x60/0x190
> [  593.769227] [<fffffc000036d598>] 
> sched_balance_update_blocked_averages+0xc8/0x2a0
> [  593.769227] [<fffffc00003a1cb8>] handle_irq_event+0x68/0x110
> [  593.769227] [<fffffc00003a8108>] handle_level_irq+0x108/0x240
> [  593.769227] [<fffffc00003158e0>] handle_irq+0x70/0xe0
> [  593.769227] [<fffffc0000320820>] 
> dp264_srm_device_interrupt+0x30/0x50
> [  593.769227] [<fffffc0000315af4>] do_entInt+0x1a4/0x200
> [  593.769227] [<fffffc0000310d00>] ret_from_sys_call+0x0/0x10
> [  593.769227] [<fffffc0000392164>] 
> torture_spin_lock_write_delay+0x74/0x180
> [  593.769227] [<fffffc00003d7cc8>] ktime_get+0x58/0x160
> [  593.769227] [<fffffc0000317fd0>] read_rpcc+0x0/0x10
> [  593.769227] [<fffffc0000317fd0>] read_rpcc+0x0/0x10
> [  593.769227] [<fffffc0000430aa8>] stutter_wait+0x88/0x110
> [  593.769227] [<fffffc0000391904>] lock_torture_writer+0x1d4/0x450
> [  593.769227] [<fffffc00003918cc>] lock_torture_writer+0x19c/0x450
> [  593.769227] [<fffffc000035a980>] kthread+0x150/0x190
> [  593.769227] [<fffffc0000391730>] lock_torture_writer+0x0/0x450
> [  593.769227] [<fffffc00003110d8>] ret_from_kernel_thread+0x18/0x20
> [  593.769227] [<fffffc000035a830>] kthread+0x0/0x190
> 
> [  593.769227] ---[ end trace 0000000000000000 ]---
> 
> 
> 
> Adding some machine relevant stuff here (for the sake of being 
> thorough)
> 
> The machine is a DEC DS10
> 
> root@bigbang:/lib/modules/6.12.12-SMP# lspci -vvv
> 00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA 
> Bridge [Aladdin IV/V/V+] (rev c3)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
> >TAbort- <TAbort+ <MAbort+ >SERR- <PERR- INTx-
>         Latency: 0
> 
> 00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 
> 21142/43 (rev 41)
>         Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 
> bytes
>         Interrupt: pin A routed to IRQ 29
>         Region 0: I/O ports at 8400 [size=128]
>         Region 1: Memory at 0a120000 (32-bit, non-prefetchable) 
> [size=1K]
>         Expansion ROM at 0a000000 [disabled] [size=256K]
>         Kernel driver in use: tulip
>         Kernel modules: tulip
> 
> 00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 
> 21142/43 (rev 41)
>         Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 
> bytes
>         Interrupt: pin A routed to IRQ 30
>         Region 0: I/O ports at 8480 [size=128]
>         Region 1: Memory at 0a121000 (32-bit, non-prefetchable) 
> [size=1K]
>         Expansion ROM at 0a040000 [disabled] [size=256K]
>         Kernel driver in use: tulip
>         Kernel modules: tulip
> 
> 00:0d.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c1) (prog-if 
> f0)
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (500ns min, 1000ns max)
>         Interrupt: pin A routed to IRQ 255
>         Region 0: I/O ports at 01f0 [size=8]
>         Region 1: I/O ports at 03f4
>         Region 2: I/O ports at 0170 [size=8]
>         Region 3: I/O ports at 0374
>         Region 4: I/O ports at 8880 [size=16]
>         Kernel driver in use: pata_ali
> 
> 00:0e.0 VGA compatible controller: Texas Instruments TVP4020 [Permedia 
> 2] (rev 01) (prog-if 00 [VGA controller])
>         Subsystem: Elsa AG GLoria Synergy
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (48000ns min, 48000ns max)
>         Interrupt: pin A routed to IRQ 35
>         Region 0: Memory at 0a080000 (32-bit, non-prefetchable) 
> [size=128K]
>         Region 1: Memory at 09000000 (32-bit, non-prefetchable) 
> [size=8M]
>         Region 2: Memory at 09800000 (32-bit, non-prefetchable) 
> [size=8M]
>         Expansion ROM at 0a100000 [disabled] [size=64K]
>         Kernel driver in use: pm2fb
> 
> 00:0f.0 USB controller: VIA Technologies, Inc. 
> VT82xx/62xx/VX700/8x0/900 UHCI USB 1.1 Controller (rev 61) (prog-if 00 
> [UHCI])
>         Subsystem: VIA Technologies, Inc. USB 1.1 UHCI controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 39
>         Region 4: I/O ports at 8800 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: uhci_hcd
> 
> 00:0f.1 USB controller: VIA Technologies, Inc. 
> VT82xx/62xx/VX700/8x0/900 UHCI USB 1.1 Controller (rev 61) (prog-if 00 
> [UHCI])
>         Subsystem: VIA Technologies, Inc. USB 1.1 UHCI controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255, Cache Line Size: 64 bytes
>         Interrupt: pin B routed to IRQ 38
>         Region 4: I/O ports at 8820 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: uhci_hcd
> 
> 00:0f.2 USB controller: VIA Technologies, Inc. USB 2.0 EHCI-Compliant 
> Host-Controller (rev 63) (prog-if 20 [EHCI])
>         Subsystem: VIA Technologies, Inc. USB 2.0 EHCI controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255, Cache Line Size: 64 bytes
>         Interrupt: pin C routed to IRQ 37
>         Region 0: Memory at 0a122000 (32-bit, non-prefetchable) 
> [size=256]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: ehci-pci
> 
> 00:10.0 Ethernet controller: Intel Corporation 82544EI Gigabit Ethernet 
> Controller (Fiber) (rev 02)
>         Subsystem: Intel Corporation PRO/1000 XF Server Adapter
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 252 (63750ns min), Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 43
>         Region 0: Memory at 0a0a0000 (32-bit, non-prefetchable) 
> [size=128K]
>         Region 1: Memory at 0a0c0000 (32-bit, non-prefetchable) 
> [size=128K]
>         Region 2: I/O ports at 8840 [size=32]
>         Expansion ROM at 0a0e0000 [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [e4] PCI-X non-bridge device
>                 Command: DPERE- ERO+ RBC=512 OST=1
>                 Status: Dev=00:00.0 64bit+ 133MHz+ SCD- USC- DC=simple 
> DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
>         Capabilities: [f0] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Kernel driver in use: e1000
> 
> 00:11.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE/SATA 
> Controller (rev 50)
>         Subsystem: VIA Technologies, Inc. VT6421 IDE/SATA Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 240
>         Interrupt: pin A routed to IRQ 47
>         Region 0: I/O ports at 8890 [size=16]
>         Region 1: I/O ports at 88a0 [size=16]
>         Region 2: I/O ports at 88b0 [size=16]
>         Region 3: I/O ports at 88c0 [size=16]
>         Region 4: I/O ports at 8860 [size=32]
>         Region 5: I/O ports at 8000 [size=256]
>         Expansion ROM at 0a110000 [disabled] [size=64K]
>         Capabilities: [e0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: sata_via
> 
> 
> root@bigbang:/lib/modules/6.12.12-SMP# cat /proc/cpuinfo
> cpu                     : Alpha
> cpu model               : EV6
> cpu variation           : 7
> cpu revision            : 0
> cpu serial number       :
> system type             : Tsunami
> system variation        : Webbrick
> system revision         : 0
> system serial number    : 4004DQMZ1055
> cycle frequency [Hz]    : 462437186 est.
> timer frequency [Hz]    : 1024.00
> page size [bytes]       : 8192
> phys. address bits      : 44
> max. addr. space #      : 255
> BogoMIPS                : 911.32
> kernel unaligned acc    : 0 (pc=0,va=0)
> user unaligned acc      : 0 (pc=0,va=0)
> platform string         : AlphaServer DS10 466 MHz
> cpus detected           : 1
> cpus active             : 1
> cpu active mask         : 0000000000000001
> L1 Icache               : 64K, 2-way, 64b line
> L1 Dcache               : 64K, 2-way, 64b line
> L2 cache                : 2048K, 1-way, 64b line
> L3 cache                : n/a
> 
> 
> 
> 
> 
> I also ran this setup again, with the USB/video/Intel NIC yanked out, 
> and it's the same...
> Once the IPs are bound, a link loss pops the message:
> (with the other PCI cards pulled)
> 
> 
> [  363.702938] ------------[ cut here ]------------
> [  363.702938] WARNING: CPU: 0 PID: 34 at kernel/time/timer.c:1657 
> __timer_delete_sync+0x10c/0x150
> [  363.702938] Modules linked in: tulip
> [  363.702938] CPU: 0 UID: 0 PID: 34 Comm: lock_torture_wr Not tainted 
> 6.12.12-SMP #1
> [  363.702938]        fffffc0002aefa70 fffffc00011b0ac0 
> fffffc000032a4f0 fffffc0000f8f181
> [  363.702938]        0000000000000000 0000000000000000 
> fffffc000032a688 fffffc000119c690
> [  363.702938]        0000000000000000 fffffc0000f8f181 
> fffffc00003d297c fffffc000125c7e0
> [  363.702938]        fffffffc008251c4 00000000fa83b2da 
> fffffc00003d297c fffffc0003ded490
> [  363.702938]        fffffc0003ded490 0000000000000000 
> fffffffff8668000 fffffd000a0c0000
> [  363.702938]        00000054ae626ca0 fffffc000285a600 
> fffffc000036692c fffffc000285af80
> [  363.702938] Trace:
> [  363.702938] [<fffffc000032a4f0>] __warn+0x190/0x1a0
> [  363.702938] [<fffffc000032a688>] warn_slowpath_fmt+0x188/0x240
> [  363.702938] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
> [  363.702938] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
> [  363.702938] [<fffffc000036692c>] ttwu_do_activate.isra.0+0x8c/0x1a0
> [  363.702938] [<fffffc0000369030>] try_to_wake_up+0x370/0x700
> [  363.702938] [<fffffc0000368e70>] try_to_wake_up+0x1b0/0x700
> [  363.702938] [<fffffc00003d43f8>] hrtimer_wakeup+0x28/0x40
> [  363.702938] [<fffffc00003d43d0>] hrtimer_wakeup+0x0/0x40
> [  363.702938] [<fffffc00003c31a4>] rcu_sched_clock_irq+0x714/0xea0
> [  363.702938] [<fffffc00003a1a80>] 
> __handle_irq_event_percpu+0x60/0x190
> [  363.702938] [<fffffc00003e6758>] tick_handle_periodic+0x38/0xd0
> [  363.702938] [<fffffc00003731e8>] enqueue_task_fair+0x358/0x8b0
> [  363.702938] [<fffffc00003a1cb8>] handle_irq_event+0x68/0x110
> [  363.702938] [<fffffc00003a8108>] handle_level_irq+0x108/0x240
> [  363.702938] [<fffffc00003158e0>] handle_irq+0x70/0xe0
> [  363.702938] [<fffffc0000320820>] 
> dp264_srm_device_interrupt+0x30/0x50
> [  363.702938] [<fffffc0000372538>] pick_task_fair+0x88/0x100
> [  363.702938] [<fffffc0000315af4>] do_entInt+0x1a4/0x200
> [  363.702938] [<fffffc0000310d00>] ret_from_sys_call+0x0/0x10
> [  363.702938] [<fffffc00003923dc>] __torture_rt_boost+0x5c/0x100
> [  363.702938] [<fffffc0000e291d8>] _raw_spin_lock+0x18/0x30
> [  363.702938] [<fffffc0000390330>] do_raw_spin_lock+0x0/0x140
> [  363.702938] [<fffffc00003903a0>] do_raw_spin_lock+0x70/0x140
> [  363.702938] [<fffffc0000e291d8>] _raw_spin_lock+0x18/0x30
> [  363.702938] [<fffffc0000390ac0>] 
> torture_spin_lock_write_lock+0x20/0x40
> [  363.702938] [<fffffc000039183c>] lock_torture_writer+0x10c/0x450
> [  363.702938] [<fffffc000035a980>] kthread+0x150/0x190
> [  363.702938] [<fffffc0000391730>] lock_torture_writer+0x0/0x450
> [  363.702938] [<fffffc00003110d8>] ret_from_kernel_thread+0x18/0x20
> [  363.702938] [<fffffc000035a830>] kthread+0x0/0x190
> 
> [  363.702938] ---[ end trace 0000000000000000 ]---
> 
> 
> 
> 
> I'm going to try one more thing, which is compile a non-specific alpha 
> kernel, and try it, but I don't think it'll change anything.




With the recompiled (fully from scratch) kernel with generic alpha vs 
DP264 I am still seeing the same thing.
What is odd is that I see "dp264_srm_device_interrupt" in the error 
though...
Next step is to make sure it's the tulip driver itself and not the 
network stack.  I can't use the i1000 card at the moment, so I need to 
find another PCI nic to test.


root@bigbang:~# zcat /proc/config.gz |grep CONFIG_ALPHA
CONFIG_ALPHA=y
CONFIG_ALPHA_GENERIC=y
# CONFIG_ALPHA_ALCOR is not set
# CONFIG_ALPHA_DP264 is not set
# CONFIG_ALPHA_EIGER is not set
# CONFIG_ALPHA_LX164 is not set
# CONFIG_ALPHA_MARVEL is not set
# CONFIG_ALPHA_MIATA is not set
# CONFIG_ALPHA_MIKASA is not set
# CONFIG_ALPHA_NAUTILUS is not set
# CONFIG_ALPHA_NORITAKE is not set
# CONFIG_ALPHA_PC164 is not set
# CONFIG_ALPHA_RAWHIDE is not set
# CONFIG_ALPHA_RUFFIAN is not set
# CONFIG_ALPHA_RX164 is not set
# CONFIG_ALPHA_SX164 is not set
# CONFIG_ALPHA_SABLE is not set
# CONFIG_ALPHA_SHARK is not set
# CONFIG_ALPHA_TAKARA is not set
# CONFIG_ALPHA_TITAN is not set
# CONFIG_ALPHA_WILDFIRE is not set
CONFIG_ALPHA_BROKEN_IRQ_MASK=y
# CONFIG_ALPHA_WTINT is not set
CONFIG_ALPHA_LEGACY_START_ADDRESS=y




[  204.662981] ------------[ cut here ]------------
[  204.662981] WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1657 
__timer_delete_sync+0x10c/0x150
[  204.662981] Modules linked in: tulip
[  204.662981] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 
6.12.12-SMP #1
[  204.662981]        fffffc00011c7a20 fffffc0008b62000 fffffc00003314e0 
fffffc0000fa108f
[  204.662981]        0000000000000000 0000000000000000 fffffc0000331678 
fffffc00011bc690
[  204.662981]        0000000000000000 fffffc0000fa108f fffffc00003d99cc 
fffffc00012829e0
[  204.662981]        fffffd000a0c0060 00000000e0ccdeeb fffffc00003d99cc 
fffffc0008b62000
[  204.662981]        fffffc0008b63490 0000000000000000 fffffd000a0c0000 
fffffd000a0c0070
[  204.662981]        fffffc0000370040 fffffc000283d580 0000002fa6dd421e 
0000000000000000
[  204.662981] Trace:
[  204.662981] [<fffffc00003314e0>] __warn+0x190/0x1a0
[  204.662981] [<fffffc0000331678>] warn_slowpath_fmt+0x188/0x240
[  204.662981] [<fffffc00003d99cc>] __timer_delete_sync+0x10c/0x150
[  204.662981] [<fffffc00003d99cc>] __timer_delete_sync+0x10c/0x150
[  204.662981] [<fffffc0000370040>] try_to_wake_up+0x370/0x700
[  204.662981] [<fffffc000036d960>] ttwu_do_activate.isra.0+0xb0/0x1a0
[  204.662981] [<fffffc0000e37960>] 
_raw_spin_unlock_irqrestore+0x20/0x40
[  204.662981] [<fffffc000036fe80>] try_to_wake_up+0x1b0/0x700
[  204.662981] [<fffffc00003a8aa0>] __handle_irq_event_percpu+0x60/0x190
[  204.662981] [<fffffc0000318214>] rtc_timer_interrupt+0x44/0xc0
[  204.662981] [<fffffc00003a8c50>] handle_irq_event_percpu+0x80/0xa0
[  204.662981] [<fffffc00003a8cd8>] handle_irq_event+0x68/0x110
[  204.662981] [<fffffc00003af128>] handle_level_irq+0x108/0x240
[  204.662981] [<fffffc00003159cc>] handle_irq+0x7c/0xf0
[  204.662981] [<fffffc00003244b0>] dp264_srm_device_interrupt+0x30/0x50
[  204.662981] [<fffffc000037d714>] pick_next_task_fair+0x114/0x200
[  204.662981] [<fffffc0000315be4>] do_entInt+0x1a4/0x200
[  204.662981] [<fffffc0000310d00>] ret_from_sys_call+0x0/0x10
[  204.662981] [<fffffc0000e37898>] _raw_spin_unlock+0x18/0x30
[  204.662981] [<fffffc000038769c>] update_dl_rq_load_avg+0x1bc/0x350
[  204.662981] [<fffffc0000e2c54c>] cpu_idle_poll.isra.0+0x1c/0xa0
[  204.662981] [<fffffc0000e2be60>] ct_kernel_enter_state+0x0/0x50
[  204.662981] [<fffffc0000e2c580>] cpu_idle_poll.isra.0+0x50/0xa0
[  204.662981] [<fffffc0000383318>] do_idle+0x78/0x1d0
[  204.662981] [<fffffc0000383798>] cpu_startup_entry+0x58/0x70
[  204.662981] [<fffffc0000e2c77c>] rest_init+0x11c/0x120
[  204.662981] [<fffffc000031001c>] _stext+0x1c/0x20
[  204.662981] [<fffffc0000312460>] do_entUnaUser+0x520/0x550
[  204.662981] [<fffffc0000cbd6f8>] rtm_new_nexthop+0x14c8/0x1800

[  204.662981] ---[ end trace 0000000000000000 ]---


