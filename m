Return-Path: <stable+bounces-104331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F1B9F2FDF
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C1D7A29B9
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 11:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C151D204579;
	Mon, 16 Dec 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AKwuk2sc"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDC82040BC;
	Mon, 16 Dec 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350136; cv=none; b=h/WK12NcW7U5Qopb1qwL2czI8t/L8yoxEQWn9608S4yhjnOwTwJ25/PoJP9Quka9izmvINAIROQRfAMpkqv+MEYphObDJM6LXMn3EWMBMCij0HUSU+4I7aH+TFxfSh2ldMNjGs5RBXF86b8a18YA5HuYCmdzWBH8ZF4EqBGUiB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350136; c=relaxed/simple;
	bh=kVAP8PxF3UrpxZw87ELx0B/Q/qq63lJQQJUfxtANVPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFa0zVTNxBpozMYoGWOea5w1is0fAZURD8Djaz1rBPVSzytNFJ3bJkgN0nRipPAp+TWqzsG//y29cTy8i924zn11FzNsk0tVfq7r6/eclrwK42Nsi/r3FeZhcto+YJN3x0sM7gYoE2EKDiaZX+7gV4mTOqgLoDFtlAUQt1Qy6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=AKwuk2sc; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=vHai0bofydY5qRIK3SpVBL5Nv8an8p0CBft58pGYi0Q=;
	b=AKwuk2scUnVAC4EwlrIo2GqsmFEisCsrP2hXSTmnaUv9rn7zdoI8r6V68R2p5W
	+6UL6qcLVL6reTSyUR0eJ2UzC1PTDvlVcv+PwYrYgVodbLQb2Bv0dtToeq+UEGPd
	7YBLLMqXsDHEsgwTNZj5YVdKJDJbfAcnhXjPb4s3XDcok=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzsmtp3 (Coremail) with SMTP id pykvCgC3HlLCFGBnu946Cg--.55143S2;
	Mon, 16 Dec 2024 19:53:38 +0800 (CST)
Message-ID: <3e160d54-5860-4616-bd32-5faff3afdb49@126.com>
Date: Mon, 16 Dec 2024 19:53:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] mm, compaction: don't use ALLOC_CMA in long term GUP
 flow
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, david@redhat.com, vbabka@suse.cz, liuzixing@hygon.cn
References: <1734256867-19614-1-git-send-email-yangge1116@126.com>
 <f3bf705a-89db-47be-860f-31227b0133a2@linux.alibaba.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <f3bf705a-89db-47be-860f-31227b0133a2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:pykvCgC3HlLCFGBnu946Cg--.55143S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GrWUuF1fur45Jr1rGw47twb_yoW3tw45pF
	18Z3W2y395XFy3Cr48tF409F4Fqw4xKF18Ar1Igw1xZa4akF9293WkKFy3AF4UXryYka1Y
	qFWq9F9ruFsxAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uq2NtUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgW3G2dgFFkEhwAAsa



