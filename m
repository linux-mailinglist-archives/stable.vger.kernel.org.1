Return-Path: <stable+bounces-154822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5547AE0D38
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 20:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF4E3BD047
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A82244686;
	Thu, 19 Jun 2025 18:56:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from constellation.wizardsworks.org (wizardsworks.org [24.234.38.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707330E84E;
	Thu, 19 Jun 2025 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.234.38.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359372; cv=none; b=FgGckgn0VLaHBaX0GowzUZUn5DLqMZ7l24zuC48aOUaqfNc04v6zkZlSvEyU/ODBHb5JojkIoDrouZ5wjPExZsSALWN+XsZzpohMyX2H67BxK6R9zm9lyBgSqcm3fi1sMlswai6Eq8l6KB7Z7j3LpEza+OUfF7dVq20xL88DM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359372; c=relaxed/simple;
	bh=KOzlRBo1KWM/aKpCch/mcTGYkA9Zqq1gIuxQmN57YXM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bmG3W+AIapmZHYgjPHO/hvWXP4FuLhaGa/hfk0nLsgU0qiAPTAJz9i9mBTht40K06xa9bnW4jVL7veiuiiZmOeJBZsoKm2TFxonFU0UnOV7dRt2WvwgTxD3ugHM6kpvcKyOaAQ02KhA28Hs+VJ8ahTdLjuNpVGtqxbTvzSlsvEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org; spf=pass smtp.mailfrom=wizardsworks.org; arc=none smtp.client-ip=24.234.38.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizardsworks.org
Received: from mail.wizardsworks.org (localhost [127.0.0.1])
	by constellation.wizardsworks.org (8.18.1/8.18.1) with ESMTP id 55JIvjCI005951;
	Thu, 19 Jun 2025 11:57:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Jun 2025 11:57:45 -0700
From: Greg Chandler <chandleg@wizardsworks.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <12ccf3e4c24e8db2545f6ccaba8ce273@wizardsworks.org>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
 <385f2469f504dd293775d3c39affa979@wizardsworks.org>
 <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com>
 <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
 <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com>
 <a3d8ee993b73b826b537f374d78084ad@wizardsworks.org>
 <12ccf3e4c24e8db2545f6ccaba8ce273@wizardsworks.org>
Message-ID: <8c06f8969e726912b46ef941d36571ad@wizardsworks.org>
X-Sender: chandleg@wizardsworks.org
Content-Type: multipart/mixed;
 boundary="=_79d7279178f2b1a21b4c1e64c97a9c50"

--=_79d7279178f2b1a21b4c1e64c97a9c50
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

On 2025/06/18 15:51, Greg Chandler wrote:
> On 2025/06/18 13:59, Greg Chandler wrote:
>> On 2025/06/17 11:22, Florian Fainelli wrote:
>>> (please no top posting)
>>> 
>>> On 6/17/25 11:19, Greg Chandler wrote:
>>>> 
>>>> Hmm...  I'm wondering if that means it's an alpha-only issue then, 
>>>> which would make this a much larger headache than it already is.
>>>> Also thank you for checking, I appreciate you taking the time.
>>>> 
>>>> I assume the those interfaces actually work right? (simple ping over 
>>>> that interface would be enough)  I posted in a subsequent message 
>>>> that mine do not appear to at all.
>>> 
>>> Oh yeah, they work just fine:
>>> 
>>> udhcpc: broadcasting discover
>>> [   19.197697] net eth0: Setting full-duplex based on MII#1 link 
>>> partner capability of cde1
>>> 
>>> # ping -c 1 192.168.254.123
>>> PING 192.168.254.123 (192.168.254.123): 56 data bytes
>>> 64 bytes from 192.168.254.123: seq=0 ttl=64 time=2.902 ms
>>> 
>>> --- 192.168.254.123 ping statistics ---
>>> 1 packets transmitted, 1 packets received, 0% packet loss
>>> round-trip min/avg/max = 2.902/2.902/2.902 ms
>>> 
>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>> [ ID] Interval           Transfer     Bitrate         Retr
>>> [  5]   0.00-10.03  sec  39.6 MBytes  33.1 Mbits/sec    0            
>>> sender
>>> [  5]   0.00-10.07  sec  39.8 MBytes  33.1 Mbits/sec receiver
>>> 
>>> 
>>>> 
>>>> My next step is to build that driver as a module, and see if it 
>>>> changes anything (I'm doubting it will).
>>>> Then after that go dig up a different adapter, and see if it's the 
>>>> network stack or the driver.
>>>> 
>>>> I've been hard pressed over the last week to get a lot of diagnosing 
>>>> time.
>>> 
>>> Let me know if I can run experiments, I can load any kernel version 
>>> on this Cobalt Qube2 meaning that bisections are possible.
>>> 
>>> Good luck!
>> 
>> 
>> 
>> 
>> I thought I replied to the whole list, not just the sender, sorry for 
>> the repeat....
>> (full config is attached)
>> 
>> 
>> As a module, the system booted up but did not probe the module.
>> This may be from a variety of issues, not limited to the fact I am 
>> still rolling this distro from scratch, and not all of the tools are 
>> 100% working yet.
>> I'm having some issues with gcc/gdb so I have a large number of 
>> debugging options turned on in the kernel as well.
>> 
>> 
>> When the module is loaded with insmod:
>> 
>> [  213.363172] tulip 0000:00:09.0: vgaarb: pci_notify
>> [  213.363172] tulip 0000:00:09.0: assign IRQ: got 29
>> [  213.363172] tulip 0000:00:09.0: enabling Mem-Wr-Inval
>> [  213.369031] tulip0: EEPROM default media type Autosense
>> [  213.369031] tulip0: Index #0 - Media 10baseT (#0) described by a 
>> 21142 Serial PHY (2) block
>> [  213.369031] tulip0: Index #1 - Media 10baseT-FDX (#4) described by 
>> a 21142 Serial PHY (2) block
>> [  213.370007] tulip0: Index #2 - Media 100baseTx (#3) described by a 
>> 21143 SYM PHY (4) block
>> [  213.370007] tulip0: Index #3 - Media 100baseTx-FDX (#5) described 
>> by a 21143 SYM PHY (4) block
>> [  213.376843] net eth1: Digital DS21142/43 Tulip rev 65 at MMIO 
>> 0xa120000, 08:00:2b:86:ab:b1, IRQ 29
>> [  213.377820] tulip 0000:00:09.0: vgaarb: pci_notify
>> [  213.377820] tulip 0000:00:0b.0: vgaarb: pci_notify
>> [  213.377820] tulip 0000:00:0b.0: assign IRQ: got 30
>> [  213.377820] tulip 0000:00:0b.0: enabling Mem-Wr-Inval
>> [  213.384656] tulip1: EEPROM default media type Autosense
>> [  213.384656] tulip1: Index #0 - Media 10baseT (#0) described by a 
>> 21142 Serial PHY (2) block
>> [  213.384656] tulip1: Index #1 - Media 10baseT-FDX (#4) described by 
>> a 21142 Serial PHY (2) block
>> [  213.384656] tulip1: Index #2 - Media 100baseTx (#3) described by a 
>> 21143 SYM PHY (4) block
>> [  213.384656] tulip1: Index #3 - Media 100baseTx-FDX (#5) described 
>> by a 21143 SYM PHY (4) block
>> [  213.391492] net eth2: Digital DS21142/43 Tulip rev 65 at MMIO 
>> 0xa121000, 08:00:2b:86:a8:5b, IRQ 30
>> 
>> 
>> 
>> root@bigbang:/lib/modules/6.12.12-SMP# mii-tool eth1
>> eth1: no link
>> 
>> root@bigbang:/lib/modules/6.12.12-SMP# mii-tool eth2
>> eth2: autonegotiation failed, link ok
>> 
>> 
>> 
>> When I pulled the plug I did not get the crash..
>> When I plugged it back in, I did not get a dmesg/kernel line for the 
>> link.
>> 
>> 
>> 
>> I bound the IP addresses to both, and did a ping test to the default 
>> gateway, resulting in:
>> (I promise the network is properly configured)
>> 
>> root@bigbang:/lib/modules/6.12.12-SMP# ping 192.168.1.1
>> PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
>> From 192.168.1.75 icmp_seq=1 Destination Host Unreachable
>> From 192.168.1.75 icmp_seq=2 Destination Host Unreachable
>> From 192.168.1.75 icmp_seq=3 Destination Host Unreachable
>> 
>> 
>> 
>> Upon pulling the cord out of the switch **after** the IP address was 
>> bound, we are back to this:
>> [  593.769227] ------------[ cut here ]------------
>> [  593.769227] WARNING: CPU: 0 PID: 33 at kernel/time/timer.c:1657 
>> __timer_delete_sync+0x10c/0x150
>> [  593.769227] Modules linked in: tulip
>> [  593.769227] CPU: 0 UID: 0 PID: 33 Comm: lock_torture_wr Not tainted 
>> 6.12.12-SMP #1
>> [  593.769227]        fffffc0002aeba40 fffffc00011b0ac0 
>> fffffc000032a4f0 fffffc0000f8f181
>> [  593.769227]        0000000000000000 0000000000000000 
>> fffffc000032a688 fffffc000119c690
>> [  593.769227]        0000000000000000 fffffc0000f8f181 
>> fffffc00003d297c fffffc000125c7e0
>> [  593.769227]        fffffffc0082f1c4 00000000efe4b99a 
>> fffffc00003d297c fffffc000b03b490
>> [  593.769227]        fffffc000b03b490 0000000000000000 
>> fffffffff8668000 fffffd000a120000
>> [  593.769227]        fffffc0000366888 fffffc000020ce00 
>> fffffc000020ce00 0000000000000008
>> [  593.769227] Trace:
>> [  593.769227] [<fffffc000032a4f0>] __warn+0x190/0x1a0
>> [  593.769227] [<fffffc000032a688>] warn_slowpath_fmt+0x188/0x240
>> [  593.769227] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
>> [  593.769227] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
>> [  593.769227] [<fffffc0000366888>] wakeup_preempt+0xb8/0xd0
>> [  593.769227] [<fffffc0000366950>] ttwu_do_activate.isra.0+0xb0/0x1a0
>> [  593.769227] [<fffffc0000369030>] try_to_wake_up+0x370/0x700
>> [  593.769227] [<fffffc0000e29470>] 
>> _raw_spin_unlock_irqrestore+0x20/0x40
>> [  593.769227] [<fffffc000036e1c4>] task_tick_fair+0x74/0x370
>> [  593.769227] [<fffffc00003d46dc>] enqueue_hrtimer.isra.0+0x5c/0xc0
>> [  593.769227] [<fffffc000037bc1c>] task_non_contending+0xcc/0x4f0
>> [  593.769227] [<fffffc00003a1a80>] 
>> __handle_irq_event_percpu+0x60/0x190
>> [  593.769227] [<fffffc000036d598>] 
>> sched_balance_update_blocked_averages+0xc8/0x2a0
>> [  593.769227] [<fffffc00003a1cb8>] handle_irq_event+0x68/0x110
>> [  593.769227] [<fffffc00003a8108>] handle_level_irq+0x108/0x240
>> [  593.769227] [<fffffc00003158e0>] handle_irq+0x70/0xe0
>> [  593.769227] [<fffffc0000320820>] 
>> dp264_srm_device_interrupt+0x30/0x50
>> [  593.769227] [<fffffc0000315af4>] do_entInt+0x1a4/0x200
>> [  593.769227] [<fffffc0000310d00>] ret_from_sys_call+0x0/0x10
>> [  593.769227] [<fffffc0000392164>] 
>> torture_spin_lock_write_delay+0x74/0x180
>> [  593.769227] [<fffffc00003d7cc8>] ktime_get+0x58/0x160
>> [  593.769227] [<fffffc0000317fd0>] read_rpcc+0x0/0x10
>> [  593.769227] [<fffffc0000317fd0>] read_rpcc+0x0/0x10
>> [  593.769227] [<fffffc0000430aa8>] stutter_wait+0x88/0x110
>> [  593.769227] [<fffffc0000391904>] lock_torture_writer+0x1d4/0x450
>> [  593.769227] [<fffffc00003918cc>] lock_torture_writer+0x19c/0x450
>> [  593.769227] [<fffffc000035a980>] kthread+0x150/0x190
>> [  593.769227] [<fffffc0000391730>] lock_torture_writer+0x0/0x450
>> [  593.769227] [<fffffc00003110d8>] ret_from_kernel_thread+0x18/0x20
>> [  593.769227] [<fffffc000035a830>] kthread+0x0/0x190
>> 
>> [  593.769227] ---[ end trace 0000000000000000 ]---
>> 
>> 
>> 
>> Adding some machine relevant stuff here (for the sake of being 
>> thorough)
>> 
>> The machine is a DEC DS10
>> 
>> root@bigbang:/lib/modules/6.12.12-SMP# lspci -vvv
>> 00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA 
>> Bridge [Aladdin IV/V/V+] (rev c3)
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
>> >TAbort- <TAbort+ <MAbort+ >SERR- <PERR- INTx-
>>         Latency: 0
>> 
>> 00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 
>> 21142/43 (rev 41)
>>         Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 
>> bytes
>>         Interrupt: pin A routed to IRQ 29
>>         Region 0: I/O ports at 8400 [size=128]
>>         Region 1: Memory at 0a120000 (32-bit, non-prefetchable) 
>> [size=1K]
>>         Expansion ROM at 0a000000 [disabled] [size=256K]
>>         Kernel driver in use: tulip
>>         Kernel modules: tulip
>> 
>> 00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 
>> 21142/43 (rev 41)
>>         Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 
>> bytes
>>         Interrupt: pin A routed to IRQ 30
>>         Region 0: I/O ports at 8480 [size=128]
>>         Region 1: Memory at 0a121000 (32-bit, non-prefetchable) 
>> [size=1K]
>>         Expansion ROM at 0a040000 [disabled] [size=256K]
>>         Kernel driver in use: tulip
>>         Kernel modules: tulip
>> 
>> 00:0d.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c1) 
>> (prog-if f0)
>>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 255 (500ns min, 1000ns max)
>>         Interrupt: pin A routed to IRQ 255
>>         Region 0: I/O ports at 01f0 [size=8]
>>         Region 1: I/O ports at 03f4
>>         Region 2: I/O ports at 0170 [size=8]
>>         Region 3: I/O ports at 0374
>>         Region 4: I/O ports at 8880 [size=16]
>>         Kernel driver in use: pata_ali
>> 
>> 00:0e.0 VGA compatible controller: Texas Instruments TVP4020 [Permedia 
>> 2] (rev 01) (prog-if 00 [VGA controller])
>>         Subsystem: Elsa AG GLoria Synergy
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 255 (48000ns min, 48000ns max)
>>         Interrupt: pin A routed to IRQ 35
>>         Region 0: Memory at 0a080000 (32-bit, non-prefetchable) 
>> [size=128K]
>>         Region 1: Memory at 09000000 (32-bit, non-prefetchable) 
>> [size=8M]
>>         Region 2: Memory at 09800000 (32-bit, non-prefetchable) 
>> [size=8M]
>>         Expansion ROM at 0a100000 [disabled] [size=64K]
>>         Kernel driver in use: pm2fb
>> 
>> 00:0f.0 USB controller: VIA Technologies, Inc. 
>> VT82xx/62xx/VX700/8x0/900 UHCI USB 1.1 Controller (rev 61) (prog-if 00 
>> [UHCI])
>>         Subsystem: VIA Technologies, Inc. USB 1.1 UHCI controller
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 255, Cache Line Size: 64 bytes
>>         Interrupt: pin A routed to IRQ 39
>>         Region 4: I/O ports at 8800 [size=32]
>>         Capabilities: [80] Power Management version 2
>>                 Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
>> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Kernel driver in use: uhci_hcd
>> 
>> 00:0f.1 USB controller: VIA Technologies, Inc. 
>> VT82xx/62xx/VX700/8x0/900 UHCI USB 1.1 Controller (rev 61) (prog-if 00 
>> [UHCI])
>>         Subsystem: VIA Technologies, Inc. USB 1.1 UHCI controller
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 255, Cache Line Size: 64 bytes
>>         Interrupt: pin B routed to IRQ 38
>>         Region 4: I/O ports at 8820 [size=32]
>>         Capabilities: [80] Power Management version 2
>>                 Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
>> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Kernel driver in use: uhci_hcd
>> 
>> 00:0f.2 USB controller: VIA Technologies, Inc. USB 2.0 EHCI-Compliant 
>> Host-Controller (rev 63) (prog-if 20 [EHCI])
>>         Subsystem: VIA Technologies, Inc. USB 2.0 EHCI controller
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 255, Cache Line Size: 64 bytes
>>         Interrupt: pin C routed to IRQ 37
>>         Region 0: Memory at 0a122000 (32-bit, non-prefetchable) 
>> [size=256]
>>         Capabilities: [80] Power Management version 2
>>                 Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
>> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Kernel driver in use: ehci-pci
>> 
>> 00:10.0 Ethernet controller: Intel Corporation 82544EI Gigabit 
>> Ethernet Controller (Fiber) (rev 02)
>>         Subsystem: Intel Corporation PRO/1000 XF Server Adapter
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 252 (63750ns min), Cache Line Size: 64 bytes
>>         Interrupt: pin A routed to IRQ 43
>>         Region 0: Memory at 0a0a0000 (32-bit, non-prefetchable) 
>> [size=128K]
>>         Region 1: Memory at 0a0c0000 (32-bit, non-prefetchable) 
>> [size=128K]
>>         Region 2: I/O ports at 8840 [size=32]
>>         Expansion ROM at 0a0e0000 [disabled] [size=128K]
>>         Capabilities: [dc] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
>> PME(D0+,D1-,D2-,D3hot+,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>>         Capabilities: [e4] PCI-X non-bridge device
>>                 Command: DPERE- ERO+ RBC=512 OST=1
>>                 Status: Dev=00:00.0 64bit+ 133MHz+ SCD- USC- DC=simple 
>> DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
>>         Capabilities: [f0] MSI: Enable- Count=1/1 Maskable- 64bit+
>>                 Address: 0000000000000000  Data: 0000
>>         Kernel driver in use: e1000
>> 
>> 00:11.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE/SATA 
>> Controller (rev 50)
>>         Subsystem: VIA Technologies, Inc. VT6421 IDE/SATA Controller
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 240
>>         Interrupt: pin A routed to IRQ 47
>>         Region 0: I/O ports at 8890 [size=16]
>>         Region 1: I/O ports at 88a0 [size=16]
>>         Region 2: I/O ports at 88b0 [size=16]
>>         Region 3: I/O ports at 88c0 [size=16]
>>         Region 4: I/O ports at 8860 [size=32]
>>         Region 5: I/O ports at 8000 [size=256]
>>         Expansion ROM at 0a110000 [disabled] [size=64K]
>>         Capabilities: [e0] Power Management version 2
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Kernel driver in use: sata_via
>> 
>> 
>> root@bigbang:/lib/modules/6.12.12-SMP# cat /proc/cpuinfo
>> cpu                     : Alpha
>> cpu model               : EV6
>> cpu variation           : 7
>> cpu revision            : 0
>> cpu serial number       :
>> system type             : Tsunami
>> system variation        : Webbrick
>> system revision         : 0
>> system serial number    : 4004DQMZ1055
>> cycle frequency [Hz]    : 462437186 est.
>> timer frequency [Hz]    : 1024.00
>> page size [bytes]       : 8192
>> phys. address bits      : 44
>> max. addr. space #      : 255
>> BogoMIPS                : 911.32
>> kernel unaligned acc    : 0 (pc=0,va=0)
>> user unaligned acc      : 0 (pc=0,va=0)
>> platform string         : AlphaServer DS10 466 MHz
>> cpus detected           : 1
>> cpus active             : 1
>> cpu active mask         : 0000000000000001
>> L1 Icache               : 64K, 2-way, 64b line
>> L1 Dcache               : 64K, 2-way, 64b line
>> L2 cache                : 2048K, 1-way, 64b line
>> L3 cache                : n/a
>> 
>> 
>> 
>> 
>> 
>> I also ran this setup again, with the USB/video/Intel NIC yanked out, 
>> and it's the same...
>> Once the IPs are bound, a link loss pops the message:
>> (with the other PCI cards pulled)
>> 
>> 
>> [  363.702938] ------------[ cut here ]------------
>> [  363.702938] WARNING: CPU: 0 PID: 34 at kernel/time/timer.c:1657 
>> __timer_delete_sync+0x10c/0x150
>> [  363.702938] Modules linked in: tulip
>> [  363.702938] CPU: 0 UID: 0 PID: 34 Comm: lock_torture_wr Not tainted 
>> 6.12.12-SMP #1
>> [  363.702938]        fffffc0002aefa70 fffffc00011b0ac0 
>> fffffc000032a4f0 fffffc0000f8f181
>> [  363.702938]        0000000000000000 0000000000000000 
>> fffffc000032a688 fffffc000119c690
>> [  363.702938]        0000000000000000 fffffc0000f8f181 
>> fffffc00003d297c fffffc000125c7e0
>> [  363.702938]        fffffffc008251c4 00000000fa83b2da 
>> fffffc00003d297c fffffc0003ded490
>> [  363.702938]        fffffc0003ded490 0000000000000000 
>> fffffffff8668000 fffffd000a0c0000
>> [  363.702938]        00000054ae626ca0 fffffc000285a600 
>> fffffc000036692c fffffc000285af80
>> [  363.702938] Trace:
>> [  363.702938] [<fffffc000032a4f0>] __warn+0x190/0x1a0
>> [  363.702938] [<fffffc000032a688>] warn_slowpath_fmt+0x188/0x240
>> [  363.702938] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
>> [  363.702938] [<fffffc00003d297c>] __timer_delete_sync+0x10c/0x150
>> [  363.702938] [<fffffc000036692c>] ttwu_do_activate.isra.0+0x8c/0x1a0
>> [  363.702938] [<fffffc0000369030>] try_to_wake_up+0x370/0x700
>> [  363.702938] [<fffffc0000368e70>] try_to_wake_up+0x1b0/0x700
>> [  363.702938] [<fffffc00003d43f8>] hrtimer_wakeup+0x28/0x40
>> [  363.702938] [<fffffc00003d43d0>] hrtimer_wakeup+0x0/0x40
>> [  363.702938] [<fffffc00003c31a4>] rcu_sched_clock_irq+0x714/0xea0
>> [  363.702938] [<fffffc00003a1a80>] 
>> __handle_irq_event_percpu+0x60/0x190
>> [  363.702938] [<fffffc00003e6758>] tick_handle_periodic+0x38/0xd0
>> [  363.702938] [<fffffc00003731e8>] enqueue_task_fair+0x358/0x8b0
>> [  363.702938] [<fffffc00003a1cb8>] handle_irq_event+0x68/0x110
>> [  363.702938] [<fffffc00003a8108>] handle_level_irq+0x108/0x240
>> [  363.702938] [<fffffc00003158e0>] handle_irq+0x70/0xe0
>> [  363.702938] [<fffffc0000320820>] 
>> dp264_srm_device_interrupt+0x30/0x50
>> [  363.702938] [<fffffc0000372538>] pick_task_fair+0x88/0x100
>> [  363.702938] [<fffffc0000315af4>] do_entInt+0x1a4/0x200
>> [  363.702938] [<fffffc0000310d00>] ret_from_sys_call+0x0/0x10
>> [  363.702938] [<fffffc00003923dc>] __torture_rt_boost+0x5c/0x100
>> [  363.702938] [<fffffc0000e291d8>] _raw_spin_lock+0x18/0x30
>> [  363.702938] [<fffffc0000390330>] do_raw_spin_lock+0x0/0x140
>> [  363.702938] [<fffffc00003903a0>] do_raw_spin_lock+0x70/0x140
>> [  363.702938] [<fffffc0000e291d8>] _raw_spin_lock+0x18/0x30
>> [  363.702938] [<fffffc0000390ac0>] 
>> torture_spin_lock_write_lock+0x20/0x40
>> [  363.702938] [<fffffc000039183c>] lock_torture_writer+0x10c/0x450
>> [  363.702938] [<fffffc000035a980>] kthread+0x150/0x190
>> [  363.702938] [<fffffc0000391730>] lock_torture_writer+0x0/0x450
>> [  363.702938] [<fffffc00003110d8>] ret_from_kernel_thread+0x18/0x20
>> [  363.702938] [<fffffc000035a830>] kthread+0x0/0x190
>> 
>> [  363.702938] ---[ end trace 0000000000000000 ]---
>> 
>> 
>> 
>> 
>> I'm going to try one more thing, which is compile a non-specific alpha 
>> kernel, and try it, but I don't think it'll change anything.
> 
> 
> 
> 
> With the recompiled (fully from scratch) kernel with generic alpha vs 
> DP264 I am still seeing the same thing.
> What is odd is that I see "dp264_srm_device_interrupt" in the error 
> though...
> Next step is to make sure it's the tulip driver itself and not the 
> network stack.  I can't use the i1000 card at the moment, so I need to 
> find another PCI nic to test.
> 
> 
> root@bigbang:~# zcat /proc/config.gz |grep CONFIG_ALPHA
> CONFIG_ALPHA=y
> CONFIG_ALPHA_GENERIC=y
> # CONFIG_ALPHA_ALCOR is not set
> # CONFIG_ALPHA_DP264 is not set
> # CONFIG_ALPHA_EIGER is not set
> # CONFIG_ALPHA_LX164 is not set
> # CONFIG_ALPHA_MARVEL is not set
> # CONFIG_ALPHA_MIATA is not set
> # CONFIG_ALPHA_MIKASA is not set
> # CONFIG_ALPHA_NAUTILUS is not set
> # CONFIG_ALPHA_NORITAKE is not set
> # CONFIG_ALPHA_PC164 is not set
> # CONFIG_ALPHA_RAWHIDE is not set
> # CONFIG_ALPHA_RUFFIAN is not set
> # CONFIG_ALPHA_RX164 is not set
> # CONFIG_ALPHA_SX164 is not set
> # CONFIG_ALPHA_SABLE is not set
> # CONFIG_ALPHA_SHARK is not set
> # CONFIG_ALPHA_TAKARA is not set
> # CONFIG_ALPHA_TITAN is not set
> # CONFIG_ALPHA_WILDFIRE is not set
> CONFIG_ALPHA_BROKEN_IRQ_MASK=y
> # CONFIG_ALPHA_WTINT is not set
> CONFIG_ALPHA_LEGACY_START_ADDRESS=y
> 
> 
> 
> 
> [  204.662981] ------------[ cut here ]------------
> [  204.662981] WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1657 
> __timer_delete_sync+0x10c/0x150
> [  204.662981] Modules linked in: tulip
> [  204.662981] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 
> 6.12.12-SMP #1
> [  204.662981]        fffffc00011c7a20 fffffc0008b62000 
> fffffc00003314e0 fffffc0000fa108f
> [  204.662981]        0000000000000000 0000000000000000 
> fffffc0000331678 fffffc00011bc690
> [  204.662981]        0000000000000000 fffffc0000fa108f 
> fffffc00003d99cc fffffc00012829e0
> [  204.662981]        fffffd000a0c0060 00000000e0ccdeeb 
> fffffc00003d99cc fffffc0008b62000
> [  204.662981]        fffffc0008b63490 0000000000000000 
> fffffd000a0c0000 fffffd000a0c0070
> [  204.662981]        fffffc0000370040 fffffc000283d580 
> 0000002fa6dd421e 0000000000000000
> [  204.662981] Trace:
> [  204.662981] [<fffffc00003314e0>] __warn+0x190/0x1a0
> [  204.662981] [<fffffc0000331678>] warn_slowpath_fmt+0x188/0x240
> [  204.662981] [<fffffc00003d99cc>] __timer_delete_sync+0x10c/0x150
> [  204.662981] [<fffffc00003d99cc>] __timer_delete_sync+0x10c/0x150
> [  204.662981] [<fffffc0000370040>] try_to_wake_up+0x370/0x700
> [  204.662981] [<fffffc000036d960>] ttwu_do_activate.isra.0+0xb0/0x1a0
> [  204.662981] [<fffffc0000e37960>] 
> _raw_spin_unlock_irqrestore+0x20/0x40
> [  204.662981] [<fffffc000036fe80>] try_to_wake_up+0x1b0/0x700
> [  204.662981] [<fffffc00003a8aa0>] 
> __handle_irq_event_percpu+0x60/0x190
> [  204.662981] [<fffffc0000318214>] rtc_timer_interrupt+0x44/0xc0
> [  204.662981] [<fffffc00003a8c50>] handle_irq_event_percpu+0x80/0xa0
> [  204.662981] [<fffffc00003a8cd8>] handle_irq_event+0x68/0x110
> [  204.662981] [<fffffc00003af128>] handle_level_irq+0x108/0x240
> [  204.662981] [<fffffc00003159cc>] handle_irq+0x7c/0xf0
> [  204.662981] [<fffffc00003244b0>] 
> dp264_srm_device_interrupt+0x30/0x50
> [  204.662981] [<fffffc000037d714>] pick_next_task_fair+0x114/0x200
> [  204.662981] [<fffffc0000315be4>] do_entInt+0x1a4/0x200
> [  204.662981] [<fffffc0000310d00>] ret_from_sys_call+0x0/0x10
> [  204.662981] [<fffffc0000e37898>] _raw_spin_unlock+0x18/0x30
> [  204.662981] [<fffffc000038769c>] update_dl_rq_load_avg+0x1bc/0x350
> [  204.662981] [<fffffc0000e2c54c>] cpu_idle_poll.isra.0+0x1c/0xa0
> [  204.662981] [<fffffc0000e2be60>] ct_kernel_enter_state+0x0/0x50
> [  204.662981] [<fffffc0000e2c580>] cpu_idle_poll.isra.0+0x50/0xa0
> [  204.662981] [<fffffc0000383318>] do_idle+0x78/0x1d0
> [  204.662981] [<fffffc0000383798>] cpu_startup_entry+0x58/0x70
> [  204.662981] [<fffffc0000e2c77c>] rest_init+0x11c/0x120
> [  204.662981] [<fffffc000031001c>] _stext+0x1c/0x20
> [  204.662981] [<fffffc0000312460>] do_entUnaUser+0x520/0x550
> [  204.662981] [<fffffc0000cbd6f8>] rtm_new_nexthop+0x14c8/0x1800
> 
> [  204.662981] ---[ end trace 0000000000000000 ]---




Well I have good news, and that is, it's the driver, and not the 
platform or the network stack.
The bad news is that it's the driver on this platform with this network 
stack...

I already had the e1000 driver compiled in, and I was able to find one 
of those laying around (finally)

[    7.578121] e1000 0000:00:0f.0 eth124: renamed from eth2
[    7.581050] e1000 0000:00:0f.0 eth3: renamed from eth124
[  124.012631] e1000: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow 
Control: RX/TX


root@bigbang:~# ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.763 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=2.32 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=2.76 ms
64 bytes from 192.168.1.1: icmp_seq=4 ttl=64 time=0.554 ms

Then I removed the the ethernet cable, and all I see in the dmesg is 
this:
[  124.012631] e1000: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow 
Control: RX/TX
[  132.938408] tulip 0000:00:0b.0 eth1: tulip_stop_rxtx() failed (CSR5 
0xf0660000 CSR6 0xb3862002)
[  167.312414] e1000: eth3 NIC Link is Down


Which is excactly what we expect to see (the link down message)



So what I know for sure is this:
The tulip driver on alpha (generic and DP264) oops/panic on physical 
disconnect, but only when an IP address is bound.
It does not panic when no address is bound to the interface.
It does not matter if the driver is compiled in, or if it is compiled as 
a module.
It does not matter if all of the options are set for tulip or if none of 
them are:
     New bus configuration
     Use PCI shared mem for NIC registers
     Use RX polling (NAPI)
     Use Interrupt Mitigation
The physical link does not auto-negotiate, and mii-tool does not seem to 
be able to force it with -F or -A like you would expect it to.
The kernel does not drop the "Link is Up/Link is Down" messages when the 
PHY "links"
The switch and interface both show LEDs as if linked at 10-Half-Duplex, 
and the lights turn off when the link is broken.
Subsequently they do relink at 10-Half again if plugged back in.
I did also attempt to test the kernel level stack for nfsroot, just to 
see if it worked prior to init launching everything else, and it did 
not.
I used the same IP configuration for that test as all of the tests in 
these emails.
All of the oops/panics seem to happen at:
     kernel/time/timer.c:1657 __timer_delete_sync+0x10c/0x150

I've attached my normal running config (non-diagnostic) set for the 
platform (DP264).


--=_79d7279178f2b1a21b4c1e64c97a9c50
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=dp264-config
Content-Disposition: attachment;
 filename=dp264-config;
 size=60027

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4L2Fs
cGhhIDYuMTIuMTIgS2VybmVsIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfQ0NfVkVSU0lPTl9URVhU
PSJhbHBoYS1saW51eC1nbnUtZ2NjIChHQ0MpIDE0LjIuMCIKQ09ORklHX0NDX0lTX0dDQz15CkNP
TkZJR19HQ0NfVkVSU0lPTj0xNDAyMDAKQ09ORklHX0NMQU5HX1ZFUlNJT049MApDT05GSUdfQVNf
SVNfR05VPXkKQ09ORklHX0FTX1ZFUlNJT049MjQ0MDAKQ09ORklHX0xEX0lTX0JGRD15CkNPTkZJ
R19MRF9WRVJTSU9OPTI0NDAwCkNPTkZJR19MTERfVkVSU0lPTj0wCkNPTkZJR19SVVNUQ19WRVJT
SU9OPTEwODQwMQpDT05GSUdfUlVTVENfTExWTV9WRVJTSU9OPTE5MDEwNQpDT05GSUdfQ0NfQ0FO
X0xJTks9eQpDT05GSUdfQ0NfQ0FOX0xJTktfU1RBVElDPXkKQ09ORklHX0NDX0hBU19BU01fSU5M
SU5FPXkKQ09ORklHX1BBSE9MRV9WRVJTSU9OPTEyOQpDT05GSUdfSVJRX1dPUks9eQoKIwojIEdl
bmVyYWwgc2V0dXAKIwpDT05GSUdfQlJPS0VOX09OX1NNUD15CkNPTkZJR19JTklUX0VOVl9BUkdf
TElNSVQ9MzIKIyBDT05GSUdfQ09NUElMRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0VSUk9S
IGlzIG5vdCBzZXQKQ09ORklHX0xPQ0FMVkVSU0lPTj0iIgpDT05GSUdfTE9DQUxWRVJTSU9OX0FV
VE89eQpDT05GSUdfQlVJTERfU0FMVD0iIgpDT05GSUdfREVGQVVMVF9JTklUPSIiCkNPTkZJR19E
RUZBVUxUX0hPU1ROQU1FPSIobm9uZSkiCkNPTkZJR19TWVNWSVBDPXkKQ09ORklHX1NZU1ZJUENf
U1lTQ1RMPXkKQ09ORklHX1BPU0lYX01RVUVVRT15CkNPTkZJR19QT1NJWF9NUVVFVUVfU1lTQ1RM
PXkKIyBDT05GSUdfV0FUQ0hfUVVFVUUgaXMgbm90IHNldApDT05GSUdfQ1JPU1NfTUVNT1JZX0FU
VEFDSD15CkNPTkZJR19VU0VMSUI9eQojIENPTkZJR19BVURJVCBpcyBub3Qgc2V0CkNPTkZJR19I
QVZFX0FSQ0hfQVVESVRTWVNDQUxMPXkKCiMKIyBJUlEgc3Vic3lzdGVtCiMKQ09ORklHX0dFTkVS
SUNfSVJRX1BST0JFPXkKQ09ORklHX0dFTkVSSUNfSVJRX1NIT1c9eQojIGVuZCBvZiBJUlEgc3Vi
c3lzdGVtCgpDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5UUz15CgojCiMgVGltZXJzIHN1YnN5c3Rl
bQojCkNPTkZJR19IWl9QRVJJT0RJQz15CiMgQ09ORklHX05PX0haX0lETEUgaXMgbm90IHNldAoj
IENPTkZJR19OT19IWiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJR0hfUkVTX1RJTUVSUyBpcyBub3Qg
c2V0CiMgZW5kIG9mIFRpbWVycyBzdWJzeXN0ZW0KCkNPTkZJR19CUEY9eQoKIwojIEJQRiBzdWJz
eXN0ZW0KIwojIENPTkZJR19CUEZfU1lTQ0FMTCBpcyBub3Qgc2V0CiMgZW5kIG9mIEJQRiBzdWJz
eXN0ZW0KCkNPTkZJR19QUkVFTVBUX05PTkVfQlVJTEQ9eQpDT05GSUdfUFJFRU1QVF9OT05FPXkK
CiMKIyBDUFUvVGFzayB0aW1lIGFuZCBzdGF0cyBhY2NvdW50aW5nCiMKQ09ORklHX1RJQ0tfQ1BV
X0FDQ09VTlRJTkc9eQojIENPTkZJR19CU0RfUFJPQ0VTU19BQ0NUIGlzIG5vdCBzZXQKIyBDT05G
SUdfVEFTS1NUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfUFNJIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
Q1BVL1Rhc2sgdGltZSBhbmQgc3RhdHMgYWNjb3VudGluZwoKIwojIFJDVSBTdWJzeXN0ZW0KIwpD
T05GSUdfVElOWV9SQ1U9eQojIENPTkZJR19SQ1VfRVhQRVJUIGlzIG5vdCBzZXQKQ09ORklHX1RJ
TllfU1JDVT15CiMgZW5kIG9mIFJDVSBTdWJzeXN0ZW0KCkNPTkZJR19JS0NPTkZJRz15CkNPTkZJ
R19JS0NPTkZJR19QUk9DPXkKIyBDT05GSUdfSUtIRUFERVJTIGlzIG5vdCBzZXQKQ09ORklHX0xP
R19CVUZfU0hJRlQ9MTQKCiMKIyBTY2hlZHVsZXIgZmVhdHVyZXMKIwojIGVuZCBvZiBTY2hlZHVs
ZXIgZmVhdHVyZXMKCkNPTkZJR19DQ19IQVNfSU5UMTI4PXkKQ09ORklHX0dDQzEwX05PX0FSUkFZ
X0JPVU5EUz15CkNPTkZJR19DQ19OT19BUlJBWV9CT1VORFM9eQpDT05GSUdfR0NDX05PX1NUUklO
R09QX09WRVJGTE9XPXkKQ09ORklHX0NDX05PX1NUUklOR09QX09WRVJGTE9XPXkKIyBDT05GSUdf
Q0dST1VQUyBpcyBub3Qgc2V0CkNPTkZJR19OQU1FU1BBQ0VTPXkKQ09ORklHX1VUU19OUz15CkNP
TkZJR19JUENfTlM9eQojIENPTkZJR19VU0VSX05TIGlzIG5vdCBzZXQKQ09ORklHX1BJRF9OUz15
CkNPTkZJR19ORVRfTlM9eQojIENPTkZJR19DSEVDS1BPSU5UX1JFU1RPUkUgaXMgbm90IHNldAoj
IENPTkZJR19TQ0hFRF9BVVRPR1JPVVAgaXMgbm90IHNldAojIENPTkZJR19SRUxBWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19ERVZfSU5JVFJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQk9PVF9DT05G
SUcgaXMgbm90IHNldApDT05GSUdfSU5JVFJBTUZTX1BSRVNFUlZFX01USU1FPXkKQ09ORklHX0ND
X09QVElNSVpFX0ZPUl9QRVJGT1JNQU5DRT15CiMgQ09ORklHX0NDX09QVElNSVpFX0ZPUl9TSVpF
IGlzIG5vdCBzZXQKQ09ORklHX1NZU0NUTD15CkNPTkZJR19IQVZFX1BDU1BLUl9QTEFURk9STT15
CiMgQ09ORklHX0VYUEVSVCBpcyBub3Qgc2V0CkNPTkZJR19NVUxUSVVTRVI9eQpDT05GSUdfU1lT
RlNfU1lTQ0FMTD15CkNPTkZJR19GSEFORExFPXkKQ09ORklHX1BPU0lYX1RJTUVSUz15CkNPTkZJ
R19QUklOVEs9eQpDT05GSUdfQlVHPXkKQ09ORklHX0VMRl9DT1JFPXkKQ09ORklHX1BDU1BLUl9Q
TEFURk9STT15CkNPTkZJR19GVVRFWD15CkNPTkZJR19GVVRFWF9QST15CkNPTkZJR19FUE9MTD15
CkNPTkZJR19TSUdOQUxGRD15CkNPTkZJR19USU1FUkZEPXkKQ09ORklHX0VWRU5URkQ9eQpDT05G
SUdfU0hNRU09eQpDT05GSUdfQUlPPXkKQ09ORklHX0lPX1VSSU5HPXkKQ09ORklHX0FEVklTRV9T
WVNDQUxMUz15CkNPTkZJR19NRU1CQVJSSUVSPXkKQ09ORklHX0NBQ0hFU1RBVF9TWVNDQUxMPXkK
Q09ORklHX0tBTExTWU1TPXkKIyBDT05GSUdfS0FMTFNZTVNfU0VMRlRFU1QgaXMgbm90IHNldApD
T05GSUdfS0FMTFNZTVNfQUxMPXkKQ09ORklHX0hBVkVfUEVSRl9FVkVOVFM9eQoKIwojIEtlcm5l
bCBQZXJmb3JtYW5jZSBFdmVudHMgQW5kIENvdW50ZXJzCiMKIyBDT05GSUdfUEVSRl9FVkVOVFMg
aXMgbm90IHNldAojIGVuZCBvZiBLZXJuZWwgUGVyZm9ybWFuY2UgRXZlbnRzIEFuZCBDb3VudGVy
cwoKIyBDT05GSUdfUFJPRklMSU5HIGlzIG5vdCBzZXQKCiMKIyBLZXhlYyBhbmQgY3Jhc2ggZmVh
dHVyZXMKIwpDT05GSUdfVk1DT1JFX0lORk89eQojIGVuZCBvZiBLZXhlYyBhbmQgY3Jhc2ggZmVh
dHVyZXMKIyBlbmQgb2YgR2VuZXJhbCBzZXR1cAoKQ09ORklHX0FMUEhBPXkKQ09ORklHXzY0QklU
PXkKQ09ORklHX01NVT15CkNPTkZJR19HRU5FUklDX0NBTElCUkFURV9ERUxBWT15CkNPTkZJR19H
RU5FUklDX0lTQV9ETUE9eQpDT05GSUdfUEdUQUJMRV9MRVZFTFM9MwpDT05GSUdfQVVESVRfQVJD
SD15CgojCiMgU3lzdGVtIHNldHVwCiMKIyBDT05GSUdfQUxQSEFfR0VORVJJQyBpcyBub3Qgc2V0
CiMgQ09ORklHX0FMUEhBX0FMQ09SIGlzIG5vdCBzZXQKQ09ORklHX0FMUEhBX0RQMjY0PXkKIyBD
T05GSUdfQUxQSEFfRUlHRVIgaXMgbm90IHNldAojIENPTkZJR19BTFBIQV9MWDE2NCBpcyBub3Qg
c2V0CiMgQ09ORklHX0FMUEhBX01BUlZFTCBpcyBub3Qgc2V0CiMgQ09ORklHX0FMUEhBX01JQVRB
IGlzIG5vdCBzZXQKIyBDT05GSUdfQUxQSEFfTUlLQVNBIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxQ
SEFfTkFVVElMVVMgaXMgbm90IHNldAojIENPTkZJR19BTFBIQV9OT1JJVEFLRSBpcyBub3Qgc2V0
CiMgQ09ORklHX0FMUEhBX1BDMTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQUxQSEFfUkFXSElERSBp
cyBub3Qgc2V0CiMgQ09ORklHX0FMUEhBX1JVRkZJQU4gaXMgbm90IHNldAojIENPTkZJR19BTFBI
QV9SWDE2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0FMUEhBX1NYMTY0IGlzIG5vdCBzZXQKIyBDT05G
SUdfQUxQSEFfU0FCTEUgaXMgbm90IHNldAojIENPTkZJR19BTFBIQV9TSEFSSyBpcyBub3Qgc2V0
CiMgQ09ORklHX0FMUEhBX1RBS0FSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0FMUEhBX1RJVEFOIGlz
IG5vdCBzZXQKIyBDT05GSUdfQUxQSEFfV0lMREZJUkUgaXMgbm90IHNldApDT05GSUdfSVNBPXkK
Q09ORklHX0lTQV9ETUFfQVBJPXkKQ09ORklHX0FMUEhBX0VWNj15CkNPTkZJR19BTFBIQV9UU1VO
QU1JPXkKIyBDT05GSUdfQUxQSEFfRVY2NyBpcyBub3Qgc2V0CkNPTkZJR19HRU5FUklDX0hXRUlH
SFQ9eQpDT05GSUdfVkdBX0hPU0U9eQojIENPTkZJR19BTFBIQV9RRU1VIGlzIG5vdCBzZXQKQ09O
RklHX0FMUEhBX1NSTT15CkNPTkZJR19BUkNIX01BWV9IQVZFX1BDX0ZEQz15CiMgQ09ORklHX1NN
UCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfU1BBUlNFTUVNX0VOQUJMRSBpcyBub3Qgc2V0CiMg
Q09ORklHX0FMUEhBX1dUSU5UIGlzIG5vdCBzZXQKQ09ORklHX1ZFUkJPU0VfTUNIRUNLPXkKQ09O
RklHX1ZFUkJPU0VfTUNIRUNLX09OPTEKIyBDT05GSUdfSFpfMzIgaXMgbm90IHNldAojIENPTkZJ
R19IWl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0haXzEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX0ha
XzI1NiBpcyBub3Qgc2V0CkNPTkZJR19IWl8xMDI0PXkKIyBDT05GSUdfSFpfMTIwMCBpcyBub3Qg
c2V0CkNPTkZJR19IWj0xMDI0CkNPTkZJR19TUk1fRU5WPW0KIyBlbmQgb2YgU3lzdGVtIHNldHVw
CgpDT05GSUdfRFVNTVlfQ09OU09MRT15CkNPTkZJR19DUFVfTUlUSUdBVElPTlM9eQpDT05GSUdf
QVJDSF9IQVNfRE1BX09QUz15CgojCiMgR2VuZXJhbCBhcmNoaXRlY3R1cmUtZGVwZW5kZW50IG9w
dGlvbnMKIwpDT05GSUdfSEFWRV82NEJJVF9BTElHTkVEX0FDQ0VTUz15CkNPTkZJR19HRU5FUklD
X1NNUF9JRExFX1RIUkVBRD15CkNPTkZJR19BUkNIXzMyQklUX1VTVEFUX0ZfVElOT0RFPXkKQ09O
RklHX0hBVkVfQVNNX01PRFZFUlNJT05TPXkKQ09ORklHX01NVV9HQVRIRVJfTk9fUkFOR0U9eQpD
T05GSUdfTU1VX0dBVEhFUl9NRVJHRV9WTUFTPXkKQ09ORklHX01NVV9MQVpZX1RMQl9SRUZDT1VO
VD15CkNPTkZJR19BUkNIX0hBVkVfTk1JX1NBRkVfQ01QWENIRz15CkNPTkZJR19BUkNIX1dBTlRf
SVBDX1BBUlNFX1ZFUlNJT049eQpDT05GSUdfTFRPX05PTkU9eQpDT05GSUdfSEFWRV9WSVJUX0NQ
VV9BQ0NPVU5USU5HX0dFTj15CkNPTkZJR19IQVZFX01PRF9BUkNIX1NQRUNJRklDPXkKQ09ORklH
X01PRFVMRVNfVVNFX0VMRl9SRUxBPXkKQ09ORklHX0hBVkVfUEFHRV9TSVpFXzhLQj15CkNPTkZJ
R19QQUdFX1NJWkVfOEtCPXkKQ09ORklHX1BBR0VfU0laRV9MRVNTX1RIQU5fNjRLQj15CkNPTkZJ
R19QQUdFX1NJWkVfTEVTU19USEFOXzI1NktCPXkKQ09ORklHX1BBR0VfU0hJRlQ9MTMKQ09ORklH
X0lTQV9CVVNfQVBJPXkKQ09ORklHX09ERF9SVF9TSUdBQ1RJT049eQpDT05GSUdfT0xEX1NJR1NV
U1BFTkQ9eQojIENPTkZJR19DT01QQVRfMzJCSVRfVElNRSBpcyBub3Qgc2V0CkNPTkZJR19BUkNI
X05PX1BSRUVNUFQ9eQpDT05GSUdfQ1BVX05PX0VGRklDSUVOVF9GRlM9eQoKIwojIEdDT1YtYmFz
ZWQga2VybmVsIHByb2ZpbGluZwojCiMgZW5kIG9mIEdDT1YtYmFzZWQga2VybmVsIHByb2ZpbGlu
ZwoKQ09ORklHX0ZVTkNUSU9OX0FMSUdOTUVOVD0wCiMgZW5kIG9mIEdlbmVyYWwgYXJjaGl0ZWN0
dXJlLWRlcGVuZGVudCBvcHRpb25zCgpDT05GSUdfUlRfTVVURVhFUz15CkNPTkZJR19NT0RVTEVT
PXkKQ09ORklHX01PRFVMRV9GT1JDRV9MT0FEPXkKQ09ORklHX01PRFVMRV9VTkxPQUQ9eQpDT05G
SUdfTU9EVUxFX0ZPUkNFX1VOTE9BRD15CiMgQ09ORklHX01PRFVMRV9VTkxPQURfVEFJTlRfVFJB
Q0tJTkcgaXMgbm90IHNldAojIENPTkZJR19NT0RWRVJTSU9OUyBpcyBub3Qgc2V0CiMgQ09ORklH
X01PRFVMRV9TUkNWRVJTSU9OX0FMTCBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFVMRV9TSUcgaXMg
bm90IHNldAojIENPTkZJR19NT0RVTEVfQ09NUFJFU1MgaXMgbm90IHNldAojIENPTkZJR19NT0RV
TEVfQUxMT1dfTUlTU0lOR19OQU1FU1BBQ0VfSU1QT1JUUyBpcyBub3Qgc2V0CkNPTkZJR19NT0RQ
Uk9CRV9QQVRIPSIvc2Jpbi9tb2Rwcm9iZSIKIyBDT05GSUdfVFJJTV9VTlVTRURfS1NZTVMgaXMg
bm90IHNldApDT05GSUdfQkxPQ0s9eQpDT05GSUdfQkxPQ0tfTEVHQUNZX0FVVE9MT0FEPXkKIyBD
T05GSUdfQkxLX0RFVl9CU0dMSUIgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lOVEVHUklU
WSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1dSSVRFX01PVU5URUQ9eQojIENPTkZJR19CTEtf
REVWX1pPTkVEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX1dCVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19TRURfT1BBTCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19JTkxJTkVfRU5DUllQVElPTiBp
cyBub3Qgc2V0CgojCiMgUGFydGl0aW9uIFR5cGVzCiMKQ09ORklHX1BBUlRJVElPTl9BRFZBTkNF
RD15CiMgQ09ORklHX0FDT1JOX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FJWF9QQVJU
SVRJT04gaXMgbm90IHNldApDT05GSUdfT1NGX1BBUlRJVElPTj15CiMgQ09ORklHX0FNSUdBX1BB
UlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQVJJX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMg
Q09ORklHX01BQ19QQVJUSVRJT04gaXMgbm90IHNldApDT05GSUdfTVNET1NfUEFSVElUSU9OPXkK
Q09ORklHX0JTRF9ESVNLTEFCRUw9eQojIENPTkZJR19NSU5JWF9TVUJQQVJUSVRJT04gaXMgbm90
IHNldAojIENPTkZJR19TT0xBUklTX1g4Nl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19V
TklYV0FSRV9ESVNLTEFCRUwgaXMgbm90IHNldAojIENPTkZJR19MRE1fUEFSVElUSU9OIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0dJX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VMVFJJWF9Q
QVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19TVU5fUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBD
T05GSUdfS0FSTUFfUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX0VGSV9QQVJUSVRJT049eQoj
IENPTkZJR19TWVNWNjhfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQ01ETElORV9QQVJU
SVRJT04gaXMgbm90IHNldAojIGVuZCBvZiBQYXJ0aXRpb24gVHlwZXMKCkNPTkZJR19CTEtfTVFf
UENJPXkKCiMKIyBJTyBTY2hlZHVsZXJzCiMKQ09ORklHX01RX0lPU0NIRURfREVBRExJTkU9eQpD
T05GSUdfTVFfSU9TQ0hFRF9LWUJFUj15CiMgQ09ORklHX0lPU0NIRURfQkZRIGlzIG5vdCBzZXQK
IyBlbmQgb2YgSU8gU2NoZWR1bGVycwoKQ09ORklHX0lOTElORV9TUElOX1VOTE9DS19JUlE9eQpD
T05GSUdfSU5MSU5FX1JFQURfVU5MT0NLPXkKQ09ORklHX0lOTElORV9SRUFEX1VOTE9DS19JUlE9
eQpDT05GSUdfSU5MSU5FX1dSSVRFX1VOTE9DSz15CkNPTkZJR19JTkxJTkVfV1JJVEVfVU5MT0NL
X0lSUT15CgojCiMgRXhlY3V0YWJsZSBmaWxlIGZvcm1hdHMKIwpDT05GSUdfQklORk1UX0VMRj15
CkNPTkZJR19FTEZDT1JFPXkKQ09ORklHX0NPUkVfRFVNUF9ERUZBVUxUX0VMRl9IRUFERVJTPXkK
Q09ORklHX0JJTkZNVF9TQ1JJUFQ9eQojIENPTkZJR19CSU5GTVRfTUlTQyBpcyBub3Qgc2V0CkNP
TkZJR19DT1JFRFVNUD15CiMgZW5kIG9mIEV4ZWN1dGFibGUgZmlsZSBmb3JtYXRzCgojCiMgTWVt
b3J5IE1hbmFnZW1lbnQgb3B0aW9ucwojCkNPTkZJR19TV0FQPXkKIyBDT05GSUdfWlNXQVAgaXMg
bm90IHNldAoKIwojIFNsYWIgYWxsb2NhdG9yIG9wdGlvbnMKIwpDT05GSUdfU0xVQj15CkNPTkZJ
R19TTEFCX01FUkdFX0RFRkFVTFQ9eQojIENPTkZJR19TTEFCX0ZSRUVMSVNUX1JBTkRPTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NMQUJfRlJFRUxJU1RfSEFSREVORUQgaXMgbm90IHNldAojIENPTkZJ
R19TTEFCX0JVQ0tFVFMgaXMgbm90IHNldAojIENPTkZJR19TTFVCX1NUQVRTIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkFORE9NX0tNQUxMT0NfQ0FDSEVTIGlzIG5vdCBzZXQKIyBlbmQgb2YgU2xhYiBh
bGxvY2F0b3Igb3B0aW9ucwoKIyBDT05GSUdfU0hVRkZMRV9QQUdFX0FMTE9DQVRPUiBpcyBub3Qg
c2V0CkNPTkZJR19DT01QQVRfQlJLPXkKQ09ORklHX0ZMQVRNRU09eQpDT05GSUdfQ09NUEFDVElP
Tj15CkNPTkZJR19DT01QQUNUX1VORVZJQ1RBQkxFX0RFRkFVTFQ9MQojIENPTkZJR19QQUdFX1JF
UE9SVElORyBpcyBub3Qgc2V0CkNPTkZJR19NSUdSQVRJT049eQpDT05GSUdfUENQX0JBVENIX1ND
QUxFX01BWD01CkNPTkZJR19QSFlTX0FERFJfVF82NEJJVD15CiMgQ09ORklHX0tTTSBpcyBub3Qg
c2V0CkNPTkZJR19ERUZBVUxUX01NQVBfTUlOX0FERFI9NDA5NgpDT05GSUdfTkVFRF9QRVJfQ1BV
X0tNPXkKIyBDT05GSUdfQ01BIGlzIG5vdCBzZXQKIyBDT05GSUdfSURMRV9QQUdFX1RSQUNLSU5H
IGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFTX0NVUlJFTlRfU1RBQ0tfUE9JTlRFUj15CkNPTkZJ
R19aT05FX0RNQT15CkNPTkZJR19WTV9FVkVOVF9DT1VOVEVSUz15CiMgQ09ORklHX1BFUkNQVV9T
VEFUUyBpcyBub3Qgc2V0CgojCiMgR1VQX1RFU1QgbmVlZHMgdG8gaGF2ZSBERUJVR19GUyBlbmFi
bGVkCiMKIyBDT05GSUdfRE1BUE9PTF9URVNUIGlzIG5vdCBzZXQKQ09ORklHX01FTUZEX0NSRUFU
RT15CiMgQ09ORklHX0FOT05fVk1BX05BTUUgaXMgbm90IHNldAojIENPTkZJR19VU0VSRkFVTFRG
RCBpcyBub3Qgc2V0CiMgQ09ORklHX0xSVV9HRU4gaXMgbm90IHNldApDT05GSUdfTE9DS19NTV9B
TkRfRklORF9WTUE9eQpDT05GSUdfRVhFQ01FTT15CgojCiMgRGF0YSBBY2Nlc3MgTW9uaXRvcmlu
ZwojCiMgQ09ORklHX0RBTU9OIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGF0YSBBY2Nlc3MgTW9uaXRv
cmluZwojIGVuZCBvZiBNZW1vcnkgTWFuYWdlbWVudCBvcHRpb25zCgpDT05GSUdfTkVUPXkKCiMK
IyBOZXR3b3JraW5nIG9wdGlvbnMKIwpDT05GSUdfUEFDS0VUPXkKIyBDT05GSUdfUEFDS0VUX0RJ
QUcgaXMgbm90IHNldApDT05GSUdfVU5JWD15CkNPTkZJR19BRl9VTklYX09PQj15CiMgQ09ORklH
X1VOSVhfRElBRyBpcyBub3Qgc2V0CkNPTkZJR19UTFM9eQojIENPTkZJR19UTFNfREVWSUNFIGlz
IG5vdCBzZXQKIyBDT05GSUdfVExTX1RPRSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGUk1fVVNFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9LRVkgaXMgbm90IHNldApDT05GSUdfTkVUX0hBTkRTSEFL
RT15CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CiMgQ09ORklHX0lQX0FEVkFO
Q0VEX1JPVVRFUiBpcyBub3Qgc2V0CkNPTkZJR19JUF9QTlA9eQpDT05GSUdfSVBfUE5QX0RIQ1A9
eQpDT05GSUdfSVBfUE5QX0JPT1RQPXkKQ09ORklHX0lQX1BOUF9SQVJQPXkKIyBDT05GSUdfTkVU
X0lQSVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVBHUkVfREVNVVggaXMgbm90IHNldAojIENP
TkZJR19JUF9NUk9VVEUgaXMgbm90IHNldAojIENPTkZJR19TWU5fQ09PS0lFUyBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9JUFZUSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GT1UgaXMgbm90IHNl
dAojIENPTkZJR19JTkVUX0FIIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9FU1AgaXMgbm90IHNl
dAojIENPTkZJR19JTkVUX0lQQ09NUCBpcyBub3Qgc2V0CkNPTkZJR19JTkVUX1RBQkxFX1BFUlRV
UkJfT1JERVI9MTYKIyBDT05GSUdfSU5FVF9ESUFHIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NP
TkdfQURWQU5DRUQgaXMgbm90IHNldApDT05GSUdfVENQX0NPTkdfQ1VCSUM9eQpDT05GSUdfREVG
QVVMVF9UQ1BfQ09ORz0iY3ViaWMiCiMgQ09ORklHX1RDUF9BTyBpcyBub3Qgc2V0CiMgQ09ORklH
X1RDUF9NRDVTSUcgaXMgbm90IHNldAojIENPTkZJR19JUFY2IGlzIG5vdCBzZXQKIyBDT05GSUdf
TVBUQ1AgaXMgbm90IHNldAojIENPTkZJR19ORVRXT1JLX1NFQ01BUksgaXMgbm90IHNldApDT05G
SUdfTkVUX1BUUF9DTEFTU0lGWT15CiMgQ09ORklHX05FVFdPUktfUEhZX1RJTUVTVEFNUElORyBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX0RDQ1Ag
aXMgbm90IHNldAojIENPTkZJR19JUF9TQ1RQIGlzIG5vdCBzZXQKIyBDT05GSUdfUkRTIGlzIG5v
dCBzZXQKIyBDT05GSUdfVElQQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0wyVFAgaXMgbm90IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfRFNBIGlzIG5vdCBzZXQKIyBDT05GSUdfVkxBTl84MDIxUSBpcyBub3Qgc2V0CiMgQ09O
RklHX0xMQzIgaXMgbm90IHNldAojIENPTkZJR19BVEFMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1gy
NSBpcyBub3Qgc2V0CiMgQ09ORklHX0xBUEIgaXMgbm90IHNldAojIENPTkZJR19QSE9ORVQgaXMg
bm90IHNldAojIENPTkZJR19JRUVFODAyMTU0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSEVE
IGlzIG5vdCBzZXQKIyBDT05GSUdfRENCIGlzIG5vdCBzZXQKQ09ORklHX0ROU19SRVNPTFZFUj15
CiMgQ09ORklHX0JBVE1BTl9BRFYgaXMgbm90IHNldAojIENPTkZJR19PUEVOVlNXSVRDSCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZTT0NLRVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUTElOS19ESUFH
IGlzIG5vdCBzZXQKIyBDT05GSUdfTVBMUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9OU0ggaXMg
bm90IHNldAojIENPTkZJR19IU1IgaXMgbm90IHNldAojIENPTkZJR19ORVRfU1dJVENIREVWIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX0wzX01BU1RFUl9ERVYgaXMgbm90IHNldAojIENPTkZJR19R
UlRSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX05DU0kgaXMgbm90IHNldApDT05GSUdfTUFYX1NL
Ql9GUkFHUz0xNwpDT05GSUdfTkVUX1JYX0JVU1lfUE9MTD15CkNPTkZJR19CUUw9eQoKIwojIE5l
dHdvcmsgdGVzdGluZwojCiMgQ09ORklHX05FVF9QS1RHRU4gaXMgbm90IHNldAojIGVuZCBvZiBO
ZXR3b3JrIHRlc3RpbmcKIyBlbmQgb2YgTmV0d29ya2luZyBvcHRpb25zCgojIENPTkZJR19IQU1S
QURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0NBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0JUIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUZfUlhSUEMgaXMgbm90IHNldAojIENPTkZJR19BRl9LQ00gaXMgbm90
IHNldApDT05GSUdfU1RSRUFNX1BBUlNFUj15CiMgQ09ORklHX01DVFAgaXMgbm90IHNldAojIENP
TkZJR19XSVJFTEVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JGS0lMTCBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF85UCBpcyBub3Qgc2V0CiMgQ09ORklHX0NBSUYgaXMgbm90IHNldAojIENPTkZJR19D
RVBIX0xJQiBpcyBub3Qgc2V0CiMgQ09ORklHX05GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BTQU1Q
TEUgaXMgbm90IHNldAojIENPTkZJR19ORVRfSUZFIGlzIG5vdCBzZXQKIyBDT05GSUdfTFdUVU5O
RUwgaXMgbm90IHNldApDT05GSUdfTkVUX1NFTEZURVNUUz15CkNPTkZJR19ORVRfU09DS19NU0c9
eQojIENPTkZJR19GQUlMT1ZFUiBpcyBub3Qgc2V0CkNPTkZJR19FVEhUT09MX05FVExJTks9eQoK
IwojIERldmljZSBEcml2ZXJzCiMKQ09ORklHX0hBVkVfUENJPXkKQ09ORklHX0ZPUkNFX1BDST15
CkNPTkZJR19HRU5FUklDX1BDSV9JT01BUD15CkNPTkZJR19QQ0k9eQpDT05GSUdfUENJX0RPTUFJ
TlM9eQpDT05GSUdfUENJX1NZU0NBTEw9eQojIENPTkZJR19QQ0lFUE9SVEJVUyBpcyBub3Qgc2V0
CkNPTkZJR19QQ0lFQVNQTT15CkNPTkZJR19QQ0lFQVNQTV9ERUZBVUxUPXkKIyBDT05GSUdfUENJ
RUFTUE1fUE9XRVJTQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRUFTUE1fUE9XRVJfU1VQRVJT
QVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRUFTUE1fUEVSRk9STUFOQ0UgaXMgbm90IHNldAoj
IENPTkZJR19QQ0lFX1BUTSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9NU0kgaXMgbm90IHNldApD
T05GSUdfUENJX1FVSVJLUz15CiMgQ09ORklHX1BDSV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklH
X1BDSV9TVFVCIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX0lPViBpcyBub3Qgc2V0CiMgQ09ORklH
X1BDSV9QUkkgaXMgbm90IHNldAojIENPTkZJR19QQ0lfUEFTSUQgaXMgbm90IHNldApDT05GSUdf
VkdBX0FSQj15CkNPTkZJR19WR0FfQVJCX01BWF9HUFVTPTE2CiMgQ09ORklHX0hPVFBMVUdfUENJ
IGlzIG5vdCBzZXQKCiMKIyBQQ0kgY29udHJvbGxlciBkcml2ZXJzCiMKCiMKIyBDYWRlbmNlLWJh
c2VkIFBDSWUgY29udHJvbGxlcnMKIwojIGVuZCBvZiBDYWRlbmNlLWJhc2VkIFBDSWUgY29udHJv
bGxlcnMKCiMKIyBEZXNpZ25XYXJlLWJhc2VkIFBDSWUgY29udHJvbGxlcnMKIwojIGVuZCBvZiBE
ZXNpZ25XYXJlLWJhc2VkIFBDSWUgY29udHJvbGxlcnMKCiMKIyBNb2JpdmVpbC1iYXNlZCBQQ0ll
IGNvbnRyb2xsZXJzCiMKIyBlbmQgb2YgTW9iaXZlaWwtYmFzZWQgUENJZSBjb250cm9sbGVycwoK
IwojIFBMREEtYmFzZWQgUENJZSBjb250cm9sbGVycwojCiMgZW5kIG9mIFBMREEtYmFzZWQgUENJ
ZSBjb250cm9sbGVycwojIGVuZCBvZiBQQ0kgY29udHJvbGxlciBkcml2ZXJzCgojCiMgUENJIEVu
ZHBvaW50CiMKIyBDT05GSUdfUENJX0VORFBPSU5UIGlzIG5vdCBzZXQKIyBlbmQgb2YgUENJIEVu
ZHBvaW50CgojCiMgUENJIHN3aXRjaCBjb250cm9sbGVyIGRyaXZlcnMKIwojIENPTkZJR19QQ0lf
U1dfU1dJVENIVEVDIGlzIG5vdCBzZXQKIyBlbmQgb2YgUENJIHN3aXRjaCBjb250cm9sbGVyIGRy
aXZlcnMKCiMgQ09ORklHX0NYTF9CVVMgaXMgbm90IHNldAojIENPTkZJR19QQ0NBUkQgaXMgbm90
IHNldAojIENPTkZJR19SQVBJRElPIGlzIG5vdCBzZXQKCiMKIyBHZW5lcmljIERyaXZlciBPcHRp
b25zCiMKIyBDT05GSUdfVUVWRU5UX0hFTFBFUiBpcyBub3Qgc2V0CkNPTkZJR19ERVZUTVBGUz15
CiMgQ09ORklHX0RFVlRNUEZTX01PVU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfREVWVE1QRlNfU0FG
RSBpcyBub3Qgc2V0CkNPTkZJR19TVEFOREFMT05FPXkKQ09ORklHX1BSRVZFTlRfRklSTVdBUkVf
QlVJTEQ9eQoKIwojIEZpcm13YXJlIGxvYWRlcgojCkNPTkZJR19GV19MT0FERVI9eQpDT05GSUdf
RVhUUkFfRklSTVdBUkU9IiIKIyBDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRldfTE9BREVSX0NPTVBSRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfRldfVVBM
T0FEIGlzIG5vdCBzZXQKIyBlbmQgb2YgRmlybXdhcmUgbG9hZGVyCgpDT05GSUdfQUxMT1dfREVW
X0NPUkVEVU1QPXkKIyBDT05GSUdfREVCVUdfRFJJVkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfREVC
VUdfREVWUkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfVEVTVF9EUklWRVJfUkVNT1ZFIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEVTVF9BU1lOQ19EUklWRVJfUFJPQkUgaXMgbm90IHNldApDT05G
SUdfR0VORVJJQ19DUFVfVlVMTkVSQUJJTElUSUVTPXkKIyBDT05GSUdfRldfREVWTElOS19TWU5D
X1NUQVRFX1RJTUVPVVQgaXMgbm90IHNldAojIGVuZCBvZiBHZW5lcmljIERyaXZlciBPcHRpb25z
CgojCiMgQnVzIGRldmljZXMKIwojIENPTkZJR19NSElfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUhJX0JVU19FUCBpcyBub3Qgc2V0CiMgZW5kIG9mIEJ1cyBkZXZpY2VzCgojCiMgQ2FjaGUgRHJp
dmVycwojCiMgZW5kIG9mIENhY2hlIERyaXZlcnMKCiMgQ09ORklHX0NPTk5FQ1RPUiBpcyBub3Qg
c2V0CgojCiMgRmlybXdhcmUgRHJpdmVycwojCgojCiMgQVJNIFN5c3RlbSBDb250cm9sIGFuZCBN
YW5hZ2VtZW50IEludGVyZmFjZSBQcm90b2NvbAojCiMgZW5kIG9mIEFSTSBTeXN0ZW0gQ29udHJv
bCBhbmQgTWFuYWdlbWVudCBJbnRlcmZhY2UgUHJvdG9jb2wKCiMgQ09ORklHX0dPT0dMRV9GSVJN
V0FSRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lNWF9TQ01JX01JU0NfRFJWIGlzIG5vdCBzZXQKCiMK
IyBRdWFsY29tbSBmaXJtd2FyZSBkcml2ZXJzCiMKIyBlbmQgb2YgUXVhbGNvbW0gZmlybXdhcmUg
ZHJpdmVycwoKIwojIFRlZ3JhIGZpcm13YXJlIGRyaXZlcgojCiMgZW5kIG9mIFRlZ3JhIGZpcm13
YXJlIGRyaXZlcgojIGVuZCBvZiBGaXJtd2FyZSBEcml2ZXJzCgojIENPTkZJR19HTlNTIGlzIG5v
dCBzZXQKIyBDT05GSUdfTVREIGlzIG5vdCBzZXQKIyBDT05GSUdfT0YgaXMgbm90IHNldApDT05G
SUdfQVJDSF9NSUdIVF9IQVZFX1BDX1BBUlBPUlQ9eQojIENPTkZJR19QQVJQT1JUIGlzIG5vdCBz
ZXQKQ09ORklHX1BOUD15CkNPTkZJR19QTlBfREVCVUdfTUVTU0FHRVM9eQoKIwojIFByb3RvY29s
cwojCkNPTkZJR19JU0FQTlA9eQpDT05GSUdfQkxLX0RFVj15CiMgQ09ORklHX0JMS19ERVZfTlVM
TF9CTEsgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9GRD15CiMgQ09ORklHX0JMS19ERVZfRkRf
UkFXQ01EIGlzIG5vdCBzZXQKQ09ORklHX0NEUk9NPXkKIyBDT05GSUdfQkxLX0RFVl9QQ0lFU1NE
X01USVAzMlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfWlJBTSBpcyBub3Qgc2V0CkNPTkZJR19CTEtf
REVWX0xPT1A9bQpDT05GSUdfQkxLX0RFVl9MT09QX01JTl9DT1VOVD04CiMgQ09ORklHX0JMS19E
RVZfRFJCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTkJEIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9SQU0gaXMgbm90IHNldAojIENPTkZJR19DRFJPTV9QS1RDRFZEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQVRBX09WRVJfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SQkQg
aXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1VCTEsgaXMgbm90IHNldAoKIwojIE5WTUUgU3Vw
cG9ydAojCiMgQ09ORklHX0JMS19ERVZfTlZNRSBpcyBub3Qgc2V0CiMgQ09ORklHX05WTUVfRkMg
aXMgbm90IHNldAojIENPTkZJR19OVk1FX1RDUCBpcyBub3Qgc2V0CiMgZW5kIG9mIE5WTUUgU3Vw
cG9ydAoKIwojIE1pc2MgZGV2aWNlcwojCiMgQ09ORklHX0RVTU1ZX0lSUSBpcyBub3Qgc2V0CiMg
Q09ORklHX1BIQU5UT00gaXMgbm90IHNldAojIENPTkZJR19USUZNX0NPUkUgaXMgbm90IHNldAoj
IENPTkZJR19FTkNMT1NVUkVfU0VSVklDRVMgaXMgbm90IHNldAojIENPTkZJR19IUF9JTE8gaXMg
bm90IHNldAojIENPTkZJR19TUkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfRFdfWERBVEFfUENJRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1BDSV9FTkRQT0lOVF9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
WElMSU5YX1NERkVDIGlzIG5vdCBzZXQKIyBDT05GSUdfQzJQT1JUIGlzIG5vdCBzZXQKCiMKIyBF
RVBST00gc3VwcG9ydAojCiMgQ09ORklHX0VFUFJPTV85M0NYNiBpcyBub3Qgc2V0CiMgZW5kIG9m
IEVFUFJPTSBzdXBwb3J0CgojIENPTkZJR19DQjcxMF9DT1JFIGlzIG5vdCBzZXQKCiMKIyBUZXhh
cyBJbnN0cnVtZW50cyBzaGFyZWQgdHJhbnNwb3J0IGxpbmUgZGlzY2lwbGluZQojCiMgZW5kIG9m
IFRleGFzIEluc3RydW1lbnRzIHNoYXJlZCB0cmFuc3BvcnQgbGluZSBkaXNjaXBsaW5lCgojCiMg
QWx0ZXJhIEZQR0EgZmlybXdhcmUgZG93bmxvYWQgbW9kdWxlIChyZXF1aXJlcyBJMkMpCiMKIyBD
T05GSUdfR0VOV1FFIGlzIG5vdCBzZXQKIyBDT05GSUdfRUNITyBpcyBub3Qgc2V0CiMgQ09ORklH
X01JU0NfQUxDT1JfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19SVFNYX1BDSSBpcyBub3Qg
c2V0CiMgQ09ORklHX01JU0NfUlRTWF9VU0IgaXMgbm90IHNldAojIENPTkZJR19QVlBBTklDIGlz
IG5vdCBzZXQKIyBDT05GSUdfS0VCQV9DUDUwMCBpcyBub3Qgc2V0CiMgZW5kIG9mIE1pc2MgZGV2
aWNlcwoKIwojIFNDU0kgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfU0NTSV9NT0Q9eQojIENPTkZJ
R19SQUlEX0FUVFJTIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfQ09NTU9OPXkKQ09ORklHX1NDU0k9
eQpDT05GSUdfU0NTSV9ETUE9eQpDT05GSUdfU0NTSV9QUk9DX0ZTPXkKCiMKIyBTQ1NJIHN1cHBv
cnQgdHlwZSAoZGlzaywgdGFwZSwgQ0QtUk9NKQojCkNPTkZJR19CTEtfREVWX1NEPXkKIyBDT05G
SUdfQ0hSX0RFVl9TVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1NSPXkKIyBDT05GSUdfQ0hS
X0RFVl9TRyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQlNHIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ0hSX0RFVl9TQ0ggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0NPTlNUQU5UUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfTE9HR0lORyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0NBTl9B
U1lOQyBpcyBub3Qgc2V0CgojCiMgU0NTSSBUcmFuc3BvcnRzCiMKQ09ORklHX1NDU0lfU1BJX0FU
VFJTPW0KIyBDT05GSUdfU0NTSV9GQ19BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVND
U0lfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBU19BVFRSUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfU0FTX0xJQlNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1JQX0FUVFJT
IGlzIG5vdCBzZXQKIyBlbmQgb2YgU0NTSSBUcmFuc3BvcnRzCgojIENPTkZJR19TQ1NJX0xPV0xF
VkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ESCBpcyBub3Qgc2V0CiMgZW5kIG9mIFNDU0kg
ZGV2aWNlIHN1cHBvcnQKCkNPTkZJR19BVEE9eQpDT05GSUdfU0FUQV9IT1NUPXkKQ09ORklHX1BB
VEFfVElNSU5HUz15CkNPTkZJR19BVEFfVkVSQk9TRV9FUlJPUj15CkNPTkZJR19BVEFfRk9SQ0U9
eQojIENPTkZJR19TQVRBX1BNUCBpcyBub3Qgc2V0CgojCiMgQ29udHJvbGxlcnMgd2l0aCBub24t
U0ZGIG5hdGl2ZSBpbnRlcmZhY2UKIwojIENPTkZJR19TQVRBX0FIQ0kgaXMgbm90IHNldAojIENP
TkZJR19TQVRBX0FIQ0lfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19BSENJX0RXQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NBVEFfSU5JQzE2MlggaXMgbm90IHNldAojIENPTkZJR19TQVRBX0FD
QVJEX0FIQ0kgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NJTDI0IGlzIG5vdCBzZXQKQ09ORklH
X0FUQV9TRkY9eQoKIwojIFNGRiBjb250cm9sbGVycyB3aXRoIGN1c3RvbSBETUEgaW50ZXJmYWNl
CiMKIyBDT05GSUdfUERDX0FETUEgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1FTVE9SIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0FUQV9TWDQgaXMgbm90IHNldApDT05GSUdfQVRBX0JNRE1BPXkKCiMK
IyBTQVRBIFNGRiBjb250cm9sbGVycyB3aXRoIEJNRE1BCiMKIyBDT05GSUdfQVRBX1BJSVggaXMg
bm90IHNldAojIENPTkZJR19TQVRBX01WIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9OViBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NBVEFfUFJPTUlTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU0lM
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSVMgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NW
VyBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfVUxJIGlzIG5vdCBzZXQKQ09ORklHX1NBVEFfVklB
PXkKIyBDT05GSUdfU0FUQV9WSVRFU1NFIGlzIG5vdCBzZXQKCiMKIyBQQVRBIFNGRiBjb250cm9s
bGVycyB3aXRoIEJNRE1BCiMKQ09ORklHX1BBVEFfQUxJPXkKIyBDT05GSUdfUEFUQV9BTUQgaXMg
bm90IHNldAojIENPTkZJR19QQVRBX0FSVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9BVElJ
WFAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0FUUDg2N1ggaXMgbm90IHNldAojIENPTkZJR19Q
QVRBX0NNRDY0WCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQ1lQUkVTUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1BBVEFfRUZBUiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSFBUMzY2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9IUFQzN1ggaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDNYMk4g
aXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDNYMyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFf
SVQ4MjEzIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9JVDgyMVggaXMgbm90IHNldAojIENPTkZJ
R19QQVRBX0pNSUNST04gaXMgbm90IHNldAojIENPTkZJR19QQVRBX01BUlZFTEwgaXMgbm90IHNl
dAojIENPTkZJR19QQVRBX05FVENFTEwgaXMgbm90IHNldAojIENPTkZJR19QQVRBX05JTkpBMzIg
aXMgbm90IHNldAojIENPTkZJR19QQVRBX05TODc0MTUgaXMgbm90IHNldAojIENPTkZJR19QQVRB
X09MRFBJSVggaXMgbm90IHNldAojIENPTkZJR19QQVRBX09QVElETUEgaXMgbm90IHNldAojIENP
TkZJR19QQVRBX1BEQzIwMjdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QRENfT0xEIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFUQV9SQURJU1lTIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9SREMg
aXMgbm90IHNldAojIENPTkZJR19QQVRBX1NDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfU0VS
VkVSV09SS1MgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NJTDY4MCBpcyBub3Qgc2V0CiMgQ09O
RklHX1BBVEFfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9UT1NISUJBIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9UUklGTEVYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9WSUEgaXMgbm90
IHNldAojIENPTkZJR19QQVRBX1dJTkJPTkQgaXMgbm90IHNldAoKIwojIFBJTy1vbmx5IFNGRiBj
b250cm9sbGVycwojCiMgQ09ORklHX1BBVEFfQ01ENjQwX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfSVNBUE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9NUElJWCBpcyBub3Qgc2V0CiMg
Q09ORklHX1BBVEFfTlM4NzQxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfT1BUSSBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfUURJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9SWjEwMDAgaXMg
bm90IHNldAojIENPTkZJR19QQVRBX1dJTkJPTkRfVkxCIGlzIG5vdCBzZXQKCiMKIyBHZW5lcmlj
IGZhbGxiYWNrIC8gbGVnYWN5IGRyaXZlcnMKIwojIENPTkZJR19BVEFfR0VORVJJQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfTEVHQUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUQgaXMgbm90IHNl
dAojIENPTkZJR19UQVJHRVRfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0lPTiBpcyBub3Qg
c2V0CgojCiMgSUVFRSAxMzk0IChGaXJlV2lyZSkgc3VwcG9ydAojCiMgQ09ORklHX0ZJUkVXSVJF
IGlzIG5vdCBzZXQKIyBDT05GSUdfRklSRVdJUkVfTk9TWSBpcyBub3Qgc2V0CiMgZW5kIG9mIElF
RUUgMTM5NCAoRmlyZVdpcmUpIHN1cHBvcnQKCkNPTkZJR19ORVRERVZJQ0VTPXkKQ09ORklHX01J
ST15CkNPTkZJR19ORVRfQ09SRT15CiMgQ09ORklHX0JPTkRJTkcgaXMgbm90IHNldAojIENPTkZJ
R19EVU1NWSBpcyBub3Qgc2V0CiMgQ09ORklHX1dJUkVHVUFSRCBpcyBub3Qgc2V0CiMgQ09ORklH
X0VRVUFMSVpFUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GQyBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9URUFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDVkxBTiBpcyBub3Qgc2V0CiMgQ09ORklH
X0lQVkxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZYTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VO
RVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFSRVVEUCBpcyBub3Qgc2V0CiMgQ09ORklHX0dUUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1BGQ1AgaXMgbm90IHNldAojIENPTkZJR19BTVQgaXMgbm90IHNl
dAojIENPTkZJR19NQUNTRUMgaXMgbm90IHNldAojIENPTkZJR19ORVRDT05TT0xFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVFVOIGlzIG5vdCBzZXQKIyBDT05GSUdfVFVOX1ZORVRfQ1JPU1NfTEUgaXMg
bm90IHNldAojIENPTkZJR19WRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxNT04gaXMgbm90IHNl
dAojIENPTkZJR19BUkNORVQgaXMgbm90IHNldApDT05GSUdfRVRIRVJORVQ9eQojIENPTkZJR19O
RVRfVkVORE9SXzNDT00gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FEQVBURUMgaXMg
bm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FHRVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1ZFTkRPUl9BTEFDUklURUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BTFRFT04g
aXMgbm90IHNldAojIENPTkZJR19BTFRFUkFfVFNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9BTUFaT04gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FNRCBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9WRU5ET1JfQVFVQU5USUEgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVO
RE9SX0FSQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQVNJWCBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9WRU5ET1JfQVRIRVJPUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1Jf
QlJPQURDT00gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0NBREVOQ0UgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfVkVORE9SX0NBVklVTSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5E
T1JfQ0hFTFNJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQ0lSUlVTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9DSVNDTyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5E
T1JfQ09SVElOQSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfREFWSUNPTSBpcyBub3Qg
c2V0CiMgQ09ORklHX0RORVQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9ERUM9eQpDT05G
SUdfTkVUX1RVTElQPXkKIyBDT05GSUdfREUyMTA0WCBpcyBub3Qgc2V0CkNPTkZJR19UVUxJUD15
CkNPTkZJR19UVUxJUF9NV0k9eQpDT05GSUdfVFVMSVBfTU1JTz15CkNPTkZJR19UVUxJUF9OQVBJ
PXkKQ09ORklHX1RVTElQX05BUElfSFdfTUlUSUdBVElPTj15CiMgQ09ORklHX1dJTkJPTkRfODQw
IGlzIG5vdCBzZXQKIyBDT05GSUdfRE05MTAyIGlzIG5vdCBzZXQKIyBDT05GSUdfVUxJNTI2WCBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfRExJTksgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX0VNVUxFWCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfRU5HTEVERVIg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0VaQ0hJUCBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfRlVOR0lCTEUgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0dPT0dM
RSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfSFVBV0VJIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9JODI1WFggaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9JTlRFTD15
CkNPTkZJR19FMTAwPXkKQ09ORklHX0UxMDAwPXkKIyBDT05GSUdfRTEwMDBFIGlzIG5vdCBzZXQK
IyBDT05GSUdfSUdCIGlzIG5vdCBzZXQKIyBDT05GSUdfSUdCVkYgaXMgbm90IHNldAojIENPTkZJ
R19JWEdCRSBpcyBub3Qgc2V0CiMgQ09ORklHX0k0MEUgaXMgbm90IHNldAojIENPTkZJR19JR0Mg
aXMgbm90IHNldAojIENPTkZJR19KTUUgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0xJ
VEVYIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NQVJWRUxMIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1ZFTkRPUl9NRUxMQU5PWCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1Jf
TUVUQSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTUlDUkVMIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1ZFTkRPUl9NSUNST0NISVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9S
X01JQ1JPU0VNSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTUlDUk9TT0ZUIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NWVJJIGlzIG5vdCBzZXQKIyBDT05GSUdfRkVBTE5Y
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9OSSBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9WRU5ET1JfTkFUU0VNSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTkVURVJJT04g
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX05FVFJPTk9NRSBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9WRU5ET1JfTlZJRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9PS0kg
aXMgbm90IHNldAojIENPTkZJR19FVEhPQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1Jf
UEFDS0VUX0VOR0lORVMgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1BFTlNBTkRPIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9RTE9HSUMgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX0JST0NBREUgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1FVQUxDT01N
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9SREMgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX1JFQUxURUsgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1JFTkVTQVMg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1JPQ0tFUiBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfU0FNU1VORyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU0VFUSBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU0lMQU4gaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU09MQVJGTEFSRSBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU01TQyBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9WRU5ET1JfU09DSU9ORVhUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TVE1JQ1JP
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TVU4gaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX1NZTk9QU1lTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9URUhVVEkg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1RJIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1ZFTkRPUl9WRVJURVhDT00gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1ZJQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfV0FOR1hVTiBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9WRU5ET1JfV0laTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9YSUxJTlggaXMg
bm90IHNldAojIENPTkZJR19GRERJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElQUEkgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfU0IxMDAwIGlzIG5vdCBzZXQKQ09ORklHX1BIWUxJQj15CiMgQ09ORklH
X0ZJWEVEX1BIWSBpcyBub3Qgc2V0CgojCiMgTUlJIFBIWSBkZXZpY2UgZHJpdmVycwojCiMgQ09O
RklHX0FJUl9FTjg4MTFIX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FNRF9QSFkgaXMgbm90IHNl
dAojIENPTkZJR19BRElOX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FESU4xMTAwX1BIWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FRVUFOVElBX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FYODg3OTZC
X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JST0FEQ09NX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0JDTTU0MTQwX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JDTTdYWFhfUEhZIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkNNODQ4ODFfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNNODdYWF9QSFkgaXMg
bm90IHNldAojIENPTkZJR19DSUNBREFfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09SVElOQV9Q
SFkgaXMgbm90IHNldAojIENPTkZJR19EQVZJQ09NX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lD
UExVU19QSFkgaXMgbm90IHNldAojIENPTkZJR19MWFRfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5URUxfWFdBWV9QSFkgaXMgbm90IHNldAojIENPTkZJR19MU0lfRVQxMDExQ19QSFkgaXMgbm90
IHNldAojIENPTkZJR19NQVJWRUxMX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01BUlZFTExfMTBH
X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01BUlZFTExfODhRMlhYWF9QSFkgaXMgbm90IHNldAoj
IENPTkZJR19NQVJWRUxMXzg4WDIyMjJfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFYTElORUFS
X0dQSFkgaXMgbm90IHNldAojIENPTkZJR19NRURJQVRFS19HRV9QSFkgaXMgbm90IHNldAojIENP
TkZJR19NSUNSRUxfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUk9DSElQX1QxU19QSFkgaXMg
bm90IHNldAojIENPTkZJR19NSUNST0NISVBfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUk9D
SElQX1QxX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01JQ1JPU0VNSV9QSFkgaXMgbm90IHNldAoj
IENPTkZJR19NT1RPUkNPTU1fUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTkFUSU9OQUxfUEhZIGlz
IG5vdCBzZXQKIyBDT05GSUdfTlhQX0NCVFhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTlhQX0M0
NV9USkExMVhYX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX05DTjI2MDAwX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX1FDQTgzWFhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfUUNBODA4WF9QSFkgaXMg
bm90IHNldAojIENPTkZJR19RU0VNSV9QSFkgaXMgbm90IHNldAojIENPTkZJR19SRUFMVEVLX1BI
WSBpcyBub3Qgc2V0CiMgQ09ORklHX1JFTkVTQVNfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfUk9D
S0NISVBfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfU01TQ19QSFkgaXMgbm90IHNldAojIENPTkZJ
R19TVEUxMFhQIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVSQU5FVElDU19QSFkgaXMgbm90IHNldAoj
IENPTkZJR19EUDgzODIyX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODNUQzgxMV9QSFkgaXMg
bm90IHNldAojIENPTkZJR19EUDgzODQ4X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODM4Njdf
UEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfRFA4Mzg2OV9QSFkgaXMgbm90IHNldAojIENPTkZJR19E
UDgzVEQ1MTBfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfRFA4M1RHNzIwX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX1ZJVEVTU0VfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMSU5YX0dNSUkyUkdN
SUkgaXMgbm90IHNldApDT05GSUdfTURJT19ERVZJQ0U9eQpDT05GSUdfTURJT19CVVM9eQpDT05G
SUdfTURJT19ERVZSRVM9eQojIENPTkZJR19NRElPX0JJVEJBTkcgaXMgbm90IHNldAojIENPTkZJ
R19NRElPX0JDTV9VTklNQUMgaXMgbm90IHNldAojIENPTkZJR19NRElPX01WVVNCIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTURJT19USFVOREVSIGlzIG5vdCBzZXQKCiMKIyBNRElPIE11bHRpcGxleGVy
cwojCgojCiMgUENTIGRldmljZSBkcml2ZXJzCiMKIyBDT05GSUdfUENTX1hQQ1MgaXMgbm90IHNl
dAojIGVuZCBvZiBQQ1MgZGV2aWNlIGRyaXZlcnMKCiMgQ09ORklHX1BQUCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NMSVAgaXMgbm90IHNldApDT05GSUdfVVNCX05FVF9EUklWRVJTPXkKIyBDT05GSUdf
VVNCX0NBVEMgaXMgbm90IHNldApDT05GSUdfVVNCX0tBV0VUSD15CkNPTkZJR19VU0JfUEVHQVNV
Uz15CkNPTkZJR19VU0JfUlRMODE1MD15CkNPTkZJR19VU0JfUlRMODE1Mj15CiMgQ09ORklHX1VT
Ql9MQU43OFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1VTQk5FVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9JUEhFVEggaXMgbm90IHNldAojIENPTkZJR19XTEFOIGlzIG5vdCBzZXQKIyBDT05G
SUdfV0FOIGlzIG5vdCBzZXQKCiMKIyBXaXJlbGVzcyBXQU4KIwojIENPTkZJR19XV0FOIGlzIG5v
dCBzZXQKIyBlbmQgb2YgV2lyZWxlc3MgV0FOCgojIENPTkZJR19WTVhORVQzIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX0ZBSUxPVkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNETiBpcyBub3Qgc2V0
CgojCiMgSW5wdXQgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfSU5QVVQ9eQojIENPTkZJR19JTlBV
VF9GRl9NRU1MRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfU1BBUlNFS01BUCBpcyBub3Qg
c2V0CiMgQ09ORklHX0lOUFVUX01BVFJJWEtNQVAgaXMgbm90IHNldApDT05GSUdfSU5QVVRfVklW
QUxESUZNQVA9eQoKIwojIFVzZXJsYW5kIGludGVyZmFjZXMKIwpDT05GSUdfSU5QVVRfTU9VU0VE
RVY9eQpDT05GSUdfSU5QVVRfTU9VU0VERVZfUFNBVVg9eQpDT05GSUdfSU5QVVRfTU9VU0VERVZf
U0NSRUVOX1g9MTAyNApDT05GSUdfSU5QVVRfTU9VU0VERVZfU0NSRUVOX1k9NzY4CiMgQ09ORklH
X0lOUFVUX0pPWURFViBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0VWREVWIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5QVVRfRVZCVUcgaXMgbm90IHNldAoKIwojIElucHV0IERldmljZSBEcml2ZXJz
CiMKQ09ORklHX0lOUFVUX0tFWUJPQVJEPXkKQ09ORklHX0tFWUJPQVJEX0FUS0JEPXkKIyBDT05G
SUdfS0VZQk9BUkRfTEtLQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9ORVdUT04gaXMg
bm90IHNldAojIENPTkZJR19LRVlCT0FSRF9PUEVOQ09SRVMgaXMgbm90IHNldAojIENPTkZJR19L
RVlCT0FSRF9TVE9XQVdBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1hUS0JEIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX01P
VVNFPXkKQ09ORklHX01PVVNFX1BTMj15CkNPTkZJR19NT1VTRV9QUzJfQUxQUz15CkNPTkZJR19N
T1VTRV9QUzJfQllEPXkKQ09ORklHX01PVVNFX1BTMl9MT0dJUFMyUFA9eQpDT05GSUdfTU9VU0Vf
UFMyX1NZTkFQVElDUz15CkNPTkZJR19NT1VTRV9QUzJfQ1lQUkVTUz15CkNPTkZJR19NT1VTRV9Q
UzJfVFJBQ0tQT0lOVD15CiMgQ09ORklHX01PVVNFX1BTMl9FTEFOVEVDSCBpcyBub3Qgc2V0CiMg
Q09ORklHX01PVVNFX1BTMl9TRU5URUxJQyBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1BTMl9U
T1VDSEtJVCBpcyBub3Qgc2V0CkNPTkZJR19NT1VTRV9QUzJfRk9DQUxURUNIPXkKIyBDT05GSUdf
TU9VU0VfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfQVBQTEVUT1VDSCBpcyBub3Qg
c2V0CiMgQ09ORklHX01PVVNFX0JDTTU5NzQgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9JTlBP
UlQgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9MT0dJQk0gaXMgbm90IHNldAojIENPTkZJR19N
T1VTRV9QQzExMFBBRCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1ZTWFhYQUEgaXMgbm90IHNl
dAojIENPTkZJR19NT1VTRV9TWU5BUFRJQ1NfVVNCIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRf
Sk9ZU1RJQ0sgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9UQUJMRVQgaXMgbm90IHNldAojIENP
TkZJR19JTlBVVF9UT1VDSFNDUkVFTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX01JU0MgaXMg
bm90IHNldAojIENPTkZJR19STUk0X0NPUkUgaXMgbm90IHNldAoKIwojIEhhcmR3YXJlIEkvTyBw
b3J0cwojCkNPTkZJR19TRVJJTz15CkNPTkZJR19BUkNIX01JR0hUX0hBVkVfUENfU0VSSU89eQpD
T05GSUdfU0VSSU9fSTgwNDI9eQpDT05GSUdfU0VSSU9fU0VSUE9SVD15CiMgQ09ORklHX1NFUklP
X1BDSVBTMiBpcyBub3Qgc2V0CkNPTkZJR19TRVJJT19MSUJQUzI9eQojIENPTkZJR19TRVJJT19S
QVcgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19BTFRFUkFfUFMyIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VSSU9fUFMyTVVMVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX0FSQ19QUzIgaXMgbm90
IHNldAojIENPTkZJR19VU0VSSU8gaXMgbm90IHNldAojIENPTkZJR19HQU1FUE9SVCBpcyBub3Qg
c2V0CiMgZW5kIG9mIEhhcmR3YXJlIEkvTyBwb3J0cwojIGVuZCBvZiBJbnB1dCBkZXZpY2Ugc3Vw
cG9ydAoKIwojIENoYXJhY3RlciBkZXZpY2VzCiMKQ09ORklHX1RUWT15CkNPTkZJR19WVD15CkNP
TkZJR19DT05TT0xFX1RSQU5TTEFUSU9OUz15CkNPTkZJR19WVF9DT05TT0xFPXkKQ09ORklHX1ZU
X0hXX0NPTlNPTEVfQklORElORz15CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJR19MRUdBQ1lf
UFRZUz15CkNPTkZJR19MRUdBQ1lfUFRZX0NPVU5UPTI1NgpDT05GSUdfTEVHQUNZX1RJT0NTVEk9
eQpDT05GSUdfTERJU0NfQVVUT0xPQUQ9eQoKIwojIFNlcmlhbCBkcml2ZXJzCiMKQ09ORklHX1NF
UklBTF9FQVJMWUNPTj15CkNPTkZJR19TRVJJQUxfODI1MD15CkNPTkZJR19TRVJJQUxfODI1MF9E
RVBSRUNBVEVEX09QVElPTlM9eQpDT05GSUdfU0VSSUFMXzgyNTBfUE5QPXkKQ09ORklHX1NFUklB
TF84MjUwXzE2NTUwQV9WQVJJQU5UUz15CiMgQ09ORklHX1NFUklBTF84MjUwX0ZJTlRFSyBpcyBu
b3Qgc2V0CkNPTkZJR19TRVJJQUxfODI1MF9DT05TT0xFPXkKQ09ORklHX1NFUklBTF84MjUwX1BD
SUxJQj15CkNPTkZJR19TRVJJQUxfODI1MF9QQ0k9eQpDT05GSUdfU0VSSUFMXzgyNTBfRVhBUj15
CkNPTkZJR19TRVJJQUxfODI1MF9OUl9VQVJUUz00CkNPTkZJR19TRVJJQUxfODI1MF9SVU5USU1F
X1VBUlRTPTQKIyBDT05GSUdfU0VSSUFMXzgyNTBfRVhURU5ERUQgaXMgbm90IHNldAojIENPTkZJ
R19TRVJJQUxfODI1MF9QQ0kxWFhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX0RX
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfUlQyODhYIGlzIG5vdCBzZXQKQ09ORklH
X1NFUklBTF84MjUwX1BFUklDT009eQoKIwojIE5vbi04MjUwIHNlcmlhbCBwb3J0IHN1cHBvcnQK
IwojIENPTkZJR19TRVJJQUxfVUFSVExJVEUgaXMgbm90IHNldApDT05GSUdfU0VSSUFMX0NPUkU9
eQpDT05GSUdfU0VSSUFMX0NPUkVfQ09OU09MRT15CiMgQ09ORklHX1NFUklBTF9KU00gaXMgbm90
IHNldAojIENPTkZJR19TRVJJQUxfU0NDTlhQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0FM
VEVSQV9KVEFHVUFSVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9BTFRFUkFfVUFSVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFUklBTF9BUkMgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfUlAy
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0ZTTF9MUFVBUlQgaXMgbm90IHNldAojIENPTkZJ
R19TRVJJQUxfRlNMX0xJTkZMRVhVQVJUIGlzIG5vdCBzZXQKIyBlbmQgb2YgU2VyaWFsIGRyaXZl
cnMKCiMgQ09ORklHX1NFUklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0CiMgQ09ORklHX05fR1NN
IGlzIG5vdCBzZXQKIyBDT05GSUdfTk9aT01JIGlzIG5vdCBzZXQKIyBDT05GSUdfTlVMTF9UVFkg
aXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfREVWX0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJ
UlRJT19DT05TT0xFIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBNSV9IQU5ETEVSIGlzIG5vdCBzZXQK
Q09ORklHX0hXX1JBTkRPTT1tCiMgQ09ORklHX0hXX1JBTkRPTV9USU1FUklPTUVNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSFdfUkFORE9NX0JBNDMxIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9N
X1hJUEhFUkEgaXMgbm90IHNldAojIENPTkZJR19EVExLIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQ
TElDT00gaXMgbm90IHNldApDT05GSUdfREVWTUVNPXkKQ09ORklHX0RFVlBPUlQ9eQojIENPTkZJ
R19UQ0dfVFBNIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMTFlCVVMgaXMgbm90IHNldAojIENPTkZJ
R19YSUxMWVVTQiBpcyBub3Qgc2V0CiMgZW5kIG9mIENoYXJhY3RlciBkZXZpY2VzCgojCiMgSTJD
IHN1cHBvcnQKIwojIENPTkZJR19JMkMgaXMgbm90IHNldAojIGVuZCBvZiBJMkMgc3VwcG9ydAoK
IyBDT05GSUdfSTNDIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdf
U1BNSSBpcyBub3Qgc2V0CiMgQ09ORklHX0hTSSBpcyBub3Qgc2V0CkNPTkZJR19QUFM9eQojIENP
TkZJR19QUFNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19OVFBfUFBTIGlzIG5vdCBzZXQKCiMK
IyBQUFMgY2xpZW50cyBzdXBwb3J0CiMKIyBDT05GSUdfUFBTX0NMSUVOVF9LVElNRVIgaXMgbm90
IHNldAojIENPTkZJR19QUFNfQ0xJRU5UX0xESVNDIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBTX0NM
SUVOVF9HUElPIGlzIG5vdCBzZXQKCiMKIyBQUFMgZ2VuZXJhdG9ycyBzdXBwb3J0CiMKCiMKIyBQ
VFAgY2xvY2sgc3VwcG9ydAojCkNPTkZJR19QVFBfMTU4OF9DTE9DSz15CkNPTkZJR19QVFBfMTU4
OF9DTE9DS19PUFRJT05BTD15CgojCiMgRW5hYmxlIFBIWUxJQiBhbmQgTkVUV09SS19QSFlfVElN
RVNUQU1QSU5HIHRvIHNlZSB0aGUgYWRkaXRpb25hbCBjbG9ja3MuCiMKIyBDT05GSUdfUFRQXzE1
ODhfQ0xPQ0tfTU9DSyBpcyBub3Qgc2V0CiMgZW5kIG9mIFBUUCBjbG9jayBzdXBwb3J0CgojIENP
TkZJR19QSU5DVFJMIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT0xJQiBpcyBub3Qgc2V0CiMgQ09O
RklHX1cxIGlzIG5vdCBzZXQKIyBDT05GSUdfUE9XRVJfUkVTRVQgaXMgbm90IHNldAojIENPTkZJ
R19QT1dFUl9TRVFVRU5DSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfUE9XRVJfU1VQUExZIGlzIG5v
dCBzZXQKIyBDT05GSUdfSFdNT04gaXMgbm90IHNldAojIENPTkZJR19USEVSTUFMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfV0FUQ0hET0cgaXMgbm90IHNldApDT05GSUdfU1NCX1BPU1NJQkxFPXkKIyBD
T05GSUdfU1NCIGlzIG5vdCBzZXQKQ09ORklHX0JDTUFfUE9TU0lCTEU9eQojIENPTkZJR19CQ01B
IGlzIG5vdCBzZXQKCiMKIyBNdWx0aWZ1bmN0aW9uIGRldmljZSBkcml2ZXJzCiMKIyBDT05GSUdf
TUZEX01BREVSQSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9ETE4yIGlzIG5vdCBzZXQKIyBDT05G
SUdfTFBDX0lDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0xQQ19TQ0ggaXMgbm90IHNldAojIENPTkZJ
R19NRkRfSkFOWl9DTU9ESU8gaXMgbm90IHNldAojIENPTkZJR19NRkRfS0VNUExEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX01UNjM5NyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9WSVBFUkJPQVJE
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JEQzMyMVggaXMgbm90IHNldAojIENPTkZJR19NRkRf
U001MDEgaXMgbm90IHNldAojIENPTkZJR19NRkRfU1lTQ09OIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX1RRTVg4NiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9WWDg1NSBpcyBub3Qgc2V0CiMgZW5k
IG9mIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKCiMgQ09ORklHX1JFR1VMQVRPUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JDX0NPUkUgaXMgbm90IHNldAoKIwojIENFQyBzdXBwb3J0CiMKIyBD
T05GSUdfTUVESUFfQ0VDX1NVUFBPUlQgaXMgbm90IHNldAojIGVuZCBvZiBDRUMgc3VwcG9ydAoK
IyBDT05GSUdfTUVESUFfU1VQUE9SVCBpcyBub3Qgc2V0CgojCiMgR3JhcGhpY3Mgc3VwcG9ydAoj
CkNPTkZJR19BUEVSVFVSRV9IRUxQRVJTPXkKQ09ORklHX1ZJREVPPXkKIyBDT05GSUdfQVVYRElT
UExBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTSBpcyBu
b3Qgc2V0CgojCiMgRnJhbWUgYnVmZmVyIERldmljZXMKIwpDT05GSUdfRkI9eQojIENPTkZJR19G
Ql9DSVJSVVMgaXMgbm90IHNldApDT05GSUdfRkJfUE0yPXkKQ09ORklHX0ZCX1BNMl9GSUZPX0RJ
U0NPTk5FQ1Q9eQojIENPTkZJR19GQl9DWUJFUjIwMDAgaXMgbm90IHNldAojIENPTkZJR19GQl9B
U0lMSUFOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0lNU1RUIGlzIG5vdCBzZXQKIyBDT05GSUdf
RkJfVEdBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfT1BFTkNPUkVTIGlzIG5vdCBzZXQKIyBDT05G
SUdfRkJfUzFEMTNYWFggaXMgbm90IHNldAojIENPTkZJR19GQl9OVklESUEgaXMgbm90IHNldAoj
IENPTkZJR19GQl9SSVZBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSTc0MCBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZCX01BVFJPWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1JBREVPTiBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX0FUWTEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FUWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX1MzIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU0FWQUdFIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTkVPTUFHSUMgaXMgbm90IHNl
dAojIENPTkZJR19GQl9LWVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfM0RGWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX1ZPT0RPTzEgaXMgbm90IHNldAojIENPTkZJR19GQl9WVDg2MjMgaXMgbm90
IHNldAojIENPTkZJR19GQl9UUklERU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQVJLIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfUE0zIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQ0FSTUlORSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZCX1NNU0NVRlggaXMgbm90IHNldAojIENPTkZJR19GQl9VREwgaXMg
bm90IHNldAojIENPTkZJR19GQl9JQk1fR1hUNDUwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1ZJ
UlRVQUwgaXMgbm90IHNldAojIENPTkZJR19GQl9NRVRST05PTUUgaXMgbm90IHNldAojIENPTkZJ
R19GQl9NQjg2MlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU0lNUExFIGlzIG5vdCBzZXQKIyBD
T05GSUdfRkJfU003MTIgaXMgbm90IHNldApDT05GSUdfRkJfQ09SRT15CkNPTkZJR19GQl9OT1RJ
Rlk9eQojIENPTkZJR19GSVJNV0FSRV9FRElEIGlzIG5vdCBzZXQKQ09ORklHX0ZCX0RFVklDRT15
CkNPTkZJR19GQl9DRkJfRklMTFJFQ1Q9eQpDT05GSUdfRkJfQ0ZCX0NPUFlBUkVBPXkKQ09ORklH
X0ZCX0NGQl9JTUFHRUJMSVQ9eQojIENPTkZJR19GQl9GT1JFSUdOX0VORElBTiBpcyBub3Qgc2V0
CkNPTkZJR19GQl9JT01FTV9GT1BTPXkKIyBDT05GSUdfRkJfTU9ERV9IRUxQRVJTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfVElMRUJMSVRUSU5HIGlzIG5vdCBzZXQKIyBlbmQgb2YgRnJhbWUgYnVm
ZmVyIERldmljZXMKCiMKIyBCYWNrbGlnaHQgJiBMQ0QgZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJ
R19MQ0RfQ0xBU1NfREVWSUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0NMQVNTX0RF
VklDRSBpcyBub3Qgc2V0CiMgZW5kIG9mIEJhY2tsaWdodCAmIExDRCBkZXZpY2Ugc3VwcG9ydAoK
IwojIENvbnNvbGUgZGlzcGxheSBkcml2ZXIgc3VwcG9ydAojCkNPTkZJR19WR0FfQ09OU09MRT15
CiMgQ09ORklHX01EQV9DT05TT0xFIGlzIG5vdCBzZXQKQ09ORklHX0RVTU1ZX0NPTlNPTEVfQ09M
VU1OUz04MApDT05GSUdfRFVNTVlfQ09OU09MRV9ST1dTPTI1CkNPTkZJR19GUkFNRUJVRkZFUl9D
T05TT0xFPXkKIyBDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRV9MRUdBQ1lfQUNDRUxFUkFUSU9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRV9ERVRFQ1RfUFJJTUFSWSBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVfUk9UQVRJT04gaXMgbm90IHNl
dAojIENPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX0RFRkVSUkVEX1RBS0VPVkVSIGlzIG5vdCBz
ZXQKIyBlbmQgb2YgQ29uc29sZSBkaXNwbGF5IGRyaXZlciBzdXBwb3J0CgpDT05GSUdfTE9HTz15
CkNPTkZJR19MT0dPX0xJTlVYX01PTk89eQpDT05GSUdfTE9HT19MSU5VWF9WR0ExNj15CkNPTkZJ
R19MT0dPX0xJTlVYX0NMVVQyMjQ9eQpDT05GSUdfTE9HT19ERUNfQ0xVVDIyND15CiMgZW5kIG9m
IEdyYXBoaWNzIHN1cHBvcnQKCiMgQ09ORklHX1NPVU5EIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X1NVUFBPUlQgaXMgbm90IHNldApDT05GSUdfVVNCX09IQ0lfTElUVExFX0VORElBTj15CkNPTkZJ
R19VU0JfU1VQUE9SVD15CkNPTkZJR19VU0JfQ09NTU9OPXkKIyBDT05GSUdfVVNCX1VMUElfQlVT
IGlzIG5vdCBzZXQKQ09ORklHX1VTQl9BUkNIX0hBU19IQ0Q9eQpDT05GSUdfVVNCPXkKQ09ORklH
X1VTQl9QQ0k9eQojIENPTkZJR19VU0JfUENJX0FNRCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfQU5O
T1VOQ0VfTkVXX0RFVklDRVM9eQoKIwojIE1pc2NlbGxhbmVvdXMgVVNCIG9wdGlvbnMKIwpDT05G
SUdfVVNCX0RFRkFVTFRfUEVSU0lTVD15CiMgQ09ORklHX1VTQl9GRVdfSU5JVF9SRVRSSUVTIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0RZTkFNSUNfTUlOT1JTIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX09UR19QUk9EVUNUTElTVCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfQVVUT1NVU1BFTkRfREVM
QVk9MgpDT05GSUdfVVNCX0RFRkFVTFRfQVVUSE9SSVpBVElPTl9NT0RFPTEKIyBDT05GSUdfVVNC
X01PTiBpcyBub3Qgc2V0CgojCiMgVVNCIEhvc3QgQ29udHJvbGxlciBEcml2ZXJzCiMKIyBDT05G
SUdfVVNCX0M2N1gwMF9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfWEhDSV9IQ0QgaXMgbm90
IHNldApDT05GSUdfVVNCX0VIQ0lfSENEPXkKQ09ORklHX1VTQl9FSENJX1JPT1RfSFVCX1RUPXkK
Q09ORklHX1VTQl9FSENJX1RUX05FV1NDSEVEPXkKQ09ORklHX1VTQl9FSENJX1BDST15CiMgQ09O
RklHX1VTQl9FSENJX0ZTTCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FSENJX0hDRF9QTEFURk9S
TSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PWFUyMTBIUF9IQ0QgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfSVNQMTE2WF9IQ0QgaXMgbm90IHNldApDT05GSUdfVVNCX09IQ0lfSENEPXkKQ09ORklH
X1VTQl9PSENJX0hDRF9QQ0k9eQpDT05GSUdfVVNCX09IQ0lfSENEX1BMQVRGT1JNPXkKQ09ORklH
X1VTQl9VSENJX0hDRD15CiMgQ09ORklHX1VTQl9TTDgxMV9IQ0QgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfUjhBNjY1OTdfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hDRF9URVNUX01PREUg
aXMgbm90IHNldAoKIwojIFVTQiBEZXZpY2UgQ2xhc3MgZHJpdmVycwojCiMgQ09ORklHX1VTQl9B
Q00gaXMgbm90IHNldAojIENPTkZJR19VU0JfUFJJTlRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9XRE0gaXMgbm90IHNldAojIENPTkZJR19VU0JfVE1DIGlzIG5vdCBzZXQKCiMKIyBOT1RFOiBV
U0JfU1RPUkFHRSBkZXBlbmRzIG9uIFNDU0kgYnV0IEJMS19ERVZfU0QgbWF5CiMKCiMKIyBhbHNv
IGJlIG5lZWRlZDsgc2VlIFVTQl9TVE9SQUdFIEhlbHAgZm9yIG1vcmUgaW5mbwojCkNPTkZJR19V
U0JfU1RPUkFHRT15CiMgQ09ORklHX1VTQl9TVE9SQUdFX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklH
X1VTQl9TVE9SQUdFX1JFQUxURUs9eQojIENPTkZJR19VU0JfU1RPUkFHRV9EQVRBRkFCIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfRlJFRUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TVE9SQUdFX0lTRDIwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1VTQkFUIGlz
IG5vdCBzZXQKQ09ORklHX1VTQl9TVE9SQUdFX1NERFIwOT15CkNPTkZJR19VU0JfU1RPUkFHRV9T
RERSNTU9eQojIENPTkZJR19VU0JfU1RPUkFHRV9KVU1QU0hPVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9TVE9SQUdFX0FMQVVEQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX09ORVRP
VUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfS0FSTUEgaXMgbm90IHNldAojIENP
TkZJR19VU0JfU1RPUkFHRV9DWVBSRVNTX0FUQUNCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NU
T1JBR0VfRU5FX1VCNjI1MCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfVUFTPXkKCiMKIyBVU0IgSW1h
Z2luZyBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX01EQzgwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9NSUNST1RFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQklQX0NPUkUgaXMgbm90IHNldAoKIwoj
IFVTQiBkdWFsLW1vZGUgY29udHJvbGxlciBkcml2ZXJzCiMKIyBDT05GSUdfVVNCX0NETlNfU1VQ
UE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NVVNCX0hEUkMgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfRFdDMyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9EV0MyIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0NISVBJREVBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDE3NjAgaXMgbm90IHNl
dAoKIwojIFVTQiBwb3J0IGRyaXZlcnMKIwpDT05GSUdfVVNCX1NFUklBTD15CkNPTkZJR19VU0Jf
U0VSSUFMX0NPTlNPTEU9eQpDT05GSUdfVVNCX1NFUklBTF9HRU5FUklDPXkKIyBDT05GSUdfVVNC
X1NFUklBTF9TSU1QTEUgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0FJUkNBQkxFIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9BUkszMTE2IGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9CRUxLSU4gaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0NIMzQxIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9XSElURUhFQVQgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfU0VSSUFMX0RJR0lfQUNDRUxFUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJ
QUxfQ1AyMTBYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9DWVBSRVNTX004IGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9FTVBFRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9T
RVJJQUxfRlRESV9TSU8gaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1ZJU09SIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9JUEFRIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NF
UklBTF9JUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRURHRVBPUlQgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX0VER0VQT1JUX1RJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9GODEyMzIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0Y4MTUzWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfR0FSTUlOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9JUFcgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0lVVSBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9QREEgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX0tFWVNQQU4gaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tMU0kgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tPQklMX1NDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TRVJJQUxfTUNUX1UyMzIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX01FVFJPIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9NT1M3NzIwIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9NT1M3ODQwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9NWFVQT1JU
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9OQVZNQU4gaXMgbm90IHNldApDT05GSUdf
VVNCX1NFUklBTF9QTDIzMDM9eQojIENPTkZJR19VU0JfU0VSSUFMX09USTY4NTggaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX1FDQVVYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9RVUFMQ09NTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfU1BDUDhYNSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfU0FGRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJ
QUxfU0lFUlJBV0lSRUxFU1MgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1NZTUJPTCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfVEkgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX0NZQkVSSkFDSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfT1BUSU9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9PTU5JTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9PUFRJQ09OIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9YU0VOU19N
VCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfV0lTSEJPTkUgaXMgbm90IHNldAojIENP
TkZJR19VU0JfU0VSSUFMX1NTVTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfUVQy
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9VUEQ3OEYwNzMwIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1NFUklBTF9YUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfREVCVUcg
aXMgbm90IHNldAoKIwojIFVTQiBNaXNjZWxsYW5lb3VzIGRyaXZlcnMKIwojIENPTkZJR19VU0Jf
RU1JNjIgaXMgbm90IHNldAojIENPTkZJR19VU0JfRU1JMjYgaXMgbm90IHNldAojIENPTkZJR19V
U0JfQURVVFVYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFVlNFRyBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9MRUdPVE9XRVIgaXMgbm90IHNldAojIENPTkZJR19VU0JfTENEIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0NZUFJFU1NfQ1k3QzYzIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NZVEhF
Uk0gaXMgbm90IHNldAojIENPTkZJR19VU0JfSURNT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9BUFBMRURJU1BMQVkgaXMgbm90IHNldAojIENPTkZJR19BUFBMRV9NRklfRkFTVENIQVJHRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TSVNVU0JWR0EgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
TEQgaXMgbm90IHNldAojIENPTkZJR19VU0JfVFJBTkNFVklCUkFUT1IgaXMgbm90IHNldAojIENP
TkZJR19VU0JfSU9XQVJSSU9SIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1RFU1QgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfRUhTRVRfVEVTVF9GSVhUVVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0lTSUdIVEZXIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1lVUkVYIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0VaVVNCX0ZYMiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MSU5LX0xBWUVSX1RFU1Qg
aXMgbm90IHNldAojIENPTkZJR19VU0JfQ0hBT1NLRVkgaXMgbm90IHNldAoKIwojIFVTQiBQaHlz
aWNhbCBMYXllciBkcml2ZXJzCiMKIyBDT05GSUdfTk9QX1VTQl9YQ0VJViBpcyBub3Qgc2V0CiMg
ZW5kIG9mIFVTQiBQaHlzaWNhbCBMYXllciBkcml2ZXJzCgojIENPTkZJR19VU0JfR0FER0VUIGlz
IG5vdCBzZXQKIyBDT05GSUdfVFlQRUMgaXMgbm90IHNldAojIENPTkZJR19VU0JfUk9MRV9TV0lU
Q0ggaXMgbm90IHNldAojIENPTkZJR19NTUMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1VGU0hD
RCBpcyBub3Qgc2V0CiMgQ09ORklHX01FTVNUSUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVXX0xF
RFMgaXMgbm90IHNldAojIENPTkZJR19BQ0NFU1NJQklMSVRZIGlzIG5vdCBzZXQKQ09ORklHX1JU
Q19MSUI9eQpDT05GSUdfUlRDX01DMTQ2ODE4X0xJQj15CkNPTkZJR19SVENfQ0xBU1M9eQpDT05G
SUdfUlRDX0hDVE9TWVM9eQpDT05GSUdfUlRDX0hDVE9TWVNfREVWSUNFPSJydGMwIgpDT05GSUdf
UlRDX1NZU1RPSEM9eQpDT05GSUdfUlRDX1NZU1RPSENfREVWSUNFPSJydGMwIgojIENPTkZJR19S
VENfREVCVUcgaXMgbm90IHNldApDT05GSUdfUlRDX05WTUVNPXkKCiMKIyBSVEMgaW50ZXJmYWNl
cwojCkNPTkZJR19SVENfSU5URl9TWVNGUz15CkNPTkZJR19SVENfSU5URl9QUk9DPXkKQ09ORklH
X1JUQ19JTlRGX0RFVj15CiMgQ09ORklHX1JUQ19JTlRGX0RFVl9VSUVfRU1VTCBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUQ19EUlZfVEVTVCBpcyBub3Qgc2V0CgojCiMgSTJDIFJUQyBkcml2ZXJzCiMK
CiMKIyBTUEkgUlRDIGRyaXZlcnMKIwoKIwojIFNQSSBhbmQgSTJDIFJUQyBkcml2ZXJzCiMKCiMK
IyBQbGF0Zm9ybSBSVEMgZHJpdmVycwojCkNPTkZJR19SVENfRFJWX0FMUEhBPXkKIyBDT05GSUdf
UlRDX0RSVl9EUzEyODYgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMTUxMSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNTUzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9E
UzE2ODVfRkFNSUxZIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE3NDIgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX0RTMjQwNCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfU1RL
MTdUQTggaXMgbm90IHNldApDT05GSUdfUlRDX0RSVl9NNDhUODY9eQojIENPTkZJR19SVENfRFJW
X000OFQzNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQ4VDU5IGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRDX0RSVl9NU002MjQyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SUDVDMDEg
aXMgbm90IHNldAoKIwojIG9uLUNQVSBSVEMgZHJpdmVycwojCiMgQ09ORklHX1JUQ19EUlZfRlRS
VEMwMTAgaXMgbm90IHNldAoKIwojIEhJRCBTZW5zb3IgUlRDIGRyaXZlcnMKIwojIENPTkZJR19S
VENfRFJWX0dPTERGSVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1BREVWSUNFUyBpcyBub3Qgc2V0
CgojCiMgRE1BQlVGIG9wdGlvbnMKIwojIENPTkZJR19TWU5DX0ZJTEUgaXMgbm90IHNldAojIENP
TkZJR19ETUFCVUZfSEVBUFMgaXMgbm90IHNldAojIGVuZCBvZiBETUFCVUYgb3B0aW9ucwoKIyBD
T05GSUdfVUlPIGlzIG5vdCBzZXQKIyBDT05GSUdfVkZJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJ
UlRfRFJJVkVSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJUlRJT19NRU5VIGlzIG5vdCBzZXQKIyBD
T05GSUdfVkRQQSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZIT1NUX01FTlUgaXMgbm90IHNldAoKIwoj
IE1pY3Jvc29mdCBIeXBlci1WIGd1ZXN0IHN1cHBvcnQKIwojIGVuZCBvZiBNaWNyb3NvZnQgSHlw
ZXItViBndWVzdCBzdXBwb3J0CgojIENPTkZJR19HUkVZQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q09NRURJIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBR0lORyBpcyBub3Qgc2V0CiMgQ09ORklHX0dP
TERGSVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1pOSUNfUExBVEZPUk1TIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ09NTU9OX0NMSyBpcyBub3Qgc2V0CiMgQ09ORklHX0hXU1BJTkxPQ0sgaXMgbm90IHNl
dAoKIwojIENsb2NrIFNvdXJjZSBkcml2ZXJzCiMKQ09ORklHX0k4MjUzX0xPQ0s9eQpDT05GSUdf
Q0xLQkxEX0k4MjUzPXkKIyBlbmQgb2YgQ2xvY2sgU291cmNlIGRyaXZlcnMKCiMgQ09ORklHX01B
SUxCT1ggaXMgbm90IHNldAojIENPTkZJR19JT01NVV9TVVBQT1JUIGlzIG5vdCBzZXQKCiMKIyBS
ZW1vdGVwcm9jIGRyaXZlcnMKIwojIENPTkZJR19SRU1PVEVQUk9DIGlzIG5vdCBzZXQKIyBlbmQg
b2YgUmVtb3RlcHJvYyBkcml2ZXJzCgojCiMgUnBtc2cgZHJpdmVycwojCiMgQ09ORklHX1JQTVNH
X1ZJUlRJTyBpcyBub3Qgc2V0CiMgZW5kIG9mIFJwbXNnIGRyaXZlcnMKCiMKIyBTT0MgKFN5c3Rl
bSBPbiBDaGlwKSBzcGVjaWZpYyBEcml2ZXJzCiMKCiMKIyBBbWxvZ2ljIFNvQyBkcml2ZXJzCiMK
IyBlbmQgb2YgQW1sb2dpYyBTb0MgZHJpdmVycwoKIwojIEJyb2FkY29tIFNvQyBkcml2ZXJzCiMK
IyBlbmQgb2YgQnJvYWRjb20gU29DIGRyaXZlcnMKCiMKIyBOWFAvRnJlZXNjYWxlIFFvcklRIFNv
QyBkcml2ZXJzCiMKIyBlbmQgb2YgTlhQL0ZyZWVzY2FsZSBRb3JJUSBTb0MgZHJpdmVycwoKIwoj
IGZ1aml0c3UgU29DIGRyaXZlcnMKIwojIGVuZCBvZiBmdWppdHN1IFNvQyBkcml2ZXJzCgojCiMg
aS5NWCBTb0MgZHJpdmVycwojCiMgZW5kIG9mIGkuTVggU29DIGRyaXZlcnMKCiMKIyBFbmFibGUg
TGl0ZVggU29DIEJ1aWxkZXIgc3BlY2lmaWMgZHJpdmVycwojCiMgZW5kIG9mIEVuYWJsZSBMaXRl
WCBTb0MgQnVpbGRlciBzcGVjaWZpYyBkcml2ZXJzCgojIENPTkZJR19XUENNNDUwX1NPQyBpcyBu
b3Qgc2V0CgojCiMgUXVhbGNvbW0gU29DIGRyaXZlcnMKIwojIGVuZCBvZiBRdWFsY29tbSBTb0Mg
ZHJpdmVycwoKIyBDT05GSUdfU09DX1RJIGlzIG5vdCBzZXQKCiMKIyBYaWxpbnggU29DIGRyaXZl
cnMKIwojIGVuZCBvZiBYaWxpbnggU29DIGRyaXZlcnMKIyBlbmQgb2YgU09DIChTeXN0ZW0gT24g
Q2hpcCkgc3BlY2lmaWMgRHJpdmVycwoKIwojIFBNIERvbWFpbnMKIwoKIwojIEFtbG9naWMgUE0g
RG9tYWlucwojCiMgZW5kIG9mIEFtbG9naWMgUE0gRG9tYWlucwoKIwojIEJyb2FkY29tIFBNIERv
bWFpbnMKIwojIGVuZCBvZiBCcm9hZGNvbSBQTSBEb21haW5zCgojCiMgaS5NWCBQTSBEb21haW5z
CiMKIyBlbmQgb2YgaS5NWCBQTSBEb21haW5zCgojCiMgUXVhbGNvbW0gUE0gRG9tYWlucwojCiMg
ZW5kIG9mIFF1YWxjb21tIFBNIERvbWFpbnMKIyBlbmQgb2YgUE0gRG9tYWlucwoKIyBDT05GSUdf
UE1fREVWRlJFUSBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVENPTiBpcyBub3Qgc2V0CiMgQ09ORklH
X01FTU9SWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05UQiBp
cyBub3Qgc2V0CiMgQ09ORklHX1BXTSBpcyBub3Qgc2V0CgojCiMgSVJRIGNoaXAgc3VwcG9ydAoj
CiMgQ09ORklHX0xBTjk2NlhfT0lDIGlzIG5vdCBzZXQKIyBlbmQgb2YgSVJRIGNoaXAgc3VwcG9y
dAoKIyBDT05GSUdfSVBBQ0tfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVTRVRfQ09OVFJPTExF
UiBpcyBub3Qgc2V0CgojCiMgUEhZIFN1YnN5c3RlbQojCiMgQ09ORklHX0dFTkVSSUNfUEhZIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEhZX0NBTl9UUkFOU0NFSVZFUiBpcyBub3Qgc2V0CgojCiMgUEhZ
IGRyaXZlcnMgZm9yIEJyb2FkY29tIHBsYXRmb3JtcwojCiMgQ09ORklHX0JDTV9LT05BX1VTQjJf
UEhZIGlzIG5vdCBzZXQKIyBlbmQgb2YgUEhZIGRyaXZlcnMgZm9yIEJyb2FkY29tIHBsYXRmb3Jt
cwoKIyBDT05GSUdfUEhZX1BYQV8yOE5NX0hTSUMgaXMgbm90IHNldAojIENPTkZJR19QSFlfUFhB
XzI4Tk1fVVNCMiBpcyBub3Qgc2V0CiMgZW5kIG9mIFBIWSBTdWJzeXN0ZW0KCiMgQ09ORklHX1BP
V0VSQ0FQIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNCIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFTIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCNCBpcyBub3Qgc2V0CgojCiMgQW5kcm9pZAojCiMgQ09ORklH
X0FORFJPSURfQklOREVSX0lQQyBpcyBub3Qgc2V0CiMgZW5kIG9mIEFuZHJvaWQKCiMgQ09ORklH
X0xJQk5WRElNTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RBWCBpcyBub3Qgc2V0CkNPTkZJR19OVk1F
TT15CkNPTkZJR19OVk1FTV9TWVNGUz15CiMgQ09ORklHX05WTUVNX0xBWU9VVFMgaXMgbm90IHNl
dAojIENPTkZJR19OVk1FTV9STUVNIGlzIG5vdCBzZXQKCiMKIyBIVyB0cmFjaW5nIHN1cHBvcnQK
IwojIENPTkZJR19TVE0gaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9USCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEhXIHRyYWNpbmcgc3VwcG9ydAoKIyBDT05GSUdfRlBHQSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NJT1ggaXMgbm90IHNldAojIENPTkZJR19TTElNQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5URVJDT05ORUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09VTlRFUiBpcyBub3Qgc2V0CiMgQ09O
RklHX1BFQ0kgaXMgbm90IHNldAojIENPTkZJR19IVEUgaXMgbm90IHNldAojIGVuZCBvZiBEZXZp
Y2UgRHJpdmVycwoKIwojIEZpbGUgc3lzdGVtcwojCiMgQ09ORklHX1ZBTElEQVRFX0ZTX1BBUlNF
UiBpcyBub3Qgc2V0CkNPTkZJR19GU19JT01BUD15CkNPTkZJR19CVUZGRVJfSEVBRD15CkNPTkZJ
R19MRUdBQ1lfRElSRUNUX0lPPXkKQ09ORklHX0VYVDJfRlM9eQojIENPTkZJR19FWFQyX0ZTX1hB
VFRSIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUM19GUyBpcyBub3Qgc2V0CkNPTkZJR19FWFQ0X0ZT
PXkKIyBDT05GSUdfRVhUNF9GU19QT1NJWF9BQ0wgaXMgbm90IHNldAojIENPTkZJR19FWFQ0X0ZT
X1NFQ1VSSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUNF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJ
R19KQkQyPXkKIyBDT05GSUdfSkJEMl9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19GU19NQkNBQ0hF
PXkKIyBDT05GSUdfUkVJU0VSRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19KRlNfRlMgaXMgbm90
IHNldAojIENPTkZJR19YRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19HRlMyX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQlRSRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19OSUxGUzJfRlMgaXMgbm90
IHNldAojIENPTkZJR19GMkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNBQ0hFRlNfRlMgaXMg
bm90IHNldApDT05GSUdfRVhQT1JURlM9eQojIENPTkZJR19FWFBPUlRGU19CTE9DS19PUFMgaXMg
bm90IHNldApDT05GSUdfRklMRV9MT0NLSU5HPXkKIyBDT05GSUdfRlNfRU5DUllQVElPTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZTX1ZFUklUWSBpcyBub3Qgc2V0CkNPTkZJR19GU05PVElGWT15CkNP
TkZJR19ETk9USUZZPXkKQ09ORklHX0lOT1RJRllfVVNFUj15CiMgQ09ORklHX0ZBTk9USUZZIGlz
IG5vdCBzZXQKIyBDT05GSUdfUVVPVEEgaXMgbm90IHNldAojIENPTkZJR19BVVRPRlNfRlMgaXMg
bm90IHNldAojIENPTkZJR19GVVNFX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfT1ZFUkxBWV9GUyBp
cyBub3Qgc2V0CgojCiMgQ2FjaGVzCiMKIyBlbmQgb2YgQ2FjaGVzCgojCiMgQ0QtUk9NL0RWRCBG
aWxlc3lzdGVtcwojCkNPTkZJR19JU085NjYwX0ZTPXkKQ09ORklHX0pPTElFVD15CkNPTkZJR19a
SVNPRlM9eQpDT05GSUdfVURGX0ZTPXkKIyBlbmQgb2YgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwoK
IwojIERPUy9GQVQvRVhGQVQvTlQgRmlsZXN5c3RlbXMKIwpDT05GSUdfRkFUX0ZTPXkKQ09ORklH
X01TRE9TX0ZTPXkKQ09ORklHX1ZGQVRfRlM9eQpDT05GSUdfRkFUX0RFRkFVTFRfQ09ERVBBR0U9
NDM3CkNPTkZJR19GQVRfREVGQVVMVF9JT0NIQVJTRVQ9Imlzbzg4NTktMSIKIyBDT05GSUdfRkFU
X0RFRkFVTFRfVVRGOCBpcyBub3Qgc2V0CkNPTkZJR19FWEZBVF9GUz15CkNPTkZJR19FWEZBVF9E
RUZBVUxUX0lPQ0hBUlNFVD0idXRmOCIKIyBDT05GSUdfTlRGUzNfRlMgaXMgbm90IHNldAojIENP
TkZJR19OVEZTX0ZTIGlzIG5vdCBzZXQKIyBlbmQgb2YgRE9TL0ZBVC9FWEZBVC9OVCBGaWxlc3lz
dGVtcwoKIwojIFBzZXVkbyBmaWxlc3lzdGVtcwojCkNPTkZJR19QUk9DX0ZTPXkKQ09ORklHX1BS
T0NfS0NPUkU9eQpDT05GSUdfUFJPQ19TWVNDVEw9eQpDT05GSUdfUFJPQ19QQUdFX01PTklUT1I9
eQojIENPTkZJR19QUk9DX0NISUxEUkVOIGlzIG5vdCBzZXQKQ09ORklHX0tFUk5GUz15CkNPTkZJ
R19TWVNGUz15CkNPTkZJR19UTVBGUz15CiMgQ09ORklHX1RNUEZTX1BPU0lYX0FDTCBpcyBub3Qg
c2V0CiMgQ09ORklHX1RNUEZTX1hBVFRSIGlzIG5vdCBzZXQKIyBDT05GSUdfVE1QRlNfSU5PREU2
NCBpcyBub3Qgc2V0CiMgQ09ORklHX1RNUEZTX1FVT1RBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09O
RklHRlNfRlMgaXMgbm90IHNldAojIGVuZCBvZiBQc2V1ZG8gZmlsZXN5c3RlbXMKCiMgQ09ORklH
X01JU0NfRklMRVNZU1RFTVMgaXMgbm90IHNldApDT05GSUdfTkVUV09SS19GSUxFU1lTVEVNUz15
CkNPTkZJR19ORlNfRlM9bQpDT05GSUdfTkZTX1YyPW0KQ09ORklHX05GU19WMz1tCiMgQ09ORklH
X05GU19WM19BQ0wgaXMgbm90IHNldApDT05GSUdfTkZTX1Y0PW0KIyBDT05GSUdfTkZTX1NXQVAg
aXMgbm90IHNldAojIENPTkZJR19ORlNfVjRfMSBpcyBub3Qgc2V0CiMgQ09ORklHX05GU19VU0Vf
TEVHQUNZX0ROUyBpcyBub3Qgc2V0CkNPTkZJR19ORlNfVVNFX0tFUk5FTF9ETlM9eQpDT05GSUdf
TkZTX0RJU0FCTEVfVURQX1NVUFBPUlQ9eQpDT05GSUdfTkZTRD1tCiMgQ09ORklHX05GU0RfVjIg
aXMgbm90IHNldAojIENPTkZJR19ORlNEX1YzX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX05GU0Rf
VjQgaXMgbm90IHNldApDT05GSUdfR1JBQ0VfUEVSSU9EPW0KQ09ORklHX0xPQ0tEPW0KQ09ORklH
X0xPQ0tEX1Y0PXkKQ09ORklHX05GU19DT01NT049eQojIENPTkZJR19ORlNfTE9DQUxJTyBpcyBu
b3Qgc2V0CkNPTkZJR19TVU5SUEM9bQpDT05GSUdfU1VOUlBDX0dTUz1tCkNPTkZJR19SUENTRUNf
R1NTX0tSQjU9bQojIENPTkZJR19TVU5SUENfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19DRVBI
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lGUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NNQl9TRVJW
RVIgaXMgbm90IHNldAojIENPTkZJR19DT0RBX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZTX0ZT
IGlzIG5vdCBzZXQKQ09ORklHX05MUz15CkNPTkZJR19OTFNfREVGQVVMVD0iaXNvODg1OS0xIgpD
T05GSUdfTkxTX0NPREVQQUdFXzQzNz15CiMgQ09ORklHX05MU19DT0RFUEFHRV83MzcgaXMgbm90
IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfNzc1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NP
REVQQUdFXzg1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTIgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQ
QUdFXzg1NyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjAgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfQ09ERVBBR0VfODYxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdF
Xzg2MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjMgaXMgbm90IHNldAojIENP
TkZJR19OTFNfQ09ERVBBR0VfODY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2
NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjYgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfQ09ERVBBR0VfODY5IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85NTAgaXMgbm90IHNldAojIENPTkZJR19O
TFNfQ09ERVBBR0VfOTMyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk0OSBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NzQgaXMgbm90IHNldAojIENPTkZJR19OTFNf
SVNPODg1OV84IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfQ09ERVBBR0VfMTI1MSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19BU0NJ
SSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzEgaXMgbm90IHNldAojIENPTkZJR19O
TFNfSVNPODg1OV8yIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMyBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19JU084ODU5XzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV81
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNiBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19JU084ODU5XzcgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV85IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0lTTzg4NTlfMTMgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8x
NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzE1IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0tPSThfUiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19LT0k4X1UgaXMgbm90IHNldAojIENP
TkZJR19OTFNfTUFDX1JPTUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19DRUxUSUMgaXMg
bm90IHNldAojIENPTkZJR19OTFNfTUFDX0NFTlRFVVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X01BQ19DUk9BVElBTiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfQ1lSSUxMSUMgaXMgbm90
IHNldAojIENPTkZJR19OTFNfTUFDX0dBRUxJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNf
R1JFRUsgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0lDRUxBTkQgaXMgbm90IHNldAojIENP
TkZJR19OTFNfTUFDX0lOVUlUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19ST01BTklBTiBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfVFVSS0lTSCBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19VVEY4IGlzIG5vdCBzZXQKIyBDT05GSUdfVU5JQ09ERSBpcyBub3Qgc2V0CkNPTkZJR19JT19X
UT15CiMgZW5kIG9mIEZpbGUgc3lzdGVtcwoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwpDT05GSUdf
S0VZUz15CiMgQ09ORklHX0tFWVNfUkVRVUVTVF9DQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BF
UlNJU1RFTlRfS0VZUklOR1MgaXMgbm90IHNldAojIENPTkZJR19UUlVTVEVEX0tFWVMgaXMgbm90
IHNldAojIENPTkZJR19FTkNSWVBURURfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWV9ESF9P
UEVSQVRJT05TIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFlfRE1FU0dfUkVTVFJJQ1QgaXMg
bm90IHNldApDT05GSUdfUFJPQ19NRU1fQUxXQVlTX0ZPUkNFPXkKIyBDT05GSUdfUFJPQ19NRU1f
Rk9SQ0VfUFRSQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJPQ19NRU1fTk9fRk9SQ0UgaXMgbm90
IHNldAojIENPTkZJR19TRUNVUklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZRlMgaXMg
bm90IHNldAojIENPTkZJR19IQVJERU5FRF9VU0VSQ09QWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NU
QVRJQ19VU0VSTU9ERUhFTFBFUiBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX1NFQ1VSSVRZX0RB
Qz15CkNPTkZJR19MU009ImxhbmRsb2NrLGxvY2tkb3duLHlhbWEsbG9hZHBpbixzYWZlc2V0aWQs
aXBlLGJwZiIKCiMKIyBLZXJuZWwgaGFyZGVuaW5nIG9wdGlvbnMKIwoKIwojIE1lbW9yeSBpbml0
aWFsaXphdGlvbgojCkNPTkZJR19JTklUX1NUQUNLX05PTkU9eQojIENPTkZJR19JTklUX09OX0FM
TE9DX0RFRkFVTFRfT04gaXMgbm90IHNldAojIENPTkZJR19JTklUX09OX0ZSRUVfREVGQVVMVF9P
TiBpcyBub3Qgc2V0CiMgZW5kIG9mIE1lbW9yeSBpbml0aWFsaXphdGlvbgoKIwojIEhhcmRlbmlu
ZyBvZiBrZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzCiMKIyBDT05GSUdfTElTVF9IQVJERU5FRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JVR19PTl9EQVRBX0NPUlJVUFRJT04gaXMgbm90IHNldAojIGVuZCBv
ZiBIYXJkZW5pbmcgb2Yga2VybmVsIGRhdGEgc3RydWN0dXJlcwoKQ09ORklHX1JBTkRTVFJVQ1Rf
Tk9ORT15CiMgZW5kIG9mIEtlcm5lbCBoYXJkZW5pbmcgb3B0aW9ucwojIGVuZCBvZiBTZWN1cml0
eSBvcHRpb25zCgpDT05GSUdfQ1JZUFRPPXkKCiMKIyBDcnlwdG8gY29yZSBvciBoZWxwZXIKIwpD
T05GSUdfQ1JZUFRPX0FMR0FQST15CkNPTkZJR19DUllQVE9fQUxHQVBJMj15CkNPTkZJR19DUllQ
VE9fQUVBRD15CkNPTkZJR19DUllQVE9fQUVBRDI9eQpDT05GSUdfQ1JZUFRPX1NJRzI9eQpDT05G
SUdfQ1JZUFRPX1NLQ0lQSEVSPXkKQ09ORklHX0NSWVBUT19TS0NJUEhFUjI9eQpDT05GSUdfQ1JZ
UFRPX0hBU0g9eQpDT05GSUdfQ1JZUFRPX0hBU0gyPXkKQ09ORklHX0NSWVBUT19STkc9bQpDT05G
SUdfQ1JZUFRPX1JORzI9eQpDT05GSUdfQ1JZUFRPX1JOR19ERUZBVUxUPW0KQ09ORklHX0NSWVBU
T19BS0NJUEhFUjI9eQpDT05GSUdfQ1JZUFRPX0tQUDI9eQpDT05GSUdfQ1JZUFRPX0FDT01QMj15
CkNPTkZJR19DUllQVE9fTUFOQUdFUj15CkNPTkZJR19DUllQVE9fTUFOQUdFUjI9eQojIENPTkZJ
R19DUllQVE9fVVNFUiBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fTUFOQUdFUl9ESVNBQkxFX1RF
U1RTPXkKQ09ORklHX0NSWVBUT19OVUxMPXkKQ09ORklHX0NSWVBUT19OVUxMMj15CiMgQ09ORklH
X0NSWVBUT19DUllQVEQgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0FVVEhFTkM9bQojIENPTkZJ
R19DUllQVE9fVEVTVCBpcyBub3Qgc2V0CiMgZW5kIG9mIENyeXB0byBjb3JlIG9yIGhlbHBlcgoK
IwojIFB1YmxpYy1rZXkgY3J5cHRvZ3JhcGh5CiMKIyBDT05GSUdfQ1JZUFRPX1JTQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19ESCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19FQ0RIIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0VDRFNBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X0VDUkRTQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DVVJWRTI1NTE5IGlzIG5vdCBzZXQK
IyBlbmQgb2YgUHVibGljLWtleSBjcnlwdG9ncmFwaHkKCiMKIyBCbG9jayBjaXBoZXJzCiMKQ09O
RklHX0NSWVBUT19BRVM9eQojIENPTkZJR19DUllQVE9fQUVTX1RJIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0FSSUEgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQkxPV0ZJU0ggaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fQ0FNRUxMSUEgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
Q0FTVDUgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FTVDYgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fREVTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0ZDUllQVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19TRVJQRU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NNNF9H
RU5FUklDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RXT0ZJU0ggaXMgbm90IHNldAojIGVu
ZCBvZiBCbG9jayBjaXBoZXJzCgojCiMgTGVuZ3RoLXByZXNlcnZpbmcgY2lwaGVycyBhbmQgbW9k
ZXMKIwojIENPTkZJR19DUllQVE9fQURJQU5UVU0gaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
Q0hBQ0hBMjAgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0NCQz1tCkNPTkZJR19DUllQVE9fQ1RS
PXkKIyBDT05GSUdfQ1JZUFRPX0NUUyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fRUNCPXkKIyBD
T05GSUdfQ1JZUFRPX0hDVFIyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0tFWVdSQVAgaXMg
bm90IHNldAojIENPTkZJR19DUllQVE9fTFJXIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1BD
QkMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fWFRTIGlzIG5vdCBzZXQKIyBlbmQgb2YgTGVu
Z3RoLXByZXNlcnZpbmcgY2lwaGVycyBhbmQgbW9kZXMKCiMKIyBBRUFEIChhdXRoZW50aWNhdGVk
IGVuY3J5cHRpb24gd2l0aCBhc3NvY2lhdGVkIGRhdGEpIGNpcGhlcnMKIwojIENPTkZJR19DUllQ
VE9fQUVHSVMxMjggaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0hBQ0hBMjBQT0xZMTMwNSBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQ00gaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0dD
TT15CkNPTkZJR19DUllQVE9fR0VOSVY9bQpDT05GSUdfQ1JZUFRPX1NFUUlWPW0KQ09ORklHX0NS
WVBUT19FQ0hBSU5JVj1tCiMgQ09ORklHX0NSWVBUT19FU1NJViBpcyBub3Qgc2V0CiMgZW5kIG9m
IEFFQUQgKGF1dGhlbnRpY2F0ZWQgZW5jcnlwdGlvbiB3aXRoIGFzc29jaWF0ZWQgZGF0YSkgY2lw
aGVycwoKIwojIEhhc2hlcywgZGlnZXN0cywgYW5kIE1BQ3MKIwojIENPTkZJR19DUllQVE9fQkxB
S0UyQiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DTUFDIGlzIG5vdCBzZXQKQ09ORklHX0NS
WVBUT19HSEFTSD15CkNPTkZJR19DUllQVE9fSE1BQz15CiMgQ09ORklHX0NSWVBUT19NRDQgaXMg
bm90IHNldAojIENPTkZJR19DUllQVE9fTUQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX01J
Q0hBRUxfTUlDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1BPTFkxMzA1IGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX1JNRDE2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TSEExIGlz
IG5vdCBzZXQKQ09ORklHX0NSWVBUT19TSEEyNTY9eQpDT05GSUdfQ1JZUFRPX1NIQTUxMj1tCkNP
TkZJR19DUllQVE9fU0hBMz1tCiMgQ09ORklHX0NSWVBUT19TTTNfR0VORVJJQyBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19TVFJFRUJPRyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19WTUFD
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1dQNTEyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX1hDQkMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fWFhIQVNIIGlzIG5vdCBzZXQKIyBl
bmQgb2YgSGFzaGVzLCBkaWdlc3RzLCBhbmQgTUFDcwoKIwojIENSQ3MgKGN5Y2xpYyByZWR1bmRh
bmN5IGNoZWNrcykKIwpDT05GSUdfQ1JZUFRPX0NSQzMyQz15CiMgQ09ORklHX0NSWVBUT19DUkMz
MiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DUkNUMTBESUYgaXMgbm90IHNldAojIGVuZCBv
ZiBDUkNzIChjeWNsaWMgcmVkdW5kYW5jeSBjaGVja3MpCgojCiMgQ29tcHJlc3Npb24KIwojIENP
TkZJR19DUllQVE9fREVGTEFURSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MWk8gaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fODQyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xaNCBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MWjRIQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19aU1REIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ29tcHJlc3Npb24KCiMKIyBSYW5kb20gbnVtYmVy
IGdlbmVyYXRpb24KIwojIENPTkZJR19DUllQVE9fQU5TSV9DUFJORyBpcyBub3Qgc2V0CkNPTkZJ
R19DUllQVE9fRFJCR19NRU5VPW0KQ09ORklHX0NSWVBUT19EUkJHX0hNQUM9eQojIENPTkZJR19D
UllQVE9fRFJCR19IQVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RSQkdfQ1RSIGlzIG5v
dCBzZXQKQ09ORklHX0NSWVBUT19EUkJHPW0KQ09ORklHX0NSWVBUT19KSVRURVJFTlRST1BZPW0K
Q09ORklHX0NSWVBUT19KSVRURVJFTlRST1BZX01FTU9SWV9CTE9DS1M9NjQKQ09ORklHX0NSWVBU
T19KSVRURVJFTlRST1BZX01FTU9SWV9CTE9DS1NJWkU9MzIKQ09ORklHX0NSWVBUT19KSVRURVJF
TlRST1BZX09TUj0xCiMgZW5kIG9mIFJhbmRvbSBudW1iZXIgZ2VuZXJhdGlvbgoKIwojIFVzZXJz
cGFjZSBpbnRlcmZhY2UKIwojIENPTkZJR19DUllQVE9fVVNFUl9BUElfSEFTSCBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19VU0VSX0FQSV9TS0NJUEhFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19VU0VSX0FQSV9STkcgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVVNFUl9BUElfQUVB
RCBpcyBub3Qgc2V0CiMgZW5kIG9mIFVzZXJzcGFjZSBpbnRlcmZhY2UKCkNPTkZJR19DUllQVE9f
SFc9eQojIENPTkZJR19DUllQVE9fREVWX1FBVF9ESDg5NXhDQyBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19ERVZfUUFUX0MzWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRf
QzYyWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfUUFUXzRYWFggaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fREVWX1FBVF80MjBYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19E
RVZfUUFUX0RIODk1eENDVkYgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX1FBVF9DM1hY
WFZGIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRfQzYyWFZGIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX0RFVl9TQUZFWENFTCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19E
RVZfQU1MT0dJQ19HWEwgaXMgbm90IHNldAojIENPTkZJR19BU1lNTUVUUklDX0tFWV9UWVBFIGlz
IG5vdCBzZXQKCiMKIyBDZXJ0aWZpY2F0ZXMgZm9yIHNpZ25hdHVyZSBjaGVja2luZwojCiMgQ09O
RklHX1NZU1RFTV9CTEFDS0xJU1RfS0VZUklORyBpcyBub3Qgc2V0CiMgZW5kIG9mIENlcnRpZmlj
YXRlcyBmb3Igc2lnbmF0dXJlIGNoZWNraW5nCgojCiMgTGlicmFyeSByb3V0aW5lcwojCiMgQ09O
RklHX1BBQ0tJTkcgaXMgbm90IHNldApDT05GSUdfQklUUkVWRVJTRT15CkNPTkZJR19HRU5FUklD
X1NUUk5DUFlfRlJPTV9VU0VSPXkKQ09ORklHX0dFTkVSSUNfU1RSTkxFTl9VU0VSPXkKQ09ORklH
X0dFTkVSSUNfTkVUX1VUSUxTPXkKIyBDT05GSUdfQ09SRElDIGlzIG5vdCBzZXQKIyBDT05GSUdf
UFJJTUVfTlVNQkVSUyBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX1VTRV9DTVBYQ0hHX0xPQ0tSRUY9
eQoKIwojIENyeXB0byBsaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0NSWVBUT19MSUJfVVRJTFM9
eQpDT05GSUdfQ1JZUFRPX0xJQl9BRVM9eQpDT05GSUdfQ1JZUFRPX0xJQl9HRjEyOE1VTD15CkNP
TkZJR19DUllQVE9fTElCX0JMQUtFMlNfR0VORVJJQz15CiMgQ09ORklHX0NSWVBUT19MSUJfQ0hB
Q0hBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xJQl9DVVJWRTI1NTE5IGlzIG5vdCBzZXQK
Q09ORklHX0NSWVBUT19MSUJfUE9MWTEzMDVfUlNJWkU9MQojIENPTkZJR19DUllQVE9fTElCX1BP
TFkxMzA1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xJQl9DSEFDSEEyMFBPTFkxMzA1IGlz
IG5vdCBzZXQKQ09ORklHX0NSWVBUT19MSUJfU0hBMT15CkNPTkZJR19DUllQVE9fTElCX1NIQTI1
Nj15CiMgZW5kIG9mIENyeXB0byBsaWJyYXJ5IHJvdXRpbmVzCgojIENPTkZJR19DUkNfQ0NJVFQg
aXMgbm90IHNldApDT05GSUdfQ1JDMTY9eQojIENPTkZJR19DUkNfVDEwRElGIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JDNjRfUk9DS1NPRlQgaXMgbm90IHNldApDT05GSUdfQ1JDX0lUVV9UPXkKQ09O
RklHX0NSQzMyPXkKIyBDT05GSUdfQ1JDMzJfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfQ1JD
MzJfU0xJQ0VCWTg9eQojIENPTkZJR19DUkMzMl9TTElDRUJZNCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSQzMyX1NBUldBVEUgaXMgbm90IHNldAojIENPTkZJR19DUkMzMl9CSVQgaXMgbm90IHNldAoj
IENPTkZJR19DUkM2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzQgaXMgbm90IHNldAojIENPTkZJ
R19DUkM3IGlzIG5vdCBzZXQKIyBDT05GSUdfTElCQ1JDMzJDIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JDOCBpcyBub3Qgc2V0CiMgQ09ORklHX1JBTkRPTTMyX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09O
RklHX1pMSUJfSU5GTEFURT15CiMgQ09ORklHX1haX0RFQyBpcyBub3Qgc2V0CkNPTkZJR19HRU5F
UklDX0FMTE9DQVRPUj15CkNPTkZJR19BU1NPQ0lBVElWRV9BUlJBWT15CkNPTkZJR19IQVNfSU9N
RU09eQpDT05GSUdfSEFTX0lPUE9SVD15CkNPTkZJR19IQVNfSU9QT1JUX01BUD15CkNPTkZJR19I
QVNfRE1BPXkKQ09ORklHX0RNQV9PUFNfSEVMUEVSUz15CkNPTkZJR19ORUVEX1NHX0RNQV9MRU5H
VEg9eQpDT05GSUdfTkVFRF9ETUFfTUFQX1NUQVRFPXkKQ09ORklHX0FSQ0hfRE1BX0FERFJfVF82
NEJJVD15CkNPTkZJR19ETUFfTkVFRF9TWU5DPXkKIyBDT05GSUdfRE1BX0FQSV9ERUJVRyBpcyBu
b3Qgc2V0CkNPTkZJR19TR0xfQUxMT0M9eQpDT05GSUdfRk9SQ0VfTlJfQ1BVUz15CkNPTkZJR19E
UUw9eQpDT05GSUdfR0xPQj15CiMgQ09ORklHX0dMT0JfU0VMRlRFU1QgaXMgbm90IHNldApDT05G
SUdfTkxBVFRSPXkKIyBDT05GSUdfSVJRX1BPTEwgaXMgbm90IHNldApDT05GSUdfRElNTElCPXkK
Q09ORklHX09JRF9SRUdJU1RSWT1tCkNPTkZJR19GT05UX1NVUFBPUlQ9eQojIENPTkZJR19GT05U
UyBpcyBub3Qgc2V0CkNPTkZJR19GT05UXzh4OD15CkNPTkZJR19GT05UXzh4MTY9eQpDT05GSUdf
U0dfUE9PTD15CkNPTkZJR19BUkNIX05PX1NHX0NIQUlOPXkKQ09ORklHX1NCSVRNQVA9eQojIENP
TkZJR19MV1FfVEVTVCBpcyBub3Qgc2V0CiMgZW5kIG9mIExpYnJhcnkgcm91dGluZXMKCiMKIyBL
ZXJuZWwgaGFja2luZwojCgojCiMgcHJpbnRrIGFuZCBkbWVzZyBvcHRpb25zCiMKIyBDT05GSUdf
UFJJTlRLX1RJTUUgaXMgbm90IHNldAojIENPTkZJR19QUklOVEtfQ0FMTEVSIGlzIG5vdCBzZXQK
IyBDT05GSUdfU1RBQ0tUUkFDRV9CVUlMRF9JRCBpcyBub3Qgc2V0CkNPTkZJR19DT05TT0xFX0xP
R0xFVkVMX0RFRkFVTFQ9NwpDT05GSUdfQ09OU09MRV9MT0dMRVZFTF9RVUlFVD00CkNPTkZJR19N
RVNTQUdFX0xPR0xFVkVMX0RFRkFVTFQ9NAojIENPTkZJR19CT09UX1BSSU5US19ERUxBWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RZTkFNSUNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19EWU5BTUlD
X0RFQlVHX0NPUkUgaXMgbm90IHNldApDT05GSUdfU1lNQk9MSUNfRVJSTkFNRT15CiMgZW5kIG9m
IHByaW50ayBhbmQgZG1lc2cgb3B0aW9ucwoKQ09ORklHX0RFQlVHX0tFUk5FTD15CkNPTkZJR19E
RUJVR19NSVNDPXkKCiMKIyBDb21waWxlLXRpbWUgY2hlY2tzIGFuZCBjb21waWxlciBvcHRpb25z
CiMKQ09ORklHX0RFQlVHX0lORk89eQpDT05GSUdfQVNfSEFTX05PTl9DT05TVF9VTEVCMTI4PXkK
IyBDT05GSUdfREVCVUdfSU5GT19OT05FIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0lORk9fRFdB
UkZfVE9PTENIQUlOX0RFRkFVTFQ9eQojIENPTkZJR19ERUJVR19JTkZPX0RXQVJGNCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RFQlVHX0lORk9fRFdBUkY1IGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
SU5GT19SRURVQ0VEIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0lORk9fQ09NUFJFU1NFRF9OT05F
PXkKQ09ORklHX1BBSE9MRV9IQVNfU1BMSVRfQlRGPXkKQ09ORklHX1BBSE9MRV9IQVNfTEFOR19F
WENMVURFPXkKIyBDT05GSUdfR0RCX1NDUklQVFMgaXMgbm90IHNldApDT05GSUdfRlJBTUVfV0FS
Tj0yMDQ4CiMgQ09ORklHX1NUUklQX0FTTV9TWU1TIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVBREFC
TEVfQVNNIGlzIG5vdCBzZXQKIyBDT05GSUdfSEVBREVSU19JTlNUQUxMIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVCVUdfU0VDVElPTl9NSVNNQVRDSCBpcyBub3Qgc2V0CkNPTkZJR19TRUNUSU9OX01J
U01BVENIX1dBUk5fT05MWT15CiMgQ09ORklHX0RFQlVHX0ZPUkNFX1dFQUtfUEVSX0NQVSBpcyBu
b3Qgc2V0CiMgZW5kIG9mIENvbXBpbGUtdGltZSBjaGVja3MgYW5kIGNvbXBpbGVyIG9wdGlvbnMK
CiMKIyBHZW5lcmljIEtlcm5lbCBEZWJ1Z2dpbmcgSW5zdHJ1bWVudHMKIwpDT05GSUdfTUFHSUNf
U1lTUlE9eQpDT05GSUdfTUFHSUNfU1lTUlFfREVGQVVMVF9FTkFCTEU9MHgxCkNPTkZJR19NQUdJ
Q19TWVNSUV9TRVJJQUw9eQpDT05GSUdfTUFHSUNfU1lTUlFfU0VSSUFMX1NFUVVFTkNFPSIiCiMg
Q09ORklHX0RFQlVHX0ZTIGlzIG5vdCBzZXQKIyBlbmQgb2YgR2VuZXJpYyBLZXJuZWwgRGVidWdn
aW5nIEluc3RydW1lbnRzCgojCiMgTmV0d29ya2luZyBEZWJ1Z2dpbmcKIwojIENPTkZJR19ERUJV
R19ORVQgaXMgbm90IHNldAojIGVuZCBvZiBOZXR3b3JraW5nIERlYnVnZ2luZwoKIwojIE1lbW9y
eSBEZWJ1Z2dpbmcKIwojIENPTkZJR19QQUdFX0VYVEVOU0lPTiBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFQlVHX1BBR0VBTExPQyBpcyBub3Qgc2V0CkNPTkZJR19TTFVCX0RFQlVHPXkKIyBDT05GSUdf
U0xVQl9ERUJVR19PTiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBR0VfUE9JU09OSU5HIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREVCVUdfT0JKRUNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NUQUNL
X1VTQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NIRURfU1RBQ0tfRU5EX0NIRUNLIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREVCVUdfVk0gaXMgbm90IHNldApDT05GSUdfREVCVUdfTUVNT1JZX0lOSVQ9
eQojIENPTkZJR19NRU1fQUxMT0NfUFJPRklMSU5HIGlzIG5vdCBzZXQKQ09ORklHX0NDX0hBU19X
T1JLSU5HX05PU0FOSVRJWkVfQUREUkVTUz15CiMgZW5kIG9mIE1lbW9yeSBEZWJ1Z2dpbmcKCiMg
Q09ORklHX0RFQlVHX1NISVJRIGlzIG5vdCBzZXQKCiMKIyBEZWJ1ZyBPb3BzLCBMb2NrdXBzIGFu
ZCBIYW5ncwojCiMgQ09ORklHX1BBTklDX09OX09PUFMgaXMgbm90IHNldApDT05GSUdfUEFOSUNf
T05fT09QU19WQUxVRT0wCkNPTkZJR19QQU5JQ19USU1FT1VUPTAKIyBDT05GSUdfU09GVExPQ0tV
UF9ERVRFQ1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFVEVDVF9IVU5HX1RBU0sgaXMgbm90IHNl
dAojIENPTkZJR19XUV9XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX1dRX0NQVV9JTlRFTlNJ
VkVfUkVQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9MT0NLVVAgaXMgbm90IHNldAojIGVu
ZCBvZiBEZWJ1ZyBPb3BzLCBMb2NrdXBzIGFuZCBIYW5ncwoKIwojIFNjaGVkdWxlciBEZWJ1Z2dp
bmcKIwojIENPTkZJR19TQ0hFRFNUQVRTIGlzIG5vdCBzZXQKIyBlbmQgb2YgU2NoZWR1bGVyIERl
YnVnZ2luZwoKIwojIExvY2sgRGVidWdnaW5nIChzcGlubG9ja3MsIG11dGV4ZXMsIGV0Yy4uLikK
IwojIENPTkZJR19ERUJVR19SVF9NVVRFWEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU1BJ
TkxPQ0sgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19NVVRFWEVTIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfUldTRU1TIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTE9DS0lOR19BUElfU0VM
RlRFU1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfTE9DS19UT1JUVVJFX1RFU1QgaXMgbm90IHNldAoj
IENPTkZJR19XV19NVVRFWF9TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDRl9UT1JUVVJF
X1RFU1QgaXMgbm90IHNldAojIGVuZCBvZiBMb2NrIERlYnVnZ2luZyAoc3BpbmxvY2tzLCBtdXRl
eGVzLCBldGMuLi4pCgojIENPTkZJR19ERUJVR19JUlFGTEFHUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1dBUk5fQUxMX1VOU0VFREVEX1JBTkRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0tPQkpF
Q1QgaXMgbm90IHNldAoKIwojIERlYnVnIGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMKIwojIENPTkZJ
R19ERUJVR19MSVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUExJU1QgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19TRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX05PVElGSUVSUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFQlVHX01BUExFX1RSRUUgaXMgbm90IHNldAojIGVuZCBvZiBEZWJ1
ZyBrZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzCgojCiMgUkNVIERlYnVnZ2luZwojCiMgQ09ORklHX1JD
VV9TQ0FMRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNVX1RPUlRVUkVfVEVTVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1JDVV9SRUZfU0NBTEVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9U
UkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9FUVNfREVCVUcgaXMgbm90IHNldAojIGVuZCBv
ZiBSQ1UgRGVidWdnaW5nCgojIENPTkZJR19ERUJVR19XUV9GT1JDRV9SUl9DUFUgaXMgbm90IHNl
dAojIENPTkZJR19TQU1QTEVTIGlzIG5vdCBzZXQKCiMKIyBhbHBoYSBEZWJ1Z2dpbmcKIwpDT05G
SUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX0FMUEhBX0xFR0FDWV9TVEFSVF9BRERSRVNTPXkKQ09O
RklHX01BVEhFTVU9eQojIGVuZCBvZiBhbHBoYSBEZWJ1Z2dpbmcKCiMKIyBLZXJuZWwgVGVzdGlu
ZyBhbmQgQ292ZXJhZ2UKIwojIENPTkZJR19LVU5JVCBpcyBub3Qgc2V0CiMgQ09ORklHX05PVElG
SUVSX0VSUk9SX0lOSkVDVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZBVUxUX0lOSkVDVElPTiBp
cyBub3Qgc2V0CkNPTkZJR19SVU5USU1FX1RFU1RJTkdfTUVOVT15CiMgQ09ORklHX1RFU1RfREhS
WSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfTUlOX0hFQVAgaXMgbm90IHNldAojIENPTkZJR19U
RVNUX0RJVjY0IGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9NVUxESVY2NCBpcyBub3Qgc2V0CiMg
Q09ORklHX0JBQ0tUUkFDRV9TRUxGX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19SQlRSRUVfVEVT
VCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFRURfU09MT01PTl9URVNUIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5URVJWQUxfVFJFRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUEVSQ1BVX1RFU1QgaXMg
bm90IHNldAojIENPTkZJR19BVE9NSUM2NF9TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RF
U1RfSEVYRFVNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfS1NUUlRPWCBpcyBub3Qgc2V0CiMg
Q09ORklHX1RFU1RfUFJJTlRGIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9TQ0FORiBpcyBub3Qg
c2V0CiMgQ09ORklHX1RFU1RfQklUTUFQIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9VVUlEIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEVTVF9YQVJSQVkgaXMgbm90IHNldAojIENPTkZJR19URVNUX01B
UExFX1RSRUUgaXMgbm90IHNldAojIENPTkZJR19URVNUX1JIQVNIVEFCTEUgaXMgbm90IHNldAoj
IENPTkZJR19URVNUX0lEQSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfTEtNIGlzIG5vdCBzZXQK
IyBDT05GSUdfVEVTVF9CSVRPUFMgaXMgbm90IHNldAojIENPTkZJR19URVNUX1ZNQUxMT0MgaXMg
bm90IHNldAojIENPTkZJR19URVNUX0JQRiBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfQkxBQ0tI
T0xFX0RFViBpcyBub3Qgc2V0CiMgQ09ORklHX0ZJTkRfQklUX0JFTkNITUFSSyBpcyBub3Qgc2V0
CiMgQ09ORklHX1RFU1RfRklSTVdBUkUgaXMgbm90IHNldAojIENPTkZJR19URVNUX1NZU0NUTCBp
cyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfVURFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9T
VEFUSUNfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfS01PRCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RFU1RfTUVNQ0FUX1AgaXMgbm90IHNldAojIENPTkZJR19URVNUX01FTUlOSVQgaXMgbm90
IHNldAojIENPTkZJR19URVNUX0ZSRUVfUEFHRVMgaXMgbm90IHNldAojIENPTkZJR19URVNUX09C
SlBPT0wgaXMgbm90IHNldAojIGVuZCBvZiBLZXJuZWwgVGVzdGluZyBhbmQgQ292ZXJhZ2UKCiMK
IyBSdXN0IGhhY2tpbmcKIwojIGVuZCBvZiBSdXN0IGhhY2tpbmcKIyBlbmQgb2YgS2VybmVsIGhh
Y2tpbmcK
--=_79d7279178f2b1a21b4c1e64c97a9c50--

