Return-Path: <stable+bounces-268932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RRwyD22IPmpjHgkAu9opvQ
	(envelope-from <stable+bounces-268932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:10:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B606CDCB5
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:10:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=PklWBCLq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268932-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268932-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D5D4300119D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721723F7873;
	Fri, 26 Jun 2026 14:10:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA443F4DC0
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 14:10:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483048; cv=none; b=MDmgoNBpO9aXACf/pKpzX6tSwKlK0PTgd06y088hQn2acs9FVhQX1MN/YUm6POtfaRlPi6xeQpoYycnf91qCeMqGx9wcFCl1A6oLm3cp+oZOOae8/3DqJYrwZvqP7ebwiCxM80WGjSyT03n3RBnNces6JoeHmeDwsuQMPsbfc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483048; c=relaxed/simple;
	bh=GyXWHcCRlzUinSJe2fCCgkAYaaMz198jlTTl/2UmppY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEbnIreBJEP7MOl3cvSubBF3uPkiFEf6TMd9hbtV6AGPqygf/ZvcUOM2JXRed4BBNLCDA9mAZw6Yrpna3kNeog889IVDZmAmg4TJtxnXwCGsFoHjORzjEh2p41XCZzGD5p7Jdb0miTedY/rrdoKERgyR6pFbhT2bIzUTegr5VHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PklWBCLq; arc=none smtp.client-ip=91.218.175.179
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782483042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPOvTRgVK+OIeqo9yXz4qFWfg6EvbVp+C25CpobS7as=;
	b=PklWBCLqKduGqfOIu/7FEk7C07iknzzmZm1gu0Dxd1LPlF7OU1TLHLxhAWkSu3UlPLTpIb
	qKKoAAyrIeNwyTksbKqjlRA5VQXCLJEWu6gTDkDGmzkTq3TI3MZ6t32dzWMu336YnKeSt6
	ANKvT8ikOqH1D1HQwM/dvVZ3+zkP43A=
From: Lance Yang <lance.yang@linux.dev>
To: dev.jain@arm.com,
	linmiaohe@huawei.com
Cc: lance.yang@linux.dev,
	muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	david@kernel.org,
	liam@infradead.org,
	riel@surriel.com,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcampbell@nvidia.com,
	apopple@nvidia.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	mel@csn.ul.ie,
	nao.horiguchi@gmail.com,
	ak@linux.intel.com,
	j-nomura@ce.jp.nec.com,
	pfalcato@suse.de,
	dave.hansen@intel.com,
	tglx@kernel.org,
	jpoimboe@kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
Date: Fri, 26 Jun 2026 22:10:31 +0800
Message-Id: <20260626141031.14309-1-lance.yang@linux.dev>
In-Reply-To: <e6d1b813-0893-458e-9d58-8d3a9bd979c4@arm.com>
References: <e6d1b813-0893-458e-9d58-8d3a9bd979c4@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268932-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,suse.de,linux-foundation.org,kernel.org,infradead.org,surriel.com,google.com,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,arm.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dev.jain@arm.com,m:linmiaohe@huawei.com,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31B606CDCB5


On Fri, Jun 26, 2026 at 06:53:10PM +0530, Dev Jain wrote:
>
>
>On 26/06/26 1:18 pm, Lance Yang wrote:
>> 
>> On Thu, Jun 25, 2026 at 11:29:53AM +0000, Dev Jain wrote:
>>> check_pte() is the final validation step in page_vma_mapped_walk().
>>> It reads pvmw->pte with ptep_get() to decide whether the entry maps
>>> the PFN range being walked. For hugetlb VMAs, that pointer refers
>>> to a hugetlb entry.
>>>
>>> On arches which provide their own huge_ptep_get() to dereference a huge
>>> pte pointer, accessing via ptep_get() would cause pte_pfn(),
>>> pte_present() etc to misbehave.
>>>
>>> It is not clear whether this has a trivially visible effect to userspace.
>>>
>>> Use huge_ptep_get() to dereference a huge pte pointer.
>>>
>>> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>> mm/page_vma_mapped.c | 8 +++++++-
>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>> index 2ccbabfb2cc17..18e1d341f463c 100644
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -107,7 +107,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>>> static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>>> {
>>> 	unsigned long pfn;
>>> -	pte_t ptent = ptep_get(pvmw->pte);
>>> +	pte_t ptent;
>>> +
>>> +	if (is_vm_hugetlb_page(pvmw->vma))
>>> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>>> +				      pvmw->pte);
>> 
>> I think check_pte() can pass a wrong address to huge_ptep_get() ...
>
>Won't this be handled by rmap_walk_anon/rmap_walk_file - they are the ones
>performing the rmap traversal and passing address to try_to_unmap_one/folio_referenced_one
>etc ...

Right, that should cover the rmap callbacks. The bit I was worried about
is page_mapped_in_vma() though.

>> 
>> Not sure that is wrong in the first place. For memory failure,
>> page_mapped_in_vma() can be called with a poisoned tail page of a hugetlb
>> folio. In that case, pvmw->address need not be hugepage-aligned.
>> 
>> @Miaohe

For hugetlb memory failure we start with the poisoned PFN:

static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
{
	...
	struct page *p = pfn_to_page(pfn);
	struct folio *folio;
	...

	folio = page_folio(p);

	...

	if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
		...
	}

	...
}

and pass the same p down:

static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
		unsigned long pfn, int flags)
{
	...

	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);

	...
}

static void collect_procs(const struct folio *folio, const struct page *page,
		struct list_head *tokill, int force_early)
{
	...

	if (unlikely(folio_test_ksm(folio)))
		...
	else if (folio_test_anon(folio))
		collect_procs_anon(folio, page, tokill, force_early);
	else
		...
}

