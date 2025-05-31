Return-Path: <stable+bounces-148350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53706AC99CC
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 09:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138D417F2B1
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42EC235067;
	Sat, 31 May 2025 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2fjbW7b1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BE92343C0
	for <stable@vger.kernel.org>; Sat, 31 May 2025 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748675503; cv=none; b=Ii1wds8TNkHDVGamuX0pYzHHbHw+wc42OKqtfNy/TAdA7hhZLvZJDOhxsXJUSo8BVXLzHHws8jrPSiQ9gBuHmuk5jiG7EqZef2kmcZGaRd66OYXqczQXUUVDor+5xmeOJ/HVmdrVq8dRosUDbh9kLJ3KDS42O41YRFoy8pfRIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748675503; c=relaxed/simple;
	bh=qPD6RSZsfHxQKR9kiSFgamDIvSiSK5NmVTTFJ5JcHu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c45czhwS29EpmrMXC37MP4Ji7A3pZX381/xkGmrqIQV8zNU8BhLyaGZq0cfGuGmUdypSW8JyVp2DkSr0u+j2Z4WmTxTBxmecMKtj62CHlVaSzXsNf7lgQNWvDvmkeT0IllGW638OynlqxqVk9WSTUlYVqra5T4m1aaB/psDUCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2fjbW7b1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2348a45fc73so77525ad.0
        for <stable@vger.kernel.org>; Sat, 31 May 2025 00:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748675500; x=1749280300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJUPLZSZKX8rYufeGcr9Ae45p6/9NH9FDi+v384RGEw=;
        b=2fjbW7b1dNLn0tyqgmEzy1Q2OewrJAfhUElX4c5/Rb9NHi4L7vQNf9+YPDrW4RNWnI
         5nMkVArSov1fnACWXvK/029/XQklL48CPMUbRAMgkKfZVYxT84NYnytbeDr0PYURNWMa
         QGTGhU0xtNsi8+H8kcO/ychGanh0Q/WnKj6BV2IsrXmTDz/+pd2k7ki6haUAHP5RD401
         FVaWDpF1huGP0T3o+inU+GPpAn/AMfwAWqLJL9CHNC/vuyS1qGE6PSyKHVgvv7EtZBQ3
         UyPF/YjEf8QYopJ5ZcER5FzGqQPh9uaHoWLIXzzPYKuXqIVPKMhhiDFmUVfez8pUolj0
         TZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748675500; x=1749280300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJUPLZSZKX8rYufeGcr9Ae45p6/9NH9FDi+v384RGEw=;
        b=iuEtR3VEY/L2/EH2YR5cj/nsOo0K6gxHiav/DsLAyOki7ekQAk5ptxSDcf6u4YgmDW
         6lYwV0UrMRcN7tvw6FvKzWltnW+pw2RNHQRrLiKWYxzbxeAZQhKvnStP/rclSoN2Nd84
         +RV6QJetBsySv0Ku4Z3QbNDMwwMaX/DR5bLlgc5OrzHASzVXU9DLiPA6c+z3finxudmb
         7/kYJsXtGrhOuX8ADDdMB8k3p+lSZS1cS+VADoFj/LvbcU2VZHBYpDAKKJtOSRnOXPs9
         sTnaMELndbbATARAjU+186QfuTE/Qj3SVYP6t8ubIsffbOzb8jkshTwhJSvtNjY4TREh
         0c4w==
X-Forwarded-Encrypted: i=1; AJvYcCWo3sD+vRN9rQ7j5pqwvptTVBS20GJWQTnd9tMInMXvbmxdImsBVUPVwoHk5XbRSbECGraG94w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymqew/EML1Lz9l2ejxYK51477Tp6rvNttZde/Dxq7pZXyH9iI7
	8pyRkXekXQw60IYW/ZII1ah+ra7umERV765KItgIWPVrx5y4etwWWegBbBqG0demq1pXLNJ12oy
	X9fhmRqM+gwhMA3lLjckAsAPFjdD4NUEPeYKWeB0A
