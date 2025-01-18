Return-Path: <stable+bounces-109428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EF4A15B9A
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 07:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FBE3A93FE
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 06:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1860814A09A;
	Sat, 18 Jan 2025 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uHGlGhW+"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFF13B2A9
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737180620; cv=none; b=fYgaXRwxlieeQVd4Hz79wIjKK/iCtruqt9g0R/Iw3z3zU6A3cXDZhfdN22LNiUxTwyYMQ+WGLHaVdqHIErF/VlLx74lgMd+kVzFI66CH1c9GdsgtSkxKIYBzJyekds1QQW3N1bHH/7J3mcsKelB7lka6kET+B6nMyLNHSJNXR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737180620; c=relaxed/simple;
	bh=qvp+vj9B9b/5QOQJQV8LzHBpf2GzxI5mxi+u+Q2cmDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hS9jH68kmZhCgPB06bsMe2FjC2jnZN2J/FW6a5TvBSl4aqid2g4XGuMEZleFti8LTVBu1HadbHFGMSVhFy+49bfu2fgxPNQrkZujjfF3yqotfWwfxKCpwsNBaISQl5463j3EqQMdOQrCZtnL9ragaUD/rfSsb7bISeXqfm3p3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uHGlGhW+; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250118061015epoutp0112c62fab74594a3f3205ce3f7c2e08ff~btJDonNgv0411704117epoutp01-
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 06:10:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250118061015epoutp0112c62fab74594a3f3205ce3f7c2e08ff~btJDonNgv0411704117epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737180615;
	bh=SFjx4bqj1nep3JVl84W3D1/cwhpIa9Kam0/A9tc2sww=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=uHGlGhW+ZAoHZDa451qZCBj5QbJUlfGt0cqKKJXfRl4eo6uTLf8AKIWKfx5CAXQ2A
	 DoHzxue2VIvLegnSsm+IeZYwv6jItVPSjUp+1sew760VavkuhZL3q87K8QM1HwTcAB
	 CKPM9f0vTd/NP2nDmLn2inBi4Q9+rUAYDxT3W2as=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250118061014epcas5p44dfdcad7a27416b95c2772e494fba194~btJC5kONt3104431044epcas5p4q;
	Sat, 18 Jan 2025 06:10:14 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YZmRT484yz4x9Ps; Sat, 18 Jan
	2025 06:10:13 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	51.82.19710.5C54B876; Sat, 18 Jan 2025 15:10:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250118061013epcas5p3d0d1d702ddbc5a8add31e23241a86e9e~btJBINuVh2330723307epcas5p3D;
	Sat, 18 Jan 2025 06:10:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250118061013epsmtrp19d7e34ee68682476d9be4ca996925e8f~btJBHVvY41109711097epsmtrp1S;
	Sat, 18 Jan 2025 06:10:13 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-dc-678b45c5b650
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5C.C0.18729.4C54B876; Sat, 18 Jan 2025 15:10:12 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250118061010epsmtip1147bac060724109b7678f9ad6eedcdf3~btI_j5YK01589915899epsmtip1Q;
	Sat, 18 Jan 2025 06:10:10 +0000 (GMT)
