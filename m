Return-Path: <stable+bounces-75801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9986974BEB
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 09:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C3B2172E
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A821422AB;
	Wed, 11 Sep 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SsYm+jLk"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC113CFA1;
	Wed, 11 Sep 2024 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041313; cv=none; b=VbFJYfvKYCd+HIG5S7bsginiQx0aUSpwciZok/aSUmnRtA/6AEpsUA9uFqRSyartcVKxi0Q6Ll1n3+Q4tTYXGzWzzkS0pMXP3GuslqC4A60bOUrFCEodyRNaJoCjsondCM30yeTexBGPyfYIQAh2tOblvKU/iJv82d7fhx/KkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041313; c=relaxed/simple;
	bh=EA2tEPCTXn6CLL+yTzdOoB+ZdBX9EA2j8pmKlZ6sF5c=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=DP7mph7Ta/OFjvq8BhlG8ptN2uOFXJ+vmOZP741K3VvIDn15umyaezvCh+j8/0Ea85zTx9U4lSqdxuL06czD4vFTOTOM2MWUTIl7CPSa3NFyCA2v+612igzOL+5W4ppK03S0+B4Ui1KUg+lznjxHl4zFbdJi4CHc94bDxyGyMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SsYm+jLk; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Cc:
	Subject:Reply-To:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=fV7E5LQGvZ58qV7zl++1wTRM8EAH4UQbWhnGhcyslZw=; t=1726041311;
	x=1726473311; b=SsYm+jLkKj9sbF44XD1kH/M4WsDSGW7Dg0G6JMeF9LrFxd4uJ6THLDRO/hHw9
	auy/McHCDfzcs7a/N4YociK29sdweHkweMbzPWX1Z6RmPTiMSo8yArTY8Mm9YleblBIwwke7C/imE
	D+Lj7DZ6uro0gEUMckwNjnO/1xdeTWQvTvCRFJCC2NHcSMr+wYRvJcHz3uWGahtJ5qywIAqgoZe/2
	N60gbMqRoOSnTKrKv0mutnyXvbqjUA2M2znz/6vyMLNWh08yawapEily/EKOSZLlLwtAO/nzNUcgg
	OV4ACW8ZkPuIfXj/N8Z1ibT7Cl9US3IFcz9+jo6rP3PMIzfkQg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1soIBr-0004CD-UF; Wed, 11 Sep 2024 09:55:04 +0200
Message-ID: <3724e8e8-ab71-4f64-8ba1-c5c9a617632f@leemhuis.info>
Date: Wed, 11 Sep 2024 09:55:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] frozen usb mouse pointer at boot
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1726041311;adc16418;
X-HE-SMSGID: 1soIBr-0004CD-UF

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a report about a linux-6.6.y regression in bugzilla.kernel.org
that appears to be caused by this commit from Dan applied by Greg:

15fffc6a5624b1 ("driver core: Fix uevent_show() vs driver detach race")
[v6.11-rc3, v6.10.5, v6.6.46, v6.1.105, v5.15.165, v5.10.224, v5.4.282,
v4.19.320]

The reporter did not check yet if mainline is affected; decided to
forward the report by mail nevertheless, as the maintainer for the
subsystem is also the maintainer for the stable tree. ;-)

To quote from https://bugzilla.kernel.org/show_bug.cgi?id=219244 :

