Return-Path: <stable+bounces-61811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B993CCD2
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 05:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29FE2831C2
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 03:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40541CAB9;
	Fri, 26 Jul 2024 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ilsfmeQA"
X-Original-To: stable@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487680B;
	Fri, 26 Jul 2024 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721962996; cv=none; b=djv8bKxzXIaoKX6+tcwBwr6ztARrkRAOL9PcvwzS8tKTlkFrgUN3AEbiSBxNmac91SbWDZZRLe7TuxgxuBN1xer6aX/WcBBrKxzW+TWoI23e8lRuF0gRciw8Gpmq6xiMVLqwcHIRXhe+W/G0IE2q1/jLOFabZHqx7ALMSCWG1XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721962996; c=relaxed/simple;
	bh=hYOYfZoUkCIvJxsOI3jO84CIaJT5Wy15y1NkflfxNMw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZpQwwk1BahiTHtOpMYrrdmAjoqxFypZ4ULN+D/+wsBMfGRtqdIjHd75hG23DKxLHD3mFfATDfbJlqLzHnXTTT05H7g1VJZfBukeuL3cz+5Q9zu0OSia6T3YY9WJ3yuAqGNTsEmDT0PAq9fMZUkaWsz5Ik6kNOzJuZ4LG4vu4NSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ilsfmeQA; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721962991; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=DEeU61Mv+VNz/k6t7DEYpHVLFckAb60VA3KKLUZPnoE=;
	b=ilsfmeQAQkn95+2ROcE+51MI+yW8dMx+Axt8ha9qUhlzT60JzASDOpQf2ztjEuodhSkQxt7gqDuR01dZQo9nzF5kvxnGj6BiOQMRRoHlmPfXQkFoX58dIGkkBBFj1gn6bY3i7KzxBkSSFpYNTe7phMzCaQ+4I/i9iURY9jZuC7E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0WBK7fww_1721962989;
Received: from 30.97.56.64(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBK7fww_1721962989)
          by smtp.aliyun-inc.com;
          Fri, 26 Jul 2024 11:03:10 +0800
Message-ID: <707d8937-d4c8-43b3-bc19-70f0038522a9@linux.alibaba.com>
Date: Fri, 26 Jul 2024 11:03:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-3-david@redhat.com>
 <0067dfe6-b9a6-4e98-9eef-7219299bfe58@linux.alibaba.com>
In-Reply-To: <0067dfe6-b9a6-4e98-9eef-7219299bfe58@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/26 10:33, Baolin Wang wrote:
> 
> 
> On 2024/7/26 02:39, David Hildenbrand wrote:
>> We recently made GUP's common page table walking code to also walk
>> hugetlb VMAs without most hugetlb special-casing, preparing for the
>> future of having less hugetlb-specific page table walking code in the
>> codebase. Turns out that we missed one page table locking detail: page
>> table locking for hugetlb folios that are not mapped using a single
>> PMD/PUD.
>>
>> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
>> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
>> page tables, will perform a pte_offset_map_lock() to grab the PTE table
>> lock.
>>
>> However, hugetlb that concurrently modifies these page tables would
>> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
>> locks would differ. Something similar can happen right now with hugetlb
>> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
>>
>> Let's make huge_pte_lockptr() effectively uses the same PT locks as any
>> core-mm page table walker would.
> 
> Thanks for raising the issue again. I remember fixing this issue 2 years 
> ago in commit fac35ba763ed ("mm/hugetlb: fix races when looking up a 
> CONT-PTE/PMD size hugetlb page"), but it seems to be broken again.
> 
>> There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
>> folio being mapped using two PTE page tables. While hugetlb wants to take
>> the PMD table lock, core-mm would grab the PTE table lock of one of both
>> PTE page tables. In such corner cases, we have to make sure that both
>> locks match, which is (fortunately!) currently guaranteed for 8xx as it
>> does not support SMP.
>>
>> Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic 
>> follow_page_mask code")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/hugetlb.h | 25 ++++++++++++++++++++++---
>>   1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index c9bf68c239a01..da800e56fe590 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -944,10 +944,29 @@ static inline bool htlb_allow_alloc_fallback(int 
>> reason)
>>   static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>>                          struct mm_struct *mm, pte_t *pte)
>>   {
>> -    if (huge_page_size(h) == PMD_SIZE)
>> +    VM_WARN_ON(huge_page_size(h) == PAGE_SIZE);
>> +    VM_WARN_ON(huge_page_size(h) >= P4D_SIZE);
>> +
>> +    /*
>> +     * hugetlb must use the exact same PT locks as core-mm page table
>> +     * walkers would. When modifying a PTE table, hugetlb must take the
>> +     * PTE PT lock, when modifying a PMD table, hugetlb must take the 
>> PMD
>> +     * PT lock etc.
>> +     *
>> +     * The expectation is that any hugetlb folio smaller than a PMD is
>> +     * always mapped into a single PTE table and that any hugetlb folio
>> +     * smaller than a PUD (but at least as big as a PMD) is always 
>> mapped
>> +     * into a single PMD table.
> 
> ARM64 also supports cont-PMD size hugetlb, which is 32MiB size with a 4 
> KiB base page size. This means the PT locks for 32MiB hugetlb may race 
> again, as we currently only hold one PMD lock for several PMD entries of 
> a cont-PMD size hugetlb.
> 
>> +     *
>> +     * If that does not hold for an architecture, then that architecture
>> +     * must disable split PT locks such that all *_lockptr() functions
>> +     * will give us the same result: the per-MM PT lock.
>> +     */
>> +    if (huge_page_size(h) < PMD_SIZE)
>> +        return pte_lockptr(mm, pte);
>> +    else if (huge_page_size(h) < PUD_SIZE)
>>           return pmd_lockptr(mm, (pmd_t *) pte);
> 
> IIUC, as I said above, this change doesn't fix the inconsistent lock for 
> cont-PMD size hugetlb for GUP, and it will also break the lock rule for 
> unmapping/migrating a cont-PMD size hugetlb (use mm->page_table_lock 
> before for cont-PMD size hugetlb before).

After more thinking, I realized I confused the PMD table with the PMD 
entry. Therefore, using the PMD table's lock is safe for cont-PMD size 
hugetlb. This change looks good to me. Sorry for noise.

Please feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> 
>> -    VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
>> -    return &mm->page_table_lock;
>> +    return pud_lockptr(mm, (pud_t *) pte);
>>   }
>>   #ifndef hugepages_supported

