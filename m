Return-Path: <stable+bounces-123206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5442CA5C17C
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF913AFBEF
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124592571C0;
	Tue, 11 Mar 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="eJTvEO0E"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC61253F05;
	Tue, 11 Mar 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696681; cv=none; b=BEDYfFeJANYovHPWqqQXMalGQ7AOAEQ3dZSWF9byOixjVAkX/t8KUz8iOHkJH4+u0immYwYTBCVrhSEDpPwDBZepTR2JNRBrWwtuErbyP7EA9+gJzAAAKPQysUpn9s/ED9eVSEP/YdDyE7bwNTDaQGaogzRkoKfqVHizfuCUjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696681; c=relaxed/simple;
	bh=OEJyXK8gJanEDc24LcAoqkNul9aACtqIx/G0Aob4YPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbWGV4jUBlyE5SEffgRAGFeI5kSEHOBaA12TNwqU4cSu+VFMXM+ymgEx6kLDEj9OQmMO2RkytwqvcPYlsjCaCBYKLBofZgeatnpje8e4t0gJ5KbINUlvPoMuBH2elaJPh16iX/ftxEaYO8c6EiZlHUD4pdJXSxHN5GdvTqDUfc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=eJTvEO0E; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741696660; x=1742301460; i=fiona.klute@gmx.de;
	bh=BbL9JHXclr2BMUrynD6ixpEkOrje39v6gTZp9Fbsn34=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eJTvEO0Eza7PGDkhhuCjieynidcBLNZIWgRe7HwR7Sgd/dzfJDpdhT8m/8VtKKKC
	 RNDLSEHWgWP5Y/68VF/BOLD1EgCk0PIL9aotTEYAm9dc/ZX9gHnWzDP/QmdblXpu6
	 Q1Mc7RScJWlTmFGg0lSqSZTeGDf7leRHq2ObS4Xxuk6zySyG6FWAcfQFmZCbHTBt5
	 H5+cG/c3Xssfq1foKGvfvKTUrpmvO8LKTd4zjOtV3yUWESM0ngUtSWD2+v88bfett
	 XqAIkeLZbs/xc11vOVuMQQMRdoFrJsEFdn4jl1twa8kiSHm0A08J00/do4+E+zzPY
	 91RJMyDkwwQoG3r35w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.124.191]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1th1au2jFo-00R4D1; Tue, 11
 Mar 2025 13:37:40 +0100
Message-ID: <81ac2930-161e-4fb0-8027-2afe269229a5@gmx.de>
Date: Tue, 11 Mar 2025 13:37:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Enforce a minimum interrupt polling
 period
To: Alan Stern <stern@rowland.harvard.edu>
Cc: netdev@vger.kernel.org, Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
 stable@vger.kernel.org
References: <20250310165932.1201702-1-fiona.klute@gmx.de>
 <d52e460d-2c73-4117-95b9-bed3892ac41d@rowland.harvard.edu>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <d52e460d-2c73-4117-95b9-bed3892ac41d@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/h7Gk6DRwhjdHYJEnAD3tMIurlFFHNF8R/t0798If3lYy7eUnX1
 w0XcROK+WQmUT28XYdj7wnRJ8PiJhaRGirQ+96JFC/SZK5ScI4pSjNFtvzxRj5+hasogQi+
 YJMCb15MVdsQbqLD35WmNVFLYc4vezrFH6gzFbexmcEZHFzc3STxudXX6RXnBEtFnyVOoZs
 oXdyFdGNUjLah8HCoLaCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VpA8MuiRC8o=;z6oZBcF4DAd29mcvkrFGsNvora6
 rroNyQmiNKO/JjyeEjzvLWwFl2S4Ly9WNJZz0/YZVe4qxjEdurVhP3sFBEAXEPfs4JM6DaGJn
 PSGXch/wOIwoLcWQIED2txaOqJL6uSeDqKCVjK+xpAOGATvouJco800WXiqFWOACb/7fCLpyM
 XE1KzhF3vldUdO9V1rRs5Fpav1bclXU86Wfj+n5ZTgxNFklwfgntpY6yPwTw+DewV75p3m9QN
 Zi/NdWWsCsIpSbM4ilPc3hsIq6s7kmoiwhFTDjjzsOXXqr34LhKS62D15EVToJ2qnk+MExKBt
 QVOwAHOWLyXIxZv2q8wvQ6YSv+Wvn2qc+q13esX3LliPuprm9dxbdx96kmu8TE4lzrmQxtCZX
 4Nnp3k/AtejoynBmTBkMpvs36EDm1q8VPH/X+8raPZnB1quTlP42rPNp/HIeGHJlq5dAhFTCw
 quM5F2cOUlMNnkk/QEtsQdnt/eM3B0R6auGihuUZhiHzR/3lX1D/tCuAu611v956bzXMnls2Y
 43kyYr2W7Gr4ww6J6O9HN5uxsuKgl5HHxkEW7fgthCce58BoYZYeYUE+V6+uN0EuBgL8cxtP3
 gZn9/eZu6y9VSbDoqlg954EV25JLWInpBJI99b/HnzD7YWjQbEYyeYrBEsgZxkhXVv1ZOO3H4
 w6/dTPmqTBOamqPBnHnle2pb+mQXGBLJfdUQUaEMDLHJHq/ExPKQwuhcimeBOW40Wt99BgK9l
 n7MSJ1q/fcFGXMhx00JXMUB2NUUptbIeN9fHJHoQL1BhElqsFihs31Hwvkg68QGQrKGOrLLNQ
 ZbOyryIpSdztkynY4ZROj2Vnx/oGiJvO6SYYJpzhhohVJDSruPfqy+xECJGYSM+J9F+pt8EDj
 T/n+GElCQ4Qu8O5SQ1YEJNzQgNtKxV++AAmQDLb3x3RjPRpVET7ArewQu7t1hbTIzuWHXHoxg
 ZGKmhdeKlGAPPAAP3iaB/fbXTFhjWBEKnha/KbOi9NyONRrCpe9GoiLh8i3bvcK5QWkkkxkfO
 N9u5UGu1HWuPC8jtD2wvdBT1JFcdiTm2gqTwo1C3JV0f+wVAX8I37wSIl0RP0c2Qwf6bDhkJ+
 EBoAh5kns1wZpqylVzVaF4CCNs3NlMpCaOxNURhUo/atCoYd6X1rJVL4FF73FbDnAIVl4GJ/d
 PrXwhXZTq7/SbkyeGQbzv22G1nEUkLy7WKGc/OYiqwPgjX4HJ2yWWlrii089ZObdchhmiWH70
 auUYLYAdPFE358FCWB8+biHsi3SfDNlvQn5MMWIPoMWKWgmuPs6K0STIS0pw/OQIeIT2iVfzc
 a0n8F+TcOQdQTqjXpD4geGOcdVSQz2WvMIbm6JhCrpGbm4N5wl7pOCFPtbK3DAC1IKgAD9GsA
 dR0uFRPVIzhD4FTyRwNVSLmG9Ek/h0ag4Ul8eCzrp6eWQjADCcwijmV8IFlLH9I303g+8y5w6
 ZeKlFJktl+aeB4iu/jtuYpWLbcUXMcFXwnPIQwzq+F2GQa9MB