> The symptoms of this bug are as follows:
> 
> - After booting (to the graphical login screen) the mouse pointer
> would frozen and only after unplugging and plugging-in again the usb
> plug of the mouse would the mouse be working as expected.
> - If one would log in without fixing the mouse issue, the mouse
> pointer would still be frozen after login.
> - The usb keyboard usually is not affected even though plugged into
> the same usb-hub - thus logging in is possible.
> - The mouse pointer is also frozen if the usb connector is plugged
> into a different usb-port (different from the usb-hub)
> - The pointer is moveable via the inbuilt synaptics trackpad
> 
> 
> The kernel log shows almost the same messages (not sure if the
> differences mean anything in regards to this bug) for the initial
> recognizing the mouse (frozen mouse pointer) and the re-plugged-in mouse
> (and subsequently moveable mouse pointer):
> 
> [kernel] [    8.763158] usb 1-2.2.1.2: new low-speed USB device number 10 using xhci_hcd
> [kernel] [    8.956028] usb 1-2.2.1.2: New USB device found, idVendor=045e, idProduct=00cb, bcdDevice= 1.04
> [kernel] [    8.956036] usb 1-2.2.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [kernel] [    8.956039] usb 1-2.2.1.2: Product: Microsoft Basic Optical Mouse v2.0 
> [kernel] [    8.956041] usb 1-2.2.1.2: Manufacturer: Microsoft 
> [kernel] [    8.963554] input: Microsoft  Microsoft Basic Optical Mouse v2.0  as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2.1/1-2.2.1.2/1-2.2.1.2:1.0/0003:045E:00CB.0002/input/input18
> [kernel] [    8.964417] hid-generic 0003:045E:00CB.0002: input,hidraw1: USB HID v1.11 Mouse [Microsoft  Microsoft Basic Optical Mouse v2.0 ] on usb-0000:00:14.0-2.2.1.2/input0
> 
> [kernel] [   31.258381] usb 1-2.2.1.2: USB disconnect, device number 10
> [kernel] [   31.595051] usb 1-2.2.1.2: new low-speed USB device number 16 using xhci_hcd
> [kernel] [   31.804002] usb 1-2.2.1.2: New USB device found, idVendor=045e, idProduct=00cb, bcdDevice= 1.04
> [kernel] [   31.804010] usb 1-2.2.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [kernel] [   31.804013] usb 1-2.2.1.2: Product: Microsoft Basic Optical Mouse v2.0 
> [kernel] [   31.804016] usb 1-2.2.1.2: Manufacturer: Microsoft 
> [kernel] [   31.812933] input: Microsoft  Microsoft Basic Optical Mouse v2.0  as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2.1/1-2.2.1.2/1-2.2.1.2:1.0/0003:045E:00CB.0004/input/input20
> [kernel] [   31.814028] hid-generic 0003:045E:00CB.0004: input,hidraw1: USB HID v1.11 Mouse [Microsoft  Microsoft Basic Optical Mouse v2.0 ] on usb-0000:00:14.0-2.2.1.2/input0
> 
> Differences:
> 
> ../0003:045E:00CB.0002/input/input18 vs ../0003:045E:00CB.0004/input/input20
> 
> and
> 
> hid-generic 0003:045E:00CB.0002 vs hid-generic 0003:045E:00CB.0004
> 
> 
> The connector / usb-port was not changed in this case!
> 
> 
> The symptoms of this bug have been present at one point in the
> recent
> past, but with kernel v6.6.45 (or maybe even some version before that)
> it was fine. But with 6.6.45 it seems to be definitely fine.
> 
> But with v6.6.46 the symptoms returned. That's the reason I
> suspected
> the kernel to be the cause of this issue. So I did some bisecting -
> which wasn't easy because that bug would often times not appear if the
> system was simply rebooted into the test kernel.
> As the bug would definitely appear on the affected kernels (v6.6.46
> ff) after shutting down the system for the night and booting the next
> day, I resorted to simulating the over-night powering-off by shutting
> the system down, unplugging the power and pressing the power button to
> get rid of residual voltage. But even then a few times the bug would
> only appear if I repeated this procedure before booting the system again
> with the respective kernel.
> 
> This is on a Thinkpad with Kaby Lake and integrated Intel graphics. 
> Even though it is a laptop, it is used as a desktop device, and the
> internal battery is disconnected, the removable battery is removed as
> the system is plugged-in via the power cord at all times (when in use)!
> Also, the system has no power (except for the bios battery, of
> course)
> over night as the power outlet is switched off if the device is not in use.
> 
> Not sure if this affects the issue - or how it does. But for
> successful bisecting I had to resort to the above procedure.
> 
> Bisecting the issue (between the release commits of v6.6.45 and
> v6.6.46) resulted in this commit [1] being the probable culprit.
> 
> I then tested kernel v6.6.49. It still produced the bug for me. So I
> reverted the changes of the assumed "bad commit" and re-compiled kernel
> v6.6.49. With this modified kernel the bug seems to be gone.
> 
> Now, I assume the commit has a reason for being introduced, but
> maybe
> needs some adjusting in order to avoid this bug I'm experiencing on my
> system.
> Also, I can't say why the issue appeared in the past even without
> this
> commit being present, as I haven't bisected any kernel version before
> v6.6.45.
> 
> 
> [1]:
> 
> 4d035c743c3e391728a6f81cbf0f7f9ca700cf62 is the first bad commit
> commit 4d035c743c3e391728a6f81cbf0f7f9ca700cf62
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Fri Jul 12 12:42:09 2024 -0700
> 
>     driver core: Fix uevent_show() vs driver detach race
>     
>     commit 15fffc6a5624b13b428bb1c6e9088e32a55eb82c upstream.
>     
>     uevent_show() wants to de-reference dev->driver->name. There is no clean

See the ticket for more details. Note, you have to use bugzilla to reach
the reporter, as I sadly[1] can not CCed them in mails like this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 4d035c743c3e391728a6f81cbf0f7f9ca700cf62
#regzbot from: brmails+k
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219244
#regzbot title: driver core: frozen usb mouse pointer at boot
#regzbot ignore-activity

