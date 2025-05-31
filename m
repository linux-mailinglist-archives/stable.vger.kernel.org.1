Return-Path: <stable+bounces-148338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D475AAC9947
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 06:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566FE4E114B
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 04:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D728D823;
	Sat, 31 May 2025 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnktmMBA"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1828CF4C;
	Sat, 31 May 2025 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748666529; cv=none; b=QJP9A0vyEpfpDZc9CXwDbWDVPmtdDvNLbecLMBeE7ozsv44kfB5EKyY3oqL4DK9M4UB7tci2TYxJso8rCa0vMhTNlzg6g8LBXc24p9ohFfyNllJ+6BVUNF+lqslsyMyJpOlLiNDZ+PNvVTqASv0bD8jtNowjX3VRF6qQ5kXlNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748666529; c=relaxed/simple;
	bh=VGqXujUi9yFx/a/hYVK6eAXwihXUAVub5lzgM1XcGr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvtQcsD6uSJ56R4jhXfOheWkKbaeuroM/xf9MuZB258bjcElHuZhUgwyiaggxusMoLI2TFOWjrMwx3vKmmXtgMDpRRQRUoxSe6OR8UNIiwuT9e14LQbGxEY+1iJRU+3ZH9yYCsBF3SkcOZhbsFqpjB48mxQSLaKjkpVRpb4r74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnktmMBA; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4c4fa0bfca2so845537137.0;
        Fri, 30 May 2025 21:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748666526; x=1749271326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9EBOQZoadO8Tdn5XLSCzKniJvmsxChEl4wEsHQNLR0=;
        b=WnktmMBAz87QmMvrZqzULxb1+GnXycFlLoJtR2kPhxtLxJhDvEC197L28sLJGNeWhr
         DtVN+LL2w4YSDwt/u9rvGggy9J4WAGWIHzzlyBfPdiFY65XOqeRdHP2XEekfCRv1DAAH
         lkjzW1+hzHt6egbP83amRVe+j4ZPfr2GhZcKt8tKsTLKKp+CXLXnA1fnc3aAoWVZla5+
         KGkAMZYHsyE9qV5oZCkYetLr43vNaDmwMUKwRdoQBp6y0HDP8qkoudX2gYbh/FmaN2uG
         ya82RspOlBZ1Xeq6DYMKm6NrXsDfCXHNaFUEMQIS2o+S5lYPAzj/p3OxsxSTbxjxZkZ2
         NN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748666526; x=1749271326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9EBOQZoadO8Tdn5XLSCzKniJvmsxChEl4wEsHQNLR0=;
        b=ZsA3aRWjBDDWxr9w2sFOGKVQGY73VAQUpGV3sF2tKIieuAoCzK9dPNqK5s2gBbzboD
         8Hzpi3eFdiu+53Spm5U1PCjgC49VZauRG1pDlz2GmOH5zhG9+Ju5M5FyK078biI1v3++
         PnPEPnPAtE9iNlHtxQlGQFew10qw+52IKcapwRpsaz2a92fR0kAqRB/vC/RJB0XstbaV
         s1GS97e4t5HhjCBd8pxvJK2hIa7SRdzcP6c4lEMWbQLGZCdsxVXUNutPwZdf7dQ0IGYp
         fhcBoR0OEOk1OICkO3NE/ly6eKVlPFl24QlJtyaPRhmSTLa9QhKIHNpaNlmAGW+pHh5l
         NBHw==
X-Forwarded-Encrypted: i=1; AJvYcCUhJhf02ZJpOKRbl3YPwObHGckPHTNNKX5pWgdBXUOBmVwnbI+VSDvNuAr8waPAlCxRCxztZvle@vger.kernel.org, AJvYcCWGDjyHovYlQiUTi/B+kdCUWMLSPaLujulHwoUy3MG3HzT5kO93nFHLF3o0bbFfHCvKRkjyYKkDRUzQCl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVoN6/T+ZmgVDbbq0kq04e3Ree2Lhgl27jCKZbtuhks5gUbhM
	KiONo8deZCdaIzt7RzIUp4GpaRpC4kA2PPz73wOlFmyc4olSjDtnKs97rQBiVlp0Q10Ocw4XvPq
	RdheuW4qeEEiwCabbG/0yrSCFui0amHQ=
