Return-Path: <stable+bounces-123204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17467A5C140
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F20D3A7636
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 12:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6DA256C6F;
	Tue, 11 Mar 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Et031xQH"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D15253B5C;
	Tue, 11 Mar 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696262; cv=none; b=QIj3EdQBlCayVCxu9cW6AfrYRJQsjZwSDcHQvjdL1IKMmnwYWydCSAhGbNZnEwlzshHesaGTr6q6eGGBEcyf5lkPv4kt+S1khByQbYSLOrA8b/jUKZnwk4v7pbV0gSTi1EB6MjSsdwHbGShm0WvBUKYPg9Ofig9FubLOeb6N1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696262; c=relaxed/simple;
	bh=PnMjqCT/JDu+O+HEOB1WsgvgH2yOOs6UrjeOok8Qu+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMnQyMV3mwwLLfjr86C56NXKpDvdUGvZxpU2VmRDMUF7eIFulfGTauESI8osIcEjHDylOMWspQ/Wc6wyWQQdalwSAjaHDAw6lDifoua8woO86zlkP5uK0IVVGJTYwJPoQurXMv64kbY17hc3Ji8GhdGg5q8drPlsdLqJ/Fc6tcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=Et031xQH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741696257; x=1742301057; i=fiona.klute@gmx.de;
	bh=LhDDnClaxOdOPD9NJmQebCFr4MKnshM8uyYZcMBPHH8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Et031xQH81jdY0m6qYRU+dopINSohNm5BciAVinV5sJ5sB6A2JYcwOBQiGS6WBYX
	 6gWp+r6+PpK5BXureDi6t1juTUnR78j17ogJSV0ywmRJaeDIgk5wNtp+ahDU8Ra2T
	 f5afxjTVg+9XRrX3Sw6/I8DYhDAkCEU7pTvRZ31AGj35RFqdAvcbqPTOk3tJ0lLf1
	 2zH9eN6O98T4L6TbPVIrn0BzeUa14THFkyD8oR97mTVlU05B1UaLlffHTaU15g+EJ
	 tyEYotwSoGN+0pjMpEFSj6ZRd/FBXegvO5JKs2oTwqfJ81E29qZpH1uDRww/c+lU7
	 TgEoyqqy4OcyRSgUHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.124.191]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel7v-1tKHy94AEP-00hh0X; Tue, 11
 Mar 2025 13:30:57 +0100
