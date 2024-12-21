Return-Path: <stable+bounces-105537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581FA9FA1CF
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 19:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66271188BAF4
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E22816C854;
	Sat, 21 Dec 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cyiJ9BFH"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D51547F0
	for <stable@vger.kernel.org>; Sat, 21 Dec 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734804497; cv=none; b=SY+MEJPDWgSuwbFJm7IC21ybtmag8Nw5sceT2BNYE7iB1CRkKRChdV6hem+3OSNjAtblcr73NzuG/zSkt/IHoBc+gGDoEjJZfwAIRT0Ys0nckrmFnEhtWaqFZnLHPZ+tfYt0+dipI3/CeHQ2x3STxoE7p8yfViQv4UEj795cVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734804497; c=relaxed/simple;
	bh=16YzqKFTkTvxfdNNZkdNT4Z2zvtpvGIgupdWLbfzORg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=bwtLotaIdsYmk75FINsloZUicWIdjQ6cGMx3CJgCRc9z3zQ4zKAlvzsdJKJy3MiCr8NQ3jZbLwVffM0bGaCGLvHTxu4djJWCmPyuckwbXf2m1d6phA8Y/Wg0W9OUQ2WsPxLHEu4uKsBFqDVvlNh9z/71VOY/pYUAkBCuQ39VAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cyiJ9BFH; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241221180805epoutp01f446a9616a7730816be283aae8ed2a44~TQ3zz7jl51863018630epoutp01Y
	for <stable@vger.kernel.org>; Sat, 21 Dec 2024 18:08:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241221180805epoutp01f446a9616a7730816be283aae8ed2a44~TQ3zz7jl51863018630epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734804485;
	bh=uARgmvpASQAKIdPH6Cgx961uzCEyQMHmG6n3EbcH7Rg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cyiJ9BFHm8VyLCKTZPTL+M1ZxJ2tshAH6w4ia6zSzA7TdMj+zlC0ciQBBSxnjcd2Z
	 hULuo6MXtTpW9030te2fCaeb2uHefAj6d4oJmSCU8HTMi2Rd4u2AlmtRmXkKqUJqOw
	 pZ7CBrg7KIHC2YiLeGE5wi2SMC1WLHixKGekijgU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241221180803epcas5p4e87fc1316126f340b88723ebf0758236~TQ3yXZmxP0138001380epcas5p4V;
	Sat, 21 Dec 2024 18:08:03 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YFshf4mggz4x9Pq; Sat, 21 Dec
	2024 18:08:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.79.29212.20407676; Sun, 22 Dec 2024 03:08:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241221180801epcas5p29e3c0c70e8876befc6c2d1eb68b0f59c~TQ3v_z0Mz0557705577epcas5p2r;
	Sat, 21 Dec 2024 18:08:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241221180801epsmtrp1a63c9f4f09936cfe23ddf812c3c6a9dc~TQ3v9Bz_33112231122epsmtrp1f;
	Sat, 21 Dec 2024 18:08:01 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-12-676704029763
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6A.F4.18729.10407676; Sun, 22 Dec 2024 03:08:01 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241221180758epsmtip1419674e0523f6dd79646a0e0867cd729~TQ3tepSQP2035020350epsmtip1h;
	Sat, 21 Dec 2024 18:07:58 +0000 (GMT)
