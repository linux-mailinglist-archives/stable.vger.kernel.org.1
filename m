Return-Path: <stable+bounces-150632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B0DACBD0D
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 00:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BE918909FE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186AA2522BE;
	Mon,  2 Jun 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US+qd65r"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160279E1;
	Mon,  2 Jun 2025 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748902103; cv=none; b=C2HxlJvVNY2ngiHjVWkuV5Etzwfoy2sALT9pfYmuOABiFLp5DwvlMDM1/MsVmNNES3Dckd507s8pDxYFF5jQkWZr5lEWjtx674Pit28smsZ7YtNuw8iDv6lctdYHmWu9bMss67fha+3a/Z+fSNOJzrgzHWbEbXwIqipqPiiOBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748902103; c=relaxed/simple;
	bh=KinW92haDtNqhQ3SVgwTtNpKMUTQCYNye7bOybDG+qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ir58VklwigAK5majI7BQ5Yc+os8KMV0cHdIQxB94PMlPrSov06DhKHo40lI/FXnzqC84F1YWWZ/dukPkgWVC5VWFzdeP8NKUFSnPR1RybNBVQWvSfxuADvGbe2oGAPX8Iuxxpp3R7/+U+ASJ1tH+4d807LcuhNFWbJudiu+Szeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US+qd65r; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87de3223127so1281327241.1;
        Mon, 02 Jun 2025 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748902101; x=1749506901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1bjsXpVHOI5ZIszrbadfu9xBNyVRNiAQcBU5726rrk=;
        b=US+qd65rWyY6hSbQJ0YzP7VaHEqKG+bbww1yMIC6DBtpqYhj5M/gx1jqjs88bXNclV
         0cBnkhPHr7mbXwc5+pjYvb7V0RDpJzouv2ssWAjkZorOdWwvIiSwv9S5T4mRR1ALkpu/
         51C7nnvjRFIcF4Wm1AwDf343RZrJJPPTlCwDeYMm6snkIuEkZiZYcz9a86V/30v+7czE
         LR4e8/alVdE7LUCGUwSbQp2nR2VBS3KnexZZDl7mdL4WiK0MWNmSweGCCffmUxYjhPwI
         k+3ibICQERmtHdCLiNMF9CPV7gK5P8qlWR8pMcyzfaiftwWbGMwM8u0TGWvq/pZn2PMl
         Yo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748902101; x=1749506901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1bjsXpVHOI5ZIszrbadfu9xBNyVRNiAQcBU5726rrk=;
        b=mC7fhpKDm2fQlMoFfXP8bjCWNL1LC/ch9i18fQvygkAUeF+Kj5j4xkeGEMcOTjH1M7
         Yf5U/rIKrWxOHAaPc5u+5Rfx/qvbVccJiSPCdDqs2G8BnCGppArMoffnSrdhG1SWUbPM
         e0iUTLSB5HHRcmCEHqPRKroNZQufZGg4/YPePsJq/Xa476gdLd0SG2sQiBvsyqqi4eZk
         3FDXQBGupucpwngtcMpZbss3tAISg1qvxqHs6+vMM4FME0kJFf+uNx73b32fOzo/cTTJ
         4iT4X17BWvB+xzTOikSutt8uKymR/8VnngwEKcCopF5MYYhJe4JYkBB+apwqB3nddZtn
         uFOg==
X-Forwarded-Encrypted: i=1; AJvYcCWaBXoKgadQ7cFGPn+55zaP77a2bLlfTxx2eiSKj8CMVGu2xbwQ4F/Gd/VkSXl2JOMRWccL5OF/@vger.kernel.org, AJvYcCXBZJ6+dmXvZhHhpIZanTl2Glpfnb8aqRSzIXdXFNLU96P3QFt1UpTQ4tytcDYsDPNMcQVcEdc2JSB+cwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74JH873kMSLj5Bqxfe/g4zdf0PycBMTPYXfIA3RcP+KlZaDv7
	kuNGbem85hedLDmO9+LmJ9pd3Y6y1sDp5k5Jevd7jckME/mt38kyhZ8sHIvtYA++W9OJsKdc0yN
	LNAyUfPogdEaGSEEkXZ6aSPB8PvscU8A=
