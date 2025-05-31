Return-Path: <stable+bounces-148347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1CFAC99BF
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 09:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACCD3B19F4
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 07:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A26223DCE;
	Sat, 31 May 2025 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXc6ro2c"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60C35949;
	Sat, 31 May 2025 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748674853; cv=none; b=ZQ1oTpEOW6yxWIaivGjb9LKhu8kqxCn/R9j9BNWMR5Ht92HRYtyD2iNJzkA/WuUmOR9rcQDbtexbqnaVZTlaruoa0JJ77oyx6iPdXGBWRhqxxAd5SekWJm6f5CMU3d0mYHJXZ26r0F2mGpWqGoDLeD6jX85Trm7KmZTN741CDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748674853; c=relaxed/simple;
	bh=xNtSKnlo3ooiXUucFc3Lir6rDSSBwUqAmtThG9rzzwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HY/zSDfFuZPvU2oOeBYEzIYspXL1VCNpRCB37MvqC4oov/Yvk4y7VfWUx6lzs7nS56cpl8ynJWNo+uO7vZW+lGojp6ggcZcAsT621+HgLhFyv9cSFl8HkERFPrfZvK4mucmOQbV2dZsvkzNZ0JGOmER43LVV9PB4JxWRPa8JNpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXc6ro2c; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32a63ff3bdfso21948201fa.3;
        Sat, 31 May 2025 00:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748674850; x=1749279650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0/6i247A0yd7g/ohON1pSpOBinIfrLgbq10zNbzL4E=;
        b=mXc6ro2cIDj+vLO18qqH/lvUmJpwMuksLTSh0Y558b5EOlwx7vjW5nxySR/5lQr7yT
         9PNN16UCw7YB7E0KPmrYJBzXvLcuyZfp8Ju9gcRi1U9DU/GEEgooPQ0SHdWg4SzD7Bvy
         z8s6LMlV4IR+roBaAj8V9JgHYLxTu0+ijFxYBkWZVBYavDJy7gYW7O0wx3iXcHSg6l8B
         Oqjk3Xh9bRikAD0DYAA1aisHlzOTUSI4m1CgO84o5kIijdQPnKoDlx4gtYgLUAdDUMcd
         z7WyNpy6dY3VWlsCPshoP538DQmm1HpTXVM8Sf+kJesGDxZDFr8HBbTSfZ1y2dWVqqoO
         5IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748674850; x=1749279650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0/6i247A0yd7g/ohON1pSpOBinIfrLgbq10zNbzL4E=;
        b=OauxO4/XxjYr9fb+MAS0FmnSEGg4AFDu35Mh8XWwCrg7XXGC+T/gLj3hdynZ47gBtN
         IeswK5qGnLCyoLVWu9Ww4f+taR1gY4Lv/JHpGxlFZ0sK4bs6ZYu5xllBj9RobW0t9dta
         yL5H3/TSTt70142HPXwIjtFO2/QEd++0hTsOeSBnNRkxAOQCffJpt5SO+SHPUg8MjLKc
         7MvTYuSDj7XePtfS8OuQXyjZO/KCQJzfzI/Mcr6RxRCxrZMK23adOAiihBjgem5coqJn
         P3K/7slHXkYiL/uL/Ul8y82MJ58g1lRwQPa3M1S+/ZMXUbTN4gdSMbavT55eKtGS33HE
         hQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7AVZl5TqNZ9d7PIoPhfGHDZg+xKLjUIxmcabYuktOZPPn44eB9KINoeeKQoLMY/fRUQIHKPlCl3j4vmw=@vger.kernel.org, AJvYcCVoIodLQbgUgtEthHim5SZ8tR/2XuwQ3qSYEwmwS0VzBRU++pSDzYJXkJpSjdVXUJxC1xCVuFzj@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZAbtHuMEQaS6IBWEtOuyzdufwNppq8FY229Hz25XZ0uHOd2J
	6KCecZ/LgBv1WvvnmxTUd4T5oOgg4FNe2YhIEFTlpkCxTymZ0ZD56LQ1iA7xq0a0yBsCnrBOVey
	pf6t19qwIKl7A6MT1CygVeT5O7/GGM8uksTnsUe/w8Q==
X-Gm-Gg: ASbGncviTjK7PXWPIVOjdgOrDyB1ZimSKqpDGfU0nEWeuGJCIAqcmcN5bcZaSSIwGIx
	SrM0+hpMrNbJVC4QnfY/SzSwJmLA39Wvi68aWMGlrndqlBCk3BjnvsMdCWqk6UdpzgAhn01K86l
	eNqZi+fvGCoEUjDVyKLt5eASLDeMKLrlAdIfNNADBLKMg=
