Return-Path: <stable+bounces-148900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F4ACA914
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 07:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDC27A9F1B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 05:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A8979E1;
	Mon,  2 Jun 2025 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNiFnuMX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C692C3254;
	Mon,  2 Jun 2025 05:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748843268; cv=none; b=Ytqr6TX8FdUW09bWTU5AG7hrjHrlsbfVIzx2yBwsBKriiFftUgSzU07yd514ZCi4j3CGOcejW/ncWeq7np2U5uTqYf9Bvwp2d4QWaE+b6bZXC+vGeyLNGtcvbb44FToz3VNN3OAXzsQGtZ9t3lrGQrA3wTTlJIY78DeudchMNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748843268; c=relaxed/simple;
	bh=rTZOLnGna9H5UpXIFrB5N1YfCOUWcX803oZwA8ZZs6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYNhEleyqVvgp/DwmgH0LYVfHUVFB4jPsJAbOjQ8tS8v3sFSMllOdAjuArh/Z/G/ozZSsT056uXickdJdXRXrLPIIFXT2tEmQ9qkQZEQMilhVrDyOnZuRSwQWJVI84KQDgQIsqWSdHgwsTXAxfhgxSBnfL+JHzrbrM0LITKbwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNiFnuMX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3292aad800aso43521191fa.0;
        Sun, 01 Jun 2025 22:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748843263; x=1749448063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETNvbGvKme7nAnnmtzIyBdJn/0gcb2FNly7MRGQKSjA=;
        b=fNiFnuMX5hO7IRHVZeQ+qAR3PKAYtZ5voC/Eyuuyjjq8iUbyULpi00x1iTiLGGdGAE
         pNfiBhhWbS1AUXWeR5fd3vDwZjT2Hya70MttzLbzN/AmHYSMckEH8YC40ef+D6ZNFzS7
         c/xyKghRnxsl/HDrYJ+65x5mmlWnaEI7LtqOyHrSDRueNXadvDcivP13l9ucp2WA58h1
         C++EKORmUZsk6QMs5izgUGVWK5aIiib0dCf+1UniasgWVuuoUwH3AvjAdyZbUcn3NZeO
         5StW1DLumf0PWZNV5HaXlFkp6o4UfIB3Bo9HeU7TIUsc2fkYLM8pmub32D7nIJGqutgQ
         7ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748843263; x=1749448063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETNvbGvKme7nAnnmtzIyBdJn/0gcb2FNly7MRGQKSjA=;
        b=XPWqk0bSfOT78YWBrR45D/AYX+1l/qjmrGI2dP47eVBI6c0Eg5BLlMsMsRPOYU3oru
         arafm4jptNH+sman0M4gKaK2yEllFQh35yRzjgbRkW/XRbmv2i2VdozY6w0rTzkP6lN1
         WyrXAxuAZ1WSQ7QTdLB+as9MZeBrrLPPKccXU4Gs7Nky7b28vIUBLe62fIPU2CnubsY+
         HSs8z4LSghJW9VHDt7Ed5GmcQF8SD5gjhmQMDMrB8Sc1LwTrKminZ+RzTwlRZSFypEyX
         A8QmQh2gLrADLE1c/1xtePdcq2i9p/Def7WeKPv2WggklyC6t3k5gO9i5YEs4XyGB/xV
         sk9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnHkPZGGM5TvYamAqoluFvYb4d1SgT0xHOhTEY64S4aV1S2zkYkx+oecRvN0K5V5gx+a09aDyC@vger.kernel.org, AJvYcCXMG6h9LwlsYc8gs5Uu1aAMxaCW5Fr/EuXCNXPMemGmzb0M6sIFVGgTYMmijZl/W8MSHBK/b83qzVdMW6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvZiXYeYAUos3TYJUeIi1UvRVsxUz586qzAgImZ8Iekx4Lbcp
	lSZmfA9Rbx+wkmt7J9NvtUkEBpQsRSNyVoLSKBMNeYG+/QVsdXhEE/ZLPPQKotAPXXyDgl/v96a
	6CWETHl7NmPkftHFesbsb0vZD5k7V+uc=
X-Gm-Gg: ASbGncsfizYOBW7WdOLGBkJ5qyezZVsgvy4TCm0/AJWd/csD03/fvI2Q+35P8iEFHxC
	GAu/UHbI7p+yYi4Qcb+oJtOiDolVPGBd7UA6CjY8l3Mo7nm0jMyLHCGh3iL3a+oaHhgv94e9UDT
	b8ZV+TbvrEnzP7RGF1HmoeTKzqkuxKHTjZ
