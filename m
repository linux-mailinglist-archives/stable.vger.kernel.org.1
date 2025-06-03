Return-Path: <stable+bounces-150729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BBAACCB68
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3C716C912
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230519C558;
	Tue,  3 Jun 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTGCW58v"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6419D06A
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748968930; cv=none; b=GuATN/RV92jA24Hl7PpPrzWts5zrYgSK27Fk+8pN8I/ybMC3hJq5K/jj3vsjgR9p6Vf8eDZXUyN02XDpQdqaxOy+yigEvMxztu+BtCjACOT44e2QYpvLCxWoDoEQTCZl05cuRXJNqWK7qtjqXtZk/Iy9r9dBJW/QDArsvG9WXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748968930; c=relaxed/simple;
	bh=zrKNirMsdjziCcAGApD/8ntDTx6uQnaRHnHcj6e/C6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD4DA37y5wn46gCBvaVrzkLY6IKz4ZKRrn5uUGqlBXAxrdLhUj5rNnTw0N8vivZOXJscqY3QU9vpYAWG8ksSf5yxqkI/Q5c87Y963LVhmA2xvJoQxPu9c/AupAEZBPSuxA2b43KtHLnFQpq7xtlPmoqS7b7F2ZAhNddIoPdokGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTGCW58v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748968927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XW5iA+IcoMvqOf0ndcrgPMgu4TWbTOSU4Ckyq0Vi+RE=;
	b=CTGCW58vP4drg/zcLkrf/GXhq0MbaxtDA4fNHKJObZ5G6CaxvUVb1IBEp0WxjrTzP0Z+Tx
	zeCAW9eauvev8oog7QkUFOGFz9bJMxekAs+p+KcF8n7keKZYeSnLypIUV6JUaJlXMSuJDz
	0ksjr+m67QQU5G+mm3zX+RIrNpLLiPc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-O-iU5r8YOa2iSVJ0YzTjfQ-1; Tue, 03 Jun 2025 12:42:05 -0400
X-MC-Unique: O-iU5r8YOa2iSVJ0YzTjfQ-1
X-Mimecast-MFC-AGG-ID: O-iU5r8YOa2iSVJ0YzTjfQ_1748968925
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d2107d6b30so165393585a.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 09:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748968925; x=1749573725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XW5iA+IcoMvqOf0ndcrgPMgu4TWbTOSU4Ckyq0Vi+RE=;
        b=Rq5voPkTm+ms+pTsjyl80bI+IOqTDNfQQ/XmydLygjIDUgl+daeM/MkAKls0yU8d/X
         7cLTgKXWk7nNZerrbe6VkIk+dFFErDIxt789UaAH9QmRTihv5DmYHB7q0FB/7R3tlUnk
         nKB4AGpnE5wlT7ZCyGV4rwuLIO1SQ9qCuvLoBT4vNC1SgmIVV8PjF+R8LSnDw41pVAXW
         qBXRYPSKA3qDVcr/vsN+4TEVt8jR+afUinrB8fMHOscHRZfXdET2Ac3QnzipUPyQqILD
         MHdOf5C5kUKt81NUv8qkHArQWROuuQ+vloK8gVDZihXu1jAHxPtwr1NMA/1SvtwHZZda
         fXiA==
X-Forwarded-Encrypted: i=1; AJvYcCUJtPX606ytlHgFM86Y6B2yo6I6BJ0LHxfh53Yf1ZnWA8q8JyZ4rlSLaCz7fAOyAUPsETjvBYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9L3Pw6ej7k4oaTtNZrHeYO9CqcMBdAP1V6ehdhxsjhYDcbWtJ
	0ZWV7rIWsW2xzFUlwn2alA0zIcMDpNvO/sNMDKL7gLclge0o586NFk75l2o+YDgbPYYW1QQFvtF
	IbNW2pdKd9GamDJdiMaVM+dFT3/H/ZZcqlm5grUkOBj5quoLUqr9Tg6SciQ==
X-Gm-Gg: ASbGncsMQJrkPR3DtxdqIVLDLOlfcYjvLb6Ng9YIyCiwSfYDZWE6kbM6mD2Eb1++PPs
	vxfK+jct+kb6dqWVBAcOZDtZQEg+uN+ECD6UTw2tBmKtDdcv74uuXSx3Vfk1m3JBW0xHYdw54mH
	In8M6xJKi2Zcw/YlR99ehPn31ME+PO7Wx4NCbrVaWeAL6Ma/HljvzCJq83iUULI2h1y7nw/gZ1I
	MiAfKGuOsMkm9dbn/9RdpVXphQDLXzIC2quzTRkSMy0xBjPOvemGQYR7eM2IbZV2F8r3YkWabQv
	mcJntSNeayxIkA==
