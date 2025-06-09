Return-Path: <stable+bounces-152187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822D1AD29A6
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 00:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B613ACEEE
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467D225414;
	Mon,  9 Jun 2025 22:49:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from constellation.wizardsworks.org (wizardsworks.org [24.234.38.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD1223DC4;
	Mon,  9 Jun 2025 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.234.38.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509381; cv=none; b=RQji8jsSw3KyV/6ygW8skW+PlsOInr3bCJcnK5ObYELvu1iNtB9puN/LBsE5sFKXFt6Oc3kzoddksJ1FDa3olK8dMNXN5fn6P+EXiCuq4TJYJ+xxeRp8vPLyT9846ROW27AlXSOWz5pPqdW+rxTv+WrMPp8l9XufJeXFAEPy1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509381; c=relaxed/simple;
	bh=zcdeKXN994Bd8yruC0RcAhSYMctgBLtKrGhSPKsusLg=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=D46BfB/rWSbLiYKuFfXxmHYWZyiAxiW81dhD3fGW3QdAZRrxfuYgihC9FrWH+F2Y3a70FAFnSbBQB7Q4HB5ZyDyu8mFlFB8sRn941JN06ZNjhGA+YUvpJAD3qBAzLhO69fhrb3sIdMdpjEa8KQrp0SByuYVUerSUEObyGju0Wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org; spf=pass smtp.mailfrom=wizardsworks.org; arc=none smtp.client-ip=24.234.38.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizardsworks.org
Received: from mail.wizardsworks.org (localhost [127.0.0.1])
	by constellation.wizardsworks.org (8.18.1/8.18.1) with ESMTP id 559Mhfgg001683;
	Mon, 9 Jun 2025 15:43:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Jun 2025 15:43:41 -0700
From: Greg Chandler <chandleg@wizardsworks.org>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: Tulip 21142 panic on physical link disconnect
Message-ID: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
X-Sender: chandleg@wizardsworks.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit


This is a from-scratch build (non-vendor/non-distribution)
Host/Target = alpha ev6
Kernel source = 6.12.12

My last working kernel on this was a 2.6.x, it's been a while since I've 
had time to bring this system up to date, so I don't know when this may 
have started.
I had a 3.0.102 in there, but I didn't test the networking while using 
it.

Please let me know what I can do to help out with figuring this one out.


The kernel output:
[    0.692382] net eth0: Digital DS21142/43 Tulip rev 65 at MMIO 
0xa120000, 08:00:2b:86:ab:b1, IRQ 29
[    0.710937] net eth1: Digital DS21142/43 Tulip rev 65 at MMIO 
0xa121000, 08:00:2b:86:a8:5b, IRQ 30
[    0.989257] e1000 0000:00:10.0 eth2: (PCI:33MHz:64-bit) 
00:02:b3:f3:e6:3d
[    0.990233] e1000 0000:00:10.0 eth2: Intel(R) PRO/1000 Network 
Connection
[    6.088864] tulip 0000:00:09.0 eth126: renamed from eth0
[    6.103512] tulip 0000:00:09.0 rename_eth126: renamed from eth126
[    6.164059] e1000 0000:00:10.0 eth124: renamed from eth2
[    6.172848] e1000 0000:00:10.0 eth0: renamed from eth124
[    6.207028] tulip 0000:00:09.0 eth2: renamed from rename_eth126
[   18.957998] net eth2: Using user-specified media 10baseT-FDX
[   19.082021] net eth2: 21143 10baseT link beat good


I attempted to set the interface to 100MB/FDX with mii-tool but didn't 
seem to be having any luck, so I disconnected the cord, and it dropped 
this immediately:

[  195.170798] ------------[ cut here ]------------
[  195.170798] WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1657 
__timer_delete_sync+0x104/0x120
[  195.170798] Modules linked in: loop
[  195.170798] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.12 #4
[  195.170798]        fffffc0000c83ab0 fffffc0000388c94 fffffc0000326744 
fffffc0000afbee8
[  195.170798]        0000000000000000 fffffc0000388c94 fffffc00009e0d70 
0000000000000000
[  195.170798]        fffffc0000afbee8 0000000000000679 fffffc0000388c94 
0000000000000009
[  195.170798]        fffffc0000cf9100 0000000000000000 fffffc0000388c94 
0000000000000000
[  195.170798]        fffffc00020e6000 fffffc00020e73d0 fffffffff0669000 
fffffd000a120000
[  195.170798]        fffffc00007cff70 fffffc00024b5c00 0000000000000000 
0000000000000122
[  195.170798] Trace:
[  195.170798] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[  195.170798] [<fffffc0000326744>] __warn+0x194/0x1a0
[  195.170798] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[  195.170798] [<fffffc00009e0d70>] warn_slowpath_fmt+0x84/0xf0
[  195.170798] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[  195.170798] [<fffffc0000388c94>] __timer_delete_sync+0x104/0x120
[  195.170798] [<fffffc00007cff70>] usb_hcd_poll_rh_status+0x140/0x1a0
[  195.170798] [<fffffc0000919a2c>] tcp_orphan_update+0x6c/0x90
[  195.170798] [<fffffc000038be64>] timekeeping_update+0xd4/0x290
[  195.170798] [<fffffc0000780fdc>] t21142_lnk_change+0x1bc/0x790
[  195.170798] [<fffffc000077a890>] tulip_interrupt+0x280/0xac0
[  195.170798] [<fffffc0000372b90>] __handle_irq_event_percpu+0x60/0x180
[  195.170798] [<fffffc0000372d30>] handle_irq_event_percpu+0x80/0xa0
[  195.170798] [<fffffc0000372d98>] handle_irq_event+0x48/0xe0
[  195.170798] [<fffffc0000377af0>] handle_level_irq+0xc0/0x1f0
[  195.170798] [<fffffc0000315300>] handle_irq+0x70/0xe0
[  195.170798] [<fffffc000031d6c0>] dp264_srm_device_interrupt+0x30/0x50
[  195.170798] [<fffffc00003153dc>] do_entInt+0x6c/0x1c0
[  195.170798] [<fffffc0000310cc0>] ret_from_sys_call+0x0/0x10
[  195.170798] [<fffffc000035c69c>] pick_task_fair+0x3c/0x100
[  195.170798] [<fffffc000035d89c>] task_non_contending+0x6c/0x2a0
[  195.170798] [<fffffc000035fc28>] do_idle+0x58/0x190
[  195.170798] [<fffffc00009eda20>] cpu_idle_poll.isra.0+0x0/0x60
[  195.170798] [<fffffc00009eda50>] cpu_idle_poll.isra.0+0x30/0x60
[  195.170798] [<fffffc0000360058>] cpu_startup_entry+0x38/0x50
[  195.170798] [<fffffc00009edbc8>] rest_init+0xe8/0xec
[  195.170798] [<fffffc000031001c>] _stext+0x1c/0x20
[  195.170798] [<fffffc0000312460>] common_shutdown_1+0x0/0x150

[  195.170798] ---[ end trace 0000000000000000 ]---


Kernel options that may be relevant:
CONFIG_ALPHA_DP264=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y


Device info:
root@bigbang:~# lspci -vvv |more
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

