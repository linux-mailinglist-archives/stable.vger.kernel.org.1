Return-Path: <stable+bounces-166837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF34B1E8CA
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E4AA08469
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9227A91D;
	Fri,  8 Aug 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IEw726aU"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18E27A46E
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657879; cv=none; b=EEDS0JeIMdNGAMJ3j7jXeXg493ZnCEBvV2e5Rh+Q1gz3TWFhVmvoIKywunUz/J4xjROlcJZi9+hTNKkBmTQUaIfuLpk2h139b6HRiQNooltmuxTPscrsbpiZvlAC/rPAjB2CLlbqm32mkfhBDt5TKLITJfZLquvGqyIyfnQu1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657879; c=relaxed/simple;
	bh=IQvfIcQl6e0vjED1LXORhgHmqLUoE6bjXWpaqRkbHQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UY8gVHz8XtCJlrYWE/38+yHCv8kWrjeJsUpqSrA1oCaE5ShElYFFkUivhjIjt/Vl3XpcT79QJGO3mo6R8RWDmz4pjunTWMelLZvldYEOq3QHT3D4C1XAhA1WnC7pugJA3/ZKxDJnYmGQY5ZmAoY6XZ7SGqpuPgGUTJ5/l9PkOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IEw726aU; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250808125756epoutp04f979987cfea0d9b6c17bdf57aab5e667~ZzAq7TCWe2288322883epoutp04m
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 12:57:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250808125756epoutp04f979987cfea0d9b6c17bdf57aab5e667~ZzAq7TCWe2288322883epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754657876;
	bh=IQvfIcQl6e0vjED1LXORhgHmqLUoE6bjXWpaqRkbHQ8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=IEw726aUID6zYxZtwGVTLBxqgQ8FIpCR7zB3jBR0wANRH8SLFrjbC7BAHSg9niWVF
	 ji2b2qwOo9+JSWGi62COSHDvQgMgdwsMFU8xUWQ2R3ugJA/d/vpzn5ZGICkrK28VF3
	 fDRIoa5EIvaJXwkfnBGAac+O3KBRjo/2WHqAFLPs=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250808125755epcas5p3b9a4febf60b8148ebeab4cb75e654e5d~ZzAqVPJ2G2260122601epcas5p3j;
	Fri,  8 Aug 2025 12:57:55 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bz3wf4yBGz6B9m4; Fri,  8 Aug
	2025 12:57:54 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250808125753epcas5p4900526c630142d68a53dbd36ee8735b5~ZzAovfX6_1320613206epcas5p4I;
	Fri,  8 Aug 2025 12:57:53 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250808125751epsmtip255feeda4d4f6029bbfa56a48fc0d9527~ZzAmfS8DY0613706137epsmtip2M;
	Fri,  8 Aug 2025 12:57:51 +0000 (GMT)
Message-ID: <f0a31913-a019-4f06-b1e7-fbe857cf136e@samsung.com>
Date: Fri, 8 Aug 2025 18:27:50 +0530
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
In-Reply-To: <20250808124346.ynoPIlpX@linutronix.de>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250808125753epcas5p4900526c630142d68a53dbd36ee8735b5
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
	<03f1ab21-3fa7-41b1-a59e-91f1d9dca2f1@samsung.com>
	<20250808124346.ynoPIlpX@linutronix.de>


On 8/8/2025 6:13 PM, Sebastian Andrzej Siewior wrote:
> On 2025-08-08 16:59:08 [+0530], Selvarasu Ganesan wrote:
>>>> Here is the corrected patch submission:
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>>> Signed-off-by: Akash M <akash.m5@samsung.com>
>>>>
>>>> Regarding the next steps, I will post a new patchset with the reordered
>>>> sign-offs.
>>> Your sign-off (as the poster) should come last.
>>> What is Akash' role in this?
>>
>> Akash M's role in the patch as a co-contributor.
>> Shall i add tag as Co-developed-by: Akash M <akash.m5@samsung.com>?
>>
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Akash M <akash.m5@samsung.com>
>> Signed-off-by: Akash M <akash.m5@samsung.com>
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> Yes. This looks good now.
Ok. Thanks for the confirmation.
>
>>>> Thanks,
>>>> Selva
> Sebastian
>
>

