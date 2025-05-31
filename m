Return-Path: <stable+bounces-148348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F96AC99C3
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 09:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF911890F92
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 07:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8520F22FDF1;
	Sat, 31 May 2025 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9xk5HjI"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300322D7BF;
	Sat, 31 May 2025 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748675208; cv=none; b=WITumDNcTi90x4cIOSaJqxf1sj5+nIcgVbtQ0hHA8ft9ySiDN0YSlwQ7GcrRkzchI+hakyC+rtpGqP/okIxIfF5ea01uqj8brhhLRJtfNLnkG1Q2ufJgp1H6o6UnxqkTcjloXSORm+EVWMp565qn17/Wn9Yk5u6rWqfueBVZmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748675208; c=relaxed/simple;
	bh=YWsRLOax1JIeCZ+RG0ps7GRDmgt/6FuZ/dOmn2tWD08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/DXSn95KGvKidoRkStIaidviZhzklrhE85t14nvHKPUgjbm/Idmpo8vMCepIDZM1H8uNR+w3mLXv/bgrVpodZtWGSedk6ojc8FqHIDBIdDojHllqE4LNqXgVAW68ogxnnPg0NgDQEH70mO5n57ff+9+7lTl1lOi8okdnUeuJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9xk5HjI; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e701c53c84so214124137.0;
        Sat, 31 May 2025 00:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748675205; x=1749280005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsTeU4EFLHIlrLb9s8RD2uX61gMjvlIv64R2i/tB+3M=;
        b=D9xk5HjIgvz+ttXHcxfxTNMoZIzeG0/dA7vXmGUo1dlB7OJP7kX0ghW0U9E59dnLVU
         TiE3/OF/HiLl4MYaZPuA3bDgF7lcjyY4AtpW0NVznFP2+bPcBehevykxMFrzwszWVX3W
         DoOaGWK6Q3I+w57MoaolC9xpyXs9WXY/AdU1ugVyiX5NSsu+ZjYJgfka5JSZEwQs/9Xy
         31dhl/1BjJuxUKJLnYDfmV+osUOwb/00SQr0kQeM3P21keaz2kPyZl0MqB6SSZ0hKMkt
         slNrRK6ah5+fzKZdarDuEz1alZGcldslTjJ4kD+4BdS7JqcBTZ+g3ojAXyMRL+rYGTry
         rrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748675205; x=1749280005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsTeU4EFLHIlrLb9s8RD2uX61gMjvlIv64R2i/tB+3M=;
        b=u4Y7ok/t8f3EXcW40UHlliERC87XfBKj9rnDVcetD42yHpNM0tqJnEcBJrE9uiOrnC
         NQpviI0nBFFv1C341/xu0B8j6TtIJI4hgV3zCkHdrYGUNFWHlHcfOeiXt+a1Sa0OWfcp
         z1m15i6l1xPeIA64Sm6kMU44uKcD2aMD3f7kgW37HuJWzo82sUGso0jiHJsOcHwJGFub
         AJOI20IHRJA+A+6F3tXLmPRoDm3Ed4j8g9+V99mvfTQunHQ4sTSGFVrOPMTB1edUy596
         qwAC8jcsh40+iTYbVYu3Yw+mwzJ7t77hwJfL1q8qAKDrYew9ETkRohPB55PNY/m1uZ7v
         24Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWPawr7FLQDvEB2lNBSvnpOej3Ze5P/1wXOfbl0F37pmUCK3jhQvoCkfiZMT5snpLCYQ5cAC9LI@vger.kernel.org, AJvYcCXMDtwyvCUbrdX8aZQVl8g+nsOiIYpqaL7f/cOY0+us91fO+yQwSOe8UtRi5LUlXDsnCnAFzk9krtWxk2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkshjLGGeyTs1vs51S/cbMnxY7groduo9EFgx/IyP2ozu/slX
	nUTQb3fHPy6Q5OFiVSVDVFIqhCxPKIIxOBpr6N1Ft+jEGZf54twuuQ4pIExlsNfc2m9gr/chalj
	mceKSi1Cv8Vq0CLuu8XCIRDIMZctqaeg=
X-Gm-Gg: ASbGnctAE57VhtpzFowwID0ga5PFvd6zi4LhuIjD8m8yg+ArYkPeqWFWWHjXRKxZs4x
	n0jdzB3s9acXPAW4t5zyaLi6RGa8AX+jW+RTuiGh9pIlP4BOFANrULGRF+lWOOMnJBPy6XpxSAC
	70hUpUj86/8hGMRXI8ruiv1xnVb90L53STzFYhpcXhkhCo
