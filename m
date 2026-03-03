Return-Path: <stable+bounces-222829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCVLFAqepmlqRwAAu9opvQ
	(envelope-from <stable+bounces-222829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:38:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6871EAE06
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36948300CA1A
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80EF387344;
	Tue,  3 Mar 2026 08:38:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E87329A2
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527109; cv=none; b=da5rhmZlOaPS6Fs+DFOkxbKTDO3piIBmYc5RCK4o2khI1fYsrqTmoDieAj009N2oqzp6y2lIYAWVzC5Zh+yUTjkqEgr6Z9/+SWCknXndyl86Wk5x4qyrVgDHGTPCxmjvbO/giGqYxrqgg3mKePTeiBYhjqPKwF9i0oBEpYXdsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527109; c=relaxed/simple;
	bh=FNMGAkiAf6zgRCr7SpwMEVNM6p+oIUrmBtYwdgKeuJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qe3NJy7TjF+27R6MzFLcFCItOEke9ohyJJODfj92da7KHB9743XZ9o4rNKaLUYgsEuqRVJjwsEQGnVglTZf9G99v7+p1Vix7agjX1bHj0PkTMBD+UNy7i9MzbxUS2CSeezyMjBCZRzJaXc2ro3PbYeQP7j55/yT8DUyRC7l6/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09E9A497;
	Tue,  3 Mar 2026 00:38:20 -0800 (PST)
Received: from [10.57.81.89] (unknown [10.57.81.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8222E3F7BD;
	Tue,  3 Mar 2026 00:38:24 -0800 (PST)
Message-ID: <0a10ea33-937a-4294-b9a1-9323c706434d@arm.com>
Date: Tue, 3 Mar 2026 08:38:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
Content-Language: en-GB
To: Piotr Jaroszynski <pjaroszynski@nvidia.com>, Will Deacon
 <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DE6871EAE06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222829-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.899];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

On 03/03/2026 06:37, Piotr Jaroszynski wrote:
> contpte_ptep_set_access_flags() compared the gathered ptep_get() value
> against the requested entry to detect no-ops. ptep_get() ORs AF/dirty
> from all sub-PTEs in the CONT block, so a dirty sibling can make the
> target appear already-dirty. When the gathered value matches entry, the
> function returns 0 even though the target sub-PTE still has PTE_RDONLY
> set in hardware.
> 
> For CPU page-table walks this is benign: with FEAT_HAFDBS the hardware
> may set AF/dirty on any sub-PTE and the CPU TLB treats the gathered
> result as authoritative for the entire range. But an SMMU without HTTU
> (or with HA/HD disabled in CD.TCR) evaluates each descriptor
> individually and will keep raising F_PERMISSION on the unchanged target
> sub-PTE, causing an infinite fault loop.

Ouch; thanks for the fix!

> 
> Gathering can therefore cause false no-ops when only a sibling has been
> updated:
>  - write faults: target still has PTE_RDONLY (needs PTE_RDONLY cleared)
>  - read faults:  target still lacks PTE_AF
> 
> Fix by checking all sub-PTEs' access flags individually (not via the
> gathered view) before returning no-op, and use the raw target PTE for
> the write-bit unfold decision. The access-flag mask matches the one
> used by __ptep_set_access_flags().
> 
> Per Arm ARM (DDI 0487) D8.7.1 ("The Contiguous bit"), any sub-PTE in a CONT
> range may become the effective cached translation and software must
> maintain consistent attributes across the range.
> 
> Fixes: 4602e5757bcc ("arm64/mm: wire up PTE_CONT for user mappings")
> 

nit: there shouldn't be whitespace here.

> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>

This fix looks good to me:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  arch/arm64/mm/contpte.c | 47 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index bcac4f55f9c1..9868bfe4607c 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -390,6 +390,23 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
>  }
>  EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
>  
> +static bool contpte_all_subptes_match_access_flags(pte_t *ptep, pte_t entry)
> +{
> +	pte_t *cont_ptep = contpte_align_down(ptep);
> +	const pteval_t access_mask = PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY;
> +	pteval_t entry_access = pte_val(entry) & access_mask;
> +	int i;
> +
> +	for (i = 0; i < CONT_PTES; i++) {
> +		pteval_t pte_access = pte_val(__ptep_get(cont_ptep + i)) & access_mask;
> +
> +		if (pte_access != entry_access)
> +			return false;
> +	}

There are 2 forms of "dirty"; HW and SW. Here you are testing that all ptes in
the contpte block have the same form of dirty, which I think is the correct
thing to do. You could relax to just test that every pte has one of the forms of
dirty, But in that case, if a pte is sw-dirty but not hw-dirty, then the
PTE_RDONLY bit remains set and the SMMU will fault, I think?

If my reasoning is correct, then I think arm64 hugetlb has a similar bug; See
__cont_access_flags_changed(), which just checks for any form of dirty. So I
guess hugetlb is buggy in the same way and should be fixed to use this more
stringent approach?

Thanks,
Ryan

> +
> +	return true;
> +}
> +
>  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep,
>  					pte_t entry, int dirty)
> @@ -399,13 +416,35 @@ int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  	int i;
>  
>  	/*
> -	 * Gather the access/dirty bits for the contiguous range. If nothing has
> -	 * changed, its a noop.
> +	 * Check whether all sub-PTEs in the CONT block already have the
> +	 * requested access flags, using raw per-PTE values rather than the
> +	 * gathered ptep_get() view.
> +	 *
> +	 * ptep_get() gathers AF/dirty state across the whole CONT block,
> +	 * which is correct for CPU TLB semantics: with FEAT_HAFDBS the
> +	 * hardware may set AF/dirty on any sub-PTE and the CPU TLB treats
> +	 * the gathered result as authoritative for the entire range. But an
> +	 * SMMU without HTTU (or with HA/HD disabled in CD.TCR) evaluates
> +	 * each descriptor individually and will keep faulting on the target
> +	 * sub-PTE if its flags haven't actually been updated. Gathering can
> +	 * therefore cause false no-ops when only a sibling has been updated:
> +	 *  - write faults: target still has PTE_RDONLY (needs PTE_RDONLY cleared)
> +	 *  - read faults:  target still lacks PTE_AF
> +	 *
> +	 * Per Arm ARM (DDI 0487) D8.7.1, any sub-PTE in a CONT range may
> +	 * become the effective cached translation, so all entries must have
> +	 * consistent attributes. Check the full CONT block before returning
> +	 * no-op, and when any sub-PTE mismatches, proceed to update the whole
> +	 * range.
>  	 */
> -	orig_pte = pte_mknoncont(ptep_get(ptep));
> -	if (pte_val(orig_pte) == pte_val(entry))
> +	if (contpte_all_subptes_match_access_flags(ptep, entry))
>  		return 0;
>  
> +	/*
> +	 * Use raw target pte (not gathered) for write-bit unfold decision.
> +	 */
> +	orig_pte = pte_mknoncont(__ptep_get(ptep));
> +
>  	/*
>  	 * We can fix up access/dirty bits without having to unfold the contig
>  	 * range. But if the write bit is changing, we must unfold.


