Return-Path: <stable+bounces-150629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4146CACBC5C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 22:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF53161EA9
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 20:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DED20C031;
	Mon,  2 Jun 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFaITMWf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F21AA786
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896465; cv=none; b=UZHy8ipupR5OYqGITi6MTTksDUO5CBfGc8FDddGLd/ENzIbYheXv+5huZvUa1nY14F68Z08906oFlEOvLSvxhfu+y8YtyGqzkKpvrlwCtV8IxjUC4cZHba76ySxCBVfGLdKyik6edX6xxz8x+al1oNnbQmjM3kLXIbYhEDb0kRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896465; c=relaxed/simple;
	bh=RkvVCL61yQKFBJkxYHdJUQU7ntEcFDDuLLQonhgbzUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHwGjjIiHKPaoAPrPZfTo7OIP59kD9vCldppx23y64/4jg/+gQrYy9p5fpHBWUsh11c1aPNy364SxkrqePJP9qaUh18154eQyBBK92AZ6jpr8vQU7r79Mga8nRQE2HLdCodwfRo7FGj4Zy8vfJPdhi+bLLtB+IB+oWnaQPLlCTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFaITMWf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748896462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HG1FlZp/JYWfFVMaM74f8RK6Xap63I2K8CkMFS8DVkU=;
	b=VFaITMWfOnHLV6F6/C4eZMFwuNhmiW6WpVAUw1NoNVghRGZbQyDtbpFuulO4TWP+eKH7AF
	eJ6ppaWEsM1lix8i7/dgxnTVtrmzlmn9ToZvaTWumCsQ1XhbbWCzI2BfBEa0F2YFuUXinn
	V6MrU8aelwbZ4Ix+k+ow6arq/Tvq7to=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-DAtr-XokPCq979uo6bYpRQ-1; Mon, 02 Jun 2025 16:34:22 -0400
X-MC-Unique: DAtr-XokPCq979uo6bYpRQ-1
X-Mimecast-MFC-AGG-ID: DAtr-XokPCq979uo6bYpRQ_1748896461
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fad08209f5so86654346d6.3
        for <stable@vger.kernel.org>; Mon, 02 Jun 2025 13:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748896461; x=1749501261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG1FlZp/JYWfFVMaM74f8RK6Xap63I2K8CkMFS8DVkU=;
        b=i/liSlT9KTw1iLKW+SjgiAZyjzAMJ5fheFOf7BKa05xTtxcvTwvMKt7wGfq3qaUQDi
         ZoEPanQLEw1dSQnI081iuw1N/9rAgiozxqgWKgjaag6C1tX4lBLLrIqZy7OxWEijTeP1
         WKFmBBmFCHVy1kBUMdhgehZcWP95KE0VyslJ19av57b2J82Xwt9feV8wv5WD1XZKIDQ7
         edbBR5YP7MpC/OCiQYIBluBF2iBovrM6quN6217TIPWSvPXqcIj1K2lmDiSNc99DDNGv
         pvPmEj+CT1051fLzY3yPrGluMmZy1VPA9YjchU80MKWlAyM5Zki8wsqH6/MKqF1mRyWa
         8f5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMl6XSggFkm5QHqEKPzWNrQkPN3Xgwsr2USZndexR5gZIzSo89naLIni+LGLFknwFw4SOmtdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9NH1Se7i/Lvk5CLqhDJ8dC/+9Y5rXsqhNjs5cTojsOQ+pLIy
	8t7UZ9JRycH+uag5rCaYhP/RHrAx3KaxOF7E6KeTeWX70zuiREzsOL/yMfLXfUdQrY50NoAgpTT
	zM/Crq9OXDyuQOnzvVb7GhzInrlwTr4TUrEoWDSjLIcnxJldrDiYFCNDquWcq2RYc+Q==
