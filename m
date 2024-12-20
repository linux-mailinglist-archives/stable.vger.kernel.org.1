Return-Path: <stable+bounces-105420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B8C9F9354
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 14:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6688016EA7D
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2498215F51;
	Fri, 20 Dec 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rtarZKn1"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB102153DE
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734701543; cv=none; b=brRQNerDk7LzIk6xeSmY7uuSxKNOGiMHxqP9KOPRkFe/dLouVrOpaaqf2IEYAOH3CJxRK3f+oZhCLmAL+QT7yljskDQSD9pkOL/Rd7phADsa/s0uPnsmeagdsU2GZn5t7Pzo9Iq+zNRTRvX+C2c1v8Z0L7qXj3of2VswUr7uwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734701543; c=relaxed/simple;
	bh=xmur9rRKzq0w06sTzQGLHDLhAIOOV/lgeWdYHoug4xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sx3GmaOYxPEXIVEesRxWHEitbf0gkCV9DBhsKIAUoiKAYiMGmaELG4t9OyLX5rYpKxm9c3/Fuvzi9Z8qp2b5y+AoNkxbDZ0wXLwdSvP7s0u7mK5FHZLlTEoNZnIVkiEswFy08n6CzPjE6QPEhM+csCFpcQokhmn5UyI6b8XwzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rtarZKn1; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241220133213epoutp036332c96b31e58571e0cc85b7478d0eea~S5dqWxrqn0147001470epoutp03w
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 13:32:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241220133213epoutp036332c96b31e58571e0cc85b7478d0eea~S5dqWxrqn0147001470epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734701533;
	bh=mawm9FxrMruchSxDkH5qyc6pz8OvLEgmrUeU/MJ+U+0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rtarZKn1wiOuRQM1TWveX5KmoivhyPMh3ifV79Qyt30GUm5O9HKnVOpEm0q/egbBr
	 SMcLYJA50H3olWlxrplqZcI6nWfjFXe2aSavF2dcw7JEIgOuatJDyBcUx9SPqVYy39
	 VGxp43/0wjG5K9vFzL9Fr55tHt0TrZ0qPVan/Fig=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241220133212epcas5p3c43eecc0a48b1c8a6c2724f069e23d05~S5dpM6EVh0952309523epcas5p3q;
	Fri, 20 Dec 2024 13:32:12 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YF7cq0QVTz4x9Pr; Fri, 20 Dec
	2024 13:32:11 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6A.1B.19710.AD175676; Fri, 20 Dec 2024 22:32:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241220133210epcas5p3f1dd65e0efd42dc4702af63007c91c25~S5dntaj690952309523epcas5p3l;
	Fri, 20 Dec 2024 13:32:10 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241220133210epsmtrp26379b3a3c9a3642749b94ae323692aa3~S5dnrQWsw1655716557epsmtrp2J;
	Fri, 20 Dec 2024 13:32:10 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-52-676571da66f7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.4D.33707.AD175676; Fri, 20 Dec 2024 22:32:10 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241220133207epsmtip1c14d45313778adc97dc33c267b35185e~S5dlOy9352052420524epsmtip1E;
	Fri, 20 Dec 2024 13:32:07 +0000 (GMT)
