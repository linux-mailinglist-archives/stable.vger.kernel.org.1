Return-Path: <stable+bounces-244125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEG7LqDg+WlPEwMAu9opvQ
	(envelope-from <stable+bounces-244125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:20:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3186E4CD576
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94155300795D
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA534CFC4;
	Tue,  5 May 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6mu93jk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6D38E5C8;
	Tue,  5 May 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983645; cv=none; b=H4iLZh42hXwk1vD3jJv/yiWljbw0DPTmCigiuvkSAEAURsKrDdmMQmdS4XBnxT0TPXq8xWnKxRhBhWxFkf6ra4p1mAJE81JCknnTlYaCQ6Z6GXfQ7DqHWDGmiBnoqIewqfUPih0668MIsvpO7nCinJNpcXaMHpl/DiIoMG74K/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983645; c=relaxed/simple;
	bh=6BjI5eOuom5pvJYSucqP4/FaJG3jMl4E2DqfW6+FQ7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5w/okXimbeMd7eJXvfe97pUWs4zY9KB6jLkskd1/gBzheqJgahACi9JykKWovUQbAvoHZA2ervh0Jl1MKH+NwGOASzXZjrxTeXndKP4HICTW7d6S2rWbfDU5PA1PokQKNN2XEsJJw4x4DtjtWrnIST92bkCCoYenkxGec+tMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6mu93jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08885C2BCB4;
	Tue,  5 May 2026 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777983645;
	bh=6BjI5eOuom5pvJYSucqP4/FaJG3jMl4E2DqfW6+FQ7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6mu93jkiHjKWcy+UZvMqFimN7mzVDoyBLRyL95V6b4o0AP0bAw6fhxN3ULKsPRwg
	 d4DEf9cBYXkRqvnw/4IAU+2hsKfu9oUA3+SasOI77LbGyG7cu0App92sNzsqaGtih4
	 E0f9P/83K5tSWslQGZHbjeezvzUbHe4NBDylhZab6rIIgoRaRLshXOc6db0YLj1jT0
	 h23o6ruRrULweJvSZk/PCFBfUX9ctm/50biEqvraaOyvnzCHkV74IuQjl+6lAXOsCE
	 s4xbsljW3Bilb8vQOkRHJ0GSPgCyJCOCNCXQ8anCY4i/+k5Jac+L85aPKAqfTFKffW
	 tCvuiditQph8Q==
Date: Tue, 5 May 2026 13:20:40 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, 
	Hugh Dickins <hughd@google.com>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix __vm_normal_page() to handle missing support for
 pmd_special()/pud_special()
Message-ID: <afnffbs-5cy7KGua@lucifer>
References: <20260430-pmd_special-v1-1-dbcbcfd72c20@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-pmd_special-v1-1-dbcbcfd72c20@kernel.org>
X-Rspamd-Queue-Id: 3186E4CD576
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244125-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:email]

On Thu, Apr 30, 2026 at 01:31:22PM +0200, David Hildenbrand (Arm) wrote:
> On x86 32-bit with THP enabled, zap_huge_pmd() is seen to generate a
> "WARNING: mm/memory.c:735 at __vm_normal_page+0x6a/0x7d", from the
> VM_WARN_ON_ONCE(is_zero_pfn(pfn) || is_huge_zero_pfn(pfn)); followed
> by "BUG: Bad rss-counter state"s, then later "BUG: Bad page state"s
> when reclaim gets to call shrink_huge_zero_folio_scan().
>
> It's as if the _PAGE_SPECIAL bit never got set in the huge_zero pmd:
> and indeed, whereas pte_special() and pte_mkspecial() are subject to a
> dedicated CONFIG_ARCH_HAS_PTE_SPECIAL, pmd_special() and pmd_mkspecial()
> are subject to CONFIG_ARCH_SUPPORTS_PMD_PFNMAP, which is never enabled
> on any 32-bit architecture.

Ah damn. I wonder if it's really a combination of 'supports THP' and 'has a
spare software defined bit free in PTE'?

In any case obviously have to fix this.

>
> While the problem was exposed through commit d80a9cb1a64a ("mm/huge_memory:
> add and use normal_or_softleaf_folio_pmd()"), it was an oversight in commit
> af38538801c6 ("mm/memory: factor out common code from vm_normal_page_*()")
> and would result in other problems:
> * huge zero folio accounted in smaps, pagemap (PAGE_IS_FILE) and
>   numamaps as file-backed THP
> * folio_walk_start() returning the folio even without FW_ZEROPAGE set.
>   Callers seem to tolerate that, though.
>
> ... and triggering the VM_WARN_ON_ONE(), although never reported so far.
>
> To fix it, teach vm_normal_page_pmd()/vm_normal_page_pud() to consider
> whether pmd_special/pud_special is actually implemented.
>
> Fixes: af38538801c6 ("mm/memory: factor out common code from vm_normal_page_*()")
> Reported-by: Hugh Dickins <hughd@google.com>
> Closes: https://lore.kernel.org/r/74a75b59-2e13-3985-ee99-d5521f39df2a@google.com
> Reported-by: Bibo Mao <maobibo@loongson.cn>
> Closes: https://lore.kernel.org/r/20260430041121.2839350-1-maobibo@loongson.cn
> Debugged-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Tested-by: Bibo Mao <maobibo@loongson.cn>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

This LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
> This is an alternative to Hugh's patch, whereby we leave pmd_special()
> be a NOP and instead teach __vm_normal_page() about lack of support for
> pmd_special/pud_special.
> ---
>  mm/memory.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 7322a40e73b9..4d84976fc7f4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -612,6 +612,21 @@ static void print_bad_page_map(struct vm_area_struct *vma,
>  	dump_stack();
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  }
> +
> +static inline bool pgtable_level_has_pxx_special(enum pgtable_level level)
> +{
> +	switch (level) {
> +	case PGTABLE_LEVEL_PTE:
> +		return IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL);
> +	case PGTABLE_LEVEL_PMD:
> +		return IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP);
> +	case PGTABLE_LEVEL_PUD:
> +		return IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP);
> +	default:
> +		return false;
> +	}
> +}
> +
>  #define print_bad_pte(vma, addr, pte, page) \
>  	print_bad_page_map(vma, addr, pte_val(pte), page, PGTABLE_LEVEL_PTE)
>
> @@ -684,7 +699,7 @@ static inline struct page *__vm_normal_page(struct vm_area_struct *vma,
>  		unsigned long addr, unsigned long pfn, bool special,
>  		unsigned long long entry, enum pgtable_level level)
>  {
> -	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
> +	if (pgtable_level_has_pxx_special(level)) {
>  		if (unlikely(special)) {
>  #ifdef CONFIG_FIND_NORMAL_PAGE
>  			if (vma->vm_ops && vma->vm_ops->find_normal_page)
> @@ -699,8 +714,9 @@ static inline struct page *__vm_normal_page(struct vm_area_struct *vma,
>  			return NULL;
>  		}
>  		/*
> -		 * With CONFIG_ARCH_HAS_PTE_SPECIAL, any special page table
> -		 * mappings (incl. shared zero folios) are marked accordingly.
> +		 * With working pte_special()/pmd_special()..., any special page
> +		 * table mappings (incl. shared zero folios) are marked
> +		 * accordingly.
>  		 */
>  	} else {
>  		if (unlikely(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))) {
>
> ---
>
> base-commit: d94322006a51b522dd361128a450bf9e75aad889
>
> change-id: 20260430-pmd_special-610dbdd8ac3c
>
> --
>
> Cheers,
>
> David
>

