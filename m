Return-Path: <stable+bounces-150703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B793FACC5C5
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC003A289E
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85696229B12;
	Tue,  3 Jun 2025 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD3U2aQ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C03597C;
	Tue,  3 Jun 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748951352; cv=none; b=TBNidhoUQ5HXwIOe7paI3ik+gK1ghDLBR7WT5k58Xb14cm3yYvoZa8lvQYrdVAuW5b9Yg2VT7l1XH6I7XKLxD/LMM30Yh8nMuoyRBLE8VS8mapY4/hGQwkfv9ZN/RZroUrAVZAayAZiljklD4hLn/QvmPgJ1k8peRSXA5MEvckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748951352; c=relaxed/simple;
	bh=YFRAfVQT/IsrC7NSXrBMkZvKbXmwtLxA+4zLmBoHs28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaKJq6kTZDdZdAIqbb4u+/N3X2n15SjH8JL3JsRFHsjpCmt/yfgEHkGxwAAbOSElEpdxAAjvP7XmiMzVjOg1PhNf+1CroQgGJILQV6J3JBk3ZhWSuOZzM+pvjXnfRclZQN0GYulj7Z43MhBg9ZkZ+VLaaN7pfo3FC9Eu5cqb+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CD3U2aQ/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32a6a91f0easo19269511fa.0;
        Tue, 03 Jun 2025 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748951348; x=1749556148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDRcA+T6Fi9CfWPBz64dW6ekkPgHNPPDc7aXpEK7++Y=;
        b=CD3U2aQ/IzPDCgctsrJr8CtSpIcrUsWP45k4NLzDOpBKMlbbwBO1VHvUM7j17wiWDI
         CwYEg4btbDoeGb74H81HWupn8j1lLyz1uW5DiQ8fbUky6puUJx6CQ+cjohriirTSckha
         y89UHxVJvlLJywEf9jCgVzQElFyTVbKKKIW9m6CANh2OWwtV61UKqbLHj0nFXCAO5zZ7
         I8wSPSaznALYsdkhsGWUma0VUuQx84+puBJ3fLUccvJW7FMBSv2UVJ4/4IjYFWOqhlGM
         Iw9XRbVsmhBMvbPPWoh7lfDaJwrDjS460dN+O5uiWUzXWo+k6cn24w23tPGu2HXxuCUa
         aaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748951348; x=1749556148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDRcA+T6Fi9CfWPBz64dW6ekkPgHNPPDc7aXpEK7++Y=;
        b=aSpE/dhXWqRTvQ7GkgNQDG5sxa8jl/FHp/Abjb83VGoTER+jUuYvkkwLucelYrVAnc
         pmBAMBVH1k+SyM2jJ5UZB5ST0roMl55lOTDOCT0+67KApqTD7nAG82P9RxLrIyFwbKwA
         mvCfNge3mWDeTH1SFSjZyZGP5Hns5F3D3svirGmuAZDvklvmmbAkVxlDfIUD68hovQhA
         WGlQmGJxkNGK4ZfE0dRavDzAPpH6KzTLv51uVsobcBdfItvSMgGsvWj9Oz4zhkMqDhnK
         TykoFjeuu3fFJH3L7vX6QNhY6S6xx9o9aG4Sm448O+sm3XMuozxQhfAmgt2L9WbSeOBC
         XnfA==
X-Forwarded-Encrypted: i=1; AJvYcCUPZjKzMKH6e6IK+D5YsCrzbsmiADOBrrjgg6ElYVrOW5Mik7YV1o0PZWbrNVaVrz7TjkmQ0wbf@vger.kernel.org, AJvYcCUoR9yDBvjsF4/KqUpbqUDK+WBHFQK5cnRGMQF9dMeCimugVkPwfAcpcORcoQQLW8NmH2uZHLRGv4SyfLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3sna9fHlz6k7JeE5C+TpyjgLduRItqeb5T0ic2EhgtfRZX0W
	LcjM1VKZOYt61UFyKFd93oFALsbFr0n7WUFIac1vnAZ1/C+nEhbwB4f6YTh53dwD8usYClg5+F4
	Hkq7d56XctBaG5yicLml0FWr2evUKA5A54gF9TWs=
