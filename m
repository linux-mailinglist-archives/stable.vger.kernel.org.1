Return-Path: <stable+bounces-67738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689299528AA
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 06:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1421F226C7
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 04:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723B3FBB3;
	Thu, 15 Aug 2024 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PkC367M5"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75918D63B
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 04:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697450; cv=none; b=bCc5ta27tZ8OuHXcI7GhrBVirVpDYjksPM+8cDkcrb3LMPVY7o8BabP71e/qiyddkcRfOhIbudaYvnwUJtzDoPqZ0U3ofjO/HRxVom/dUFiWemOXT2VLNZ0+i7HrGNhBq2AEyriHBhbflaqavP87XD3TuqnLsyZxKf9jYTRv7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697450; c=relaxed/simple;
	bh=+sbo/RaN01xb+bMoE+fI4jvDxe5KaagqqbODOZdWilU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=toty4iD5O/OX6JREy/Q7UlpHQxeXgICRvgymwtv+GvPtCJBvzvhPz+tXSDUpZmELpliEpPEYTxBwhgI/fCYYMsKWzLFI6VPztzEpdI6Ya/GvoFXIftp1BpLmEu6oubhZ6tajhcav0Ok4Jp0OmxGzMp9BHUlgBG7sS9M/m+3qg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PkC367M5; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240815045039epoutp0226ce2933d4ed8eee323e002488cca8ad~rzbBnIl6t0383903839epoutp02m
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 04:50:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240815045039epoutp0226ce2933d4ed8eee323e002488cca8ad~rzbBnIl6t0383903839epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723697439;
	bh=B04Z+6zGuB0KBw3YdpPpJZCIUGk1QJZXr7rPMYtlGts=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=PkC367M5yxF1bfV82f5wMwp84QovXGDc7pUfBZ/jCYWt0r6kxT1WiTWYQGt9gKUTg
	 fit/dJ4pvbOTDhz3FquNp+y4njBMrwuxZ8eRwfceQjdsTs7l20gpUSEAVx/alzLqsN
	 xEpnMNqKjtGeJCdnMJHa5jK7Lfto/TY9oEzygbOk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240815045039epcas5p42e8d7cba4902eb634b902e53d99386ca~rzbBIS0Q03231432314epcas5p4i;
	Thu, 15 Aug 2024 04:50:39 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Wkt3d595hz4x9Pt; Thu, 15 Aug
	2024 04:50:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.A1.08855.D198DB66; Thu, 15 Aug 2024 13:50:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240815044941epcas5p443263c18ecb61bbbc08871faf57eccbc~rzaLhtCUt2641926419epcas5p48;
	Thu, 15 Aug 2024 04:49:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240815044941epsmtrp14e0d289d9828a17e8412de60624ae374~rzaLhBnu32251522515epsmtrp1w;
	Thu, 15 Aug 2024 04:49:41 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-1b-66bd891d4f79
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FA.D9.08456.5E88DB66; Thu, 15 Aug 2024 13:49:41 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240815044939epsmtip1a78615c86bab7dd0a600378c8b7320a8~rzaJeP-Po0122001220epsmtip1u;
	Thu, 15 Aug 2024 04:49:39 +0000 (GMT)
Message-ID: <8526e46f-30f2-4f24-8874-624b66aa54b1@samsung.com>
Date: Thu, 15 Aug 2024 10:19:38 +0530
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
In-Reply-To: <20240815000352.squzue3q646bfmmx@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmhq5s5940gx0n1CzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9liwcZHjBaT
	DoparFpwgN2Bz2P/3DXsHn1bVjF6bNn/mdHj8ya5AJaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
	eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
	JbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZL/etZSzokKho/FLewNgk3MXIySEh
	YCKx8el/xi5GLg4hgd2MEpPvzGKGcD4xSnSt2g7lfGOU+PHoCnsXIwdYy82HURDxvYwSh5+/
	YIdw3jJK/F24ixVkLq+AncTnhi9sIDaLgKrEnD/d7BBxQYmTM5+wgNiiAvIS92/NABsqLBAv
	cbk9HCQsIqAjceDEeSYQm1lgL6tE/2dvCFtc4taT+Uwg5WwChhLPTtiAhDkFrCXOzNjFDlEi
	L9G8dTbYzRICezgkljx6ywTxpovEmweP2CFsYYlXx7dA2VISL/vboOxqidV3PrJBNLcAPfbk
	G1TCXuLx0UfMIIuZBTQl1u/ShwjLSkw9tQ7qTj6J3t9PoHbxSuyYB2OrSpxqvMwGYUtL3Fty
	jRUShh4S+xa7T2BUnIUUKLOQfDkLyTuzEBYvYGRZxSiZWlCcm56abFpgmJdaDo/t5PzcTYzg
	9KvlsoPxxvx/eocYmTgYDzFKcDArifAGmuxKE+JNSaysSi3Kjy8qzUktPsRoCoydicxSosn5
	wAyQVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampBahFMHxMHp1QDE98XfZ71Zo5V
	k2JCNmfs1dzb82vuxpscU2teMypeyJ55ed3UNG+2Ix+a6qqWO6ffEc6+u9uWcUf9koMimz02
	XtLf+SnobPo7U4VdIosDX/lP6S5X9xDnm9V9sv6k/d2ZVnU8G9Y+a43nWuj8qTqU5Xfu+cc7
	/J9PuptVMG3Z/qvWD5wn5rB7zt0Z9uiCzbMjUf5vrbTvCrDN5RVJr+R8+Tve8TKrMLPW1Ic7
	X/IxreJpdCx6tvDK1rXWFosUnKddsv8hwhvLJLt3UdEU4Z/deTU++0rONCe/2Hw36om7/Nko
	/WiWehN+4QLPHAPp6amzHHzXTs3ON5YQiOmeO1V5e3ptn/7vi2YX/vccS/0tp8RSnJFoqMVc
	VJwIAIb0vipIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnO7Tjr1pBr/b9SzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9liwcZHjBaT
	DoparFpwgN2Bz2P/3DXsHn1bVjF6bNn/mdHj8ya5AJYoLpuU1JzMstQifbsEroyX+9YyFnRI
	VDR+KW9gbBLuYuTgkBAwkbj5MKqLkYtDSGA3o0RvZxN7FyMnUFxa4vWsLkYIW1hi5b/n7BBF
	rxkltvzbCZbgFbCT+NzwhQ3EZhFQlZjzp5sdIi4ocXLmExYQW1RAXuL+rRlgcWGBeIk122aB
	9YoI6EgcOHGeCWQos8BBVokLk34xQmzoYZZ4smkLK0gVs4C4xK0n85lATmUTMJR4dsIGJMwp
	YC1xZsYudogSM4murRCXMgMta946m3kCo9AsJHfMQjJpFpKWWUhaFjCyrGKUTC0ozk3PLTYs
	MMpLLdcrTswtLs1L10vOz93ECI43La0djHtWfdA7xMjEwXiIUYKDWUmEN9BkV5oQb0piZVVq
	UX58UWlOavEhRmkOFiVx3m+ve1OEBNITS1KzU1MLUotgskwcnFINTE3zb7QbLinZrjnny8K9
	TBczmCbLVM+x9Tv/umqBx3vJXbcvt3ccaA3ds0+b86/W7LavOdwTd//8dW/LxOVWu+/nft+r
	y/38Q8Vd+b7aJ7/bVa1XTrVvSjr4qSvr6LLJd9KCC17YdSV+iHr+O3X72v3OM7I81XYGdDT1
	bZ3rtKK67iPHusU33dyVJbSjteoildfv01yuwnP26c5p+es/b/Ko7pS3yrt2nSNLZ5P0/rpn
	TgUn/M5MbN3XmyulFr5hi4vIlzMOies+vtJP/hIyW4FXJOW/YukGgfnzmbdpzYu/tJ25Quaj
	9L+QGW4Bux4HPj4YHndz1eHECTxfeXic7sx/1iKu456yRMb8Y6tV/AklluKMREMt5qLiRACC
	tM9sJgMAAA==