Message-ID: <6629115f-5208-42fe-8bf4-25d808129741@samsung.com>
Date: Sat, 21 Dec 2024 23:37:57 +0530
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
	stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2024122007-flail-traverse-b7b8@gregkh>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmhi4TS3q6webJihbTp21ktXhzdRWr
	xYN529gs7iyYxmRxavlCJovmxevZLCbt2cpicffhDxaLdW/Ps1pc3jWHzWLRslZmiy1tV5gs
	Ph39z2rRuOUuq8WqzjksFpe/72S2WLDxEaPFpIOiDkIem1Z1snnsn7uG3ePYi+PsHv1/DTwm
	7qnz6NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxU
	WyUXnwBdt8wcoCeUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnp
	enmpJVaGBgZGpkCFCdkZ7fP3shecUar4Of0DYwPjZJkuRg4OCQETiZPr1bsYuTiEBPYwSjT1
	XWbqYuQEcj4xSpx4WQphf2OU+LYqA8QGqd/5Yz8zRMNeRonunndQzltGiRnnXjKDVPEK2Ens
	btvPCmKzCKhKPJ1/GCouKHFy5hMWEFtUQF7i/q0Z7CC2sECmxNfpXYwgtoiAhsTLo7dYQIYy
	C6xhlrj5pZcNJMEsIC5x68l8JpCz2QQMJZ6dsAEJcwJdtGL3H1aIEnmJ5q2zwQ6SEHjBIfHp
	+G12iLNdJObt2sYKYQtLvDq+BSouJfGyvw3KTpbYM+kLlJ0hcWjVIWYI215i9YIzrCB7mQU0
	Jdbv0ofYxSfR+/sJEyQUeSU62oQgqlUlTjVeZoOwpSXuLbkGtdVD4lTbd3ZIWH1hkpjXe4Rl
	AqPCLKRgmYXky1lI3pmFsHkBI8sqRqnUguLc9NRk0wJD3bzUcnh8J+fnbmIEJ3GtgB2Mqzf8
	1TvEyMTBeIhRgoNZSYSXRy41XYg3JbGyKrUoP76oNCe1+BCjKTCCJjJLiSbnA/NIXkm8oYml
	gYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTNrX2b4yfVwteuyCdIKDReOr
	rj0nHr7SOhQ8/eNHRjUlTdWFsutOLY5L9nF4uaR6Y2Jv3vfv9mW7HvnPu77w6bRgsz/8h/VC
	djvWvbzqGRO+Z5Hi6xsrr/+rFHXx3VWQ3Ja0dqamqVlEz3Eu1fuf14Rv9Xv9dG68dcyerF/v
	/906V33x0J35akc+2q4482Jae5e6/uWWJ3YMCyIregSj9j6ROq5+Pc1oblrkOoF6b6udmfp5
	EotXN7HL33zMuXJyxqsN5o12RvnCPx6yx5Y4C7LN8VgZd9Rlp22W6ro5Ec9LJi9ped1vLeh4
	5zSbZaWP6F/BxBlqT08U/xTS3HlreknrHke+J06a5nyfo+57TlViKc5INNRiLipOBAAGtjJx
	awQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSnC4jS3q6wYQ2Dovp0zayWry5uorV
	4sG8bWwWdxZMY7I4tXwhk0Xz4vVsFpP2bGWxuPvwB4vFurfnWS0u75rDZrFoWSuzxZa2K0wW
	n47+Z7Vo3HKX1WJV5xwWi8vfdzJbLNj4iNFi0kFRByGPTas62Tz2z13D7nHsxXF2j/6/Bh4T
	99R59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV0b7/L3sBWeUKn5O/8DYwDhZpouRk0NCwERi
	54/9zF2MXBxCArsZJe41zGODSEhLvJ7VxQhhC0us/PecHaLoNaPEwqYTTCAJXgE7id1t+1lB
	bBYBVYmn8w8zQ8QFJU7OfMICYosKyEvcvzWDHcQWFsiUuHdqJtgCEQENiZdHb7GADGUWWMMs
	8WtGByPEhi9MEk/27QObyiwgLnHryXygbRwcbAKGEs9O2ICEOYHOXrH7D1SJmUTXVohLmYGW
	NW+dzTyBUWgWkjtmIZk0C0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525i
	BEetluYOxu2rPugdYmTiYDzEKMHBrCTCyyOXmi7Em5JYWZValB9fVJqTWnyIUZqDRUmcV/xF
	b4qQQHpiSWp2ampBahFMlomDU6qByY3ZyMvh14MDV3VKGT6ovCubcDtX4vefiuaAEzxf3yTo
	rCkScZo9/fsJ/7eyQSsPM79a8m3tDz7rczN3ftzqdPWJIn9UmM9fvvpOvm0VnIoR60q32thF
	TnZ+zBAfZHZUnJkzLH1G99xrnrJCt3KD989cWK0/s2rGj84dmrqlOkWBllYSN9NDTf+c57ty
	Ufv7wklsN/x1MkMuzfntc7ZJdz+/BrviEV8hg7PNiiuUZx+yW9Bh1n7w8bYe2+37Chv8Zs02
	aFKQK5z0qliEs3ke55Opqg9T7t4yZ2O2Xrrenu3Fvp3TbGLW79jgJFoq4fVMKvTiKmYFfvbD
	TmWSn9kMsiRs5T46sh64Otf9mK+EEktxRqKhFnNRcSIAesMfV0kDAAA=
X-CMS-MailID: 20241221180801epcas5p29e3c0c70e8876befc6c2d1eb68b0f59c
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


