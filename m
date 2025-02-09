Return-Path: <stable+bounces-114429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1527CA2DC7E
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 11:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A3C1887610
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 10:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDC015F41F;
	Sun,  9 Feb 2025 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="bmyXYyXt"
X-Original-To: stable@vger.kernel.org
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FB13DDB9;
	Sun,  9 Feb 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096957; cv=none; b=QS1TY7ItanhVRlxd0bLg/OFxp3lC5iT0B6fZ1MOUiZ1mUl/h3y27rXQyyfipe3W0DFbWGYyQ8U6R0Yg66PxD1QKzcjwmFdyhG6Pr2ONHm9aD95l2UV1X1dvy1647X89JgQ8e68vnNdp0eZVFFVraTFWZ4xg3ltcbcl/odfpPmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096957; c=relaxed/simple;
	bh=pZJYWTi+Aymw8sCXm2t1RPSaapaHEkwN4a8cGdKKvvQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MYoeXOWEfs1vtwLNe9Yx+X2pQKWmPCu/paPKKsMPQeP5FKL33su86ewZ3S7koN34aXcSGFXqfH+DSafy7VPOW/3uIWOM1JtvusQ+7FrR1NiPUpos2KEcqXd0z/hwwhAJwcD6PaUg7cYRk/0DDeGhQoZxlvnAQUi+S7lqaa5nhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=bmyXYyXt; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id AB6DA20294;
	Sun,  9 Feb 2025 10:23:16 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 5720A260F7;
	Sun,  9 Feb 2025 10:23:08 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 08F163EA8A;
	Sun,  9 Feb 2025 10:23:00 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id A26C44023E;
	Sun,  9 Feb 2025 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1739096579; bh=pZJYWTi+Aymw8sCXm2t1RPSaapaHEkwN4a8cGdKKvvQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bmyXYyXtMZdyI/JAQH4NChsd0LVJDlGUV+bv3C2avNLw6Wiup4xCuK4l2Si7nRyuU
	 4VxXiG8X7wvvPAxok6WkGodRfiWjB+fm4x7GvDWMKkNNG1OJIYg1gQuE7IqPXoVk9M
	 ctjg3tO178/TuH2pwfFdIG7lJzoWlre8zwyox0m8=
Received: from [172.29.0.1] (unknown [203.175.14.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 6359F410EC;
	Sun,  9 Feb 2025 10:22:56 +0000 (UTC)
Message-ID: <6c9b295c-3199-4660-b162-188a9ab5a829@aosc.io>
Date: Sun, 9 Feb 2025 18:22:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
From: Mingcong Bai <jeffbai@aosc.io>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huacai Chen <chenhuacai@kernel.org>, Huacai Chen
 <chenhuacai@loongson.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>
References: <20250131100630.342995-1-chenhuacai@loongson.cn>
 <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
 <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>
 <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>
 <61fecc0b-d5ac-4fcb-aca7-aa84d8219493@rowland.harvard.edu>
 <2a8d65f4-6832-49c5-9d61-f8c0d0552ed4@aosc.io>
 <06c81c97-7e5f-412b-b6af-04368dd644c9@rowland.harvard.edu>
 <6838de5f-2984-4722-9ee5-c4c62d13911b@aosc.io>
 <6363c5ba-c576-42a8-8a09-31d55768618c@rowland.harvard.edu>
 <9f363d74-24ce-43fe-b0e3-7aef5000abb3@aosc.io>
 <425bf21b-8aa6-4de0-bbe4-c815b9df51a7@rowland.harvard.edu>
 <0ca08039-73fb-4c4b-ad10-15be8129d1b7@aosc.io>
 <5b4349c8-26ae-4c95-8e60-9cccbb1befe6@aosc.io>
Content-Language: en-US
In-Reply-To: <5b4349c8-26ae-4c95-8e60-9cccbb1befe6@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: A26C44023E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 10.00];
	BAYES_SPAM(0.24)[66.67%];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]

Hi again,

Oops. I missed the dmesg.