So collect_procs_anon() still gets the poisoned page, not &folio->page:

static void collect_procs_anon(const struct folio *folio,
		const struct page *page, struct list_head *to_kill,
		int force_early)
{
	...

	pgoff = page_pgoff(folio, page);
	rcu_read_lock();
	for_each_process(tsk) {
		...
		
		anon_vma_interval_tree_foreach(vmac, &av->rb_root,
					       pgoff, pgoff) {
			...
			addr = page_mapped_in_vma(page, vma);
			...
		}
	}
	rcu_read_unlock();
	anon_vma_unlock_read(av);
}

page_mapped_in_vma() then builds pvmw for that page:

unsigned long page_mapped_in_vma(const struct page *page,
		struct vm_area_struct *vma)
{
	const struct folio *folio = page_folio(page);
	struct page_vma_mapped_walk pvmw = {
		.pfn = page_to_pfn(page),
		.nr_pages = 1,
		.vma = vma,
		.flags = PVMW_SYNC,
	};

	pvmw.address = vma_address(vma, page_pgoff(folio, page), 1);
	...
}

and page_pgoff() includes the subpage index:

static inline pgoff_t page_pgoff(const struct folio *folio,
		const struct page *page)
{
	return folio->index + folio_page_idx(folio, page);
}

So if the poisoned PFN points to a tail page, pvmw->address can be offset
from the start of the hugetlb mapping by

folio_page_idx(folio, page) << PAGE_SHIFT

Should check_pte() pass the hugepage-aligned address to huge_ptep_get()
for that case?

Cheers, Lance

>> 
>> For arm64, CONT_PMD_SIZE is one supported HugeTLB size. With such a VMA,
>> page_vma_mapped_walk() passes that size to hugetlb_walk():
>> 
>> bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> {
>> 	...
>> 	if (unlikely(is_vm_hugetlb_page(vma))) {
>> 		...
>> 		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
>> 		...
>> 	}
>> 	...
>> }
>> 
>> hugetlb_walk() then calls arm64 huge_pte_offset(mm, addr, sz). For
>> sz == CONT_PMD_SIZE, huge_pte_offset() aligns its local addr before
>> calculating pmdp:
>> 
>> pte_t *huge_pte_offset(struct mm_struct *mm,
>> 		       unsigned long addr, unsigned long sz)
>> {
>> 	...
>> 	if (sz == CONT_PMD_SIZE)
>> 		addr &= CONT_PMD_MASK;
>> 
>> 	pmdp = pmd_offset(pudp, addr);
>> 	pmd = READ_ONCE(*pmdp);
>> 	...
>> }
>> 
>> So for that case, pvmw->pte is calculated from the aligned addr, not
>> necessarily from the original pvmw->address. But check_pte() passes the
>> original address together with pvmw->pte:
>> 
>> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>> +				      pvmw->pte);
>> 
>> arm64 then uses that addr again to choose ncontig:
>> 
>> pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>> {
>> 	...
>> 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>> 	for (i = 0; i < ncontig; i++, ptep++) {
>> 		...
>> 	}
>> 	return orig_pte;
>> }
>> 
>> static int find_num_contig(struct mm_struct *mm, unsigned long addr,
>> 			   pte_t *ptep, size_t *pgsize)
>> {
>> 	pgd_t *pgdp = pgd_offset(mm, addr);
>> 	p4d_t *p4dp;
>> 	pud_t *pudp;
>> 	pmd_t *pmdp;
>> 
>> 	*pgsize = PAGE_SIZE;
>> 	p4dp = p4d_offset(pgdp, addr);
>> 	pudp = pud_offset(p4dp, addr);
>> 	pmdp = pmd_offset(pudp, addr);
>> 	if ((pte_t *)pmdp == ptep) {
>> 		*pgsize = PMD_SIZE;
>> 		return CONT_PMDS;
>> 	}
>> 	return CONT_PTES;
>> }
>> 
>> With a tail address, pmdp may no longer point at pvmw->pte, so
>> find_num_contig() can return CONT_PTES for a CONT_PMD HugeTLB mapping.
>> 
>> On 16K arm64, that changes ncontig from 32 to 128. So huge_ptep_get()
>> can walk past the CONT_PMD entries, and possibly past the PMD table.
>> 
>> Should check_pte() pass the address matching pvmw->pte, sth like:
>> 
>> ---8<---
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 406fd50bbd8f..58463493bd3d 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -109,11 +109,14 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>>  	unsigned long pfn;
>>  	pte_t ptent;
>> 
>> -	if (is_vm_hugetlb_page(pvmw->vma))
>> -		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>> -				      pvmw->pte);
>> -	else
>> +	if (is_vm_hugetlb_page(pvmw->vma)) {
>> +		struct hstate *hstate = hstate_vma(pvmw->vma);
>> +		unsigned long haddr = pvmw->address & huge_page_mask(hstate);
>> +
>> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, haddr, pvmw->pte);
>> +	} else {
>>  		ptent = ptep_get(pvmw->pte);
>> +	}
>> 
>>  	if (pvmw->flags & PVMW_MIGRATION) {
>>  		const softleaf_t entry = softleaf_from_pte(ptent);
>> --
>> 
>> while leaving pvmw->address unchanged for page_mapped_in_vma()?
>> 
>> Cheers, Lance
>> 
>>> +	else
>>> +		ptent = ptep_get(pvmw->pte);
>>>
>>> 	if (pvmw->flags & PVMW_MIGRATION) {
>>> 		const softleaf_t entry = softleaf_from_pte(ptent);
>>> -- 
>>> 2.43.0
>>>
>>>
>
>

