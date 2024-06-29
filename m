Return-Path: <stable+bounces-56116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8CF91CB95
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 10:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB0D2838A2
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E50F3307B;
	Sat, 29 Jun 2024 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="EWlNJNfd"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87D1CF9B;
	Sat, 29 Jun 2024 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719648931; cv=none; b=HZyc8fyvwNXRYt0H8VMDqt3UmF0/+GgtZ6yUpFc4XU9iZkADruqritNQIUI26ZxuxYGyObWvyp4ocf5sFxL54Aa5ToZl7R5pPqLwDap+cai7YQ0XmeOQyg033oVaLV71yeQdGs+fDkOWGIEpDC8DIKNvvGq/m4dxTPwisfi+RJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719648931; c=relaxed/simple;
	bh=7fPdSKTB5sDi8Tfo1+Zk3rQPduLiuut1w1gT1fiVd/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT+BM0ZGvg4sxq6xFlYUueIDT/HKbEmJ6FdnFo6d83/QIq0hXbGd2sBKZ6ZGD8n9n8qDpdEiNZFVJY/rkj7A9ZnaBZEqvQNxUGtFQmOWjXnSSVFfACUCbOySRzacnu3JlrZdTkpqaf2CYoYKF/eqM+Val36c91basscU7fvdvPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=EWlNJNfd; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=e7NUOCYME9T42EbguCEH1eL3Rh7H9fSWiZDsAsqD2SQ=;
	b=EWlNJNfdx9Qtfd6Vj6AqpQeNQZZVDRg6QWxqT7LahSWvc4s7/UK9u5Z2NikON6
	q55CQNoPS7YQXrp73M/VT2MdnhygIhFfwOWlCeL/5vhN5047OYsFGkEHOQJ98tpg
	RqqzbO5piLi5GMOpBFRNeblf64rMeS+EXjQfIZvCNXR8Y=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDXv9dywn9mrjW3AA--.729S2;
	Sat, 29 Jun 2024 16:14:43 +0800 (CST)
Message-ID: <a97e9cf7-fca1-4f03-bc2a-7cf48086d21d@126.com>
Date: Sat, 29 Jun 2024 16:14:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 linus-tree PATCH] mm: gup: stop abusing try_grab_folio
To: Yang Shi <yang@os.amperecomputing.com>, peterx@redhat.com,
 david@redhat.com, hch@infradead.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240628191458.2605553-1-yang@os.amperecomputing.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <20240628191458.2605553-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXv9dywn9mrjW3AA--.729S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfZFWrJr15ur1rJw1rGFy8Zrb_yoW8uFWfJo
	WfCw43twnakw13AF4fCF10qFy8uan0v34fGF4fCrs8ZasrZ345Wr47Ww1DXr1DWrn8GF4f
	Gr93Z3W7tFZ7trn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUa9N3UUUUU
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQoNG2VLbDG1jQAAsO



