Return-Path: <stable+bounces-105274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311D9F73A2
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 05:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4961892E64
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 04:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536F0189F2B;
	Thu, 19 Dec 2024 04:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="feUX2YNu"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5BC155757
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581227; cv=none; b=V22y6/ArYszjp8vxERcsrEgU9FFvCo/MdiAEKS7e/L13DKEaKuqifz+CMDJOQigtX81qhttQQhOHmF3OjlXjyjyZLnsMfZ6u6ADyFf999O+pZ+eWd6WxUESZn0X3NYMifZV0cpQxIazXKmt+QXNBJfVJGY7ZKF4D0ajfzJpgf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581227; c=relaxed/simple;
	bh=nZbCAbcuMx4JfVdnLbdc2spSIOkfSaL2leiWJMFju/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=EwCagXDAq7TR8UG4t0Tf8b3UgmvMjSCEQ4b0SZxUvyDkvdAhEI+g6aBejVh26ibK5iCx6J7rNLQ+m3igd/OShT+CJenqVrtX1KgNVoEHPzAuSpKimoyBndLM2+N0CdUjuVSRkmjbrMxtlLjuYuSrPZtVu6/3l+9VC9GaM7G/2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=feUX2YNu; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241219040657epoutp021242e34ef30e73b8f31aabf0ea87bb9d~SeG0-05820722407224epoutp02a
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 04:06:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241219040657epoutp021242e34ef30e73b8f31aabf0ea87bb9d~SeG0-05820722407224epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734581217;
	bh=SZaLiOz3iAghxld63UE8Ygw+URk9/P2BnDospR2Tb6Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=feUX2YNunyqSy9vprssyttZvmUWOZ6v3dQgthzNstLDQqPZHzHdRxoPKDfyqy7P1i
	 zUuG1YxurcC2sZHITqz+isPBD0t7TwB0jAkHn/45HUgiLFO+qSGEFVyj/9vtPlBbcn
	 e0jZ7xCVB1vAdHsjPiUHdZrKz8NW9Odk/7KQMx2Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241219040656epcas5p412570b11588e4c0cc5aeb02b0df5a802~SeG0Ryaok0414804148epcas5p4N;
	Thu, 19 Dec 2024 04:06:56 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YDH730Ggzz4x9Pq; Thu, 19 Dec
	2024 04:06:55 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.10.19933.EDB93676; Thu, 19 Dec 2024 13:06:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241219040654epcas5p238d335586f3a418459bcd48292e6745f~SeGykn5HU0538305383epcas5p2i;
	Thu, 19 Dec 2024 04:06:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241219040654epsmtrp19da4c14e792113ae360443cba5ffd452~SeGyjmTzJ3226232262epsmtrp16;
	Thu, 19 Dec 2024 04:06:54 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-2e-67639bdee25e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.FC.18729.EDB93676; Thu, 19 Dec 2024 13:06:54 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241219040651epsmtip1c295690831c882f791b803ee3cbc6508~SeGv-0awv0578105781epsmtip1e;
	Thu, 19 Dec 2024 04:06:51 +0000 (GMT)
