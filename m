Return-Path: <stable+bounces-114027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F6A29F74
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 04:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B3D16469D
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 03:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95E480BFF;
	Thu,  6 Feb 2025 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="IKNjyR7a"
X-Original-To: stable@vger.kernel.org
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B83376;
	Thu,  6 Feb 2025 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.119.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738813803; cv=none; b=JzRlvaWdMk+5viNWiatuyx5WX8nDq5M88dX0LRd0e3TDOxmLVai5HjAZvGjwNbR1bnYUKITSDBDvEkfSmFO1zUO1/2PCpIVjPGM8tcGLAO2eZ6Krq3D2atPBigrYRPHdV49+9LgLegR6iG2Zwvmw+sw4TWEN5StSAWoBoKW16qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738813803; c=relaxed/simple;
	bh=0oKwoNil2ySPdJ/RLN71pumDlZ8rJJJkI6TvxAej0cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHzQi8GFTSOQr9LccHnOgG2PAJ8OkYGdw9z33+Bv/XemtfJf1cwFySow1oX21/FYZ5BmZWFiI9z+wi6ofxQu4HxKt2BD7Lqg3cKZ1+HLnySHmcsWpE3W6Y3vWbpi0Lo1NXv0AJojUZwFtFI2MLnyzDhEYPiyUZReWUqwIU2SxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=IKNjyR7a; arc=none smtp.client-ip=217.182.119.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 5A8D93E94E;
	Thu,  6 Feb 2025 03:49:58 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 5A0F040098;
	Thu,  6 Feb 2025 03:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1738813796; bh=0oKwoNil2ySPdJ/RLN71pumDlZ8rJJJkI6TvxAej0cU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IKNjyR7af0xDhh9twoQWsFJ6Tfx/u/M5X8/134N9shTLelPhLly19n3I65Vs5w4Mt
	 EsolsqmRMDpZ5td/f7aaZDWXRPGl/dTIxN70b3x/CcdIG3aPBIgUy9PrZoeMrqSpIE
	 O+rxMt6bsFPk1ALtoxaSkqe5t5Hwzp6eRS4nKAEw=