X-Gm-Gg: ASbGnctdGBRIuR+GLTDbp3A7Y2PH1y6iahYgHAGhCFITItQQ3i4BYaFCpyGXNA/nO17
	qtC9nHqbHwq4VdFzhiN1eZeBy1agdWTqlMMnNZCX9Fd/ABwY5W0o5nLJwrjMXkxK8fEeJpOztdD
	E3tWlOjAfzcXnp47TsZBLu7zVPNVP9LDygwXzLCNTqCqY=
X-Google-Smtp-Source: AGHT+IGM/SASzWhhUTrY3uUzMWyJSMweqBgIdXZyU0E7noNfgJkGiCnAdF8at5x8bukX8dJz5+IH+N1p4N9YAoNkADk=
X-Received: by 2002:a2e:bc19:0:b0:32a:7a2d:a589 with SMTP id
 38308e7fff4ca-32a906cec93mr41852711fa.13.1748951347781; Tue, 03 Jun 2025
 04:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602181419.20478-1-ryncsn@gmail.com> <aD4KyHz_H5WPLLf4@x1.local>
 <CAGsJ_4wbU=4ECxNPEB0dKGXibrAKuR-N3i8wwmVCYAgWCuupnQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wbU=4ECxNPEB0dKGXibrAKuR-N3i8wwmVCYAgWCuupnQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 3 Jun 2025 19:48:49 +0800
X-Gm-Features: AX0GCFvpZgb4jbkGTHBdzZSITw6Z_SdDPq42ADh9_afW-sX_weoyjolG37LBaHQ
Message-ID: <CAMgjq7C_nVynRpMV8xkyVuhpyDY6qZX_ShzxChen5Fh5gXSJVg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Barry Song <21cnbao@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 6:08=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Tue, Jun 3, 2025 at 8:34=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
> >
> > On Tue, Jun 03, 2025 at 02:14:19AM +0800, Kairui Song wrote:
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
> >
> > [1]
> >
> > >
> > > Testing with a simple C program to allocate and move several GB of me=
mory
> > > did not show any observable performance change.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCz=
i+EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > >
> > > ---
> > >
> > > V1: https://lore.kernel.org/linux-mm/20250530201710.81365-1-ryncsn@gm=
ail.com/
> > > Changes:
> > > - Check swap_map instead of doing a filemap lookup after acquiring th=
e
> > >   PTE lock to minimize critical section overhead [ Barry Song, Lokesh=
 Gidra ]