X-Gm-Gg: ASbGncuVWd2AjiCR/MsF74fKsERyVXgIKDHuZ5wGfc8V+52g/mUuWJvc1hf0kQEufvb
	c9jujxHtxudAb7xqI4vfyxfTqBwuIqvMv3peQrIfqssBpk3VtIjUi23HE+emx7ZKmjIeH2AASra
	YlmyjrABTkAlYvzJHSPqOvPLY43oOajR81nijXb87N9zPno1LGNIzZgf6XcdQN0SDGINVdD8d2G
	e7nRKxM+f1kHz8=
X-Google-Smtp-Source: AGHT+IFL2G6R9UYfr0o8oK/7I4HkDQML7Z++7jpPt0Grez3RcIK5mSoEa/a8KBvtmIkNzJbgoKpZnCjzVgIrrFgtNbM=
X-Received: by 2002:a17:902:da8e:b0:234:14ff:541f with SMTP id
 d9443c01a7336-2355af16345mr998905ad.21.1748675499856; Sat, 31 May 2025
 00:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
 <CAGsJ_4wkY8UcyU3LnNc1a55AvjYsVjBiST=Dy07UiaH8MU5-yg@mail.gmail.com>
 <CAMgjq7CFhboj1qDjdzwb2_vWKpzSzY5d0s-kWmE2ZYDDJ4s-JQ@mail.gmail.com>
 <CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+tAi=8Y560K8eT=A@mail.gmail.com>
 <CAMgjq7BzBFTOb-urmfuF5y6qsWxwFMy0Eq=Fym+2x2pjcqg1fQ@mail.gmail.com> <CAGsJ_4wm1hf54UgYJMrOyfBHDU=ZTYcGtcWTNOqo-OjmRNtXmg@mail.gmail.com>
In-Reply-To: <CAGsJ_4wm1hf54UgYJMrOyfBHDU=ZTYcGtcWTNOqo-OjmRNtXmg@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Sat, 31 May 2025 00:11:24 -0700
X-Gm-Features: AX0GCFu-U44uG2WWotTuwSQuH2rZxfvOvvkcAntijfqzmYHrTd196Ke7FpZ3cCU
Message-ID: <CA+EESO5NWFtyhYXY2Tq5ku1NnyWJY0T=ENFjqQEZR3SQF0X8qg@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 12:06=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Sat, May 31, 2025 at 7:00=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Sat, May 31, 2025 at 2:36=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Sat, May 31, 2025 at 6:25=E2=80=AFPM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > On Sat, May 31, 2025 at 11:39=E2=80=AFAM Barry Song <21cnbao@gmail.=
com> wrote:
> > > > >
> > > > > On Sat, May 31, 2025 at 11:40=E2=80=AFAM Lokesh Gidra <lokeshgidr=
a@google.com> wrote:
> > > > > >
> > > > > > On Fri, May 30, 2025 at 1:17=E2=80=AFPM Kairui Song <ryncsn@gma=
il.com> wrote:
> > > > > > >
> > > > > > > From: Kairui Song <kasong@tencent.com>
> > > > > > >
> > > > > > > On seeing a swap entry PTE, userfaultfd_move does a lockless =
swap cache
> > > > > > > lookup, and try to move the found folio to the faulting vma w=
hen.
> > > > > > > Currently, it relies on the PTE value check to ensure the mov=
ed folio
> > > > > > > still belongs to the src swap entry, which turns out is not r=
eliable.
> > > > > > >
> > > > > > > While working and reviewing the swap table series with Barry,=
 following
> > > > > > > existing race is observed and reproduced [1]:
> > > > > > >
> > > > > > > ( move_pages_pte is moving src_pte to dst_pte, where src_pte =
is a
> > > > > > >  swap entry PTE holding swap entry S1, and S1 isn't in the sw=
ap cache.)
> > > > > > >
> > > > > > > CPU1                               CPU2
> > > > > > > userfaultfd_move
> > > > > > >   move_pages_pte()
> > > > > > >     entry =3D pte_to_swp_entry(orig_src_pte);
> > > > > > >     // Here it got entry =3D S1
> > > > > > >     ... < Somehow interrupted> ...
> > > > > > >                                    <swapin src_pte, alloc and=
 use folio A>
