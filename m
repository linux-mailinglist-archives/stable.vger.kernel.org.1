Return-Path: <stable+bounces-105401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E1E9F8E6B
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 09:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ACE1896AB1
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 08:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C81AA1C0;
	Fri, 20 Dec 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RAqHHnzS"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4548C1A0BFA;
	Fri, 20 Dec 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685091; cv=none; b=MwCIWlcB5ml+TJfpcww/WG7NgSfTH2/34KgcF/M/g9cfqk/4GLNcc/E2E8CXQ0o/8HEH6UfPwVLGdEQBps8/oFaX8D3Y2H85ImEjg/xgPoorf4kTnFR/ubLJ5AcMZ27fSXHi95ekDvBpQydhP3aF7Sup3Wbl+OINZ+07MDrAZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685091; c=relaxed/simple;
	bh=DB1ziz8HSL3/2AX5CPlpA6yQWCo3fLlM8HkWIIIijgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T51avp2E4i9a0v+GNOOdh7vsW9AsoUKTRSYjf7CuBzsdyzYxcUUv0pkyHu2WnKMEaw6A6ZnahgU4h78yN2E0Au21UsZ5/r4bcRoDYiUPO+Ste4ymD3/IKjx5pl8jkjxagXU7mjLeLoqbM3ESRJaOgr+wQlRFfCE/ma+2nwBblxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=RAqHHnzS; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=bAGuREr7HeDMX+iJP6gjezFu9fw3q6kjQHi3rKN4Et8=;
	b=RAqHHnzSeKNsQszCDqHl0IpSRHlWgwNQRTsIePebKh0lEtbuDo/HAcjoOmL29J
	CzDwQuXKnZgCJQwHthr/CLKJ9JfCl6QnAZjvm4l0mzWTxMy9nGOK3f3Wxivry14A
	EsRLMDJOuFZZx/U8m9dOlE2vaUhsISGbBN6W7N25igAuA=
Received: from [172.20.10.3] (unknown [39.144.39.55])
	by gzsmtp3 (Coremail) with SMTP id pykvCgBHrlFDMWVn+T0BCw--.29692S2;
	Fri, 20 Dec 2024 16:56:36 +0800 (CST)
Message-ID: <1241b567-88b6-462c-9088-8f72a45788b7@126.com>
Date: Fri, 20 Dec 2024 16:56:34 +0800
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
 liuzixing@hygon.cn, Oscar Salvador <osalvador@suse.de>
References: <1734503588-16254-1-git-send-email-yangge1116@126.com>
 <0b41cc6b-5c93-408f-801f-edd9793cb979@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <0b41cc6b-5c93-408f-801f-edd9793cb979@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:pykvCgBHrlFDMWVn+T0BCw--.29692S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrWkKw1UAF1xAw48Ww4kZwb_yoWxXrWfpF
	y8Gr15KrWDJr9rGr12qan8Cr1SvrWkXFWjyFWfJ343ZFnxtr929F1Dtwn093yrAr97CF4I
	vFW2qFWkuF1UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKFAJUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifgu7G2dlLw8k+wAAso



在 2024/12/20 0:40, David Hildenbrand 写道:
> On 18.12.24 07:33, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
> 
> CCing Oscar, who worked on migrating these pages during memory offlining 
> and alloc_contig_range().
> 
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
> 
> I thought this would be working as expected, at least we tested it with 
> alloc_contig_range / virtio-mem a while ago.
> 
> On the memory_offlining path, we migrate hugetlb folios, but also 
> dissolve any remaining free folios even if it means that we will going 
> below the requested number of hugetlb pages in our pool.
> 
> During alloc_contig_range(), we only migrate them, to then free them up 
> after migration.
> 
> Under which circumstances doe sit apply that "they may simply be 
> released back into the free hugepage pool instead of being returned to 
> the buddy system"?
> 

After migration, in-use hugetlb pages are only released back to the 
hugetlb pool and are not returned to the buddy system.

The specific steps for reproduction are as follows:
1，Reserve hugetlb pages. Some of these hugetlb pages are allocated 
within the CMA area.
echo 10240 > /proc/sys/vm/nr_hugepages

2，To ensure that hugetlb pages are in an in-use state, we can use the 
following command.
qemu-system-x86_64 \
   -mem-prealloc \
   -mem-path /dev/hugepage/ \
   ...

3，At this point, using cma_alloc() to allocate contiguous memory may 
result in a probable failure.

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
>> +    ret = replace_free_hugepage_folios(start, end);
>> +    if (ret)
>> +        goto done;
>>       /*
>>        * Pages from [start, end) are within a pageblock_nr_pages
> 
> 