X-Gm-Gg: ASbGncutCtc38zlkuOP2+yd9qfoc4EdQxrbhfLVY3B8O0xlFQslgyIjc33yLsOXeA0M
	iBMxKLAZ1qIEyIH6fRlpPQqmELzCwBnLe8HjqeqOcNPf75WTXtmDnvKG0h7hiJnZaBcMd42QyTS
	gc1dLZpMGz0ftRxj+Pr8/8gS7EPb1IcGxHuc2VkrhfWVs35Y40U3PTbXZaXfv5iDHSG7MhKwtQr
	9VjUwwWn6IqLGj1OVIQE1iRUq+wtnTNZr3srW5d6HVJRNr2vwyMXDrb01jrRd5DIeYfQGisEGPO
	VXuFdFReI3PF2Q==
X-Received: by 2002:ad4:5be8:0:b0:6fa:cb97:9722 with SMTP id 6a1803df08f44-6fad1a7094cmr243845416d6.34.1748896461206;
        Mon, 02 Jun 2025 13:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyWuOtHzhzC4FqXUSZyEiBDumezo4F5LexvCZMNuuYmdPwR2gUsLwzi8/flISRy75TRlb+9w==
X-Received: by 2002:ad4:5be8:0:b0:6fa:cb97:9722 with SMTP id 6a1803df08f44-6fad1a7094cmr243844886d6.34.1748896460706;
        Mon, 02 Jun 2025 13:34:20 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e1a6dbsm66570076d6.95.2025.06.02.13.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 13:34:20 -0700 (PDT)
Date: Mon, 2 Jun 2025 16:34:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: userfaultfd: fix race of userfaultfd_move and
 swap cache
Message-ID: <aD4KyHz_H5WPLLf4@x1.local>
References: <20250602181419.20478-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250602181419.20478-1-ryncsn@gmail.com>

