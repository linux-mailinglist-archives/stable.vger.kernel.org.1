Return-Path: <stable+bounces-67603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2419513E1
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 07:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32501F2335C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 05:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8884DA00;
	Wed, 14 Aug 2024 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tlrPlieY"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD24D8BA
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613072; cv=none; b=Wb6ZyUQoc9X5IXcz2x7BbaF3Whdr40TP/s9EIqxnK0cbiOJCa2Akl8cpwV88gRicBhNS81GBxotiXnNVIBFrP1zar7eUbh2klCS4Au3rpDxuyZHgpB8r5x1xqpIG3KRBMsAaugZIAz48BVz+bvEAMlAhG5xWxz4/aDqgRlXWmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613072; c=relaxed/simple;
	bh=0Jg37okIgoHvF/we1XydAONF+6YuWA/o+HS/lIy1XCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Kfn/56g7aiJQM7DvgKL9ncaxZNqljiRm5dVmMcY8H1TxiIpIx77olQzApPX1yP6qSEgYDeC00WCl/L7rO2ppyCDM5vd/gY9qC7rQmGY2v/f1MxFIp8J97twvSvzrMy5lIMIFUNyxqISSEoA2U9oSpdY0vuqUCFAPU+h29t9VRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tlrPlieY; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240814052427epoutp04285f3d82bfdc439523232d464ed8c53d~rgPPmZn-d1104011040epoutp04a
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 05:24:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240814052427epoutp04285f3d82bfdc439523232d464ed8c53d~rgPPmZn-d1104011040epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723613067;
	bh=tgim6fGfnoteNGPRHZsa18v9V1WUkoyXRCy+g53ak1M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tlrPlieYbmE9ez89DP17eRbm4CMGiw2ja8obGfP+e/FgjfjC4uvTeN9SCxEqREdAQ
	 ClJ2ZdAr7qwV0eao4VlwX2uu1Yw2CTew9dnXavmHp2PAJ23zozIRGH3rYUptm+NSLA
	 3+9xGPh/mzDEdW52rIS+2Q8CWgp7cApNmrr+Nagw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240814052426epcas5p15d1ab7ff38b6dca0daf8100be24744f0~rgPPJ_yG72642726427epcas5p1E;
	Wed, 14 Aug 2024 05:24:26 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WkGs45TQyz4x9Pp; Wed, 14 Aug
	2024 05:24:24 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.7D.08855.88F3CB66; Wed, 14 Aug 2024 14:24:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240814045941epcas5p4df2673c284c3b3fc372ef3d75ee769e1~rf5nSrCt01110511105epcas5p4Y;
	Wed, 14 Aug 2024 04:59:41 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240814045941epsmtrp23715f522932946fe0a5cbe25ef8ae322~rf5nRqCXw2056320563epsmtrp2i;
	Wed, 14 Aug 2024 04:59:41 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-c9-66bc3f886966
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DF.37.19367.CB93CB66; Wed, 14 Aug 2024 13:59:40 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240814045938epsmtip1c0d55b73d28bb612aa43db441ec3b0b2~rf5lKyV790771507715epsmtip1l;
	Wed, 14 Aug 2024 04:59:38 +0000 (GMT)
