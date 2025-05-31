Return-Path: <stable+bounces-148343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B350AC999B
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 08:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379697AF96C
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 06:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5057EAD0;
	Sat, 31 May 2025 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYMFUwwz"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E500619F10A;
	Sat, 31 May 2025 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748673368; cv=none; b=ls6vCi6LNGbM+EqBeIc/xtkGMPSw5ahwcoqvEvrbu6fCvvycka4ikhYY5CrEOUhjYHCm5QK2w9o3LisZq1LirEBPKhyE0qWRXAV3Vfvwy5MBJ5sK0lebM42YoJMq3+Yv+kSr6+f5uyhjBtWbIleIYpucYmoM+qr3O5SLst8kTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748673368; c=relaxed/simple;
	bh=YXwmW+GZn5Xltkq0Z7L3gYqPS8LV1nBKKs0Ek1z/X/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3JKrGqVFG/BZiQq1rYPwl9oj2Yuv/lne0q+D3/PlQYK5H+k3cLNrEBZSrfsr+zXvYu28I5tnualfB9LrNPgIR0n3lfvCaX0B36HChybluu3BEbnw43kciLbdQFO9ozzaHESUDVBkqYRYJ7W2MlWoRuVtZOjopWQwkrt5bSlsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYMFUwwz; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-530807a8691so567609e0c.0;
        Fri, 30 May 2025 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748673366; x=1749278166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxAnNwf04k1daTyHuUhp/+U0tlJ5knXJTN7hN8ijbm4=;
        b=bYMFUwwzfmHYOOv/dL1UknTx9JG3VD0DXl6xnYN2mE0aWBEqPu/At4KCkRI6JMzbPH
         bcExQyjg45hBpbIEGKs3OHWsjngILVHqGvAYX/xwDSty3NBvMMYKb8/QaIwdZr5iiXXF
         5vV4JkSSml3qsfH8JfQOQUdSjGbyG4oxZDnTeIt/WAs0xxC1j0kCnZFwrd2dbAtFngo3
         PAjI/0uKR2PI6XU5luxq1Ps5D7sb0697i1IZHeGMNqfvO4OCMSm2X0q3uHmTkFyGfqrW
         Hcmhhwp8CJGmxXCxwzabc8niaRnyfQ56j58srvyGFbrwOsdHyEJbWjKKo9doFrQx0/0f
         uJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748673366; x=1749278166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxAnNwf04k1daTyHuUhp/+U0tlJ5knXJTN7hN8ijbm4=;
        b=g9I358XMBMrXWB0JIHOTusd/gIB9ldmc/ndWLXiipHHwwLn6jVQIP1jN4lYJW45pTU
         Dya1tUXncXLEbyZgs2otbVvV2M+ClvJ+XAGC9KF+ZH4amRWKsgOMmtU/UTlqRrfksPRW
         tFG49UYHnQ/9boOu0k241ybRkSD0Kk4QcfAr6wWWU44uVwe7gdGzk7oa1+tc3u2ge8yx
         KIHt7b2yH5vus3YuoYwlMU7upbWgrcLwIDObUb2V2KPTQfJN9XMaSjGclO2xUfLu63sR
         B5GUL4hKVEVYP+/ZJcepBlnrRhFSJZ4PYHXlp7t1O55InPoctg90t0qFrUPk7jYZ4+OB
         ZW+g==
X-Forwarded-Encrypted: i=1; AJvYcCU50m0D6/g8CoFlU69SvEJjqWs5xVccnRT7/sEJc2w+QDsBudJvELNtdEGV4AKVQwmx3LVvBaZK2GrhI0U=@vger.kernel.org, AJvYcCXg2elqT43UkRma6kFZIhe6xmsBNhr8rZRfPl0v/ZspofgtQ1WkyEJ1yUBS5hre1APLHGN6MkiE@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGHpKUj64TgGTNdv+AEdMw0qbs9K4t/lN4aWYBNxi3ZOuk5EY
	A6IbjO/UE2HvQZLCuJhHwmptPIq/zaVl91LsV01aQsTdSoObvwtMAg7n0RLw6AALghDByGuhGXU
	v+gFdGV9W7gg2ZRtxlh7AdOfXuf0lf/U=