Message-ID: <4577e7d7-cadc-41c6-b93f-eca7d5a8eb46@gmx.de>
Date: Tue, 11 Mar 2025 13:30:54 +0100
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
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <11f5be1d-9250-4aba-8f51-f231b09d3992@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CJ4PCIgvMEwKbmYHBf2qwBT/20N1H9cDkLGz0RC5+6LYf9G8HH3
 oXsUXeF6dZSbsoqr5oC6lFEnwAlxil23+0Hn6c+Jmh52A5cl5nN2brX7/lG7I77ViAszN6E
 +gsWXGnYhgvuIVLU3ipb7CImvTtXJZ5cSS4KAI22DI29gAVw26I6UxevBNsE8K3v2vpjble
 lCXp6Fpv17cD6POfbRu/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a/pTbA+FHlc=;yX9IyQb5sXNqcs4abRwKR1rnJRt
 B7aqAPKISMUBpuC5SKSGsPx+NxxlWSpSRNVxcdN/g3H0tHbiIMFJC2i2fBAiiQ7ZkaUVUK6bj
 xoR1eWKFQFka9DHnMgUlaLzUitq1Zl1RtIoymYyBzEr8NwpBpKa7kypdSLUl+LoZ3hq9CrEsv
 yLQgEIDTbM0/RBgqN3LifZ+/hEzLBZI6Q7Pn7QczIPEq2gHMWTC1dQJL+3c09t8SYR9FhYNzv
 FUGQTENYN3DTAqnSAQK1hHKNIKcMMNzl+KMiT4yJxJI+TAMM4SRcxnpDBnrQKstBO8Esz4o5g
 nVfiEkXkUfX5KPyld9qp/9ZaTItLabhepypTstK7iarurhPO1Lw3U5ZgtGDp3RJHTtTg7TC5Q
 YCmlWsQIa8dt0Sx7lbJHv3dVKdb/IP0/1IEnLesuPjYLVHVHUIkMpuK0P/1keM0AqDJWZXnXD
 QvG09+WWMKTK89Nj/cSQ4zEEqA9PnA8Ygg1obCJ9hGzxfTL/D75WiFr2mK3Yo5IQ9PkEI0fF0
 b9qjhCDlLZqCeFgI78at4dQnlSL5hEY24ydFHOarT1TCIQpKt1KloZU4/D5QhF2+OC1kdMM7h
 KdTTnzdSLYoDUiQyu3N88JeysS3RpVTCtiU+wJ7cykDVgnMiM+2Lz39oKWnX0qz68E0k2khEY
 vlZsSO8XkmiUYoYkZ+AjDbiFAsLrCVifXx7g8Ni+i8REC3mszDnSXKAmsiP9PJGteCYBNgZqP
 KldPU9zDKPfuNiXz/9qkmWtBafhntXF4ectcs2SnMgaq6bdUlTVkQvnztEiKodPdN417AK+Th
 gDXXKLmQBrIAvtgdWQFIeif7awZfrb39O2Ljhv3ebniRFlR7deFQoMCVZS01iOaxQ1viwkQQo
 pH5DeBeXBADZT5+k0F3wY3SzvhIj6Ljf+bTSQwvyB1DllQTybsjwbnfkoe9NWd1DQFWA6MZm4
 CrdpBng/4/83PUboS+tHW8pD/IQGCRwqW5+cjvVEZpTCj3AagvfAUodIfsYsfQ+UKCoRTtm1K
 DU2iJnHuFaxRKxwc9ubJ/rXFwWD3Bm37+QngMjbcp0IE/iXxV2AoYyLnw1E8TnldSseAbpZhG
 m9vk7OUIzgqUbctVblJiB3wvix6qdjZaHfvFXvpQ6WWXqzLPrDkePxOBZw6+jwydeHvJsncnd
 pSrm0FNyogsE1jK2z7uoRz6shl1KSJLLPFsp2svl1mZWAmNWcoRSK0kLW5zFCzXJHTh11n1s4
 E2PjOUQA3uA4pwGF6bZkYTYATrt19UqiwsZ8qnjZCU1waLDTfO8RE2soiGMjnSKTRs2riibXh
 uw78EbkQMVO/RKZ8+agSJlo6npigB2JNO5ggFw1thKkDlaz7pVYZaQT7Mrt5GWqwVGArIKDpl
 6tesbwwskRxCL+ul9zNnLpI6IXh0qW+7xPeNu94seQPXzODHNGzGXPXNKHWGqqueUbb+Rw4nD
 knZ2l1hFi+yPtsaBlxZ3Hp/nRd8c=

Am 10.03.25 um 22:27 schrieb Andrew Lunn:
> On Mon, Mar 10, 2025 at 05:59:31PM +0100, Fiona Klute wrote:
>> If a new reset event appears before the previous one has been
>> processed, the device can get stuck into a reset loop. This happens
>> rarely, but blocks the device when it does, and floods the log with
>> messages like the following:
>>
>>    lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
>>
>> The only bit that the driver pays attention to in the interrupt data
>> is "link was reset". If there's a flapping status bit in that endpoint
>> data (such as if PHY negotiation needs a few tries to get a stable
>> link), polling at a slower rate allows the state to settle.
>
> Could you expand on this a little bit more. What is the issue you are
> seeing?

What happens is that *sometimes* when the interface is activated (up, im
my case via NetworkManager) during boot, the "kevent 4 may have been
dropped" message starts to be emitted about every 6 or 7 ms. The
interface is not usable. Today I also got this trace (and an equivalent
one at about 90s):

[   27.905405] lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
[   27.911834] lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
[   27.918199] rcu: INFO: rcu_sched self-detected stall on CPU
[   27.918205] rcu:   0-....: (3351 ticks this GP)
idle=3De6bc/1/0x4000000000000000 softirq=3D671/671 fqs=3D2300
[   27.918214] rcu:   (t=3D5250 jiffies g=3D113 q=3D10467 ncpus=3D4)
[   27.918224] CPU: 0 UID: 0 PID: 64 Comm: kworker/0:4 Tainted: G
  C         6.13.5 #1
