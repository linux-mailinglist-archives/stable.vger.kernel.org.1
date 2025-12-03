Return-Path: <stable+bounces-198165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22852C9DCC8
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 06:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03DF3A8267
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 05:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5044625742F;
	Wed,  3 Dec 2025 05:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C8jSJD16"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9F2853F8
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764739574; cv=none; b=eHnDJERPT//FV6S5PegvCW4hZaPxCFMe/FDgAPGjioM8BmfbWibzpU/0KavovNqmp+79rBG7rPtEc8/nu92byey+zyNpq8ByprZx5Qq9KYF0OxysSJl7ZYT+q059pJIRTaZDh49waAQ0hl1KI5EJHhzIsi9nnPsaGij1+jiN5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764739574; c=relaxed/simple;
	bh=WAInTEe94kduSeK2I1IY4CPthL2B8VQWqXTBwImKwc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WNHi9wJuKb/ODKG2eI7e9eZ0+7kb6NdsPA1/y/9v2DcOmbpzRRQkCWkM+bbjP+nddVmnlzGtchlMLVG8ilHzJtnr7P1gbUyz1qh00JWtEwHmENVvE+fmgJWSiRjN2c6/lgKtz1zEHdJJ0zvnChDzh3xua1W6a1apdoAdli3VfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=C8jSJD16; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251203052603epoutp026d733c5b3ac0cc8e86bc959e430b2715~9nUh22yC91019410194epoutp02b
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 05:26:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251203052603epoutp026d733c5b3ac0cc8e86bc959e430b2715~9nUh22yC91019410194epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764739563;
	bh=9dxRdhvloNOCE687PbVJkX5OQhlVeqovcOhqihYfI4Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=C8jSJD16f/c/uVbeK02VI5oLm0DrGd2On/KQTOPGX12ECmo8Nmy546Vfyg7sMT65b
	 2r+m98Ss1UG6bC+DKRkdgEvM0E0Bu9VMZ0HfgDdVof1cSiOC+FfvooaRBPKomjlpnd
	 CcbEWYUycQAXFKuhAxH7Xn87SCtahdo4IUqduuZI=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251203052602epcas5p2c05efeab64c9993bba81468a37e7c650~9nUhTimiu0829408294epcas5p27;
	Wed,  3 Dec 2025 05:26:02 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dLmMF5yJLz3hhTF; Wed,  3 Dec
	2025 05:26:01 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251203052601epcas5p3a2c18a5583363d6a9e3fc52485ec6840~9nUfuEM5w1403514035epcas5p3O;
	Wed,  3 Dec 2025 05:26:01 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251203052559epsmtip2b51e19e5031fc44ab5b935370807edfc~9nUd1msbR2340123401epsmtip2W;
	Wed,  3 Dec 2025 05:25:59 +0000 (GMT)
Message-ID: <4e82c0dd-4a36-4e1d-a93a-9bef5d63aa50@samsung.com>
Date: Wed, 3 Dec 2025 10:55:40 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
To: Alan Stern <stern@rowland.harvard.edu>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>, "h10.kim@samsung.com"
	<h10.kim@samsung.com>, "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "thiagu.r@samsung.com"
	<thiagu.r@samsung.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <f6bba9d1-2221-4bad-a7d7-564a5a311de1@rowland.harvard.edu>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251203052601epcas5p3a2c18a5583363d6a9e3fc52485ec6840
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251117160057epcas5p324eddf1866146216495186a50bcd3c01
References: <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>
	<20251117155920.643-1-selvarasu.g@samsung.com>
	<20251118022116.spdwqjdc7fyls2ht@synopsys.com>
	<f4d27a4c-df75-42b8-9a1c-3fe2a14666ed@rowland.harvard.edu>
	<20251119014858.5phpkofkveb2q2at@synopsys.com>
	<d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
	<20251120020729.k6etudqwotodnnwp@synopsys.com>
	<2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
	<20251121022156.vbnheb6r2ytov7bt@synopsys.com>
	<f6bba9d1-2221-4bad-a7d7-564a5a311de1@rowland.harvard.edu>


On 11/21/2025 8:38 AM, Alan Stern wrote:
> On Fri, Nov 21, 2025 at 02:22:02AM +0000, Thinh Nguyen wrote:
>> On Wed, Nov 19, 2025, Alan Stern wrote:
>>> ->set_alt() is called by the composite core when a Set-Interface or
>>> Set-Config control request arrives from the host.  It happens within the
>>> composite_setup() handler, which is called by the UDC driver when a
>>> control request arrives, which means it happens in the context of the
>>> UDC driver's interrupt handler.  Therefore ->set_alt() callbacks must
>>> not sleep.
>> This should be changed. I don't think we can expect set_alt() to
>> be in interrupt context only.
> Agreed.
>
>>> To do this right, I can't think of any approach other than to make the
>>> composite core use a work queue or other kernel thread for handling
>>> Set-Interface and Set-Config calls.
>> Sounds like it should've been like this initially.
> I guess the nobody thought through the issues very carefully at the time
> the composite framework was designed.  Maybe the UDCs that existed back
> did not require a lot of time to flush endpoints; I can't remember.
>
>>> Without that ability, we will have to audit every function driver to
>>> make sure the ->set_alt() callbacks do ensure that endpoints are flushed
>>> before they are re-enabled.
>>>
>>> There does not seem to be any way to fix the problem just by changing
>>> the gadget core.
>>>
>> We can have a workaround in dwc3 that can temporarily "work" with what
>> we have. However, eventually, we will need to properly rework this and
>> audit the gadget drivers.
> Clearly, the first step is to change the composite core.  That can be
> done without messing up anything else.  But yes, eventually the gadget
> drivers will have to be audited.
>
> Alan Stern


Hi Thinh,

Do you have any suggestions that might be helpful for us to try on our side?
This EP resource‑conflict problem becomes easily observable when the 
RNDIS network test executing ifconfig rndis0 down/up is run repeatedly 
on the device side.

Thanks,
Selva

