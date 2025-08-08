Return-Path: <stable+bounces-166829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A1EB1E68A
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 12:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4A91AA7984
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63827467B;
	Fri,  8 Aug 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LeERSM+N"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB4274677
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754649462; cv=none; b=hXAddKrupfNIq0m0UDv9cPmUCrXdXEPsSFJQ20aK8/mb557Lr5PyvbsvBwNwqetUYR6XbABc+GNVoSYgbeniciiCwLjPe/8TkOpWHqSWSqkjnyMcw5EZBBdyXM5JJ7wXyvBSmM9TkjKwTyFfxLQkWSUNHyyFWe9V9u5Ll0WTXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754649462; c=relaxed/simple;
	bh=DFbbcOY5/H6JQUuqXssqjAboCnz4I7riuC1BUqvx8I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ayJjRHU4ToAjJZrq7v52IHvZzorv/dvLvJ5YLttNrCcwTw14caU8lk2icYaoRcDUcn1GVBrZcVh67GfFq8WCokMhGhXAUdwffc6Dg6YvShm6QF0+YYkxbeitWZZr9IfRCE5BrXiDMRyZQukaBGbSeU4GqnFn+0IlNhBC1HLEOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LeERSM+N; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250808103732epoutp010bb882a4496736ed66a1318b21598297~ZxGFwwyKX0942009420epoutp01f
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 10:37:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250808103732epoutp010bb882a4496736ed66a1318b21598297~ZxGFwwyKX0942009420epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754649452;
	bh=tLJrRsEUYFZQp0Y/N/m+w0KFJz0WpXhgSYsFbM+cppE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LeERSM+NFvK0LFy3CVkt5qlLAvxVClwd4M1B+gSKyvYgBM3K6IDoV9TgVfvAfX4Q6
	 5ypuWvWqPbiH4VpUVyt4Hs2jp9zDfQLiP7PTmLzJbhxdPSR9UzQuPOuI/HnI77+R6M
	 X1sAw1viKdEUo0hPeB30iR1MAEDo80MM+S4ln6lU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250808103731epcas5p3c595d52fb1122012d3c3fae458d7c41c~ZxGEv5IHN1782717827epcas5p3X;
	Fri,  8 Aug 2025 10:37:31 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.88]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bz0pf3qFnz6B9m9; Fri,  8 Aug
	2025 10:37:30 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250808103729epcas5p1a2c83cd71d7e679a6143a3fbfada21a2~ZxGC4inVW0858808588epcas5p1w;
	Fri,  8 Aug 2025 10:37:29 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250808103727epsmtip152847a552a5351517eaba2de9014408b~ZxGAlndIJ2810828108epsmtip1F;
	Fri,  8 Aug 2025 10:37:26 +0000 (GMT)
Message-ID: <20c46529-b531-494a-9746-2084a968639e@samsung.com>
Date: Fri, 8 Aug 2025 16:07:25 +0530
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
In-Reply-To: <20250808090104.RL_xTSvh@linutronix.de>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250808103729epcas5p1a2c83cd71d7e679a6143a3fbfada21a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250807014905epcas5p13f7d4ae515619e1e4d7a998ab2096c32
References: <CGME20250807014905epcas5p13f7d4ae515619e1e4d7a998ab2096c32@epcas5p1.samsung.com>
	<20250807014639.1596-1-selvarasu.g@samsung.com>
	<20250808090104.RL_xTSvh@linutronix.de>


On 8/8/2025 2:31 PM, Sebastian Andrzej Siewior wrote:
> On 2025-08-07 07:16:31 [+0530], Selvarasu Ganesan wrote:
>> This commit addresses a rarely observed endpoint command timeout
> …
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Akash M <akash.m5@samsung.com>
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> The Author is Selvarasu Ganesan <selvarasu.g@samsung.com> while the
> first sign-off is Akash M <akash.m5@samsung.com>. If Akash is the Author
> and you are sending it then the patch body has to start with From: line
> to credit this.
>
> Please see
> https://origin.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> and https://origin.kernel.org/doc/html/latest/process/submitting-patches.html#from-line
>
> Sebastian


Hi Sebastian,

Thank you for pointing out the discrepancy. We will ensure that the 
patch submission accurately reflects the authorship.

Since I, "Selvarasu Ganesan" am the author, I will reorder the sign-offs 
to reflect the correct authorship.

Here is the corrected patch submission:

Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Signed-off-by: Akash M <akash.m5@samsung.com>

Regarding the next steps, I will post a new patchset with the reordered 
sign-offs.

Thanks,
Selva