Message-ID: <52a0dd32-59be-4b41-859d-a8b4c8787792@samsung.com>
Date: Sat, 18 Jan 2025 11:39:58 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
To: Greg KH <gregkh@linuxfoundation.org>
Cc: quic_jjohnson@quicinc.com, kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, alim.akhtar@samsung.com,
	stable@vger.kernel.org, thiagu.r@samsung.com
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2025011726-hydration-nephew-0d65@gregkh>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmhu5R1+50g70npC2mT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVotVnXNYLC5/38lssWDjI0aLSQdFLVY0tzI7CHtsWtXJ5rF/7hp2j2MvjrN7
	9P818Ji4p86jb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyV
	FPISc1NtlVx8AnTdMnOAPlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn
	5haX5qXr5aWWWBkaGBiZAhUmZGds+BhXsFahYurF1ywNjLeluhg5OCQETCSObC3rYuTiEBLY
	zSix4Pw8VgjnE6PExydH2SCcb4wSn1e+Y+xi5ATrWHx9HQtEYi+jRFvTIaiqt4wSb/9tYwKZ
	yytgJzHjBw9IA4uAqsTrN1dZQWxeAUGJkzOfsIDYogLyEvdvzWAHsYUFMiW+Tu8CWyAioCHx
	8ugtsAXMAoeYJRof/QRrYBYQl7j1ZD7YfDYBQ4lnJ2xAwpwCZhIX9nZDlchLNG+dzQzSKyHw
	gUPiw7sGNoirXSROPf7PDmELS7w6vgXKlpJ42d8GZSdL7Jn0BcrOkDi06hAzhG0vsXrBGVaQ
	vcwCmhLrd+lD7OKT6P39hAkSjLwSHW1CENWqEqcaL0NtlZa4t+QaK4TtIXGq7TvYdCGBLhaJ
	d0f1JjAqzEIKlVlInpyF5JtZCIsXMLKsYpRMLSjOTU9NNi0wzEsth8d2cn7uJkZwKtdy2cF4
	Y/4/vUOMTByMhxglOJiVRHjTfnekC/GmJFZWpRblxxeV5qQWH2I0BUbPRGYp0eR8YDbJK4k3
	NLE0MDEzMzOxNDYzVBLnbd7Zki4kkJ5YkpqdmlqQWgTTx8TBKdXApCpZu+SOdUxQRBvfud7H
	TQfq37KWNTxct6JiV+TMe/b+c1QmXvTZXHLW9AGP2dSM4hvun2s7FX2/WjnUH9p9pomX68sc
	RRWu1dU92+Vmrsov/7larZnzuqPF2Vm/pEOCr0/2X1F6tkKceXPPyi0Mv8P7Zuxi2Pjq8ULP
	+1Kfn8a29Ge5dezY9+rhpXhb5+XiGlXMJyJZNKvW7HayOc//r+dg71yGO0c6/F+/bnm+e/bM
	93O2OT91D3/7+f2umSFXHaTnnE516y5udppQnxBzIL675lfh8773RyridFde1P60x+77VnkZ
	lVX7NAOXsd+/JVu9+aV7j8P8Y4mMJ/IulCsdb/vOViYg0iSYcW6ZpBJLcUaioRZzUXEiAEnh
	ssJuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnO4R1+50gw0PzC2mT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVotVnXNYLC5/38lssWDjI0aLSQdFLVY0tzI7CHtsWtXJ5rF/7hp2j2MvjrN7
	9P818Ji4p86jb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4MjZ8jCtYq1Ax9eJrlgbG21JdjJwc
	EgImEouvr2PpYuTiEBLYzSix//xmNoiEtMTrWV2MELawxMp/z9khil4zSux+tY6pi5GDg1fA
	TmLGDx6QGhYBVYnXb66ygti8AoISJ2c+YQGxRQXkJe7fmsEOYgsLZErcOzUTbL6IgIbEy6O3
	wBYzCxxilvjx6ikjxIIuFomN8+4zg1QxC4hL3HoyH2wZm4ChxLMTNiBhTgEziQt7u1kgSswk
	urZCHMoMtKx562zmCYxCs5DcMQvJpFlIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0
	L10vOT93EyM4drU0dzBuX/VB7xAjEwfjIUYJDmYlEd603x3pQrwpiZVVqUX58UWlOanFhxil
	OViUxHnFX/SmCAmkJ5akZqemFqQWwWSZODilGpj27LHsFOTpaGHPiVta4tcpJMh3tHj37u3Z
	Bi9OLpW6IShxbL7tN4Hwx58Xxi9gYmA7XMTYaCC0mV3Dy0ZEvEUoLqG3utZ/vhirhtkPQ5OZ
	P0/sqNw84VrPJZVzUl7TIpZtPZr4onOHXYxP9R+zV78WXJ+822jdhSrnYGnXkpeGQVJV154e
	KL3bNaOJ52FZ69tM953ZAZw9bru9lvMtyz1TmHDg5Euh/1ceXlqip+WhwCjApLyVf/6m4/sT
	PXQiIxqO/rMPvyVcd/TPJ64JM11aXrif7BZsiVjHdtZBblX1hQOSWcymvvcksq78Tf1Rojpz
	qnFx2c4iJ7VJa88XPv3won6+kIuOZ3xB0qbrUkosxRmJhlrMRcWJABbGozhMAwAA
X-CMS-MailID: 20250118061013epcas5p3d0d1d702ddbc5a8add31e23241a86e9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241208152338epcas5p4fde427bb4467414417083221067ac7ab
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
	<20241208152322.1653-1-selvarasu.g@samsung.com>
	<2024121845-cactus-geology-8df3@gregkh>
	<9f16a8ac-1623-425e-a46e-41e4133218e5@samsung.com>
	<2024122013-scary-paver-fcff@gregkh>
	<a1dedf06-e804-4580-a690-25e55312eab8@samsung.com>
	<2024122007-flail-traverse-b7b8@gregkh>
	<6629115f-5208-42fe-8bf4-25d808129741@samsung.com>
	<7d7a0d7a-76bb-49a8-82f8-07ee53893145@samsung.com>
	<2025011726-hydration-nephew-0d65@gregkh>


