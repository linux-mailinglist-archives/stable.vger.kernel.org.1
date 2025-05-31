Return-Path: <stable+bounces-148341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB334AC998F
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 08:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6459E741F
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 06:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47F22B8C3;
	Sat, 31 May 2025 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQXutqWx"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64774EEA9;
	Sat, 31 May 2025 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748672576; cv=none; b=tHrva/561eoV4+yONJCK6wLbZono2pyAY7VpTkilG6CqyBOBpqpz0Kc7G5DM89Qd9+k2kFqxqbGKRcWWpP+e2cCNcM/GCd0POgj0f9xtlTEFdNI0I47PqRvENkd4rvv6USct6odWgq5+Uovk3Oy+cBWHfqDkdDVmwbOIMqbGe3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748672576; c=relaxed/simple;
	bh=YuLdvkfK+9Pn96qHV6pjgzwb7AkKwqjHCAwt6FM17BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/wxR4s4pXC+4MHraFq9vxPjhu28+ePtTUOrNoCp+Lv8s9HV7ihgVhGW6cjttGtLNltUy7U7xcZsMIosTCbMCPoG8n1qQXtijXbHMxx39uYbJYmmgfbbaeuJj4HlFWeKwuiOsiIHVPkuLisa7zowbgOIldDiWJLfwiczaKIyhoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQXutqWx; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32a696ff4deso24994691fa.1;
        Fri, 30 May 2025 23:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748672572; x=1749277372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z6mh7pdJDvN8yUkwBxqHC+Y8n4XgRQIeuqir52nwPE=;
        b=DQXutqWx/VXwjala8XN9r7+d/ylfw4zPY/de6qg2KOQKdM5hH5MuefJG96+JfpRz5B
         xTd9izemTi9IieEFgRUMtq5mOd2LM9/wsSBLy+h4iICVecDvMTFla5L9+HpIZhR8h6f/
         Y4gTcj3ozo+qvKiKY6vBUz4V2I9S4hFfmpxROP/pRiiKykoeD4GUkdwM3rVYfJy+V5Xx
         8vOzTs9QKhHwYNZniTuJjubC3LVOSXDJmrrMd3XSoNLBQN27OvLvQW7AGtUKbIf9szUs
         SIJHplLp+WLWsBSd+SAKCb2J7IAXOhlv26OcQtnx32ogj0fJcwyGUYoK8ihMKPIDNNhO
         IfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748672572; x=1749277372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8z6mh7pdJDvN8yUkwBxqHC+Y8n4XgRQIeuqir52nwPE=;
        b=ZG0ZrPyPMBpPcFkVPQ/8rVw8Jq0RM50giT6C3k8ap1lXD+JAOpkTzTowhvVEJzkAFb
         4ffFdmrZzjzZYYJ7+Lly20sNIw+9SQebamqT8ZNoPA/2Ff1k/1OUyTAhTUh2j6vxAtRG
         StHMtQrZcM9cnaj0/et+ecHFuK1LNhGVVIBuM6nCP1s/sgsOir4wsTl+d1JEhHHU/5Q4
         VNjEd8FV0X6FeIa24IA6PIjEkj9EAsBcV+usxzhxT0ln/gyay+nitLrVDpebwgFu0ebl
         QykdBrazEQ3ICjv2TX7fLJ/8IY4kEYaTklOftYniLSQydAKHiFgE9iFNyDQhtjCqUzZC
         rGDw==
X-Forwarded-Encrypted: i=1; AJvYcCVjQSyQKywo1aFYO62RXAi2fjMZ5G/jUCANyVtA6NKtcJmWsQ0FsqDwjf327/b5nTI4fmyP5JGTWn19bHI=@vger.kernel.org, AJvYcCWt8prIo3XT7SWLeOiewePzXg8KzVGttQfuYxhXxpF2DkRmGEsXQLfhNDS3TcTBwquQsF96yjD/@vger.kernel.org
X-Gm-Message-State: AOJu0YxhkVzGgyx3f/c7N7FHQ8iUybGUC/LoETAu/BcDLPXGeUKXrg64
	vPZwvIJf9Y0lDyjmeu1bovedMf4/zNqUOFbNfKM6xQUvxb0FTRd1ucXxnE/a63aPnArg5iz3mbd
	73O4QIR/Kr6jZ8OLorNkQKBaD+Q2aoXc=
