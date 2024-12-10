Return-Path: <stable+bounces-100389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F49EAD54
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBE3188E21D
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACB1223E9A;
	Tue, 10 Dec 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bhAYBPqK"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0CF223E94
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824414; cv=none; b=UourbRHWybTyTGYtWkn+IyOil6liAEn78gEdtxXOi6EefyM7+ap1gRuebhd9I2V/eB/oRVVQTjl7wDtzPDWCw276DNx9AqG2c6FLwbHJgBOqVkR1VT7Km1WGtAJg0jbV9lUq0Nh8zCYXtIQnKeRn6WzcpZFkzrBT0Nhdcqdetsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824414; c=relaxed/simple;
	bh=f2wXsLu93ld7H5hW2vfOqoFIUWvM4bM6iQGQZM3hGLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TsgU779ybLWfMUs3gphNqMHu5XDoJsgtFtZAZmwpC+KsY5C9wofq79UXcgucF3ikI3DnwxlCm+R9YSFQcLvpdJbnAPcbYAYVIiHzNw95hxSbbuk+9p+c69U1AB4LIRwdaNUzSBPG/4RspGqcJsDlmYYJ59Fz2iM3LZ/AVOhTa+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bhAYBPqK; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241210095329epoutp0232d232b32a941268eecfa84a2c84d968~PyB0yYPRC1258612586epoutp02r
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:53:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241210095329epoutp0232d232b32a941268eecfa84a2c84d968~PyB0yYPRC1258612586epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733824409;
	bh=Au+as8CBZsENQNOVCtoyLwjUW/xu13aSSffNENYc9/8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bhAYBPqKAxcqjBIUnoYjaqYNVklyTd9ERldvwTexbyv++egJNM3TN64hxTaGRClnt
	 hgOCjLmLrXb3URwYTGrOVvrPbnq0eb66kJeqWej207utU0n7GEq+KQ8VNej3sVIzHa
	 sx8FKF5al7hl/yKYAFmmsrJyfJE9KEDzHhcmuZIA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241210095328epcas5p12771ea8fe08eb534f608317b315752ad~PyB0LS3NP3223232232epcas5p1E;
	Tue, 10 Dec 2024 09:53:28 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y6vF31Pjsz4x9Q2; Tue, 10 Dec
	2024 09:53:27 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.39.29212.69F08576; Tue, 10 Dec 2024 18:53:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241210095325epcas5p47339f18d446e8da3efa84bbf3c9e10e5~PyBxudcuU2137121371epcas5p4J;
	Tue, 10 Dec 2024 09:53:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241210095325epsmtrp23baf7b30fd10f3a2528d0145247ec01e~PyBxthtCA1022410224epsmtrp2C;
	Tue, 10 Dec 2024 09:53:25 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-d7-67580f96b568
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	06.3F.18729.59F08576; Tue, 10 Dec 2024 18:53:25 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241210095323epsmtip260b68af7f4d84985d469d96fa5179354~PyBvP-Ak21208112081epsmtip2A;
	Tue, 10 Dec 2024 09:53:23 +0000 (GMT)