Am 10.03.25 um 19:06 schrieb Alan Stern:
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
>>
>> This is a simplified version of a patch that's been in the Raspberry
>> Pi downstream kernel since their 4.14 branch, see also:
>> https://github.com/raspberrypi/linux/issues/2447
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> Cc: kernel-list@raspberrypi.com
>> Cc: stable@vger.kernel.org
>> ---
>> For the stable crew: I've *tested* the patch with 6.12.7 and 6.13.5 on
>> a Revolution Pi Connect 4 (Raspberry Pi CM4 based device with built-in
>> LAN7800 as second ethernet port), according to the linked issue for
>> the RPi downstream kernel the problem should be present in all
>> maintained longterm kernel versions, too (based on how long they've
>> carried a patch).
>>
>>   drivers/net/usb/lan78xx.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
>> index a91bf9c7e31d..7bf01a31a932 100644
>> --- a/drivers/net/usb/lan78xx.c
>> +++ b/drivers/net/usb/lan78xx.c
>> @@ -173,6 +173,12 @@
>>   #define INT_EP_GPIO_1			(1)
>>   #define INT_EP_GPIO_0			(0)
>>
>> +/* highspeed device, so polling interval is in microframes (eight per
>> + * millisecond)
>> + */
>> +#define INT_URB_MICROFRAMES_PER_MS	8
>> +#define MIN_INT_URB_INTERVAL_MS		8
>> +
>>   static const char lan78xx_gstrings[][ETH_GSTRING_LEN] =3D {
>>   	"RX FCS Errors",
>>   	"RX Alignment Errors",
>> @@ -4527,7 +4533,11 @@ static int lan78xx_probe(struct usb_interface *i=
ntf,
>>   	if (ret < 0)
>>   		goto out4;
>>
>> -	period =3D ep_intr->desc.bInterval;
>> +	period =3D max(ep_intr->desc.bInterval,
>> +		     MIN_INT_URB_INTERVAL_MS * INT_URB_MICROFRAMES_PER_MS);
>
> This calculation is completely wrong.  For high-speed interrupt
> endpoints, the bInterval value is encoded using a logarithmic scheme.
> The actual interval in microframes is given by 2^(bInterval - 1) (see
> Table 9-13 in the USB 2.0 spec).  Furthermore, when the value is passed
> to usb_fill_int_urb(), the interval argument must be encoded in the same
> way (see the kerneldoc for usb_fill_int_urb() in include/linux/usb.h).
>
> The encoded value corresponding to 8 ms is 7, not 64, since 8 ms =3D 64
> uframes and 64 =3D 2^(7-1).

Thanks, I'll have to fix that if I send a revision. Though after Andrew
Lunn's response and seeing the bug again today despite the patch after a
few hundred good boots I suspect a different fix is needed.

>> +	dev_info(&intf->dev,
>> +		 "interrupt urb period set to %d, bInterval is %d\n",
>> +		 period, ep_intr->desc.bInterval);
>
> I doubt that this dev_info() will be very helpful to anyone (in addition
> to being wrong since the value in "period" is not the actual period).
I figured it'd be useful to note that the interval has been modified,
especially for possible debugging.

Best regards,
Fiona


