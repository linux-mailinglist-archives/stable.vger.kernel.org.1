Return-Path: <stable+bounces-105141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A449F62B5
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 11:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF80B7A5EDA
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D4419AD93;
	Wed, 18 Dec 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tO5xC67j"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41362198E75
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517321; cv=none; b=f2jHG0z87tfPz8oX+xd+vazVVQTgUWgrx9smjQsqWrTTOSEg38ExYEZrahIOFItp1SsWz0/3nVVwSq+SzU1jzzD0He5ldsbWB3ToXOE3vhOwgHrt0yhwJNJthGcn+RqGisoE8SRCY3rEWG9RDCtB2c+qCLJTNmvmPQ7l68I7GTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517321; c=relaxed/simple;
	bh=gIRlSuRZXCVhEj1cANdYWbnMlczEkhjziydB+7h0vBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=frhejdZZjJfRJt2rVG9PiE4zcv82s2qdA5Wl9P1zCqsI1crEgy8GAZZlB673MLcluKt53pQ1uW61tOzhtX2faZeCEOHTt/INsPqyIEr36LDh1czFkxu2louyrI3E8zWXTwFajwuUNk8k8CqfhomeiCC1xedQzLhYNGuGZGhkR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tO5xC67j; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241218102156epoutp040857252a24a02f6a1d291d51ed0fe57f~SPk804Ao-0182701827epoutp04Q
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 10:21:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241218102156epoutp040857252a24a02f6a1d291d51ed0fe57f~SPk804Ao-0182701827epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734517316;
	bh=c5Hrh1CqgGRGngQYGz3bW4B3kn4R23TwdKn6OhVmBlM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tO5xC67jRvmmny9C4onzkKEFoIB8LHl6E50vMPV44HvkP6Ty8g7mjFGKPcJCubmGx
	 I2uLky0Z9wgYByFsw74eeXl/dnHHVXOBvic5VRaQq7xB3KeLFesrxdpF/p2n+29hoe
	 xZMGqAYnNRfEESk4wtbdRAa83pibIEATEibjO2ZU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241218102155epcas5p2a693d9b8f80efdb8ea683623acfabea1~SPk8WJTLi3048730487epcas5p2s;
	Wed, 18 Dec 2024 10:21:55 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YCqVB4VM8z4x9Q2; Wed, 18 Dec
	2024 10:21:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.BF.19710.242A2676; Wed, 18 Dec 2024 19:21:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241218102154epcas5p28e40b033d2bb3315847890044b0ae1d5~SPk6sJn-93048730487epcas5p2p;
	Wed, 18 Dec 2024 10:21:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241218102154epsmtrp2f6d28633267a267a6911c73c4ea03958~SPk6rKZRN3238332383epsmtrp2d;
	Wed, 18 Dec 2024 10:21:54 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-96-6762a2421a19
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	73.01.18949.142A2676; Wed, 18 Dec 2024 19:21:53 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241218102151epsmtip21447dda6633480e51d250d30fb0fb357~SPk4J6rJm2783627836epsmtip2I;
	Wed, 18 Dec 2024 10:21:51 +0000 (GMT)
