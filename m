Return-Path: <stable+bounces-114427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC4A2DC42
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 11:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC8A18848C8
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F521C461F;
	Sun,  9 Feb 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="B9xDffNT"
X-Original-To: stable@vger.kernel.org
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A571922F5;
	Sun,  9 Feb 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=137.74.80.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096402; cv=none; b=E/X8BOQy23LoJ9PWV/R6o3WKUJX/Wd1jSfVBbEkayUr9Jh0bkDG6WaQmSB4muf2Sq/dcnQFKWaM5MKTFg8U1U2Y7DdvqIYmwiOQ+TH5k61JsUrbHlBcAA2FCPEckVh3ooGgCU6LW21zrSOiDSCZVrnGTpX/SKfnADfm3idj35vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096402; c=relaxed/simple;
	bh=gHIr4MYiPNO1q+EC1QWzZKZXTvbEbzgL6XP3d/qHxRo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=byQ1B9E8zXkBnb2Vq6RMKDziwH0sNqtCsOeQS3Zi+kPRmgZtvsUxAFRqXHY5zXoZ9lGWfqLy3a+TUEmPhxOTstB+Bu/KSdSYoQmp0ViYiGqLBfqfNFbnlKYpyCjEieiU/jko3PrGAvEx7X6xBKa0S6oTnsyFggKZeHt5uRNHF2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=B9xDffNT; arc=none smtp.client-ip=137.74.80.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 6AD0820159;
	Sun,  9 Feb 2025 10:19:52 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id F21824023E;
	Sun,  9 Feb 2025 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1739096391; bh=gHIr4MYiPNO1q+EC1QWzZKZXTvbEbzgL6XP3d/qHxRo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=B9xDffNTlcK5c4t/NSH9FghY/sxEGdOHXE1bp7YPDT20vbFb+1cbz1DrWBhC8832e
	 TuB24jf8KxMBcTKiFfn1DwsDsqkHPcWx9m0EMaiM1Netr2F9AeHLPpLVE0JEgb2ohN
	 YdbC23OGRVF88dbCO3d41NwOg+PTD7kR+6TMumhY=
