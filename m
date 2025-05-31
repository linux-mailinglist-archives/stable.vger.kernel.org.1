Return-Path: <stable+bounces-148345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98EAC99B2
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 08:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BA94E0CE6
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06BA1DE2A8;
	Sat, 31 May 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKv1IX/W"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABE208A7;
	Sat, 31 May 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748674468; cv=none; b=FKosKCA2jA3mjG8uMHOlTEl55JjvVWue6dqQ1nfmu5/xJwiJXI6oUf8Q9wX3KYnxGJKi3K5Ao7vL0x7VxU0yPdMNSZ3UZcuFc+68/sdxH0GGKFy+zXBoi1GusNdhKA3TW6UkGMf7igoqi0DbQX4TFhoWFGkJFxfL2EfMMUeE53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748674468; c=relaxed/simple;
	bh=yIZWai5KaDmug7inNb1zWw6dhXMuL0cbhNMRs46CaFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDY+TMXkWDcHajXE+TljmPI4WOq6VXybjOiOEEUjo/ywJ3ZPlEpDqM2ctv+ygw5rBS9dgV1srLRwPXvNAZORXE7IGduXhPEjb3JLgNgh+uGiQKEud3UVGCif0bSVbfgEx06uL0GTqlJl+/DiLT/8Hc7GcOMAM/LxgivPVpSyf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKv1IX/W; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32a61af11ffso30945341fa.1;
        Fri, 30 May 2025 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748674465; x=1749279265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KKSGxiWUusF3NpXnt88RhyaalY1bWPLatpBLtUB9C8=;
        b=jKv1IX/WgNr6Gmu3mHmTRVBhn5rga9eeY74BlajMgpv6ccSI7e7CH1nuyvx0iOJ9me
         Yfn25TMITPSE2xgQ6JYLMhxPtXm+DvkFFPwOHWwAZDOnNvpWxXXXf0ug98DnuwOGy3pv
         x21Xif90nvkRyYohH6GWuWjeihiHFdEdcW0eJINtisgZVOTodqKIpl++tSeH01Drigss
         vRv3+18Gyq8gSn49dX1WtXPRQ4kveWSmo5nlFecZi+D57REPtMgz40qzHqYxF1+oiWqm
         7R/mgDnBM7AnCF+YjTQ+CzFijhQBeFlNlbLhqET8Jjr0C/WCXNJyJdm4hOmjNkEOGbc+
         jiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748674465; x=1749279265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KKSGxiWUusF3NpXnt88RhyaalY1bWPLatpBLtUB9C8=;
        b=Oq1NdQ8DkRbGvJCqgRWpHkXQzQhMT39nCStz2mMEZmUM/g9mhoyJvvNnNWAWinL+g+
         KLQctBGWs/jugDcz8ve7v/YEZI1v+aK4Scu4je3QLJ8rtsbSvEE5gz4b/+gZiq8Ihgvp
         F2gH0Rr+4GHsJx+wCIii9NG/5gjyU2l1+ODdt/U1HBXQ4r0WtHg7XZQaJIqW83Z9y5Ns
         RBHM8KpBUWB6n48b9d2iWMdcT+bu7kdLkPKF3EA9GKG8q1GEYdwhu8cmUxDBihHljAj2
         Im9myVpdWebn5uEiOVbW8Mm7iAfCqYW+qvwiEmUHGgJTgwhwxnXrFiU0/URxLFcVCZu5
         abgA==
X-Forwarded-Encrypted: i=1; AJvYcCVOhlXc3yDjPXX76/7pBpq71j+EAoqqorc0BR0AYn388KrwW1xv84iQxQ2k9A3eBD9GcZao4IqwylzxTDw=@vger.kernel.org, AJvYcCVwV2UOxOEK4UKNls2zwgu92pEnHlMu2OXJUUXiPNJ3tgcLygjvf1q8R+80efV3Y1vHYmwtSAqF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+R0FCA/xP141LROVQbyx8QTy0mQCT4EPNhMLZgDps9fYK7ifd
	1jy/fecGCYwuulpaWWK9Ot8/zQqcbUgzG/NzqoWGa9hkUCNQKmE18kK8SjRRDrt9GgjKfm7rts9
	+9NuA0Z8zRjA508OtMSL/NU03+rcOlhU=
X-Gm-Gg: ASbGncsVFdZLjhVlyZNxujPphH6pOnIgqnY/JFih6E4aghn9soejD0T+VeMXrSqW8Hw
	6lDBlXwd6+fNeOcGph7yTrv90/j8Fy66/WM72wwfStI6r61mcoBrPnMPSbbROhh4CU4O/ES2ueA
	fpk8IPYv0MRwakRltp7sO6T6ODDq4dJX0Z
X-Google-Smtp-Source: AGHT+IEjuXhc+XS1tob6iJMFsogLwCN5+7xydvAzxLaAFbdlYQ6806qWJBCm779QeK84FiteX/3OJ/MVWxfqcx3rjbA=
X-Received: by 2002:a2e:bc1e:0:b0:329:1302:a521 with SMTP id
 38308e7fff4ca-32a82378ac8mr40695291fa.2.1748674464504; Fri, 30 May 2025
 23:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CAGsJ_4wBMxQSeoTwpKoWwEGRAr=iohbYf64aYyJ55t0Z11FkwA@mail.gmail.com>
 <CAGsJ_4wM8Tph0Mbc-1Y9xNjgMPL7gqEjp=ArBuv3cJijHVXe6w@mail.gmail.com>
In-Reply-To: <CAGsJ_4wM8Tph0Mbc-1Y9xNjgMPL7gqEjp=ArBuv3cJijHVXe6w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 31 May 2025 14:54:07 +0800
X-Gm-Features: AX0GCFs7VJ_XozhddB2_YVsREaUzj3-1R3pIid7kwPCuF7uBRdjCty7q65Y57Qo
Message-ID: <CAMgjq7BoqyNLDir6YGEfLOFhn392VbX+3m6oVzFyg3g_7AQrGA@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 12:42=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
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

Even if it's not dropped, it's fine, the folio doesn belong to any VMA
in this case, and we don't need to move it.

The problem is the swapin succeed before step 4, and another swapout
also succeeded before step 4, so src folio will be left in the swap
cache belonging to src VMA.

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

Yes, that's exactly the case.

>
> Yep, we really need to re-check pte for swapcache after holding PTL.
>
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
>

