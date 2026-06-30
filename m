Return-Path: <stable+bounces-269979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2AH5CMrLQ2oviQoAu9opvQ
	(envelope-from <stable+bounces-269979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 15:59:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4986E5261
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 15:59:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=Fiyz70s4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269979-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269979-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B0CE313720D
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78534A77D;
	Tue, 30 Jun 2026 13:54:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2F7404E;
	Tue, 30 Jun 2026 13:54:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827648; cv=none; b=gHxxO5nAe8WxL+cxgKZidijuNn7d/koo8Khbc0lxGpFRvr2NQFl/3cAiGrvchGlWFm3Ww+Z0WyVPG5I1cQIqq7rRP+aywl6Msoe6gLZyzDodfKrcH3qBO/xARcIDlLLfyz/RN0skHsb6b0qeZLdhYolrAXqgezTkQj0YxQfxNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827648; c=relaxed/simple;
	bh=bRjeMLBRn+jxQAm2ekNeaSxDem01aFIboF+1jmwc+uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gu3atihf7EWuhGTH6Hri4JIrL1bWun3LGH7ImoOy7FAw4OyDpEsvcL4Zz9mfmXQOMt1TZZvwnUzpTv2Jcnx0WAYsSbdeLrq5Ytj/Pr3ekKXH04PqSdGRB8ao27HpqixvOpQrPVjW2BkS6ugVvLmMKcrvsP+oxMfnwEYlS5I3Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fiyz70s4; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B1BC1C01;
	Tue, 30 Jun 2026 06:54:01 -0700 (PDT)
Received: from [10.164.19.15] (unknown [10.164.19.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E86503F66F;
	Tue, 30 Jun 2026 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782827645; bh=bRjeMLBRn+jxQAm2ekNeaSxDem01aFIboF+1jmwc+uU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fiyz70s4+uUmNIjX6xDSUdsEK140AT1ai79NuNO+FWxq+cbpgHt9EB8jc7BkLtcU9
	 0K71n9prgUrk/y4KNQgNrLb42LI0u/iktK1roYgs9wWn3PE9SaEULIHo9SXT8C4g/+
	 gn+oSZCYkUxpoyK2BiuJDr9vOdIKKu/7eKYah7ME=
Message-ID: <cf369aa5-e540-4c3b-85d6-0e9e159496ed@arm.com>
Date: Tue, 30 Jun 2026 19:23:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lance Yang <lance.yang@linux.dev>
Cc: linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
 akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
 riel@surriel.com, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 kas@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rcampbell@nvidia.com, apopple@nvidia.com, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 mel@csn.ul.ie, nao.horiguchi@gmail.com, ak@linux.intel.com,
 j-nomura@ce.jp.nec.com, pfalcato@suse.de, dave.hansen@intel.com,
 tglx@kernel.org, jpoimboe@kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <0fabee2a-edb7-41c8-91ec-8cf0646c9e83@kernel.org>
 <20260629074802.42727-1-lance.yang@linux.dev>
 <a1c6c3dd-8db1-4db6-b032-e350bacc4577@kernel.org>
 <6fdc0cbd-0880-4594-bf33-a2993ac2fe60@arm.com>
 <1fb04774-1ac6-472a-bbc8-52fceb69b018@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <1fb04774-1ac6-472a-bbc8-52fceb69b018@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-269979-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:lance.yang@linux.dev,m:linmiaohe@huawei.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:liam@infradead.org,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[huawei.com,linux.dev,suse.de,linux-foundation.org,kernel.org,infradead.org,surriel.com,google.com,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,arm.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:dkim,arm.com:mid,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C4986E5261



On 30/06/26 6:16 pm, David Hildenbrand (Arm) wrote:
> On 6/30/26 13:34, Dev Jain wrote:
>>
>>
>> On 29/06/26 1:35 pm, David Hildenbrand (Arm) wrote:
>>> On 6/29/26 09:48, Lance Yang wrote:
>>>>
>>>> >from pagewalk code (where some users like pagemap need the actual address).
>>>>
>>>> Indeed ...
>>>>
>>>>
>>>> Kinda lean toward option 1, even if it's more invasive. If we pass the
>>>> hstate down, each arch can figure out the right addr from there.
>>>>
>>>>
>>>> AFAICT, for huge_ptep_get() the addr users are arm64 and powerpc, riscv
>>>> doesn't really care about addr there. Looks mostly arm64-specific ... 
>>> powerpc handles it correctly in the weird "span two PMD entries" case by
>>> aligning the PMD down.
>>>
>>> Risc-v copied from arm64, but can simply derive the #entries from the PTE value.
>>> it doesn't have to re-walk the table using the address.
>>>
>>> But I think the following is required to fix, no?
>>
>> We don't receive an unaligned ptep in huge_ptep_get, and riscv derives the
>> number of cont ptes from the pte itself, so why is the below required?
> 
> Let me look at the actual report once more ...
> 
> I thought for a second that the problem would be having the ptep not point at the
> start of the hugetlb page mapping. But that should always be the case.
> So yes, riscv does not have any problems.
> 
> And IIUC, arm64 only has a problem when CONT_PTES != CONT_PMDS (16 kernel?).
> 
> Yeah, aligning the ptep down doesn't solve anything, it's already properly aligned.
> 
> To fix it inside arm64 code, we'd have to teach find_num_contig() to
> ignore the ptep and instead look for the cont bit, maybe?
> 
> But I'm sure I messed this up as I am working on 10 things at the same time :D
> 
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index d477a9dd1b472..d1d03795c135e 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -76,7 +76,7 @@ bool arch_hugetlb_migration_supported(struct hstate *h)
>  #endif
>  
>  static int find_num_contig(struct mm_struct *mm, unsigned long addr,
> -                          pte_t *ptep, size_t *pgsize)
> +                          size_t *pgsize)
>  {
>         pgd_t *pgdp = pgd_offset(mm, addr);
>         p4d_t *p4dp;
> @@ -87,7 +87,7 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
>         p4dp = p4d_offset(pgdp, addr);
>         pudp = pud_offset(p4dp, addr);
>         pmdp = pmd_offset(pudp, addr);
> -       if ((pte_t *)pmdp == ptep) {
> +       if (pmd_cont(*pmdp)) {

We can simply do this right:

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index b8432886085af..a35fa373263dc 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -87,7 +87,7 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	p4dp = p4d_offset(pgdp, addr);
 	pudp = pud_offset(p4dp, addr);
 	pmdp = pmd_offset(pudp, addr);
-	if ((pte_t *)pmdp == ptep) {
+	if ((pte_t *)PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS) == ptep) {
 		*pgsize = PMD_SIZE;
 		return CONT_PMDS;
 	}


>                 *pgsize = PMD_SIZE;
>                 return CONT_PMDS;
>         }
> @@ -131,7 +131,7 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>         if (!pte_present(orig_pte) || !pte_cont(orig_pte))
>                 return orig_pte;
>  
> -       ncontig = find_num_contig(mm, addr, ptep, &pgsize);
> +       ncontig = find_num_contig(mm, addr, &pgsize);
>         for (i = 0; i < ncontig; i++, ptep++) {
>                 pte_t pte = __ptep_get(ptep);
>  
> @@ -475,7 +475,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
>                 return;
>         }
>  
> -       ncontig = find_num_contig(mm, addr, ptep, &pgsize);
> +       ncontig = find_num_contig(mm, addr, &pgsize);
>  
>         pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
>         pte = pte_wrprotect(pte);
> diff --git a/mm/memory.c b/mm/memory.c
> 
> 


