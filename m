Return-Path: <stable+bounces-148346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2892DAC99B4
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 08:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3CD9E7710
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5EB22F769;
	Sat, 31 May 2025 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laxKKMFt"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914D22DA0D;
	Sat, 31 May 2025 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748674471; cv=none; b=JoNybvnpa39wlWav7b7DLcZ/Ea2ZpXfu9crdNz/jms/wa/QL6gSKWuI71X7vkQ5hvTZD/ATUw3vNAjpNYO1RR8MKTRFdnae8z0nSZxCsc5w24XsAM127qzPMWSfoiD0sz8EkM08Kbc2iqRpXqwhBNQve9GiobHxmbYua/hq38Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748674471; c=relaxed/simple;
	bh=G1MJ9ZO0Qak9iNybW/AgNBbaXpjlDivgBxSIcV7M69Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pH2RyxATFjA8CXfTlGVBPp+bRbwKxuZ1k4cLestH30/pQ62uY4FH6FNrwHYazbBcqcQZ32N+G4E8/R+Trx4dllnR2cnaI/RekjLtmxKh5/T+sLiRK2rLxodA85W3FWz1FFnm4oH75AhfBGS/A0JFmdGJtiaDX3MF7X+XTjzNjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laxKKMFt; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e701c53c84so209792137.0;
        Fri, 30 May 2025 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748674468; x=1749279268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt9LCU4KtOp/peg997ydOztpCwzP+Qu3HWBp0qmR5aA=;
        b=laxKKMFtV8hMoxbxKli0UaU9KzC0zyx2q5Mak+azEZYaY6WNIicf9oMJd6SAxyPFSA
         lbQmJeca1KvDls2u5nHLHnoYEd1RXwcUgQiZRJcOdY3Gt6QEPgUEH5UMW85sBSL/KQdx
         8XXhGbTjbFKW/WEp2ndrdNjDMFA6FOIfMvQPk1rLMNcKTOJ4bvJMkh+RbngmrvTO7vBt
         Go4smN9oz4+e7n4jVC32nnN7GaUR/r8rKN49MvPwsobB4M8vkPF3YSMksw01Vjou+TO+
         +euYaMZJPRQm4rG8c0/YTFnkKv4R7Bx+dM8pS8Gked1dEzyOvQz8yC2YRUHFK/abK3dR
         pIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748674468; x=1749279268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mt9LCU4KtOp/peg997ydOztpCwzP+Qu3HWBp0qmR5aA=;
        b=DJ3XGDE0yLpDuJUlK9Ppp3Q6y3C2aiCwTp+p1Wqh8jcL7QPotaAmUAjDvYCI1zJjn5
         JXgw7xQgy8vfeq3CdGhxjq84eQd/HWubroJGAGcAtTdV3sAHcPSt3Qc6DFxKiQedD259
         AZ4d1GP9WMLH5bGI9b1qmtU/Jc0lNGkDtRrlTDFB0ELo6Qrsm74YSuDtDgZVbKjt3HFY
         3PeLelyK2xeNTBYRJuSI+rdaptQV94InaGVzre8COIEzmIvaU17xEBi6k+nzTQ6x6sUb
         dLkQvK7XFbg8+SQNsnVe5FptaZotv5T8KcFVVq3MCqPdn8XOnDE7Usu8vH3Gq0Ico6/U
         fy1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/o/6PPbOKS/1er1d+cv93I4KqTqkh5EjG4INC6MQDt4ECmMgDhwTy3fQZk0MM5MktnFKA15q5@vger.kernel.org, AJvYcCW5GKv3wBuHKe7dCQ0YTUwPDT63L+CzJ6pEgd1kSFUHrd42J07lYsCvRcObjsocyEcu7j8Z3Y0SdcG6jTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4n+YCSOlsN7QGn8hwnUUBcF2KKW7aUWupxPdcVKb/PPi+WFb
	J2PC05COX9YxgW6YZ1X+L4sc9LZZ7TOCiqQcyKAOq9zzQ74bJrjt4T8xQvJ83XGOB2p7lu6GFHQ
	EnlfNnE8YHynEKlwYvEWnCPDgZHG8nNuWBFOs
X-Gm-Gg: ASbGncuM8w0Qe9SNQGghnHFijzFU3si9AAPtI3ydt0h8y0t4maw1aiPa2BflfK8YKN2
	PCefOwR/v4g/K6I97dOoUa5Sb8gCbOjDkeYZc/wWzkmvOHg1TUZtUjZEDaLE/6csN+aMNty2b09
	5Xc97L8R5aoWuz3DU+YjXoHDC4/hnDllJsVw==