On Tue, Jun 03, 2025 at 02:14:19AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> On seeing a swap entry PTE, userfaultfd_move does a lockless swap cache
> lookup, and try to move the found folio to the faulting vma when.
> Currently, it relies on the PTE value check to ensure the moved folio
> still belongs to the src swap entry, which turns out is not reliable.
> 
> While working and reviewing the swap table series with Barry, following
> existing race is observed and reproduced [1]:
> 
> ( move_pages_pte is moving src_pte to dst_pte, where src_pte is a
>  swap entry PTE holding swap entry S1, and S1 isn't in the swap cache.)
> 
> CPU1                               CPU2
> userfaultfd_move
>   move_pages_pte()
>     entry = pte_to_swp_entry(orig_src_pte);
>     // Here it got entry = S1
>     ... < Somehow interrupted> ...
>                                    <swapin src_pte, alloc and use folio A>
>                                    // folio A is just a new allocated folio
>                                    // and get installed into src_pte
>                                    <frees swap entry S1>
>                                    // src_pte now points to folio A, S1
>                                    // has swap count == 0, it can be freed
>                                    // by folio_swap_swap or swap
>                                    // allocator's reclaim.
>                                    <try to swap out another folio B>
>                                    // folio B is a folio in another VMA.
>                                    <put folio B to swap cache using S1 >
>                                    // S1 is freed, folio B could use it
>                                    // for swap out with no problem.
>                                    ...
>     folio = filemap_get_folio(S1)
>     // Got folio B here !!!
>     ... < Somehow interrupted again> ...
>                                    <swapin folio B and free S1>
>                                    // Now S1 is free to be used again.
>                                    <swapout src_pte & folio A using S1>
>                                    // Now src_pte is a swap entry pte
>                                    // holding S1 again.
>     folio_trylock(folio)
>     move_swap_pte
>       double_pt_lock
>       is_pte_pages_stable
>       // Check passed because src_pte == S1
>       folio_move_anon_rmap(...)
>       // Moved invalid folio B here !!!
> 
> The race window is very short and requires multiple collisions of
> multiple rare events, so it's very unlikely to happen, but with a
> deliberately constructed reproducer and increased time window, it can be
> reproduced [1].
> 
> It's also possible that folio (A) is swapped in, and swapped out again
> after the filemap_get_folio lookup, in such case folio (A) may stay in
> swap cache so it needs to be moved too. In this case we should also try
> again so kernel won't miss a folio move.
> 
> Fix this by checking if the folio is the valid swap cache folio after
> acquiring the folio lock, and checking the swap cache again after
> acquiring the src_pte lock.
> 
> SWP_SYNCRHONIZE_IO path does make the problem more complex, but so far
> we don't need to worry about that since folios only might get exposed to
> swap cache in the swap out path, and it's covered in this patch too by
> checking the swap cache again after acquiring src_pte lock.

[1]

> 
> Testing with a simple C program to allocate and move several GB of memory
> did not show any observable performance change.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=6OOrK2OUZ0-tqCzi+EJt+2_K97TPGoSt=9+JwP7Q@mail.gmail.com/ [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>
> 
> ---
> 
> V1: https://lore.kernel.org/linux-mm/20250530201710.81365-1-ryncsn@gmail.com/
> Changes:
> - Check swap_map instead of doing a filemap lookup after acquiring the
>   PTE lock to minimize critical section overhead [ Barry Song, Lokesh Gidra ]
> 
> V2: https://lore.kernel.org/linux-mm/20250601200108.23186-1-ryncsn@gmail.com/
> Changes:
> - Move the folio and swap check inside move_swap_pte to avoid skipping
>   the check and potential overhead [ Lokesh Gidra ]
> - Add a READ_ONCE for the swap_map read to ensure it reads a up to dated
>   value.
> 
>  mm/userfaultfd.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index bc473ad21202..5dc05346e360 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1084,8 +1084,18 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
>  			 pte_t orig_dst_pte, pte_t orig_src_pte,
>  			 pmd_t *dst_pmd, pmd_t dst_pmdval,
>  			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
> -			 struct folio *src_folio)
> +			 struct folio *src_folio,
> +			 struct swap_info_struct *si, swp_entry_t entry)
>  {
> +	/*
> +	 * Check if the folio still belongs to the target swap entry after
> +	 * acquiring the lock. Folio can be freed in the swap cache while
> +	 * not locked.
> +	 */
> +	if (src_folio && unlikely(!folio_test_swapcache(src_folio) ||
> +				  entry.val != src_folio->swap.val))
> +		return -EAGAIN;
> +
>  	double_pt_lock(dst_ptl, src_ptl);
>  
>  	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
> @@ -1102,6 +1112,15 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
>  	if (src_folio) {
>  		folio_move_anon_rmap(src_folio, dst_vma);
>  		src_folio->index = linear_page_index(dst_vma, dst_addr);
> +	} else {
> +		/*
> +		 * Check if the swap entry is cached after acquiring the src_pte
> +		 * lock. Or we might miss a new loaded swap cache folio.
> +		 */
> +		if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE) {

Do we need data_race() for this, if this is an intentionally lockless read?

Another pure swap question: the comment seems to imply this whole thing is
protected by src_pte lock, but is it?

I'm not familiar enough with swap code, but it looks to me the folio can be
added into swap cache and set swap_map[] with SWAP_HAS_CACHE as long as the
folio is locked.  It doesn't seem to be directly protected by pgtable lock.

Perhaps you meant this: since src_pte lock is held, then it'll serialize
with another thread B concurrently swap-in the swap entry, but only _later_
when thread B's do_swap_page() will check again on pte_same(), then it'll
see the src pte gone (after thread A uffdio_move happened releasing src_pte
lock), hence thread B will release the newly allocated swap cache folio?

There's another trivial detail that IIUC pte_same() must fail because
before/after the uffdio_move the swap entry will be occupied so no way to
have it reused, hence src_pte, even if re-populated again after uffdio_move
succeeded, cannot become the orig_pte (points to the swap entry in
question) that thread B read, hence pte_same() must check fail.

I'm not sure my understanding is correct, though.  Maybe some richer
comment would always help.

Thanks,

> +			double_pt_unlock(dst_ptl, src_ptl);
> +			return -EAGAIN;
> +		}
>  	}
>  
>  	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
> @@ -1412,7 +1431,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  		}
>  		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
>  				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
> -				dst_ptl, src_ptl, src_folio);
> +				dst_ptl, src_ptl, src_folio, si, entry);
>  	}
>  
>  out:
> -- 
> 2.49.0
> 
> 

-- 
Peter Xu