X-Google-Smtp-Source: AGHT+IGXprOwD1uRE4xo4SpdKHUvxNK9e8+2IV/X2qmrAZDSMS3lPR0VZqmfesG8SiGew4RdFZy9w5d1mQm38Ho+bfU=
X-Received: by 2002:a05:6102:c0e:b0:4e5:8eb6:e8dd with SMTP id
 ada2fe7eead31-4e701a2823fmr436513137.5.1748675205160; Sat, 31 May 2025
 00:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
 <CAGsJ_4wkY8UcyU3LnNc1a55AvjYsVjBiST=Dy07UiaH8MU5-yg@mail.gmail.com>
 <CAMgjq7CFhboj1qDjdzwb2_vWKpzSzY5d0s-kWmE2ZYDDJ4s-JQ@mail.gmail.com>
 <CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+tAi=8Y560K8eT=A@mail.gmail.com> <CAMgjq7BzBFTOb-urmfuF5y6qsWxwFMy0Eq=Fym+2x2pjcqg1fQ@mail.gmail.com>
In-Reply-To: <CAMgjq7BzBFTOb-urmfuF5y6qsWxwFMy0Eq=Fym+2x2pjcqg1fQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 May 2025 19:06:33 +1200
X-Gm-Features: AX0GCFuoz4HDWn6J3a6yeG7T2VCsCEJaLP2KYtp3OO9TF5bk5yMKT2SLCYCNtEI
Message-ID: <CAGsJ_4wm1hf54UgYJMrOyfBHDU=ZTYcGtcWTNOqo-OjmRNtXmg@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 7:00=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, May 31, 2025 at 2:36=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Sat, May 31, 2025 at 6:25=E2=80=AFPM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Sat, May 31, 2025 at 11:39=E2=80=AFAM Barry Song <21cnbao@gmail.co=
m> wrote:
> > > >
> > > > On Sat, May 31, 2025 at 11:40=E2=80=AFAM Lokesh Gidra <lokeshgidra@=
google.com> wrote:
> > > > >
> > > > > On Fri, May 30, 2025 at 1:17=E2=80=AFPM Kairui Song <ryncsn@gmail=
.com> wrote:
> > > > > >
> > > > > > From: Kairui Song <kasong@tencent.com>
> > > > > >
> > > > > > On seeing a swap entry PTE, userfaultfd_move does a lockless sw=
ap cache
> > > > > > lookup, and try to move the found folio to the faulting vma whe=
n.
> > > > > > Currently, it relies on the PTE value check to ensure the moved=
 folio
> > > > > > still belongs to the src swap entry, which turns out is not rel=
iable.
> > > > > >
> > > > > > While working and reviewing the swap table series with Barry, f=
ollowing
> > > > > > existing race is observed and reproduced [1]:
> > > > > >
> > > > > > ( move_pages_pte is moving src_pte to dst_pte, where src_pte is=
 a
> > > > > >  swap entry PTE holding swap entry S1, and S1 isn't in the swap=
 cache.)
> > > > > >
> > > > > > CPU1                               CPU2
> > > > > > userfaultfd_move
> > > > > >   move_pages_pte()
> > > > > >     entry =3D pte_to_swp_entry(orig_src_pte);
> > > > > >     // Here it got entry =3D S1
> > > > > >     ... < Somehow interrupted> ...
> > > > > >                                    <swapin src_pte, alloc and u=
se folio A>
> > > > > >                                    // folio A is just a new all=
ocated folio
> > > > > >                                    // and get installed into sr=
c_pte
> > > > > >                                    <frees swap entry S1>
> > > > > >                                    // src_pte now points to fol=
io A, S1
> > > > > >                                    // has swap count =3D=3D 0, =
it can be freed
> > > > > >                                    // by folio_swap_swap or swa=
p
> > > > > >                                    // allocator's reclaim.
> > > > > >                                    <try to swap out another fol=
io B>
> > > > > >                                    // folio B is a folio in ano=
ther VMA.
> > > > > >                                    <put folio B to swap cache u=
sing S1 >
> > > > > >                                    // S1 is freed, folio B coul=
d use it
> > > > > >                                    // for swap out with no prob=
lem.
> > > > > >                                    ...
> > > > > >     folio =3D filemap_get_folio(S1)
> > > > > >     // Got folio B here !!!
> > > > > >     ... < Somehow interrupted again> ...
> > > > > >                                    <swapin folio B and free S1>
> > > > > >                                    // Now S1 is free to be used=
 again.
> > > > > >                                    <swapout src_pte & folio A u=
sing S1>
> > > > > >                                    // Now src_pte is a swap ent=
ry pte
> > > > > >                                    // holding S1 again.
> > > > > >     folio_trylock(folio)
> > > > > >     move_swap_pte
> > > > > >       double_pt_lock
> > > > > >       is_pte_pages_stable
> > > > > >       // Check passed because src_pte =3D=3D S1
> > > > > >       folio_move_anon_rmap(...)
> > > > > >       // Moved invalid folio B here !!!
> > > > > >
> > > > > > The race window is very short and requires multiple collisions =
of
> > > > > > multiple rare events, so it's very unlikely to happen, but with=
 a
> > > > > > deliberately constructed reproducer and increased time window, =
it can be
> > > > > > reproduced [1].
> > > > >
> > > > > Thanks for catching and fixing this. Just to clarify a few things
> > > > > about your reproducer:
> > > > > 1. Is it necessary for the 'race' mapping to be MAP_SHARED, or
> > > > > MAP_PRIVATE will work as well?
> > > > > 2. You mentioned that the 'current dir is on a block device'. Are=
 you
