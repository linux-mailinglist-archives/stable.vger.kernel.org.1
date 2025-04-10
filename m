Return-Path: <stable+bounces-132119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E4A84607
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5001F188C985
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B328C5A0;
	Thu, 10 Apr 2025 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="CJYlpJq7"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC82228A404;
	Thu, 10 Apr 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294476; cv=none; b=Gu37jmvLH00R+XwUPnDd48E+UrTA5/7yPA6A6XXgFMpzICCxFSN97INcnFzD2FbxjTlXV7fLxBaBrpYhSxqX0rwr3sTfDZr6JB2DE8hUFeCgpscu9Vh0VfggZoNQg2KeO0djbHf+U/6CERGOXNE9tysP4tcfuyh5i6KgSsIr39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294476; c=relaxed/simple;
	bh=OdhU+EJUghhV3v3RVx2zB3MQbpOxMYciiE3+5xyiXUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT2O+1YWti1823GMkzBJobXZLuZfYSrKP/Q2YPDeyDQikMuFSbKtp/vHKMHKD3SuHBdRrddkMGrSaAkrKEZ+xfOcagEKmJzlZNL2/dmQhxU12+5UNIDy031WWj/rVbUJ27i45+tAtFK/5oNd3YdZroT4cbMb+OrcRvNwlmwjByA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=CJYlpJq7; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744294457; x=1744899257; i=fiona.klute@gmx.de;
	bh=9etLMjv14bSec6zTDPFpU7N6u3iqZs2Urq3NgN1z2dM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CJYlpJq7msJ8uB80YOg25ZCK/pRL64zNZWAyMRzp4aBw9t+dLYpt4EHpJTAKqTAu
	 NsaUIGV5hfTLVsNbzP5uelNG7KONtest0W0DtjeFRlQNiXptzh/SzxtyNJcuvm+hc
	 /8qNRGS3VWRyo5fNl1y9B4fwL8e8ifTCb/wR3uokCu2UATbGCqqNNeb08O/k42JuE
	 fSkurmeFofPM/EVWh2Y7xrw9HlzzGBkwg+nmfd1DRixzbRWARSQ0UT+Py3jLIbaMw
	 o/YyVi/d23riwDIbV4s+v6/vNFIvuC0H+V8JIq8SXaTgM/c2dBkmKqvVYBIq4CFiI
	 5iAPSE3u5R6DsZVEWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.125.230]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1tMzOi392W-00iAJC; Thu, 10
 Apr 2025 16:14:16 +0200
Message-ID: <dc8ef510-8f7d-4c96-9fd8-76b67a22aaf9@gmx.de>
Date: Thu, 10 Apr 2025 16:14:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Enforce a minimum interrupt polling
 period
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
 stable@vger.kernel.org
References: <20250310165932.1201702-1-fiona.klute@gmx.de>
 <11f5be1d-9250-4aba-8f51-f231b09d3992@lunn.ch>
 <4577e7d7-cadc-41c6-b93f-eca7d5a8eb46@gmx.de>
 <42b5d49b-caf8-492d-8dba-b5292279478a@lunn.ch>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <42b5d49b-caf8-492d-8dba-b5292279478a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q4GqjF8IM+d2KHH7l/asHFmwx6gLQoyJXU3ag134w5aaUHOrOcd
 igsT50BDbB6y+5SMzVO6tFTDWEX8XOy/kgto9rjUzHsU21jVkLh0YWvN/C/ONtRIcujUBNd
 xwU3KOtvErEUxUpv5eraUjEtJ73TmfSSRTmawhIgFgqcVJ9J7tCligscs8zAJcMJxRueKTi
 wM7i31CRPUVTwOaMnCCvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mZKfw9FJemM=;lwEom+NcAnwnci9n1ctmt2L7lE3
 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
 JHP62kjDCTwDg564UN1AXFdAwR18PvlhmA

