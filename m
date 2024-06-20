Return-Path: <stable+bounces-54674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 483FF90FA55
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 02:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B5F1C21245
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 00:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE3184F;
	Thu, 20 Jun 2024 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DF6Ms+u1"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2A180B;
	Thu, 20 Jun 2024 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843662; cv=none; b=QVtRI2uEaG3gco5hgiv6CdqiZAcc+j9/VjCCF5TK3+IhpJQ/R8LhSBTQN8dUKe0wd6Dt9q/WA+QTrlhH78lo1QSBzYIH9CZabOrb+CNPjfl5kk41okgSCA95J3pLyz4OT32yFb8e4pb7yCrJRPVgFRufeN9CiAB2d2bgrZ70z/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843662; c=relaxed/simple;
	bh=HlBjycri2IB54ICDj0MHtYnImzwyKfkglbNi3WEeV0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTfMraE7COD/Gp+9jBeh9pIdMq1kt0YCo3ssNUQc+4Tq3iL+mg2Xrw5XdB628gIqTh4EAL15deukFirYBvZ1kEn/Fz+vsbWR+vjrie+phTDAxRL96WYjbSofF6ST8uSHZcnz9lTxKLBzMzUOLGZpjpY4yn2lFt8B8v/cF2Fveog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DF6Ms+u1; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=lsWT13bw0ulPMvpLu3IHN5kqyxObWTgClFkYDlqQVus=;
	b=DF6Ms+u1R+MPFLZ90t9it8EowIi0z2ALVuu/u/rHryd/q1DTWii6R+hP1Ik5iB
	cpeEBF+rNFVx20ZdzhE8TSm+53APlcYB/1Pgz8Dde+vTcH1ohJUkiJPbaZxB0vy5
	YdX+vK9uazna7TKqPFjhqct5ktkonMBGL+/WLXRAfYJtc=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDnz53weHNma2K2AA--.48280S2;
	Thu, 20 Jun 2024 08:33:54 +0800 (CST)
Message-ID: <f16baed7-ede8-4f38-8f24-bd9037e0ae4f@126.com>
Date: Thu, 20 Jun 2024 08:33:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: add one PCP list for THP
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
 liuzixing@hygon.cn
References: <1718801672-30152-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4xDY8TrjGOX_xSpM0+wj=CxXy-0R6Wo=Vn3dHOBNtYHng@mail.gmail.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <CAGsJ_4xDY8TrjGOX_xSpM0+wj=CxXy-0R6Wo=Vn3dHOBNtYHng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz53weHNma2K2AA--.48280S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWrWF15Gr4rWFW3KF1kuFg_yoW7JF1xpF
	WxJF4Yyayjq34UAw1xJ3Z0krna93yfKF1DGr1I9ry8ZrsxWFyS9a48KFnF9Fy8ArW7CF4x
	XryDt3Z3uF4qv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9TmDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGBQEG2VLb4BrvgAAsH



在 2024/6/20 6:28, Barry Song 写道:
> On Thu, Jun 20, 2024 at 12:55 AM <yangge1116@126.com> wrote:
>>
>> From: yangge <yangge1116@126.com>
>>
>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>> THP-sized allocations") no longer differentiates the migration type
>> of pages in THP-sized PCP list, it's possible that non-movable
>> allocation requests may get a CMA page from the list, in some cases,
>> it's not acceptable.
>>
>> If a large number of CMA memory are configured in system (for
>> example, the CMA memory accounts for 50% of the system memory),
>> starting a virtual machine with device passthrough will get stuck.
>> During starting the virtual machine, it will call
>> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory. Normally
>> if a page is present and in CMA area, pin_user_pages_remote() will
>> migrate the page from CMA area to non-CMA area because of
>> FOLL_LONGTERM flag. But if non-movable allocation requests return
>> CMA memory, migrate_longterm_unpinnable_pages() will migrate a CMA
>> page to another CMA page, which will fail to pass the check in
>> check_and_migrate_movable_pages() and cause migration endless.
>> Call trace:
>> pin_user_pages_remote
>> --__gup_longterm_locked // endless loops in this function
>> ----_get_user_pages_locked
>> ----check_and_migrate_movable_pages
>> ------migrate_longterm_unpinnable_pages
>> --------alloc_migration_target
>>
>> This problem will also have a negative impact on CMA itself. For
>> example, when CMA is borrowed by THP, and we need to reclaim it
>> through cma_alloc() or dma_alloc_coherent(), we must move those
>> pages out to ensure CMA's users can retrieve that contigous memory.
>> Currently, CMA's memory is occupied by non-movable pages, meaning
>> we can't relocate them. As a result, cma_alloc() is more likely to
>> fail.
>>
>> To fix the problem above, we add one PCP list for THP, which will
>> not introduce a new cacheline for struct per_cpu_pages. THP will
>> have 2 PCP lists, one PCP list is used by MOVABLE allocation, and
>> the other PCP list is used by UNMOVABLE allocation. MOVABLE
>> allocation contains GPF_MOVABLE, and UNMOVABLE allocation contains
>> GFP_UNMOVABLE and GFP_RECLAIMABLE.
>>
>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized allocations")
> 
> Please add the below tag
> 
> Cc: <stable@vger.kernel.org>
> 
> And I don't think 'mm/page_alloc: add one PCP list for THP' is a good
> title. Maybe:
> 
> 'mm/page_alloc: Separate THP PCP into movable and non-movable categories'
> 
> Whenever you send a new version, please add things like 'PATCH V2', 'PATCH V3'.
> You have already missed several version numbers, so we may have to start from V2
> though V2 is wrong.
> 

Ok, thanks.

>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   include/linux/mmzone.h | 9 ++++-----
>>   mm/page_alloc.c        | 9 +++++++--
>>   2 files changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index b7546dd..cb7f265 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -656,13 +656,12 @@ enum zone_watermarks {
>>   };
>>
>>   /*
>> - * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional list
>> - * for THP which will usually be GFP_MOVABLE. Even if it is another type,
>> - * it should not contribute to serious fragmentation causing THP allocation
>> - * failures.
>> + * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. Two additional lists
>> + * are added for THP. One PCP list is used by GPF_MOVABLE, and the other PCP list
>> + * is used by GFP_UNMOVABLE and GFP_RECLAIMABLE.
>>    */
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -#define NR_PCP_THP 1
>> +#define NR_PCP_THP 2
>>   #else
>>   #define NR_PCP_THP 0
>>   #endif
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 8f416a0..0a837e6 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -504,10 +504,15 @@ static void bad_page(struct page *page, const char *reason)
>>
>>   static inline unsigned int order_to_pindex(int migratetype, int order)
>>   {
>> +       bool __maybe_unused movable;
>> +
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>          if (order > PAGE_ALLOC_COSTLY_ORDER) {
>>                  VM_BUG_ON(order != HPAGE_PMD_ORDER);
>> -               return NR_LOWORDER_PCP_LISTS;
>> +
>> +               movable = migratetype == MIGRATE_MOVABLE;
>> +
>> +               return NR_LOWORDER_PCP_LISTS + movable;
>>          }
>>   #else
>>          VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>> @@ -521,7 +526,7 @@ static inline int pindex_to_order(unsigned int pindex)
>>          int order = pindex / MIGRATE_PCPTYPES;
>>
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -       if (pindex == NR_LOWORDER_PCP_LISTS)
>> +       if (pindex >= NR_LOWORDER_PCP_LISTS)
>>                  order = HPAGE_PMD_ORDER;
>>   #else
>>          VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>> --
>> 2.7.4
>>


