Return-Path: <stable+bounces-148342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11555AC9991
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 08:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2DF17D216
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 06:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0667C22D4F2;
	Sat, 31 May 2025 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S64M/EdB"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA97EEA9;
	Sat, 31 May 2025 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748672736; cv=none; b=mMOX+T3XgxUVZrkLeRkZtAOxoNVkh+mgyw/TDWwOmtdgTwoaueT5SIaMcX3KPu2biNxF19w/rlqeCDitmax0kXEw3luQ6cRtp8lXXsyWU8m7TlWIVXKedadMsmxWeGl61UihVu2a55xIpW/6f0/UbfKrNseB9yHJnK3PjxpfAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748672736; c=relaxed/simple;
	bh=N5wlHSkMgcAVVEV/E2uNhCs/y2dOevW/B1z/nJxUuTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASe6bLpPQ7inAfHYhhf87K+DiY8wis4N3lPKqUCZsyRpcvKyrrYJfXTHjkXepoH+fcBEWlvi5he7xOfHLhkyMpJfWqT91fztz7a0NxzqeUXeWOVE/0ZNX1hHmMiYqIZAEPaWgeuVDFZRZb5e/Ox1zRvtzGqzqU6vTsrAUDYGslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S64M/EdB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32a696ff4dcso24777431fa.3;
        Fri, 30 May 2025 23:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748672733; x=1749277533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/4OXa2hzFRR47673rkgb/Kf+clw6rbd55Z6IECRLgA=;
        b=S64M/EdBHo53e1tmOJMW+NFdBtMpsre79ODX12zIzcd+bcrdQ/LssUcOMm4X2CUEtv
         L0x/msfHx/nMoijbojyvP1ORFjPPW2WGLsBv80CEQpK9HZ52oZ+5/HYzA4ZWEUFUiPzP
         QGrMMItVav0EVUvrnySahnR16YitC5T7k9zoVdFfAJlrrmomDuLRJuwIWEZlEPPiUw3m
         08dthlfh3iXs9JSrHHQETik4/CCQ8GkmhBxJb6SBTh8c3fQ7Y2oCcrK6Y0KZyxhoX6eq
         tyIevs0FdlNaz22Fn2njXJoeqAvfXEAybeg8ZeG0YHit0TvrStSYNIwbT5X8qtkoD0AO
         Jgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748672733; x=1749277533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/4OXa2hzFRR47673rkgb/Kf+clw6rbd55Z6IECRLgA=;
        b=Fj4v4I3ydrT701x0xKUHoH3KSav3zlWkTflEbMMpGT+C+D+kXyzok1HVFspIZlqyjQ
         71XV99jGMDKSOvbs2KT5HsFGj19+Tof35W4j7Khw7AhjEmKZm+Yhxa/MUmkbc750CqN+
         PiVL9F4lusCAS2vBnyDjSZCjjsND0o4cHWQwObGI7UdjZKP36dV+ei2gW08N/RqiqDxU
         osoGxqJH3u8eMlYBf5xiEt9mbDBHe6GRiVmOzfuVTyTBdLkRnMC36dm0OVFahMmqbjeg
         xEGkCqteT6LjKAOu/85lNJjmpI+HljGM29aGRvyYhE/zwn1mVfjwMldpyDFIIe0N+jb8
         jBYA==
X-Forwarded-Encrypted: i=1; AJvYcCWFfg/XjVPRV2HA3Dh6cksBzJSA9srTCzzYSHCWKsHBcN5C8ora1/QXjjzFCUowKeFbFMW2rbWo3/ZmdOA=@vger.kernel.org, AJvYcCWPJuuo3AFPsEpDzY0ycQjNUA+jV2KlOLIYu/jXDY+dAH1vVAV3TZwIKicq+Gz7omluySpk0WPQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzzFTc9pfUYusNLPWp4nkjd82VhiIT5SHu30CIi0lFCuK6iZN
	+BAV3Va1iafRV9RQF0ETnVuZ5PWxfTTNappfkyIrFyhyxt8PihoXqwyyR6pyUPC4x+2tYlaRYNW
	MoPqg6xYF0sHRZpbC2FxoDOopr1vCZ0w=
X-Gm-Gg: ASbGncv9Rs1VvGcbMAvNtAxrTqNTqnb1m0OKb3xFvccmaJbowtPcqj1LM95JI1Yg9ee
	XpU6QIWRMOMOZfPIcd0YErZdFliCtik4Fm0k57IbuXA6W9iizY4aiXvJf2POJHWEN3gP0i3bZlh
	6xpZeoM1lc7f1rFy8KPYfOUM9wbVo2Sq7LArrmkF9iLEA=
X-Google-Smtp-Source: AGHT+IFhM1XZLO7FrleH7PqM7ZD1Wco65eL8LCXHXmS8zuJtDDrVY7wm2Kw2/lda2Mx5v32XBJlDb18N+HNo75impDo=
X-Received: by 2002:a05:651c:110d:b0:32a:5e74:5721 with SMTP id
 38308e7fff4ca-32a8ce4a7f3mr15703871fa.35.1748672732752; Fri, 30 May 2025
 23:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
 <CAGsJ_4wkY8UcyU3LnNc1a55AvjYsVjBiST=Dy07UiaH8MU5-yg@mail.gmail.com>
In-Reply-To: <CAGsJ_4wkY8UcyU3LnNc1a55AvjYsVjBiST=Dy07UiaH8MU5-yg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 31 May 2025 14:25:15 +0800
X-Gm-Features: AX0GCFuYMKY5sjANTAwsyv716ph6C9qB9Snsja0SuMF35VaUtRDL9vcNOQSsYbM
Message-ID: <CAMgjq7CFhboj1qDjdzwb2_vWKpzSzY5d0s-kWmE2ZYDDJ4s-JQ@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Barry Song <21cnbao@gmail.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 11:39=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Sat, May 31, 2025 at 11:40=E2=80=AFAM Lokesh Gidra <lokeshgidra@google=
.com> wrote:
> >
> > On Fri, May 30, 2025 at 1:17=E2=80=AFPM Kairui Song <ryncsn@gmail.com> =
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
> >
> > Thanks for catching and fixing this. Just to clarify a few things
> > about your reproducer:
> > 1. Is it necessary for the 'race' mapping to be MAP_SHARED, or
> > MAP_PRIVATE will work as well?
> > 2. You mentioned that the 'current dir is on a block device'. Are you
> > indicating that if we are using zram for swap then it doesn't
> > reproduce?
> >
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
> > I guess you mistakenly left it from your reproducer code :)
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
> >
> > Given the non-trivial overhead of filemap_get_folio(), do you think it
> > will work if filemap_get_filio() was only once after locking src_ptl?
> > Please correct me if my assumption about the overhead is wrong.
>
> not quite sure as we have a folio_lock(src_folio) before move_swap_pte().
> can we safely folio_move_anon_rmap + src_folio->index while not holding
> folio lock?

I think no, we can't even make sure the folio is still in the swap
cache, so it can be a freed folio that does not belong to any VMA
while not holding the folio lock.