Received: from [172.29.0.1] (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 1F4444050D;
	Thu,  6 Feb 2025 03:49:52 +0000 (UTC)
Message-ID: <9f363d74-24ce-43fe-b0e3-7aef5000abb3@aosc.io>
Date: Thu, 6 Feb 2025 11:49:49 +0800
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
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <6363c5ba-c576-42a8-8a09-31d55768618c@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A0F040098
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

在 2025/2/6 02:25, Alan Stern 写道:
> On Wed, Feb 05, 2025 at 01:59:24PM +0800, Mingcong Bai wrote:
>> 在 2025/2/4 00:15, Alan Stern 写道:
>>> What sort of USB controller does the X200s have?  Is the controller
>>> enabled for wakeup?
>>>
>>> What happens with runtime suspend rather than S3 suspend?
>>
>> It has the Intel Corporation 82801I (ICH9 Family) USB UCHI/USB2 EHCI
> 
> UHCI, not UCHI.
> 
>> controller with PCI IDs 17aa:20f0/17aa:20f1. The hub is a Genesys Logic,
>> Inc. Hub with an ID of 05e3:0610 - this is an xHCI hub.
> 
> There is no such thing as an xHCI hub -- xHCI is a host controller
> technology, not a hub technology.  Perhaps you mean that it is a USB-3
> hub.
> 
>> Sorry but the record here is going to get a bit messy... But let's start
>> with a kernel with Huacai's patch.
>>
>> === Kernel + Huacai's Patch ===
>>
>> 1. If I plug in the external keyboard via the hub,
>> /sys/bus/usb/devices/usb1,
> 
> /sys/bus/usb/devices/usb1 is the root hub, which is an emulated device
> that is closely tied to the host controller.  The external Genesys Logic
> hub is /sys/bus/usb/devices/1-1.
> 
>>   power/state is set to enabled. For the hub,
> 
> You mean power/wakeup, not power/state.  In fact, there is no
> power/state file for USB devices in sysfs.

Sorry for the typos and terminology issues above. You are correct on all 
counts. Yes, I meant to say a USB 3.0 hub.

> 
>> corresponding to usb1/1-1, power/wakeup is set to disabled.
>>
>> 2. If I plug the keyboard directly into the chassis, usb1/power/wakeup is
>> set to disabled, but usb1/1-1/power/wakeup is set to enabled.
> 
> Why is usb1/power/wakeup set to disabled?  Doesn't Huacai's patch set it
> to enabled?

No idea on my end either, I have double checked and that is indeed how 
it is (and wakeup does work).

> 
> Is 1-1 the keyboard device?  That is, did you plug the keyboard into the
> port that the Genesys Logic hub was using previously?
> 
>> The system wakes up via external keyboard plugged directly into the chassis
>> **or** the hub either way, regardless if I used S3 or runtime suspend (which
>> I assume to be echo freeze > /sys/power/state).
> 
> No.  Runtime suspend has no relation to /sys/power.  It is controlled by
> /sys/bus/usb/devices/.../power/control.  If you write "auto" to this
> file for the device and for all the hubs above it (including the root
> hub) then they will be put into runtime suspend a few seconds after you
> stop using them, assuming no other USB devices are plugged into the same
> hubs.

Got it.

On both unpatched and patched kernels, I have set power/control to 
"auto" for both the root hub and the external hub and left the keyboard 
for 60 seconds. Regardless if I plug the keyboard into the chassis or 
the external hub, the keyboard continues to work from the first key 
strike (no delay or lost input).

> 
>> === Kernel w/o Huacai's Patch ===
>>
>> The controller where I plugged in the USB hub, /sys/bus/usb/devices/usb1 and
> 
> /sys/bus/usb/devices/usb1 is the root hub, not the controller.  The two
> are related but they are not the same thing.  The controller is the
> parent device of the root hub; it lies under /sys/bus/pci/devices/.
> 
>> the hub, corresponding to usb1/1-1, their power/wakeup entries are both set
>> to disabled. Same for when I have the patch applied.
>>
>> However, if I plug the external keyboard into the chassis, it would fail to
>> wakeup regardless of S3/runtime suspend (freeze). If I plug the external
>> keyboard via that USB Hub though, it would wake up the machine. The findings
>> are consistent between S3/freeze.
> 
> This means there's something different between the way the keyboard
> sends its wakeup signal and the way the Genesys Logic hub sends its
> wakeup signal.
> 
> Can you post the output from "lsusb -t" for this system?

Keyboard plugged into the chassis:

/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
     |__ Port 001: Dev 002, If 0, Class=Human Interface Device, 
Driver=usbhid, 1.5M
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
/:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
/:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 005.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 006.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 007.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 008.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M

Keyboard plugged into the hub:

/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
     |__ Port 001: Dev 003, If 0, Class=Hub, Driver=hub/4p, 480M
         |__ Port 001: Dev 004, If 0, Class=Vendor Specific Class, 
Driver=r8152, 480M
         |__ Port 004: Dev 005, If 0, Class=Human Interface Device, 
Driver=usbhid, 1.5M
/:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/6p, 480M
/:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 005.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 006.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 007.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 008.Port 001: Dev 001, Class=root_hub, Driver=uhci_hcd/2p, 12M

> 
> Also, can you enable dynamic debugging for usbcore by doing:
> 
> 	echo module usbcore =p >/sys/kernel/debug/dynamic_debug/control
> 
> and then post the dmesg log for a suspend/resume cycle?

Keyboard plugged into the chassis (does not wake up via the external 
keyboard, needed to strike Fn on the internal keyboard):

[  362.886330] PM: suspend entry (deep)
[  363.286839] Filesystems sync: 0.400 seconds
[  363.323106] Freezing user space processes
[  363.324899] Freezing user space processes completed (elapsed 0.001 
seconds)
[  363.324909] OOM killer disabled.
[  363.324912] Freezing remaining freezable tasks
[  363.326107] Freezing remaining freezable tasks completed (elapsed 
0.001 seconds)
[  363.326479] printk: Suspending console(s) (use no_console_suspend to 
debug)
[  363.331241] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  363.333294] usb 1-1: usb suspend, wakeup 1
[  363.344205] usb usb8: usb auto-resume
[  363.344302] usb usb7: usb auto-resume
[  363.344380] usb usb6: usb auto-resume
[  363.344460] usb usb5: usb auto-resume
[  363.345267] usb usb3: usb auto-resume
[  363.345305] hub 3-0:1.0: hub_resume
[  363.345370] usb usb2: usb auto-resume
[  363.345426] hub 1-0:1.0: hub_suspend
[  363.345447] usb usb4: usb auto-resume
[  363.345562] usb usb1: bus suspend, wakeup 0
[  363.345744] hub 3-0:1.0: hub_suspend
[  363.345763] usb usb3: bus suspend, wakeup 0
[  363.345927] ata1.00: Entering standby power mode
[  363.353452] e1000e: EEE TX LPI TIMER: 00000000
[  363.365259] hub 5-0:1.0: hub_resume
[  363.365294] hub 6-0:1.0: hub_resume
[  363.365320] hub 8-0:1.0: hub_resume
[  363.365401] hub 6-0:1.0: hub_suspend
[  363.365419] hub 5-0:1.0: hub_suspend
[  363.365435] hub 8-0:1.0: hub_suspend
[  363.365456] usb usb6: bus suspend, wakeup 0
[  363.365487] usb usb5: bus suspend, wakeup 0
[  363.365513] usb usb8: bus suspend, wakeup 0
[  363.365626] hub 7-0:1.0: hub_resume
[  363.365675] hub 7-0:1.0: hub_suspend
[  363.365693] usb usb7: bus suspend, wakeup 0
[  363.366246] hub 2-0:1.0: hub_resume
[  363.366348] hub 2-0:1.0: hub_suspend
[  363.366366] usb usb2: bus suspend, wakeup 0
[  363.366428] hub 4-0:1.0: hub_resume
[  363.366470] hub 4-0:1.0: hub_suspend
[  363.366485] usb usb4: bus suspend, wakeup 0
[  363.682065] ACPI: EC: interrupt blocked
[  363.682633] ehci-pci 0000:00:1d.7: wakeup: 1
[  363.682714] uhci_hcd 0000:00:1d.2: wakeup: 1
[  363.682719] uhci_hcd 0000:00:1d.2: --> PCI D0
[  363.682757] uhci_hcd 0000:00:1d.1: wakeup: 1
[  363.682760] uhci_hcd 0000:00:1d.1: --> PCI D0
[  363.682796] uhci_hcd 0000:00:1d.0: wakeup: 1
[  363.682849] uhci_hcd 0000:00:1d.0: --> PCI D2
[  363.683087] ehci-pci 0000:00:1a.7: wakeup: 1
[  363.683153] uhci_hcd 0000:00:1a.2: wakeup: 1
[  363.683215] uhci_hcd 0000:00:1a.2: --> PCI D2
[  363.683254] uhci_hcd 0000:00:1a.1: wakeup: 1
[  363.683257] uhci_hcd 0000:00:1a.1: --> PCI D0
[  363.683293] uhci_hcd 0000:00:1a.0: wakeup: 1
[  363.683338] uhci_hcd 0000:00:1a.0: --> PCI D2
[  363.694561] ehci-pci 0000:00:1a.7: --> PCI D3hot
[  363.694597] ehci-pci 0000:00:1d.7: --> PCI D3hot
[  363.694767] ACPI: PM: Preparing to enter system sleep state S3
[  363.707378] ACPI: EC: event blocked
[  363.707382] ACPI: EC: EC stopped
[  363.707383] ACPI: PM: Saving platform NVS memory
[  363.709032] Disabling non-boot CPUs ...
[  363.709032] ACPI: PM: Low-level resume complete
[  363.709032] ACPI: EC: EC started
[  363.709032] ACPI: PM: Restoring platform NVS memory
[  363.709558] ACPI: PM: Waking up from system sleep state S3
[  363.735865] ACPI: EC: interrupt unblocked
[  363.744280] usb usb1: root hub lost power or was reset
[  363.744731] ACPI: EC: event unblocked
[  363.745248] usb usb4: root hub lost power or was reset
[  363.745456] usb usb5: root hub lost power or was reset
[  363.745679] usb usb6: root hub lost power or was reset
[  363.745740] usb usb7: root hub lost power or was reset
[  363.745797] usb usb8: root hub lost power or was reset
[  363.745872] usb usb3: usb resume
[  363.745906] hub 3-0:1.0: hub_resume
[  363.745973] usb usb4: usb resume
[  363.745982] hub 4-0:1.0: hub_reset_resume
[  363.745985] hub 4-0:1.0: trying to enable port power on 
non-switchable hub
[  363.746459] usb usb5: usb resume
[  363.746469] hub 5-0:1.0: hub_reset_resume
[  363.746473] hub 5-0:1.0: trying to enable port power on 
non-switchable hub
[  363.747116] usb usb6: usb resume
[  363.747126] hub 6-0:1.0: hub_reset_resume
[  363.747130] hub 6-0:1.0: trying to enable port power on 
non-switchable hub
[  363.748764] usb usb7: usb resume
[  363.748775] hub 7-0:1.0: hub_reset_resume
[  363.748779] hub 7-0:1.0: trying to enable port power on 
non-switchable hub
[  363.748952] usb usb1: usb resume
[  363.748961] hub 1-0:1.0: hub_reset_resume
[  363.748965] hub 1-0:1.0: trying to enable port power on 
non-switchable hub
[  363.749036] usb usb8: usb resume
[  363.749045] hub 8-0:1.0: hub_reset_resume
[  363.749048] hub 8-0:1.0: trying to enable port power on 
non-switchable hub
[  363.750378] usb usb2: usb resume
[  363.751222] usb usb1-port1: status 0301 change 0003
[  363.771214] hub 2-0:1.0: hub_resume
[  363.870210] usb 1-1: Waited 0ms for CONNECT
[  363.870217] usb 1-1: finish reset-resume
[  364.067770] ata2: SATA link down (SStatus 0 SControl 300)
[  364.126263] usb 1-1: reset low-speed USB device number 3 using uhci_hcd
[  364.859239] pcieport 0000:00:1c.0: pciehp: Timeout on hotplug command 
0x0018 (issued 1123 msec ago)
[  364.859262] pcieport 0000:00:1c.1: pciehp: Timeout on hotplug command 
0x0018 (issued 1123 msec ago)
[  364.859343] pcieport 0000:00:1c.3: pciehp: Timeout on hotplug command 
0x0018 (issued 1122 msec ago)
[  364.868343] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
[  364.983337] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
[  365.212241] tpm tpm0: TPM is disabled/deactivated (0x6)
[  365.220350] ACPI: \_SB_.PCI0.SATA.SCND.MSTR: docking
[  365.220462] ACPI: \_SB_.PCI0.SATA.SCND.MSTR: Unable to dock!
[  365.220694] OOM killer enabled.
[  365.220702] Restarting tasks ...
[  365.222080] hub 3-0:1.0: state 7 ports 6 chg 0000 evt 0000
[  365.222105] hub 6-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  365.222120] hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  365.222134] hub 8-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  365.222148] hub 7-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  365.222205] hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0000
[  365.222220] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  365.222233] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0002
[  365.222266] hub 3-0:1.0: hub_suspend
[  365.222412] usb usb3: bus auto-suspend, wakeup 1
[  365.222459] hub 6-0:1.0: hub_suspend
[  365.222511] hub 5-0:1.0: hub_suspend
[  365.222533] usb usb6: bus auto-suspend, wakeup 1
[  365.222567] hub 8-0:1.0: hub_suspend
[  365.222580] usb usb5: bus auto-suspend, wakeup 1
[  365.222612] hub 7-0:1.0: hub_suspend
[  365.222630] usb usb8: bus auto-suspend, wakeup 1
[  365.222664] hub 2-0:1.0: hub_suspend
[  365.222677] usb usb7: bus auto-suspend, wakeup 1
[  365.222708] hub 4-0:1.0: hub_suspend
[  365.222726] usb usb2: bus auto-suspend, wakeup 1
[  365.222767] usb usb4: bus auto-suspend, wakeup 1
[  365.237576] done.
[  365.273727] video LNXVIDEO:00: Restoring backlight state
[  365.281300] PM: suspend exit

