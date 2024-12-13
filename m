Return-Path: <stable+bounces-103978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A70A9F069C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 09:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4674E281B17
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C851AB6CB;
	Fri, 13 Dec 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZtMM5O/y"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B52F6EB4C;
	Fri, 13 Dec 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079370; cv=none; b=W98ToUm5oAFzaghs0LohjM899DwPtQkrYXJ8mazEYDd4ukL9jYXmjsdNZ4/KUy6hwibkCUieSxEUqxV3Zh6y3zZzFCKUzNaSb3EWcbIMlgclkV/kr2IoPbWEBXEFFZrdzOu+XFq8A29bvcc5IPtFvQOEiWRHO+Hvq/Eph45MKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079370; c=relaxed/simple;
	bh=gk4Rsm6h7CdWL6QyrwRS9KG0wRrZkhVav/xQzE+V4cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3nZqVyktJHlm4S3kkExO3A9b6l7sT5kh1c+9+pcrjNy56h1L/FHW2IU97PwkkplTLx0RFNgVZYXvNnce0K6O+YLE1eQoie3yE446mcEha4tQ6IVVX42Ofd3UiaPz4uB4TUAvrajgqzlUCW49dLWTGihnBOoLS9oZRTo8zDfSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZtMM5O/y; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=3VHdoh6qZKjjSI6N1JNEN/E9xuIJhplBCcKSHl3u1Ko=;
	b=ZtMM5O/y7zpgxgY5AAAxqm88/dVuNPPVSONvrQBVPj1mA/piH7jTBp9Y992Amy
	BQPdRZjDaX6+dJKMvYAsnJaF3wWGcfFwykfTCYApD1iLmsJwfKFmbn+798A+dO2H
	84fq3WAolLKK88C4SYQWEWOuRV4fWBP5GoOm9oHnnIq48=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzsmtp2 (Coremail) with SMTP id pikvCgD3P6o181tn9vusCQ--.21428S2;
	Fri, 13 Dec 2024 16:41:26 +0800 (CST)
Message-ID: <766c24df-3dbc-4b15-bd3a-3051a0b5f3ee@126.com>
Date: Fri, 13 Dec 2024 16:41:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, compaction: don't use ALLOC_CMA in long term GUP flow
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, vbabka@suse.cz, liuzixing@hygon.cn
References: <1734075432-14131-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4yQ5f1Nqu+aw2WRWivcK=PNdghdkYG3OneTJvL9mjdiiQ@mail.gmail.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <CAGsJ_4yQ5f1Nqu+aw2WRWivcK=PNdghdkYG3OneTJvL9mjdiiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:pikvCgD3P6o181tn9vusCQ--.21428S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr4DGFy5GrW8Jr47GFy7Awb_yoW7Xw47pF
	4xA3Wqyws5XFy3Cr18tw4v9F4Yvw4xKF45Gr9Fqr1DuwnIkF9a9F1kKFyUZFW5ur1akw4Y
	qFWq9asrZFsxZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uq1v3UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOh20G2db5cfQGwABsc



在 2024/12/13 15:56, Barry Song 写道:
> On Fri, Dec 13, 2024 at 3:37 PM <yangge1116@126.com> wrote:
>>
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
> 
> I don't fully understand why each node has a 16GB CMA. As I recall, I designed
> the per-NUMA CMA to support devices that are not behind the IOMMU, such as
> the IOMMU itself or certain device drivers which are not having IOMMU and
> need contiguous memory for DMA. These devices don't seem to require that
> much memory.
Our hardware supports setting specific protection for contiguous memory 
block, but the granularity of protection is relatively large, exceeding 
4MB, which makes it unsuitable for allocation from buddy. Therefore, 
during system startup, a certain percentage of memory on each node is 
reserved as CMA memory, allowing for the allocation of large contiguous 
memory blocks through cma_alloc.
> 
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
>>      if (compact_result == COMPACT_SKIPPED ||
>>          compact_result == COMPACT_DEFERRED)
>>          goto nopage; // should exit __alloc_pages_slowpath() from here
>>
>> To sum up, during long term GUP flow, we should remove ALLOC_CMA
>> both in __compaction_suitable() and __isolate_free_page().
> 
> What’s the outcome after your fix? Will it quickly fall back to remote
> NUMA nodes
> for the pin?
Starting a 32GB virtual machine with device passthrough takes only a 
free seconds.
Yes, it will quickly fall back to remote NUMA nodes.
> 
>>
>> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compaction_suitable()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   mm/compaction.c | 8 +++++---
>>   mm/page_alloc.c | 4 +++-
>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 07bd227..044c2247 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2384,6 +2384,7 @@ static bool __compaction_suitable(struct zone *zone, int order,
>>                                    unsigned long wmark_target)
>>   {
>>          unsigned long watermark;
>> +       bool pin;
>>          /*
>>           * Watermarks for order-0 must be met for compaction to be able to
>>           * isolate free pages for migration targets. This means that the
>> @@ -2395,14 +2396,15 @@ static bool __compaction_suitable(struct zone *zone, int order,
>>           * even if compaction succeeds.
>>           * For costly orders, we require low watermark instead of min for
>>           * compaction to proceed to increase its chances.
>> -        * ALLOC_CMA is used, as pages in CMA pageblocks are considered
>> -        * suitable migration targets
>> +        * In addition to long term GUP flow, ALLOC_CMA is used, as pages in
>> +        * CMA pageblocks are considered suitable migration targets
>>           */
>>          watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
>>                                  low_wmark_pages(zone) : min_wmark_pages(zone);
>>          watermark += compact_gap(order);
>> +       pin = !!(current->flags & PF_MEMALLOC_PIN);
>>          return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
>> -                                  ALLOC_CMA, wmark_target);
>> +                                  pin ? 0 : ALLOC_CMA, wmark_target);
>>   }
>>
>>   /*
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index dde19db..9a5dfda 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2813,6 +2813,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
>>   {
>>          struct zone *zone = page_zone(page);
>>          int mt = get_pageblock_migratetype(page);
>> +       bool pin;
>>
>>          if (!is_migrate_isolate(mt)) {
>>                  unsigned long watermark;
>> @@ -2823,7 +2824,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
>>                   * exists.
>>                   */
>>                  watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
>> -               if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
>> +               pin = !!(current->flags & PF_MEMALLOC_PIN);
>> +               if (!zone_watermark_ok(zone, 0, watermark, 0, pin ? 0 : ALLOC_CMA))
>>                          return 0;
>>          }
>>
>> --
>> 2.7.4
>>
> Thanks
> Barry