X-Google-Smtp-Source: AGHT+IGRBxa3bLwqvjUcM5rSwBr4KjoL/kPcL0HkCbthe4esfOCzO4sYQL2vNy8Tg6EwJuWuhd/4wxdWTxUkF5LGpyA=
X-Received: by 2002:a05:6102:3ed4:b0:4e5:c51b:ace4 with SMTP id
 ada2fe7eead31-4e701b098d7mr426437137.20.1748674468415; Fri, 30 May 2025
 23:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CAGsJ_4wBMxQSeoTwpKoWwEGRAr=iohbYf64aYyJ55t0Z11FkwA@mail.gmail.com>
 <CAGsJ_4wM8Tph0Mbc-1Y9xNjgMPL7gqEjp=ArBuv3cJijHVXe6w@mail.gmail.com>
 <CA+EESO7Gck6YpjPTMSzDGcmRXjci=zG3i8F+LTt=u2Krbp_cRg@mail.gmail.com> <CAMgjq7D10Pw6miYZvN-2stOw04iho1Z-HTb4Udo0L_1kaMgKWg@mail.gmail.com>
In-Reply-To: <CAMgjq7D10Pw6miYZvN-2stOw04iho1Z-HTb4Udo0L_1kaMgKWg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 May 2025 18:54:17 +1200
X-Gm-Features: AX0GCFuHIXE2nFc8E8Epyk2nWAYLEJ8Eun1d22K4Wew4_rSLkb6MQIrwV6xiJO0
Message-ID: <CAGsJ_4zBYhBuQmGGfbQnaGBjw5RwR2szfJxnQfF0i8=wEXbuxg@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 6:36=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, May 31, 2025 at 2:10=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.=
com> wrote:
> >
> > On Fri, May 30, 2025 at 9:42=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Sat, May 31, 2025 at 4:04=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > On Sat, May 31, 2025 at 8:17=E2=80=AFAM Kairui Song <ryncsn@gmail.c=
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
> > > > > +               if (!IS_ERR_OR_NULL(src_folio)) {
> > > > > +                       double_pt_unlock(dst_ptl, src_ptl);
> > > > > +                       folio_put(src_folio);
> > > > > +                       return -EAGAIN;
> > > > > +               }
> > > > >         }
> > > >
> > > > step 1: src pte points to a swap entry without swapcache
> > > > step 2: we call move_swap_pte()
> > > > step 3: someone swap-in src_pte by swap_readhead() and make src_pte=
's swap entry
> > > > have swapcache again - for non-sync/non-zRAM swap device;
> > > > step 4: move_swap_pte() gets ptl, move src_pte to dst_pte and *clea=
r* src_pte;
> > > > step 5: do_swap_page() for src_pte holds the ptl and found pte has
> > > > been cleared in
> > > >             step 4; pte_same() returns false;
> > > > step 6: do_swap_page() won't map src_pte to the new swapcache got f=
rom step 3;
> > > >             if the swapcache folio is dropped, it seems everything =
is fine.
> > > >
> > > > So the real issue is that do_swap_page() doesn=E2=80=99t drop the n=
ew swapcache
> > > > even when pte_same() returns false? That means the dst_pte swap-in
> > > > can still hit the swap cache entry brought in by the src_pte's swap=
-in?
> > >
> > > It seems also possible for the sync zRAM device.
> > >
> > >  step 1: src pte points to a swap entry S without swapcache
> > >  step 2: we call move_swap_pte()
> > >  step 3: someone swap-in src_pte by sync path, no swapcache; swap slo=
t
> > > S is freed.
> > >              -- for zRAM;
> > >  step 4: someone swap-out src_pte, get the exactly same swap slot S a=
s step 1,
> > >              adds folio to swapcache due to swapout;
> > >  step 5: move_swap_pte() gets ptl and finds page tables are stable
> > > since swap-out
> > >              happens to have the same swap slot as step1;
> > >  step 6: we clear src_pte, move src_pte to dst_pte; but miss to move =
the folio.
> > >
> > > Yep, we really need to re-check pte for swapcache after holding PTL.
> > >
> > Any idea what is the overhead of filemap_get_folio()? In particular,
> > when no folio exists for the given entry, how costly is it?
> >
> > Given how rare it is, unless filemap_get_folio() is cheap for 'no
> > folio' case, if there is no way to avoid calling it after holding PTL,
> > then we should do it only once at that point. If a folio is returned,
> > then like in the pte_present() case, we attempt folio_trylock() with
> > PTL held, otherwise do the retry dance.
>
> Yeah I think filemap_get_folio is cheap, each swap cache space is at
> most 64M big, so it just walks at most three xa_nodes and returns, not
> involving any synchronization or write.
>
> The swap cache lookup will be even cheaper in the future to be just
> checking one plain array element.
>
> I can try to fix this with the folio_trylock inside the PTL lock
> approach, maybe the code will be cleaner that way.

Using trylock in an atomic context and deferring to a full lock in a
non-atomic context might be considered a workaround =E2=80=94 it feels a bi=
t
hackish to me :-)

To follow that, the reader might need to understand the entire workflow
from kernel to userspace to grasp what's happening with the folio lock,
whereas the current code handles everything within the kernel, making it
more natural.

Thanks
Barry