Keyboard plugged into the hub:

[  300.631522] PM: suspend entry (deep)
[  300.918836] Filesystems sync: 0.287 seconds
[  300.958743] Freezing user space processes
[  300.960270] Freezing user space processes completed (elapsed 0.001 
seconds)
[  300.960279] OOM killer disabled.
[  300.960282] Freezing remaining freezable tasks
[  300.961290] Freezing remaining freezable tasks completed (elapsed 
0.001 seconds)
[  300.961619] printk: Suspending console(s) (use no_console_suspend to 
debug)
[  300.965734] usb 2-1.4: usb suspend, wakeup 1
[  300.966220] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  300.975608] r8152-cfgselector 2-1.1: usb suspend, wakeup 1
[  300.983969] usb usb8: usb auto-resume
[  300.984000] usb usb7: usb auto-resume
[  300.984027] usb usb6: usb auto-resume
[  300.984056] usb usb5: usb auto-resume
[  300.984189] usb usb4: usb auto-resume
[  300.984281] usb usb3: usb auto-resume
[  300.984317] hub 3-0:1.0: hub_resume
[  300.984469] hub 3-0:1.0: hub_suspend
[  300.984485] usb usb3: bus suspend, wakeup 0
[  300.984598] usb usb1: usb auto-resume
[  300.986240] hub 2-1:1.0: hub_suspend
[  300.988228] usb 2-1: usb suspend, wakeup 0
[  300.991730] e1000e: EEE TX LPI TIMER: 00000000
[  300.999224] hub 2-0:1.0: hub_suspend
[  300.999246] usb usb2: bus suspend, wakeup 0
[  301.002231] ata1.00: Entering standby power mode
[  301.004222] hub 8-0:1.0: hub_resume
[  301.004275] hub 8-0:1.0: hub_suspend
[  301.004293] usb usb8: bus suspend, wakeup 0
[  301.004371] hub 6-0:1.0: hub_resume
[  301.004410] hub 6-0:1.0: hub_suspend
[  301.004424] usb usb6: bus suspend, wakeup 0
[  301.004495] hub 7-0:1.0: hub_resume
[  301.004534] hub 7-0:1.0: hub_suspend
[  301.004548] usb usb7: bus suspend, wakeup 0
[  301.004620] hub 5-0:1.0: hub_resume
[  301.004658] hub 5-0:1.0: hub_suspend
[  301.004672] usb usb5: bus suspend, wakeup 0
[  301.005220] hub 4-0:1.0: hub_resume
[  301.005260] hub 4-0:1.0: hub_suspend
[  301.005275] usb usb4: bus suspend, wakeup 0
[  301.005351] hub 1-0:1.0: hub_resume
[  301.005389] hub 1-0:1.0: hub_suspend
[  301.005403] usb usb1: bus suspend, wakeup 0
[  301.320060] ACPI: EC: interrupt blocked
[  301.320521] ehci-pci 0000:00:1d.7: wakeup: 1
[  301.320603] uhci_hcd 0000:00:1d.2: wakeup: 1
[  301.320608] uhci_hcd 0000:00:1d.2: --> PCI D0
[  301.320644] uhci_hcd 0000:00:1d.1: wakeup: 1
[  301.320648] uhci_hcd 0000:00:1d.1: --> PCI D0
[  301.320683] uhci_hcd 0000:00:1d.0: wakeup: 1
[  301.320738] uhci_hcd 0000:00:1d.0: --> PCI D2
[  301.320967] ehci-pci 0000:00:1a.7: wakeup: 1
[  301.321032] uhci_hcd 0000:00:1a.2: wakeup: 1
[  301.321081] uhci_hcd 0000:00:1a.2: --> PCI D2
[  301.321119] uhci_hcd 0000:00:1a.1: wakeup: 1
[  301.321122] uhci_hcd 0000:00:1a.1: --> PCI D0
[  301.321157] uhci_hcd 0000:00:1a.0: wakeup: 1
[  301.321211] uhci_hcd 0000:00:1a.0: --> PCI D2
[  301.332213] ehci-pci 0000:00:1a.7: --> PCI D3hot
[  301.332287] ehci-pci 0000:00:1d.7: --> PCI D3hot
[  301.333259] ACPI: PM: Preparing to enter system sleep state S3
[  301.345826] ACPI: EC: event blocked
[  301.345829] ACPI: EC: EC stopped
[  301.345831] ACPI: PM: Saving platform NVS memory
[  301.347482] Disabling non-boot CPUs ...
[  301.358452] ACPI: PM: Low-level resume complete
[  301.358492] ACPI: EC: EC started
[  301.358494] ACPI: PM: Restoring platform NVS memory
[  301.360029] ACPI: PM: Waking up from system sleep state S3
[  301.384290] ACPI: EC: interrupt unblocked
[  301.386938] usb usb7: root hub lost power or was reset
[  301.386996] usb usb8: root hub lost power or was reset
[  301.387109] usb usb1: root hub lost power or was reset
[  301.387451] usb usb1: usb resume
[  301.387810] hub 1-0:1.0: hub_reset_resume
[  301.388174] hub 1-0:1.0: trying to enable port power on 
non-switchable hub
[  301.388828] usb usb6: root hub lost power or was reset
[  301.389860] usb usb4: root hub lost power or was reset
[  301.390026] usb usb5: root hub lost power or was reset
[  301.391115] usb usb3: usb resume
[  301.391150] hub 3-0:1.0: hub_resume
[  301.391312] usb usb2: usb resume
[  301.391371] hub 2-0:1.0: hub_resume
[  301.393298] usb usb2-port1: status 0507 change 0000
[  301.393517] usb usb4: usb resume
[  301.393526] hub 4-0:1.0: hub_reset_resume
[  301.393529] hub 4-0:1.0: trying to enable port power on 
non-switchable hub
[  301.393572] usb usb5: usb resume
[  301.393580] hub 5-0:1.0: hub_reset_resume
[  301.393583] hub 5-0:1.0: trying to enable port power on 
non-switchable hub
[  301.393651] usb usb6: usb resume
[  301.393659] hub 6-0:1.0: hub_reset_resume
[  301.393661] hub 6-0:1.0: trying to enable port power on 
non-switchable hub
[  301.394042] ACPI: EC: event unblocked
[  301.394380] usb usb7: usb resume
[  301.394390] hub 7-0:1.0: hub_reset_resume
[  301.394393] hub 7-0:1.0: trying to enable port power on 
non-switchable hub
[  301.394846] usb usb8: usb resume
[  301.394856] hub 8-0:1.0: hub_reset_resume
[  301.394859] hub 8-0:1.0: trying to enable port power on 
non-switchable hub
[  301.395151] usb 2-1: usb resume
[  301.407569] i915 0000:00:02.0: vgaarb: VGA decodes changed: 
olddecodes=io+mem,decodes=io+mem:owns=io+mem
[  301.446267] usb 2-1: Waited 0ms for CONNECT
[  301.446274] usb 2-1: finish resume
[  301.446496] hub 2-1:1.0: hub_resume
[  301.446738] usb 2-1-port1: status 0507 change 0000
[  301.447487] usb 2-1-port4: status 0303 change 0004
[  301.448488] r8152-cfgselector 2-1.1: usb resume
[  301.459266] usb 2-1.4: Waited 0ms for CONNECT
[  301.459272] usb 2-1.4: finish resume
[  301.500260] r8152-cfgselector 2-1.1: Waited 0ms for CONNECT
[  301.500267] r8152-cfgselector 2-1.1: finish resume
[  301.703719] ata2: SATA link down (SStatus 0 SControl 300)
[  302.231255] clocksource: timekeeping watchdog on CPU0: Marking 
clocksource 'tsc' as unstable because the skew is too large:
[  302.231260] clocksource:                       'hpet' wd_nsec: 
686990643 wd_now: e82aa5 wd_last: 5212fe mask: ffffffff
[  302.231265] clocksource:                       'tsc' cs_nsec: 
495997904 cs_now: 5f58466b cs_last: 360f1164 mask: ffffffffffffffff
[  302.231269] clocksource:                       Clocksource 'tsc' 
skewed -190992739 ns (-190 ms) over watchdog 'hpet' interval of 
686990643 ns (686 ms)
[  302.231274] clocksource:                       'tsc' is current 
clocksource.
[  302.231279] tsc: Marking TSC unstable due to clocksource watchdog
[  302.231309] TSC found unstable after boot, most likely due to broken 
BIOS. Use 'tsc=unstable'.
[  302.231312] sched_clock: Marking unstable (302218066766, 
1180678)<-(302494932176, -263623254)
[  302.219394] clocksource: Not enough CPUs to check clocksource 'tsc'.
[  302.219425] clocksource: Switched to clocksource hpet
[  302.494221] pcieport 0000:00:1c.1: pciehp: Timeout on hotplug command 
0x0018 (issued 1123 msec ago)
[  302.494250] pcieport 0000:00:1c.0: pciehp: Timeout on hotplug command 
0x0018 (issued 1123 msec ago)
[  302.494327] pcieport 0000:00:1c.3: pciehp: Timeout on hotplug command 
0x0018 (issued 1123 msec ago)
[  302.503313] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
[  302.618321] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
[  302.660241] tpm tpm0: TPM is disabled/deactivated (0x6)
[  302.670557] OOM killer enabled.
[  302.670566] Restarting tasks ...
[  302.670842] hub 3-0:1.0: state 7 ports 6 chg 0000 evt 0000
[  302.670880] hub 3-0:1.0: hub_suspend
[  302.670924] hub 8-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  302.671024] hub 8-0:1.0: hub_suspend
[  302.671052] usb usb8: bus auto-suspend, wakeup 1
[  302.671088] hub 6-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  302.671106] hub 6-0:1.0: hub_suspend
[  302.671128] usb usb6: bus auto-suspend, wakeup 1
[  302.671161] hub 7-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  302.671179] hub 7-0:1.0: hub_suspend
[  302.671216] usb usb7: bus auto-suspend, wakeup 1
[  302.671248] hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  302.671266] hub 5-0:1.0: hub_suspend
[  302.671287] usb usb5: bus auto-suspend, wakeup 1
[  302.671317] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  302.671334] hub 4-0:1.0: hub_suspend
[  302.671356] usb usb4: bus auto-suspend, wakeup 1
[  302.671386] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  302.671403] hub 1-0:1.0: hub_suspend
[  302.671424] usb usb1: bus auto-suspend, wakeup 1
[  302.671455] hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0000
[  302.671469] hub 2-1:1.0: state 7 ports 4 chg 0000 evt 0010
[  302.671493] usb usb3: bus auto-suspend, wakeup 1
[  302.679716] done.
[  302.715864] video LNXVIDEO:00: Restoring backlight state
[  302.723732] PM: suspend exit

> 
> Alan Stern

Best Regards,
Mingcong Bai

