Return-Path: <stable+bounces-106779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F89A01EC2
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 06:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48393A36E1
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 05:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C8870816;
	Mon,  6 Jan 2025 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rFgfgq4+"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E1171D2
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736140638; cv=none; b=RxXdOLd40DCXo2YVTOcQKx+JL+OmxWbkiDDoN9GvMZ2xiWKBVihLTdbDfJ4rk6qx18lhOssE2OkqP7vrzNmlQsc6w0x1jSzIW7q+9SN9DBdIyg75u8gIqj0B6irD3/xTItq9QT2fNWltNUoF2NZdgbCWA0GUVea7QRLsdIyLUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736140638; c=relaxed/simple;
	bh=smFa+R0lA0eglsmslLQWaGINza0VEKTPSSydYLeReMY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=r5AmU2ruZBVV+eZO6LBeD8iR5GI9XmwGIp8SW13iGBECYUuYTO3jvki8tSOK/hXNfeHYE4RmnjPuD5PMlIcrjeR/fEzvEfCxMwH6eVQbbokmCAxWAvCL2mAksNul1m+HW/7m4M5RgxVEzfKIqB5806LNUWF+qMG3YjzaypII2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rFgfgq4+; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250106051714epoutp0279d3087aafe407e2be50eba3c0822dbc~YArVQV0HX0045300453epoutp02H
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 05:17:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250106051714epoutp0279d3087aafe407e2be50eba3c0822dbc~YArVQV0HX0045300453epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736140634;
	bh=GcjVrca95vrRUMZ3UEOSA4Z1WO2Iw5OjVo3XFBaamwU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rFgfgq4+V9bhu/6K2gtarUEKtHza7d8W13/EIMUkA3IezWkUO2vSnrvAp/VLZwgPQ
	 LyvByNoLRNYapk1g5fV0YF5XUutdG73+xb/YoqomYL92WP8KhLXP8gUPds0k1D05dK
	 DABxWoLfBEVu3ZP5IxqBqV8HPwhuqg9Nuk8mk2dg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250106051713epcas5p4e1cdb81bb424e7a55358ef59223c3c27~YArUTWoIx0222402224epcas5p4D;
	Mon,  6 Jan 2025 05:17:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YRMqq35ftz4x9QF; Mon,  6 Jan
	2025 05:17:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AD.45.20052.7576B776; Mon,  6 Jan 2025 14:17:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250106051710epcas5p169a6504f572020de576d233594361d86~YArR9MnqV1192111921epcas5p1K;
	Mon,  6 Jan 2025 05:17:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250106051710epsmtrp1e5c3a5da5e4263267fa45b9986be6c03~YArR8BxiT0116101161epsmtrp11;
	Mon,  6 Jan 2025 05:17:10 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-80-677b6757b54d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.64.18729.6576B776; Mon,  6 Jan 2025 14:17:10 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250106051707epsmtip1c27e429c4d721a4a24fa0a6ef70aa526~YArPcNGE42552925529epsmtip1C;
	Mon,  6 Jan 2025 05:17:07 +0000 (GMT)
Message-ID: <ad54dc65-5ad5-4122-8105-da8f578fc30c@samsung.com>
Date: Mon, 6 Jan 2025 10:47:06 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: quic_jjohnson@quicinc.com, kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, alim.akhtar@samsung.com,
	stable@vger.kernel.org
