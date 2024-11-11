Return-Path: <stable+bounces-92139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258BF9C411F
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 15:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5171F245D6
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8AD1A01D8;
	Mon, 11 Nov 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rAZMpoVv"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438D15A84E
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336022; cv=none; b=AtOFaqt4BzfY+GRjmbjelA133HNUQxF6BWHI6/kYW98nvxaqlkbMmVgnUy1No56OyMcNqHaRgn/0SA3G9644B8rWzu/oAFnvV0YjPtscj6VmB58/2sB3WjCmSgoBaipu5pX9+d0lUSxeW6eZSrMeagL0jzxrDUO9UvP99WSbj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336022; c=relaxed/simple;
	bh=fq9gJQClxxuEn+YB4Igeb6OnqsFtKp4jQ2QPEItAL9Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=PnPXc2rfeMXqFlWT179nQ1nEpPuiCSs6StsEmSUpMvWjWxtgJj4bUve5Ax5YM53LczK/ym5lGA+aNoZczm4XL8kf5eRaF5o3bkES0kbpY0+8PN6D3CPIdyfbzodbfNzcceAAU0j/Ioj46F0EpX51w31IVk9gRwfslO3o5H7oZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rAZMpoVv; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241111144018epoutp02f36f956abacc85d5dad1612d89b83f58~G8O97TE1S0687806878epoutp02D
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 14:40:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241111144018epoutp02f36f956abacc85d5dad1612d89b83f58~G8O97TE1S0687806878epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731336018;
	bh=Ad3FP+ExoHUF9icH51NuRcqmBB1Fehm957KfuyYr74k=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=rAZMpoVv940X94tyt/pe+nJLPp3JdoY1JkY8oCw803Dl8VshtPN+OHQZoF7guIypc
	 6Bvfvdc6SvOXSe+oDElnJ7ifGVSvV3CK0P2vNEP0+GUZuVwK5n+A+quAzg8o5Sxa2K
	 Ob82aVvGUv8tfmAxOUG2teZuXnqIlNNjaJGvt3Iw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241111144017epcas5p201e45c7deb51b8a77353b590eb74beca~G8O9OHgbd1338413384epcas5p20;
	Mon, 11 Nov 2024 14:40:17 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XnBzN0b7yz4x9Pp; Mon, 11 Nov
	2024 14:40:16 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9C.4D.08574.F4712376; Mon, 11 Nov 2024 23:40:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241111144015epcas5p4c8dfeacbef382017023b9f01a92b18b9~G8O7bQzbp3079230792epcas5p4r;
	Mon, 11 Nov 2024 14:40:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241111144015epsmtrp289b348945f3904561b7af618e7a7c607~G8O7aZrEO2928229282epsmtrp29;
	Mon, 11 Nov 2024 14:40:15 +0000 (GMT)
X-AuditID: b6c32a44-93ffa7000000217e-2b-6732174f9337
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.DB.35203.F4712376; Mon, 11 Nov 2024 23:40:15 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241111144012epsmtip12099e76e51040682300cfdc7fe414ce6~G8O4_8Oj_1138211382epsmtip1_;
	Mon, 11 Nov 2024 14:40:12 +0000 (GMT)
Message-ID: <7a79d1fb-60fb-4809-9542-02dfdf1156cd@samsung.com>
Date: Mon, 11 Nov 2024 20:09:58 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Alan Stern
	<stern@rowland.harvard.edu>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_akakum@quicinc.com" <quic_akakum@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>, "rc93.raju@samsung.com"
	<rc93.raju@samsung.com>, "taehyun.cho@samsung.com"
	<taehyun.cho@samsung.com>, "hongpooh.kim@samsung.com"
	<hongpooh.kim@samsung.com>, "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"shijie.cai@samsung.com" <shijie.cai@samsung.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>