Message-ID: <6933f402-ee55-42a1-a307-cb1b81190e3e@samsung.com>
Date: Thu, 19 Dec 2024 09:36:50 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>, quic_jjohnson@quicinc.com,
	kees@kernel.org, abdul.rahim@myyahoo.com, m.grzeschik@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <eaa330e8-0510-445d-8aef-b39164169cb1@rowland.harvard.edu>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmlu692cnpBs87rS2mT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVotVnXNYLC5/38lssWDjI0aLCb8vAPUeFHUQ9ti0qpPNY//cNewex14cZ/fo
	/2vgMXFPncfsuz8YPfq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
	0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
	SYFecWJucWleul5eaomVoYGBkSlQYUJ2xrpHe9kKDglUbDx1irGBcS9vFyMnh4SAicTUDbfY
	uxi5OIQEdjNKTNlzHsr5xCixq7eRFaRKSOAbo8SDV3ldjBxgHT/+6EHU7AWq6f7PAlHzllGi
	77QNiM0rYCfx8/sNNhCbRUBV4unReewQcUGJkzOfgNWLCshL3L81AywuLJAp8XV6FyOILSKg
	JbG56SUzyAJmgUvMEk8X3gdLMAuIS9x6Mp8J5Ag2AUOJZyfAdnEKuEv8WNXEBFEiL9G8dTZY
	r4TADw6Jc78XsEO86SJxvH0XG4QtLPHq+BaouJTEy/42KDtZYs+kL1B2hsShVYeYIWx7idUL
	zrCC7GUW0JRYv0sfYhefRO/vJ0yQMOGV6GgTgqhWlTjVeBlqk7TEvSXXWCFsD4lTbd+hYbua
	SeLb76usExgVZiEFyywkX85C8s4shM0LGFlWMUqmFhTnpqcWmxYY5aWWw6M7OT93EyM4rWt5
	7WB8+OCD3iFGJg7GQ4wSHMxKIrxumonpQrwpiZVVqUX58UWlOanFhxhNgfEzkVlKNDkfmFny
	SuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgqrCo2/84Z81DG1aF
	0mxTl4jun191hRfPKHQ8tGnjt4uzFUTUfaPdd28O4ew2nNKqbu3BksO5hCWedcNjv6rFBUXe
	pROyFov9VKmrnCTVVGbYH7/P75LQv9lcU9Ke59q21rOxaD59uv1i5HGlLMkOy+8XrmWm84ta
	399bujfUk3kC1/PmXW2HJEoXr7SMPfqx3qin1HpmerrYg+drsrbxOHS8ucG+uu+Qisvdp10f
	VgY83LHxZVVF5R9B16/BF4+dzl8wT+ShAcuvVbeW2jp0Fldy5R0pUU+tDL2r/V/VuHOfpPnK
	cCO234svKT0+ya65ou2k0Z+okMLbEu/mr5v8RsZln9GRFTNf6hxdVVOmxFKckWioxVxUnAgA
	gjiRcXQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSnO692cnpBq/fiFtMn7aR1eLN1VWs
	Fg/mbWOzuLNgGpPFqeULmSyaF69ns5i0ZyuLxd2HP1gs1r09z2pxedccNotFy1qZLba0XWGy
	+HT0P6tF45a7rBarOuewWFz+vpPZYsHGR4wWE35fAOo9KOog7LFpVSebx/65a9g9jr04zu7R
	/9fAY+KeOo/Zd38wevRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfGukd72QoOCVRsPHWKsYFx
	L28XIweHhICJxI8/el2MXBxCArsZJbo/n2LtYuQEiktLvJ7VxQhhC0us/PecHcQWEnjNKPHi
	lSGIzStgJ/Hz+w02EJtFQFXi6dF57BBxQYmTM5+wgNiiAvIS92/NAIsLC2RK3Ds1E6xeREBL
	YnPTS2aQxcwCl5gljv44zQyxYDWTxIYdniA2s4C4xK0n85lADmUTMJR4dsIGJMwp4C7xY1UT
	E0SJmUTXVog7mYF2NW+dzTyBUWgWkjNmIZk0C0nLLCQtCxhZVjFKphYU56bnFhsWGOallusV
	J+YWl+al6yXn525iBMewluYOxu2rPugdYmTiYDzEKMHBrCTC66aZmC7Em5JYWZValB9fVJqT
	WnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomDU6qBiYtxna/mhPK3P30Drn5x2Ffj6uNo
	vv/3wRsPYvNMino+HEwV/xNmbvDS3+z74vmnHmx76Xjccnnsv0PpTwIfygk731ZoTdjAcfZD
	1boe58D4a8c26bXYnel54dM1ncVBftoJAYfUv1Y8B/VNuzKNT8w7c/BZP3/+z4lx72/+tJrG
	vX/9GtX7cd/uPthpZuLJ5WbBsaFk/pZnrQsnepkfdYh+XF5+5DUrxyO3//qFjcsL9nO11EcW
	F35ZuHqr73nNJ94+5emNz+72f7jS+kkyRKuwrCit1FE64nnTZcV7j998/vGsV9B0aZD3znsP
	g1XfXHlbebmjoq+W/ZbmP/dZXxI4NshvfhYWtDLo78a53UosxRmJhlrMRcWJAEwFR4RQAwAA
X-CMS-MailID: 20241219040654epcas5p238d335586f3a418459bcd48292e6745f
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
	<eaa330e8-0510-445d-8aef-b39164169cb1@rowland.harvard.edu>


On 12/18/2024 9:21 PM, Alan Stern wrote:
> On Wed, Dec 18, 2024 at 03:51:50PM +0530, Selvarasu Ganesan wrote:
>> The issue arises during the second time the "f_midi_bind" function is
>> called. The problem lies in the fact that the size of
>> "bulk_in_desc.wMaxPacketSize" is set to 1024 during the first call,
>> which exceeds the hardware capability of the dwc3 TX/RX FIFO
>> (ep->maxpacket_limit = 512).
> Is this gadget supposed to be able to run at SuperSpeed?  I thought the
> dwc3 controller supported SuperSpeed operation.
>
> The USB-3 spec requires that all SuperSpeed bulk endpoints must have a
> wMaxPacketSize of 1024 (see Table 9-24 on p.9-25 of the USB-3.1
> specification).
>
> Alan Stern
>
Hi Alan,

No, In our platform, the DWC3 controller supports up to HighSpeed. While 
DWC3 is capable of SuperSpeed operation, it is not necessary to operate 
at the same speed. Moreover, even in our SoC, the DWC3 IP is limited to 
supporting only USB 2.0 mode (HighSpeed) at the hardware design level.

As previously mentioned, there is no need to set the wMaxPacketSize 
based on the current speed support before claiming the endpoint (before 
calling usb_ep_autoconfig), as usb_ep_autoconfig treats endpoint 
descriptors as if they were full-speed by default.

For reference, let's see the usb_ep_autoconfig code where the 
wMaxPacketSize is set to 64 bytes if the ep->maxpacket_limit is greater 
than 64. As i mentioned earlier in our specific failure scenarios, the 
code does not reach this point because the wMaxPacketSize is greater 
than the ep->maxpacket_limit.

struct usb_ep *usb_ep_autoconfig()
{
…
…
…
         /* report (variable) full speed bulk maxpacket */
         if (type == USB_ENDPOINT_XFER_BULK) {
                 int size = ep->maxpacket_limit;

                 if (size > 64)
                         size = 64;
                 desc->wMaxPacketSize = cpu_to_le16(size);
         }

         return ep;

}


Thanks,
Selva