X-Gm-Gg: ASbGncutrE7GP5KR5skLEnkONY998KH5CGzIyKcWea+vu0sm+4/klfeBtvrrygjwpgU
	1IqgImGZ19Fg4QG68EgbB1sWpCbHkDOjx01OVuOiluEN3VXYRNCIxiOtZi8F73+4IuUhxL1OIoz
	hhgeFXEcX2Qk1ZPn6TK9OP1r+ZuGHgEs+4
X-Google-Smtp-Source: AGHT+IHS8XLKQ5NmPv0l2ZJX5RYz0dEFA4DWAVhyuy7guXysiJ85JCN16IFjvHRjGXXy7OsItWIIp4P8s8h7CeYnOrs=
X-Received: by 2002:a2e:a986:0:b0:32a:710f:5a0 with SMTP id
 38308e7fff4ca-32a906d76a0mr15468041fa.11.1748672572114; Fri, 30 May 2025
 23:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
In-Reply-To: <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 31 May 2025 14:22:34 +0800
X-Gm-Features: AX0GCFs1kvLiRCh7TzrXTKfCqNtzaev34lKPFyF-_wQf4bInaissLB-H6Q8jHs4
Message-ID: <CAMgjq7B=CEhEE_M3d07Vtq+Fkv8+A7pu2axQu0oLi44d1r9Xrg@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <21cnbao@gmail.com>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 7:42=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> On Fri, May 30, 2025 at 1:17=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
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
>
> Thanks for catching and fixing this. Just to clarify a few things
> about your reproducer:
> 1. Is it necessary for the 'race' mapping to be MAP_SHARED, or
> MAP_PRIVATE will work as well?

Hi, I used MAP_SHARED just to prevent vma merging, so folio B and
folio A belong to different vma, so the folio_move_anon_rmap will
cause a real problem. The race is not related to the map flag.

> 2. You mentioned that the 'current dir is on a block device'. Are you
> indicating that if we are using zram for swap then it doesn't
> reproduce?

ZRAM may also trigger the race, with a slightly different race window,
but the race window is even shorter so I can't reproduce with that.

>
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
> I guess you mistakenly left it from your reproducer code :)

Ah, yes, I'll drop this :)

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
>
> Given the non-trivial overhead of filemap_get_folio(), do you think it
> will work if filemap_get_filio() was only once after locking src_ptl?
> Please correct me if my assumption about the overhead is wrong.

No we can't do the filemap_get_filio after locking src_ptl, moving the
folio requires locking it, lock a folio inside a PTE lock looks a bad
idea... So I just added a lockless lookup and fallback to try again if
found one.

The overhead should be low I think, it's a lockless xarray lookup and
when I was doing many profiling of SWAP performance optimizations,
Xarray look up is not a heavy burden.

>
> > +               if (!IS_ERR_OR_NULL(src_folio)) {
> > +                       double_pt_unlock(dst_ptl, src_ptl);
> > +                       folio_put(src_folio);
> > +                       return -EAGAIN;
> > +               }
> >         }
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
>
> To avoid further increasing move_pages_pte() size, I recommend moving
> the entire 'pte not present' case into move_swap_pte(), and maybe
> returning some positive integer (or something more appropriate) to
> handle the retry case. And then in move_swap_pte(), as suggested
> above, you can do filemap_get_folio only once after locking ptl.
>
> I think this will fix the bug as well as improve the code's organization.
>
> >                 }
> >                 err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr, =
dst_pte, src_pte,
> >                                 orig_dst_pte, orig_src_pte, dst_pmd, ds=
t_pmdval,
> > --
> > 2.49.0
> >
>