在 2025/2/9 18:19, Mingcong Bai 写道:
> Hi Alan,
> 
> <snip>
> 
>> This all makes sense. Since Huacai's patch was originally intended to 
>> fix Loongson's OHCI implementation, I was beginning to suspect if it 
>> exists for OHCI implementations found on older x86 platforms, say, 
>> AMD's SB600/700 series south bridges. Also to see if this issue is 
>> shared between OHCI and UHCI.
>>
>> I have purchased a motherboard to test this and will report back as 
>> soon as I get my hands on it.
>>
> 
> I have since purchased a Gigabyte GA-78LMT-S2 motherboard with an SB710 
> south bridge, the USB OHCI controllers and USB device tree are as follows:
> 
> 00:12.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] 
> SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
> 00:12.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] 
> SB7x0 USB OHCI1 Controller [1002:4398]
> 00:13.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] 
> SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
> 00:13.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] 
> SB7x0 USB OHCI1 Controller [1002:4398]
> 00:14.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] 
> SB7x0/SB8x0/SB9x0 USB OHCI2 Controller [1002:4399]
> 
> /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=ohci-pci/3p, 12M
>      ID 1d6b:0001 Linux Foundation 1.1 root hub
> /:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
>      ID 1d6b:0002 Linux Foundation 2.0 root hub
> /:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
>      ID 1d6b:0002 Linux Foundation 2.0 root hub
> /:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=ohci-pci/3p, 12M
>      ID 1d6b:0001 Linux Foundation 1.1 root hub
> /:  Bus 005.Port 001: Dev 001, Class=root_hub, Driver=ohci-pci/3p, 12M
>      ID 1d6b:0001 Linux Foundation 1.1 root hub
> /:  Bus 006.Port 001: Dev 001, Class=root_hub, Driver=ohci-pci/3p, 12M
>      ID 1d6b:0001 Linux Foundation 1.1 root hub
>      |__ Port 002: Dev 004, If 0, Class=Human Interface Device, 
> Driver=usbhid, 1.5M
>          ID 17ef:6099 Lenovo
>      |__ Port 003: Dev 003, If 0, Class=Human Interface Device, 
> Driver=usbhid, 1.5M
>          ID 046d:c077 Logitech, Inc. Mouse
> /:  Bus 007.Port 001: Dev 001, Class=root_hub, Driver=ohci-pci/2p, 12M
>      ID 1d6b:0001 Linux Foundation 1.1 root hub
> 
> Long story short - wake from keyboard via OHCI works (as opposed to what 
> we have found with the Loongson XA61200 motherboard, which also has an 
> OHCI controller, but in its 7A2000 bridge chip).
> 
> Huacai, I suspect that we are looking at a Loongson-specific issue.
> 
> For your reference, here are the equivalent logs which I have supplied 
> for the ThinkPad X200s (which, according to my previous testing, failed 
> to wake up from an external keyboard plugged into its UHCI interface). 
> The OHCI to which the keyboard is connected to on this motherboard 
> corresponds to PCI device 0000:00:13.1:
> 
> `grep . /sys/bus/usb/devices/*/serial`:
> 
> /sys/bus/usb/devices/usb1/serial:0000:00:12.0
> /sys/bus/usb/devices/usb2/serial:0000:00:12.2
> /sys/bus/usb/devices/usb3/serial:0000:00:13.2
> /sys/bus/usb/devices/usb4/serial:0000:00:12.1
> /sys/bus/usb/devices/usb5/serial:0000:00:13.0
> /sys/bus/usb/devices/usb6/serial:0000:00:13.1
> /sys/bus/usb/devices/usb7/serial:0000:00:14.5
> 
> `cat /sys/kernel/debug/usb/ohci/0000:00:13.1/*`:
> 
> size = 32
>   0 [117]: ed8/00000000dd878181 (ls dev4 ep1in-int qlen 1 max 8 00083084)
>   1 [ 92]: ed8/000000001f1ee77f (ls dev3 ep1in-int qlen 1 max 4 00043083)
>   8 [117]: ed8/00000000dd878181
>   9 [ 92]: ed8/000000001f1ee77f
> 16 [117]: ed8/00000000dd878181
> 17 [ 92]: ed8/000000001f1ee77f
> 24 [117]: ed8/00000000dd878181
> 25 [ 92]: ed8/000000001f1ee77f
> bus pci, device 0000:00:13.1
> OHCI PCI host controller
> ohci_hcd
> OHCI 1.0, NO legacy support registers, rh state running
> control 0x28f RWC HCFS=operational IE PLE CBSR=3
> cmdstatus 0x00000 SOC=0
> intrstatus 0x00000024 FNO SF
> intrenable 0x8000005a MIE RHSC UE RD WDH
> ed_controlhead 0108d0e0
> hcca frame 0x6d8a
> fmintvl 0xa7782edf FIT FSMPS=0xa778 FI=0x2edf
> fmremaining 0x80001dd1 FRT FR=0x1dd1
> periodicstart 0x2a2f
> lsthresh 0x0628
> hub poll timer off
> roothub.a 02000b03 POTPGT=2 OCPM NPS PSM NDP=3(3)
> roothub.b 00000000 PPCM=0000 DR=0000
> roothub.status 00008000 DRWE
> roothub.portstatus [0] 0x00000100 PPS
> roothub.portstatus [1] 0x00000303 LSDA PPS PES CCS
> roothub.portstatus [2] 0x00000303 LSDA PPS PES CCS
> 
> `lspci -vv -s 13.0`:
> 
> 00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/ 
> SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
>      Subsystem: Gigabyte Technology Co., Ltd GA-78/880-series motherboard
>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 32, Cache Line Size: 64 bytes
>      Interrupt: pin A routed to IRQ 18
>      NUMA node: 0
>      Region 0: Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
>      Kernel driver in use: ohci-pci
> 
> `lspci -vv -s 13.1`:
> 
> 00:13.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB 
> OHCI1 Controller (prog-if 10 [OHCI])
>      Subsystem: Gigabyte Technology Co., Ltd GA-MA78GM-S2H motherboard
>      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Latency: 32, Cache Line Size: 64 bytes
>      Interrupt: pin A routed to IRQ 18
>      NUMA node: 0
>      Region 0: Memory at fe02a000 (32-bit, non-prefetchable) [size=4K]
>      Kernel driver in use: ohci-pci
> 