X-Gm-Gg: ASbGncuyyYooIgCeJ7gzQo2X/JLUY9Tma4lbg/wb0isdEhPa3Y3ky7+GrOmM3HeJTkU
	SNPWxzRKMPmp9dJAL/nEShJ808lwpLJvcdkc1rcH8bMF6KKyhXOKLy5ehBpwM+RZKxKV6/9Vojs
	2Qz3QLR2lWeGtH3zX3Vnz3+hBBcQG5sU9Pmg==
X-Google-Smtp-Source: AGHT+IFoFH9kRyoo67Aj4j7sLe/VRhCJ+NyYgJ+kdpibA364NNkrfUx+kDIf2nV6F+Nf9J3DCvPMTi+MJfD/icdKAsE=
X-Received: by 2002:a05:6102:6d2:b0:4df:8259:eaa with SMTP id
 ada2fe7eead31-4e701bae8a0mr364647137.5.1748673365645; Fri, 30 May 2025
 23:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
 <CAGsJ_4wkY8UcyU3LnNc1a55AvjYsVjBiST=Dy07UiaH8MU5-yg@mail.gmail.com> <CAMgjq7CFhboj1qDjdzwb2_vWKpzSzY5d0s-kWmE2ZYDDJ4s-JQ@mail.gmail.com>
In-Reply-To: <CAMgjq7CFhboj1qDjdzwb2_vWKpzSzY5d0s-kWmE2ZYDDJ4s-JQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 May 2025 18:35:54 +1200
X-Gm-Features: AX0GCFsKja1UXSjAtb35_iM4kGOhGAzatuZyI2XERD_MsOjTIh0b4SoyXztRzgA
Message-ID: <CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+tAi=8Y560K8eT=A@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 6:25=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, May 31, 2025 at 11:39=E2=80=AFAM Barry Song <21cnbao@gmail.com> w=
rote:
> >
> > On Sat, May 31, 2025 at 11:40=E2=80=AFAM Lokesh Gidra <lokeshgidra@goog=
le.com> wrote:
> > >
> > > On Fri, May 30, 2025 at 1:17=E2=80=AFPM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > On seeing a swap entry PTE, userfaultfd_move does a lockless swap c=
ache
> > > > lookup, and try to move the found folio to the faulting vma when.
> > > > Currently, it relies on the PTE value check to ensure the moved fol=
io
> > > > still belongs to the src swap entry, which turns out is not reliabl=
e.
> > > >
> > > > While working and reviewing the swap table series with Barry, follo=
wing
> > > > existing race is observed and reproduced [1]:
> > > >
> > > > ( move_pages_pte is moving src_pte to dst_pte, where src_pte is a
> > > >  swap entry PTE holding swap entry S1, and S1 isn't in the swap cac=
he.)
> > > >
> > > > CPU1                               CPU2
> > > > userfaultfd_move
> > > >   move_pages_pte()
> > > >     entry =3D pte_to_swp_entry(orig_src_pte);
> > > >     // Here it got entry =3D S1
> > > >     ... < Somehow interrupted> ...
> > > >                                    <swapin src_pte, alloc and use f=
olio A>
> > > >                                    // folio A is just a new allocat=
ed folio
> > > >                                    // and get installed into src_pt=
e
> > > >                                    <frees swap entry S1>
> > > >                                    // src_pte now points to folio A=
, S1
> > > >                                    // has swap count =3D=3D 0, it c=
an be freed
> > > >                                    // by folio_swap_swap or swap
> > > >                                    // allocator's reclaim.
> > > >                                    <try to swap out another folio B=
>
> > > >                                    // folio B is a folio in another=
 VMA.
> > > >                                    <put folio B to swap cache using=
 S1 >
> > > >                                    // S1 is freed, folio B could us=
e it
> > > >                                    // for swap out with no problem.
> > > >                                    ...
> > > >     folio =3D filemap_get_folio(S1)
> > > >     // Got folio B here !!!
> > > >     ... < Somehow interrupted again> ...
> > > >                                    <swapin folio B and free S1>
> > > >                                    // Now S1 is free to be used aga=
in.
> > > >                                    <swapout src_pte & folio A using=
 S1>