> > > > > indicating that if we are using zram for swap then it doesn't
> > > > > reproduce?
> > > > >
> > > > > >
> > > > > > It's also possible that folio (A) is swapped in, and swapped ou=
t again
> > > > > > after the filemap_get_folio lookup, in such case folio (A) may =
stay in
> > > > > > swap cache so it needs to be moved too. In this case we should =
also try
> > > > > > again so kernel won't miss a folio move.
> > > > > >
> > > > > > Fix this by checking if the folio is the valid swap cache folio=
 after
> > > > > > acquiring the folio lock, and checking the swap cache again aft=
er
> > > > > > acquiring the src_pte lock.
> > > > > >
> > > > > > SWP_SYNCRHONIZE_IO path does make the problem more complex, but=
 so far
> > > > > > we don't need to worry about that since folios only might get e=
xposed to
> > > > > > swap cache in the swap out path, and it's covered in this patch=
 too by
> > > > > > checking the swap cache again after acquiring src_pte lock.
> > > > > >
> > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ=
0-tqCzi+EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > > ---
> > > > > >  mm/userfaultfd.c | 26 ++++++++++++++++++++++++++
> > > > > >  1 file changed, 26 insertions(+)
> > > > > >
> > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > index bc473ad21202..a1564d205dfb 100644
> > > > > > --- a/mm/userfaultfd.c
> > > > > > +++ b/mm/userfaultfd.c
> > > > > > @@ -15,6 +15,7 @@
> > > > > >  #include <linux/mmu_notifier.h>
> > > > > >  #include <linux/hugetlb.h>
> > > > > >  #include <linux/shmem_fs.h>
> > > > > > +#include <linux/delay.h>
> > > > > I guess you mistakenly left it from your reproducer code :)
> > > > > >  #include <asm/tlbflush.h>
> > > > > >  #include <asm/tlb.h>
> > > > > >  #include "internal.h"
> > > > > > @@ -1086,6 +1087,8 @@ static int move_swap_pte(struct mm_struct=
 *mm, struct vm_area_struct *dst_vma,
> > > > > >                          spinlock_t *dst_ptl, spinlock_t *src_p=
tl,
> > > > > >                          struct folio *src_folio)
> > > > > >  {
> > > > > > +       swp_entry_t entry;
> > > > > > +
> > > > > >         double_pt_lock(dst_ptl, src_ptl);
> > > > > >
> > > > > >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte=
, orig_src_pte,
> > > > > > @@ -1102,6 +1105,19 @@ static int move_swap_pte(struct mm_struc=
t *mm, struct vm_area_struct *dst_vma,
> > > > > >         if (src_folio) {
> > > > > >                 folio_move_anon_rmap(src_folio, dst_vma);
> > > > > >                 src_folio->index =3D linear_page_index(dst_vma,=
 dst_addr);
> > > > > > +       } else {
> > > > > > +               /*
> > > > > > +                * Check again after acquiring the src_pte lock=
. Or we might
> > > > > > +                * miss a new loaded swap cache folio.
> > > > > > +                */
> > > > > > +               entry =3D pte_to_swp_entry(orig_src_pte);
> > > > > > +               src_folio =3D filemap_get_folio(swap_address_sp=
ace(entry),
> > > > > > +                                             swap_cache_index(=
entry));
> > > > >
> > > > > Given the non-trivial overhead of filemap_get_folio(), do you thi=
nk it
> > > > > will work if filemap_get_filio() was only once after locking src_=
ptl?
> > > > > Please correct me if my assumption about the overhead is wrong.
> > > >
> > > > not quite sure as we have a folio_lock(src_folio) before move_swap_=
pte().
> > > > can we safely folio_move_anon_rmap + src_folio->index while not hol=
ding
> > > > folio lock?
> > >
> > > I think no, we can't even make sure the folio is still in the swap
> > > cache, so it can be a freed folio that does not belong to any VMA
> > > while not holding the folio lock.
> >
> > Right, but will the following be sufficient, given that we don=E2=80=99=
t really
> > care about the folio=E2=80=94only whether there=E2=80=99s new cache?
> >
> > if (READ_ONCE(si->swap_map[offset]) & SWAP_HAS_CACHE) {
> >              double_pt_unlock(dst_ptl, src_ptl);
> >              return -EAGAIN;
> > }
>
> The problem is reading swap_map without locking the cluster map seems
> unstable, and has strange false positives, a swapin will set this bit
> first, while not adding the folio to swap cache or even when skipping
> the swap cache, that seems could make it more complex.

As long as it's a false positive and not a false negative, I think it's
acceptable=E2=80=94especially if we're concerned about the overhead of
filemap_get_folio. The probability is extremely low (practically close
to 0%), but we still need to call filemap_get_folio for every swap PTE.

Thanks
Barry

