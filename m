Return-Path: <stable+bounces-114199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA7A2B9AC
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 04:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441817A2A89
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 03:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104D417AE1D;
	Fri,  7 Feb 2025 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="ox98C2Rd"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8417995E;
	Fri,  7 Feb 2025 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738898659; cv=none; b=ZWwDGdtozeW1aah7Urtapx2r8jjjYK9t2g7ywqlJqjG7kNaFRwxUjCYfzByO8gvCAwhLQwZLjW72AL+xo/dDirDKjSLiUwS2VtSx0/g+9nT0cmXELKEiGx7LQH/d+JMJNsTZmbf9KZ2VJHdVnkZvKvH8ZwDZKuobEXS/AziiT2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738898659; c=relaxed/simple;
	bh=sAlLgDxhjRVjQ1K2sXr4ARtue1aL8XbbDctOT0sc1vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmFRA6qCKlreNHl3JJf4hQHKVQSj7+b5A4qBIdoliEDRxNQv3hz20jXSQKDv8wdHHIYdKmsNTp3FMg1rr3TCCdgAOjca5P8mh5h4ZH377mkETjcWDhMv1H14y5CuKKzxXOpEta2vv++vkxcp0c5zGzASiNf0PV5viJXhF5abcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=ox98C2Rd; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 3CC3820063;
	Fri,  7 Feb 2025 03:24:06 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id DAE983E885;
	Fri,  7 Feb 2025 03:23:57 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id EF9A8400D6;
	Fri,  7 Feb 2025 03:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1738898636; bh=sAlLgDxhjRVjQ1K2sXr4ARtue1aL8XbbDctOT0sc1vc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ox98C2RdkKuJIDs11ZRNK/0gQKBeNTxpg7CU/Fvh7KqpEXOazZSaQi30ZhaHo2Ge3
	 xLsaP6BZBmJESPJlwDk9PJDF3VT4AKjoekuiKtd+hRZIXIpqq1ozSIgXdPewcy5mfk
	 M28fjdW1ECPbEAZqD74rQ91C3ju473el0k4tKtDY=