X-Gm-Gg: ASbGncsH2q+evnexzi51XZyFzK8eZQJQ0uwmvvsUu8kmgRWKEKYIeClLkG3jZm8Ti5E
	CG4p7Rm8fZOj7IIvrROQHH0XiIeD7ZOzonHeorVBFjDKkSFYTQWhN0uuhcEETiQa4WaanyHnWdl
	Hcksmkr5QGNJEd8knXsNkCXJzp/F9k6f4rYw==
X-Google-Smtp-Source: AGHT+IEZt3bmd4/+ChkCUkHgAFdPa9qd/ctYAKrj6kzFX3PgCnevvFkD585y/++RKRQweFgx95IXcjH2OZjWEoc2ag4=
X-Received: by 2002:a05:6102:358d:b0:4c1:992c:b95d with SMTP id
 ada2fe7eead31-4e701bae866mr309508137.17.1748666525967; Fri, 30 May 2025
 21:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CAGsJ_4wBMxQSeoTwpKoWwEGRAr=iohbYf64aYyJ55t0Z11FkwA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wBMxQSeoTwpKoWwEGRAr=iohbYf64aYyJ55t0Z11FkwA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 May 2025 16:41:54 +1200
X-Gm-Features: AX0GCFukT232aOA-NzZjeQ0scZe458Zm-uPbRRQUphoV6tAN2n8wvIXgiMZah0o
Message-ID: <CAGsJ_4wM8Tph0Mbc-1Y9xNjgMPL7gqEjp=ArBuv3cJijHVXe6w@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 4:04=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sat, May 31, 2025 at 8:17=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > On seeing a swap entry PTE, userfaultfd_move does a lockless swap cache
> > lookup, and try to move the found folio to the faulting vma when.
> > Currently, it relies on the PTE value check to ensure the moved folio
> > still belongs to the src swap entry, which turns out is not reliable.
> >
> > While working and reviewing the swap table series with Barry, following
> > existing race is observed and reproduced [1]:
> >
> > ( move_pages_pte is moving src_pte to dst_pte, where src_pte is a
> >  swap entry PTE holding swap entry S1, and S1 isn't in the swap cache.)
> >
> > CPU1                               CPU2
> > userfaultfd_move
> >   move_pages_pte()
> >     entry =3D pte_to_swp_entry(orig_src_pte);
> >     // Here it got entry =3D S1
> >     ... < Somehow interrupted> ...
> >                                    <swapin src_pte, alloc and use folio=
 A>
> >                                    // folio A is just a new allocated f=
olio
> >                                    // and get installed into src_pte
> >                                    <frees swap entry S1>
> >                                    // src_pte now points to folio A, S1
> >                                    // has swap count =3D=3D 0, it can b=
e freed
> >                                    // by folio_swap_swap or swap
> >                                    // allocator's reclaim.
> >                                    <try to swap out another folio B>
> >                                    // folio B is a folio in another VMA=
.
> >                                    <put folio B to swap cache using S1 =
>
> >                                    // S1 is freed, folio B could use it
> >                                    // for swap out with no problem.
> >                                    ...
> >     folio =3D filemap_get_folio(S1)
> >     // Got folio B here !!!
> >     ... < Somehow interrupted again> ...
> >                                    <swapin folio B and free S1>
> >                                    // Now S1 is free to be used again.
> >                                    <swapout src_pte & folio A using S1>
> >                                    // Now src_pte is a swap entry pte
> >                                    // holding S1 again.
> >     folio_trylock(folio)
> >     move_swap_pte
> >       double_pt_lock
> >       is_pte_pages_stable
> >       // Check passed because src_pte =3D=3D S1
> >       folio_move_anon_rmap(...)
> >       // Moved invalid folio B here !!!
> >
> > The race window is very short and requires multiple collisions of
> > multiple rare events, so it's very unlikely to happen, but with a
> > deliberately constructed reproducer and increased time window, it can b=
e
> > reproduced [1].
> >
> > It's also possible that folio (A) is swapped in, and swapped out again
> > after the filemap_get_folio lookup, in such case folio (A) may stay in
> > swap cache so it needs to be moved too. In this case we should also try
> > again so kernel won't miss a folio move.
> >
> > Fix this by checking if the folio is the valid swap cache folio after
> > acquiring the folio lock, and checking the swap cache again after
> > acquiring the src_pte lock.
> >
> > SWP_SYNCRHONIZE_IO path does make the problem more complex, but so far
> > we don't need to worry about that since folios only might get exposed t=
o
> > swap cache in the swap out path, and it's covered in this patch too by
> > checking the swap cache again after acquiring src_pte lock.
> >
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCzi+=
EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/userfaultfd.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index bc473ad21202..a1564d205dfb 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/mmu_notifier.h>
> >  #include <linux/hugetlb.h>
> >  #include <linux/shmem_fs.h>
> > +#include <linux/delay.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/tlb.h>
> >  #include "internal.h"
> > @@ -1086,6 +1087,8 @@ static int move_swap_pte(struct mm_struct *mm, st=
ruct vm_area_struct *dst_vma,
> >                          spinlock_t *dst_ptl, spinlock_t *src_ptl,
> >                          struct folio *src_folio)
> >  {
> > +       swp_entry_t entry;
> > +
> >         double_pt_lock(dst_ptl, src_ptl);
> >
> >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_s=
rc_pte,
> > @@ -1102,6 +1105,19 @@ static int move_swap_pte(struct mm_struct *mm, s=
truct vm_area_struct *dst_vma,
> >         if (src_folio) {
> >                 folio_move_anon_rmap(src_folio, dst_vma);
> >                 src_folio->index =3D linear_page_index(dst_vma, dst_add=
r);
> > +       } else {
> > +               /*
> > +                * Check again after acquiring the src_pte lock. Or we =
might
> > +                * miss a new loaded swap cache folio.
> > +                */
> > +               entry =3D pte_to_swp_entry(orig_src_pte);
> > +               src_folio =3D filemap_get_folio(swap_address_space(entr=
y),
> > +                                             swap_cache_index(entry));
> > +               if (!IS_ERR_OR_NULL(src_folio)) {
> > +                       double_pt_unlock(dst_ptl, src_ptl);
> > +                       folio_put(src_folio);
> > +                       return -EAGAIN;
> > +               }
> >         }
>
> step 1: src pte points to a swap entry without swapcache
> step 2: we call move_swap_pte()
> step 3: someone swap-in src_pte by swap_readhead() and make src_pte's swa=
p entry
> have swapcache again - for non-sync/non-zRAM swap device;
> step 4: move_swap_pte() gets ptl, move src_pte to dst_pte and *clear* src=
_pte;
> step 5: do_swap_page() for src_pte holds the ptl and found pte has
> been cleared in
>             step 4; pte_same() returns false;
> step 6: do_swap_page() won't map src_pte to the new swapcache got from st=
ep 3;
>             if the swapcache folio is dropped, it seems everything is fin=
e.
>
> So the real issue is that do_swap_page() doesn=E2=80=99t drop the new swa=
pcache
> even when pte_same() returns false? That means the dst_pte swap-in
> can still hit the swap cache entry brought in by the src_pte's swap-in?

It seems also possible for the sync zRAM device.

 step 1: src pte points to a swap entry S without swapcache
 step 2: we call move_swap_pte()
 step 3: someone swap-in src_pte by sync path, no swapcache; swap slot
S is freed.
             -- for zRAM;
 step 4: someone swap-out src_pte, get the exactly same swap slot S as step=
 1,
             adds folio to swapcache due to swapout;
 step 5: move_swap_pte() gets ptl and finds page tables are stable
since swap-out
             happens to have the same swap slot as step1;
 step 6: we clear src_pte, move src_pte to dst_pte; but miss to move the fo=
lio.

Yep, we really need to re-check pte for swapcache after holding PTL.

>
> >
> >         orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> > @@ -1409,6 +1425,16 @@ static int move_pages_pte(struct mm_struct *mm, =
pmd_t *dst_pmd, pmd_t *src_pmd,
> >                                 folio_lock(src_folio);
> >                                 goto retry;
> >                         }
> > +                       /*
> > +                        * Check if the folio still belongs to the targ=
et swap entry after
> > +                        * acquiring the lock. Folio can be freed in th=
e swap cache while
> > +                        * not locked.
> > +                        */
> > +                       if (unlikely(!folio_test_swapcache(folio) ||
> > +                                    entry.val !=3D folio->swap.val)) {
> > +                               err =3D -EAGAIN;
> > +                               goto out;
> > +                       }
> >                 }
> >                 err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr, =
dst_pte, src_pte,
> >                                 orig_dst_pte, orig_src_pte, dst_pmd, ds=
t_pmdval,
> > --
> > 2.49.0
> >
>

Thanks
Barry