> > > >                                    // Now src_pte is a swap entry p=
te
> > > >                                    // holding S1 again.
> > > >     folio_trylock(folio)
> > > >     move_swap_pte
> > > >       double_pt_lock
> > > >       is_pte_pages_stable
> > > >       // Check passed because src_pte =3D=3D S1
> > > >       folio_move_anon_rmap(...)
> > > >       // Moved invalid folio B here !!!
> > > >
> > > > The race window is very short and requires multiple collisions of
> > > > multiple rare events, so it's very unlikely to happen, but with a
> > > > deliberately constructed reproducer and increased time window, it c=
an be
> > > > reproduced [1].
> > >
> > > Thanks for catching and fixing this. Just to clarify a few things
> > > about your reproducer:
> > > 1. Is it necessary for the 'race' mapping to be MAP_SHARED, or
> > > MAP_PRIVATE will work as well?
> > > 2. You mentioned that the 'current dir is on a block device'. Are you
> > > indicating that if we are using zram for swap then it doesn't
> > > reproduce?
> > >
> > > >
> > > > It's also possible that folio (A) is swapped in, and swapped out ag=
ain
> > > > after the filemap_get_folio lookup, in such case folio (A) may stay=
 in
> > > > swap cache so it needs to be moved too. In this case we should also=
 try
> > > > again so kernel won't miss a folio move.
> > > >
> > > > Fix this by checking if the folio is the valid swap cache folio aft=
er
> > > > acquiring the folio lock, and checking the swap cache again after
> > > > acquiring the src_pte lock.
> > > >
> > > > SWP_SYNCRHONIZE_IO path does make the problem more complex, but so =
far
> > > > we don't need to worry about that since folios only might get expos=
ed to
> > > > swap cache in the swap out path, and it's covered in this patch too=
 by
> > > > checking the swap cache again after acquiring src_pte lock.
> > > >
> > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tq=
Czi+EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > ---
> > > >  mm/userfaultfd.c | 26 ++++++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index bc473ad21202..a1564d205dfb 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -15,6 +15,7 @@
> > > >  #include <linux/mmu_notifier.h>
> > > >  #include <linux/hugetlb.h>
> > > >  #include <linux/shmem_fs.h>
> > > > +#include <linux/delay.h>
> > > I guess you mistakenly left it from your reproducer code :)
> > > >  #include <asm/tlbflush.h>
> > > >  #include <asm/tlb.h>
> > > >  #include "internal.h"
> > > > @@ -1086,6 +1087,8 @@ static int move_swap_pte(struct mm_struct *mm=
, struct vm_area_struct *dst_vma,
> > > >                          spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > > >                          struct folio *src_folio)
> > > >  {
> > > > +       swp_entry_t entry;
> > > > +
> > > >         double_pt_lock(dst_ptl, src_ptl);
> > > >
> > > >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, or=
ig_src_pte,
> > > > @@ -1102,6 +1105,19 @@ static int move_swap_pte(struct mm_struct *m=
m, struct vm_area_struct *dst_vma,
> > > >         if (src_folio) {
> > > >                 folio_move_anon_rmap(src_folio, dst_vma);
> > > >                 src_folio->index =3D linear_page_index(dst_vma, dst=
_addr);
> > > > +       } else {
> > > > +               /*
> > > > +                * Check again after acquiring the src_pte lock. Or=
 we might
> > > > +                * miss a new loaded swap cache folio.
> > > > +                */
> > > > +               entry =3D pte_to_swp_entry(orig_src_pte);
> > > > +               src_folio =3D filemap_get_folio(swap_address_space(=
entry),
> > > > +                                             swap_cache_index(entr=
y));
> > >
> > > Given the non-trivial overhead of filemap_get_folio(), do you think i=
t
> > > will work if filemap_get_filio() was only once after locking src_ptl?
> > > Please correct me if my assumption about the overhead is wrong.
> >
> > not quite sure as we have a folio_lock(src_folio) before move_swap_pte(=
).
> > can we safely folio_move_anon_rmap + src_folio->index while not holding
> > folio lock?
>
> I think no, we can't even make sure the folio is still in the swap
> cache, so it can be a freed folio that does not belong to any VMA
> while not holding the folio lock.

Right, but will the following be sufficient, given that we don=E2=80=99t re=
ally
care about the folio=E2=80=94only whether there=E2=80=99s new cache?

if (READ_ONCE(si->swap_map[offset]) & SWAP_HAS_CACHE) {
             double_pt_unlock(dst_ptl, src_ptl);
             return -EAGAIN;
}

Thanks
Barry

