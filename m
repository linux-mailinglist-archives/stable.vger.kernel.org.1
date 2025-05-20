Return-Path: <stable+bounces-145710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D3ABE41E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 21:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C901BC203B
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885F283128;
	Tue, 20 May 2025 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QvCktGuM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sL68f2ji";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QvCktGuM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sL68f2ji"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441328151E
	for <stable@vger.kernel.org>; Tue, 20 May 2025 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770801; cv=none; b=AXLlqmCjzkcymASpk4I+FpAsUXDMmZGR15FGRkKm70eiy4B9DFlntyatvx3+1QH0/On1NwwMZURa/2CBBPSmgyr1VRE1tef8u03e+Fw5MpgE19fedIinNMWC74bBqeI/l5nBaU8qdd4GXAr5LrdeIJq+hlG7bVzvHY64PWqZkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770801; c=relaxed/simple;
	bh=r02WTNLTkZ/4TsfbX5I3EifcoEkeGfFEmnTe1C+LMjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCrIR9qW1mIssfn9ToryjnPVpHQk1VDyGEBg87E9DBwFSRKSRighgKg80ekdoMSF6wkR/DcZUrlFMa+N+eXfMv7ZZBEEJXjmCozo47ON0/YMCC9f4mYkZeNOKAi+BIgf3Uq9dHQzrXwuO3R8lY8mX2fINTe8dFe0EnRM/ZXt8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QvCktGuM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sL68f2ji; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QvCktGuM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sL68f2ji; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A55B02225F;
	Tue, 20 May 2025 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747770789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S34FQjO/spo0/EF5quOdXn1uELyrC8/pQ7dPMdPUKXs=;
	b=QvCktGuMZWVjCcKAF6DQr/6K/g9d0kj8S88bvzkl9x+3GLmyUCJWBeakmlcbrgg6qgPJ7n
	NejSFqWc6b+GsRzQh6T6rcK7XR4sI8EDwFCNJaErMjb9JP2dhqOPC9JC1YI9HYYB+qFyzY
	jfxbpoGfWg8jz3yExwONwb5p+7uzWb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747770789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S34FQjO/spo0/EF5quOdXn1uELyrC8/pQ7dPMdPUKXs=;
	b=sL68f2jiZoxPUe0MpvYNAOsabqTjxTgbFBzg8X4oCHV/MW8maD8NyEdzlpOlGr+xOvEfpk
	h040HrHFg4xf3FCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747770789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S34FQjO/spo0/EF5quOdXn1uELyrC8/pQ7dPMdPUKXs=;
	b=QvCktGuMZWVjCcKAF6DQr/6K/g9d0kj8S88bvzkl9x+3GLmyUCJWBeakmlcbrgg6qgPJ7n
	NejSFqWc6b+GsRzQh6T6rcK7XR4sI8EDwFCNJaErMjb9JP2dhqOPC9JC1YI9HYYB+qFyzY
	jfxbpoGfWg8jz3yExwONwb5p+7uzWb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747770789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S34FQjO/spo0/EF5quOdXn1uELyrC8/pQ7dPMdPUKXs=;
	b=sL68f2jiZoxPUe0MpvYNAOsabqTjxTgbFBzg8X4oCHV/MW8maD8NyEdzlpOlGr+xOvEfpk
	h040HrHFg4xf3FCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77B7B13A3E;
	Tue, 20 May 2025 19:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eI5+HKXdLGgYdQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 20 May 2025 19:53:09 +0000
Date: Tue, 20 May 2025 21:53:00 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Gavin Guo <gavinguo@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	kernel-dev@igalia.com, stable@vger.kernel.org,
	Hugh Dickins <hughd@google.com>, Florent Revest <revest@google.com>,
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <aCzdnAmuOylilU1p@localhost.localdomain>
References: <20250513093448.592150-1-gavinguo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513093448.592150-1-gavinguo@igalia.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

On Tue, May 13, 2025 at 05:34:48PM +0800, Gavin Guo wrote:
> The patch fixes a deadlock which can be triggered by an internal
> syzkaller [1] reproducer and captured by bpftrace script [2] and its log
> [3] in this scenario:
> 
> Process 1                              Process 2
> ---				       ---
> hugetlb_fault
>   mutex_lock(B) // take B
>   filemap_lock_hugetlb_folio
>     filemap_lock_folio
>       __filemap_get_folio
>         folio_lock(A) // take A
>   hugetlb_wp
>     mutex_unlock(B) // release B
>     ...                                hugetlb_fault
>     ...                                  mutex_lock(B) // take B
>                                          filemap_lock_hugetlb_folio
>                                            filemap_lock_folio
>                                              __filemap_get_folio
>                                                folio_lock(A) // blocked
>     unmap_ref_private
>     ...
>     mutex_lock(B) // retake and blocked
> 
...
> Signed-off-by: Gavin Guo <gavinguo@igalia.com>