X-Google-Smtp-Source: AGHT+IHn3wg4wsWomGqU6A+Vt+xO9VDpV33AKxJYrE+LY2QPQSH7NokQuVYb4n+7SLmsmZzmi7hGLdX1i5AVlVWIpxM=
X-Received: by 2002:a05:651c:1b0f:b0:326:e449:3442 with SMTP id
 38308e7fff4ca-32a8db5e104mr31375631fa.10.1748843263104; Sun, 01 Jun 2025
 22:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601200108.23186-1-ryncsn@gmail.com> <CA+EESO5DWB1C3ggH53n=DQL6xNz1bU+NWh7C7_ao=o9NGLvQ4w@mail.gmail.com>
In-Reply-To: <CA+EESO5DWB1C3ggH53n=DQL6xNz1bU+NWh7C7_ao=o9NGLvQ4w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 2 Jun 2025 13:47:24 +0800
X-Gm-Features: AX0GCFt6pHbMLecqqaWvuLEmwvQs6hTTd2T2X3d9RZidCJA-txiQGEkBEO3RMJg
Message-ID: <CAMgjq7Ds9zQVoxWw_mkFuKTWqr5Jvd50Ek-W7YRgkKCbsdS55g@mail.gmail.com>
Subject: Re: [PATCH v2] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <21cnbao@gmail.com>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 9:43=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.com=
> wrote:
>
> On Sun, Jun 1, 2025 at 1:01=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
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
> > Testing with a simple C program to allocate and move several GB of memo=
ry
> > did not show any observable performance change.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCzi+=
EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> >
> > ---
> >
> > V1: https://lore.kernel.org/linux-mm/20250530201710.81365-1-ryncsn@gmai=
l.com/
> > Changes:
> > - Check swap_map instead of doing a filemap lookup after acquiring the
> >   PTE lock to minimize critical section overhead [ Barry Song, Lokesh G=
idra ]
> >
> >  mm/userfaultfd.c | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index bc473ad21202..a74ede04996c 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1084,8 +1084,11 @@ static int move_swap_pte(struct mm_struct *mm, s=
truct vm_area_struct *dst_vma,
> >                          pte_t orig_dst_pte, pte_t orig_src_pte,
> >                          pmd_t *dst_pmd, pmd_t dst_pmdval,
> >                          spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > -                        struct folio *src_folio)
> > +                        struct folio *src_folio,
> > +                        struct swap_info_struct *si)
> >  {
> > +       swp_entry_t entry;
> > +
> >         double_pt_lock(dst_ptl, src_ptl);
> >
> >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_s=
rc_pte,
> > @@ -1102,6 +1105,16 @@ static int move_swap_pte(struct mm_struct *mm, s=
truct vm_area_struct *dst_vma,
> >         if (src_folio) {
> >                 folio_move_anon_rmap(src_folio, dst_vma);
> >                 src_folio->index =3D linear_page_index(dst_vma, dst_add=
r);
> > +       } else {
> > +               /*
> > +                * Check if the swap entry is cached after acquiring th=
e src_pte
> > +                * lock. Or we might miss a new loaded swap cache folio=
.
> > +                */
> > +               entry =3D pte_to_swp_entry(orig_src_pte);
>
> Can we pass this also from move_pages_pte()? It would be great to
> minimize PTL critical section.

I checked the objdump output. It seems the compiler is doing a good
job on optimizing all the overhead off since it's an inlined macro,
but I can pass it in too, just in case.

>
> > +               if (si->swap_map[swp_offset(entry)] & SWAP_HAS_CACHE) {
> > +                       double_pt_unlock(dst_ptl, src_ptl);
> > +                       return -EAGAIN;
> > +               }
> >         }
> >
> >         orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> > @@ -1409,10 +1422,20 @@ static int move_pages_pte(struct mm_struct *mm,=
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
>
> This check will get skipped if the folio was locked by folio_lock()
> rather than folio_trylock(). It seems to me that the correct way to do
> this is to check outside this if block (right before calling
> move_swap_pte()) and with 'src_folio' instead of 'folio'. Even better,
> if you pass 'entry' as well to move_swap_pte() as per my previous
> comment, then you can move this check also in move_swap_pte().

Good catch, let me move it into move_swap_pte then, it's much easier
to follow that way.

