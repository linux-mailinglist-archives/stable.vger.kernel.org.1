Return-Path: <stable+bounces-105552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6029FA4A2
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 09:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98CE16677E
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094501632D7;
	Sun, 22 Dec 2024 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="WabXblh+"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA865EAF6;
	Sun, 22 Dec 2024 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734855277; cv=none; b=uAeDUhWQIvkxMkuuiuiSb3p8yyNoe4ZUL2IazE7RPFCq7lOSZ4EWkzPnzUut2hbiplhxGuaRaLK0AtsCmIbOOG91+AA4qXXq5CvwcH5fMUGOljBWoK8jWkvPD+bQaMW+CBQ90EPc+/v6f/VHR6qk/uuAdB5WtEBEvoZfwzWuTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734855277; c=relaxed/simple;
	bh=RU0grsk1NlJOrri0TnPVdDWVkgjWLJBP5YdGgV4zIJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sifaCzsYQACFfMe8BtWGkqN0XXxopvqRYlZf3odoF8tWHCiyMttH4Sb+vPw3VCN/liP2OguLjAIcKfE3eRhafoOFsmvAW77S0aDwUGqmmYDvM6YVlw+9B0/y6vUQwrA+cHoiffnSaEXlKRt8sbb1nQJtmyoNoobjsNVYLxozg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=WabXblh+; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=MEj+1+5yRDWIb0ATQhyGvjl5S2ZyCLRVuyNGEQnBk68=;
	b=WabXblh+7T8z+YPvm0ufFQLa67aDzukKmFkbD2dwi+V3MilPgeYNVI01MCjm5x
	3bwMM0N8mMY8zWz7H0kILnJuywcXA99d9dXaGPmHKn0dXbwak2xoznva+rCSA5bY
	dAN2d2m9SZi2kXPWMFs7lO9RmWq2b+fhdIWhiYMGvUK5U=
Received: from [172.20.10.3] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD314M+ymdnnSbTAA--.60994S2;
	Sun, 22 Dec 2024 16:13:51 +0800 (CST)
Message-ID: <d6d92a36-4ed7-4ae8-8b74-48f79a502a36@126.com>
Date: Sun, 22 Dec 2024 16:13:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replace free hugepage folios after migration
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 liuzixing@hygon.cn
References: <1734503588-16254-1-git-send-email-yangge1116@126.com>
 <0ca35fe5-9799-4518-9fb1-701c88501a8d@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <0ca35fe5-9799-4518-9fb1-701c88501a8d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD314M+ymdnnSbTAA--.60994S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrWkXrWDtFy3XFWUAryrJFb_yoW7uw15pF
	y8Gr15GrWDJr9rGr1Iqan8Ar1Sy3ykXFWjkFWftrW3ZFnxtr929Fn0ywn093y8Cr97CF4I
	vFWjqr4kuF1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKzuZUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWRO9G2dnuXaZzgAAs0