Am 11.03.25 um 14:22 schrieb Andrew Lunn:
> On Tue, Mar 11, 2025 at 01:30:54PM +0100, Fiona Klute wrote:
>> Am 10.03.25 um 22:27 schrieb Andrew Lunn:
>>> On Mon, Mar 10, 2025 at 05:59:31PM +0100, Fiona Klute wrote:
>>>> If a new reset event appears before the previous one has been
>>>> processed, the device can get stuck into a reset loop. This happens
>>>> rarely, but blocks the device when it does, and floods the log with
>>>> messages like the following:
>>>>
>>>>     lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
>>>>
>>>> The only bit that the driver pays attention to in the interrupt data
>>>> is "link was reset". If there's a flapping status bit in that endpoin=
t
>>>> data (such as if PHY negotiation needs a few tries to get a stable
>>>> link), polling at a slower rate allows the state to settle.
>>>
>>> Could you expand on this a little bit more. What is the issue you are
>>> seeing?
>>
>> What happens is that *sometimes* when the interface is activated (up, i=
m
>> my case via NetworkManager) during boot, the "kevent 4 may have been
>> dropped" message starts to be emitted about every 6 or 7 ms.
>
> This sounding a bit like an interrupt storm. The PHY interrupt is not
> being cleared correctly. PHY interrupts are level interrupts, so if
> you don't clear the interrupt at the source, it will fire again as
> soon as you re-enable it.
>
> So which PHY driver is being used? If you look for the first kernel
> message about the lan78xx it probably tells you.
>
>> [   27.918335] Call trace:
>> [   27.918338]  console_flush_all+0x2b0/0x4f8 (P)
>> [   27.918346]  console_unlock+0x8c/0x170
>> [   27.918352]  vprintk_emit+0x238/0x3b8
>> [   27.918357]  dev_vprintk_emit+0xe4/0x1b8
>> [   27.918364]  dev_printk_emit+0x64/0x98
>> [   27.918368]  __netdev_printk+0xc8/0x228
>> [   27.918376]  netdev_info+0x70/0xa8
>> [   27.918382]  phy_print_status+0xcc/0x138
>> [   27.918386]  lan78xx_link_status_change+0x78/0xb0
>> [   27.918392]  phy_link_change+0x38/0x70
>> [   27.918398]  phy_check_link_status+0xa8/0x110
>> [   27.918405]  _phy_start_aneg+0x5c/0xb8
>> [   27.918409]  lan88xx_link_change_notify+0x5c/0x128
>> [   27.918416]  _phy_state_machine+0x12c/0x2b0
>> [   27.918420]  phy_state_machine+0x34/0x80
>> [   27.918425]  process_one_work+0x150/0x3b8
>> [   27.918432]  worker_thread+0x2a4/0x4b8
>> [   27.918438]  kthread+0xec/0xf8
>> [   27.918442]  ret_from_fork+0x10/0x20
>> [   27.918534] lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
>> [   27.924985] lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
>
> Ah, O.K. This tells me the PHY is a lan88xx. And there is a workaround
> involved for an issue in this PHY. Often PHYs are driven by polling
> for status changes once per second. Not all PHYs/boards support
> interrupts. It could be this workaround has only been tested with
> polling, not interrupts, and so is broken when interrupts are used.
>
> As a quick hack test, in lan78xx_phy_init()
>
> 	/* if phyirq is not set, use polling mode in phylib */
> 	if (dev->domain_data.phyirq > 0)
> 		phydev->irq =3D dev->domain_data.phyirq;
> 	else
> 		phydev->irq =3D PHY_POLL;
>
> Hard code phydev->irq to PHY_POLL, so interrupts are not used.
>
> See if you can reproduce the issue when interrupts are not used.
It took a while, but I'm fairly confident now that the workaround works,
I've had over 1000 boots on the hardware in question and didn't see the
bug. Someone going by upsampled reported the same in the issue on Github
[1], and pointed out that people working with some Nvidia board and a
LAN7800 USB device came to the same conclusion a while ago [2].

That leaves me with the question, what does that mean going forward?
Would it make sense to add a quirk to unconditionally force polling on
lan88xx, at least until/unless the interrupt handling can be fixed?

Best regards,
Fiona

[1] https://github.com/raspberrypi/linux/issues/2447#issuecomment-27727890=
88
[2]
https://forums.developer.nvidia.com/t/jetson-xavier-and-lan7800-problem/14=
2134/11