Message-ID: <9f16a8ac-1623-425e-a46e-41e4133218e5@samsung.com>
Date: Wed, 18 Dec 2024 15:51:50 +0530
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
In-Reply-To: <2024121845-cactus-geology-8df3@gregkh>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmhq7ToqR0g6cf5CymT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVotVnXNYLC5/38lssWDjI0aLSQdFHYQ8Nq3qZPPYP3cNu8exF8fZPfr/GnhM
	3FPn0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmp
	tkouPgG6bpk5QE8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS
	9fJSS6wMDQyMTIEKE7IzLv4+xFZwXrfi2p7nLA2MD5S7GDk5JARMJFb9aGLrYuTiEBLYzSix
	d9FcVgjnE6PE+onfoZxvjBKnNz9nhGl5dOAbVMteRonP63qYIJy3jBJ9636wglTxCthJbFow
	lQ3EZhFQlfj9bCMTRFxQ4uTMJywgtqiAvMT9WzPYQWxhgUyJr9O7wDaICGhIvDx6iwVkKLPA
	GmaJm196wQYxC4hL3HoyH2gQBwebgKHEsxM2ICYn0EWda8wgKuQlmrfOZgZplRB4wSHRcfYv
	C8TVLhJTzhxng7CFJV4d38IOYUtJfH63FyqeLLFn0heoeIbEoVWHmCFse4nVC86wguxiFtCU
	WL9LH2IXn0Tv7ydg10gI8Ep0tAlBVKtKnGq8DDVRWuLekmusELaHxKm272DThQR2Mkp8fG49
	gVFhFlKgzELy4ywk38xCWLyAkWUVo2RqQXFuemqyaYFhXmo5PL6T83M3MYKTuJbLDsYb8//p
	HWJk4mA8xCjBwawkwuummZguxJuSWFmVWpQfX1Sak1p8iNEUGDsTmaVEk/OBeSSvJN7QxNLA
	xMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQamDimpquoog7cv+o/8nSi3P/mp
	ynvHjGqr4M7MJM1F96vKroU4H3vq6nhF7duUcv0J4ar7OL4ZKkxoVPHadD/t48EX+vOnxVrL
	y249EV1+bXPcrO2cWnt2vn4TNeHvZPEVedHsElkZ83RXlYe+epzpkWf4YgpLltOpKUymDB4c
	W7ZwvG7/n2+bZibk41sxNev9xeMZv7l3TrjAvDlE8ROffae9cdvhDYfMuE6YZq0u/zezTpo7
	PSm7oOXpeee8wvnbbPLWe2887nv89HrHWVNcsq9o/7kwm9W6fIvirZk159XiXlu/enPzl87P
	Av+j65/WR/NfXmJfGMj37TDTovkSF7ku85kcX1m181TqKud8JZbijERDLeai4kQAFsvlNGsE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvK7joqR0g/M3LSymT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVotVnXNYLC5/38lssWDjI0aLSQdFHYQ8Nq3qZPPYP3cNu8exF8fZPfr/GnhM
	3FPn0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkXfx9iKzivW3Ftz3OWBsYHyl2MnBwSAiYS
	jw58Y+ti5OIQEtjNKNG3fScTREJa4vWsLkYIW1hi5b/n7BBFrxkldq9aywyS4BWwk9i0YCob
	iM0ioCrx+9lGJoi4oMTJmU9YQGxRAXmJ+7dmsIPYwgKZEvdOzQSrFxHQkHh59BYLyFBmgTXM
	Er9mdDBCbNjJKHFu/i2wDcwC4hK3nswHmsrBwSZgKPHshA2IyQl0ducaM4gKM4murRCHMgPt
	at46m3kCo9AsJGfMQjJoFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93E
	CI5ZLa0djHtWfdA7xMjEwXiIUYKDWUmE100zMV2INyWxsiq1KD++qDQntfgQozQHi5I477fX
	vSlCAumJJanZqakFqUUwWSYOTqkGpiM7ZZpLny4w+2C6qNBvtdHV9R4nuY1Mps9zWJgWcLP6
	1LtZN/7lLL+QIXj3SUCTqVDqsUf9ghUbT50VPynKkZDLlM0tFL7EgCP7Vs3JqsoqXdv1zH1H
	fX55JViKX1h3WXh7WzirKcsDdUZZD2l3KUMety0XrO54yzdPTVhutXdL4sbls5Ss5ZeWhcq8
	uqsqNE3YcJdZAIMSJ2tkvqTHfuWMKnuBwqZNmWbR9p92fPYrlLs1Yf1ESWOmVzxzzjC0fEuc
	vezfMQluU4t5svfCY26rT7ecc3TT3/aaqYqa0rOkskzEoq41hx7p98pUvsSl/3lV5n6jjO1O
	ZYuTH0Tb7NPtkUqO3ebT6StVPFuJpTgj0VCLuag4EQClJj7gSAMAAA==
X-CMS-MailID: 20241218102154epcas5p28e40b033d2bb3315847890044b0ae1d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241208152338epcas5p4fde427bb4467414417083221067ac7ab
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
	<20241208152322.1653-1-selvarasu.g@samsung.com>
	<2024121845-cactus-geology-8df3@gregkh>


On 12/18/2024 11:01 AM, Greg KH wrote:
> On Sun, Dec 08, 2024 at 08:53:20PM +0530, Selvarasu Ganesan wrote:
>> The current implementation sets the wMaxPacketSize of bulk in/out
>> endpoints to 1024 bytes at the end of the f_midi_bind function. However,
>> in cases where there is a failure in the first midi bind attempt,
>> consider rebinding.
> What considers rebinding?  Your change does not modify that.

Hi Greg,
Thanks for your review comments.


Here the term "rebind" in this context refers to attempting to bind the 
MIDI function a second time in certain scenarios.
The situations where rebinding is considered include:

  * When there is a failure in the first UDC write attempt, which may be
    caused by other functions bind along with MIDI
  * Runtime composition change : Example : MIDI,ADB to MIDI. Or MIDI to
    MIDI,ADB

The issue arises during the second time the "f_midi_bind" function is 
called. The problem lies in the fact that the size of 
"bulk_in_desc.wMaxPacketSize" is set to 1024 during the first call, 
which exceeds the hardware capability of the dwc3 TX/RX FIFO 
(ep->maxpacket_limit = 512).
Let consider the below sequence,