Content-Language: en-US
In-Reply-To: <6629115f-5208-42fe-8bf4-25d808129741@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmlm54enW6wdbnohbTp21ktXhzdRWr
	xYN529gs7iyYxmRxavlCJovmxevZLCbt2cpicffhDxaLdW/Ps1pc3jWHzWLRslZmiy1tV5gs
	Ph39z2rRuOUuq8WqzjksFpe/72S2WLDxEaPFpIOiDkIem1Z1snnsn7uG3ePYi+PsHv1/DTwm
	7qnz6NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxU
	WyUXnwBdt8wcoCeUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnp
	enmpJVaGBgZGpkCFCdkZKw7OZS3oUq343drG2sC4QK6LkZNDQsBE4unlXrYuRi4OIYHdjBJP
	br9kgXA+MUp83/WHGcL5xiixZ/8EdpiW6f+boVr2Mkp86F/BCOG8ZZRoeNjCCFLFK2An8Wnf
	SjCbRUBFomdXMzNEXFDi5MwnLCC2qIC8xP1bM8CmCgtkSnyd3gVUz8HBJmAo8eyEDUhYREBD
	4uXRW2AnMQusYZa4+QXkWE4gR1zi1pP5TCA2p4C9xMa5mxgh4vISzVtng50tIfCCQ6Jj11IW
	iLNdJC5fuM8EYQtLvDq+BeodKYmX/W1QdrLEnklfoOwMiUOrDjFD2PYSqxecYQU5jllAU2L9
	Ln2IXXwSvb+fMIGEJQR4JTrahCCqVSVONV5mg7ClJe4tucYKYXtInGr7zg4Jq5XMErfWLmab
	wKgwCylYZiF5bRaSd2YhbF7AyLKKUTK1oDg3PbXYtMAwL7UcHuPJ+bmbGMGJXMtzB+PdBx/0
	DjEycTAeYpTgYFYS4c3SqEwX4k1JrKxKLcqPLyrNSS0+xGgKjJ+JzFKiyfnAXJJXEm9oYmlg
	YmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAPT7MbGS++9JKU9gwR8j58xeJ17
	4gGvZ19God3DmYkmGwpzOv4eyJOZdLnQoNnKMG/tZzv54FeiTu+ezHz+9qv7cr03opvuMrj1
	m3ZcrtzDGvF3pW2FCH9GftDJj+Wi/z6c4qpMerZn2jORH4bBnTcqWy8k+7cbNDR7XFh2Idvd
	/d5dlrtXd2SFyiYZ7Wl7tS3DPPjzi3nV2fM/OvfJVK54uvTB1s58jthDGpwxSak1YdHMr5Yp
	TPq2b67aL9maSIGtLxkOLb2idJ7R55/WZrWPVnsaZznxJsjVSX+Z+8cx6vHtbC3BFc//7BVf
	MuGc1Imbe49IiNtdnb9owi6ZHPYXR8tmbOaX5rKV3Pfv2JXZSizFGYmGWsxFxYkAaYViNG0E
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSnG5YenW6weT54hbTp21ktXhzdRWr
	xYN529gs7iyYxmRxavlCJovmxevZLCbt2cpicffhDxaLdW/Ps1pc3jWHzWLRslZmiy1tV5gs
	Ph39z2rRuOUuq8WqzjksFpe/72S2WLDxEaPFpIOiDkIem1Z1snnsn7uG3ePYi+PsHv1/DTwm
	7qnz6NuyitHj8ya5APYoLpuU1JzMstQifbsErowVB+eyFnSpVvxubWNtYFwg18XIySEhYCIx
	/X8zWxcjF4eQwG5Giaa9G5khEtISr2d1MULYwhIr/z1nhyh6zSjx+dA2FpAEr4CdxKd9K8GK
	WARUJHp2NTNDxAUlTs58AlYjKiAvcf/WDHYQW1ggU+LeqZlA2zg42AQMJZ6dsAEJiwhoSLw8
	eosFZD6zwBpmiV8zOhghlq1klrjc1QI2iFlAXOLWk/lMIDangL3ExrmbGCHiZhJdW7ugbHmJ
	5q2zmScwCs1CcscsJO2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZG
	cNRqae5g3L7qg94hRiYOxkOMEhzMSiK8WRqV6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0
	pggJpCeWpGanphakFsFkmTg4pRqY0nLqjyy95vOkes8Z5rQur+WZm94w5LJ0sG9QP/vAXF4k
	rGbZqbut2p9YPN4fmVxWJn55yhKGsH3Ba26mc67+GbtzmtGVh7JueZx7tl+V+7XUY9pxjaNy
	nbmXXnwx0betv//uSmhl4zZN9b3N9Q+PCHUztObqn2eNSBF3ntxfPCdS/a1TbWSrkWfM5Nem
	fv9179xV4VJZUfY346l+v673Ufu1zh8UV76rX9Vl4f54b+m9VdemGFcdfx7Aua7LyeufY/vl
	bk8hvi+todPX9vzZVTpzJ1vcj2PvZ26rOXjTLLjxGhdvp6XjTs/iDb6Ot/dFb/IsFYp5/Jdt
	W3xuT8kC3p3nGk1nRG4yMz5movFTiaU4I9FQi7moOBEA7W9S50kDAAA=
X-CMS-MailID: 20250106051710epcas5p169a6504f572020de576d233594361d86
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