Message-ID: <6b3b314e-20a3-4b3f-a3ab-bb2df21de4f5@samsung.com>
Date: Tue, 10 Dec 2024 15:23:22 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
To: gregkh@linuxfoundation.org, quic_jjohnson@quicinc.com, kees@kernel.org,
	abdul.rahim@myyahoo.com, m.grzeschik@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20241208152322.1653-1-selvarasu.g@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wbZRjed3e9Hgzk6KB8YiJdE0yKgfVcC4cpjDCEZjSBhJRM44QLvRSk
	tE1bdBBiQAcTVn66wEbYZDiYlm0IFhDsWCgpTNycivoHSmk3wsYE3A8cLoDacqj897xPnvfH
	877fR6CCWTySKNJbWJOe0YnxQGxoQiKJbQs5qpXWegHd1trPo5d/svFoz/khnP61sxWhpy9d
	QOgPPunD6RbHIEbPef/E6Ksrt3n0zGgHTnf1VKO0veZHhH7s+ptHV9nneLSttgOjZ9ZHULqz
	/w6gW8bDUwTKAVstrrx+7jJfOXl/iq9s3JIqmx3vKRvsNqB8MvBiNv+NYkUhy2hYk4jVFxg0
	RXptkjgzJ+9wnjxeSsVSiXSCWKRnStgkcZoqOza9SOczIRa9w+hKfVQ2YzaLDyQrTIZSCysq
	NJgtSWLWqNEZZcY4M1NiLtVr4/Ss5VVKKn1F7hPmFxcuVb5mHA05fs+7CSqBO6gOBBCQlMFb
	J1uxOhBICEgHgFtjV3hc8BjAU3cvAS54CuDmoMcnI7ZTusde5/hrALqtHpwLVgCcvFLJ99cN
	JpPhdye6UT/GyGi44KjGOT4Ufn12AfPjcDIKzs+e2dbvI4vgH211293C/HPcctv5/gAlrQi0
	Phzn+VUoGQFnFz5G/GPgJAUXbyj8dACpgC1L3QgniYLDKx2oPxeSywRc/n0AcE7ToGfShXJ4
	H3wwZedzOBI+Wb2Gc7gAOlrWdvhC6LQ5d/SHYG/nTZ6/L0pKYN/oAa7Xc7B+YwHhthIMP6wR
	cOpoOF01s1PxBei++DOPw0o4XbPO55bVCOBH7f1IExC179pL+y6X7bvstP/fuRNgNhDJGs0l
	WrZAbqRi9ey7/128wFAyALYfeUz2l6D38604J0AI4ASQQMVhwUSmWisI1jBl5azJkGcq1bFm
	J5D7LtSMRoYXGHy/RG/Jo2SJUll8fLws8WA8JY4I/q36nEZAahkLW8yyRtb0bx5CBERWIgw1
	Gw3e5qdjmfvD7vHJNSt/Zv9VRqW6vipVn/9UteVuXO/aW3YyWXE/7a5C/vT7MmJ+8ODY7bEb
	KUTOnbX31aHCr4Tzw6L0z3pPewWThxQdoUPqwYoMYUJPU6y54uKFJWGKEGa99FCl3XDmbwY1
	fPNI5ekn38wtU4UkxuHl43vsz6f2h/UJn3kbb1ZUTuUKTkSNLza/NZeQsYZPTOzNdS0es9Sn
	/rWhri7WZHl+sQe6JAHlEZT0UU7MD64eXsPLw66u1pXS+eOnjzVJquwZ+V2XdbI97iNfdJTE
	LaaeqjnS9SArKMQqyB3ZOqONqFLX0yLJtz3PVnOoQGzk8NFRMWYuZKgY1GRm/gHosdzCbQQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvO5U/oh0g3+PzSymT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVotVnXNYLC5/38lssWDjI0aLSQdFHYQ8Nq3qZPPYP3cNu8exF8fZPfr/GnhM
	3FPn0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkvG1wLdvFXPH/4h7GB8R5PFyMHh4SAicTS
	fZFdjFwcQgK7GSU6lq9l72LkBIpLS7ye1cUIYQtLrPz3nB2i6DWjxJrmj2wgCV4BO4kLLUuZ
	QWwWAVWJJ3taoeKCEidnPmEBsUUF5CXu35oBNlRYIFPi3qmZbCCDRAT2AG1794AFxGEW6GGS
	uL7mMRvEin5GiTsHv4GNYhYQl7j1ZD4TyK1sAoYSz07YgIQ5BWwkJr1cygRRYibRtRXiVGag
	bdvfzmGewCg0C8khs5BMmoWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3
	MYJjVktzB+P2VR/0DjEycTAeYpTgYFYS4eXwDk0X4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+
	ojdFSCA9sSQ1OzW1ILUIJsvEwSnVwLR2enIT06wLsW8PlPDlbWILDEl6fvlNTewKm0/N/5+K
	aszaX7jU8/OuBb/1O951yJ/bXl90Vqx/0dxje7JPL5zTl7Ir8u60bcyXD3nfr3n17pTQl2+N
	hpILkyb5S9+K32vpfGTe7aZla3heneTViuJ1OBIrP7WVf0ZVaf3ET4wJ2x9tat20KL5jT7fn
	mYkNEwwjJ9hOOl3xLVJB49L/y3cEF3RmO95wV5Fhvr6uXfy0L8NEPtmsww8ONM2NkgzVyLyU
	NbvsxbywPVJsOx03vZpZ87T7ye9wLw7z6+m7U27a/b0Y+8Io9vzeaBvWnybvDHg+TNoS8Xvv
	u+M1fLL7Q5lvP+pvCj4U/58j1bC4ULdDiaU4I9FQi7moOBEAtyi3QkgDAAA=
X-CMS-MailID: 20241210095325epcas5p47339f18d446e8da3efa84bbf3c9e10e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241208152338epcas5p4fde427bb4467414417083221067ac7ab
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
	<20241208152322.1653-1-selvarasu.g@samsung.com>

Hello Maintainers.

Gentle remainder for review.

Thanks,
Selva


On 12/8/2024 8:53 PM, Selvarasu Ganesan wrote:
> The current implementation sets the wMaxPacketSize of bulk in/out
> endpoints to 1024 bytes at the end of the f_midi_bind function. However,
> in cases where there is a failure in the first midi bind attempt,
> consider rebinding. This scenario may encounter an f_midi_bind issue due
> to the previous bind setting the bulk endpoint's wMaxPacketSize to 1024
> bytes, which exceeds the ep->maxpacket_limit where configured TX/RX
> FIFO's maxpacket size of 512 bytes for IN/OUT endpoints in support HS
> speed only.
> This commit addresses this issue by resetting the wMaxPacketSize before
> endpoint claim.
>
> Fixes: 46decc82ffd5 ("usb: gadget: unconditionally allocate hs/ss descriptor in bind operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> ---
>   drivers/usb/gadget/function/f_midi.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 837fcdfa3840..5caa0e4eb07e 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -907,6 +907,15 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>   
>   	status = -ENODEV;
>   
> +	/*
> +	 * Reset wMaxPacketSize with maximum packet size of FS bulk transfer before
> +	 * endpoint claim. This ensures that the wMaxPacketSize does not exceed the
> +	 * limit during bind retries where configured TX/RX FIFO's maxpacket size
> +	 * of 512 bytes for IN/OUT endpoints in support HS speed only.
> +	 */
> +	bulk_in_desc.wMaxPacketSize = cpu_to_le16(64);
> +	bulk_out_desc.wMaxPacketSize = cpu_to_le16(64);
> +
>   	/* allocate instance-specific endpoints */
>   	midi->in_ep = usb_ep_autoconfig(cdev->gadget, &bulk_in_desc);
>   	if (!midi->in_ep)