Content-Language: en-US
In-Reply-To: <20241109010542.q5walgpxwht6ghbx@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmuq6/uFG6wZe3VhZvrq5itXgwbxub
	xZ0F05gsTi1fyGTRvHg9m8WkPVtZLO4+/MFicXnXHDaLRctamS0+Hf3PanH7z15Wi1Wdc4AS
	33cyWyzY+IjRYsLvC0AdB0UtVi04wO4g6LF/7hp2j4l76jxm3/3B6NG3ZRWjx5b9nxk9Pm+S
	C2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpd
	SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApU
	mJCd8XLWC6aCe3IVv3e8Z2xgfC/RxcjBISFgIvF7UVQXIxeHkMBuRomnd9tYIZxPjBLfZ89h
	g3C+MUrM3faMuYuRE6zj8rGrUFV7GSVuHNnMAuG8ZZRYeLuJDaSKV8BO4uCl9+wgNouAqsS1
	q5cYIeKCEidnPmEBsUUF5CXu35rBDnIHm4ChxLMTNiBhYYEoiT0bD4AtExEIk1h2cTcTyHxm
	gdVsEhPuTgbrZRYQl7j1ZD4TiM0pYC2x89xeRoi4vETz1tnMIA0SAlc4JNae+8EIcbaLxMdd
	C1khbGGJV8e3sEPYUhKf3+1lg7CTJfZM+gIVz5A4tOoQ1Mv2EqsXnGEFOZRZQFNi/S59iF18
	Er2/nzBBwpFXoqNNCKJaVeJU42WoidIS95Zcg9rqIXFk7yl2SFgtZZJYfWEb6wRGhVlIwTIL
	yWuzkLwzC2HzAkaWVYySqQXFuempyaYFhnmp5fAIT87P3cQITtpaLjsYb8z/p3eIkYmD8RCj
	BAezkgivhr9+uhBvSmJlVWpRfnxRaU5q8SFGU2D8TGSWEk3OB+aNvJJ4QxNLAxMzMzMTS2Mz
	QyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamDYHG2+4JBi57thyhSv/yrv3HEuRec22on1N
	D4eu9cryWWtufo4+UPZ/k/ua17EHdVstC5ZGO/WsjrKofvVONSvT1U0l+H3ztli9mkP99oUH
	M0W7eMruWU5p1VVkOF953LbqTlzf38Y/jsaK63dxa6veNZwSZtFz4um873W9U7cte8aa7CqY
	/KlZN0Ra8rVkoGnXxYdffMvkY9gSp2k98pN988ZTIFNNU6/CkS0++U+6Zqro9s86JjMX/tM4
	kffJav35BZnb7f9wCyxTVv7LOz0jUryva3MBV8Vb+dPmD91WPZvVrvr891Kx1lVBaTVbt9oU
	OP0urrdr6XO+uv6zTt2iKv2dn8yLGN0Mt8kqsRRnJBpqMRcVJwIALKMG2WMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSnK6/uFG6wbT1QhZvrq5itXgwbxub
	xZ0F05gsTi1fyGTRvHg9m8WkPVtZLO4+/MFicXnXHDaLRctamS0+Hf3PanH7z15Wi1Wdc4AS
	33cyWyzY+IjRYsLvC0AdB0UtVi04wO4g6LF/7hp2j4l76jxm3/3B6NG3ZRWjx5b9nxk9Pm+S
	C2CL4rJJSc3JLEst0rdL4Mp4OesFU8E9uYrfO94zNjC+l+hi5OSQEDCRuHzsKmsXIxeHkMBu
	RolnR28zQySkJV7P6mKEsIUlVv57zg5R9JpRomHnJCaQBK+AncTBS+/ZQWwWAVWJa1cvMULE
	BSVOznzCAmKLCshL3L81A6iGg4NNwFDi2QkbkLCwQJTEno0HwHaJCIRJnDh1GWwMs8B6Nonu
	HxUQu5YySRxcf4ARIiEucevJfLC9nALWEjvP7YWKm0l0be2CsuUlmrfOZp7AKDQLyRmzkLTP
	QtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwRGqpbmDcfuqD3qHGJk4
	GA8xSnAwK4nwavjrpwvxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIkkJ5YkpqdmlqQWgST
	ZeLglGpgkpjGLfOdV+W8rI7gcp8lTn4vnGdpGn0UYhf5L3L347LUOXaeny+a7Fa4e6i9YN/F
	U3O8nLIuJHv6tiZ9M+ur/LgkKLvuRh7/tp/HGGdklB6LWeSw2zVvVRxX/vFog3MnGe/xKP6e
	7fHg09XjU5RkGGsz3HnYVrGuMJ6dE+fAJlZyWHONkJjQwaLvW02/layRVJloMbkg+Bt/ygIb
	O5ePb9NLb/0VXvxFu+Tkrd3XU2dJ25+8dExROOYAV9HVeNPdFz46L2OefzLqmchxpQSe6W/L
	D3guX5RiYZvQYLtlWubfjJPP27XuNbAavExvLNHtm75B8d/U5OvHBM6mH/GV1JN0mbIk92jf
	sfeTV5RcU2Ipzkg01GIuKk4EAH7h/uk/AwAA
