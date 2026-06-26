Return-Path: <stable+bounces-268782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wieWLjxDPmocCQkAu9opvQ
	(envelope-from <stable+bounces-268782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:15:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A96D6CB9F1
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:15:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=T7Moi+hM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268782-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268782-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 674CC3084519
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 09:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBB53E717A;
	Fri, 26 Jun 2026 09:14:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8403E866B
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:14:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465289; cv=none; b=M6Ai/tH78EWiVwCJYWhzzTjVR4Az46qFW53AZMyUYx2xdGX1gIwF3QZkKWXmvuqWV9fS0CYDbW60VLMQykKWvVvgifutJw7PWPb6Mr4N2FnNUFlRwwfWPK8JvXxTUYsNfDfP7WxzWgVCb7qS7PFxjH0zUOZ/mXQiFTBoKBtEPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465289; c=relaxed/simple;
	bh=7L2ILT5M0bKLh7hfol0ELC0DSd6JHL3nT7d253fBrSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0lklSfiLriFKKBPzpebavjsFFAe0LLpGdtzbvzkKtx4avDeg7Ru+PR5AyV7AUAwF/5Z2azxVkpWEe9cvb5HNBtyBCzkU+EaJlZTPIPqIFc1acQi+qDhLTm1gpv7tofU1TpBjunh8zr1HcBkOZ8bBnKhhbSajepjVMcFTeLReA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T7Moi+hM; arc=none smtp.client-ip=95.215.58.176
Message-ID: <6adeecc1-7204-4d2b-8381-45e13633be57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782465275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGkNXoDW7vkQPBFhvgku7f4WZ/LdspfionMDkNs4wus=;
	b=T7Moi+hM7BpfWhMpIMJR9KVAP0rdMWWq1CBE6ZzZhxMG6sqFmMpykRL2sHculkidiIlFhD
	aVrhifHc069IM7bStV5KZT3EheUxNmdM+QPc4fhmjhzNIj3+Ii7AeTez66Q0mZwiZMWXsw
	iqz+Mz1SHIRdfvtcxiXwpqAmVY9TigY=
Date: Fri, 26 Jun 2026 17:14:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
Content-Language: en-US
To: dev.jain@arm.com, linmiaohe@huawei.com
Cc: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
 ljs@kernel.org, david@kernel.org, liam@infradead.org, riel@surriel.com,
 vbabka@kernel.org, harry@kernel.org, jannh@google.com, kas@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcampbell@nvidia.com,
 apopple@nvidia.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, mel@csn.ul.ie,
 nao.horiguchi@gmail.com, ak@linux.intel.com, j-nomura@ce.jp.nec.com,
 pfalcato@suse.de, dave.hansen@intel.com, tglx@kernel.org,
 jpoimboe@kernel.org, ryan.roberts@arm.com, anshuman.khandual@arm.com,
 stable@vger.kernel.org
References: <20260625112955.3254283-5-dev.jain@arm.com>
 <20260626074855.97652-1-lance.yang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260626074855.97652-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268782-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dev.jain@arm.com,m:linmiaohe@huawei.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[linux.dev,suse.de,linux-foundation.org,kernel.org,infradead.org,surriel.com,google.com,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,arm.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A96D6CB9F1



On 2026/6/26 15:48, Lance Yang wrote:
> 
> On Thu, Jun 25, 2026 at 11:29:53AM +0000, Dev Jain wrote:
>> check_pte() is the final validation step in page_vma_mapped_walk().
>> It reads pvmw->pte with ptep_get() to decide whether the entry maps
>> the PFN range being walked. For hugetlb VMAs, that pointer refers
>> to a hugetlb entry.
>>
>> On arches which provide their own huge_ptep_get() to dereference a huge
>> pte pointer, accessing via ptep_get() would cause pte_pfn(),
>> pte_present() etc to misbehave.
>>
>> It is not clear whether this has a trivially visible effect to userspace.
>>
>> Use huge_ptep_get() to dereference a huge pte pointer.
>>
>> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> mm/page_vma_mapped.c | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 2ccbabfb2cc17..18e1d341f463c 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -107,7 +107,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>> static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>> {
>> 	unsigned long pfn;
>> -	pte_t ptent = ptep_get(pvmw->pte);
>> +	pte_t ptent;
>> +
>> +	if (is_vm_hugetlb_page(pvmw->vma))
>> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>> +				      pvmw->pte);
> 
> I think check_pte() can pass a wrong address to huge_ptep_get() ...
> 
> Not sure that is wrong in the first place. For memory failure,
> page_mapped_in_vma() can be called with a poisoned tail page of a hugetlb
> folio. In that case, pvmw->address need not be hugepage-aligned.
> 
> @Miaohe
> 
> For arm64, CONT_PMD_SIZE is one supported HugeTLB size. With such a VMA,
> page_vma_mapped_walk() passes that size to hugetlb_walk():
> 
> bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> {
> 	...
> 	if (unlikely(is_vm_hugetlb_page(vma))) {
> 		...
> 		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
> 		...
> 	}
> 	...
> }
> 
> hugetlb_walk() then calls arm64 huge_pte_offset(mm, addr, sz). For
> sz == CONT_PMD_SIZE, huge_pte_offset() aligns its local addr before
> calculating pmdp:
> 
> pte_t *huge_pte_offset(struct mm_struct *mm,
> 		       unsigned long addr, unsigned long sz)
> {
> 	...
> 	if (sz == CONT_PMD_SIZE)
> 		addr &= CONT_PMD_MASK;
> 
> 	pmdp = pmd_offset(pudp, addr);
> 	pmd = READ_ONCE(*pmdp);
> 	...
> }
> 
> So for that case, pvmw->pte is calculated from the aligned addr, not
> necessarily from the original pvmw->address. But check_pte() passes the
> original address together with pvmw->pte:
> 
> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
> +				      pvmw->pte);

In addition:

Went through all arch code that has its own huge_ptep_get(); only
arm64 and powerpc actually use addr, and there addr has to match the
ptep, IIUC.

So I am wondering whether all huge_ptep_get() callers satisfy that
requirement.

Cheers, Lance

> 
> arm64 then uses that addr again to choose ncontig:
> 
> pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
> {
> 	...
> 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
> 	for (i = 0; i < ncontig; i++, ptep++) {
> 		...
> 	}
> 	return orig_pte;
> }
> 
> static int find_num_contig(struct mm_struct *mm, unsigned long addr,
> 			   pte_t *ptep, size_t *pgsize)
> {
> 	pgd_t *pgdp = pgd_offset(mm, addr);
> 	p4d_t *p4dp;
> 	pud_t *pudp;
> 	pmd_t *pmdp;
> 
> 	*pgsize = PAGE_SIZE;
> 	p4dp = p4d_offset(pgdp, addr);
> 	pudp = pud_offset(p4dp, addr);
> 	pmdp = pmd_offset(pudp, addr);
> 	if ((pte_t *)pmdp == ptep) {
> 		*pgsize = PMD_SIZE;
> 		return CONT_PMDS;
> 	}
> 	return CONT_PTES;
> }
> 
> With a tail address, pmdp may no longer point at pvmw->pte, so
> find_num_contig() can return CONT_PTES for a CONT_PMD HugeTLB mapping.
> 
> On 16K arm64, that changes ncontig from 32 to 128. So huge_ptep_get()
> can walk past the CONT_PMD entries, and possibly past the PMD table.
> 
> Should check_pte() pass the address matching pvmw->pte, sth like:
> 
> ---8<---
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 406fd50bbd8f..58463493bd3d 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -109,11 +109,14 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>   	unsigned long pfn;
>   	pte_t ptent;
> 
> -	if (is_vm_hugetlb_page(pvmw->vma))
> -		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
> -				      pvmw->pte);
> -	else
> +	if (is_vm_hugetlb_page(pvmw->vma)) {
> +		struct hstate *hstate = hstate_vma(pvmw->vma);
> +		unsigned long haddr = pvmw->address & huge_page_mask(hstate);
> +
> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, haddr, pvmw->pte);
> +	} else {
>   		ptent = ptep_get(pvmw->pte);
> +	}
> 
>   	if (pvmw->flags & PVMW_MIGRATION) {
>   		const softleaf_t entry = softleaf_from_pte(ptent);
> --
> 
> while leaving pvmw->address unchanged for page_mapped_in_vma()?
> 
> Cheers, Lance
> 
>> +	else
>> +		ptent = ptep_get(pvmw->pte);
>>
>> 	if (pvmw->flags & PVMW_MIGRATION) {
>> 		const softleaf_t entry = softleaf_from_pte(ptent);
>> -- 
>> 2.43.0
>>
>>


