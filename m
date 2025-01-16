Return-Path: <stable+bounces-109209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A737DA13249
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 06:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88FA16679C
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 05:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C282137C2A;
	Thu, 16 Jan 2025 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R5YfXI29"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65591E505
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737004792; cv=none; b=Gz9ZJNFylmFvurXeGOR4HNIFAhWecRafhZMkmob96TBslSeg07ZGfw7uZia6LrnFJYC3vjO7o5LVMuutRFoS4cTPmkRIuq3IbDH12HQhNL7hK2hINg9JDubcZi7VBy7AqU/IaN+gUBuRkRM9XnsEe7yUrPwhrA1jM0xGAyyOyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737004792; c=relaxed/simple;
	bh=K1dIF/O/CK3E70GU0VXU/mKdPIJZLAMPpJ5Y0yDpVms=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=YEgI/OZKMKS7AyHZzCnH7R2ZH2dnv30CLlxCu0MG9rwRv9mDl7XUwLqm096zwZatwmX0Pb4rVAVPBpXS+WxfoQ6e+vK2fr4LLZjZgjI4x5M2z1kvY5FAlBUk8c984A+VRduxupaN3ekpoY/SOFyBSyC2SdSwNPABduUDNWaon3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=R5YfXI29; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250116051946epoutp02ffd22464d30163338686e772e77eb607~bFKaEiYtH2238722387epoutp02Z
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 05:19:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250116051946epoutp02ffd22464d30163338686e772e77eb607~bFKaEiYtH2238722387epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737004786;
	bh=c5x98hRMUwcUXOzHdvTI4imhii0gD1HrPv3Rsx7msfU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=R5YfXI29p7gy/0kLGz0WgYvV7bsFQf5uCy8zW46RnYjyS2PxJKOHfz2zONEFzLMrN
	 4BsSWpjGMLpMvJC/nUXkSYmmahGWV5WzEXOLLi6774BJ0yLJVjlbsJlFsrvvT6N0gT
	 I83NJTbBjjdIi0gPCrWj2xwj08tY7HQeOziOZl4M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250116051946epcas5p1d42b230ec3223a32bba14c5e2d7f060b~bFKZbTi-q2438724387epcas5p1S;
	Thu, 16 Jan 2025 05:19:46 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YYWQ84tBNz4x9Q6; Thu, 16 Jan
	2025 05:19:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.5E.29212.0F698876; Thu, 16 Jan 2025 14:19:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250116051944epcas5p3bc5a84af3430983751f8ae8872e27e93~bFKXvVhjj0208902089epcas5p3J;
	Thu, 16 Jan 2025 05:19:44 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250116051944epsmtrp1d8b0c27b2bc22821d315d52a63a04baa~bFKXuSMEu0761307613epsmtrp1T;
	Thu, 16 Jan 2025 05:19:44 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-cb-678896f01292
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EF.0E.23488.FE698876; Thu, 16 Jan 2025 14:19:43 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250116051941epsmtip2da7c68a95a0c186c527ee05a57a0795a~bFKVFMpIS1029610296epsmtip2P;
	Thu, 16 Jan 2025 05:19:41 +0000 (GMT)
Message-ID: <7d7a0d7a-76bb-49a8-82f8-07ee53893145@samsung.com>
Date: Thu, 16 Jan 2025 10:49:24 +0530
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
	stable@vger.kernel.org, thiagu.r@samsung.com