X-Google-Smtp-Source: AGHT+IFQfYTOUKoUQsoKvjrVG8EjikBueS9mdC3qCctGVd586bN2S/4pCQTvJwmEnsD58/V2Q3nlHbLroDe2+EGI8A8=
X-Received: by 2002:a05:651c:b1f:b0:32a:8bf4:3a54 with SMTP id
 38308e7fff4ca-32a9e99b639mr3723201fa.2.1748674849519; Sat, 31 May 2025
 00:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
 <CAGsJ_4wkY8UcyU3LnNc1a55AvjYsVjBiST=Dy07UiaH8MU5-yg@mail.gmail.com>
 <CAMgjq7CFhboj1qDjdzwb2_vWKpzSzY5d0s-kWmE2ZYDDJ4s-JQ@mail.gmail.com> <CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+tAi=8Y560K8eT=A@mail.gmail.com>
In-Reply-To: <CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+tAi=8Y560K8eT=A@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 31 May 2025 15:00:31 +0800
X-Gm-Features: AX0GCFuLqGZrssa2ETQMnuocMxOiKaSYx_nnjXGgLT7jaHa6QNo6cy-ULN9-bYc
Message-ID: <CAMgjq7BzBFTOb-urmfuF5y6qsWxwFMy0Eq=Fym+2x2pjcqg1fQ@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Barry Song <21cnbao@gmail.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 2:36=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sat, May 31, 2025 at 6:25=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Sat, May 31, 2025 at 11:39=E2=80=AFAM Barry Song <21cnbao@gmail.com>=
 wrote:
> > >
> > > On Sat, May 31, 2025 at 11:40=E2=80=AFAM Lokesh Gidra <lokeshgidra@go=
ogle.com> wrote:
> > > >
> > > > On Fri, May 30, 2025 at 1:17=E2=80=AFPM Kairui Song <ryncsn@gmail.c=
om> wrote:
> > > > >
> > > > > From: Kairui Song <kasong@tencent.com>
> > > > >
> > > > > On seeing a swap entry PTE, userfaultfd_move does a lockless swap=
 cache
> > > > > lookup, and try to move the found folio to the faulting vma when.
> > > > > Currently, it relies on the PTE value check to ensure the moved f=
olio
> > > > > still belongs to the src swap entry, which turns out is not relia=
ble.
> > > > >
> > > > > While working and reviewing the swap table series with Barry, fol=
lowing
> > > > > existing race is observed and reproduced [1]:
> > > > >
> > > > > ( move_pages_pte is moving src_pte to dst_pte, where src_pte is a
> > > > >  swap entry PTE holding swap entry S1, and S1 isn't in the swap c=
ache.)
> > > > >
> > > > > CPU1                               CPU2
> > > > > userfaultfd_move
> > > > >   move_pages_pte()
> > > > >     entry =3D pte_to_swp_entry(orig_src_pte);
> > > > >     // Here it got entry =3D S1
> > > > >     ... < Somehow interrupted> ...
> > > > >                                    <swapin src_pte, alloc and use=
 folio A>
> > > > >                                    // folio A is just a new alloc=
ated folio
> > > > >                                    // and get installed into src_=
pte
> > > > >                                    <frees swap entry S1>
> > > > >                                    // src_pte now points to folio=
 A, S1
> > > > >                                    // has swap count =3D=3D 0, it=
 can be freed
> > > > >                                    // by folio_swap_swap or swap
> > > > >                                    // allocator's reclaim.
> > > > >                                    <try to swap out another folio=
 B>
> > > > >                                    // folio B is a folio in anoth=
er VMA.
> > > > >                                    <put folio B to swap cache usi=
ng S1 >
> > > > >                                    // S1 is freed, folio B could =
use it
> > > > >                                    // for swap out with no proble=
m.
> > > > >                                    ...
> > > > >     folio =3D filemap_get_folio(S1)
> > > > >     // Got folio B here !!!
> > > > >     ... < Somehow interrupted again> ...
> > > > >                                    <swapin folio B and free S1>
> > > > >                                    // Now S1 is free to be used a=
gain.
> > > > >                                    <swapout src_pte & folio A usi=
ng S1>
> > > > >                                    // Now src_pte is a swap entry=
 pte
> > > > >                                    // holding S1 again.
> > > > >     folio_trylock(folio)
> > > > >     move_swap_pte
> > > > >       double_pt_lock
> > > > >       is_pte_pages_stable
> > > > >       // Check passed because src_pte =3D=3D S1
> > > > >       folio_move_anon_rmap(...)
> > > > >       // Moved invalid folio B here !!!
> > > > >
> > > > > The race window is very short and requires multiple collisions of
> > > > > multiple rare events, so it's very unlikely to happen, but with a
> > > > > deliberately constructed reproducer and increased time window, it=
 can be
