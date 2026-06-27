Return-Path: <stable+bounces-269341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f8j0M3hJP2q/RAkAu9opvQ
	(envelope-from <stable+bounces-269341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 05:54:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2867C6D10A7
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 05:54:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=KWgtvn2K;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269341-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269341-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA5A03026AAD
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 03:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17CD36BCED;
	Sat, 27 Jun 2026 03:54:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382A3750D6;
	Sat, 27 Jun 2026 03:54:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782532467; cv=none; b=azvonAeoaVDyfkOvBvxqQOBqJGOCFaZTB7LMvGTQau8V4x/NsPhmORSyfNVOJAm45lhKiUC5ej/tzQaGNofEjHzOuk8pSYvx876NlPD4ef6teppZNVM7oWLBGImRu70Sk7I+EB3Rn5kPhRj7qRwJMorNQruuxE9noVUaK5b81jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782532467; c=relaxed/simple;
	bh=V5rsK4UW6VUoGMr7tllgFW1qi7JIcYqkN0bk2UJkS3Q=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b50Lc396OX4esHtWZ9of2mmq/6//olJ2aQHJ72zp3/7qs1iz485eYHXjaxruu1trOnivhaM/Jbhh5/mkqfUPaMp+m70bp4JOr2LUEo1ScEi6F2ODFq1idFLpZVDEuNfI1bC208ftY7h7PvAVCOVdUCxn2WMTuBRxHGVhw6xuI9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KWgtvn2K; arc=none smtp.client-ip=113.46.200.218
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dMhnwwyr0X6eIrWWVrP1kSsfT0hNEAccTRRDjQENV44=;
	b=KWgtvn2K4B7BlitRHRQ4x/eeeMg3htlDB6rTLjt4qc/CTdVG8G/DiL+ehp3X7ZPg8q3RkSxaP
	QGVZMK0a7LXjTSQKPsmPY3WPxNVZw+Dqd0x639x3nvkJ7vqG2zmM+qbWaEtTHgdFfbHyR/JDqfS
	bbdX33wv7gMf4pyzdK3Z/B8=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gnJNd1mxCzpSvr;
	Sat, 27 Jun 2026 11:45:53 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 97E7E40577;
	Sat, 27 Jun 2026 11:54:13 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 27 Jun 2026 11:54:13 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 27 Jun 2026 11:54:10 +0800
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
To: Lance Yang <lance.yang@linux.dev>, Dev Jain <dev.jain@arm.com>
CC: <muchun.song@linux.dev>, <osalvador@suse.de>, <akpm@linux-foundation.org>,
	<ljs@kernel.org>, <david@kernel.org>, <liam@infradead.org>,
	<riel@surriel.com>, <vbabka@kernel.org>, <harry@kernel.org>,
	<jannh@google.com>, <kas@kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <rcampbell@nvidia.com>, <apopple@nvidia.com>,
	<ziy@nvidia.com>, <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>,
	<rakie.kim@sk.com>, <byungchul@sk.com>, <gourry@gourry.net>,
	<ying.huang@linux.alibaba.com>, <mel@csn.ul.ie>, <nao.horiguchi@gmail.com>,
	<ak@linux.intel.com>, <j-nomura@ce.jp.nec.com>, <pfalcato@suse.de>,
	<dave.hansen@intel.com>, <tglx@kernel.org>, <jpoimboe@kernel.org>,
	<ryan.roberts@arm.com>, <anshuman.khandual@arm.com>, <stable@vger.kernel.org>
References: <e6d1b813-0893-458e-9d58-8d3a9bd979c4@arm.com>
 <20260626141031.14309-1-lance.yang@linux.dev>
 <61e9fcf7-02a5-4285-948b-62fba4dcd69c@arm.com>
 <edee8461-34c6-41e9-ae0c-076380d92ebb@linux.dev>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cb5bd857-adb1-b59a-d257-412965886184@huawei.com>
Date: Sat, 27 Jun 2026 11:54:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <edee8461-34c6-41e9-ae0c-076380d92ebb@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269341-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lance.yang@linux.dev,m:dev.jain@arm.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[linmiaohe@huawei.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[linux.dev,suse.de,linux-foundation.org,kernel.org,infradead.org,surriel.com,google.com,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,arm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:dkim,huawei.com:mid,huawei.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmiaohe@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2867C6D10A7

On 2026/6/27 0:46, Lance Yang wrote:
> 
> 
> On 2026/6/26 23:26, Dev Jain wrote:
>>
>>
>> On 26/06/26 7:40 pm, Lance Yang wrote:
>>>
>>> On Fri, Jun 26, 2026 at 06:53:10PM +0530, Dev Jain wrote:
>>>>
>>>>
>>>> On 26/06/26 1:18 pm, Lance Yang wrote:
>>>>>
>>>>> On Thu, Jun 25, 2026 at 11:29:53AM +0000, Dev Jain wrote:
>>>>>> check_pte() is the final validation step in page_vma_mapped_walk().
>>>>>> It reads pvmw->pte with ptep_get() to decide whether the entry maps
>>>>>> the PFN range being walked. For hugetlb VMAs, that pointer refers
>>>>>> to a hugetlb entry.
>>>>>>
>>>>>> On arches which provide their own huge_ptep_get() to dereference a huge
>>>>>> pte pointer, accessing via ptep_get() would cause pte_pfn(),
>>>>>> pte_present() etc to misbehave.
>>>>>>
>>>>>> It is not clear whether this has a trivially visible effect to userspace.
>>>>>>
>>>>>> Use huge_ptep_get() to dereference a huge pte pointer.
>>>>>>
>>>>>> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>> ---
>>>>>> mm/page_vma_mapped.c | 8 +++++++-
>>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>>>> index 2ccbabfb2cc17..18e1d341f463c 100644
>>>>>> --- a/mm/page_vma_mapped.c
>>>>>> +++ b/mm/page_vma_mapped.c
>>>>>> @@ -107,7 +107,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>>>>>> static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>>>>>> {
>>>>>>     unsigned long pfn;
>>>>>> -    pte_t ptent = ptep_get(pvmw->pte);
>>>>>> +    pte_t ptent;
>>>>>> +
>>>>>> +    if (is_vm_hugetlb_page(pvmw->vma))
>>>>>> +        ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>>>>>> +                      pvmw->pte);
>>>>>
>>>>> I think check_pte() can pass a wrong address to huge_ptep_get() ...
>>>>
>>>> Won't this be handled by rmap_walk_anon/rmap_walk_file - they are the ones
>>>> performing the rmap traversal and passing address to try_to_unmap_one/folio_referenced_one
>>>> etc ...
>>>
>>> Right, that should cover the rmap callbacks. The bit I was worried about
>>> is page_mapped_in_vma() though.
>>>
>>>>>
>>>>> Not sure that is wrong in the first place. For memory failure,
>>>>> page_mapped_in_vma() can be called with a poisoned tail page of a hugetlb
>>>>> folio. In that case, pvmw->address need not be hugepage-aligned.
>>>>>
>>>>> @Miaohe
>>>
>>> For hugetlb memory failure we start with the poisoned PFN:
>>>
>>> static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
>>> {
>>>     ...
>>>     struct page *p = pfn_to_page(pfn);
>>>     struct folio *folio;
>>>     ...
>>>
>>>     folio = page_folio(p);
>>>
>>>     ...
>>>
>>>     if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
>>>         ...
>>>     }
>>>
>>>     ...
>>> }
>>>
>>> and pass the same p down:
>>>
>>> static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>>>         unsigned long pfn, int flags)
>>> {
>>>     ...
>>>
>>>     collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>>>
>>>     ...
>>> }
>>>
>>> static void collect_procs(const struct folio *folio, const struct page *page,
>>>         struct list_head *tokill, int force_early)
>>> {
>>>     ...
>>>
>>>     if (unlikely(folio_test_ksm(folio)))
>>>         ...
>>>     else if (folio_test_anon(folio))
>>>         collect_procs_anon(folio, page, tokill, force_early);
>>>     else
>>>         ...
>>> }
>>>
>>> So collect_procs_anon() still gets the poisoned page, not &folio->page:
>>>
>>> static void collect_procs_anon(const struct folio *folio,
>>>         const struct page *page, struct list_head *to_kill,
>>>         int force_early)
>>> {
>>>     ...
>>>
>>>     pgoff = page_pgoff(folio, page);
>>>     rcu_read_lock();
>>>     for_each_process(tsk) {
>>>         ...
>>>        
>>>         anon_vma_interval_tree_foreach(vmac, &av->rb_root,
>>>                            pgoff, pgoff) {
>>>             ...
>>>             addr = page_mapped_in_vma(page, vma);
>>>             ...
>>>         }
>>>     }
>>>     rcu_read_unlock();
>>>     anon_vma_unlock_read(av);
>>> }
>>>
>>> page_mapped_in_vma() then builds pvmw for that page:
>>>
>>> unsigned long page_mapped_in_vma(const struct page *page,
>>>         struct vm_area_struct *vma)
>>> {
>>>     const struct folio *folio = page_folio(page);
>>>     struct page_vma_mapped_walk pvmw = {
>>>         .pfn = page_to_pfn(page),
>>>         .nr_pages = 1,
>>>         .vma = vma,
>>>         .flags = PVMW_SYNC,
>>>     };
>>>
>>>     pvmw.address = vma_address(vma, page_pgoff(folio, page), 1);
>>>     ...
>>> }
>>>
>>> and page_pgoff() includes the subpage index:
>>>
>>> static inline pgoff_t page_pgoff(const struct folio *folio,
>>>         const struct page *page)
>>> {
>>>     return folio->index + folio_page_idx(folio, page);
>>> }
>>>
>>> So if the poisoned PFN points to a tail page, pvmw->address can be offset
>>> from the start of the hugetlb mapping by
>>>
>>> folio_page_idx(folio, page) << PAGE_SHIFT
>>>
>>> Should check_pte() pass the hugepage-aligned address to huge_ptep_get()
>>> for that case?
>>
>> Thanks! This looks correct.
>>

Thanks both.

>> I can indeed fix this up in check_pte. But in the memory-failure path
>> it has always been confusing to me for hugetlb folios why we are bothering

IIUC, the hugetlb tail page is used to calculate the specified hwpoisoned address
and send it to userspace through SIGBUS.

>> with the tail page. I am sure that area can also be simplified. But for
>> now I'll just do a simple fix here itself.
> 
> Just thinking out loud: given that huge_ptep_get() already assumes that
> addr matches the huge pte, at least on arm64, would it make sense to
> have a small hugetlb wrapper around it that takes hstate and aligns
> the address before calling the arch helper?

This proposal looks good to me given the assumption.

Thanks.
.

> 
> Might make the rule clearer, and a bit harder to get wrong again :)
> 
> Thanks, Lance
> 
>>
>>>
>>> Cheers, Lance
>>>
>>>>>
>>>>> For arm64, CONT_PMD_SIZE is one supported HugeTLB size. With such a VMA,
>>>>> page_vma_mapped_walk() passes that size to hugetlb_walk():
>>>>>
>>>>> bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>>> {
>>>>>     ...
>>>>>     if (unlikely(is_vm_hugetlb_page(vma))) {
>>>>>         ...
>>>>>         pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
>>>>>         ...
>>>>>     }
>>>>>     ...
>>>>> }
>>>>>
>>>>> hugetlb_walk() then calls arm64 huge_pte_offset(mm, addr, sz). For
>>>>> sz == CONT_PMD_SIZE, huge_pte_offset() aligns its local addr before
>>>>> calculating pmdp:
>>>>>
>>>>> pte_t *huge_pte_offset(struct mm_struct *mm,
>>>>>                unsigned long addr, unsigned long sz)
>>>>> {
>>>>>     ...
>>>>>     if (sz == CONT_PMD_SIZE)
>>>>>         addr &= CONT_PMD_MASK;
>>>>>
>>>>>     pmdp = pmd_offset(pudp, addr);
>>>>>     pmd = READ_ONCE(*pmdp);
>>>>>     ...
>>>>> }
>>>>>
>>>>> So for that case, pvmw->pte is calculated from the aligned addr, not
>>>>> necessarily from the original pvmw->address. But check_pte() passes the
>>>>> original address together with pvmw->pte:
>>>>>
>>>>> +        ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>>>>> +                      pvmw->pte);
>>>>>
>>>>> arm64 then uses that addr again to choose ncontig:
>>>>>
>>>>> pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>>>>> {
>>>>>     ...
>>>>>     ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>>>>>     for (i = 0; i < ncontig; i++, ptep++) {
>>>>>         ...
>>>>>     }
>>>>>     return orig_pte;
>>>>> }
>>>>>
>>>>> static int find_num_contig(struct mm_struct *mm, unsigned long addr,
>>>>>                pte_t *ptep, size_t *pgsize)
>>>>> {
>>>>>     pgd_t *pgdp = pgd_offset(mm, addr);
>>>>>     p4d_t *p4dp;
>>>>>     pud_t *pudp;
>>>>>     pmd_t *pmdp;
>>>>>
>>>>>     *pgsize = PAGE_SIZE;
>>>>>     p4dp = p4d_offset(pgdp, addr);
>>>>>     pudp = pud_offset(p4dp, addr);
>>>>>     pmdp = pmd_offset(pudp, addr);
>>>>>     if ((pte_t *)pmdp == ptep) {
>>>>>         *pgsize = PMD_SIZE;
>>>>>         return CONT_PMDS;
>>>>>     }
>>>>>     return CONT_PTES;
>>>>> }
>>>>>
>>>>> With a tail address, pmdp may no longer point at pvmw->pte, so
>>>>> find_num_contig() can return CONT_PTES for a CONT_PMD HugeTLB mapping.
>>>>>
>>>>> On 16K arm64, that changes ncontig from 32 to 128. So huge_ptep_get()
>>>>> can walk past the CONT_PMD entries, and possibly past the PMD table.
>>>>>
>>>>> Should check_pte() pass the address matching pvmw->pte, sth like:
>>>>>
>>>>> ---8<---
>>>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>>> index 406fd50bbd8f..58463493bd3d 100644
>>>>> --- a/mm/page_vma_mapped.c
>>>>> +++ b/mm/page_vma_mapped.c
>>>>> @@ -109,11 +109,14 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>>>>>       unsigned long pfn;
>>>>>       pte_t ptent;
>>>>>
>>>>> -    if (is_vm_hugetlb_page(pvmw->vma))
>>>>> -        ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>>>>> -                      pvmw->pte);
>>>>> -    else
>>>>> +    if (is_vm_hugetlb_page(pvmw->vma)) {
>>>>> +        struct hstate *hstate = hstate_vma(pvmw->vma);
>>>>> +        unsigned long haddr = pvmw->address & huge_page_mask(hstate);
>>>>> +
>>>>> +        ptent = huge_ptep_get(pvmw->vma->vm_mm, haddr, pvmw->pte);
>>>>> +    } else {
>>>>>           ptent = ptep_get(pvmw->pte);
>>>>> +    }
>>>>>
>>>>>       if (pvmw->flags & PVMW_MIGRATION) {
>>>>>           const softleaf_t entry = softleaf_from_pte(ptent);
>>>>> -- 
>>>>>
>>>>> while leaving pvmw->address unchanged for page_mapped_in_vma()?
>>>>>
>>>>> Cheers, Lance
>>>>>
>>>>>> +    else
>>>>>> +        ptent = ptep_get(pvmw->pte);
>>>>>>
>>>>>>     if (pvmw->flags & PVMW_MIGRATION) {
>>>>>>         const softleaf_t entry = softleaf_from_pte(ptent);
>>>>>> -- 
>>>>>> 2.43.0
>>>>>>
>>>>>>
>>>>
>>>>
>>>
>>
> 
> .