I think this is more convoluted that it needs to be?

hugetlb_wp() is called from hugetlb_no_page() and hugetlb_fault().
hugetlb_no_page() locks and unlocks the lock itself, which leaves us
with hugetlb_fault().

hugetlb_fault() always passed the folio locked to hugetlb_wp(), and the
latter only unlocks it when we have a cow from owner happening and we
cannot satisfy the allocation.
So, should not checking whether the folio is still locked after
returning enough?
What speaks against:

 diff --git a/mm/hugetlb.c b/mm/hugetlb.c
 index bd8971388236..23b57c5689a4 100644
 --- a/mm/hugetlb.c
 +++ b/mm/hugetlb.c
 @@ -6228,6 +6228,12 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
  			u32 hash;
 
  			folio_put(old_folio);
 +			/*
 +			* The pagecache_folio needs to be unlocked to avoid
 +			* deadlock when the child unmaps the folio.
 +			*/
 +			if (pagecache_folio)
 +				folio_unlock(pagecache_folio);
  			/*
  			 * Drop hugetlb_fault_mutex and vma_lock before
  			 * unmapping.  unmapping needs to hold vma_lock
 @@ -6825,7 +6831,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
  	spin_unlock(vmf.ptl);
 
  	if (pagecache_folio) {
 -		folio_unlock(pagecache_folio);
 +		/*
 +		 * hugetlb_wp() might have already unlocked pagecache_folio, so
 +		 * skip it if that is the case.
 +		 */
 +		if (folio_test_locked(pagecache_folio))
 +			folio_unlock(pagecache_folio);
  		folio_put(pagecache_folio);
  	}
  out_mutex:

> ---
>  mm/hugetlb.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e3e6ac991b9c..ad54a74aa563 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6115,7 +6115,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
>   * Keep the pte_same checks anyway to make transition from the mutex easier.
>   */
>  static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
> -		       struct vm_fault *vmf)
> +		       struct vm_fault *vmf,
> +		       bool *pagecache_folio_unlocked)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -6212,6 +6213,22 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>  			u32 hash;
>  
>  			folio_put(old_folio);
> +			/*
> +			 * The pagecache_folio needs to be unlocked to avoid
> +			 * deadlock and we won't re-lock it in hugetlb_wp(). The
> +			 * pagecache_folio could be truncated after being
> +			 * unlocked. So its state should not be relied
> +			 * subsequently.
> +			 *
> +			 * Setting *pagecache_folio_unlocked to true allows the
> +			 * caller to handle any necessary logic related to the
> +			 * folio's unlocked state.
> +			 */
> +			if (pagecache_folio) {
> +				folio_unlock(pagecache_folio);
> +				if (pagecache_folio_unlocked)
> +					*pagecache_folio_unlocked = true;
> +			}
>  			/*
>  			 * Drop hugetlb_fault_mutex and vma_lock before
>  			 * unmapping.  unmapping needs to hold vma_lock
> @@ -6566,7 +6583,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>  	hugetlb_count_add(pages_per_huge_page(h), mm);
>  	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
>  		/* Optimization, do the COW without a second fault */
> -		ret = hugetlb_wp(folio, vmf);
> +		ret = hugetlb_wp(folio, vmf, NULL);
>  	}
>  
>  	spin_unlock(vmf->ptl);
> @@ -6638,6 +6655,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	struct hstate *h = hstate_vma(vma);
>  	struct address_space *mapping;
>  	int need_wait_lock = 0;
> +	bool pagecache_folio_unlocked = false;
>  	struct vm_fault vmf = {
>  		.vma = vma,
>  		.address = address & huge_page_mask(h),
> @@ -6792,7 +6810,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>  		if (!huge_pte_write(vmf.orig_pte)) {
> -			ret = hugetlb_wp(pagecache_folio, &vmf);
> +			ret = hugetlb_wp(pagecache_folio, &vmf,
> +					&pagecache_folio_unlocked);
>  			goto out_put_page;
>  		} else if (likely(flags & FAULT_FLAG_WRITE)) {
>  			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
> @@ -6809,10 +6828,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  out_ptl:
>  	spin_unlock(vmf.ptl);
>  
> -	if (pagecache_folio) {
> +	/*
> +	 * If the pagecache_folio is unlocked in hugetlb_wp(), we skip
> +	 * folio_unlock() here.
> +	 */
> +	if (pagecache_folio && !pagecache_folio_unlocked)
>  		folio_unlock(pagecache_folio);
> +	if (pagecache_folio)
>  		folio_put(pagecache_folio);
> -	}
>  out_mutex:
>  	hugetlb_vma_unlock_read(vma);
>  
> 
> base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
> -- 
> 2.43.0
> 
> 

-- 
Oscar Salvador
SUSE Labs