Content-Language: en-US
In-Reply-To: <6629115f-5208-42fe-8bf4-25d808129741@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc3pvLxe1y5WHntSIpAypbMWWFXbYimwZMd00WCX6B5lhN3DT
	ltJHessAkxlYoVPGQMjCa6DlEYG6yaiVZ7eFMgWJyTIec5CJQHDqBowxHSgjru3Fjf8+v9/5
	fc/vdQ6JBU0TQlJrsDBmA50tIrbhXYMHxJLlqnNq6fxQBKqu6uSjhQkHH81c7CLQL/YqHhpp
	beQha3MHgSrd13F0d3YNR1cXf+Cjsb56AjVdLsaQyzbOQys3nvNRoesuHznO1+NobLUXQ/bO
	OYAqB0JRm7UYeytY6XScJ5TfNXwZoLz5cChAWb4hVVa4zyrLXA6g/MsZpgpI0yk0DJ3JmMMZ
	Q4YxU2tQJ4qOpKa/kx4XL5VJZAnodVG4gdYziaLkoyrJYW22txNR+Id0do7XpaJZVnTwkMJs
	zLEw4Roja0kUMabMbJPcFMPSejbHoI4xMJY3ZFJpbJw38AOdZnRtlG+qiMxzfZtQANrDSkAg
	CSk5nG9sIErANjKIcgM4U1WKc8YKgK7acowz/gaw6J494IXkk+EBPnfwDYCtpZUBnLEI4IXC
	Xq+EJAXUITjgYn0CnIqE1ZcHMR8LqJ3wVu087uNQah+8N1XjvzSY0sIn1SXAJyUoGfx1WOFz
	h1Bi+OjGlL8ijPJgsHDuqV+LUbvh1Pwlno8DqSTY2eAEnH8ftF7/wl81pJZJ2Lb4gMdVnQwH
	e0dxjoPhb0OuzW6E8FG5bZMzoLvy8SZroMfhwThOglfst/m+4jDqAOzoO8jlegl+tj7P87kh
	JYDnbEFcdCQcKRwjON4Dp1t+4nOshCO21c1RtWNw6qtm4gIIr9sylrotrdVtaafu/8x2gDuA
	kDGxejWTEWeSSQxM7n8LzzDqncD/0KNVPeDK1xsxHsAjgQdAEhOFCFqIYnWQIJPOP8OYjenm
	nGyG9YA474IqMGFohtH7UwyWdJk8QSqPj4+XJ7wWLxPtFlh7i9RBlJq2MDqGMTHmFzoeGSgs
	4DUz1y6GrOApufT9tOGOVz41LvVMnXzozHsmm1koPbI96XHXg6xbGyuW+oqZxqX+hkZ1Wfeu
	AvFHlrdb75yuqe/X5Sieucry7Ht3VA5Fn2yffb4/9ez2qGX153m2PSmoVijvwt6VTYvZXZNh
	cyZ66c2ILvYP9zFLzPcKj0V/hrCqWiea7swmae/n9v6+ntkdtkM8bnbm81Y1jPHnU7ruo/mS
	QEnyn6PiPCL1xKkC5mpKVOJsrO1pUU9W1bqqJfJ2VEjb6dhiAVmuX7q58LJquCl1b8zCk4ZF
	T/9glvp9YrL/R0edzvxPWvO145c6onbWtB57z/oq6CuNmJiUnhifWftYhLMaWhaNmVn6X1pk
	zIJxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSvO77aR3pBs0/bCymT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVotVnXNYLC5/38lssWDjI0aLSQdFLVY0tzI7CHtsWtXJ5rF/7hp2j2MvjrN7
	9P818Ji4p86jb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mi79uMRaMFG1Yss+ywbGlXJdjJwc
	EgImEu0nDrJ2MXJxCAnsZpTY/+EwO0RCWuL1rC5GCFtYYuW/5+wQRa8ZJT7P3czWxcjBwStg
	J3FwSzFIDYuAqsT0ZYeZQWxeAUGJkzOfsIDYogLyEvdvzQCbKSyQKXHv1EywVjYBQ4lnJ2xA
	wiICGhIvj95iARnPLHCIWeLHq6eMELtWMktc7moBG8QsIC5x68l8JhCbU8BeYuPcTYwQcTOJ
	rq1dULa8RPPW2cwTGIVmIbljFpL2WUhaZiFpWcDIsopRMrWgODc9N9mwwDAvtVyvODG3uDQv
	XS85P3cTIzh2tTR2ML771qR/iJGJg/EQowQHs5II7xK21nQh3pTEyqrUovz4otKc1OJDjNIc
	LErivCsNI9KFBNITS1KzU1MLUotgskwcnFINTAnPPANipSJ83CrOTPTYczsuY7l3r5pq7n9m
	hbc6ryXPbU+9Y8vUFhbxqK9tR9fBuL/e19qOJ55LNc8utYg/xKjTfKAmZL1VdODeklsxAt8E
	V1ivmrVJym6J4jsnA/O3XUZXVW551/9PduzqNnl/LCqExdfUMj6/7crbe72bfTdMCls2qeih
	6ta3PnmFHU9lv9Rrrq/5KbBV9UDjj07lFIeGT6GXGXxsjiuyL2y0DJmyykDJyH3yot+HJoje
	ZRNwUb6ir8kxy37q6jWZAaxnTlpuO2C30m1RUn+SrNzNudv0X3n8LuKaJLutWnVpgeGkJcZf
	3Ho7eANfa3cGGMnO4Qsx3f0mveFfaFZdVqISS3FGoqEWc1FxIgA7A/DTTAMAAA==
X-CMS-MailID: 20250116051944epcas5p3bc5a84af3430983751f8ae8872e27e93
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
HI Greg,

Gentle remainder for your further comments or suggestions on this.

Thanks,
Selva

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

