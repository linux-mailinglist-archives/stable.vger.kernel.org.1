Return-Path: <stable+bounces-104443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19C79F4522
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248D8168350
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FE915B0EC;
	Tue, 17 Dec 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rpVjO5J2"
X-Original-To: stable@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1D179A7;
	Tue, 17 Dec 2024 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420710; cv=none; b=JMKqH+fh0HqMkfgNkrDAdlLyKVUoLka/NNH+aNM+NhC4ExC3OA0CFQw54/Z6PaW/jc2eROTPJYywHnhgyO3N+mAkSwMAUuSks+6NDv2skHOVyrZDdE7KFp5vnJhOIAuprX60rtZSKoE2TXGZ4iPsP7sIQCICp+DAoE3gVRWBAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420710; c=relaxed/simple;
	bh=yqHi8COCMHDxXc9RpRMrg9Yc48F9LlRQHxz73EXLwdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKfTRC/gvDhJ1R/PSLt7CBW4o6WoE6ZwKeFqedmBTn7i9LKlk1IQEE97D/kbFjuNVsZ/uclt0OBpR+6iNi+qeMx+IjOHqGMQ9Y2BzoE4hCr07WR35JPeZegtG4+GRpP/qqQ/Y4rPzyyq8W1+fyNN3JTKuWDE0+n2cNi+y9aW2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rpVjO5J2; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734420698; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TkosoO+3ONVOSeeI8+WgoAPbCZNq1k7eOucDpvCkMms=;
	b=rpVjO5J29e6lkeqkdmU8iiu6w6py7L9uT/LzNLiGXA/sKdi9n3KxmcpnDC1R0oG8h8XoMEZmnFY9osvygjktiixSURtDcS+kcTy2v+4APCOA4bNIN5hY/Bns2ZTIdZM1noNXSDM9vssaM/WLIdh/rignu0OAI0mGEcN7N4zaB+U=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WLhprS1_1734420696 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 15:31:37 +0800
Message-ID: <03d09def-2509-4e87-ad14-cf616ac90908@linux.alibaba.com>
Date: Tue, 17 Dec 2024 15:31:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6] mm, compaction: don't use ALLOC_CMA in long term GUP
 flow
To: Barry Song <21cnbao@gmail.com>, yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com,
 vbabka@suse.cz, liuzixing@hygon.cn
References: <1734406405-25847-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4xSbw7XDe1CWBAfYvMH35n0s1KaSze+wTUDOpwE-VrhfQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xSbw7XDe1CWBAfYvMH35n0s1KaSze+wTUDOpwE-VrhfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/17 14:14, Barry Song wrote:
> On Tue, Dec 17, 2024 at 4:33 PM <yangge1116@126.com> wrote:
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
>>
>> During the start-up of the virtual machine, it will call
>> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
>> Long term GUP cannot allocate memory from CMA area, so a maximum
>> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
>> machine memory. Since there is 16G of free CMA memory on the NUMA
> 
> Other unmovable allocations, like dma_buf, which can be large in a
> Linux system, are
> also unable to allocate memory from CMA. My question is whether the issue you
> described applies to these allocations as well.
> 
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
> 
> Do we face the same issue if we allocate dma-buf while CMA has plenty
> of free memory, but non-CMA has none?
> 
>> In order to quickly fall back to remote node, we should remove
>> ALLOC_CMA both in __compaction_suitable() and __isolate_free_page()
>> in long term GUP flow. After this fix, starting a 32GB virtual machine
>> with device passthrough takes only a few seconds.
>>
>> Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compaction_suitable()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: yangge <yangge1116@126.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>
>> V6:
>> -- update cc->alloc_flags to keep the original loginc
>>
>> V5:
>> - add 'alloc_flags' parameter for __isolate_free_page()
>> - remove 'usa_cma' variable
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
>>   include/linux/compaction.h |  6 ++++--
>>   mm/compaction.c            | 26 +++++++++++++++-----------
>>   mm/internal.h              |  3 ++-
>>   mm/page_alloc.c            |  7 +++++--
>>   mm/page_isolation.c        |  3 ++-
>>   mm/page_reporting.c        |  2 +-
>>   mm/vmscan.c                |  4 ++--
>>   7 files changed, 31 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
>> index e947764..b4c3ac3 100644
>> --- a/include/linux/compaction.h
>> +++ b/include/linux/compaction.h
>> @@ -90,7 +90,8 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
>>                  struct page **page);
>>   extern void reset_isolation_suitable(pg_data_t *pgdat);
>>   extern bool compaction_suitable(struct zone *zone, int order,
>> -                                              int highest_zoneidx);
>> +                                              int highest_zoneidx,
>> +                                              unsigned int alloc_flags);
>>
>>   extern void compaction_defer_reset(struct zone *zone, int order,
>>                                  bool alloc_success);
>> @@ -108,7 +109,8 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
>>   }
>>
>>   static inline bool compaction_suitable(struct zone *zone, int order,
>> -                                                     int highest_zoneidx)
>> +                                                     int highest_zoneidx,
>> +                                                     unsigned int alloc_flags)
>>   {
>>          return false;
>>   }
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 07bd227..d92ba6c 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -655,7 +655,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>
>>                  /* Found a free page, will break it into order-0 pages */
>>                  order = buddy_order(page);
>> -               isolated = __isolate_free_page(page, order);
>> +               isolated = __isolate_free_page(page, order, cc->alloc_flags);
>>                  if (!isolated)
>>                          break;
>>                  set_page_private(page, order);
>> @@ -1634,7 +1634,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
>>
>>                  /* Isolate the page if available */
>>                  if (page) {
>> -                       if (__isolate_free_page(page, order)) {
>> +                       if (__isolate_free_page(page, order, cc->alloc_flags)) {
>>                                  set_page_private(page, order);
>>                                  nr_isolated = 1 << order;
>>                                  nr_scanned += nr_isolated - 1;
>> @@ -2381,6 +2381,7 @@ static enum compact_result compact_finished(struct compact_control *cc)
>>
>>   static bool __compaction_suitable(struct zone *zone, int order,
>>                                    int highest_zoneidx,
>> +                                 unsigned int alloc_flags,
>>                                    unsigned long wmark_target)
>>   {
>>          unsigned long watermark;
>> @@ -2395,25 +2396,26 @@ static bool __compaction_suitable(struct zone *zone, int order,
>>           * even if compaction succeeds.
>>           * For costly orders, we require low watermark instead of min for
>>           * compaction to proceed to increase its chances.
>> -        * ALLOC_CMA is used, as pages in CMA pageblocks are considered
>> -        * suitable migration targets
>> +        * In addition to long term GUP flow, ALLOC_CMA is used, as pages in
>> +        * CMA pageblocks are considered suitable migration targets
> 
> I'm not sure if this document is correct for cases other than GUP.

Yes, we should update the document for other cases where CMA cannot be 
used. That's why we use the passed 'alloc_flags' to determine if 
'ALLOC_CMA' is needed, instead of using 'current->flags & PF_MEMALLOC_PIN'.

