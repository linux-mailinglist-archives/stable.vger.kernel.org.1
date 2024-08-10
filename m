Return-Path: <stable+bounces-66320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A740594DD75
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16551F219E1
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16793161326;
	Sat, 10 Aug 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a/q0hr6U"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A41607AC
	for <stable@vger.kernel.org>; Sat, 10 Aug 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723303503; cv=none; b=tT1Xxyvodl13NTKki/xLYHg5tZvsBNLDx/51fkNmICKjCeOo1hrRAbrxI54yoas0+ACg12HURrb72bacawEEhrWgufG3OC0XjbqoP43b2JZbObKB76X4kMmIanygNCxUFiojHQUpI+lwgXW+8e40FggEFIW4wkty5Xz9EV7zvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723303503; c=relaxed/simple;
	bh=t3VCCouQnDbrL9wSfpdLSweezDYeNQxokx6inX93DSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Z+cxIsKJ+pe96VoztLJ0Hlbu1Fqgood/mQmY+ue0mkMrB/4yJFaLL2VuFVDflXc4KO8gEgWO3cjPPcPA87OTs7RNRyQlIQZmtIXotH1jGRfO6nnBNKCh1NMFWTSdEQGzwCBqPFersd4kS29KUXuoC9WJUOCCqqdPHxh1XWHBnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=a/q0hr6U; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240810152452epoutp01c092adec7d7bd9b33fb8a23f73bb995f~qZ2V1whr22692526925epoutp01w
	for <stable@vger.kernel.org>; Sat, 10 Aug 2024 15:24:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240810152452epoutp01c092adec7d7bd9b33fb8a23f73bb995f~qZ2V1whr22692526925epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723303492;
	bh=+doLS3iw7weHZn4QcZp9Xt4odCNdv0B2uJTFdQoFKNc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=a/q0hr6UwRtazD7scVqpYkWOCjinnJn/PjJXropsvrD+J5uKY8Q395cfbLBDamLmB
	 +bVBcNQL7P1rmleZ2mC3F6ZR6eCb9mfvqDNCUmdlHtaco4NXfzD+Abs+dEIqZ5sobM
	 pGblf5xoC0LKYE8HUoVvGsGCOF6BhfyHap25xI5k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240810152451epcas5p1ee2e3993f3e855d7c9ce4653ea2d7ad7~qZ2UuEH4T2749627496epcas5p1d;
	Sat, 10 Aug 2024 15:24:51 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Wh4Mj6s3qz4x9Pp; Sat, 10 Aug
	2024 15:24:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	87.E0.09640.14687B66; Sun, 11 Aug 2024 00:24:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240810150929epcas5p29f8f920848d657ca1b618b83a9707610~qZo59giRR2970929709epcas5p2Q;
	Sat, 10 Aug 2024 15:09:29 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240810150929epsmtrp152aa04c2a1bccb09e04252995422dc20~qZo54nrf30127301273epsmtrp1a;
	Sat, 10 Aug 2024 15:09:29 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-3d-66b78641ea32
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.A2.19367.9A287B66; Sun, 11 Aug 2024 00:09:29 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240810150927epsmtip2611b16a87d82862a2e5f07270daed144~qZo36t4Ke2282322823epsmtip2F;
	Sat, 10 Aug 2024 15:09:27 +0000 (GMT)
