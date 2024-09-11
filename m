Return-Path: <stable+bounces-75808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2464974EE7
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 11:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B510B24623
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D614B960;
	Wed, 11 Sep 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dpk/DtQf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29E17DFE8;
	Wed, 11 Sep 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047809; cv=none; b=t2AKANYnaP5G/i/1iHp3/wZxEhQIeU/HsuHsK6u6PwqrRo2hwSOLAYcoOunl4VWNiRq3PfmgobdS9XKLpauFw8X06EeGZ3d+e9nIJtPf+s2EtBLjR89E8Y+1Fk1/6ec5ccXo2YB3Mx7xZjH3GBQARJxrc4bEJmdaVKVpUj0Tfhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047809; c=relaxed/simple;
	bh=EWMOQDrgbdeHEFspLRojh7jCLMPwWmpwnLfye5ARu2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyzBAEctDSrbfiiSX/pBuH0hA3PcdLsu1bJqTJwfknBIA1043R0ILwHGEkeDY5gzxOvxsqSgCLxBdjTwOkiLED3tAQHgA1dJAgCKmEhe8H6l5Zn5W80a4e0wYPHUB/LmLKdSkkuWzmVqTWg6MBTTPTEPuAok+1q4NBIVpE2adSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dpk/DtQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA2BC4CEC5;
	Wed, 11 Sep 2024 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726047809;
	bh=EWMOQDrgbdeHEFspLRojh7jCLMPwWmpwnLfye5ARu2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dpk/DtQfRV52ayuDT/7sejXVknvjwZbM/9rHMDYCo+YywoHLw9wBnRsXtYQX9s2so
	 oC/bCfpttyotj4Mu2DPx/FrcNZhUY2L5jF1e7k4WR9Ksgy51XnYCqynNwex1Ec/yf4
	 BaTXLCic3qTKy7xxW+NQJtcwQFnzBJwI7Fyuwk6Y=
Date: Wed, 11 Sep 2024 11:43:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Dan Williams <dan.j.williams@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [regression] frozen usb mouse pointer at boot
Message-ID: <2024091128-imperial-purchase-f5e7@gregkh>
References: <3724e8e8-ab71-4f64-8ba1-c5c9a617632f@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3724e8e8-ab71-4f64-8ba1-c5c9a617632f@leemhuis.info>

On Wed, Sep 11, 2024 at 09:55:03AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> I noticed a report about a linux-6.6.y regression in bugzilla.kernel.org
> that appears to be caused by this commit from Dan applied by Greg:
> 
> 15fffc6a5624b1 ("driver core: Fix uevent_show() vs driver detach race")
> [v6.11-rc3, v6.10.5, v6.6.46, v6.1.105, v5.15.165, v5.10.224, v5.4.282,
> v4.19.320]
> 
> The reporter did not check yet if mainline is affected; decided to
> forward the report by mail nevertheless, as the maintainer for the
> subsystem is also the maintainer for the stable tree. ;-)
> 
> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=219244 :

This is very odd, because:

> > The symptoms of this bug are as follows:
> > 
> > - After booting (to the graphical login screen) the mouse pointer
> > would frozen and only after unplugging and plugging-in again the usb
> > plug of the mouse would the mouse be working as expected.
> > - If one would log in without fixing the mouse issue, the mouse
> > pointer would still be frozen after login.
> > - The usb keyboard usually is not affected even though plugged into
> > the same usb-hub - thus logging in is possible.
> > - The mouse pointer is also frozen if the usb connector is plugged
> > into a different usb-port (different from the usb-hub)
> > - The pointer is moveable via the inbuilt synaptics trackpad

The patch from Dan should only affect when the module is unloaded, not
when the device is removed.

And it should not diferenciate between device types (i.e. mouse,
keyboard, etc.) as it affects ALL devices in the system.

