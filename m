Return-Path: <stable+bounces-103979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D589F06AC
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 09:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAAF281D40
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 08:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F131ABEA0;
	Fri, 13 Dec 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Br7TXAJ6"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD7D502B1;
	Fri, 13 Dec 2024 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079518; cv=none; b=A6BsYX+0MchTHUxIQghEkoveYhqXRJ91MtsEb7dR2TT4dmcI+kk8QmImEyMNfib8YSFz2xFiZzA3KYM0N9jT1g9EbdyyXcHsT47P59zqQaFtt1wAK5Hm3t7cCJGeJXn5ZW6V9dJv1rNoB6ABnEIJIuJA3v6L/bHqJD+jhoV5ymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079518; c=relaxed/simple;
	bh=R4lOByC38bcsXyI+lvJteskzBW3zHltZzdR72FWJ0BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ol7nt2Zwn6fv71Avgc5blBytsxYfwhhDpQSQ+6IzuuQXbVabYOj7uteuQ98uZsVfuNHwQRQtNOSwAIfacoDIS5ha2VlctOV/eV36CLLzbROH0QHwhRPhpjCoB0jpV3OFAHgPty80PR9SI3Nc8hUme6pbSvrVuQDuAB5SJItj38I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Br7TXAJ6; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=21o0XTtNuQcRS+Oc7dde/R2xtmPgrdOT4SD3ZXbhO8o=;
	b=Br7TXAJ63rL76NDlkqboL0MkTRngkqIr1kxmhNprvIh7mQjhnvFHSB4iqqIpaX
	nWqqil1Iz8pmX/hEtbaScok5ERRiZXDocHtUaStDQipGIDtUun9QBu35eWlBIetr
	RS46bUpATIFy+E+K7vwtzFKGz/36diQzdU2qRlXDGPvfk=
Received: from [172.21.22.210] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3t2bL81tnFV3LAA--.50419S2;
	Fri, 13 Dec 2024 16:43:55 +0800 (CST)
Message-ID: <3651bce1-f84b-4537-bc57-ef6d7460749f@126.com>
Date: Fri, 13 Dec 2024 16:43:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, compaction: don't use ALLOC_CMA in long term GUP flow
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, david@redhat.com, vbabka@suse.cz, liuzixing@hygon.cn
References: <1734075432-14131-1-git-send-email-yangge1116@126.com>
 <df357a47-7d76-47b8-b91f-3f4bd4d2176e@linux.alibaba.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <df357a47-7d76-47b8-b91f-3f4bd4d2176e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t2bL81tnFV3LAA--.50419S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw13KrWUXF47CFW7JFW5Wrg_yoWrZr45pF
	1xA3WDAws8XFy5Cr48ta1v9F4Yvw4xKF45GryIqw18Zw1akF9a9F1kKry7AFWUur1Ykw4Y
	qFWq9asrZFsxZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6KZXUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOh20G2db5cfQGwACsf



在 2024/12/13 16:23, Baolin Wang 写道:
> 
> 
> On 2024/12/13 15:37, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
>>
>> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
>> in __compaction_suitable()") allow compaction to proceed when free
>> pages required for compaction reside in the CMA pageblocks, it's
>> possible that __compaction_suitable() always returns true, and in
>> some cases, it's not acceptable.
>>
>> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
>> of memory. I have configured 16GB of CMA memory on each NUMA node,
>> and starting a 32GB virtual machine with device passthrough is
>> extremely slow, taking almost an hour.
>>
>> During the start-up of the virtual machine, it will call
>> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
>> Long term GUP cannot allocate memory from CMA area, so a maximum
>> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
>> machine memory. Since there is 16G of free CMA memory on the NUMA
>> node, watermark for order-0 always be met for compaction, so
>> __compaction_suitable() always returns true, even if the node is
>> unable to allocate non-CMA memory for the virtual machine.
>>
>> For costly allocations, because __compaction_suitable() always
>> returns true, __alloc_pages_slowpath() can't exit at the appropriate
>> place, resulting in excessively long virtual machine startup times.
>> Call trace:
>> __alloc_pages_slowpath
>>      if (compact_result == COMPACT_SKIPPED ||
>>          compact_result == COMPACT_DEFERRED)
>>          goto nopage; // should exit __alloc_pages_slowpath() from here
>>
>> To sum up, during long term GUP flow, we should remove ALLOC_CMA
>> both in __compaction_suitable() and __isolate_free_page().
>>
>> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in 
>> __compaction_suitable()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   mm/compaction.c | 8 +++++---
>>   mm/page_alloc.c | 4 +++-
>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 07bd227..044c2247 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2384,6 +2384,7 @@ static bool __compaction_suitable(struct zone 
>> *zone, int order,
>>                     unsigned long wmark_target)
>>   {
>>       unsigned long watermark;
>> +    bool pin;
>>       /*
>>        * Watermarks for order-0 must be met for compaction to be able to
>>        * isolate free pages for migration targets. This means that the
>> @@ -2395,14 +2396,15 @@ static bool __compaction_suitable(struct zone 
>> *zone, int order,
>>        * even if compaction succeeds.
>>        * For costly orders, we require low watermark instead of min for
>>        * compaction to proceed to increase its chances.
>> -     * ALLOC_CMA is used, as pages in CMA pageblocks are considered
>> -     * suitable migration targets
>> +     * In addition to long term GUP flow, ALLOC_CMA is used, as pages in
>> +     * CMA pageblocks are considered suitable migration targets
>>        */
>>       watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
>>                   low_wmark_pages(zone) : min_wmark_pages(zone);
>>       watermark += compact_gap(order);
>> +    pin = !!(current->flags & PF_MEMALLOC_PIN);
>>       return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
>> -                   ALLOC_CMA, wmark_target);
>> +                   pin ? 0 : ALLOC_CMA, wmark_target);
>>   }
> 
> Seems a little hack for me. Using the 'cc->alloc_flags' passed from the 
> caller to determin if ‘ALLOC_CMA’ is needed looks more reasonable to me.

Ok, thanks.

> 
>>   /*
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index dde19db..9a5dfda 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2813,6 +2813,7 @@ int __isolate_free_page(struct page *page, 
>> unsigned int order)
>>   {
>>       struct zone *zone = page_zone(page);
>>       int mt = get_pageblock_migratetype(page);
>> +    bool pin;
>>       if (!is_migrate_isolate(mt)) {
>>           unsigned long watermark;
>> @@ -2823,7 +2824,8 @@ int __isolate_free_page(struct page *page, 
>> unsigned int order)
>>            * exists.
>>            */
>>           watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
>> -        if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
>> +        pin = !!(current->flags & PF_MEMALLOC_PIN);
>> +        if (!zone_watermark_ok(zone, 0, watermark, 0, pin ? 0 : 
>> ALLOC_CMA))
>>               return 0;
>>       }