Received: from [172.29.0.1] (unknown [203.175.14.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id B876B4050D;
	Sun,  9 Feb 2025 10:19:47 +0000 (UTC)
Message-ID: <5b4349c8-26ae-4c95-8e60-9cccbb1befe6@aosc.io>
Date: Sun, 9 Feb 2025 18:19:43 +0800
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
Content-Language: en-US
In-Reply-To: <0ca08039-73fb-4c4b-ad10-15be8129d1b7@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: F21824023E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.62 / 10.00];
	BAYES_SPAM(0.72)[76.60%];
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

Hi Alan,

<snip>

> This all makes sense. Since Huacai's patch was originally intended to 
> fix Loongson's OHCI implementation, I was beginning to suspect if it 
> exists for OHCI implementations found on older x86 platforms, say, AMD's 
> SB600/700 series south bridges. Also to see if this issue is shared 
> between OHCI and UHCI.
> 
> I have purchased a motherboard to test this and will report back as soon 
> as I get my hands on it.
> 

I have since purchased a Gigabyte GA-78LMT-S2 motherboard with an SB710 
south bridge, the USB OHCI controllers and USB device tree are as follows:

00:12.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
00:12.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0 USB OHCI1 Controller [1002:4398]
00:13.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
00:13.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0 USB OHCI1 Controller [1002:4398]
00:14.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB OHCI2 Controller [1002:4399]

/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=ohci-pci/3p, 12M
     ID 1d6b:0001 Linux Foundation 1.1 root hub
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
     ID 1d6b:0002 Linux Foundation 2.0 root hub
/:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
     ID 1d6b:0002 Linux Foundation 2.0 root hub
/:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=ohci-pci/3p, 12M
     ID 1d6b:0001 Linux Foundation 1.1 root hub
/:  Bus 005.Port 001: Dev 001, Class=root_hub, Driver=ohci-pci/3p, 12M
     ID 1d6b:0001 Linux Foundation 1.1 root hub
/:  Bus 006.Port 001: Dev 001, Class=root_hub, Driver=ohci-pci/3p, 12M
     ID 1d6b:0001 Linux Foundation 1.1 root hub
     |__ Port 002: Dev 004, If 0, Class=Human Interface Device, 
Driver=usbhid, 1.5M
         ID 17ef:6099 Lenovo
     |__ Port 003: Dev 003, If 0, Class=Human Interface Device, 
Driver=usbhid, 1.5M
         ID 046d:c077 Logitech, Inc. Mouse
/:  Bus 007.Port 001: Dev 001, Class=root_hub, Driver=ohci-pci/2p, 12M
     ID 1d6b:0001 Linux Foundation 1.1 root hub

Long story short - wake from keyboard via OHCI works (as opposed to what 
we have found with the Loongson XA61200 motherboard, which also has an 
OHCI controller, but in its 7A2000 bridge chip).

Huacai, I suspect that we are looking at a Loongson-specific issue.

For your reference, here are the equivalent logs which I have supplied 
for the ThinkPad X200s (which, according to my previous testing, failed 
to wake up from an external keyboard plugged into its UHCI interface). 
The OHCI to which the keyboard is connected to on this motherboard 
corresponds to PCI device 0000:00:13.1:

`grep . /sys/bus/usb/devices/*/serial`:

/sys/bus/usb/devices/usb1/serial:0000:00:12.0
/sys/bus/usb/devices/usb2/serial:0000:00:12.2
/sys/bus/usb/devices/usb3/serial:0000:00:13.2
/sys/bus/usb/devices/usb4/serial:0000:00:12.1
/sys/bus/usb/devices/usb5/serial:0000:00:13.0
/sys/bus/usb/devices/usb6/serial:0000:00:13.1
/sys/bus/usb/devices/usb7/serial:0000:00:14.5

`cat /sys/kernel/debug/usb/ohci/0000:00:13.1/*`:

size = 32
  0 [117]: ed8/00000000dd878181 (ls dev4 ep1in-int qlen 1 max 8 00083084)
  1 [ 92]: ed8/000000001f1ee77f (ls dev3 ep1in-int qlen 1 max 4 00043083)
  8 [117]: ed8/00000000dd878181
  9 [ 92]: ed8/000000001f1ee77f
16 [117]: ed8/00000000dd878181
17 [ 92]: ed8/000000001f1ee77f
24 [117]: ed8/00000000dd878181
25 [ 92]: ed8/000000001f1ee77f
bus pci, device 0000:00:13.1
OHCI PCI host controller
ohci_hcd
OHCI 1.0, NO legacy support registers, rh state running
control 0x28f RWC HCFS=operational IE PLE CBSR=3
cmdstatus 0x00000 SOC=0
intrstatus 0x00000024 FNO SF
intrenable 0x8000005a MIE RHSC UE RD WDH
ed_controlhead 0108d0e0
hcca frame 0x6d8a
fmintvl 0xa7782edf FIT FSMPS=0xa778 FI=0x2edf
fmremaining 0x80001dd1 FRT FR=0x1dd1
periodicstart 0x2a2f
lsthresh 0x0628
hub poll timer off
roothub.a 02000b03 POTPGT=2 OCPM NPS PSM NDP=3(3)
roothub.b 00000000 PPCM=0000 DR=0000
roothub.status 00008000 DRWE
roothub.portstatus [0] 0x00000100 PPS
roothub.portstatus [1] 0x00000303 LSDA PPS PES CCS
roothub.portstatus [2] 0x00000303 LSDA PPS PES CCS

`lspci -vv -s 13.0`:

00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
	Subsystem: Gigabyte Technology Co., Ltd GA-78/880-series motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	NUMA node: 0
	Region 0: Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

`lspci -vv -s 13.1`:

00:13.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB 
OHCI1 Controller (prog-if 10 [OHCI])
	Subsystem: Gigabyte Technology Co., Ltd GA-MA78GM-S2H motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	NUMA node: 0
	Region 0: Memory at fe02a000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

Best Regards,
Mingcong Bai

