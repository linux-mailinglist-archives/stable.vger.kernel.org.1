Return-Path: <stable+bounces-152323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65584AD423E
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 20:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D2817D78A
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376BC2494F5;
	Tue, 10 Jun 2025 18:51:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from constellation.wizardsworks.org (wizardsworks.org [24.234.38.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39EC248F73;
	Tue, 10 Jun 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.234.38.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581506; cv=none; b=iaf91ihnzgxHSecnMZ8LkUaWxN7AGt/Wr5m7QkFSLhhoriemTdNXgsV5xqwogAZUiYNB9WzwqXU4mSo3qMWvmhTJZGWzT9H4roGC6qMQ+Vh3XkGUPIujNhOxmA8JSywUf55qh8S14D+SdRLty3XEXzRY7tDjnSz9iKkxDm30PTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581506; c=relaxed/simple;
	bh=kkBnKdtcGib5Pt8puNdpG+R7rOnu2/QGnpy7xh8y1q0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=D6KH4MDTL7Pb8qBE0U3Wt3kDSltdu0rTMT38Z9WxT21Yo7mRmjVgFhmbPgpiSKBUcvbgPknd94IPdqodOsoO2lBBnDiV2DUW62B33meFDGMUM7+/zSzAnt77CEa0xTPmCG1GDwgDW6xPt98pTnfTouAkqKVbuYwf2dEQWohfGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org; spf=pass smtp.mailfrom=wizardsworks.org; arc=none smtp.client-ip=24.234.38.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizardsworks.org
Received: from mail.wizardsworks.org (localhost [127.0.0.1])
	by constellation.wizardsworks.org (8.18.1/8.18.1) with ESMTP id 55AIraMY001192;
	Tue, 10 Jun 2025 11:53:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Jun 2025 11:53:36 -0700
From: Greg Chandler <chandleg@wizardsworks.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
Message-ID: <385f2469f504dd293775d3c39affa979@wizardsworks.org>
X-Sender: chandleg@wizardsworks.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit



I decided to test this again before I got sidetracked on my bigger 
issue.
The kernel I repored this on was 6.12.12 on alpha, this is also that 
same version, but with a make distclean, and just about every single 
debug option turned on.

I left the last line of the kernel boot in this output as well, showing 
"link beat good"

I pulled the plug and it happened again immediately.
I waited 10 sec, and plugged it back in, and I do not get a "link up" 
type message that I would expect to see.

This should have popped up between:
[ 1088.732841] ---[ end trace 0000000000000000 ]---

     and this one:
[ 1133.693755] ------------[ cut here ]------------



I waited for the switch to negotiate, which it only does at 10 half for 
this.
I waited a few seconds more and pulled the plug again and got the second 
one:



[   18.469717] net eth2: 21143 10baseT link beat good
[ 1088.732841] ------------[ cut here ]------------
[ 1088.732841] WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1657 
__timer_delete_sync+0x104/0x120
[ 1088.732841] Modules linked in: loop
[ 1088.732841] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.12 #4
[ 1088.732841]        fffffc0000c83ab0 fffffc0000388c94 fffffc0000326744 
fffffc0000afbee8
[ 1088.732841]        0000000000000000 fffffc0000388c94 fffffc00009e0d70 
0000000000000000
[ 1088.732841]        fffffc0000afbee8 0000000000000679 fffffc0000388c94 
0000000000000009
[ 1088.732841]        fffffc0000cf9100 000000011f821600 fffffc0000388c94 
0000000000000000
[ 1088.732841]        fffffc00020e6000 fffffc00020e73d0 fffffffff0669000 
fffffd000a120000
[ 1088.732841]        fffffc0000358f10 fffffc000203e180 0000000000000008 
fffffc000203e6b0
[ 1088.732841] Trace:
[ 1088.732841] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[ 1088.732841] [<fffffc0000326744>] __warn+0x194/0x1a0
[ 1088.732841] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[ 1088.732841] [<fffffc00009e0d70>] warn_slowpath_fmt+0x84/0xf0
[ 1088.732841] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[ 1088.732841] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[ 1088.732841] [<fffffc0000358f10>] try_to_wake_up+0x170/0x2d0
[ 1088.732841] [<fffffc0000358bb8>] wakeup_preempt+0x68/0xd0
[ 1088.732841] [<fffffc0000919a2c>] tcp_orphan_update+0x6c/0x90
[ 1088.732841] [<fffffc000038be64>] timekeeping_update+0xd4/0x290
[ 1088.732841] [<fffffc0000780fdc>] t21142_lnk_change+0x1bc/0x790
[ 1088.732841] [<fffffc000077a890>] tulip_interrupt+0x280/0xac0
[ 1088.732841] [<fffffc0000372b90>] __handle_irq_event_percpu+0x60/0x180
[ 1088.732841] [<fffffc0000372d30>] handle_irq_event_percpu+0x80/0xa0
[ 1088.732841] [<fffffc0000372d98>] handle_irq_event+0x48/0xe0
[ 1088.732841] [<fffffc0000377af0>] handle_level_irq+0xc0/0x1f0
[ 1088.732841] [<fffffc0000315300>] handle_irq+0x70/0xe0
[ 1088.732841] [<fffffc000031d6c0>] dp264_srm_device_interrupt+0x30/0x50
[ 1088.732841] [<fffffc00003153dc>] do_entInt+0x6c/0x1c0
[ 1088.732841] [<fffffc0000310cc0>] ret_from_sys_call+0x0/0x10
[ 1088.732841] [<fffffc000035c69c>] pick_task_fair+0x3c/0x100
[ 1088.732841] [<fffffc000035d89c>] task_non_contending+0x6c/0x2a0
[ 1088.732841] [<fffffc000035fc28>] do_idle+0x58/0x190
[ 1088.732841] [<fffffc00009eda20>] cpu_idle_poll.isra.0+0x0/0x60
[ 1088.732841] [<fffffc00009eda60>] cpu_idle_poll.isra.0+0x40/0x60
[ 1088.732841] [<fffffc0000360058>] cpu_startup_entry+0x38/0x50
[ 1088.732841] [<fffffc00009edbc8>] rest_init+0xe8/0xec
[ 1088.732841] [<fffffc000031001c>] _stext+0x1c/0x20

[ 1088.732841] ---[ end trace 0000000000000000 ]---
[ 1133.693755] ------------[ cut here ]------------
[ 1133.693755] WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1657 
__timer_delete_sync+0x104/0x120
[ 1133.693755] Modules linked in: loop
[ 1133.693755] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G        W    
       6.12.12 #4
[ 1133.693755] Tainted: [W]=WARN
[ 1133.693755]        fffffc0000c83ab0 fffffc0000388c94 fffffc0000326744 
fffffc0000afbee8
[ 1133.693755]        0000000000000000 fffffc0000388c94 fffffc00009e0d70 
0000000000000000
[ 1133.693755]        fffffc0000afbee8 0000000000000679 fffffc0000388c94 
0000000000000009
[ 1133.693755]        fffffc0000cf9100 000000011f821600 fffffc0000388c94 
0000000000000000
[ 1133.693755]        fffffc00020e6000 fffffc00020e73d0 fffffffff8668000 
fffffd000a120000
[ 1133.693755]        fffffc0000358f10 fffffc000203e180 0000000000000008 
fffffc000203e6b0
[ 1133.693755] Trace:
[ 1133.693755] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[ 1133.693755] [<fffffc0000326744>] __warn+0x194/0x1a0
[ 1133.693755] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[ 1133.693755] [<fffffc00009e0d70>] warn_slowpath_fmt+0x84/0xf0
[ 1133.693755] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[ 1133.693755] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[ 1133.693755] [<fffffc0000358f10>] try_to_wake_up+0x170/0x2d0
[ 1133.693755] [<fffffc0000358bb8>] wakeup_preempt+0x68/0xd0
[ 1133.693755] [<fffffc0000919a2c>] tcp_orphan_update+0x6c/0x90
[ 1133.693755] [<fffffc000038be64>] timekeeping_update+0xd4/0x290
[ 1133.693755] [<fffffc0000780fdc>] t21142_lnk_change+0x1bc/0x790
[ 1133.693755] [<fffffc000077a890>] tulip_interrupt+0x280/0xac0
[ 1133.693755] [<fffffc0000372b90>] __handle_irq_event_percpu+0x60/0x180
[ 1133.693755] [<fffffc0000372d30>] handle_irq_event_percpu+0x80/0xa0
[ 1133.693755] [<fffffc0000372d98>] handle_irq_event+0x48/0xe0
[ 1133.693755] [<fffffc0000377af0>] handle_level_irq+0xc0/0x1f0
[ 1133.693755] [<fffffc0000315300>] handle_irq+0x70/0xe0
[ 1133.693755] [<fffffc000031d6c0>] dp264_srm_device_interrupt+0x30/0x50
[ 1133.693755] [<fffffc00003153dc>] do_entInt+0x6c/0x1c0
[ 1133.693755] [<fffffc0000310cc0>] ret_from_sys_call+0x0/0x10
[ 1133.693755] [<fffffc000035c69c>] pick_task_fair+0x3c/0x100
[ 1133.693755] [<fffffc000035d89c>] task_non_contending+0x6c/0x2a0
[ 1133.693755] [<fffffc000035fc28>] do_idle+0x58/0x190
[ 1133.693755] [<fffffc00009eda20>] cpu_idle_poll.isra.0+0x0/0x60
[ 1133.693755] [<fffffc00009eda50>] cpu_idle_poll.isra.0+0x30/0x60
[ 1133.693755] [<fffffc0000360058>] cpu_startup_entry+0x38/0x50
[ 1133.693755] [<fffffc00009edbc8>] rest_init+0xe8/0xec
[ 1133.693755] [<fffffc000031001c>] _stext+0x1c/0x20

[ 1133.693755] ---[ end trace 0000000000000000 ]---




After this, even though the link is shown at the switch mii-tool 
confirms:
root@bigbang:~# mii-tool eth2
eth2: no link


Which I think leans towards it not showing the link up message.  I think 
the driver croaked which is a pain as it's not a module.  I can 
recompile to test that if someone thinks that would be helpful.

root@bigbang:~# dmesg |grep eth
[    8.150386] net eth0: Digital DS21142/43 Tulip rev 65 at Port 0x8400, 
08:00:2b:86:ab:b1, IRQ 29
[    8.170894] net eth1: Digital DS21142/43 Tulip rev 65 at Port 0x8480, 
08:00:2b:86:a8:5b, IRQ 30
[    8.809565] e1000 0000:00:10.0 eth2: (PCI:33MHz:64-bit) 
00:02:b3:f3:e6:3d
[    8.811518] e1000 0000:00:10.0 eth2: Intel(R) PRO/1000 Network 
Connection
[    8.813472] usbcore: registered new interface driver kaweth
[   25.848619] tulip 0000:00:09.0 eth126: renamed from eth0
[   26.400377] tulip 0000:00:09.0 rename_eth126: renamed from eth126
[   26.861314] e1000 0000:00:10.0 eth124: renamed from eth2
[   26.887681] e1000 0000:00:10.0 eth0: renamed from eth124
[   27.122056] tulip 0000:00:09.0 eth2: renamed from rename_eth126
[   68.313441] tulip 0000:00:0b.0 eth1: tulip_stop_rxtx() failed (CSR5 
0xf0660000 CSR6 0xb3862002)
[   68.791956] tulip 0000:00:09.0 eth2: tulip_stop_rxtx() failed (CSR5 
0xf0660000 CSR6 0xb3862002)

root@bigbang:~# mii-tool eth2
eth2: no link

root@bigbang:~# mii-tool eth1
eth1: no link

root@bigbang:~# ifconfig -a
eth0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
         inet 192.168.1.75  netmask 255.255.255.0  broadcast 
192.168.1.255
         ether 00:02:b3:f3:e6:3d  txqueuelen 1000  (Ethernet)
         RX packets 0  bytes 0 (0.0 B)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 0  bytes 0 (0.0 B)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 192.168.1.76  netmask 255.255.255.0  broadcast 
192.168.1.255
         inet6 fe80::a00:2bff:fe86:a85b  prefixlen 64  scopeid 0x20<link>
         ether 08:00:2b:86:a8:5b  txqueuelen 1000  (Ethernet)
         RX packets 0  bytes 0 (0.0 B)
         RX errors 11  dropped 0  overruns 0  frame 0
         TX packets 0  bytes 0 (0.0 B)
         TX errors 5  dropped 0 overruns 0  carrier 15  collisions 0

eth2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 192.168.1.77  netmask 255.255.255.0  broadcast 
192.168.1.255
         inet6 fe80::a00:2bff:fe86:abb1  prefixlen 64  scopeid 0x20<link>
         ether 08:00:2b:86:ab:b1  txqueuelen 1000  (Ethernet)
         RX packets 0  bytes 0 (0.0 B)
         RX errors 11  dropped 0  overruns 0  frame 0
         TX packets 0  bytes 0 (0.0 B)
         TX errors 5  dropped 0 overruns 0  carrier 15  collisions 0


Clearly the interface doesn't work at all, which I hadn't noticed up 
until now.  I have been using a USB stick to copy stuff, and a serial 
console for everything else.

I took a quick look at the motherboard and these are Intel 21143-TD 
chips vs DEC ones.

I had not noticed the "tulip_stop_rxtx" errors until now, more likely 
becuase I wasn't looking for them, vs them not being there.








On 2025/06/10 09:27, Florian Fainelli wrote:
> Howdy!
> 
> On 6/9/25 15:43, Greg Chandler wrote:
>> 
>> This is a from-scratch build (non-vendor/non-distribution)
>> Host/Target = alpha ev6
>> Kernel source = 6.12.12
>> 
>> My last working kernel on this was a 2.6.x, it's been a while since 
>> I've had time to bring this system up to date, so I don't know when 
>> this may have started.
>> I had a 3.0.102 in there, but I didn't test the networking while using 
>> it.
>> 
>> Please let me know what I can do to help out with figuring this one 
>> out.
> 
> I don't have an Alpha machine to try this on, but I do have a 
> functional Cobalt Qube2 (MIPS 32/64) with these adapters connected 
> directly over PCI:
> 
> 00:07.0 Ethernet controller: Digital Equipment Corporation DECchip 
> 21142/43 (rev 41)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr+ Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 32 
> bytes
>         Interrupt: pin A routed to IRQ 19
>         Region 0: I/O ports at 1000 [size=128]
>         Region 1: Memory at 12082000 (32-bit, non-prefetchable) 
> [size=1K]
>         Expansion ROM at 12000000 [disabled] [size=256K]
>         Kernel driver in use: tulip
> 
> 
> 00:0c.0 Ethernet controller: Digital Equipment Corporation DECchip 
> 21142/43 (rev 41)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 32 
> bytes
>         Interrupt: pin A routed to IRQ 20
>         Region 0: I/O ports at 1080 [size=128]
>         Region 1: Memory at 12082400 (32-bit, non-prefetchable) 
> [size=1K]
>         Expansion ROM at 12040000 [disabled] [size=256K]
>         Kernel driver in use: tulip
> 
> the machine is not currently on a switch that I can control, but I can 
> certainly try to plug in the cable and see what happens, give me a 
> couple of days to get back to you, and if you don't hear back,  please 
> holler. Here are the bits of kernel configuration:
> 
> CONFIG_NET_TULIP=y
> CONFIG_TULIP=y
> # CONFIG_TULIP_MWI is not set
> # CONFIG_TULIP_MMIO is not set
> # CONFIG_TULIP_NAPI is not set