_1. First time f_midi_bind:_

  * As per the current codethe size of bulk_in_desc.wMaxPacketSize is 0
    in first time call.
  * Call usb_ep_autoconfig to match EP and got success as no failure in
    the below code as part of usb_ep_autoconfig.

    usb_gadget_ep_match_desc()
        {
        ..
        ..
        if (max > ep->maxpacket_limit)// (64 > 512)
            return 0;

        return 1;// Found Maching EP

        } 

  * EP claim got success and set bulk_in_desc.wMaxPacketSize =1024 at
    end of f_midi_bind.


_2. Second time enter into f_midi_bind _

  * The size of bulk_in_desc.wMaxPacketSize become 1024 because of above
    code.
  * Call usb_ep_autoconfig for EP claim and has a failure now in the
    below code as part of usb_ep_autoconfig

    usb_gadget_ep_match_desc()

    {
    ..
    ..
    if (max > ep->maxpacket_limit)// (1024 > 512)
    return 0; // Not found any matchingEP

    }


To resolve this issue, our patch sets the default value of 
"bulk_in_desc.wMaxPacketSize" to 64 before endpoint claim. This ensures 
that the endpoint claim is successful during the second time 
"f_midi_bind" is called.


>
>> This scenario may encounter an f_midi_bind issue due
>> to the previous bind setting the bulk endpoint's wMaxPacketSize to 1024
>> bytes, which exceeds the ep->maxpacket_limit where configured TX/RX
>> FIFO's maxpacket size of 512 bytes for IN/OUT endpoints in support HS
>> speed only.
>> This commit addresses this issue by resetting the wMaxPacketSize before
>> endpoint claim.
> resets it to what?  Where did the magic numbers come from?  How do we
> know this is now full speed and not high speed?


It’s a generic way of setwMaxPacketSize before endpoint claim. Its 
because of the usb_ep_autoconfig treats endpoint descriptors as if they 
were full speed. This approach follows the same pattern as other 
function drivers, which also set the wMaxPacketSize to 64 before 
endpoint claim.

The following are the example of how other functions drivers EP claim.

_1. drivers/usb/gadget/function/f_eem.c_


eem_bind ()

{

…

..

/* allocate instance-specific endpoints */

ep = usb_ep_autoconfig(cdev->gadget, &eem_fs_in_desc); 
//eem_fs_in_desc.wMaxPacketSize=64

if (!ep)

goto fail;

}

_2. drivers/usb/gadget/function/f_rndis.c_


rndis_bind()

{

...

...

/* allocate instance-specific endpoints */

ep = usb_ep_autoconfig(cdev->gadget, &fs_in_desc); 
//fs_in_desc.wMaxPacketSize=64

if (!ep)

goto fail;

rndis->port.in_ep = ep;

  }

Anyway the wMaxPacketSize set with 64 byte after complete 
usb_ep_autoconfig() as part of below this function ifep->maxpacket_limit 
is grater then 64. It's means treats endpoint descriptors as if they 
were full speed by default.

struct usb_ep *usb_ep_autoconfig()

{

..

…

if (type == USB_ENDPOINT_XFER_BULK) {

int size = ep->maxpacket_limit;

/* min() doesn't work on bitfields with gcc-3.5 */

if (size > 64)

size = 64;

desc->wMaxPacketSize = cpu_to_le16(size);

}

..

..

}

>> Fixes: 46decc82ffd5 ("usb: gadget: unconditionally allocate hs/ss descriptor in bind operation")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>   drivers/usb/gadget/function/f_midi.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
>> index 837fcdfa3840..5caa0e4eb07e 100644
>> --- a/drivers/usb/gadget/function/f_midi.c
>> +++ b/drivers/usb/gadget/function/f_midi.c
>> @@ -907,6 +907,15 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>>   
>>   	status = -ENODEV;
>>   
>> +	/*
>> +	 * Reset wMaxPacketSize with maximum packet size of FS bulk transfer before
>> +	 * endpoint claim. This ensures that the wMaxPacketSize does not exceed the
>> +	 * limit during bind retries where configured TX/RX FIFO's maxpacket size
>> +	 * of 512 bytes for IN/OUT endpoints in support HS speed only.
>> +	 */
>> +	bulk_in_desc.wMaxPacketSize = cpu_to_le16(64);
>> +	bulk_out_desc.wMaxPacketSize = cpu_to_le16(64);
> Where did "64" come from?  How do we know this is full speed?  Later
> on in this function the endpoint sizes are set, why set them here to
> these small values when you do not know the speed?
>
> Or, if it had failed before, reset the values on the failure, not here
> before you start anything up, right?

Explained as part of above ask.

>
> thanks,
>
> greg k-h
>