`dmesg` of the suspend sequence with dynamic debug on `usbcore`:

[ 1113.101923] PM: suspend entry (deep)
[ 1113.145038] Filesystems sync: 0.043 seconds
[ 1113.209491] Freezing user space processes
[ 1113.211153] Freezing user space processes completed (elapsed 0.001 
seconds)
[ 1113.211163] OOM killer disabled.
[ 1113.211165] Freezing remaining freezable tasks
[ 1113.212471] Freezing remaining freezable tasks completed (elapsed 
0.001 seconds)
[ 1113.212497] printk: Suspending console(s) (use no_console_suspend to 
debug)
[ 1113.214870] usb usb7: usb auto-resume
[ 1113.215460] serial 00:03: disabled
[ 1113.215540] usb 6-3: usb suspend, wakeup 0
[ 1113.216021] usb usb5: usb auto-resume
[ 1113.216177] usb usb4: usb auto-resume
[ 1113.216546] usb 6-2: usb suspend, wakeup 1
[ 1113.217234] usb usb3: usb auto-resume
[ 1113.217406] usb usb2: usb auto-resume
[ 1113.217440] hub 2-0:1.0: hub_resume
[ 1113.217499] hub 2-0:1.0: hub_suspend
[ 1113.217508] usb usb2: bus suspend, wakeup 0
[ 1113.218431] usb usb1: usb auto-resume
[ 1113.218463] sd 4:0:0:0: [sda] Synchronizing SCSI cache
[ 1113.220421] ata5.00: Entering standby power mode
[ 1113.228391] hub 6-0:1.0: hub_suspend
[ 1113.228413] usb usb6: bus suspend, wakeup 0
[ 1113.238347] hub 3-0:1.0: hub_resume
[ 1113.238404] hub 3-0:1.0: hub_suspend
[ 1113.238414] usb usb3: bus suspend, wakeup 0
[ 1113.263489] hub 7-0:1.0: hub_resume
[ 1113.263522] hub 7-0:1.0: hub_suspend
[ 1113.263531] usb usb7: bus suspend, wakeup 0
[ 1113.264405] hub 5-0:1.0: hub_resume
[ 1113.264429] hub 4-0:1.0: hub_resume
[ 1113.264450] hub 5-0:1.0: hub_suspend
[ 1113.264458] usb usb5: bus suspend, wakeup 0
[ 1113.264600] hub 4-0:1.0: hub_suspend
[ 1113.264621] usb usb4: bus suspend, wakeup 0
[ 1113.268364] hub 1-0:1.0: hub_resume
[ 1113.268414] hub 1-0:1.0: hub_suspend
[ 1113.268425] usb usb1: bus suspend, wakeup 0
[ 1114.710476] ohci-pci 0000:00:14.5: wakeup: 1
[ 1114.710501] ohci-pci 0000:00:14.5: --> PCI D0
[ 1114.710605] ohci-pci 0000:00:13.1: wakeup: 1
[ 1114.710610] ohci-pci 0000:00:13.1: --> PCI D0
[ 1114.710615] ohci-pci 0000:00:13.0: wakeup: 1
[ 1114.710635] ohci-pci 0000:00:13.0: --> PCI D0
[ 1114.710641] ehci-pci 0000:00:12.2: wakeup: 1
[ 1114.710669] ohci-pci 0000:00:12.1: wakeup: 1
[ 1114.710674] ohci-pci 0000:00:12.1: --> PCI D0
[ 1114.710705] ohci-pci 0000:00:12.0: wakeup: 1
[ 1114.710710] ohci-pci 0000:00:12.0: --> PCI D0
[ 1114.710752] ehci-pci 0000:00:13.2: wakeup: 1
[ 1114.722478] ehci-pci 0000:00:13.2: --> PCI D3hot
[ 1114.722570] ehci-pci 0000:00:12.2: --> PCI D3hot
[ 1114.722596] ACPI: PM: Preparing to enter system sleep state S3
[ 1114.722737] ACPI: PM: Saving platform NVS memory
[ 1114.722777] Disabling non-boot CPUs ...
[ 1114.724483] smpboot: CPU 1 is now offline
[ 1114.725283] ACPI: PM: Low-level resume complete
[ 1114.725303] ACPI: PM: Restoring platform NVS memory
[ 1114.725347] LVT offset 1 assigned for vector 0x400
[ 1114.725359] LVT offset 1 assigned
[ 1114.725707] Enabling non-boot CPUs ...
[ 1114.725747] smpboot: Booting Node 0 Processor 1 APIC 0x1
[ 1114.728737] CPU1 is up
[ 1114.729088] ACPI: PM: Waking up from system sleep state S3
[ 1114.729555] ahci 0000:00:11.0: set SATA to AHCI mode
[ 1114.743246] serial 00:03: activated
[ 1114.756206] [drm] PCIE gen 2 link speeds already enabled
[ 1114.764122] usb usb1: root hub lost power or was reset
[ 1114.764173] usb usb7: root hub lost power or was reset
[ 1114.764205] usb usb4: root hub lost power or was reset
[ 1114.764219] usb usb6: root hub lost power or was reset
[ 1114.764237] usb usb4: usb resume
[ 1114.764254] usb usb5: root hub lost power or was reset
[ 1114.764271] usb usb1: usb resume
[ 1114.764276] usb usb2: usb resume
[ 1114.764294] usb usb3: usb resume
[ 1114.764316] hub 2-0:1.0: hub_resume
[ 1114.764380] usb usb5: usb resume
[ 1114.764399] usb usb6: usb resume
[ 1114.768550] usb usb7: usb resume
[ 1114.769473] [drm] PCIE GART of 2048M enabled (table at 
0x0000000000165000).
[ 1114.769571] radeon 0000:01:00.0: WB enabled
[ 1114.769574] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 
0x0000000040000c00
[ 1114.769576] radeon 0000:01:00.0: fence driver on ring 1 use gpu addr 
0x0000000040000c04
[ 1114.769578] radeon 0000:01:00.0: fence driver on ring 2 use gpu addr 
0x0000000040000c08
[ 1114.769579] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 
0x0000000040000c0c
[ 1114.769581] radeon 0000:01:00.0: fence driver on ring 4 use gpu addr 
0x0000000040000c10
[ 1114.769982] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 
0x0000000000075a18
[ 1114.785155] hub 3-0:1.0: hub_resume
[ 1114.819119] hub 5-0:1.0: hub_reset_resume
[ 1114.819122] hub 5-0:1.0: trying to enable port power on 
non-switchable hub
[ 1114.819145] hub 4-0:1.0: hub_reset_resume
[ 1114.819151] hub 4-0:1.0: trying to enable port power on 
non-switchable hub
[ 1114.819156] hub 1-0:1.0: hub_reset_resume
[ 1114.819158] hub 1-0:1.0: trying to enable port power on 
non-switchable hub
[ 1114.823143] hub 7-0:1.0: hub_reset_resume
[ 1114.823149] hub 7-0:1.0: trying to enable port power on 
non-switchable hub
[ 1114.830220] hub 6-0:1.0: hub_reset_resume
[ 1114.830226] hub 6-0:1.0: trying to enable port power on 
non-switchable hub
[ 1114.835158] usb usb6-port2: status 0307 change 0000
[ 1114.835175] usb usb6-port3: status 0307 change 0000
[ 1114.835224] usb 6-3: usb resume
[ 1114.835228] usb 6-2: usb resume
[ 1114.887136] usb 6-3: Waited 0ms for CONNECT
[ 1114.887143] usb 6-3: finish reset-resume
[ 1114.887160] usb 6-2: Waited 0ms for CONNECT
[ 1114.887161] usb 6-2: finish reset-resume
[ 1114.931454] ata5.00: ACPI cmd ef/03:08:00:00:00:a0(SET FEATURES) 
filtered out
[ 1114.931462] ata5.00: ACPI cmd ef/03:20:00:00:00:a0(SET FEATURES) 
filtered out
[ 1114.945495] [drm] ring test on 0 succeeded in 1 usecs
[ 1114.945504] [drm] ring test on 1 succeeded in 1 usecs
[ 1114.945508] [drm] ring test on 2 succeeded in 1 usecs
[ 1114.945515] [drm] ring test on 3 succeeded in 3 usecs
[ 1114.945521] [drm] ring test on 4 succeeded in 3 usecs
[ 1114.958500] sd 4:0:0:0: [sda] Starting disk
[ 1115.048845] ata4: SATA link down (SStatus 0 SControl 300)
[ 1115.048886] ata2: SATA link down (SStatus 0 SControl 300)
[ 1115.048916] ata1: SATA link down (SStatus 0 SControl 300)
[ 1115.048946] ata3: SATA link down (SStatus 0 SControl 300)
[ 1115.122985] [drm] ring test on 5 succeeded in 2 usecs
[ 1115.122990] [drm] UVD initialized successfully.
[ 1115.123034] [drm] ib test on ring 0 succeeded in 0 usecs
[ 1115.123067] [drm] ib test on ring 1 succeeded in 0 usecs
[ 1115.123098] [drm] ib test on ring 2 succeeded in 0 usecs
[ 1115.123130] [drm] ib test on ring 3 succeeded in 0 usecs
[ 1115.123160] [drm] ib test on ring 4 succeeded in 0 usecs
[ 1115.158192] usb 6-2: reset low-speed USB device number 4 using ohci-pci
[ 1115.726225] usb 6-3: reset low-speed USB device number 3 using ohci-pci
[ 1115.779259] [drm] ib test on ring 5 succeeded
[ 1116.033742] OOM killer enabled.
[ 1116.033752] Restarting tasks ...
[ 1116.033903] hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0000
[ 1116.033950] hub 5-0:1.0: state 7 ports 3 chg 0000 evt 0000
[ 1116.033959] hub 2-0:1.0: hub_suspend
[ 1116.033973] hub 5-0:1.0: hub_suspend
[ 1116.034013] usb usb2: bus auto-suspend, wakeup 1
[ 1116.034032] usb usb5: bus auto-suspend, wakeup 1
[ 1116.034113] hub 3-0:1.0: state 7 ports 6 chg 0000 evt 0000
[ 1116.034133] hub 7-0:1.0: state 7 ports 2 chg 0000 evt 0000
[ 1116.034181] hub 4-0:1.0: state 7 ports 3 chg 0000 evt 0000
[ 1116.034195] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[ 1116.034207] hub 6-0:1.0: state 7 ports 3 chg 0000 evt 0008
[ 1116.035547] done.
[ 1116.035977] PM: suspend exit
[ 1116.048179] hub 3-0:1.0: hub_suspend
[ 1116.048201] usb usb3: bus auto-suspend, wakeup 1
[ 1116.049119] hub 7-0:1.0: hub_suspend
[ 1116.050939] usb usb7: bus auto-suspend, wakeup 1
[ 1116.050966] hub 4-0:1.0: hub_suspend
[ 1116.051052] usb usb4: bus auto-suspend, wakeup 1
[ 1116.051075] hub 1-0:1.0: hub_suspend
[ 1116.051083] usb usb1: bus auto-suspend, wakeup 1
[ 1116.529188] RTL8211E Gigabit Ethernet r8169-0-200:00: attached PHY 
driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
[ 1116.765376] r8169 0000:02:00.0 enp2s0: Link is Down
[ 1119.704013] r8169 0000:02:00.0 enp2s0: Link is Up - 1Gbps/Full - flow 
control off

Best Regards,
Mingcong Bai