X-Gm-Gg: ASbGncvlk1cDotFJKzRqs/UuhPosedD39M18GOLys+2xjZroNXIPrzTlhj8RyWIPbei
	5z4wUxyyLASFRLEaetimRIPY+uaP3ga3prr89SjWF5O8Eh5ld5aH7Spthy2FjmhH/Uv6dDiwLgv
	ysXixAVZ2jHJTrCGbYZOUptA17rdnmvFyDShFC6OoxJwfd
X-Google-Smtp-Source: AGHT+IGNzI60dSLYollS+mg1gFdbjGQgBOwciHiqeEYkQr4lRCqkU+jWMdSSFqE/VxcsypKoP75InS1VD/0jqAG3uK8=
X-Received: by 2002:a05:6102:158f:b0:4e5:8b76:44c5 with SMTP id
 ada2fe7eead31-4e6ece6b680mr11090213137.22.1748902100639; Mon, 02 Jun 2025
 15:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602181419.20478-1-ryncsn@gmail.com> <aD4KyHz_H5WPLLf4@x1.local>
In-Reply-To: <aD4KyHz_H5WPLLf4@x1.local>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 3 Jun 2025 10:08:09 +1200
X-Gm-Features: AX0GCFun4bSH_h7lkhTVyMQ2zfLiYUNalUUqsAC0LS2LaJcC3bsiH3TSJR3c5h0
Message-ID: <CAGsJ_4wbU=4ECxNPEB0dKGXibrAKuR-N3i8wwmVCYAgWCuupnQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Peter Xu <peterx@redhat.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:34=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jun 03, 2025 at 02:14:19AM +0800, Kairui Song wrote:
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
>
> [1]
>
> >
> > Testing with a simple C program to allocate and move several GB of memo=
ry
> > did not show any observable performance change.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCzi+=
EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> >
> > ---
> >
> > V1: https://lore.kernel.org/linux-mm/20250530201710.81365-1-ryncsn@gmai=
l.com/
> > Changes:
> > - Check swap_map instead of doing a filemap lookup after acquiring the
> >   PTE lock to minimize critical section overhead [ Barry Song, Lokesh G=
idra ]
> >
> > V2: https://lore.kernel.org/linux-mm/20250601200108.23186-1-ryncsn@gmai=
l.com/
> > Changes:
> > - Move the folio and swap check inside move_swap_pte to avoid skipping
> >   the check and potential overhead [ Lokesh Gidra ]
> > - Add a READ_ONCE for the swap_map read to ensure it reads a up to date=
d
> >   value.
> >
> >  mm/userfaultfd.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index bc473ad21202..5dc05346e360 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1084,8 +1084,18 @@ static int move_swap_pte(struct mm_struct *mm, s=
truct vm_area_struct *dst_vma,
> >                        pte_t orig_dst_pte, pte_t orig_src_pte,
> >                        pmd_t *dst_pmd, pmd_t dst_pmdval,
> >                        spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > -                      struct folio *src_folio)
> > +                      struct folio *src_folio,
> > +                      struct swap_info_struct *si, swp_entry_t entry)
> >  {
> > +     /*
> > +      * Check if the folio still belongs to the target swap entry afte=
r
> > +      * acquiring the lock. Folio can be freed in the swap cache while
> > +      * not locked.
> > +      */
> > +     if (src_folio && unlikely(!folio_test_swapcache(src_folio) ||
> > +                               entry.val !=3D src_folio->swap.val))
> > +             return -EAGAIN;
> > +
> >       double_pt_lock(dst_ptl, src_ptl);
> >
> >       if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> > @@ -1102,6 +1112,15 @@ static int move_swap_pte(struct mm_struct *mm, s=
truct vm_area_struct *dst_vma,
> >       if (src_folio) {
> >               folio_move_anon_rmap(src_folio, dst_vma);
> >               src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
> > +     } else {
> > +             /*
> > +              * Check if the swap entry is cached after acquiring the =
src_pte
> > +              * lock. Or we might miss a new loaded swap cache folio.
> > +              */
> > +             if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS=
_CACHE) {
>
> Do we need data_race() for this, if this is an intentionally lockless rea=
d?

Not entirely sure. But I recommend this pattern, borrowed from
zap_nonpresent_ptes() -> free_swap_and_cache_nr(),
where the PTL is also held and READ_ONCE is used.

                if (READ_ONCE(si->swap_map[offset]) =3D=3D SWAP_HAS_CACHE) =
{
                       ..
                        nr =3D __try_to_reclaim_swap(si, offset,
                                                   TTRS_UNMAPPED | TTRS_FUL=
L);

                        if (nr =3D=3D 0)
                                nr =3D 1;
                        else if (nr < 0)
                                nr =3D -nr;
                        nr =3D ALIGN(offset + 1, nr) - offset;
                }

I think we could use this to further optimize the existing
filemap_get_folio(), since in the vast majority of cases we don't
have a swapcache, yet we still always call filemap_get_folio().

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bc473ad21202..c527ec73c3b4 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c

@@ -1388,7 +1388,7 @@ static int move_pages_pte(struct mm_struct *mm,
pmd_t *dst_pmd, pmd_t *src_pmd,
                 * folios in the swapcache. This issue needs to be resolved
                 * separately to allow proper handling.
                 */

-               if (!src_folio)
+               if (!src_folio & (swap_map[offset] & SWAP_HAS_CACHE))
                        folio =3D filemap_get_folio(swap_address_space(entr=
y),
                                        swap_cache_index(entry));
                if (!IS_ERR_OR_NULL(folio)) {

To be future-proof, we may want to keep the READ_ONCE to ensure
the compiler doesn't skip the second read inside move_swap_pte().

>
> Another pure swap question: the comment seems to imply this whole thing i=
s
> protected by src_pte lock, but is it?
>
> I'm not familiar enough with swap code, but it looks to me the folio can =
be
> added into swap cache and set swap_map[] with SWAP_HAS_CACHE as long as t=
he
> folio is locked.  It doesn't seem to be directly protected by pgtable loc=
k.
>
> Perhaps you meant this: since src_pte lock is held, then it'll serialize
> with another thread B concurrently swap-in the swap entry, but only _late=
r_
> when thread B's do_swap_page() will check again on pte_same(), then it'll
> see the src pte gone (after thread A uffdio_move happened releasing src_p=
te
> lock), hence thread B will release the newly allocated swap cache folio?
>
> There's another trivial detail that IIUC pte_same() must fail because
> before/after the uffdio_move the swap entry will be occupied so no way to
> have it reused, hence src_pte, even if re-populated again after uffdio_mo=
ve
> succeeded, cannot become the orig_pte (points to the swap entry in
> question) that thread B read, hence pte_same() must check fail.

in v1 of this patch, we had some similar discussions [1][2]:

[1] https://lore.kernel.org/linux-mm/CAGsJ_4wBMxQSeoTwpKoWwEGRAr=3DiohbYf64=
aYyJ55t0Z11FkwA@mail.gmail.com/
[2] https://lore.kernel.org/linux-mm/CAGsJ_4wM8Tph0Mbc-1Y9xNjgMPL7gqEjp=3DA=
rBuv3cJijHVXe6w@mail.gmail.com/

At the very least, [2] is possible, although the probability is extremely l=
ow.

"It seems also possible for the sync zRAM device.

 step 1: src pte points to a swap entry S without swapcache
 step 2: we call move_swap_pte()
 step 3: someone swap-in src_pte by sync path, no swapcache; swap slot
S is freed.
             -- for zRAM;
 step 4: someone swap-out src_pte, get the exactly same swap slot S as step=
 1,
             adds folio to swapcache due to swapout;
 step 5: move_swap_pte() gets ptl and finds page tables are stable
since swap-out
             happens to have the same swap slot as step1;
 step 6: we clear src_pte, move src_pte to dst_pte; but miss to move the fo=
lio.

Yep, we really need to re-check pte for swapcache after holding PTL.
"

Personally, I agree that improving the changelog or the comments
would be more helpful. In fact, there are two bugs here, and Kairui=E2=80=
=99s
changelog clearly describes the first one.

>
> I'm not sure my understanding is correct, though.  Maybe some richer
> comment would always help.
>
> Thanks,
>
> > +                     double_pt_unlock(dst_ptl, src_ptl);
> > +                     return -EAGAIN;
> > +             }
> >       }
> >
> >       orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> > @@ -1412,7 +1431,7 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >               }
> >               err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr, ds=
t_pte, src_pte,
> >                               orig_dst_pte, orig_src_pte, dst_pmd, dst_=
pmdval,
> > -                             dst_ptl, src_ptl, src_folio);
> > +                             dst_ptl, src_ptl, src_folio, si, entry);
> >       }
> >
> >  out:
> > --
> > 2.49.0
> >
> >
>
> --
> Peter Xu
>

Thanks
barry