Message-ID: <a1dedf06-e804-4580-a690-25e55312eab8@samsung.com>
Date: Fri, 20 Dec 2024 19:02:06 +0530
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
In-Reply-To: <2024122013-scary-paver-fcff@gregkh>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxjn3FcvZGXXIvPQZdI1UYEFaF3pDobHMphpFDOcJNMtC9zRm7YB
	brs+5tjDQUQiGFDwgVQdHQ4dXYORVQYIcxRBIJi5AWY8nEIImUNZeImGAGu56Pjv933n932/
	7/edc2hcMkhJaQNv5cw8my2nAoiG9vBtkUOfcjpFbesOVHHmKokeDThJ9ODbBgqNOM5gqOfy
	dxg6fPEKhcpbrhHo3uhTAtU9/o1Efc3nKVR96QiO3IX9GJrpWCFRvvseiZxF5wnUt9CEI8fV
	MYDK24LflmjqnUWU5sYFl0jT+fctkeb4kkJT1nJIU+p2As1s/eZU0YdZcXqO1XJmGcdnGrUG
	Xhcv370vPSk9Rq1QRipj0VtyGc/mcPHy5JTUyJ2GbK8JuewzNtvmTaWyFos8OiHObLRZOZne
	aLHGyzmTNtukMkVZ2ByLjddF8Zx1h1Kh2B7jJWZk6W+UDpOmH8I+752swPPAyOvFwJ+GjAr2
	/9oJikEALWGuA+hYPocLwQyAfZUnyBfB2NkJ/HlJzWD9GqsJwOnpYeA7kDCPASyo53xYzCTA
	uiE35sMEswV2Px2lhPwG2F05TvhwMBMK7w+dFflwEGOA8xXFq302MmHwYccQ4RPAGRcOB+dK
	VotxZhMcGq/yNqVpilHCia44X9rfC2tn7hMCJRQeviZYgMwDGh499zshTJ0MR0oHSQEHwX9u
	uUUClsLZqVZKwJmwpXxuLa+HHqdnzXEi/NHRS/p0cSYcXmmOFrQCYcni+Oo4kBHDo4USgb0F
	9uT3rXV8Ff71/d01VQ3sKVwQCXs7jUH3ZCt1Asjs69ZiX+fSvs6O/X9lByCcIIQzWXJ0XGaM
	SclzB19ceKYxpx6svvGI5EbwZ9VylAdgNPAASOPyjeKXNnM6iVjL5n7BmY3pZls2Z/GAGO/9
	lOHS4Eyj95Pw1nSlKlahUqvVqtg31Ur5JvHkkQtaCaNjrVwWx5k48/M6jPaX5mFpw36u6L1p
	/pVT1L6EXf9ih+bHzI6RWql4KjewqezmzrTRqLaWjADnJzM52wj35TuwaVbpSYrCtxbetS+H
	qFYWGtmM3pTxr8Y62qtL9nc9EQ3k8xOuhT+C/N599lpbnq27doMBjGlrh2+XNe5p1gdNVz65
	ndd8ssra+fHw/CmpqKQgmqXvVEnfqTnW/vJofujDS+bFY49UGV0XE3+52Vdje58uKA4MGXBt
	L3r2SmFMdYMtydO4wIe/wX3j6Kz7+tRHP+364OetdtsM5j9w/PR0S8ruVlcsETEx96Vh70GU
	ZA870H9AQS7tr2zlO68noj1WDJjfC1nxk6l5KYmWFnPlhEXPKiNws4X9D8reYMBsBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSnO6twtR0gwV/5S2mT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVotVnXNYLC5/38lssWDjI0aLSQdFHYQ8Nq3qZPPYP3cNu8exF8fZPfr/GnhM
	3FPn0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBn7+26zFqzQqDjzejpzA+MdxS5GTg4JAROJ
	pTc3MXcxcnEICWxnlHj59SkjREJa4vWsLihbWGLlv+fsEEWvGSXutj1hAknwCthJrLu1Bcxm
	EVCVOPnjIRtEXFDi5MwnLCC2qIC8xP1bM9hBbGGBTIl7p2aC1YgIaEi8PHqLBWQos8AaZolf
	MzoYITZMZZJYu20jWAezgLjErSfzgTZwcLAJGEo8O2EDEuYEMld+us8CUWIm0bUV4lJmoGXN
	W2czT2AUmoXkjllIJs1C0jILScsCRpZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ+bmbGMHRqhW0
	g3HZ+r96hxiZOBgPMUpwMCuJ8PLIpaYL8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwREkhP
	LEnNTk0tSC2CyTJxcEo1ME0xPynymEGnOVLwv9tcWSvz2MZC62bV6yofdvNYnSi/ODvHiud2
	D6+h49uGEzp+TycdmaX5buLW6rrrC9TrNj+ruvIzYdrWOcW9NcsvHFJ1XFF5fa6Iq2HZ06vf
	z5fImMyrWpMa4qZ/pvjSMTnZstrGvs0zHxWIl+tmdQV0SG4RuW90/tfqewV9wlMqmEuLGc1s
	ev40lp35Y3n/PHvbdc6zgYf853RNLov6+zBdcoLIzCKGrpOGm8qrHKOjb5xc9+btIc3rbPNX
	+Wxf95zr4+bTa/PWHXsSUPSwsGhPnIfs8QPZqtdupzvf99MWMqoPK+jpTzrY31qYeljT8ACf
	oHp3VJz82mSB3p1Ll29VUGIpzkg01GIuKk4EALgVQHBFAwAA
X-CMS-MailID: 20241220133210epcas5p3f1dd65e0efd42dc4702af63007c91c25
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