在 2024/12/16 16:41, Baolin Wang 写道:
> 
> 
> On 2024/12/15 18:01, yangge1116@126.com wrote:
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
>> In order to quickly fall back to remote node, we should remove
>> ALLOC_CMA both in __compaction_suitable() and __isolate_free_page()
>> in long term GUP flow. After this fix, starting a 32GB virtual machine
>> with device passthrough takes only a few seconds.
>>
>> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in 
>> __compaction_suitable()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>
>> V4:
>> - rich the commit log description
>>
>> V3:
>> - fix build errors
>> - add ALLOC_CMA both in should_continue_reclaim() and compaction_ready()
>>
>> V2:
>> - using the 'cc->alloc_flags' to determin if 'ALLOC_CMA' is needed
>> - rich the commit log description
>>
>>   include/linux/compaction.h |  6 ++++--
>>   mm/compaction.c            | 18 +++++++++++-------
>>   mm/page_alloc.c            |  4 +++-
>>   mm/vmscan.c                |  4 ++--
>>   4 files changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
>> index e947764..b4c3ac3 100644
>> --- a/include/linux/compaction.h
>> +++ b/include/linux/compaction.h
>> @@ -90,7 +90,8 @@ extern enum compact_result 
>> try_to_compact_pages(gfp_t gfp_mask,
>>           struct page **page);
>>   extern void reset_isolation_suitable(pg_data_t *pgdat);
>>   extern bool compaction_suitable(struct zone *zone, int order,
>> -                           int highest_zoneidx);
>> +                           int highest_zoneidx,
>> +                           unsigned int alloc_flags);
>>   extern void compaction_defer_reset(struct zone *zone, int order,
>>                   bool alloc_success);
>> @@ -108,7 +109,8 @@ static inline void 
>> reset_isolation_suitable(pg_data_t *pgdat)
>>   }
>>   static inline bool compaction_suitable(struct zone *zone, int order,
>> -                              int highest_zoneidx)
>> +                              int highest_zoneidx,
>> +                              unsigned int alloc_flags)
>>   {
>>       return false;
>>   }
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 07bd227..585f5ab 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2381,9 +2381,11 @@ static enum compact_result 
>> compact_finished(struct compact_control *cc)
>>   static bool __compaction_suitable(struct zone *zone, int order,
>>                     int highest_zoneidx,
>> +                  unsigned int alloc_flags,
>>                     unsigned long wmark_target)
>>   {
>>       unsigned long watermark;
>> +    bool use_cma;
>>       /*
>>        * Watermarks for order-0 must be met for compaction to be able to
>>        * isolate free pages for migration targets. This means that the
>> @@ -2395,25 +2397,27 @@ static bool __compaction_suitable(struct zone 
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
>> +    use_cma = !!(alloc_flags & ALLOC_CMA);
>>       return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
>> -                   ALLOC_CMA, wmark_target);
>> +                   use_cma ? ALLOC_CMA : 0, wmark_target);
> 
> Why not just use 'alloc_flags & ALLOC_CMA' instead? then you can remove 
> the 'use_cma' variable.
yes, I will change it in next version.
> 
>>   }
>>   /*
>>    * compaction_suitable: Is this suitable to run compaction on this 
>> zone now?
>>    */
>> -bool compaction_suitable(struct zone *zone, int order, int 
>> highest_zoneidx)
>> +bool compaction_suitable(struct zone *zone, int order, int 
>> highest_zoneidx,
>> +                   unsigned int alloc_flags)
>>   {
>>       enum compact_result compact_result;
>>       bool suitable;
>> -    suitable = __compaction_suitable(zone, order, highest_zoneidx,
>> +    suitable = __compaction_suitable(zone, order, highest_zoneidx, 
>> alloc_flags,
>>                        zone_page_state(zone, NR_FREE_PAGES));
>>       /*
>>        * fragmentation index determines if allocation failures are due to
>> @@ -2474,7 +2478,7 @@ bool compaction_zonelist_suitable(struct 
>> alloc_context *ac, int order,
>>           available = zone_reclaimable_pages(zone) / order;
>>           available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
>>           if (__compaction_suitable(zone, order, ac->highest_zoneidx,
>> -                      available))
>> +                      alloc_flags, available))
>>               return true;
>>       }
>> @@ -2499,7 +2503,7 @@ compaction_suit_allocation_order(struct zone 
>> *zone, unsigned int order,
>>                     alloc_flags))
>>           return COMPACT_SUCCESS;
>> -    if (!compaction_suitable(zone, order, highest_zoneidx))
>> +    if (!compaction_suitable(zone, order, highest_zoneidx, alloc_flags))
>>           return COMPACT_SKIPPED;
>>       return COMPACT_CONTINUE;
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
> 
> I wonder why not pass ‘cc->alloc_flags’ as a parameter for 
> __isolate_free_page()?
Some places that use __isolate_free_page() don't have 'cc->alloc_flags', 
which leads me to believe that no modification is required.
I will change it in next version.
> 
>>       }
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 5e03a61..33f5b46 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5815,7 +5815,7 @@ static inline bool 
>> should_continue_reclaim(struct pglist_data *pgdat,
>>                         sc->reclaim_idx, 0))
>>               return false;
>> -        if (compaction_suitable(zone, sc->order, sc->reclaim_idx))
>> +        if (compaction_suitable(zone, sc->order, sc->reclaim_idx, 
>> ALLOC_CMA))
>>               return false;
>>       }
>> @@ -6043,7 +6043,7 @@ static inline bool compaction_ready(struct zone 
>> *zone, struct scan_control *sc)
>>           return true;
>>       /* Compaction cannot yet proceed. Do reclaim. */
>> -    if (!compaction_suitable(zone, sc->order, sc->reclaim_idx))
>> +    if (!compaction_suitable(zone, sc->order, sc->reclaim_idx, 
>> ALLOC_CMA))
>>           return false;
>>       /*