On 1/17/2025 4:35 PM, Greg KH wrote:
> On Thu, Jan 16, 2025 at 10:49:24AM +0530, Selvarasu Ganesan wrote:
>> On 12/21/2024 11:37 PM, Selvarasu Ganesan wrote:
>>> On 12/20/2024 8:45 PM, Greg KH wrote:
>>>> On Fri, Dec 20, 2024 at 07:02:06PM +0530, Selvarasu Ganesan wrote:
>>>>> On 12/20/2024 5:54 PM, Greg KH wrote:
>>>>>> On Wed, Dec 18, 2024 at 03:51:50PM +0530, Selvarasu Ganesan wrote:
>>>>>>> On 12/18/2024 11:01 AM, Greg KH wrote:
>>>>>>>> On Sun, Dec 08, 2024 at 08:53:20PM +0530, Selvarasu Ganesan wrote:
>>>>>>>>> The current implementation sets the wMaxPacketSize of bulk in/out
>>>>>>>>> endpoints to 1024 bytes at the end of the f_midi_bind function.
>>>>>>>>> However,
>>>>>>>>> in cases where there is a failure in the first midi bind attempt,
>>>>>>>>> consider rebinding.
>>>>>>>> What considers rebinding?  Your change does not modify that.
>>>>>>> Hi Greg,
>>>>>>> Thanks for your review comments.
>>>>>>>
>>>>>>>
>>>>>>> Here the term "rebind" in this context refers to attempting to
>>>>>>> bind the
>>>>>>> MIDI function a second time in certain scenarios.
>>>>>>> The situations where rebinding is considered include:
>>>>>>>
>>>>>>>      * When there is a failure in the first UDC write attempt,
>>>>>>> which may be
>>>>>>>        caused by other functions bind along with MIDI
>>>>>>>      * Runtime composition change : Example : MIDI,ADB to MIDI. Or
>>>>>>> MIDI to
>>>>>>>        MIDI,ADB
>>>>>>>
>>>>>>> The issue arises during the second time the "f_midi_bind" function is
>>>>>>> called. The problem lies in the fact that the size of
>>>>>>> "bulk_in_desc.wMaxPacketSize" is set to 1024 during the first call,
>>>>>>> which exceeds the hardware capability of the dwc3 TX/RX FIFO
>>>>>>> (ep->maxpacket_limit = 512).
>>>>>> Ok, but then why not properly reset ALL of the options/values when a
>>>>>> failure happens, not just this one when the initialization happens
>>>>>> again?  Odds are you might be missing the change of something else
>>>>>> here
>>>>>> as well, right?
>>>>> Are you suggesting that we reset the entire value of
>>>>> usb_endpoint_descriptor before call usb_ep_autoconfig? If so, Sorry
>>>>> I am
>>>>> not clear on your reasoning for wanting to reset all options/values.
>>>>> After all, all values will be overwritten
>>>>> afterusb_ep_autoconfig.Additionally, the wMaxPacketSize is the only
>>>>> value being checked during the EP claim process (usb_ep_autoconfig),
>>>>> and
>>>>> it has caused issues where claiming wMaxPacketSize is grater than
>>>>> ep->maxpacket_limit.
>>>> Then fix up that value on failure, if things fail you should reset it
>>>> back to a "known good state", right?  And what's wrong with resetting
>>>> all of the values anyway, wouldn't that be the correct thing to do?
>>> Yes, It's back to known good state if we reset wMaxPacketSize. There
>>> is no point to reset all values in the usb endpoint descriptor
>>> structure as all the member of this structure are predefined value
>>> except wMaxPacketSize and bEndpointAddress. The bEndpointAddress is
>>> obtain as part of usb_ep_autoconfig.
>>>
>>> static struct usb_endpoint_descriptor bulk_out_desc = {
>>>          .bLength =              USB_DT_ENDPOINT_AUDIO_SIZE,
>>>          .bDescriptorType =      USB_DT_ENDPOINT,
>>>          .bEndpointAddress =     USB_DIR_OUT,
>>>          .bmAttributes =         USB_ENDPOINT_XFER_BULK,
>>> };
>>>
>> HI Greg,
>>
>> Gentle remainder for your further comments or suggestions on this.
> Sorry, I don't remember, it was thousands of patches reviewed ago.  If
> you feel your submission was correct, and no changes are needed, resend
> with an expanded changelog text to help explain things so I don't have
> the same questions again.
>
> thanks,
>
> greg k-h

Hi Greg,

I understand. Thanks for your update.

Yes, no changes are needed. I updated new version with expanded 
changelog in below link.

https://lore.kernel.org/all/20250118060134.927-1-selvarasu.g@samsung.com/

Thanks,
Selva
>