On 12/20/2024 5:54 PM, Greg KH wrote:
> On Wed, Dec 18, 2024 at 03:51:50PM +0530, Selvarasu Ganesan wrote:
>> On 12/18/2024 11:01 AM, Greg KH wrote:
>>> On Sun, Dec 08, 2024 at 08:53:20PM +0530, Selvarasu Ganesan wrote:
>>>> The current implementation sets the wMaxPacketSize of bulk in/out
>>>> endpoints to 1024 bytes at the end of the f_midi_bind function. However,
>>>> in cases where there is a failure in the first midi bind attempt,
>>>> consider rebinding.
>>> What considers rebinding?  Your change does not modify that.
>> Hi Greg,
>> Thanks for your review comments.
>>
>>
>> Here the term "rebind" in this context refers to attempting to bind the
>> MIDI function a second time in certain scenarios.
>> The situations where rebinding is considered include:
>>
>>    * When there is a failure in the first UDC write attempt, which may be
>>      caused by other functions bind along with MIDI
>>    * Runtime composition change : Example : MIDI,ADB to MIDI. Or MIDI to
>>      MIDI,ADB
>>
>> The issue arises during the second time the "f_midi_bind" function is
>> called. The problem lies in the fact that the size of
>> "bulk_in_desc.wMaxPacketSize" is set to 1024 during the first call,
>> which exceeds the hardware capability of the dwc3 TX/RX FIFO
>> (ep->maxpacket_limit = 512).
> Ok, but then why not properly reset ALL of the options/values when a
> failure happens, not just this one when the initialization happens
> again?  Odds are you might be missing the change of something else here
> as well, right?
Are you suggesting that we reset the entire value of 
usb_endpoint_descriptor before call usb_ep_autoconfig? If so, Sorry I am 
not clear on your reasoning for wanting to reset all options/values. 
After all, all values will be overwritten 
afterusb_ep_autoconfig.Additionally, the wMaxPacketSize is the only 
value being checked during the EP claim process (usb_ep_autoconfig), and 
it has caused issues where claiming wMaxPacketSize is grater than 
ep->maxpacket_limit.
>
> Also, cleaning up from an error is a better thing to do than forcing
> something to be set all the time when you don't have anything gone
> wrong.
As I previously mentioned, this is a general approach to set 
wMaxPacketSize before claiming the endpoint. This is because the 
usb_ep_autoconfig treats endpoint descriptors as if they were full 
speed. Following the same pattern as other function drivers, that 
approach allows us to claim the EP with using a full-speed descriptor. 
We can use the same approach here instead of resetting wMaxPacketSize 
every time.

The following provided code is used to claim an EP with a full-speed 
bulk descriptor in MIDI. Its also working solution.  But, We thinking 
that it may unnecessarily complicate the code as it only utilizes the 
full descriptor for obtaining the EP address here. What you think shall 
we go with below approach instead of rest wMaxPacketSize before call 
usb_ep_autoconfig?

diff --git a/drivers/usb/gadget/function/f_midi.c 
b/drivers/usb/gadget/function/f_midi.c
index 837fcdfa3840..fe12c8d82bf2 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -116,6 +116,22 @@ DECLARE_UAC_AC_HEADER_DESCRIPTOR(1);
  DECLARE_USB_MIDI_OUT_JACK_DESCRIPTOR(1);
  DECLARE_USB_MS_ENDPOINT_DESCRIPTOR(16);

+static struct usb_endpoint_descriptor fs_bulk_in_desc = {
+ .bLength =              USB_DT_ENDPOINT_SIZE,
+ .bDescriptorType =      USB_DT_ENDPOINT,
+
+ .bEndpointAddress =     USB_DIR_IN,
+ .bmAttributes =         USB_ENDPOINT_XFER_BULK,
+};
+
+static struct usb_endpoint_descriptor fs_bulk_out_desc = {
+ .bLength =              USB_DT_ENDPOINT_SIZE,
+ .bDescriptorType =      USB_DT_ENDPOINT,
+
+ .bEndpointAddress =     USB_DIR_OUT,
+ .bmAttributes =         USB_ENDPOINT_XFER_BULK,
+};
+
  /* B.3.1  Standard AC Interface Descriptor */
  static struct usb_interface_descriptor ac_interface_desc = {
.bLength =              USB_DT_INTERFACE_SIZE,
@@ -908,11 +924,11 @@ static int f_midi_bind(struct usb_configuration 
*c, struct usb_function *f)
status = -ENODEV;

/* allocate instance-specific endpoints */
- midi->in_ep = usb_ep_autoconfig(cdev->gadget, &bulk_in_desc);
+ midi->in_ep = usb_ep_autoconfig(cdev->gadget, &fs_bulk_in_desc);
if (!midi->in_ep)
goto fail;

- midi->out_ep = usb_ep_autoconfig(cdev->gadget, &bulk_out_desc);
+ midi->out_ep = usb_ep_autoconfig(cdev->gadget, &fs_bulk_out_desc);
if (!midi->out_ep)
goto fail;

@@ -1006,6 +1022,9 @@ static int f_midi_bind(struct usb_configuration 
*c, struct usb_function *f)
ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
ms_in_desc.bNumEmbMIDIJack = midi->out_ports;

+ bulk_in_desc.bEndpointAddress = fs_bulk_in_desc.bEndpointAddress;
+ bulk_out_desc.bEndpointAddress = fs_bulk_out_desc.bEndpointAddress;
+
/* ... and add them to the list */
endpoint_descriptor_index = i;
midi_function[i++] = (struct usb_descriptor_header *) &bulk_out_desc;



>
> thanks,
>
> greg k-h
>

