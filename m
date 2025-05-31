Return-Path: <stable+bounces-148340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE5EAC9984
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 08:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6BD9E2641
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 06:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB911DA62E;
	Sat, 31 May 2025 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2fWBcF5G"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54F1A257D
	for <stable@vger.kernel.org>; Sat, 31 May 2025 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748671818; cv=none; b=cPdM6r0GQCyt/RzbdEDGJAqPHScyJzTTYMsFI7GIohPIval/slUwuVtaccWFMd+Rh3v1+66f6f+Qm5j7p0SqvYZjQM4l/RlHXbpXW22qoGl28hiP22Xbjq/Q/pLEoWSA7NIBUM8G0nICpZgFZx7Hm3/NJt8AkWXG3mo39Wjkkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748671818; c=relaxed/simple;
	bh=11HOF3jldTMT25y4t9U07GFBOuxg/CkyYoSDFk/Kdlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGGLxGx22vhotfYj2i9ZvGllbCnrzDVSJUCDjBtzgupNb2nV0k9IaQTmEPcZ24WpbtIrKkaqDh8dqqFpwogp05zMx3SlFLinx02HiDJju6uRtSN4BEztGleIdeh/X2yfn0CPUQ6U4UiUZDaZjjASpWssyYfKamy9yf/3NZ7T6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2fWBcF5G; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so2791a12.1
        for <stable@vger.kernel.org>; Fri, 30 May 2025 23:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748671815; x=1749276615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pseK2rncPdJaU+2inXcRd67qeSB4vKaK2R5IOjuqGOc=;
        b=2fWBcF5GAsVD0UZuOSAfpHL3RCbdAHMTF3t49OzWiVJFc9vyq/hs3PwqfyVTL1E8qZ
         mu8OjaSOSM1EKfBwwU3e8k8ycBVUqqfvop4ySv0EHsf/erf4Gt5zrhZDQmsP+xA6rULy
         NaZais1+PGXC8Jy9oIAwQvSk3OvNEDfscVvGGA0lZiYVTIuuY5EW7QsSKG4LzDZ1X6KR
         7ECe2uM991CGBfyL2EWihD+ZinxvzecpbKfp2FNzuT0M3IXfmLQ6FJEm1KvqVIC+2a5C
         8rXp3lJCVG5y4xk1oZnfRH8Th7B3ZAtrE7uhcZski4Ttyjd6eLPJYc8JpPgBm8WEgxaO
         WOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748671815; x=1749276615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pseK2rncPdJaU+2inXcRd67qeSB4vKaK2R5IOjuqGOc=;
        b=iwWfY6mrKDZ3LgS1zPRSPTlYlz18iFLNOhBMaecXOF2+pf5m6pmnl0qTo9nSVXmiOG
         Ae/sAhIXzasUYIwGSLs/CStj3pYcnBkDosouxAier9z7Y+rsZh4TucHYu7K3vjtoifdu
         uQIj+IkHAHcclL2Yz4dWyOzrgZEANviPGNg9mEUu/IZLROxNXOOj3AJT3AbNef+Nz1ac
         D9mxGraTrqzhKNxWj4cDqIPAF4R2esaMqSkAjKlyXF0IUqLCnvI7/pqKxQ4Tv5ELvgqj
         /qblTwip+zVG4k1SwfZqWS9zD4Yheq64Ggd2TLORm/u9UzJ7vT1UaWS0GsQndkSFtIM0
         AKmw==
X-Forwarded-Encrypted: i=1; AJvYcCU1t68DkeuzT8BwC5TyRy9YPthaPeJsS6DpFBS82CP7xJFmxhE/JoyYgzxaMCYin0MzEmBiM3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvs63gDjyHF72nnpFH6gijCcQ0U/XyWyS14rQ91n2hsZ101+kZ
	uVy9rl+SZHHgyGOZQXG8b2WLKgGFwQ4wK2NeWluGAox+8ohKx/4SqaN11EHBy9umM136PAB3xYE
	WdUDNpo2lVjCyfWGEC4tIhRuOCQXjG6sK9DaCY8kmTuV0FsK+hm4Nc+jf9p4=
X-Gm-Gg: ASbGnctGtVWCxI8V05qVTVfeygJYHSug8yto302/zf4tNYM2fGgOdUulNdyJQ6nL0rz
	r15DYKB6IRPqBF9VlpqJ6O2XKgt4qSL/K3k7A6Ta24bfjI6ajzvA7utNJsAmgDAhq/UEF03fTjY
	ePE7NG2PGqx+C1VYWBbtMq1X6xvBsO0HrhAYt+VdAUPU9cs88Gy14xZoIWewBp2lHbFEM7ezCSd
	lDF
