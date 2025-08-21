Return-Path: <stable+bounces-171944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC7B2ED26
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 06:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48000A26857
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 04:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7711C4A10;
	Thu, 21 Aug 2025 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kXqRMh1L"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814B2D24BC
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 04:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751363; cv=none; b=f41LH1TM/p/VE8HZAg4jO/4gbJtYFFZGgYdjXjx1h00FzpAk2aa5jvMJgOl+1NsO17PfbM86peAuSNlhLp9e5L4ZtzuIdkSpB+Gb6RFmDvTeZ9fPSDOkT4jf68lXRlTw8NR/RP0E6h755tnkXYrByALkD6QDDr3qoxfxuW3kd+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751363; c=relaxed/simple;
	bh=w4GhD1wnKt7XCKCzRFuc6+utNFkBz7x/huaSlXfODvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=qhXJVa8r3+eUtx73ZN7hoy/felcYOcCnaVuKSdEayztpDq2gw+1LzgEJIGqvT1boc3+P2vwT0sK6i9ZziSZu0F0GVxCGFxgywdnj+t6NJRY5twb3ioOY00B+2pxG3x1uMRT00srL2Ib64BJXCsEThNAIyk0LrvT/TGgXH9hHBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kXqRMh1L; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250821044230epoutp038577ea4ac698dfbfb3c298117ec0c843~droz_nFV90073200732epoutp03I
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 04:42:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250821044230epoutp038577ea4ac698dfbfb3c298117ec0c843~droz_nFV90073200732epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755751350;
	bh=GK9TVnimqkNpG/NRJNRzDGEjInyoz5r75BLcaLgKxbE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kXqRMh1LWMTU6TH/wAxQdsx/NuswB5I/LsWxZM+zXz44O5lF3CNz79CChCRRr0Jjx
	 kmqR1qyrZr8OaEa8E+pnrqoMzHO/f0RP/V9A+rdHcX90dIArOwVSGYmiQHB9AGe/ty
	 1/UK9wyAlWqG/fSQm/MNxYlCLI1W/0beaVKqaF7U=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250821044229epcas5p1a78a07183c5f63a54d42372222b73ed1~drozgRXx82463724637epcas5p1k;
	Thu, 21 Aug 2025 04:42:29 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.88]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c6rK10d3Lz2SSKm; Thu, 21 Aug
	2025 04:42:29 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250821044228epcas5p20eb81a244f628c7769028fa5de857eef~droyTVA0D2011020110epcas5p2r;
	Thu, 21 Aug 2025 04:42:28 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250821044227epsmtip1e71444e683c54300ee5bf98305275c6e~droxeU_cT0151501515epsmtip1I;
	Thu, 21 Aug 2025 04:42:27 +0000 (GMT)
Message-ID: <5580c996-b8a9-4aa2-8c5f-3d23cfe970a7@samsung.com>
Date: Thu, 21 Aug 2025 10:12:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 5.10] usb: dwc3: Remove DWC3 locking during
 gadget suspend/resume
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, "akash.m5@samsung.com" <akash.m5@samsung.com>,
	"thiagu.r@samsung.com" <thiagu.r@samsung.com>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2025082051-circle-state-e38e@gregkh>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250821044228epcas5p20eb81a244f628c7769028fa5de857eef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250820141146epcas5p1a87653e56e5a9e6ce844330a94e76eea
References: <CGME20250820141146epcas5p1a87653e56e5a9e6ce844330a94e76eea@epcas5p1.samsung.com>
	<8c68604b-2775-4d70-a0d6-18ecb979c797@samsung.com>
	<2025082051-circle-state-e38e@gregkh>


On 8/20/2025 7:56 PM, Greg KH wrote:
> On Wed, Aug 20, 2025 at 07:41:44PM +0530, Selvarasu Ganesan wrote:
>> Dear stable team,
>>
>>
>> Patch : usb: dwc3: Remove DWC3 locking during gadget suspend/resume
>>
>> Commit id:5265397f94424eaea596026fd34dc7acf474dcec
>>
>> This patch fixes a critical bug in the dwc3 driver that was introduced
>> by commit
>> (https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/usb/dwc3/gadget.c?h=v5.10.240&id=90e2820c6c30db2427d020d344dfca7de813bd24
>> <https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/usb/dwc3/gadget.c?h=v5.10.240&id=90e2820c6c30db2427d020d344dfca7de813bd24>)
>> in the 5.10 kernel series.
> But that is not what the dwc3 patch says it does, how do we know it is
> ok to backport this?
Hi Greg,