X-Received: by 2002:a05:620a:190c:b0:7d0:9da7:6941 with SMTP id af79cd13be357-7d0a201df56mr2833923385a.37.1748968924978;
        Tue, 03 Jun 2025 09:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNlgjeVsUhFeMqMzPsr8hOvznmRm5eUNpcsj+yPaaFc3gu0L6wkGYTMZrQGhj5zHFGM43GxA==
X-Received: by 2002:a05:620a:190c:b0:7d0:9da7:6941 with SMTP id af79cd13be357-7d0a201df56mr2833919985a.37.1748968924554;
        Tue, 03 Jun 2025 09:42:04 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d33901sm82985226d6.18.2025.06.03.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 09:42:04 -0700 (PDT)
Date: Tue, 3 Jun 2025 12:42:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: userfaultfd: fix race of userfaultfd_move and
 swap cache
Message-ID: <aD8l2ajsoAyAmonu@x1.local>
References: <20250602181419.20478-1-ryncsn@gmail.com>
 <aD4KyHz_H5WPLLf4@x1.local>
 <CAGsJ_4wbU=4ECxNPEB0dKGXibrAKuR-N3i8wwmVCYAgWCuupnQ@mail.gmail.com>
 <CAMgjq7C_nVynRpMV8xkyVuhpyDY6qZX_ShzxChen5Fh5gXSJVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7C_nVynRpMV8xkyVuhpyDY6qZX_ShzxChen5Fh5gXSJVg@mail.gmail.com>

