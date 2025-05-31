Return-Path: <stable+bounces-148344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E83AAC99A1
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 08:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9A74A489E
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 06:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036AA22D78F;
	Sat, 31 May 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6rMuGVa"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5871B81D3;
	Sat, 31 May 2025 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748673393; cv=none; b=IoU7IGsK/nVuXK6G5Os1pKzflNevaecFGDRJKq7B1xjmtB0GrbFs8G1Xq71HJtgHejYqZwl3B1+TjbmhiHimCnaMSgm5aQJE89P7qJZLMZecbtLSaii01yvH7U4iiOPX9flN+8yN0r11iPL646aBXfX/Ldwv5RhgUOa+s3WLmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748673393; c=relaxed/simple;
	bh=D0vQoDuXadB7RpcZ57c1POsumZtMttNpfLvTO80/zGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnmbNPgNjyCKgSRKUutChPn7c5R/dsbrMl0vnwgRMLNUukMeAAfhb+UQ7MIwCN+GLLSrR9j3hedUiBTinFsyxIR4HQJygTav1NiPyhGmP74WIY090OGjVJae8yQnxOWl/n8xT0sl7ywP5gyvXpFS3iTeaOyKLF/WGF1VVatpxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6rMuGVa; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32a63ff3bdfso21838191fa.3;
        Fri, 30 May 2025 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748673390; x=1749278190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/BmoDNXQwduqlIZzmWZXOyqj/fMIT70s0zMx8YqFyY=;
        b=P6rMuGVaDWea+4Tm+jpCU6tv1ychy+WQYguOIya+AW3DRd63Up6veNOtu7XHJVZJ1o
         JWvJepbsexUEwyHEUlIDRTBtLi+Hyf7W+rWrab8l9B5atIOzmCpq+hXrdJx2f9Uj498q
         amE/ytOva1k7RysSx0JFG7oOFzTStaUHF3M7HargrnwU+Bsa3TcQXCLxJvNizyA0S6uw
         GOhltAfswh2HYWZpXwXek6G9Sp6hMiM1mgRRQfWAp+qwOgqUVpSoRvvJevgCv8rqJnYf
         uEnTUpcYsZ5JLBjz+SCq61UYW0vkpboiKSqE+JxBO0fK1Q/kfbFVDa/74F2CmGOnzf//
         Y1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748673390; x=1749278190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/BmoDNXQwduqlIZzmWZXOyqj/fMIT70s0zMx8YqFyY=;
        b=l0gQI6EtIS7W8BHO7facDQ7jYAI5QfwJq6DECyprrHzXjKM0fBWd2Xf4rWxyFN1i5s
         2hgLzt21eoxapuVF5tEdkWRYPZg/sqYoCcFXx+SXLY3KbGzn5OfKMVlGUPP1tFg4tTAM
         4gG5xYdHrv0jNvT7xH+EC4wLQSP8Rz/5ujsOzR7RPQZaUMrP0XhszYDKHP9Ws4OZ66YI
         JO5Ws9MUOw0q3EmMxmf20KmGBywsrQffgGZVUX9EQ9EMtyQj5YSHSS7+X+jJokPp9UHG
         EivRR2Bj80x7axyMb1KVjohmSv1a7YeKl81qeii2rZqfEKGSUBAhsseu0C01sXI/dX4v
         Pjyg==
X-Forwarded-Encrypted: i=1; AJvYcCU4lsLrMglygiu8kcAe39FZ1GbIjea1vLMbLayLuogDslARYAgaTCrYoKQ3IBBVlcpvf/EFzdNhf5N3N0Y=@vger.kernel.org, AJvYcCX7UhQ5EGnbKRxhgUANDJRlpJvzYImmOMiszun25iyNg7t9Gwb+JscDS8DWx6l1bnILyHNrwO36@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhC1zsX2kKvqyFKReMmEN5Gz2vBUmXH8bEFysPoKNChNlnwS8
	aoa6bcNUmerfZNQ6LoJnXl1rtThVMxaDqOuC9mo0xUEQXX/VtT51j4jDWSoFYPdi8AKQzHtp6bD
	d30NRu39W8dbAXNhNc6MZkz9MxlohUbfEEjTfHUrPBQ==
X-Gm-Gg: ASbGncv9DBwWEm7FyELFGTuDt4y5McI6njDtsAbMjFfVbZxASlgwJ5/oGzEJXni8spq
	usR6LY6r4COY3+W52O5GMl9kHKmwF1T7NOe74HCMwgaMVyLWwMXu09LQw6hEUhwb/KZjSrVdxny
	VFvsSb0P7RUD2i0MZsp2py6yOpq1AJx0Nt