On 12/21/2024 11:37 PM, Selvarasu Ganesan wrote:
>
> On 12/20/2024 8:45 PM, Greg KH wrote:
>> On Fri, Dec 20, 2024 at 07:02:06PM +0530, Selvarasu Ganesan wrote:
>>> On 12/20/2024 5:54 PM, Greg KH wrote:
>>>> On Wed, Dec 18, 2024 at 03:51:50PM +0530, Selvarasu Ganesan wrote:
>>>>> On 12/18/2024 11:01 AM, Greg KH wrote:
>>>>>> On Sun, Dec 08, 2024 at 08:53:20PM +0530, Selvarasu Ganesan wrote:
>>>>>>> The current implementation sets the wMaxPacketSize of bulk in/out
>>>>>>> endpoints to 1024 bytes at the end of the f_midi_bind function. 
>>>>>>> However,
>>>>>>> in cases where there is a failure in the first midi bind attempt,
>>>>>>> consider rebinding.
>>>>>> What considers rebinding?  Your change does not modify that.
>>>>> Hi Greg,
>>>>> Thanks for your review comments.
>>>>>
>>>>>
>>>>> Here the term "rebind" in this context refers to attempting to 
>>>>> bind the
>>>>> MIDI function a second time in certain scenarios.
>>>>> The situations where rebinding is considered include:
>>>>>
>>>>>     * When there is a failure in the first UDC write attempt, 
>>>>> which may be
>>>>>       caused by other functions bind along with MIDI
>>>>>     * Runtime composition change : Example : MIDI,ADB to MIDI. Or 
>>>>> MIDI to
>>>>>       MIDI,ADB
>>>>>
>>>>> The issue arises during the second time the "f_midi_bind" function is
>>>>> called. The problem lies in the fact that the size of
>>>>> "bulk_in_desc.wMaxPacketSize" is set to 1024 during the first call,
>>>>> which exceeds the hardware capability of the dwc3 TX/RX FIFO
>>>>> (ep->maxpacket_limit = 512).
>>>> Ok, but then why not properly reset ALL of the options/values when a
>>>> failure happens, not just this one when the initialization happens
>>>> again?  Odds are you might be missing the change of something else 
>>>> here
>>>> as well, right?
>>> Are you suggesting that we reset the entire value of
>>> usb_endpoint_descriptor before call usb_ep_autoconfig? If so, Sorry 
>>> I am
>>> not clear on your reasoning for wanting to reset all options/values.
>>> After all, all values will be overwritten
>>> afterusb_ep_autoconfig.Additionally, the wMaxPacketSize is the only
>>> value being checked during the EP claim process (usb_ep_autoconfig), 
>>> and
>>> it has caused issues where claiming wMaxPacketSize is grater than
>>> ep->maxpacket_limit.
>> Then fix up that value on failure, if things fail you should reset it
>> back to a "known good state", right?  And what's wrong with resetting
>> all of the values anyway, wouldn't that be the correct thing to do?
>
> Yes, It's back to known good state if we reset wMaxPacketSize. There 
> is no point to reset all values in the usb endpoint descriptor 
> structure as all the member of this structure are predefined value 
> except wMaxPacketSize and bEndpointAddress. The bEndpointAddress is 
> obtain as part of usb_ep_autoconfig.
>
> static struct usb_endpoint_descriptor bulk_out_desc = {
>         .bLength =              USB_DT_ENDPOINT_AUDIO_SIZE,
>         .bDescriptorType =      USB_DT_ENDPOINT,
>         .bEndpointAddress =     USB_DIR_OUT,
>         .bmAttributes =         USB_ENDPOINT_XFER_BULK,
> };
>
>>>> Also, cleaning up from an error is a better thing to do than forcing
>>>> something to be set all the time when you don't have anything gone
>>>> wrong.
>>> As I previously mentioned, this is a general approach to set
>>> wMaxPacketSize before claiming the endpoint. This is because the
>>> usb_ep_autoconfig treats endpoint descriptors as if they were full
>>> speed. Following the same pattern as other function drivers, that
>>> approach allows us to claim the EP with using a full-speed descriptor.
>>> We can use the same approach here instead of resetting wMaxPacketSize
>>> every time.
>>>
>>> The following provided code is used to claim an EP with a full-speed
>>> bulk descriptor in MIDI. Its also working solution.  But, We thinking
>>> that it may unnecessarily complicate the code as it only utilizes the
>>> full descriptor for obtaining the EP address here. What you think shall
>>> we go with below approach instead of rest wMaxPacketSize before call
>>> usb_ep_autoconfig?
>> I don't know, what do you think is best to do?  You are the one having
>> problems and will need to fix any bugs that your changes will cause :)
>>
>> thanks,
>>
>> greg k-h
>
> We agree. Restting wMaxPacketSize is the best solution for this issue, 
> as concluded from our internal review meeting as well.
>
> Thanks,
> Selva


Hi Greg,

Do you have any suggestions or further comments on this?.

Thanks,
Selva