On Tue, Jun 03, 2025 at 07:48:49PM +0800, Kairui Song wrote:
> On Tue, Jun 3, 2025 at 6:08 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Tue, Jun 3, 2025 at 8:34 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Tue, Jun 03, 2025 at 02:14:19AM +0800, Kairui Song wrote:
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > On seeing a swap entry PTE, userfaultfd_move does a lockless swap cache
> > > > lookup, and try to move the found folio to the faulting vma when.
> > > > Currently, it relies on the PTE value check to ensure the moved folio
> > > > still belongs to the src swap entry, which turns out is not reliable.
> > > >
> > > > While working and reviewing the swap table series with Barry, following
> > > > existing race is observed and reproduced [1]:
> > > >
> > > > ( move_pages_pte is moving src_pte to dst_pte, where src_pte is a
> > > >  swap entry PTE holding swap entry S1, and S1 isn't in the swap cache.)
> > > >
> > > > CPU1                               CPU2
> > > > userfaultfd_move
> > > >   move_pages_pte()
> > > >     entry = pte_to_swp_entry(orig_src_pte);
> > > >     // Here it got entry = S1
> > > >     ... < Somehow interrupted> ...
> > > >                                    <swapin src_pte, alloc and use folio A>
> > > >                                    // folio A is just a new allocated folio
> > > >                                    // and get installed into src_pte
> > > >                                    <frees swap entry S1>
> > > >                                    // src_pte now points to folio A, S1
> > > >                                    // has swap count == 0, it can be freed
> > > >                                    // by folio_swap_swap or swap
> > > >                                    // allocator's reclaim.
> > > >                                    <try to swap out another folio B>
> > > >                                    // folio B is a folio in another VMA.
> > > >                                    <put folio B to swap cache using S1 >
> > > >                                    // S1 is freed, folio B could use it
> > > >                                    // for swap out with no problem.
> > > >                                    ...
> > > >     folio = filemap_get_folio(S1)
> > > >     // Got folio B here !!!
> > > >     ... < Somehow interrupted again> ...
> > > >                                    <swapin folio B and free S1>
> > > >                                    // Now S1 is free to be used again.
> > > >                                    <swapout src_pte & folio A using S1>
> > > >                                    // Now src_pte is a swap entry pte
> > > >                                    // holding S1 again.
> > > >     folio_trylock(folio)
> > > >     move_swap_pte
> > > >       double_pt_lock
> > > >       is_pte_pages_stable
> > > >       // Check passed because src_pte == S1
> > > >       folio_move_anon_rmap(...)
> > > >       // Moved invalid folio B here !!!
> > > >
> > > > The race window is very short and requires multiple collisions of
> > > > multiple rare events, so it's very unlikely to happen, but with a
> > > > deliberately constructed reproducer and increased time window, it can be
> > > > reproduced [1].
> > > >
> > > > It's also possible that folio (A) is swapped in, and swapped out again
> > > > after the filemap_get_folio lookup, in such case folio (A) may stay in
> > > > swap cache so it needs to be moved too. In this case we should also try
> > > > again so kernel won't miss a folio move.
> > > >
> > > > Fix this by checking if the folio is the valid swap cache folio after
> > > > acquiring the folio lock, and checking the swap cache again after
> > > > acquiring the src_pte lock.
> > > >
> > > > SWP_SYNCRHONIZE_IO path does make the problem more complex, but so far
> > > > we don't need to worry about that since folios only might get exposed to
> > > > swap cache in the swap out path, and it's covered in this patch too by
> > > > checking the swap cache again after acquiring src_pte lock.
> > >
> > > [1]
> > >
> > > >
> > > > Testing with a simple C program to allocate and move several GB of memory
> > > > did not show any observable performance change.
> > > >
> > > > Cc: <stable@vger.kernel.org>
> > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=6OOrK2OUZ0-tqCzi+EJt+2_K97TPGoSt=9+JwP7Q@mail.gmail.com/ [1]
> > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > >
> > > > ---
> > > >
> > > > V1: https://lore.kernel.org/linux-mm/20250530201710.81365-1-ryncsn@gmail.com/
> > > > Changes:
> > > > - Check swap_map instead of doing a filemap lookup after acquiring the
> > > >   PTE lock to minimize critical section overhead [ Barry Song, Lokesh Gidra ]
> > > >
> > > > V2: https://lore.kernel.org/linux-mm/20250601200108.23186-1-ryncsn@gmail.com/
> > > > Changes:
> > > > - Move the folio and swap check inside move_swap_pte to avoid skipping
> > > >   the check and potential overhead [ Lokesh Gidra ]
> > > > - Add a READ_ONCE for the swap_map read to ensure it reads a up to dated
> > > >   value.
> > > >
> > > >  mm/userfaultfd.c | 23 +++++++++++++++++++++--
> > > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index bc473ad21202..5dc05346e360 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -1084,8 +1084,18 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
> > > >                        pte_t orig_dst_pte, pte_t orig_src_pte,
> > > >                        pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > >                        spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > > > -                      struct folio *src_folio)
> > > > +                      struct folio *src_folio,
> > > > +                      struct swap_info_struct *si, swp_entry_t entry)
> > > >  {
> > > > +     /*
> > > > +      * Check if the folio still belongs to the target swap entry after
> > > > +      * acquiring the lock. Folio can be freed in the swap cache while
> > > > +      * not locked.
> > > > +      */
> > > > +     if (src_folio && unlikely(!folio_test_swapcache(src_folio) ||
> > > > +                               entry.val != src_folio->swap.val))
> > > > +             return -EAGAIN;
> > > > +
> > > >       double_pt_lock(dst_ptl, src_ptl);
> > > >
> > > >       if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
> > > > @@ -1102,6 +1112,15 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
> > > >       if (src_folio) {
> > > >               folio_move_anon_rmap(src_folio, dst_vma);
> > > >               src_folio->index = linear_page_index(dst_vma, dst_addr);
> > > > +     } else {
> > > > +             /*
> > > > +              * Check if the swap entry is cached after acquiring the src_pte
> > > > +              * lock. Or we might miss a new loaded swap cache folio.
> > > > +              */
> > > > +             if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE) {
> > >
> > > Do we need data_race() for this, if this is an intentionally lockless read?
> >
> > Not entirely sure. But I recommend this pattern, borrowed from

AFAIU data_race() is only for KCSAN.  READ_ONCE/WRITE_ONCE will also be
needed.  The doc actually explicitly mentioned this case:

/*
 * ...
 * be atomic *and* KCSAN should ignore the access, use both data_race()
 * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
 */
#define data_race(expr)							\

I'm ok if there're existing references of swap_map[], so even if it's good
to have data_race() we can do that later until someone complains at all the
spots..

> > zap_nonpresent_ptes() -> free_swap_and_cache_nr(),
> > where the PTL is also held and READ_ONCE is used.
> >
> >                 if (READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
> >                        ..
> >                         nr = __try_to_reclaim_swap(si, offset,
> >                                                    TTRS_UNMAPPED | TTRS_FULL);
> >
> >                         if (nr == 0)
> >                                 nr = 1;
> >                         else if (nr < 0)
> >                                 nr = -nr;
> >                         nr = ALIGN(offset + 1, nr) - offset;
> >                 }
> 
> Thanks for the explanation, I also agree that holding PTL here is good
> enough here.
> 
> >
> > I think we could use this to further optimize the existing
> > filemap_get_folio(), since in the vast majority of cases we don't
> > have a swapcache, yet we still always call filemap_get_folio().
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index bc473ad21202..c527ec73c3b4 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> >
> > @@ -1388,7 +1388,7 @@ static int move_pages_pte(struct mm_struct *mm,
> > pmd_t *dst_pmd, pmd_t *src_pmd,
> >                  * folios in the swapcache. This issue needs to be resolved
> >                  * separately to allow proper handling.
> >                  */
> >
> > -               if (!src_folio)
> > +               if (!src_folio & (swap_map[offset] & SWAP_HAS_CACHE))
> >                         folio = filemap_get_folio(swap_address_space(entry),
> >                                         swap_cache_index(entry));
> >                 if (!IS_ERR_OR_NULL(folio)) {
> >
> > To be future-proof, we may want to keep the READ_ONCE to ensure
> > the compiler doesn't skip the second read inside move_swap_pte().
> 
> Maybe we can do this optimization in another patch I think.
> 
> >
> > >
> > > Another pure swap question: the comment seems to imply this whole thing is
> > > protected by src_pte lock, but is it?
> > >
> > > I'm not familiar enough with swap code, but it looks to me the folio can be
> > > added into swap cache and set swap_map[] with SWAP_HAS_CACHE as long as the
> > > folio is locked.  It doesn't seem to be directly protected by pgtable lock.
> > >
> > > Perhaps you meant this: since src_pte lock is held, then it'll serialize
> > > with another thread B concurrently swap-in the swap entry, but only _later_
> > > when thread B's do_swap_page() will check again on pte_same(), then it'll
> > > see the src pte gone (after thread A uffdio_move happened releasing src_pte
> > > lock), hence thread B will release the newly allocated swap cache folio?
> > >
> > > There's another trivial detail that IIUC pte_same() must fail because
> > > before/after the uffdio_move the swap entry will be occupied so no way to
> > > have it reused, hence src_pte, even if re-populated again after uffdio_move
> > > succeeded, cannot become the orig_pte (points to the swap entry in
> > > question) that thread B read, hence pte_same() must check fail.
> >
> > in v1 of this patch, we had some similar discussions [1][2]:
> >
> > [1] https://lore.kernel.org/linux-mm/CAGsJ_4wBMxQSeoTwpKoWwEGRAr=iohbYf64aYyJ55t0Z11FkwA@mail.gmail.com/
> > [2] https://lore.kernel.org/linux-mm/CAGsJ_4wM8Tph0Mbc-1Y9xNjgMPL7gqEjp=ArBuv3cJijHVXe6w@mail.gmail.com/
> >
> > At the very least, [2] is possible, although the probability is extremely low.
> >
> > "It seems also possible for the sync zRAM device.
> >
> >  step 1: src pte points to a swap entry S without swapcache
> >  step 2: we call move_swap_pte()
> >  step 3: someone swap-in src_pte by sync path, no swapcache; swap slot
> > S is freed.
> >              -- for zRAM;
> >  step 4: someone swap-out src_pte, get the exactly same swap slot S as step 1,
> >              adds folio to swapcache due to swapout;
> >  step 5: move_swap_pte() gets ptl and finds page tables are stable
> > since swap-out
> >              happens to have the same swap slot as step1;
> >  step 6: we clear src_pte, move src_pte to dst_pte; but miss to move the folio.
> >
> > Yep, we really need to re-check pte for swapcache after holding PTL.
> > "
> >
> > Personally, I agree that improving the changelog or the comments
> > would be more helpful. In fact, there are two bugs here, and Kairui’s
> > changelog clearly describes the first one.
> 
> Yeah, the first one is quite a long and complex race already, so I
> made the description on the second issue shorter. I thought it
> wouldn't be too difficult to understand given the first example. I can
> add some more details.

IMHO it's not about how the race happens that is hard to follow.  To me,
it's harder to follow on how src_pte lock can prove READ_ONCE() of
swap_map[] is valid.  Especially, on why it's okay to read even false
negative (relies on the other thread retry properly in do_swap_page).

It'll be much appreciated if you could add something into either comments
or git commit message on this. Maybe a link to this specific lore
discussion (or v1's) would be helpful.

Thanks,

-- 
Peter Xu