X-Google-Smtp-Source: AGHT+IGS+8zInVTEalAvw6lUhSsBpRvCGIuCKi3iQOkea3Fr6ApWHCsNgurueZz8XEZYCyJZmcr/XV8pjyvmWe80Gvg=
X-Received: by 2002:a05:651c:3617:b0:30b:d562:c154 with SMTP id
 38308e7fff4ca-32a9ea3bb47mr3546451fa.19.1748673389221; Fri, 30 May 2025
 23:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CAGsJ_4wBMxQSeoTwpKoWwEGRAr=iohbYf64aYyJ55t0Z11FkwA@mail.gmail.com>
 <CAGsJ_4wM8Tph0Mbc-1Y9xNjgMPL7gqEjp=ArBuv3cJijHVXe6w@mail.gmail.com> <CA+EESO7Gck6YpjPTMSzDGcmRXjci=zG3i8F+LTt=u2Krbp_cRg@mail.gmail.com>
In-Reply-To: <CA+EESO7Gck6YpjPTMSzDGcmRXjci=zG3i8F+LTt=u2Krbp_cRg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 31 May 2025 14:36:11 +0800
X-Gm-Features: AX0GCFshAi5xaCYNNOadtBW6k_pLyhFYFBRbCnnGh9C67-Jw3R-U6Uz_6qQb9PM
Message-ID: <CAMgjq7D10Pw6miYZvN-2stOw04iho1Z-HTb4Udo0L_1kaMgKWg@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 2:10=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> On Fri, May 30, 2025 at 9:42=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Sat, May 31, 2025 at 4:04=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Sat, May 31, 2025 at 8:17=E2=80=AFAM Kairui Song <ryncsn@gmail.com=
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
> > > > +               if (!IS_ERR_OR_NULL(src_folio)) {
> > > > +                       double_pt_unlock(dst_ptl, src_ptl);
> > > > +                       folio_put(src_folio);
> > > > +                       return -EAGAIN;
> > > > +               }
> > > >         }
> > >
> > > step 1: src pte points to a swap entry without swapcache
> > > step 2: we call move_swap_pte()
> > > step 3: someone swap-in src_pte by swap_readhead() and make src_pte's=
 swap entry
> > > have swapcache again - for non-sync/non-zRAM swap device;
> > > step 4: move_swap_pte() gets ptl, move src_pte to dst_pte and *clear*=
 src_pte;
> > > step 5: do_swap_page() for src_pte holds the ptl and found pte has
> > > been cleared in
> > >             step 4; pte_same() returns false;
> > > step 6: do_swap_page() won't map src_pte to the new swapcache got fro=
m step 3;
> > >             if the swapcache folio is dropped, it seems everything is=
 fine.
> > >
> > > So the real issue is that do_swap_page() doesn=E2=80=99t drop the new=
 swapcache
> > > even when pte_same() returns false? That means the dst_pte swap-in
> > > can still hit the swap cache entry brought in by the src_pte's swap-i=
n?
> >
> > It seems also possible for the sync zRAM device.
> >
> >  step 1: src pte points to a swap entry S without swapcache
> >  step 2: we call move_swap_pte()
> >  step 3: someone swap-in src_pte by sync path, no swapcache; swap slot
> > S is freed.
> >              -- for zRAM;
> >  step 4: someone swap-out src_pte, get the exactly same swap slot S as =
step 1,
> >              adds folio to swapcache due to swapout;
> >  step 5: move_swap_pte() gets ptl and finds page tables are stable
> > since swap-out
> >              happens to have the same swap slot as step1;
> >  step 6: we clear src_pte, move src_pte to dst_pte; but miss to move th=
e folio.
> >
> > Yep, we really need to re-check pte for swapcache after holding PTL.
> >
> Any idea what is the overhead of filemap_get_folio()? In particular,
> when no folio exists for the given entry, how costly is it?
>
> Given how rare it is, unless filemap_get_folio() is cheap for 'no
> folio' case, if there is no way to avoid calling it after holding PTL,
> then we should do it only once at that point. If a folio is returned,
> then like in the pte_present() case, we attempt folio_trylock() with
> PTL held, otherwise do the retry dance.

Yeah I think filemap_get_folio is cheap, each swap cache space is at
most 64M big, so it just walks at most three xa_nodes and returns, not
involving any synchronization or write.

The swap cache lookup will be even cheaper in the future to be just
checking one plain array element.

I can try to fix this with the folio_trylock inside the PTL lock
approach, maybe the code will be cleaner that way.