> > The kernel log shows almost the same messages (not sure if the
> > differences mean anything in regards to this bug) for the initial
> > recognizing the mouse (frozen mouse pointer) and the re-plugged-in mouse
> > (and subsequently moveable mouse pointer):
> > 
> > [kernel] [    8.763158] usb 1-2.2.1.2: new low-speed USB device number 10 using xhci_hcd
> > [kernel] [    8.956028] usb 1-2.2.1.2: New USB device found, idVendor=045e, idProduct=00cb, bcdDevice= 1.04
> > [kernel] [    8.956036] usb 1-2.2.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > [kernel] [    8.956039] usb 1-2.2.1.2: Product: Microsoft Basic Optical Mouse v2.0 
> > [kernel] [    8.956041] usb 1-2.2.1.2: Manufacturer: Microsoft 
> > [kernel] [    8.963554] input: Microsoft  Microsoft Basic Optical Mouse v2.0  as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2.1/1-2.2.1.2/1-2.2.1.2:1.0/0003:045E:00CB.0002/input/input18
> > [kernel] [    8.964417] hid-generic 0003:045E:00CB.0002: input,hidraw1: USB HID v1.11 Mouse [Microsoft  Microsoft Basic Optical Mouse v2.0 ] on usb-0000:00:14.0-2.2.1.2/input0
> > 
> > [kernel] [   31.258381] usb 1-2.2.1.2: USB disconnect, device number 10
> > [kernel] [   31.595051] usb 1-2.2.1.2: new low-speed USB device number 16 using xhci_hcd
> > [kernel] [   31.804002] usb 1-2.2.1.2: New USB device found, idVendor=045e, idProduct=00cb, bcdDevice= 1.04
> > [kernel] [   31.804010] usb 1-2.2.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > [kernel] [   31.804013] usb 1-2.2.1.2: Product: Microsoft Basic Optical Mouse v2.0 
> > [kernel] [   31.804016] usb 1-2.2.1.2: Manufacturer: Microsoft 
> > [kernel] [   31.812933] input: Microsoft  Microsoft Basic Optical Mouse v2.0  as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2.1/1-2.2.1.2/1-2.2.1.2:1.0/0003:045E:00CB.0004/input/input20
> > [kernel] [   31.814028] hid-generic 0003:045E:00CB.0004: input,hidraw1: USB HID v1.11 Mouse [Microsoft  Microsoft Basic Optical Mouse v2.0 ] on usb-0000:00:14.0-2.2.1.2/input0
> > 
> > Differences:
> > 
> > ../0003:045E:00CB.0002/input/input18 vs ../0003:045E:00CB.0004/input/input20

That's normal, just a different name for the device, they are always
dynamic.

> > and
> > 
> > hid-generic 0003:045E:00CB.0002 vs hid-generic 0003:045E:00CB.0004

Again, different device names, all should be fine.

> > The connector / usb-port was not changed in this case!
> > 
> > 
> > The symptoms of this bug have been present at one point in the
> > recent
> > past, but with kernel v6.6.45 (or maybe even some version before that)
> > it was fine. But with 6.6.45 it seems to be definitely fine.
> > 
> > But with v6.6.46 the symptoms returned. That's the reason I
> > suspected
> > the kernel to be the cause of this issue. So I did some bisecting -
> > which wasn't easy because that bug would often times not appear if the
> > system was simply rebooted into the test kernel.
> > As the bug would definitely appear on the affected kernels (v6.6.46
> > ff) after shutting down the system for the night and booting the next
> > day, I resorted to simulating the over-night powering-off by shutting
> > the system down, unplugging the power and pressing the power button to
> > get rid of residual voltage. But even then a few times the bug would
> > only appear if I repeated this procedure before booting the system again
> > with the respective kernel.
> > 
> > This is on a Thinkpad with Kaby Lake and integrated Intel graphics. 
> > Even though it is a laptop, it is used as a desktop device, and the
> > internal battery is disconnected, the removable battery is removed as
> > the system is plugged-in via the power cord at all times (when in use)!
> > Also, the system has no power (except for the bios battery, of
> > course)
> > over night as the power outlet is switched off if the device is not in use.
> > 
> > Not sure if this affects the issue - or how it does. But for
> > successful bisecting I had to resort to the above procedure.
> > 
> > Bisecting the issue (between the release commits of v6.6.45 and
> > v6.6.46) resulted in this commit [1] being the probable culprit.
> > 
> > I then tested kernel v6.6.49. It still produced the bug for me. So I
> > reverted the changes of the assumed "bad commit" and re-compiled kernel
> > v6.6.49. With this modified kernel the bug seems to be gone.

This is odd.

Does the latest 6.10.y release also show this problem?

I can't duplicate this here, and it's the first I've heard of it (given
that USB mice are pretty popular, I would suspect others would have hit
it as well...)

thanks,

greg k-h