在 2024/12/21 22:35, David Hildenbrand 写道:
> On 18.12.24 07:33, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
>>
>> My machine has 4 NUMA nodes, each equipped with 32GB of memory. I
>> have configured each NUMA node with 16GB of CMA and 16GB of in-use
>> hugetlb pages. The allocation of contiguous memory via the
>> cma_alloc() function can fail probabilistically.
>>
>> The cma_alloc() function may fail if it sees an in-use hugetlb page
>> within the allocation range, even if that page has already been
>> migrated. When in-use hugetlb pages are migrated, they may simply
>> be released back into the free hugepage pool instead of being
>> returned to the buddy system. This can cause the
>> test_pages_isolated() function check to fail, ultimately leading
>> to the failure of the cma_alloc() function:
>> cma_alloc()
>>      __alloc_contig_migrate_range() // migrate in-use hugepage
>>      test_pages_isolated()
>>          __test_page_isolated_in_pageblock()
>>               PageBuddy(page) // check if the page is in buddy
>>
>> To address this issue, we will add a function named
>> replace_free_hugepage_folios(). This function will replace the
>> hugepage in the free hugepage pool with a new one and release the
>> old one to the buddy system. After the migration of in-use hugetlb
>> pages is completed, we will invoke the replace_free_hugepage_folios()
>> function to ensure that these hugepages are properly released to
>> the buddy system. Following this step, when the test_pages_isolated()
>> function is executed for inspection, it will successfully pass.
>>
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   include/linux/hugetlb.h |  6 ++++++
>>   mm/hugetlb.c            | 37 +++++++++++++++++++++++++++++++++++++
>>   mm/page_alloc.c         | 13 ++++++++++++-
>>   3 files changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index ae4fe86..7d36ac8 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -681,6 +681,7 @@ struct huge_bootmem_page {
>>   };
>>   int isolate_or_dissolve_huge_page(struct page *page, struct 
>> list_head *list);
>> +int replace_free_hugepage_folios(unsigned long start_pfn, unsigned 
>> long end_pfn);
>>   struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>                   unsigned long addr, int avoid_reserve);
>>   struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int 
>> preferred_nid,
>> @@ -1059,6 +1060,11 @@ static inline int 
>> isolate_or_dissolve_huge_page(struct page *page,
>>       return -ENOMEM;
>>   }
>> +int replace_free_hugepage_folios(unsigned long start_pfn, unsigned 
>> long end_pfn)
>> +{
>> +    return 0;
>> +}
>> +
>>   static inline struct folio *alloc_hugetlb_folio(struct 
>> vm_area_struct *vma,
>>                          unsigned long addr,
>>                          int avoid_reserve)
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 8e1db80..a099c54 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2975,6 +2975,43 @@ int isolate_or_dissolve_huge_page(struct page 
>> *page, struct list_head *list)
>>       return ret;
>>   }
>> +/*
>> + *  replace_free_hugepage_folios - Replace free hugepage folios in a 
>> given pfn
>> + *  range with new folios.
>> + *  @stat_pfn: start pfn of the given pfn range
>> + *  @end_pfn: end pfn of the given pfn range
>> + *  Returns 0 on success, otherwise negated error.
>> + */
>> +int replace_free_hugepage_folios(unsigned long start_pfn, unsigned 
>> long end_pfn)
>> +{
>> +    struct hstate *h;
>> +    struct folio *folio;
>> +    int ret = 0;
>> +
>> +    LIST_HEAD(isolate_list);
>> +
>> +    while (start_pfn < end_pfn) {
>> +        folio = pfn_folio(start_pfn);
>> +        if (folio_test_hugetlb(folio)) {
>> +            h = folio_hstate(folio);
>> +        } else {
>> +            start_pfn++;
>> +            continue;
>> +        }
>> +
>> +        if (!folio_ref_count(folio)) {
>> +            ret = alloc_and_dissolve_hugetlb_folio(h, folio, 
>> &isolate_list);
>> +            if (ret)
>> +                break;
>> +
>> +            putback_movable_pages(&isolate_list);
>> +        }
>> +        start_pfn++;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>                       unsigned long addr, int avoid_reserve)
>>   {
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index dde19db..1dcea28 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6504,7 +6504,18 @@ int alloc_contig_range_noprof(unsigned long 
>> start, unsigned long end,
>>       ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
>>       if (ret && ret != -EBUSY)
>>           goto done;
>> -    ret = 0;
>> +
>> +    /*
>> +     * When in-use hugetlb pages are migrated, they may simply be
>> +     * released back into the free hugepage pool instead of being
>> +     * returned to the buddy system. After the migration of in-use
>> +     * huge pages is completed, we will invoke the
>> +     * replace_free_hugepage_folios() function to ensure that
>> +     * these hugepages are properly released to the buddy system.
>> +     */
> 
> As mentioned in my other mail, what I don't like about this is, IIUC, 
> the pages can get reallocated anytime after we successfully migrated 
> them, or is there  anything that prevents that?
> 
The pages can get reallocated anytime after we successfully migrated 
them. Currently, I haven't thought of a good way to prevent it.

> Did you ever try allocating a larger range with a single 
> alloc_contig_range() call, that possibly has to migrate multiple hugetlb 
> folios in one go (and maybe just allocates one of the just-freed hugetlb 
> folios as migration target)?
> 

I have tried using a single alloc_contig_range() call to allocate a 
larger contiguous range, and it works properly. This is because during 
the period between __alloc_contig_migrate_range() and 
isolate_freepages_range(), no one allocates a hugetlb folio from the 
free hugetlb pool.
> 