X-Google-Smtp-Source: AGHT+IEiOzwAr+Z2AokXrUSkjBMx/A9WaxidWTroqSIaYoiamYD2Biw7ekbMkoH0qfrWg4czPLT2fGqwJhd79Zjh4/k=
X-Received: by 2002:a05:6402:2217:b0:605:c356:45a2 with SMTP id
 4fb4d7f45d1cf-605c35645ccmr2343a12.4.1748671814279; Fri, 30 May 2025 23:10:14
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CAGsJ_4wBMxQSeoTwpKoWwEGRAr=iohbYf64aYyJ55t0Z11FkwA@mail.gmail.com>
 <CAGsJ_4wM8Tph0Mbc-1Y9xNjgMPL7gqEjp=ArBuv3cJijHVXe6w@mail.gmail.com>
In-Reply-To: <CAGsJ_4wM8Tph0Mbc-1Y9xNjgMPL7gqEjp=ArBuv3cJijHVXe6w@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 30 May 2025 23:10:02 -0700
X-Gm-Features: AX0GCFuENRxcHgF4CJFYuPHl_RiBHS5OnLS5Gk9oKdSbi9NUFrrwfUNlWVjB2B8
Message-ID: <CA+EESO7Gck6YpjPTMSzDGcmRXjci=zG3i8F+LTt=u2Krbp_cRg@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 9:42=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sat, May 31, 2025 at 4:04=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Sat, May 31, 2025 at 8:17=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > On seeing a swap entry PTE, userfaultfd_move does a lockless swap cac=
he
> > > lookup, and try to move the found folio to the faulting vma when.
> > > Currently, it relies on the PTE value check to ensure the moved folio
> > > still belongs to the src swap entry, which turns out is not reliable.
> > >
> > > While working and reviewing the swap table series with Barry, followi=
ng
> > > existing race is observed and reproduced [1]:
> > >
> > > ( move_pages_pte is moving src_pte to dst_pte, where src_pte is a
> > >  swap entry PTE holding swap entry S1, and S1 isn't in the swap cache=
.)
> > >
> > > CPU1                               CPU2
> > > userfaultfd_move
> > >   move_pages_pte()
> > >     entry =3D pte_to_swp_entry(orig_src_pte);
> > >     // Here it got entry =3D S1
> > >     ... < Somehow interrupted> ...
> > >                                    <swapin src_pte, alloc and use fol=
io A>
> > >                                    // folio A is just a new allocated=
 folio
> > >                                    // and get installed into src_pte
> > >                                    <frees swap entry S1>
> > >                                    // src_pte now points to folio A, =
S1
> > >                                    // has swap count =3D=3D 0, it can=
 be freed
> > >                                    // by folio_swap_swap or swap
> > >                                    // allocator's reclaim.
> > >                                    <try to swap out another folio B>
> > >                                    // folio B is a folio in another V=
MA.
> > >                                    <put folio B to swap cache using S=
1 >
> > >                                    // S1 is freed, folio B could use =
it
> > >                                    // for swap out with no problem.
> > >                                    ...
> > >     folio =3D filemap_get_folio(S1)
> > >     // Got folio B here !!!
> > >     ... < Somehow interrupted again> ...
> > >                                    <swapin folio B and free S1>
> > >                                    // Now S1 is free to be used again=
.
> > >                                    <swapout src_pte & folio A using S=
1>
> > >                                    // Now src_pte is a swap entry pte
> > >                                    // holding S1 again.
> > >     folio_trylock(folio)
> > >     move_swap_pte
> > >       double_pt_lock
> > >       is_pte_pages_stable
> > >       // Check passed because src_pte =3D=3D S1
> > >       folio_move_anon_rmap(...)
> > >       // Moved invalid folio B here !!!
> > >
> > > The race window is very short and requires multiple collisions of
> > > multiple rare events, so it's very unlikely to happen, but with a
> > > deliberately constructed reproducer and increased time window, it can=
 be
> > > reproduced [1].
> > >
> > > It's also possible that folio (A) is swapped in, and swapped out agai=
n
> > > after the filemap_get_folio lookup, in such case folio (A) may stay i=
n
> > > swap cache so it needs to be moved too. In this case we should also t=
ry
> > > again so kernel won't miss a folio move.
> > >
> > > Fix this by checking if the folio is the valid swap cache folio after
> > > acquiring the folio lock, and checking the swap cache again after
> > > acquiring the src_pte lock.
> > >
> > > SWP_SYNCRHONIZE_IO path does make the problem more complex, but so fa=
r
> > > we don't need to worry about that since folios only might get exposed=
 to
