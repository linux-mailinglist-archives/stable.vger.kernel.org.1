Return-Path: <stable+bounces-104473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A269F4985
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3FC1882E48
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B926B1E573F;
	Tue, 17 Dec 2024 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="m0EYeqnB"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFE31EC013;
	Tue, 17 Dec 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734433399; cv=none; b=Sf/hv4OmOrFEOpdyfkXK8wfdP99d5wrG25DTXz+bUuPVQJQjjZpZISzSb9rDhqGyyDcw2DNSdGdeqQIhajPmc16w/PbrlBgXFcaHI0EC/GC/T8l84AgMIeZ7Y4pY+W+R39YberKs9E41wXQ/Dltv8tKsCNes6uCjH7+eprT+hRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734433399; c=relaxed/simple;
	bh=nYvrXhMHRSdqhSkHBR/TZTlF5sSlSIYO1m2zbIVO9K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRPjRSVR4OwD6jKbo5Iw6pJ7+emVpd+2a3artKGGWmrxwKa7IYAli+nHTB+uQsMtuP3wjuEIl7CSESgw2qspOCSxWIFO3ZYT1AJDGcGJWZ6bb3DvUuYnXodD0doimTp/cxYM2eie3VBHYJMFR4Vf2gTEPkwCCvHP9v1HZjU88pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=m0EYeqnB; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=fC1AUrI43IQ3ukIr1TECB40peqU8jmbZEQ/NJSFHlvg=;
	b=m0EYeqnBYlfjAf0KnSL1YpOqw5rzSUsRuDsGs0Upl4yIiRQt8vBLphThiNpoBh
	WbwRDZakMop/2f5woWNRlDqefzabh4AHDXENU7oEqIQJFqp2mxK37RvyP9GQvr/l
	JMDPCg/mUyfvuoylyv5p+QRbbDFAw05vVeKcIox/Rg1p4=
Received: from [172.21.22.210] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD338JSWmFnialTAg--.47635S2;
	Tue, 17 Dec 2024 19:02:43 +0800 (CST)
Message-ID: <7c0d3745-c566-4f14-8ceb-05d882b609aa@126.com>
Date: Tue, 17 Dec 2024 19:02:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6] mm, compaction: don't use ALLOC_CMA in long term GUP
 flow
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, vbabka@suse.cz, liuzixing@hygon.cn
References: <1734406405-25847-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4xSbw7XDe1CWBAfYvMH35n0s1KaSze+wTUDOpwE-VrhfQ@mail.gmail.com>
 <CAGsJ_4zW9wmtGtTNZ4HowvL=suZAf-yAeqLBuKW_soOAEjmo3Q@mail.gmail.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <CAGsJ_4zW9wmtGtTNZ4HowvL=suZAf-yAeqLBuKW_soOAEjmo3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD338JSWmFnialTAg--.47635S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cr4xZrWftr18Kw4ruw1kAFb_yoW8Xr1DCo
	W3GFnrC3Z5Wry3ZF4fGw17Ka9rW34kGw4xJF15Aw1DCF90va1ayay5Kw43ZFW7WFy5tF4f
	G34xta1a9rWSvFn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU54SoDUUUU
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgy4G2dhOfh63QABs0