Received: from [172.29.0.1] (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 77A164389B;
	Fri,  7 Feb 2025 03:23:51 +0000 (UTC)
Message-ID: <0ca08039-73fb-4c4b-ad10-15be8129d1b7@aosc.io>
Date: Fri, 7 Feb 2025 11:23:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
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
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <425bf21b-8aa6-4de0-bbe4-c815b9df51a7@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF9A8400D6
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Alan,

在 2025/2/7 05:20, Alan Stern 写道:
> On Thu, Feb 06, 2025 at 11:49:49AM +0800, Mingcong Bai wrote:
>> On both unpatched and patched kernels, I have set power/control to "auto"
>> for both the root hub and the external hub and left the keyboard for 60
>> seconds. Regardless if I plug the keyboard into the chassis or the external
>> hub, the keyboard continues to work from the first key strike (no delay or
>> lost input).
> 
> It's not necessary to wait 60 seconds; 10 seconds would be enough.
> 
> For the case where the keyboard is plugged into the hub, it would be
> best if you removed the r8152 device (network or wifi, I guess).
> Leaving it plugged in will prevent the external hub from going into
> runtime suspend unless the network interface is turned off.
> 
> You can check whether these devices have gone into runtime suspend by
> looking at the contents of the .../power/runtime_status attribute
> file.  There are a couple of ways you can do this without disturbing the
> keyboard's status, such as by using ssh or by doing something like:
> 
> 	sleep 10 ; cat .../power/runtime_status
> 
> Or if you want to see the status of all your USB devices,
> 
> 	sleep 10 ; grep . /sys/bus/usb/devices/*/power/runtime_status
> 

Got it, thanks for the tip.

>>> This means there's something different between the way the keyboard
>>> sends its wakeup signal and the way the Genesys Logic hub sends its
>>> wakeup signal.
>>>
>>> Can you post the output from "lsusb -t" for this system?
>>
>> Keyboard plugged into the chassis:
>>
>> /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>>      |__ Port 001: Dev 002, If 0, Class=Human Interface Device,
>> Driver=usbhid, 1.5M
>> /:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
>> /:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
>> /:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>> /:  Bus 005.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>> /:  Bus 006.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>> /:  Bus 007.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>> /:  Bus 008.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>>
>> Keyboard plugged into the hub:
>>
>> /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>> /:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
>>      |__ Port 001: Dev 003, If 0, Class=Hub, Driver=hub/4p, 480M
>>          |__ Port 001: Dev 004, If 0, Class=Vendor Specific Class,
>> Driver=r8152, 480M
>>          |__ Port 004: Dev 005, If 0, Class=Human Interface Device,
>> Driver=usbhid, 1.5M
> 
> Ah, okay, there's an important difference.  The hub connects to an EHCI
> controller whereas the keyboard by itself connects to UHCI.
> 
> Also the output from "grep . /sys/bus/usb/devices/*/serial"?
> 
> And the contents of /sys/kernel/debug/usb/uhci/0000:00:1d.0?
> 

The enumerated USB tree changed (now to a controller at 1a.0) so I have 
reproduced a new set of outputs (also for the log you requested below).

`lsusb -t`:

/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
/:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
     |__ Port 001: Dev 002, If 0, Class=Human Interface Device, 
Driver=usbhid, 1.5M
/:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 005.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 006.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 007.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 008.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M

`grep . /sys/bus/usb/devices/*/serial`:

/sys/bus/usb/devices/usb1/serial:0000:00:1a.7
/sys/bus/usb/devices/usb2/serial:0000:00:1d.7
/sys/bus/usb/devices/usb3/serial:0000:00:1a.0
/sys/bus/usb/devices/usb4/serial:0000:00:1a.1
/sys/bus/usb/devices/usb5/serial:0000:00:1a.2
/sys/bus/usb/devices/usb6/serial:0000:00:1d.0
/sys/bus/usb/devices/usb7/serial:0000:00:1d.1
/sys/bus/usb/devices/usb8/serial:0000:00:1d.2

`cat /sys/kernel/debug/usb/uhci/0000:00:1a.0`:
Root-hub state: running   FSBR: 0
HC status
   usbcmd    =     00c1   Maxp64 CF RS
   usbstat   =     0000
   usbint    =     000f
   usbfrnum  =   (1)c14
   flbaseadd = 03147c14
   sof       =       40
   stat1     =     01a5   LowSpeed Enabled Connected
   stat2     =     0080
Most recent frame: 6fe6f (623)   Last ISO frame: 6fe6f (623)
Periodic load table
	0	0	0	0	118	0	0	0
	0	0	0	0	118	0	0	0
	0	0	0	0	118	0	0	0
	0	0	0	0	118	0	0	0
Total: 472, #INT: 1, #ISO: 0

>> /:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
>> /:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>> /:  Bus 005.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>> /:  Bus 006.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>> /:  Bus 007.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>> /:  Bus 008.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
>>
>>>
>>> Also, can you enable dynamic debugging for usbcore by doing:
>>>
>>> 	echo module usbcore =p >/sys/kernel/debug/dynamic_debug/control
>>>
>>> and then post the dmesg log for a suspend/resume cycle?
>>
>> Keyboard plugged into the chassis (does not wake up via the external
>> keyboard, needed to strike Fn on the internal keyboard):
> 
> These logs are pretty much what I would expect, except for one thing:
> 
>> [  363.682633] ehci-pci 0000:00:1d.7: wakeup: 1
>> [  363.682714] uhci_hcd 0000:00:1d.2: wakeup: 1
>> [  363.682719] uhci_hcd 0000:00:1d.2: --> PCI D0
>> [  363.682757] uhci_hcd 0000:00:1d.1: wakeup: 1
>> [  363.682760] uhci_hcd 0000:00:1d.1: --> PCI D0
>> [  363.682796] uhci_hcd 0000:00:1d.0: wakeup: 1
>> [  363.682849] uhci_hcd 0000:00:1d.0: --> PCI D2
>> [  363.683087] ehci-pci 0000:00:1a.7: wakeup: 1
>> [  363.683153] uhci_hcd 0000:00:1a.2: wakeup: 1
>> [  363.683215] uhci_hcd 0000:00:1a.2: --> PCI D2
>> [  363.683254] uhci_hcd 0000:00:1a.1: wakeup: 1
>> [  363.683257] uhci_hcd 0000:00:1a.1: --> PCI D0
>> [  363.683293] uhci_hcd 0000:00:1a.0: wakeup: 1
>> [  363.683338] uhci_hcd 0000:00:1a.0: --> PCI D2
>> [  363.694561] ehci-pci 0000:00:1a.7: --> PCI D3hot
>> [  363.694597] ehci-pci 0000:00:1d.7: --> PCI D3hot
> 
> Why do the 1d.1, 1d.2, and 1a.1 UHCI controllers remain in D0 during
> suspend, whereas the 1d.0, 1a.0, and 1a.2 controllers get put in D2?
> That's odd.
> 
> Can you send the output from "lspci -vv -s 1d.0" and "lspci -vv -s 1d.1",
> running as root?  It may explain this behavior.
> 

`lspci -vv -s 1d.0`:

00:1a.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Lenovo ThinkPad T400
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at 1860 [size=32]
	Capabilities: [50] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: uhci_hcd

`lspci -vv -s 1d.1`:

00:1a.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #5 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Lenovo ThinkPad T400
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at 1880 [size=32]
	Capabilities: [50] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: uhci_hcd

> Reading through the source code, I found a comment in the UHCI driver
> (drivers/usb/host/uhci-hcd.c, line 328) which is highly relevant:
> 
> 	/*
> 	 * UHCI doesn't distinguish between wakeup requests from downstream
> 	 * devices and local connect/disconnect events.  There's no way to
> 	 * enable one without the other; both are controlled by EGSM. Thus
> 	 * if wakeups are disallowed then EGSM must be turned off -- in which
> 	 * case remote wakeup requests from downstream during system sleep
> 	 * will be lost.
> 	 * ...
> 
> Most likely this explains what you are seeing.  In particular, it
> explains why the keyboard (when plugged directly into the computer)
> can't wake up the system unless wakeup is enabled on the root hub.  It
> even explains why wakeup from runtime suspend works, because wakeup is
> always enabled on all USB devices during runtime suspend regardless
> of the setting in .../power/wakeup.
> 
> (UHCI was the first USB host controller technology to be developed;
> the spec is from 1996.  It is very primitive compared to later
> controllers, in many ways.  Perhaps it shouldn't be surprising that
> UHCI controllers can't do all that we want them to.)
> 

This all makes sense. Since Huacai's patch was originally intended to 
fix Loongson's OHCI implementation, I was beginning to suspect if it 
exists for OHCI implementations found on older x86 platforms, say, AMD's 
SB600/700 series south bridges. Also to see if this issue is shared 
between OHCI and UHCI.

I have purchased a motherboard to test this and will report back as soon 
as I get my hands on it.

> Alan Stern
> 

Best Regards,
Mingcong Bai