Message-ID: <45a638d0-57e0-405f-bbb0-8159d73cc8b6@samsung.com>
Date: Wed, 14 Aug 2024 10:29:37 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>, "rc93.raju@samsung.com"
	<rc93.raju@samsung.com>, "taehyun.cho@samsung.com"
	<taehyun.cho@samsung.com>, "hongpooh.kim@samsung.com"
	<hongpooh.kim@samsung.com>, "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"shijie.cai@samsung.com" <shijie.cai@samsung.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20240813231744.p4hd4kbhlotjzgmz@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmhm6H/Z40g7dTZC3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9liwcZHjBaT
	DoparFpwgN2Bz2P/3DXsHn1bVjF6bNn/mdHj8ya5AJaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
	eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
	JbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ09unsxdcV6lYs3MrWwNjv2wXIyeH
	hICJxMOz3YxdjFwcQgK7GSU+b1vLDuF8YpS4d/gbC5zz8+wBZpiWid2vWEBsIYGdjBI/HhZC
	FL1llOh73MUOkuAVsJM42HMbaC4HB4uAqsT7Xg+IsKDEyZlPwHpFBeQl7t+awQ5SIiwQL3G5
	PRwkLCKgI3HgxHkmEJtZYC+rRP9nbwhbXOLWk/lMIOVsAoYSz07YgIQ5BawlLizdwAJRIi/R
	vHU2M8g1EgJbOCR2LtvOAlIvIeAiceh0JcT1whKvjm9hh7ClJD6/28sGYVdLrL7zkQ2it4VR
	4vCTb1BF9hKPjz5iBpnDLKApsX6XPkRYVmLqqXVQZ/JJ9P5+wgQR55XYMQ/GVpU41XgZar60
	xL0l11ghzvGQ2LfYfQKj4iykMJmF5MlZSL6ZhbB4ASPLKkbJ1ILi3PTUZNMCw7zUcnhkJ+fn
	bmIEJ18tlx2MN+b/0zvEyMTBeIhRgoNZSYQ30GRXmhBvSmJlVWpRfnxRaU5q8SFGU2DcTGSW
	Ek3OB6b/vJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamHLPu+9v
	mZz4+P4thsuv634arJ0mF7htcWzo+t6OX9wM36dsjl59+0TEecV524TvrzF/v7HDxVf/uuRf
	nxd3WoPsnVN/qPN05Kr8kLv//yu/s+Yf7e9Tb6YVLkhJCjtxJ0vMou7ss0T/9gDX/mCJ3Es5
	DKdO392xa1fGpptNrTNbsidJfLipdTBn+w13/Qtex98YWLnOOXTlmYHrvlmHz/zSL0zvOH0y
	Js39THUssybv3tzEOWve71J9JX2JI8gh5ZtgyU4VmdsF3GYBLNmzlAq1o7J2e5vfeTsjMbTy
	/O3j+Y7myQ0cU8+UuLBdE1ri2LJ20f5HVrcO5XDPM9glmndEPH6jau6Jo9NMeBhbtJRYijMS
	DbWYi4oTAeg+r+dHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnO4eyz1pBmtaTCzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9liwcZHjBaT
	DoparFpwgN2Bz2P/3DXsHn1bVjF6bNn/mdHj8ya5AJYoLpuU1JzMstQifbsErozp7dPZC66r
	VKzZuZWtgbFftouRk0NCwERiYvcrli5GLg4hge2MEj9+fWOGSEhLvJ7VxQhhC0us/PecHaLo
	NaPEv9NzwRK8AnYSB3tuA9kcHCwCqhLvez0gwoISJ2c+YQGxRQXkJe7fmsEOYgsLxEus2TYL
	rFVEQEfiwInzTCAzmQUOskpcmPSLEWLBMiaJRaePgVUxC4hL3HoynwlkAZuAocSzEzYgYU4B
	a4kLSzewQJSYSXRt7YIql5do3jqbeQKj0Cwkd8xCMmkWkpZZSFoWMLKsYhRNLSjOTc9NLjDU
	K07MLS7NS9dLzs/dxAiONK2gHYzL1v/VO8TIxMF4iFGCg1lJhDfQZFeaEG9KYmVValF+fFFp
	TmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA5N/1ZWMgs9bjdV+85uvcHp0dOKf
	rSffvXvGy5oel62QvWRD7ePjrYuvzXK5e7rA7jnnRuOeNfcLxafOdDmmvZL9fkleyQ1foZO3
	bZN8uWo/aXy1mTr3rpMww9THlRpqTQuvLNq8z23ec5V7+TcWKkyUiNQOZmrLXd+m6Ph9KUfE
	TZ7sjruXi3jtf6pxavUuP25wwbWC78RC9qdfnPcoNGauuXH8bcafp1cvPeur89sizlFWZDhn
	x4y1ryZel6x6kupkWPTo3JwNXG8WekqoalZ+VF+U6XWdu/XFskA+MTWt34JJbBYOVVfCr+un
	rnD9YtirJc9fd8TIOcAwbLWrtmaD6W7vmWzGZ5Tsc7Y2eCuxFGckGmoxFxUnAgCSboROIwMA
	AA==
X-CMS-MailID: 20240814045941epcas5p4df2673c284c3b3fc372ef3d75ee769e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd
References: <CGME20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd@epcas5p2.samsung.com>
	<20240808120507.1464-1-selvarasu.g@samsung.com>
	<20240809232804.or5kccyf7yebbqm6@synopsys.com>
	<98e0cf35-f729-43e2-97f2-06120052a1cc@samsung.com>
	<20240813231744.p4hd4kbhlotjzgmz@synopsys.com>