On 12/20/2024 8:45 PM, Greg KH wrote:
> On Fri, Dec 20, 2024 at 07:02:06PM +0530, Selvarasu Ganesan wrote:
>> On 12/20/2024 5:54 PM, Greg KH wrote:
>>> On Wed, Dec 18, 2024 at 03:51:50PM +0530, Selvarasu Ganesan wrote:
>>>> On 12/18/2024 11:01 AM, Greg KH wrote:
>>>>> On Sun, Dec 08, 2024 at 08:53:20PM +0530, Selvarasu Ganesan wrote:
>>>>>> The current implementation sets the wMaxPacketSize of bulk in/out
>>>>>> endpoints to 1024 bytes at the end of the f_midi_bind function. However,
>>>>>> in cases where there is a failure in the first midi bind attempt,
>>>>>> consider rebinding.
>>>>> What considers rebinding?  Your change does not modify that.
>>>> Hi Greg,
>>>> Thanks for your review comments.
>>>>
>>>>
>>>> Here the term "rebind" in this context refers to attempting to bind the
>>>> MIDI function a second time in certain scenarios.
>>>> The situations where rebinding is considered include:
>>>>
>>>>     * When there is a failure in the first UDC write attempt, which may be
>>>>       caused by other functions bind along with MIDI
>>>>     * Runtime composition change : Example : MIDI,ADB to MIDI. Or MIDI to
>>>>       MIDI,ADB
>>>>
>>>> The issue arises during the second time the "f_midi_bind" function is
>>>> called. The problem lies in the fact that the size of
>>>> "bulk_in_desc.wMaxPacketSize" is set to 1024 during the first call,
>>>> which exceeds the hardware capability of the dwc3 TX/RX FIFO
>>>> (ep->maxpacket_limit = 512).
>>> Ok, but then why not properly reset ALL of the options/values when a
>>> failure happens, not just this one when the initialization happens
>>> again?  Odds are you might be missing the change of something else here
>>> as well, right?
>> Are you suggesting that we reset the entire value of
>> usb_endpoint_descriptor before call usb_ep_autoconfig? If so, Sorry I am
>> not clear on your reasoning for wanting to reset all options/values.
>> After all, all values will be overwritten
>> afterusb_ep_autoconfig.Additionally, the wMaxPacketSize is the only
>> value being checked during the EP claim process (usb_ep_autoconfig), and
>> it has caused issues where claiming wMaxPacketSize is grater than
>> ep->maxpacket_limit.
> Then fix up that value on failure, if things fail you should reset it
> back to a "known good state", right?  And what's wrong with resetting
> all of the values anyway, wouldn't that be the correct thing to do?

Yes, It's back to known good state if we reset wMaxPacketSize. There is 
no point to reset all values in the usb endpoint descriptor structure as 
all the member of this structure are predefined value except 
wMaxPacketSize and bEndpointAddress. The bEndpointAddress is obtain as 
part of usb_ep_autoconfig.

static struct usb_endpoint_descriptor bulk_out_desc = {
         .bLength =              USB_DT_ENDPOINT_AUDIO_SIZE,
         .bDescriptorType =      USB_DT_ENDPOINT,
         .bEndpointAddress =     USB_DIR_OUT,
         .bmAttributes =         USB_ENDPOINT_XFER_BULK,
};

>>> Also, cleaning up from an error is a better thing to do than forcing
>>> something to be set all the time when you don't have anything gone
>>> wrong.
>> As I previously mentioned, this is a general approach to set
>> wMaxPacketSize before claiming the endpoint. This is because the
>> usb_ep_autoconfig treats endpoint descriptors as if they were full
>> speed. Following the same pattern as other function drivers, that
>> approach allows us to claim the EP with using a full-speed descriptor.
>> We can use the same approach here instead of resetting wMaxPacketSize
>> every time.
>>
>> The following provided code is used to claim an EP with a full-speed
>> bulk descriptor in MIDI. Its also working solution.  But, We thinking
>> that it may unnecessarily complicate the code as it only utilizes the
>> full descriptor for obtaining the EP address here. What you think shall
>> we go with below approach instead of rest wMaxPacketSize before call
>> usb_ep_autoconfig?
> I don't know, what do you think is best to do?  You are the one having
> problems and will need to fix any bugs that your changes will cause :)
>
> thanks,
>
> greg k-h

We agree. Restting wMaxPacketSize is the best solution for this issue, 
as concluded from our internal review meeting as well.

Thanks,
Selva