We agree that the dwc3 patch (5265397f9442 : usb: dwc3: Remove DWC3 
locking during gadget suspend/resume ) was missing Fixes/stable tags, 
which led to confusion about its backport.
However, these tags should have been included by the author, as the 
patch fixed a critical bug.

Furthermore, a this USB BUG observed easily in the USB reconnect case 
where the device enters suspend/resume mode with current 5.10 stable kernel.


>
>> The bug causes the below kernel crash (Added usleep in atomic context as
>> part of above patch) under dwc3 suspend/resume scenarios.
>>
>> 35.829644] [6: kworker/6:1: 68] BUG: scheduling while atomic:
>> kworker/6:1/68/0x00000002
>>
>> [ 35.829946] [6: kworker/6:1: 68] CPU: 6 PID: 68 Comm: kworker/6:1
>> Tainted: G C E 5.10.236-android13-4 #1
>>
>> [ 35.830010] [6: kworker/6:1: 68] Call trace:
>>
>> [ 35.830024] [6: kworker/6:1: 68] dump_backtrace.cfi_jt+0x0/0x8
>>
>> [ 35.830034] [6: kworker/6:1: 68] show_stack+0x1c/0x2c
>>
>> [ 35.830044] [6: kworker/6:1: 68] dump_stack_lvl+0xd8/0x134
>>
>> [ 35.830053] [6: kworker/6:1: 68] __schedule_bug+0x80/0xbc
>>
>> [ 35.830062] [6: kworker/6:1: 68] __schedule+0x55c/0x7e8
>>
>> [ 35.830068] [6: kworker/6:1: 68] schedule+0x80/0x100
>>
>> [ 35.830077] [6: kworker/6:1: 68] schedule_hrtimeout_range_clock+0xa8/0x11c
>>
>> [ 35.830083] [6: kworker/6:1: 68] usleep_range+0x68/0xa4
>>
>> [ 35.830093] [6: kworker/6:1: 68] dwc3_gadget_run_stop+0x170/0x448
>>
>> [ 35.830099] [6: kworker/6:1: 68] dwc3_gadget_resume+0x4c/0xdc
>>
>> [ 35.830108] [6: kworker/6:1: 68] dwc3_resume_common+0x6c/0x23c
>>
>> [ 35.830115] [6: kworker/6:1: 68] dwc3_runtime_resume+0x40/0xcc
>>
>> [ 35.830123] [6: kworker/6:1: 68] pm_generic_runtime_resume+0x48/0x88
>>
>> [ 35.830131] [6: kworker/6:1: 68] __rpm_callback+0x94/0x420
>>
>> The patch(5265397f9442) for this fix was originally merged in the below
>> commit:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/dwc3?h=next-20250820&id=5265397f94424eaea596026fd34dc7acf474dcec
>> <https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/dwc3?h=next-20250820&id=5265397f94424eaea596026fd34dc7acf474dcec>
>>
>>    Please apply this patch to the stable 5.10 kernel to prevent this BUG.
>>
>> Additionally the below patch also required to avoid dead lock that
>> introduced by the abovepatch (5265397f9442) in 5.10 stable kernel.
>>
>> Patch:usb: dwc3: core: remove lock of otg mode during gadget
>> suspend/resume to avoid deadlock
>>
>> Commit id:7838de15bb700c2898a7d741db9b1f3cbc86c136
> Can you please submit a backported, and tested, series of patches here
> so that we know that we got the correct ones, and we have your
> signed-off-by on them to show you tested them?

Sure, We will post patches that include backported based on the 5.10 
stable kernel.

Thanks,
Selva
>
> thanks,
>
> greg k-h
>