> > > > > reproduced [1].
> > > >
> > > > Thanks for catching and fixing this. Just to clarify a few things
> > > > about your reproducer:
> > > > 1. Is it necessary for the 'race' mapping to be MAP_SHARED, or
> > > > MAP_PRIVATE will work as well?
> > > > 2. You mentioned that the 'current dir is on a block device'. Are y=
ou
> > > > indicating that if we are using zram for swap then it doesn't
> > > > reproduce?
> > > >
> > > > >
> > > > > It's also possible that folio (A) is swapped in, and swapped out =
again
> > > > > after the filemap_get_folio lookup, in such case folio (A) may st=
ay in
> > > > > swap cache so it needs to be moved too. In this case we should al=
so try
> > > > > again so kernel won't miss a folio move.
> > > > >
> > > > > Fix this by checking if the folio is the valid swap cache folio a=
fter
> > > > > acquiring the folio lock, and checking the swap cache again after
> > > > > acquiring the src_pte lock.
> > > > >
> > > > > SWP_SYNCRHONIZE_IO path does make the problem more complex, but s=
o far
> > > > > we don't need to worry about that since folios only might get exp=
osed to
> > > > > swap cache in the swap out path, and it's covered in this patch t=
oo by
> > > > > checking the swap cache again after acquiring src_pte lock.
> > > > >
> > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-=
tqCzi+EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > ---
> > > > >  mm/userfaultfd.c | 26 ++++++++++++++++++++++++++
> > > > >  1 file changed, 26 insertions(+)
> > > > >
> > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > index bc473ad21202..a1564d205dfb 100644
> > > > > --- a/mm/userfaultfd.c
> > > > > +++ b/mm/userfaultfd.c
> > > > > @@ -15,6 +15,7 @@
> > > > >  #include <linux/mmu_notifier.h>
> > > > >  #include <linux/hugetlb.h>
> > > > >  #include <linux/shmem_fs.h>
> > > > > +#include <linux/delay.h>
> > > > I guess you mistakenly left it from your reproducer code :)
> > > > >  #include <asm/tlbflush.h>
> > > > >  #include <asm/tlb.h>
> > > > >  #include "internal.h"
> > > > > @@ -1086,6 +1087,8 @@ static int move_swap_pte(struct mm_struct *=
mm, struct vm_area_struct *dst_vma,
> > > > >                          spinlock_t *dst_ptl, spinlock_t *src_ptl=
,
> > > > >                          struct folio *src_folio)
> > > > >  {
> > > > > +       swp_entry_t entry;
> > > > > +
> > > > >         double_pt_lock(dst_ptl, src_ptl);
> > > > >
> > > > >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, =
orig_src_pte,
> > > > > @@ -1102,6 +1105,19 @@ static int move_swap_pte(struct mm_struct =
*mm, struct vm_area_struct *dst_vma,
> > > > >         if (src_folio) {
> > > > >                 folio_move_anon_rmap(src_folio, dst_vma);
> > > > >                 src_folio->index =3D linear_page_index(dst_vma, d=
st_addr);
> > > > > +       } else {
> > > > > +               /*
> > > > > +                * Check again after acquiring the src_pte lock. =
Or we might
> > > > > +                * miss a new loaded swap cache folio.
> > > > > +                */
> > > > > +               entry =3D pte_to_swp_entry(orig_src_pte);
> > > > > +               src_folio =3D filemap_get_folio(swap_address_spac=
e(entry),
> > > > > +                                             swap_cache_index(en=
try));
> > > >
> > > > Given the non-trivial overhead of filemap_get_folio(), do you think=
 it
> > > > will work if filemap_get_filio() was only once after locking src_pt=
l?
> > > > Please correct me if my assumption about the overhead is wrong.
> > >
> > > not quite sure as we have a folio_lock(src_folio) before move_swap_pt=
e().
> > > can we safely folio_move_anon_rmap + src_folio->index while not holdi=
ng
> > > folio lock?
> >
> > I think no, we can't even make sure the folio is still in the swap
> > cache, so it can be a freed folio that does not belong to any VMA
> > while not holding the folio lock.
>
> Right, but will the following be sufficient, given that we don=E2=80=99t =
really
> care about the folio=E2=80=94only whether there=E2=80=99s new cache?
>
> if (READ_ONCE(si->swap_map[offset]) & SWAP_HAS_CACHE) {
>              double_pt_unlock(dst_ptl, src_ptl);
>              return -EAGAIN;
> }

The problem is reading swap_map without locking the cluster map seems
unstable, and has strange false positives, a swapin will set this bit
first, while not adding the folio to swap cache or even when skipping
the swap cache, that seems could make it more complex.