X-CMS-MailID: 20241111144015epcas5p4c8dfeacbef382017023b9f01a92b18b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241107104306epcas5p136bea5d14a1bb3fe9ba1a7830bf366c6
References: <CGME20241107104306epcas5p136bea5d14a1bb3fe9ba1a7830bf366c6@epcas5p1.samsung.com>
	<20241107104040.502-1-selvarasu.g@samsung.com>
	<20241107233403.6li5oawn6d23e6gf@synopsys.com>
	<0c8b4491-605f-466c-86cd-1f17c70d6b7b@samsung.com>
	<20241109010542.q5walgpxwht6ghbx@synopsys.com>


On 11/9/2024 6:35 AM, Thinh Nguyen wrote:
> ++ Alan Stern
>
> On Fri, Nov 08, 2024, Selvarasu Ganesan wrote:
>
>>>> +	ram_depth = spram_type ? DWC3_RAM0_DEPTH(dwc->hwparams.hwparams6) :
>>>> +			DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>>> Don't use spram_type as a boolean. Perhaps define a macro for type value
>>> 1 and 0 (for single vs 2-port)
>> Are you expecting something like below?
>>
>> #define DWC3_SINGLE_PORT_RAM     1
>> #define DWC3_TW0_PORT_RAM        0
> Yes. I think it's more readable if we name the variable to "ram_type"
> and use the macros above as I suggested.
>
> If you still plan to use it as boolean, please rename the variable
> spram_type to is_single_port_ram (no one knows what "spram_type" mean
> without the programming guide or some documention).

We are fine to use variable name as a is_single_port_ram with boolean.
Please find the below updated new patch for your review.

https://lore.kernel.org/linux-usb/20241111142049.604-1-selvarasu.g@samsung.com/.


> < snip >
>
>>> We may need to think a little more on how to budgeting the resource
>>> properly to accomodate for different requirements. If there's no single
>>> formula to satisfy for all platform, perhaps we may need to introduce
>>> parameters that users can set base on the needs of their application.
>> Agree. Need to introduce some parameters to control the required fifos
>> by user that based their usecase.
>> Here's a rephrased version of your proposal:
>>
>> To address the issue of determining the required number of FIFOs for
>> different types of transfers, we propose introducing dynamic FIFO
>> calculation for all type of EP transfers based on the maximum packet
>> size, and remove hard code value for required fifos in driver,
> The current fifo calculation already takes on the max packet size into
> account.
>
> For SuperSpeed and above, we can guess how much fifo is needed base on
> the maxburst and mult settings. However, for bulk endpoint in highspeed,
> it needs a bit more checking.
Agree.
>
>> Additionally, we suggest introducing DT properties(tx-fifo-max-num-iso,
>> tx-fifo-max-bulk and tx-fifo-max-intr) for all types of transfers
> This constraint should be decided from the function driver. We should
> try to keep this more generic since your gadget may be used as mass
> storage device instead of UVC where bulk performance is needed more.
Agree.
>
>> (except control EP) to allow users to control the required FIFOs instead
>> of relying solely on the tx-fifo-max-num. This approach will provide
>> more flexibility and customization options for users based on their
>> specific use cases.
>>
>> Please let me know if you have any comments on the above approach.
>>
> How about this: Implement gadget->ops->match_ep() for dwc3 and update
> the note in usb_ep_autoconfig() API.
>
> If the function driver looks for an endpoint by passing in the
> descriptor with wMaxPacketSize set to 0, mark the endpoint to used for
> performance. This is closely related to the usb_ep_autoconfig() behavior
> where it returns the endpoint's maxpacket_limit if wMaxPacketSize is not
> provided. We just need to expand this behavior to look for performance
> endpoint.
>
> If the function driver provides the wMaxPacketSize during
> usb_ep_autoconfig(), then use the minimum required fifo.
>
> What do you think? Will this work for you?


Hi  Thinh,

Thank you for the suggestions. This method makes more sense to us, and 
we are fine proceeding with it. As we previously discussed, we plan to 
create a separate patch for allocating resources for bulk EP.
However, it may take some time on our end as we need to perform 
additional testing with all possible scenarios. In the meantime, please 
review and help to merge the patch for the single port RAM FIFO resizing 
logic.

Thanks,
Selva

>
> BR,
> Thinh

