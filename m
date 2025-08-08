Return-Path: <stable+bounces-166833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5A6B1E758
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 13:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011CB5A05C2
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021C52749DB;
	Fri,  8 Aug 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nhwTd2ed"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30826463B
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652558; cv=none; b=HZ0WF3eCrClvcyaE1szeSMfyCeovLfNmJT929kVTyjZZI+XdMEKu1O193FBfKfpyCRlKSiFpVcEYAYEcuKQ1J4xlR0m+oedS3DtboS+b2yP+QT4+UGNOeOalsVdCDiXxelpABamLemNkWp4Bo44wA4Hk32GnOjDjv9g4mFpsU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652558; c=relaxed/simple;
	bh=TBJ59euEFZvE5z9IZ8MPSF77dcNwPaN6yTb2xeo5BJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=JnnbN6fNILKnUAgmUE4yUsEScI0zNIjcbgLZ4tX4ew/prh+WoTZKmHTRH4378Y08OMJ2yvfEmoBBUaGcU5k7Xu6LBu2bpv4zuDcNL/cK64gv10aQwYCmBR50VToWBtgs5y5pxSZR3iVpXbVKAv5Yrde0tD7kstCoqXfAOwb675w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nhwTd2ed; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250808112913epoutp0427d0e0c2dc7c4e33140ddfe23ddaebb4~ZxzN9BIVz1596915969epoutp04f
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 11:29:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250808112913epoutp0427d0e0c2dc7c4e33140ddfe23ddaebb4~ZxzN9BIVz1596915969epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754652553;
	bh=TBJ59euEFZvE5z9IZ8MPSF77dcNwPaN6yTb2xeo5BJc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nhwTd2edMbLxPe+E5gCk6fUsXyN52PmqUMpPwRyryDyoXhiMWJDEmOh1VfphwxrWk
	 YS/TwHqM0TFbnal5t8BcDo47azeCnm6OFZ6fOLa+lL70Feef8VAFhKiXnZL1qbKE/E
	 3eP7v1Amvf+va5Ddqk9QY1pQaGyP8qOuQxcu5d1I=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250808112913epcas5p4abe581c8ef0c10c7a5cdad9e31e31035~ZxzNcwFlt1928619286epcas5p4N;
	Fri,  8 Aug 2025 11:29:13 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bz1yJ26BQz6B9m5; Fri,  8 Aug
	2025 11:29:12 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250808112911epcas5p19e8d412d90d69c2bbac4fe1b7347343e~ZxzMDNaNF0130801308epcas5p1u;
	Fri,  8 Aug 2025 11:29:11 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250808112909epsmtip1c5cc52df52ec72f61267b3ccbfd0e1d8~ZxzJ1UsIh2461024610epsmtip1t;
	Fri,  8 Aug 2025 11:29:09 +0000 (GMT)
Message-ID: <03f1ab21-3fa7-41b1-a59e-91f1d9dca2f1@samsung.com>
Date: Fri, 8 Aug 2025 16:59:08 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: Remove WARN_ON for device endpoint
 command timeouts
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	m.grzeschik@pengutronix.de, balbi@ti.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, akash.m5@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, alim.akhtar@samsung.com,
	muhammed.ali@samsung.com, thiagu.r@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20250808105218.WmVk--eM@linutronix.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250808112911epcas5p19e8d412d90d69c2bbac4fe1b7347343e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250807014905epcas5p13f7d4ae515619e1e4d7a998ab2096c32
References: <CGME20250807014905epcas5p13f7d4ae515619e1e4d7a998ab2096c32@epcas5p1.samsung.com>
	<20250807014639.1596-1-selvarasu.g@samsung.com>
	<20250808090104.RL_xTSvh@linutronix.de>
	<20c46529-b531-494a-9746-2084a968639e@samsung.com>
	<20250808105218.WmVk--eM@linutronix.de>


On 8/8/2025 4:22 PM, Sebastian Andrzej Siewior wrote:
> On 2025-08-08 16:07:25 [+0530], Selvarasu Ganesan wrote:
>> Thank you for pointing out the discrepancy. We will ensure that the
>> patch submission accurately reflects the authorship.
>>
>> Since I, "Selvarasu Ganesan" am the author, I will reorder the sign-offs
>> to reflect the correct authorship.
>>
>> Here is the corrected patch submission:
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> Signed-off-by: Akash M <akash.m5@samsung.com>
>>
>> Regarding the next steps, I will post a new patchset with the reordered
>> sign-offs.
> Your sign-off (as the poster) should come last.
> What is Akash' role in this?


Akash M's role in the patch as a co-contributor.
Shall i add tag as Co-developed-by: Akash M <akash.m5@samsung.com>?

Cc: stable@vger.kernel.org
Co-developed-by: Akash M <akash.m5@samsung.com>
Signed-off-by: Akash M <akash.m5@samsung.com>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>


>> Thanks,
>> Selva
> Sebastian
>
>