在 2024/6/29 3:14, Yang Shi 写道:
> A kernel warning was reported when pinning folio in CMA memory when
> launching SEV virtual machine.  The splat looks like:
> 
> [  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_pages+0x423/0x520
> [  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not tainted 6.6.33+ #6
> [  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
> [  464.325515] Call Trace:
> [  464.325520]  <TASK>
> [  464.325523]  ? __get_user_pages+0x423/0x520
> [  464.325528]  ? __warn+0x81/0x130
> [  464.325536]  ? __get_user_pages+0x423/0x520
> [  464.325541]  ? report_bug+0x171/0x1a0
> [  464.325549]  ? handle_bug+0x3c/0x70
> [  464.325554]  ? exc_invalid_op+0x17/0x70
> [  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
> [  464.325567]  ? __get_user_pages+0x423/0x520
> [  464.325575]  __gup_longterm_locked+0x212/0x7a0
> [  464.325583]  internal_get_user_pages_fast+0xfb/0x190
> [  464.325590]  pin_user_pages_fast+0x47/0x60
> [  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
> [  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]
> 
> Per the analysis done by yangge, when starting the SEV virtual machine,
> it will call pin_user_pages_fast(..., FOLL_LONGTERM, ...) to pin the
> memory.  But the page is in CMA area, so fast GUP will fail then
> fallback to the slow path due to the longterm pinnalbe check in
> try_grab_folio().
> The slow path will try to pin the pages then migrate them out of CMA
> area.  But the slow path also uses try_grab_folio() to pin the page,
> it will also fail due to the same check then the above warning
> is triggered.
> 
> In addition, the try_grab_folio() is supposed to be used in fast path and
> it elevates folio refcount by using add ref unless zero.  We are guaranteed
> to have at least one stable reference in slow path, so the simple atomic add
> could be used.  The performance difference should be trivial, but the
> misuse may be confusing and misleading.
> 
> Redefined try_grab_folio() to try_grab_folio_fast(), and try_grab_page()
> to try_grab_folio(), and use them in the proper paths.  This solves both
> the abuse and the kernel warning.
> 
> The proper naming makes their usecase more clear and should prevent from
> abusing in the future.
> 
> [1] https://lore.kernel.org/linux-mm/1719478388-31917-1-git-send-email-yangge1116@126.com/
> 
> Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
> Cc: <stable@vger.kernel.org> [6.6+]
> Reported-by: yangge <yangge1116@126.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   mm/gup.c         | 287 +++++++++++++++++++++++++----------------------
>   mm/huge_memory.c |   2 +-
>   mm/internal.h    |   4 +-
>   3 files changed, 155 insertions(+), 138 deletions(-)
> 
> v3:
>     1. Renamed the patch subject to make it more clear per Peter
>     2. Rephrased the commit log and elaborated the function renaming per
>        Peter
>     3. Fixed the comment from Christoph Hellwig
> 
> v2:
>     1. Fixed the build warning
>     2. Reworked the commit log to include the bug report and analysis (reworded by me)
>        from yangge
>     3. Rebased onto the latest Linus's tree
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ca0f5cedce9b..e65773ce4622 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -97,95 +97,6 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
>   	return folio;
>   }
>   
> -/**
> - * try_grab_folio() - Attempt to get or pin a folio.
> - * @page:  pointer to page to be grabbed
> - * @refs:  the value to (effectively) add to the folio's refcount
> - * @flags: gup flags: these are the FOLL_* flag values.
> - *
> - * "grab" names in this file mean, "look at flags to decide whether to use
> - * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
> - *
> - * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
> - * same time. (That's true throughout the get_user_pages*() and
> - * pin_user_pages*() APIs.) Cases:
> - *
> - *    FOLL_GET: folio's refcount will be incremented by @refs.
> - *
> - *    FOLL_PIN on large folios: folio's refcount will be incremented by
> - *    @refs, and its pincount will be incremented by @refs.
> - *
> - *    FOLL_PIN on single-page folios: folio's refcount will be incremented by
> - *    @refs * GUP_PIN_COUNTING_BIAS.
> - *
> - * Return: The folio containing @page (with refcount appropriately
> - * incremented) for success, or NULL upon failure. If neither FOLL_GET
> - * nor FOLL_PIN was set, that's considered failure, and furthermore,
> - * a likely bug in the caller, so a warning is also emitted.
> - */
> -struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
> -{
> -	struct folio *folio;
> -
> -	if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
> -		return NULL;
> -
> -	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
> -		return NULL;
> -
> -	if (flags & FOLL_GET)
> -		return try_get_folio(page, refs);
> -
> -	/* FOLL_PIN is set */
> -
> -	/*
> -	 * Don't take a pin on the zero page - it's not going anywhere
> -	 * and it is used in a *lot* of places.
> -	 */
> -	if (is_zero_page(page))
> -		return page_folio(page);
> -
> -	folio = try_get_folio(page, refs);
> -	if (!folio)
> -		return NULL;
> -
> -	/*
> -	 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
> -	 * right zone, so fail and let the caller fall back to the slow
> -	 * path.
> -	 */
> -	if (unlikely((flags & FOLL_LONGTERM) &&
> -		     !folio_is_longterm_pinnable(folio))) {
> -		if (!put_devmap_managed_folio_refs(folio, refs))
> -			folio_put_refs(folio, refs);
> -		return NULL;
> -	}
> -
> -	/*
> -	 * When pinning a large folio, use an exact count to track it.
> -	 *
> -	 * However, be sure to *also* increment the normal folio
> -	 * refcount field at least once, so that the folio really
> -	 * is pinned.  That's why the refcount from the earlier
> -	 * try_get_folio() is left intact.
> -	 */
> -	if (folio_test_large(folio))
> -		atomic_add(refs, &folio->_pincount);
> -	else
> -		folio_ref_add(folio,
> -				refs * (GUP_PIN_COUNTING_BIAS - 1));
> -	/*
> -	 * Adjust the pincount before re-checking the PTE for changes.
> -	 * This is essentially a smp_mb() and is paired with a memory
> -	 * barrier in folio_try_share_anon_rmap_*().
> -	 */
> -	smp_mb__after_atomic();
> -
> -	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
> -
> -	return folio;
> -}
> -
>   static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>   {
>   	if (flags & FOLL_PIN) {
> @@ -203,58 +114,59 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>   }
>   
>   /**
> - * try_grab_page() - elevate a page's refcount by a flag-dependent amount
> - * @page:    pointer to page to be grabbed
> - * @flags:   gup flags: these are the FOLL_* flag values.
> + * try_grab_folio() - add a folio's refcount by a flag-dependent amount
> + * @folio:    pointer to folio to be grabbed
> + * @refs:     the value to (effectively) add to the folio's refcount
> + * @flags:    gup flags: these are the FOLL_* flag values
>    *
>    * This might not do anything at all, depending on the flags argument.
>    *
>    * "grab" names in this file mean, "look at flags to decide whether to use
> - * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
> + * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
>    *
>    * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
> - * time. Cases: please see the try_grab_folio() documentation, with
> - * "refs=1".
> + * time.
>    *
>    * Return: 0 for success, or if no action was required (if neither FOLL_PIN
>    * nor FOLL_GET was set, nothing is done). A negative error code for failure:
>    *
> - *   -ENOMEM		FOLL_GET or FOLL_PIN was set, but the page could not
> + *   -ENOMEM		FOLL_GET or FOLL_PIN was set, but the folio could not
>    *			be grabbed.
> + *
> + * It is called when we have a stable reference for the folio, typically in
> + * GUP slow path.
>    */
> -int __must_check try_grab_page(struct page *page, unsigned int flags)
> +int __must_check try_grab_folio(struct folio *folio, int refs,
> +				unsigned int flags)
>   {
> -	struct folio *folio = page_folio(page);
> -
>   	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
>   		return -ENOMEM;
>   
> -	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
> +	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(&folio->page)))
>   		return -EREMOTEIO;
>   
>   	if (flags & FOLL_GET)
> -		folio_ref_inc(folio);
> +		folio_ref_add(folio, refs);
>   	else if (flags & FOLL_PIN) {
>   		/*
>   		 * Don't take a pin on the zero page - it's not going anywhere
>   		 * and it is used in a *lot* of places.
>   		 */
> -		if (is_zero_page(page))
> +		if (is_zero_folio(folio))
>   			return 0;
>   
>   		/*
> -		 * Similar to try_grab_folio(): be sure to *also*
> -		 * increment the normal page refcount field at least once,
> +		 * Increment the normal page refcount field at least once,
>   		 * so that the page really is pinned.
>   		 */
>   		if (folio_test_large(folio)) {
> -			folio_ref_add(folio, 1);
> -			atomic_add(1, &folio->_pincount);
> +			folio_ref_add(folio, refs);
> +			atomic_add(refs, &folio->_pincount);
>   		} else {
> -			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
> +			folio_ref_add(folio, refs * GUP_PIN_COUNTING_BIAS);
>   		}
>   
> -		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
> +		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
>   	}
>   
>   	return 0;
> @@ -535,7 +447,7 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
>    */
>   static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz,
>   		       unsigned long addr, unsigned long end, unsigned int flags,
> -		       struct page **pages, int *nr)
> +		       struct page **pages, int *nr, bool fast)
>   {
>   	unsigned long pte_end;
>   	struct page *page;
> @@ -558,9 +470,15 @@ static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz
>   	page = pte_page(pte);
>   	refs = record_subpages(page, sz, addr, end, pages + *nr);
>   
> -	folio = try_grab_folio(page, refs, flags);
> -	if (!folio)
> -		return 0;
> +	if (fast) {
> +		folio = try_grab_folio_fast(page, refs, flags);
> +		if (!folio)
> +			return 0;
> +	} else {
> +		folio = page_folio(page);
> +		if (try_grab_folio(folio, refs, flags))
> +			return 0;
> +	}
>   
>   	if (unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
>   		gup_put_folio(folio, refs, flags);
> @@ -588,7 +506,7 @@ static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz
>   static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
>   		      unsigned long addr, unsigned int pdshift,
>   		      unsigned long end, unsigned int flags,
> -		      struct page **pages, int *nr)
> +		      struct page **pages, int *nr, bool fast)
>   {
>   	pte_t *ptep;
>   	unsigned long sz = 1UL << hugepd_shift(hugepd);
> @@ -598,7 +516,8 @@ static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
>   	ptep = hugepte_offset(hugepd, addr, pdshift);
>   	do {
>   		next = hugepte_addr_end(addr, end, sz);
> -		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr);
> +		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr,
> +				  fast);
>   		if (ret != 1)
>   			return ret;
>   	} while (ptep++, addr = next, addr != end);
> @@ -625,7 +544,7 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
>   	ptep = hugepte_offset(hugepd, addr, pdshift);
>   	ptl = huge_pte_lock(h, vma->vm_mm, ptep);
>   	ret = gup_hugepd(vma, hugepd, addr, pdshift, addr + PAGE_SIZE,
> -			 flags, &page, &nr);
> +			 flags, &page, &nr, false);
>   	spin_unlock(ptl);
>   
>   	if (ret == 1) {
> @@ -642,7 +561,7 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
>   static inline int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
>   			     unsigned long addr, unsigned int pdshift,
>   			     unsigned long end, unsigned int flags,
> -			     struct page **pages, int *nr)
> +			     struct page **pages, int *nr, bool fast)
>   {
>   	return 0;
>   }
> @@ -729,7 +648,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
>   	    gup_must_unshare(vma, flags, page))
>   		return ERR_PTR(-EMLINK);
>   
> -	ret = try_grab_page(page, flags);
> +	ret = try_grab_folio(page_folio(page), 1, flags);
>   	if (ret)
>   		page = ERR_PTR(ret);
>   	else
> @@ -806,7 +725,7 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
>   	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
>   			!PageAnonExclusive(page), page);
>   
> -	ret = try_grab_page(page, flags);
> +	ret = try_grab_folio(page_folio(page), 1, flags);
>   	if (ret)
>   		return ERR_PTR(ret);
>   
> @@ -968,8 +887,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>   	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
>   		       !PageAnonExclusive(page), page);
>   
> -	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
> -	ret = try_grab_page(page, flags);
> +	/* try_grab_folio() does nothing unless FOLL_GET or FOLL_PIN is set. */
> +	ret = try_grab_folio(page_folio(page), 1, flags);
>   	if (unlikely(ret)) {
>   		page = ERR_PTR(ret);
>   		goto out;
> @@ -1233,7 +1152,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
>   			goto unmap;
>   		*page = pte_page(entry);
>   	}
> -	ret = try_grab_page(*page, gup_flags);
> +	ret = try_grab_folio(page_folio(*page), 1, gup_flags);
>   	if (unlikely(ret))
>   		goto unmap;
>   out:
> @@ -1636,20 +1555,19 @@ static long __get_user_pages(struct mm_struct *mm,
>   			 * pages.
>   			 */
>   			if (page_increm > 1) {
> -				struct folio *folio;
> +				struct folio *folio = page_folio(page);
>   
>   				/*
>   				 * Since we already hold refcount on the
>   				 * large folio, this should never fail.
>   				 */
> -				folio = try_grab_folio(page, page_increm - 1,
> -						       foll_flags);
> -				if (WARN_ON_ONCE(!folio)) {
> +				if (try_grab_folio(folio, page_increm - 1,
> +						   foll_flags)) {
>   					/*
>   					 * Release the 1st page ref if the
>   					 * folio is problematic, fail hard.
>   					 */
> -					gup_put_folio(page_folio(page), 1,
> +					gup_put_folio(folio, 1,
>   						      foll_flags);
>   					ret = -EFAULT;

Seems we can use the return value of try_grap_folio().

ret = try_grab_folio(folio, page_increm - 1, foll_flags);

>   					goto out;
> @@ -2797,6 +2715,101 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>    * This code is based heavily on the PowerPC implementation by Nick Piggin.
>    */
>   #ifdef CONFIG_HAVE_GUP_FAST
> +/**
> + * try_grab_folio_fast() - Attempt to get or pin a folio in fast path.
> + * @page:  pointer to page to be grabbed
> + * @refs:  the value to (effectively) add to the folio's refcount
> + * @flags: gup flags: these are the FOLL_* flag values.
> + *
> + * "grab" names in this file mean, "look at flags to decide whether to use
> + * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
> + *
> + * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
> + * same time. (That's true throughout the get_user_pages*() and
> + * pin_user_pages*() APIs.) Cases:
> + *
> + *    FOLL_GET: folio's refcount will be incremented by @refs.
> + *
> + *    FOLL_PIN on large folios: folio's refcount will be incremented by
> + *    @refs, and its pincount will be incremented by @refs.
> + *
> + *    FOLL_PIN on single-page folios: folio's refcount will be incremented by
> + *    @refs * GUP_PIN_COUNTING_BIAS.
> + *
> + * Return: The folio containing @page (with refcount appropriately
> + * incremented) for success, or NULL upon failure. If neither FOLL_GET
> + * nor FOLL_PIN was set, that's considered failure, and furthermore,
> + * a likely bug in the caller, so a warning is also emitted.
> + *
> + * It uses add ref unless zero to elevate the folio refcount and must be called
> + * in fast path only.
> + */
> +static struct folio *try_grab_folio_fast(struct page *page, int refs,
> +					 unsigned int flags)
> +{
> +	struct folio *folio;
> +
> +	/* Raise warn if it is not called in fast GUP */
> +	VM_WARN_ON_ONCE(!irqs_disabled());
> +
> +	if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
> +		return NULL;
> +
> +	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
> +		return NULL;
> +
> +	if (flags & FOLL_GET)
> +		return try_get_folio(page, refs);
> +
> +	/* FOLL_PIN is set */
> +
> +	/*
> +	 * Don't take a pin on the zero page - it's not going anywhere
> +	 * and it is used in a *lot* of places.
> +	 */
> +	if (is_zero_page(page))
> +		return page_folio(page);
> +
> +	folio = try_get_folio(page, refs);
> +	if (!folio)
> +		return NULL;
> +
> +	/*
> +	 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
> +	 * right zone, so fail and let the caller fall back to the slow
> +	 * path.
> +	 */
> +	if (unlikely((flags & FOLL_LONGTERM) &&
> +		     !folio_is_longterm_pinnable(folio))) {
> +		if (!put_devmap_managed_folio_refs(folio, refs))
> +			folio_put_refs(folio, refs);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * When pinning a large folio, use an exact count to track it.
> +	 *
> +	 * However, be sure to *also* increment the normal folio
> +	 * refcount field at least once, so that the folio really
> +	 * is pinned.  That's why the refcount from the earlier
> +	 * try_get_folio() is left intact.
> +	 */
> +	if (folio_test_large(folio))
> +		atomic_add(refs, &folio->_pincount);
> +	else
> +		folio_ref_add(folio,
> +				refs * (GUP_PIN_COUNTING_BIAS - 1));
> +	/*
> +	 * Adjust the pincount before re-checking the PTE for changes.
> +	 * This is essentially a smp_mb() and is paired with a memory
> +	 * barrier in folio_try_share_anon_rmap_*().
> +	 */
> +	smp_mb__after_atomic();
> +
> +	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
> +
> +	return folio;
> +}
>   
>   /*
>    * Used in the GUP-fast path to determine whether GUP is permitted to work on
> @@ -2962,7 +2975,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>   		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>   		page = pte_page(pte);
>   
> -		folio = try_grab_folio(page, 1, flags);
> +		folio = try_grab_folio_fast(page, 1, flags);
>   		if (!folio)
>   			goto pte_unmap;
>   
> @@ -3049,7 +3062,7 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
>   			break;
>   		}
>   
> -		folio = try_grab_folio(page, 1, flags);
> +		folio = try_grab_folio_fast(page, 1, flags);
>   		if (!folio) {
>   			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
>   			break;
> @@ -3138,7 +3151,7 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>   	page = pmd_page(orig);
>   	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
>   
> -	folio = try_grab_folio(page, refs, flags);
> +	folio = try_grab_folio_fast(page, refs, flags);
>   	if (!folio)
>   		return 0;
>   
> @@ -3182,7 +3195,7 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
>   	page = pud_page(orig);
>   	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
>   
> -	folio = try_grab_folio(page, refs, flags);
> +	folio = try_grab_folio_fast(page, refs, flags);
>   	if (!folio)
>   		return 0;
>   
> @@ -3222,7 +3235,7 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>   	page = pgd_page(orig);
>   	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
>   
> -	folio = try_grab_folio(page, refs, flags);
> +	folio = try_grab_folio_fast(page, refs, flags);
>   	if (!folio)
>   		return 0;
>   
> @@ -3276,7 +3289,8 @@ static int gup_fast_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr,
>   			 * pmd format and THP pmd format
>   			 */
>   			if (gup_hugepd(NULL, __hugepd(pmd_val(pmd)), addr,
> -				       PMD_SHIFT, next, flags, pages, nr) != 1)
> +				       PMD_SHIFT, next, flags, pages, nr,
> +				       true) != 1)
>   				return 0;
>   		} else if (!gup_fast_pte_range(pmd, pmdp, addr, next, flags,
>   					       pages, nr))
> @@ -3306,7 +3320,8 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
>   				return 0;
>   		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
>   			if (gup_hugepd(NULL, __hugepd(pud_val(pud)), addr,
> -				       PUD_SHIFT, next, flags, pages, nr) != 1)
> +				       PUD_SHIFT, next, flags, pages, nr,
> +				       true) != 1)
>   				return 0;
>   		} else if (!gup_fast_pmd_range(pudp, pud, addr, next, flags,
>   					       pages, nr))
> @@ -3333,7 +3348,8 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
>   		BUILD_BUG_ON(p4d_leaf(p4d));
>   		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
>   			if (gup_hugepd(NULL, __hugepd(p4d_val(p4d)), addr,
> -				       P4D_SHIFT, next, flags, pages, nr) != 1)
> +				       P4D_SHIFT, next, flags, pages, nr,
> +				       true) != 1)
>   				return 0;
>   		} else if (!gup_fast_pud_range(p4dp, p4d, addr, next, flags,
>   					       pages, nr))
> @@ -3362,7 +3378,8 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
>   				return;
>   		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
>   			if (gup_hugepd(NULL, __hugepd(pgd_val(pgd)), addr,
> -				       PGDIR_SHIFT, next, flags, pages, nr) != 1)
> +				       PGDIR_SHIFT, next, flags, pages, nr,
> +				       true) != 1)
>   				return;
>   		} else if (!gup_fast_p4d_range(pgdp, pgd, addr, next, flags,
>   					       pages, nr))
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index db7946a0a28c..2120f7478e55 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1331,7 +1331,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>   	if (!*pgmap)
>   		return ERR_PTR(-EFAULT);
>   	page = pfn_to_page(pfn);
> -	ret = try_grab_page(page, flags);
> +	ret = try_grab_folio(page_folio(page), 1, flags);
>   	if (ret)
>   		page = ERR_PTR(ret);
>   
> diff --git a/mm/internal.h b/mm/internal.h
> index 6902b7dd8509..cc2c5e07fad3 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1182,8 +1182,8 @@ int migrate_device_coherent_page(struct page *page);
>   /*
>    * mm/gup.c
>    */
> -struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
> -int __must_check try_grab_page(struct page *page, unsigned int flags);
> +int __must_check try_grab_folio(struct folio *folio, int refs,
> +				unsigned int flags);
>   
>   /*
>    * mm/huge_memory.c