> > > > > > >                                    // folio A is just a new a=
llocated folio
> > > > > > >                                    // and get installed into =
src_pte
> > > > > > >                                    <frees swap entry S1>
> > > > > > >                                    // src_pte now points to f=
olio A, S1
> > > > > > >                                    // has swap count =3D=3D 0=
, it can be freed
> > > > > > >                                    // by folio_swap_swap or s=
wap
> > > > > > >                                    // allocator's reclaim.
> > > > > > >                                    <try to swap out another f=
olio B>
> > > > > > >                                    // folio B is a folio in a=
nother VMA.
> > > > > > >                                    <put folio B to swap cache=
 using S1 >
> > > > > > >                                    // S1 is freed, folio B co=
uld use it
> > > > > > >                                    // for swap out with no pr=
oblem.
> > > > > > >                                    ...
> > > > > > >     folio =3D filemap_get_folio(S1)
> > > > > > >     // Got folio B here !!!
> > > > > > >     ... < Somehow interrupted again> ...
> > > > > > >                                    <swapin folio B and free S=
1>
> > > > > > >                                    // Now S1 is free to be us=
ed again.
> > > > > > >                                    <swapout src_pte & folio A=
 using S1>
> > > > > > >                                    // Now src_pte is a swap e=
ntry pte
> > > > > > >                                    // holding S1 again.
> > > > > > >     folio_trylock(folio)
> > > > > > >     move_swap_pte
> > > > > > >       double_pt_lock
> > > > > > >       is_pte_pages_stable
> > > > > > >       // Check passed because src_pte =3D=3D S1
> > > > > > >       folio_move_anon_rmap(...)
> > > > > > >       // Moved invalid folio B here !!!
> > > > > > >
> > > > > > > The race window is very short and requires multiple collision=
s of
> > > > > > > multiple rare events, so it's very unlikely to happen, but wi=
th a
> > > > > > > deliberately constructed reproducer and increased time window=
, it can be
> > > > > > > reproduced [1].
> > > > > >
> > > > > > Thanks for catching and fixing this. Just to clarify a few thin=
gs
> > > > > > about your reproducer:
> > > > > > 1. Is it necessary for the 'race' mapping to be MAP_SHARED, or
> > > > > > MAP_PRIVATE will work as well?
> > > > > > 2. You mentioned that the 'current dir is on a block device'. A=
re you
> > > > > > indicating that if we are using zram for swap then it doesn't
> > > > > > reproduce?
> > > > > >
> > > > > > >
> > > > > > > It's also possible that folio (A) is swapped in, and swapped =
out again
> > > > > > > after the filemap_get_folio lookup, in such case folio (A) ma=
y stay in
> > > > > > > swap cache so it needs to be moved too. In this case we shoul=
d also try
> > > > > > > again so kernel won't miss a folio move.
> > > > > > >
> > > > > > > Fix this by checking if the folio is the valid swap cache fol=
io after
> > > > > > > acquiring the folio lock, and checking the swap cache again a=
fter
> > > > > > > acquiring the src_pte lock.
> > > > > > >
> > > > > > > SWP_SYNCRHONIZE_IO path does make the problem more complex, b=
ut so far
> > > > > > > we don't need to worry about that since folios only might get=
 exposed to