[   27.918232] Tainted: [C]=3DCRAP
[   27.918234] Hardware name: Raspberry Pi Compute Module 4 Rev 1.1 (DT)
[   27.918238] Workqueue: events_power_efficient phy_state_machine
[   27.918252] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
BTYPE=3D--)
[   27.918257] pc : console_flush_all+0x2b0/0x4f8
[   27.918266] lr : console_flush_all+0x3f0/0x4f8
[   27.918271] sp : ffff8000805c3880
[   27.918273] x29: ffff8000805c38d0 x28: 0000000000000001 x27:
ffffcb3e232df2e8
[   27.918280] x26: ffffcb3e231bdaf0 x25: 0000000000000000 x24:
ffffcb3e231d40b8
[   27.918287] x23: 0000000000000000 x22: ffff8000805c3940 x21:
0000000000000000
[   27.918293] x20: ffff8000805c393b x19: ffffcb3e233950c8 x18:
ffff8000805c3560
[   27.918299] x17: 6c6f72746e6f6320 x16: 776f6c66202d206c x15:
ffff8001005c3717
[   27.918305] x14: 0000000000000000 x13: 646570706f726420 x12:
6e65656220657661
[   27.918311] x11: 682079616d203420 x10: 746e6576656b203a x9 :
ffffcb3e22b36c0c
[   27.918317] x8 : ffff8000805c3788 x7 : 0000000000000000 x6 :
ffff8000805c3840
[   27.918323] x5 : ffffcb3e231be000 x4 : 0000000000000000 x3 :
ffffcb3e231be3e8
[   27.918329] x2 : 0000000000000000 x1 : ffffcb3e21f25414 x0 :
ffff9e55d866a000
[   27.918335] Call trace:
[   27.918338]  console_flush_all+0x2b0/0x4f8 (P)
[   27.918346]  console_unlock+0x8c/0x170
[   27.918352]  vprintk_emit+0x238/0x3b8
[   27.918357]  dev_vprintk_emit+0xe4/0x1b8
[   27.918364]  dev_printk_emit+0x64/0x98
[   27.918368]  __netdev_printk+0xc8/0x228
[   27.918376]  netdev_info+0x70/0xa8
[   27.918382]  phy_print_status+0xcc/0x138
[   27.918386]  lan78xx_link_status_change+0x78/0xb0
[   27.918392]  phy_link_change+0x38/0x70
[   27.918398]  phy_check_link_status+0xa8/0x110
[   27.918405]  _phy_start_aneg+0x5c/0xb8
[   27.918409]  lan88xx_link_change_notify+0x5c/0x128
[   27.918416]  _phy_state_machine+0x12c/0x2b0
[   27.918420]  phy_state_machine+0x34/0x80
[   27.918425]  process_one_work+0x150/0x3b8
[   27.918432]  worker_thread+0x2a4/0x4b8
[   27.918438]  kthread+0xec/0xf8
[   27.918442]  ret_from_fork+0x10/0x20
[   27.918534] lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
[   27.924985] lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped

In this case the interface recovered about 150s after boot (the messages
stopped and it became active), which correlates with when I logged in
over serial to check what is going on. I do not know if that *caused* it
to recover, the log gives no indication, but it's the first time I've
seen the interface get out of the stuck state (before it was in CI runs
where the device simply got reset, and I could only check logs
afterwards). Unfortunately I have no reliable way to reproduce the bug,
it just appears randomly during some boots.

Another problem is that this was *with* the patch, so it's clearly not a
correct solution and at most makes the issue less frequent (I had tested
 >300 boots successfully before sending it).

> I had a quick look at the PHY handling code, and it looks broken. The
> only time a MAC driver should look at members of phydev is during the
> adjust link callback, so lan78xx_link_status_change(). Everything is
> guaranteed to be consistent at this time. However, the current
> lan78xx_link_status_change() only adjusts EEE setting. The PHY code in
> lan78xx_link_reset() looks wrong. MAC drivers should not be reading
> PHY registers, or calling functions like phy_read_status(). Setting
> flow control should be performed in lan78xx_link_status_change() using
> phydev->pause and phydev->asym_pause.
Thanks for looking into this! I'm not familiar with ethernet drivers
yet, do you have a hint on where I can learn what those functions
*should* be doing (and thus how they might be fixed)?
Documentation/driver-api/phy/phy.rst has only a very general overview of
phy drivers.

Best regards,
Fiona


