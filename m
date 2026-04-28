Return-Path: <stable+bounces-241771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHAcK78e8WmRdgEAu9opvQ
	(envelope-from <stable+bounces-241771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:55:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A476B48C1AD
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C112230664A9
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76503644A4;
	Tue, 28 Apr 2026 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf2bKYwj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE84A35;
	Tue, 28 Apr 2026 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409231; cv=none; b=LScFaaolfWJgj0AajkVY2HJfNWkRUNFFOFOrX3L/7gDmvPsTYrBBhro2vjFLHtcV/9eJOoXI0p8BeIIWmeH1ofrrkfvaFxRcOW2T8oGzLkumiLOyPDxjCD90PQUr5NsX4JLkEZCecOUXkenuhCcCy0jnljHRZURfDtquWQkwAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409231; c=relaxed/simple;
	bh=CU6G6tj4vXedgJRhFz5ZO5lzJp2jRWmWy6Up5ktVms4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZOfMYI8h2XV9/nuF1mnuLRIlJmbhlKB6jE5Fk93gvN62RGu5aZFk65LWScbLNAQofnlTzH7+pRf2r5krkyu0WyZ/luHt5qLUUkB9b0lRNW9SB5HHpz5wRSNJCLuI3RwYu4goXT630T1VyRI7IlfkFCvZRbECUonXKyLFwngb0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf2bKYwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE85C2BCB3;
	Tue, 28 Apr 2026 20:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777409231;
	bh=CU6G6tj4vXedgJRhFz5ZO5lzJp2jRWmWy6Up5ktVms4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xf2bKYwjJNCV0jae+hBeDEUsIB0+8jRcPCQXAcudSDX/F9tO1cfzBnm8wsLiTAvUX
	 If+od6ZnFzX1TD+BUaI3r+Ny98ua9IL+pVEJUlG5N5N0PiUKmpWyZezLBJGCORN3rT
	 Z63kLXbawnCR+gmhiSfWJnUr30DtQnkalg0wM/U8qTa54ErJlXsS98TWy5DzYp8w2e
	 uarmut0FN4qz9Y8vIwS8ZUTk0sHc3iMsOZPYEzvA2WPKz0WequNRtV2RO771KxcVLg
	 yORPZaBPWmTa3L+7BSb/yEa+b3goCczuHCNVr5jLQdNRNLCCCoMz4QOfZhjhI4GjC0
	 7ROblFqdW2QSg==
Date: Tue, 28 Apr 2026 22:47:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: fix freeing of PMD-sized vmemmap pages
Message-ID: <afEcxTmjX20zyx44@kernel.org>
References: <20260428-vmemmap-v1-1-b2aa1e6db2c0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-vmemmap-v1-1-b2aa1e6db2c0@kernel.org>
X-Rspamd-Queue-Id: A476B48C1AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241771-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 12:29:36PM +0200, David Hildenbrand (Arm) wrote:
> In commit bf9e4e30f353 ("x86/mm: use pagetable_free()"), we switched
> from freeing non-boot page tables through __free_pages() to
> pagetable_free().
> 
> However, the function is also called to free vmemmap pages.
> 
> Given that vmemmap pages are not page tables, already the page_ptdesc(page)
> is wrong. But worse, pagetable_free() calls
> 
> 	__free_pages(page, compound_order(page));
> 
> As vmemmap pages are not compound pages (see vmemmap_alloc_block()) --
> except for HVO, which doesn't apply here -- we will only free the first
> page when freeing a PMD-sized vmemmap page, leaking the other ones.
> 
> Fix it by properly decoupling pagetable and vmemmap freeing.
> free_pagetable() no longer has to mess with SECTION_INFO, as only the
> vmemmap is marked like that in register_page_bootmem_memmap().
> 
> While at it, just wire up the altmap parameter for remove_pte_table().
> Also, the indentation in remove_pmd_table() is messed up, let's fix that
> while touching it.
> 
> Note that we'll try to get rid of that bootmem info handling soon. For
> now, we'll handle it similar to free_pagetable(), just avoiding the
> ifdef.
> 
> Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> Reproduced and tested with a simple VM with a virtio-mem device,
> repeatedly adding and removing memory.
> 
> Found by code inspection while working on bootmem_info removal.
> ---
>  arch/x86/mm/init_64.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index df2261fa4f98..8d03e44a7fb9 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1014,7 +1014,7 @@ static void __meminit free_pagetable(struct page *page, int order)
>  #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
>  		enum bootmem_type type = bootmem_type(page);
>  
> -		if (type == SECTION_INFO || type == MIX_SECTION_INFO) {
> +		if (type == MIX_SECTION_INFO) {
>  			while (nr_pages--)
>  				put_page_bootmem(page++);
>  		} else {
> @@ -1028,13 +1028,24 @@ static void __meminit free_pagetable(struct page *page, int order)
>  	}
>  }
>  
> -static void __meminit free_hugepage_table(struct page *page,
> +static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
>  		struct vmem_altmap *altmap)
>  {
> -	if (altmap)
> -		vmem_altmap_free(altmap, PMD_SIZE / PAGE_SIZE);
> -	else
> -		free_pagetable(page, get_order(PMD_SIZE));
> +	if (altmap) {
> +		vmem_altmap_free(altmap, 1u << order);
> +	} else if (PageReserved(page)) {
> +		unsigned long nr_pages = 1 << order;
> +
> +		if (IS_ENABLED(CONFIG_HAVE_BOOTMEM_INFO_NODE) &&
> +		    bootmem_type(page) == SECTION_INFO) {
> +			while (nr_pages--)
> +				put_page_bootmem(page++);
> +		} else {
> +			free_reserved_pages(page, nr_pages);
> +		}
> +	} else {
> +		__free_pages(page, order);
> +	}
>  }
>  
>  static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
> @@ -1093,7 +1104,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
>  
>  static void __meminit
>  remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
> -		 bool direct)
> +		 bool direct, struct vmem_altmap *altmap)
>  {
>  	unsigned long next, pages = 0;
>  	pte_t *pte;
> @@ -1118,7 +1129,7 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
>  			return;
>  
>  		if (!direct)
> -			free_pagetable(pte_page(*pte), 0);
> +			free_vmemmap_pages(pte_page(*pte), 0, altmap);
>  
>  		spin_lock(&init_mm.page_table_lock);
>  		pte_clear(&init_mm, addr, pte);
> @@ -1153,25 +1164,25 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
>  			if (IS_ALIGNED(addr, PMD_SIZE) &&
>  			    IS_ALIGNED(next, PMD_SIZE)) {
>  				if (!direct)
> -					free_hugepage_table(pmd_page(*pmd),
> -							    altmap);
> +					free_vmemmap_pages(pmd_page(*pmd),
> +							   PMD_ORDER, altmap);
>  
>  				spin_lock(&init_mm.page_table_lock);
>  				pmd_clear(pmd);
>  				spin_unlock(&init_mm.page_table_lock);
>  				pages++;
>  			} else if (vmemmap_pmd_is_unused(addr, next)) {
> -					free_hugepage_table(pmd_page(*pmd),
> -							    altmap);
> -					spin_lock(&init_mm.page_table_lock);
> -					pmd_clear(pmd);
> -					spin_unlock(&init_mm.page_table_lock);
> +				free_vmemmap_pages(pmd_page(*pmd), PMD_ORDER,
> +						   altmap);
> +				spin_lock(&init_mm.page_table_lock);
> +				pmd_clear(pmd);
> +				spin_unlock(&init_mm.page_table_lock);
>  			}
>  			continue;
>  		}
>  
>  		pte_base = (pte_t *)pmd_page_vaddr(*pmd);
> -		remove_pte_table(pte_base, addr, next, direct);
> +		remove_pte_table(pte_base, addr, next, direct, altmap);
>  		free_pte_table(pte_base, pmd);
>  	}
>  
> 
> ---
> 
> base-commit: a2ddbfd1af0f54ea84bf17f0400088815d012e8d
> 
> change-id: 20260428-vmemmap-ab4b949aa727
> 
> --
> 
> Cheers,
> 
> David
> 

-- 
Sincerely yours,
Mike.