> > > > > > > swap cache in the swap out path, and it's covered in this pat=
ch too by
> > > > > > > checking the swap cache again after acquiring src_pte lock.
> > > > > > >
> > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2O=
UZ0-tqCzi+EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > > > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > > > ---
> > > > > > >  mm/userfaultfd.c | 26 ++++++++++++++++++++++++++
> > > > > > >  1 file changed, 26 insertions(+)
> > > > > > >
> > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > > index bc473ad21202..a1564d205dfb 100644
> > > > > > > --- a/mm/userfaultfd.c
> > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > @@ -15,6 +15,7 @@
> > > > > > >  #include <linux/mmu_notifier.h>
> > > > > > >  #include <linux/hugetlb.h>
> > > > > > >  #include <linux/shmem_fs.h>
> > > > > > > +#include <linux/delay.h>
> > > > > > I guess you mistakenly left it from your reproducer code :)
> > > > > > >  #include <asm/tlbflush.h>
> > > > > > >  #include <asm/tlb.h>
> > > > > > >  #include "internal.h"
> > > > > > > @@ -1086,6 +1087,8 @@ static int move_swap_pte(struct mm_stru=
ct *mm, struct vm_area_struct *dst_vma,
> > > > > > >                          spinlock_t *dst_ptl, spinlock_t *src=
_ptl,
> > > > > > >                          struct folio *src_folio)
> > > > > > >  {
> > > > > > > +       swp_entry_t entry;
> > > > > > > +
> > > > > > >         double_pt_lock(dst_ptl, src_ptl);
> > > > > > >
> > > > > > >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_p=
te, orig_src_pte,
> > > > > > > @@ -1102,6 +1105,19 @@ static int move_swap_pte(struct mm_str=
uct *mm, struct vm_area_struct *dst_vma,
> > > > > > >         if (src_folio) {
> > > > > > >                 folio_move_anon_rmap(src_folio, dst_vma);
> > > > > > >                 src_folio->index =3D linear_page_index(dst_vm=
a, dst_addr);
> > > > > > > +       } else {
> > > > > > > +               /*
> > > > > > > +                * Check again after acquiring the src_pte lo=
ck. Or we might
> > > > > > > +                * miss a new loaded swap cache folio.
> > > > > > > +                */
> > > > > > > +               entry =3D pte_to_swp_entry(orig_src_pte);
> > > > > > > +               src_folio =3D filemap_get_folio(swap_address_=
space(entry),
> > > > > > > +                                             swap_cache_inde=
x(entry));
> > > > > >
> > > > > > Given the non-trivial overhead of filemap_get_folio(), do you t=
hink it
> > > > > > will work if filemap_get_filio() was only once after locking sr=
c_ptl?
> > > > > > Please correct me if my assumption about the overhead is wrong.
> > > > >
> > > > > not quite sure as we have a folio_lock(src_folio) before move_swa=
p_pte().
> > > > > can we safely folio_move_anon_rmap + src_folio->index while not h=
olding
> > > > > folio lock?
> > > >
> > > > I think no, we can't even make sure the folio is still in the swap
> > > > cache, so it can be a freed folio that does not belong to any VMA
> > > > while not holding the folio lock.
> > >
> > > Right, but will the following be sufficient, given that we don=E2=80=
=99t really
> > > care about the folio=E2=80=94only whether there=E2=80=99s new cache?
> > >
> > > if (READ_ONCE(si->swap_map[offset]) & SWAP_HAS_CACHE) {
> > >              double_pt_unlock(dst_ptl, src_ptl);
> > >              return -EAGAIN;
> > > }
> >
> > The problem is reading swap_map without locking the cluster map seems
> > unstable, and has strange false positives, a swapin will set this bit
> > first, while not adding the folio to swap cache or even when skipping
> > the swap cache, that seems could make it more complex.
>
> As long as it's a false positive and not a false negative, I think it's
> acceptable=E2=80=94especially if we're concerned about the overhead of
> filemap_get_folio. The probability is extremely low (practically close
> to 0%), but we still need to call filemap_get_folio for every swap PTE.
>
That's exactly my concern too. A retry or EAGAIN on rare false
positives are acceptable. But adding an additional call to
filemap_get_folio, that too with PTL for both src and dst locked is
not cheap. Consider that on a multi-threaded application, there could
be many threads blocked on the same PTL. So keeping that critical
section as short as possible is desirable.

> Thanks
> Barry