On 8/14/2024 4:47 AM, Thinh Nguyen wrote:
> On Sat, Aug 10, 2024, Selvarasu Ganesan wrote:
>> On 8/10/2024 4:58 AM, Thinh Nguyen wrote:
>>> On Thu, Aug 08, 2024, Selvarasu Ganesan wrote:
>>>> This commit addresses an issue where the USB core could access an
>>>> invalid event buffer address during runtime suspend, potentially causing
>>>> SMMU faults and other memory issues. The problem arises from the
>>>> following sequence.
>>>>           1. In dwc3_gadget_suspend, there is a chance of a timeout when
>>>>           moving the USB core to the halt state after clearing the
>>>>           run/stop bit by software.
>>>>           2. In dwc3_core_exit, the event buffer is cleared regardless of
>>>>           the USB core's status, which may lead to an SMMU faults and
>>> This is a workaround to your specific setup behavior. Please document in
>>> the commit message which platforms are impacted.
>> Please correct me if i am wrong. I dont think this workaround only
>> applicable our specific setup. It could be a common issue across all
>> other vendor platforms, and it's required to must check the controller
>> status before clear the event buffers address.  What you think is it
>> really required to mention the platform details in commit message?
> How can it be a common issue, the suspend sequence hasn't completed in
> the dwc3 driver but yet the buffer is no longer accessible? Also, as you
> noted, we don't know the exact condition for the SMMU fault, and this
> isn't reproducible all the time.

Agree. Will update platform detail in next version.
>
>>>>           other memory issues. if the USB core tries to access the event
>>>>           buffer address.
>>>>
>>>> To prevent this issue, this commit ensures that the event buffer address
>>>> is not cleared by software  when the USB core is active during runtime
>>>> suspend by checking its status before clearing the buffer address.
>>>>
>>>> Cc: stable@vger.kernel.org
>>> We can keep the stable tag, but there's no issue with the commit below.
>>
>> By mistaken I mentioned wrong commit ID. The correct commit id would be
>> 660e9bde74d69 ("usb: dwc3: remove num_event_buffers").
> The above commit isn't the issue either. If it is, then the problem
> should still exist prior to that.


This issue still persists in older kernels (6.1.X) as well. We believed 
that it could be a common issue due to the missing condition for 
checking the controller status in the mentioned commit above. We require 
this fix in all stable kernel for the Exynos platform. Is it fine to 
only mention the "Cc" tag in this case?
>
>>>> Fixes: 89d7f9629946 ("usb: dwc3: core: Skip setting event buffers for host only controllers")
>>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Added separate check for USB controller status before cleaning the
>>>>     event buffer.
>>>> - Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/lkml/20240722145617.537-1-selvarasu.g@samsung.com/__;!!A4F2R9G_pg!cvZmnaxTWtJKR4ZDRZDa-8mvxpvkf5KPx57IwSXTSEtEFIVkPullR7sTYP0AM9de0xFbHLKdM_5jzBUiBL3f9SuioYE$
>>>> ---
>>>>    drivers/usb/dwc3/core.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index 734de2a8bd21..5b67d9bca71b 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -564,10 +564,15 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>>>    void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
>>>>    {
>>>>    	struct dwc3_event_buffer	*evt;
>>>> +	u32				reg;
>>>>    
>>>>    	if (!dwc->ev_buf)
>>>>    		return;
>>>>    
>>> Please add comment here why we need this and which platform is impacted
>>> should we need to go back and test.
>> Do you want add comment as like below?. If yes, As i said earlier not
>> required to mention our platform name as it could be a common issue
>> across all the other vendor platforms.
> See note above.

Noted.
>
>> /*Prevent USB controller invalid event buffer address access
>> in Exynos platform if USB controller still in active.*/
> Perhaps this:
>
> /*
>   * Exynos platforms may not be able to access event buffer if the
>   * controller failed to halt on dwc3_core_exit().

Thanks for the suggestions. Will update platform detail in next version.
>   */
>
>   BR,
>   Thinh
>
>>>> +	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>>>> +	if (!(reg & DWC3_DSTS_DEVCTRLHLT))
>>>> +		return;
>>>> +
>>>>    	evt = dwc->ev_buf;
>>>>    
>>>>    	evt->lpos = 0;
>>>> -- 
>>>> 2.17.1
>>>>
>>> Thanks,
>>> Thinh