> > > swap cache in the swap out path, and it's covered in this patch too b=
y
> > > checking the swap cache again after acquiring src_pte lock.
> > >
> > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCz=
i+EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/userfaultfd.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index bc473ad21202..a1564d205dfb 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/mmu_notifier.h>
> > >  #include <linux/hugetlb.h>
> > >  #include <linux/shmem_fs.h>
> > > +#include <linux/delay.h>
> > >  #include <asm/tlbflush.h>
> > >  #include <asm/tlb.h>
> > >  #include "internal.h"
> > > @@ -1086,6 +1087,8 @@ static int move_swap_pte(struct mm_struct *mm, =
struct vm_area_struct *dst_vma,
> > >                          spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > >                          struct folio *src_folio)
> > >  {
> > > +       swp_entry_t entry;
> > > +
> > >         double_pt_lock(dst_ptl, src_ptl);
> > >
> > >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig=
_src_pte,
> > > @@ -1102,6 +1105,19 @@ static int move_swap_pte(struct mm_struct *mm,=
 struct vm_area_struct *dst_vma,
> > >         if (src_folio) {
> > >                 folio_move_anon_rmap(src_folio, dst_vma);
> > >                 src_folio->index =3D linear_page_index(dst_vma, dst_a=
ddr);
> > > +       } else {
> > > +               /*
> > > +                * Check again after acquiring the src_pte lock. Or w=
e might
> > > +                * miss a new loaded swap cache folio.
> > > +                */
> > > +               entry =3D pte_to_swp_entry(orig_src_pte);
> > > +               src_folio =3D filemap_get_folio(swap_address_space(en=
try),
> > > +                                             swap_cache_index(entry)=
);
> > > +               if (!IS_ERR_OR_NULL(src_folio)) {
> > > +                       double_pt_unlock(dst_ptl, src_ptl);
> > > +                       folio_put(src_folio);
> > > +                       return -EAGAIN;
> > > +               }
> > >         }
> >
> > step 1: src pte points to a swap entry without swapcache
> > step 2: we call move_swap_pte()
> > step 3: someone swap-in src_pte by swap_readhead() and make src_pte's s=
wap entry
> > have swapcache again - for non-sync/non-zRAM swap device;
> > step 4: move_swap_pte() gets ptl, move src_pte to dst_pte and *clear* s=
rc_pte;
> > step 5: do_swap_page() for src_pte holds the ptl and found pte has
> > been cleared in
> >             step 4; pte_same() returns false;
> > step 6: do_swap_page() won't map src_pte to the new swapcache got from =
step 3;
> >             if the swapcache folio is dropped, it seems everything is f=
ine.
> >
> > So the real issue is that do_swap_page() doesn=E2=80=99t drop the new s=
wapcache
> > even when pte_same() returns false? That means the dst_pte swap-in
> > can still hit the swap cache entry brought in by the src_pte's swap-in?
>
> It seems also possible for the sync zRAM device.
>
>  step 1: src pte points to a swap entry S without swapcache
>  step 2: we call move_swap_pte()
>  step 3: someone swap-in src_pte by sync path, no swapcache; swap slot
> S is freed.
>              -- for zRAM;
>  step 4: someone swap-out src_pte, get the exactly same swap slot S as st=
ep 1,
>              adds folio to swapcache due to swapout;
>  step 5: move_swap_pte() gets ptl and finds page tables are stable
> since swap-out
>              happens to have the same swap slot as step1;
>  step 6: we clear src_pte, move src_pte to dst_pte; but miss to move the =
folio.
>
> Yep, we really need to re-check pte for swapcache after holding PTL.
>
Any idea what is the overhead of filemap_get_folio()? In particular,
when no folio exists for the given entry, how costly is it?

Given how rare it is, unless filemap_get_folio() is cheap for 'no
folio' case, if there is no way to avoid calling it after holding PTL,
then we should do it only once at that point. If a folio is returned,
then like in the pte_present() case, we attempt folio_trylock() with
PTL held, otherwise do the retry dance.
> >
> > >
> > >         orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> > > @@ -1409,6 +1425,16 @@ static int move_pages_pte(struct mm_struct *mm=
, pmd_t *dst_pmd, pmd_t *src_pmd,
> > >                                 folio_lock(src_folio);
> > >                                 goto retry;
> > >                         }
> > > +                       /*
> > > +                        * Check if the folio still belongs to the ta=
rget swap entry after
> > > +                        * acquiring the lock. Folio can be freed in =
the swap cache while
> > > +                        * not locked.
> > > +                        */
> > > +                       if (unlikely(!folio_test_swapcache(folio) ||
> > > +                                    entry.val !=3D folio->swap.val))=
 {
> > > +                               err =3D -EAGAIN;
> > > +                               goto out;
> > > +                       }
> > >                 }
> > >                 err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr=
, dst_pte, src_pte,
> > >                                 orig_dst_pte, orig_src_pte, dst_pmd, =
dst_pmdval,
> > > --
> > > 2.49.0
> > >
> >
>
> Thanks
> Barry