Message-ID: <98e0cf35-f729-43e2-97f2-06120052a1cc@samsung.com>
Date: Sat, 10 Aug 2024 20:39:25 +0530
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
In-Reply-To: <20240809232804.or5kccyf7yebbqm6@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmuq5j2/Y0g0eXTCzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9liwcZHjBaT
	DoparFpwgN2Bz2P/3DXsHn1bVjF6bNn/mdHj8ya5AJaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
	eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
	JbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZWxbPZy7YL1Wx9eNZ1gbGLtEuRk4O
	CQETiY6Vf5m7GLk4hAR2M0qsO3WOEcL5xCixYs16Njjnyt9fTDAtj1vWsoPYQgI7GSUm9iVD
	FL1llDh35SdYglfATuLMjA4wm0VAVaJ9zjNGiLigxMmZT1hAbFEBeYn7t2YA1XBwCAvES1xu
	DwcJiwjoSBw4cR5sF7PAXlaJ/s/eELa4xK0n85lAytkEDCWenbABCXMKWEuc6zvKDFEiL9G8
	dTbYNxICWzgkDk24CHWzi8SJva9ZIGxhiVfHt7BD2FISL/vboOxqidV3PrJBNLcwShx+8g0q
	YS/x+OgjZpDFzAKaEut36UOEZSWmnloHdSefRO/vJ1C7eCV2zIOxVSVONV5mg7ClJe4tucYK
	MkZCwENi32L3CYyKs5ACZRaSL2cheWcWwuIFjCyrGCVTC4pz01OLTQsM81LL4dGdnJ+7iRGc
	gLU8dzDeffBB7xAjEwfjIUYJDmYlEd7m8E1pQrwpiZVVqUX58UWlOanFhxhNgbEzkVlKNDkf
	mAPySuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgym2Xkkyf/V7O
	f8c67SfZN89tZl8kt2Hpooh9X+fyL6zfddFTdZ+jueCUx368ZldNBFxfimj+udHxc8vBrttV
	ul8+ft3RWPlu8QaObUtm/Pnx1iHmRdie8zsXvEpa8WfOmxoTqV6rx4+ZnkxRn9rN+Hx9utsU
	1frtKxOZHqwMenw66H1t3PO4T5nTxJIfxjxfxCe2wUOc6UbDhslrHXRXL1kiff2wliaLX+fO
	fY3ypi81tot3JX/ha7xgOfvWnUXFDivWcB7abBfw+/qNfbW7jbdNu7BUr+7mXI7QqzPUQlft
	Xieb5CPzo3XDoifHVWsersrRVts4z/Vz9Oolcz+GNMn57qyd+PRxiPK6V5/1Zu+5psRSnJFo
	qMVcVJwIAIXaVppJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvO7Kpu1pBu0TxC3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9liwcZHjBaT
	DoparFpwgN2Bz2P/3DXsHn1bVjF6bNn/mdHj8ya5AJYoLpuU1JzMstQifbsErowti+czF+yX
	qtj68SxrA2OXaBcjJ4eEgInE45a17F2MXBxCAtsZJWa0/GaBSEhLvJ7VxQhhC0us/Pccqug1
	o8Tf3Y+YQRK8AnYSZ2Z0sIPYLAKqEu1znjFCxAUlTs58AjZIVEBe4v6tGWA1wgLxEmu2zQKr
	ERHQkThw4jwTyFBmgYOsEhcm/WKE2HCAUeLC9otsIFXMAuISt57MB6ri4GATMJR4dsIGJMwp
	YC1xru8oM0SJmUTXVohLmYGWNW+dzTyBUWgWkjtmIZk0C0nLLCQtCxhZVjGKphYU56bnJhcY
	6hUn5haX5qXrJefnbmIEx5pW0A7GZev/6h1iZOJgPMQowcGsJMLbHL4pTYg3JbGyKrUoP76o
	NCe1+BCjNAeLkjivck5nipBAemJJanZqakFqEUyWiYNTqoFpxuK29W2m+kvCl7xxWnd4/voV
	9111Q/f8j4yN+thcseaY2gJlyZPaB5YdOnjNlf2UieYCngQhfXu1rNlts49KtOg6/RBb663z
	tcJ5326We0cnCwiYzHMMavwYmH2iYbFyYW5Gv8mxggXW11MvOkgs+Di/vej0LT67hkUiN17z
	tzmd19we9aHq5k8Wb6OWM5ei3v4R2bbxrURK8ZbZERs2OPC+inza9fX94SxdB77AX5ubprBw
	Fx8SnvnaJmduw0lbqQUyj/xCO9o+dn21P3yrcearMxGfVC6KcF5k1yk+pj5Xcu1TR+mqD6Zp
	b5XfnBMW+nL1UUKAeP3W1zePz06Mqr55Xet74BXJbzt3v7wSqsRSnJFoqMVcVJwIABJUUpYk
	AwAA
X-CMS-MailID: 20240810150929epcas5p29f8f920848d657ca1b618b83a9707610
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


On 8/10/2024 4:58 AM, Thinh Nguyen wrote:
> On Thu, Aug 08, 2024, Selvarasu Ganesan wrote:
>> This commit addresses an issue where the USB core could access an
>> invalid event buffer address during runtime suspend, potentially causing
>> SMMU faults and other memory issues. The problem arises from the
>> following sequence.
>>          1. In dwc3_gadget_suspend, there is a chance of a timeout when
>>          moving the USB core to the halt state after clearing the
>>          run/stop bit by software.
>>          2. In dwc3_core_exit, the event buffer is cleared regardless of
>>          the USB core's status, which may lead to an SMMU faults and
> This is a workaround to your specific setup behavior. Please document in
> the commit message which platforms are impacted.
Please correct me if i am wrong. I dont think this workaround only 
applicable our specific setup. It could be a common issue across all 
other vendor platforms, and it's required to must check the controller 
status before clear the event buffers address.  What you think is it 
really required to mention the platform details in commit message?
>
>>          other memory issues. if the USB core tries to access the event
>>          buffer address.
>>
>> To prevent this issue, this commit ensures that the event buffer address
>> is not cleared by software  when the USB core is active during runtime
>> suspend by checking its status before clearing the buffer address.
>>
>> Cc: stable@vger.kernel.org
> We can keep the stable tag, but there's no issue with the commit below.


By mistaken I mentioned wrong commit ID. The correct commit id would be 
660e9bde74d69 ("usb: dwc3: remove num_event_buffers").
>
>> Fixes: 89d7f9629946 ("usb: dwc3: core: Skip setting event buffers for host only controllers")
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>
>> Changes in v2:
>> - Added separate check for USB controller status before cleaning the
>>    event buffer.
>> - Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/lkml/20240722145617.537-1-selvarasu.g@samsung.com/__;!!A4F2R9G_pg!cvZmnaxTWtJKR4ZDRZDa-8mvxpvkf5KPx57IwSXTSEtEFIVkPullR7sTYP0AM9de0xFbHLKdM_5jzBUiBL3f9SuioYE$
>> ---
>>   drivers/usb/dwc3/core.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 734de2a8bd21..5b67d9bca71b 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -564,10 +564,15 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>   void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
>>   {
>>   	struct dwc3_event_buffer	*evt;
>> +	u32				reg;
>>   
>>   	if (!dwc->ev_buf)
>>   		return;
>>   
> Please add comment here why we need this and which platform is impacted
> should we need to go back and test.

Do you want add comment as like below?. If yes, As i said earlier not 
required to mention our platform name as it could be a common issue 
across all the other vendor platforms.

/*Prevent USB controller invalid event buffer address access
in Exynos platform if USB controller still in active.*/
>
>> +	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>> +	if (!(reg & DWC3_DSTS_DEVCTRLHLT))
>> +		return;
>> +
>>   	evt = dwc->ev_buf;
>>   
>>   	evt->lpos = 0;
>> -- 
>> 2.17.1
>>
> Thanks,
> Thinh