在 2024/12/17 14:31, Barry Song 写道:
> On Tue, Dec 17, 2024 at 7:14 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Tue, Dec 17, 2024 at 4:33 PM <yangge1116@126.com> wrote:
>>>
>>> From: yangge <yangge1116@126.com>
>>>
>>> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
>>> in __compaction_suitable()") allow compaction to proceed when free
>>> pages required for compaction reside in the CMA pageblocks, it's
>>> possible that __compaction_suitable() always returns true, and in
>>> some cases, it's not acceptable.
>>>
>>> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
>>> of memory. I have configured 16GB of CMA memory on each NUMA node,
>>> and starting a 32GB virtual machine with device passthrough is
>>> extremely slow, taking almost an hour.
>>>
>>> During the start-up of the virtual machine, it will call
>>> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
>>> Long term GUP cannot allocate memory from CMA area, so a maximum
>>> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
>>> machine memory. Since there is 16G of free CMA memory on the NUMA
>>
>> Other unmovable allocations, like dma_buf, which can be large in a
>> Linux system, are
>> also unable to allocate memory from CMA. My question is whether the issue you
>> described applies to these allocations as well.
>>
>>> node, watermark for order-0 always be met for compaction, so
>>> __compaction_suitable() always returns true, even if the node is
>>> unable to allocate non-CMA memory for the virtual machine.
>>>
>>> For costly allocations, because __compaction_suitable() always
>>> returns true, __alloc_pages_slowpath() can't exit at the appropriate
>>> place, resulting in excessively long virtual machine startup times.
>>> Call trace:
>>> __alloc_pages_slowpath
>>>      if (compact_result == COMPACT_SKIPPED ||
>>>          compact_result == COMPACT_DEFERRED)
>>>          goto nopage; // should exit __alloc_pages_slowpath() from here
>>>
>>
>> Do we face the same issue if we allocate dma-buf while CMA has plenty
>> of free memory, but non-CMA has none?
>>
>>> In order to quickly fall back to remote node, we should remove
>>> ALLOC_CMA both in __compaction_suitable() and __isolate_free_page()
>>> in long term GUP flow. After this fix, starting a 32GB virtual machine
>>> with device passthrough takes only a few seconds.
>>>
>>> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compaction_suitable()")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: yangge <yangge1116@126.com>
>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>
>>> V6:
>>> -- update cc->alloc_flags to keep the original loginc
>>>
>>> V5:
>>> - add 'alloc_flags' parameter for __isolate_free_page()
>>> - remove 'usa_cma' variable
>>>
>>> V4:
>>> - rich the commit log description
>>>
>>> V3:
>>> - fix build errors
>>> - add ALLOC_CMA both in should_continue_reclaim() and compaction_ready()
>>>
>>> V2:
>>> - using the 'cc->alloc_flags' to determin if 'ALLOC_CMA' is needed
>>> - rich the commit log description
>>>
>>>   include/linux/compaction.h |  6 ++++--
>>>   mm/compaction.c            | 26 +++++++++++++++-----------
>>>   mm/internal.h              |  3 ++-
>>>   mm/page_alloc.c            |  7 +++++--
>>>   mm/page_isolation.c        |  3 ++-
>>>   mm/page_reporting.c        |  2 +-
>>>   mm/vmscan.c                |  4 ++--
>>>   7 files changed, 31 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
>>> index e947764..b4c3ac3 100644
>>> --- a/include/linux/compaction.h
>>> +++ b/include/linux/compaction.h
>>> @@ -90,7 +90,8 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
>>>                  struct page **page);
>>>   extern void reset_isolation_suitable(pg_data_t *pgdat);
>>>   extern bool compaction_suitable(struct zone *zone, int order,
>>> -                                              int highest_zoneidx);
>>> +                                              int highest_zoneidx,
>>> +                                              unsigned int alloc_flags);
>>>
>>>   extern void compaction_defer_reset(struct zone *zone, int order,
>>>                                  bool alloc_success);
>>> @@ -108,7 +109,8 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
>>>   }
>>>
>>>   static inline bool compaction_suitable(struct zone *zone, int order,
>>> -                                                     int highest_zoneidx)
>>> +                                                     int highest_zoneidx,
>>> +                                                     unsigned int alloc_flags)
>>>   {
>>>          return false;
>>>   }
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index 07bd227..d92ba6c 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -655,7 +655,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>>
>>>                  /* Found a free page, will break it into order-0 pages */
>>>                  order = buddy_order(page);
>>> -               isolated = __isolate_free_page(page, order);
>>> +               isolated = __isolate_free_page(page, order, cc->alloc_flags);
>>>                  if (!isolated)
>>>                          break;
>>>                  set_page_private(page, order);
>>> @@ -1634,7 +1634,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
>>>
>>>                  /* Isolate the page if available */
>>>                  if (page) {
>>> -                       if (__isolate_free_page(page, order)) {
>>> +                       if (__isolate_free_page(page, order, cc->alloc_flags)) {
>>>                                  set_page_private(page, order);
>>>                                  nr_isolated = 1 << order;
>>>                                  nr_scanned += nr_isolated - 1;
>>> @@ -2381,6 +2381,7 @@ static enum compact_result compact_finished(struct compact_control *cc)
>>>
>>>   static bool __compaction_suitable(struct zone *zone, int order,
>>>                                    int highest_zoneidx,
>>> +                                 unsigned int alloc_flags,
>>>                                    unsigned long wmark_target)
>>>   {
>>>          unsigned long watermark;
>>> @@ -2395,25 +2396,26 @@ static bool __compaction_suitable(struct zone *zone, int order,
>>>           * even if compaction succeeds.
>>>           * For costly orders, we require low watermark instead of min for
>>>           * compaction to proceed to increase its chances.
>>> -        * ALLOC_CMA is used, as pages in CMA pageblocks are considered
>>> -        * suitable migration targets
>>> +        * In addition to long term GUP flow, ALLOC_CMA is used, as pages in
>>> +        * CMA pageblocks are considered suitable migration targets
>>
>> I'm not sure if this document is correct for cases other than GUP.
> 
> Hi yangge,
> 
> Could we please run the same test using dma-buf? The simplest approach is
> to use system_heap from drivers/dma-buf/heaps/system_heap.c.
> 
> Userspace programming it is quite straightforward:
> https://static.linaro.org/connect/lvc21/presentations/lvc21-120.pdf
> 
> struct dma_heap_allocation_data heap_data = { .len = 1048576,  // 1meg
>      .fd_flags = O_RDWR | O_CLOEXEC, };
> 
> fd = open(“/dev/dma_heap/system”, O_RDONLY | O_CLOEXEC);
> if (fd < 0)
>        return fd;
> ret = ioctl(fd, DMA_HEAP_IOCTL_ALLOC, &heap_data);
> 
After enabled CONFIG_DMABUF_HEAPS_SYSTEM, CONFIG_DMABUF_HEAPS_CMA, and 
CONFIG_HEAPS, I can see '/dev/dma_heap_system'.

But, after executing the following code, no memory allocation is seen.

struct dma_heap_allocation_data heap_data = { .len = 30*1024*1024*1024,
		.fd_flags = O_RDWR | O_CLOEXEC, };
fd = open(“/dev/dma_heap/system”, O_RDONLY | O_CLOEXEC);
if (fd < 0)
	return fd;
ret = ioctl(fd, DMA_HEAP_IOCTL_ALLOC, &heap_data);

> There are two objectives:
> 1. Whether we should fix the changelog and code documentation, then send
> another version.

I will fix the changelog and code documentation in next version.

> 2. If there are issues elsewhere, we need to port the patch into the Android
> common kernel, which heavily uses dma-buf.

I think dma_buf also have this problem:
__alloc_pages_slowpath() can't exit at the appropriate
place, and it will continue to perform meaningless memory reclaim and 
compaction.

> 
>>
>>>           */
>>>          watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
>>>                                  low_wmark_pages(zone) : min_wmark_pages(zone);
>>>          watermark += compact_gap(order);
>>>          return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
>>> -                                  ALLOC_CMA, wmark_target);
>>> +                                  alloc_flags & ALLOC_CMA, wmark_target);
>>>   }
>>>
>>>   /*
>>>    * compaction_suitable: Is this suitable to run compaction on this zone now?
>>>    */
>>> -bool compaction_suitable(struct zone *zone, int order, int highest_zoneidx)
>>> +bool compaction_suitable(struct zone *zone, int order, int highest_zoneidx,
>>> +                                  unsigned int alloc_flags)
>>>   {
>>>          enum compact_result compact_result;
>>>          bool suitable;
>>>
>>> -       suitable = __compaction_suitable(zone, order, highest_zoneidx,
>>> +       suitable = __compaction_suitable(zone, order, highest_zoneidx, alloc_flags,
>>>                                           zone_page_state(zone, NR_FREE_PAGES));
>>>          /*
>>>           * fragmentation index determines if allocation failures are due to
>>> @@ -2474,7 +2476,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>>>                  available = zone_reclaimable_pages(zone) / order;
>>>                  available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
>>>                  if (__compaction_suitable(zone, order, ac->highest_zoneidx,
>>> -                                         available))
>>> +                                         alloc_flags, available))
>>>                          return true;
>>>          }
>>>
>>> @@ -2499,7 +2501,7 @@ compaction_suit_allocation_order(struct zone *zone, unsigned int order,
>>>                                alloc_flags))
>>>                  return COMPACT_SUCCESS;
>>>
>>> -       if (!compaction_suitable(zone, order, highest_zoneidx))
>>> +       if (!compaction_suitable(zone, order, highest_zoneidx, alloc_flags))
>>>                  return COMPACT_SKIPPED;
>>>
>>>          return COMPACT_CONTINUE;
>>> @@ -2893,6 +2895,7 @@ static int compact_node(pg_data_t *pgdat, bool proactive)
>>>          struct compact_control cc = {
>>>                  .order = -1,
>>>                  .mode = proactive ? MIGRATE_SYNC_LIGHT : MIGRATE_SYNC,
>>> +               .alloc_flags = ALLOC_CMA,
>>>                  .ignore_skip_hint = true,
>>>                  .whole_zone = true,
>>>                  .gfp_mask = GFP_KERNEL,
>>> @@ -3037,7 +3040,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
>>>
>>>                  ret = compaction_suit_allocation_order(zone,
>>>                                  pgdat->kcompactd_max_order,
>>> -                               highest_zoneidx, ALLOC_WMARK_MIN);
>>> +                               highest_zoneidx, ALLOC_CMA | ALLOC_WMARK_MIN);
>>>                  if (ret == COMPACT_CONTINUE)
>>>                          return true;
>>>          }
>>> @@ -3058,6 +3061,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
>>>                  .search_order = pgdat->kcompactd_max_order,
>>>                  .highest_zoneidx = pgdat->kcompactd_highest_zoneidx,
>>>                  .mode = MIGRATE_SYNC_LIGHT,
>>> +               .alloc_flags = ALLOC_CMA | ALLOC_WMARK_MIN,
>>>                  .ignore_skip_hint = false,
>>>                  .gfp_mask = GFP_KERNEL,
>>>          };
>>> @@ -3078,7 +3082,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
>>>                          continue;
>>>
>>>                  ret = compaction_suit_allocation_order(zone,
>>> -                               cc.order, zoneid, ALLOC_WMARK_MIN);
>>> +                               cc.order, zoneid, cc.alloc_flags);
>>>                  if (ret != COMPACT_CONTINUE)
>>>                          continue;
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 3922788..6d257c8 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -662,7 +662,8 @@ static inline void clear_zone_contiguous(struct zone *zone)
>>>          zone->contiguous = false;
>>>   }
>>>
>>> -extern int __isolate_free_page(struct page *page, unsigned int order);
>>> +extern int __isolate_free_page(struct page *page, unsigned int order,
>>> +                                   unsigned int alloc_flags);
>>>   extern void __putback_isolated_page(struct page *page, unsigned int order,
>>>                                      int mt);
>>>   extern void memblock_free_pages(struct page *page, unsigned long pfn,
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index dde19db..1bfdca3 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -2809,7 +2809,8 @@ void split_page(struct page *page, unsigned int order)
>>>   }
>>>   EXPORT_SYMBOL_GPL(split_page);
>>>
>>> -int __isolate_free_page(struct page *page, unsigned int order)
>>> +int __isolate_free_page(struct page *page, unsigned int order,
>>> +                                  unsigned int alloc_flags)
>>>   {
>>>          struct zone *zone = page_zone(page);
>>>          int mt = get_pageblock_migratetype(page);
>>> @@ -2823,7 +2824,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
>>>                   * exists.
>>>                   */
>>>                  watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
>>> -               if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
>>> +               if (!zone_watermark_ok(zone, 0, watermark, 0,
>>> +                           alloc_flags & ALLOC_CMA))
>>>                          return 0;
>>>          }
>>>
>>> @@ -6454,6 +6456,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>>                  .order = -1,
>>>                  .zone = page_zone(pfn_to_page(start)),
>>>                  .mode = MIGRATE_SYNC,
>>> +               .alloc_flags = ALLOC_CMA,
>>>                  .ignore_skip_hint = true,
>>>                  .no_set_skip_hint = true,
>>>                  .alloc_contig = true,
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index c608e9d..a1f2c79 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -229,7 +229,8 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
>>>                          buddy = find_buddy_page_pfn(page, page_to_pfn(page),
>>>                                                      order, NULL);
>>>                          if (buddy && !is_migrate_isolate_page(buddy)) {
>>> -                               isolated_page = !!__isolate_free_page(page, order);
>>> +                               isolated_page = !!__isolate_free_page(page, order,
>>> +                                                   ALLOC_CMA);
>>>                                  /*
>>>                                   * Isolating a free page in an isolated pageblock
>>>                                   * is expected to always work as watermarks don't
>>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>>> index e4c428e..fd3813b 100644
>>> --- a/mm/page_reporting.c
>>> +++ b/mm/page_reporting.c
>>> @@ -198,7 +198,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>>>
>>>                  /* Attempt to pull page from list and place in scatterlist */
>>>                  if (*offset) {
>>> -                       if (!__isolate_free_page(page, order)) {
>>> +                       if (!__isolate_free_page(page, order, ALLOC_CMA)) {
>>>                                  next = page;
>>>                                  break;
>>>                          }
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 5e03a61..33f5b46 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -5815,7 +5815,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>>>                                        sc->reclaim_idx, 0))
>>>                          return false;
>>>
>>> -               if (compaction_suitable(zone, sc->order, sc->reclaim_idx))
>>> +               if (compaction_suitable(zone, sc->order, sc->reclaim_idx, ALLOC_CMA))
>>>                          return false;
>>>          }
>>>
>>> @@ -6043,7 +6043,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
>>>                  return true;
>>>
>>>          /* Compaction cannot yet proceed. Do reclaim. */
>>> -       if (!compaction_suitable(zone, sc->order, sc->reclaim_idx))
>>> +       if (!compaction_suitable(zone, sc->order, sc->reclaim_idx, ALLOC_CMA))
>>>                  return false;
>>>
>>>          /*
>>> --
>>> 2.7.4
>>>
>>>
>>
> Thanks
> Barry