> > >
> > > V2: https://lore.kernel.org/linux-mm/20250601200108.23186-1-ryncsn@gm=
ail.com/
> > > Changes:
> > > - Move the folio and swap check inside move_swap_pte to avoid skippin=
g
> > >   the check and potential overhead [ Lokesh Gidra ]
> > > - Add a READ_ONCE for the swap_map read to ensure it reads a up to da=
ted
> > >   value.
> > >
> > >  mm/userfaultfd.c | 23 +++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index bc473ad21202..5dc05346e360 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -1084,8 +1084,18 @@ static int move_swap_pte(struct mm_struct *mm,=
 struct vm_area_struct *dst_vma,
> > >                        pte_t orig_dst_pte, pte_t orig_src_pte,
> > >                        pmd_t *dst_pmd, pmd_t dst_pmdval,
> > >                        spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > > -                      struct folio *src_folio)
> > > +                      struct folio *src_folio,
> > > +                      struct swap_info_struct *si, swp_entry_t entry=
)
> > >  {
> > > +     /*
> > > +      * Check if the folio still belongs to the target swap entry af=
ter
> > > +      * acquiring the lock. Folio can be freed in the swap cache whi=
le
> > > +      * not locked.
> > > +      */
> > > +     if (src_folio && unlikely(!folio_test_swapcache(src_folio) ||
> > > +                               entry.val !=3D src_folio->swap.val))
> > > +             return -EAGAIN;
> > > +
> > >       double_pt_lock(dst_ptl, src_ptl);
> > >
> > >       if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_s=
rc_pte,
> > > @@ -1102,6 +1112,15 @@ static int move_swap_pte(struct mm_struct *mm,=
 struct vm_area_struct *dst_vma,
> > >       if (src_folio) {
> > >               folio_move_anon_rmap(src_folio, dst_vma);
> > >               src_folio->index =3D linear_page_index(dst_vma, dst_add=
r);
> > > +     } else {
> > > +             /*
> > > +              * Check if the swap entry is cached after acquiring th=
e src_pte
> > > +              * lock. Or we might miss a new loaded swap cache folio=
.
> > > +              */
> > > +             if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_H=
AS_CACHE) {
> >
> > Do we need data_race() for this, if this is an intentionally lockless r=
ead?
>
> Not entirely sure. But I recommend this pattern, borrowed from
> zap_nonpresent_ptes() -> free_swap_and_cache_nr(),
> where the PTL is also held and READ_ONCE is used.
>
>                 if (READ_ONCE(si->swap_map[offset]) =3D=3D SWAP_HAS_CACHE=
) {
>                        ..
>                         nr =3D __try_to_reclaim_swap(si, offset,
>                                                    TTRS_UNMAPPED | TTRS_F=
ULL);
>
>                         if (nr =3D=3D 0)
>                                 nr =3D 1;
>                         else if (nr < 0)
>                                 nr =3D -nr;
>                         nr =3D ALIGN(offset + 1, nr) - offset;
>                 }

Thanks for the explanation, I also agree that holding PTL here is good
enough here.

>
> I think we could use this to further optimize the existing
> filemap_get_folio(), since in the vast majority of cases we don't
> have a swapcache, yet we still always call filemap_get_folio().
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index bc473ad21202..c527ec73c3b4 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
>
> @@ -1388,7 +1388,7 @@ static int move_pages_pte(struct mm_struct *mm,
> pmd_t *dst_pmd, pmd_t *src_pmd,
>                  * folios in the swapcache. This issue needs to be resolv=
ed
>                  * separately to allow proper handling.
>                  */
>
> -               if (!src_folio)
> +               if (!src_folio & (swap_map[offset] & SWAP_HAS_CACHE))
>                         folio =3D filemap_get_folio(swap_address_space(en=
try),
>                                         swap_cache_index(entry));
>                 if (!IS_ERR_OR_NULL(folio)) {
>
> To be future-proof, we may want to keep the READ_ONCE to ensure
> the compiler doesn't skip the second read inside move_swap_pte().

Maybe we can do this optimization in another patch I think.

>
> >
> > Another pure swap question: the comment seems to imply this whole thing=
 is
> > protected by src_pte lock, but is it?
> >
> > I'm not familiar enough with swap code, but it looks to me the folio ca=
n be
> > added into swap cache and set swap_map[] with SWAP_HAS_CACHE as long as=
 the
> > folio is locked.  It doesn't seem to be directly protected by pgtable l=
ock.
> >
> > Perhaps you meant this: since src_pte lock is held, then it'll serializ=
e
> > with another thread B concurrently swap-in the swap entry, but only _la=
ter_
> > when thread B's do_swap_page() will check again on pte_same(), then it'=
ll
> > see the src pte gone (after thread A uffdio_move happened releasing src=
_pte
> > lock), hence thread B will release the newly allocated swap cache folio=
?
> >
> > There's another trivial detail that IIUC pte_same() must fail because
> > before/after the uffdio_move the swap entry will be occupied so no way =
to
> > have it reused, hence src_pte, even if re-populated again after uffdio_=
move
> > succeeded, cannot become the orig_pte (points to the swap entry in
> > question) that thread B read, hence pte_same() must check fail.
>
> in v1 of this patch, we had some similar discussions [1][2]:
>
> [1] https://lore.kernel.org/linux-mm/CAGsJ_4wBMxQSeoTwpKoWwEGRAr=3DiohbYf=
64aYyJ55t0Z11FkwA@mail.gmail.com/
> [2] https://lore.kernel.org/linux-mm/CAGsJ_4wM8Tph0Mbc-1Y9xNjgMPL7gqEjp=
=3DArBuv3cJijHVXe6w@mail.gmail.com/
>
> At the very least, [2] is possible, although the probability is extremely=
 low.
>
> "It seems also possible for the sync zRAM device.
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
>
> Yep, we really need to re-check pte for swapcache after holding PTL.
> "
>
> Personally, I agree that improving the changelog or the comments
> would be more helpful. In fact, there are two bugs here, and Kairui=E2=80=
=99s
> changelog clearly describes the first one.

Yeah, the first one is quite a long and complex race already, so I
made the description on the second issue shorter. I thought it
wouldn't be too difficult to understand given the first example. I can
add some more details.