X-CMS-MailID: 20240815044941epcas5p443263c18ecb61bbbc08871faf57eccbc
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
	<45a638d0-57e0-405f-bbb0-8159d73cc8b6@samsung.com>
	<20240815000352.squzue3q646bfmmx@synopsys.com>


On 8/15/2024 5:34 AM, Thinh Nguyen wrote:
> On Wed, Aug 14, 2024, Selvarasu Ganesan wrote:
>> On 8/14/2024 4:47 AM, Thinh Nguyen wrote:
>>> On Sat, Aug 10, 2024, Selvarasu Ganesan wrote:
>>>> On 8/10/2024 4:58 AM, Thinh Nguyen wrote:
>>>>> On Thu, Aug 08, 2024, Selvarasu Ganesan wrote:
>>>>>> This commit addresses an issue where the USB core could access an
>>>>>> invalid event buffer address during runtime suspend, potentially causing
>>>>>> SMMU faults and other memory issues. The problem arises from the
>>>>>> following sequence.
>>>>>>            1. In dwc3_gadget_suspend, there is a chance of a timeout when
>>>>>>            moving the USB core to the halt state after clearing the
>>>>>>            run/stop bit by software.
>>>>>>            2. In dwc3_core_exit, the event buffer is cleared regardless of
>>>>>>            the USB core's status, which may lead to an SMMU faults and
>>>>> This is a workaround to your specific setup behavior. Please document in
>>>>> the commit message which platforms are impacted.
>>>> Please correct me if i am wrong. I dont think this workaround only
>>>> applicable our specific setup. It could be a common issue across all
>>>> other vendor platforms, and it's required to must check the controller
>>>> status before clear the event buffers address.  What you think is it
>>>> really required to mention the platform details in commit message?
>>> How can it be a common issue, the suspend sequence hasn't completed in
>>> the dwc3 driver but yet the buffer is no longer accessible? Also, as you
>>> noted, we don't know the exact condition for the SMMU fault, and this
>>> isn't reproducible all the time.
>> Agree. Will update platform detail in next version.
>>>>>>            other memory issues. if the USB core tries to access the event
>>>>>>            buffer address.
>>>>>>
>>>>>> To prevent this issue, this commit ensures that the event buffer address
>>>>>> is not cleared by software  when the USB core is active during runtime
>>>>>> suspend by checking its status before clearing the buffer address.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>> We can keep the stable tag, but there's no issue with the commit below.
>>>> By mistaken I mentioned wrong commit ID. The correct commit id would be
>>>> 660e9bde74d69 ("usb: dwc3: remove num_event_buffers").
>>> The above commit isn't the issue either. If it is, then the problem
>>> should still exist prior to that.
>>
>> This issue still persists in older kernels (6.1.X) as well. We believed
>> that it could be a common issue due to the missing condition for
>> checking the controller status in the mentioned commit above. We require
>> this fix in all stable kernel for the Exynos platform. Is it fine to
>> only mention the "Cc" tag in this case?
> You can just Cc stable and indicate how far you want this to be
> backported. Make sure to note that this change resolves a hardware
> quirk.
>
> e.g.
> Cc: stable <stable@kernel.org> # 6.1.x

Sure. Thanks for the confirmation.
>
> BR,
> Thinh

