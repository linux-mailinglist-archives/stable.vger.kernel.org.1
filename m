Return-Path: <stable+bounces-152395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2E6AD4A5A
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390EB17B722
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FEC222589;
	Wed, 11 Jun 2025 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoxcgWTd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F62EAE3;
	Wed, 11 Jun 2025 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749619008; cv=none; b=CQ3imDNGuh7OmD4gzlb27ZrYhIxuQJAokuMu/PQOouVgZ9u7FMIOcZ9yRLOBGl5qVO+fwa2pexby/Qh3R7UEtOI9C8RtrH8oq9H8tpg11fVm9/eR+PdgPM8hny/MLmHie89qwgkDT3bM3pkLOSlv4JiXtI73UgXdbnuaKmdQuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749619008; c=relaxed/simple;
	bh=wpjO2UdDbgzV1FGy0cNPW5dk5DD8i5Z62VlUTb6TYTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuLdC3AZNHjgdrzcUFVgQN9NvuSCI9ikpGZRzqh1N5qxMb7ZPjgHVIlpWWBCQvr4chYWtYEyvFOTOmJ6+gvhGG9fj1MLNUSoFPl3/W2dm7KEF6O/Ab4eAPJ6F7gmOEYi+A5HxFSpxZzCtka+aG6+zTeXGTkwT23KfpUr80+Zuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoxcgWTd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32adebb15c5so42554841fa.3;
        Tue, 10 Jun 2025 22:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749619003; x=1750223803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WbUYvBV5w7iIvRbYFpOg/UyF3d6Aj3iPpcFOvmAbqs=;
        b=PoxcgWTdqUHEOVv9bEZqMPMXkOJ8GZFX325zIxQP9tVnTyWJVRLpHE4vzWauBImQp/
         s3YVY35dRCxfzF4PCTlr+SINpXwczEv67IeQKYRDAG+TEefCJaFM0efUu1syfc3Ab6tF
         fRexTKfjnyoT50XEG48CqY8LN3S2QrsVPLc9FN/h/BGD3Y3wPdR+tcadoH+cMTu0AiNW
         aQAU5SJNcUcuOktsQJVs7QT87YsD8/ILyMSd2dEbrcUyc+zDEx4FFYe1Q1XyTjGNc/4k
         13NUPSmpw4HJVJEsww9jNQ/FeYzQ5Yirl9xlPXY5yCMTsKAh0rYLfVb9ivVDXP6Q3k00
         mqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749619003; x=1750223803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WbUYvBV5w7iIvRbYFpOg/UyF3d6Aj3iPpcFOvmAbqs=;
        b=Z1F84s2cNXrEU8fHBxxngWC/1HgCLA4a2gAvl6iLCyI0m5ctkM6nyYrIZ4r7htlAEn
         hU9Ti39ijhGsZ/+smIPHEYHK/uVqerhnzaSCRPPmB3YQN5BP0s0L1wxvu1/OPRWEQ1fe
         GaHtx/guOy9KcWIZLNnq2iz1JHcPWe5VQnPGpkFjk3kkNa+XlFFghD8HoCFDXO76Zbx4
         YT+W/XVT64JEi/W4bVyvwm7Y9Wv9kVd3UtebkZZQnhyLSMV2mFq/sWFLlFhCY0nPVeaa
         uqGdX0fa9C6fHYQE+zMjAZyDH3NNlWPy/TR+bgGYqiiIObIYpxfqLXA4JM9tjNgs0GGS
         cKVA==
X-Forwarded-Encrypted: i=1; AJvYcCUx0JClBnZ5iIkzIYsXNNTLjWgFNGDtJDvRo/5FcgOMNwYBMqVSNKSPHJCdd1oUjMsfpFnS2pQj@vger.kernel.org, AJvYcCVQ68CnQvGPLvZl68iiKMxYGXAOkMIdGAXe3wrogKQR8Hh215A7nRodyPBsw9DjMaNZnZEbeuvcWstoCwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXCq42aM8xHGOumJp9vUYrwNSacKT/OxvlFURBrYZ+6M6swWCa
	YOuFoTrb0ADnL3SZaQewczsFtRQ0mLNJbQL9EE4Yv5T4L3fpQgDVS5zIWG33VcTGWBp536phEkX
	O+jkCecVMXlfnODL9D4eE+MxNb1h3ao8=
X-Gm-Gg: ASbGnctnbShAyiOjgqKoIamKXriLeSZ5bWWoDuRc9RCLpIUZXehwotpxLrjEA4XXIK5
	pincSSqKifiLNZj4kLx3BL3BHnbRAyO9DUFa7pxy+Mh+VEZ+rhB14u0JuTRNcBtINyA7LAqzIVE
	VE910ead37au6qnnaX4Vnq8NZl8cRenSn3IGKtqCdRbco=
X-Google-Smtp-Source: AGHT+IHAK3hZ2AAdYks83VACnJX54IgNwo73ZfcbGiW8zGfVZvURJSODOI9JvOuDHZxurbfBaFeIm4p9HJeqpDFxDWo=
X-Received: by 2002:a2e:2e06:0:b0:32a:7a12:9286 with SMTP id
 38308e7fff4ca-32b21d1bfacmr3447611fa.31.1749619002404; Tue, 10 Jun 2025
 22:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604151038.21968-1-ryncsn@gmail.com> <CAF8kJuPoJrYu30YPqze7oSPBm0qJ1Qutpw3=cQMQeSmboGnQKg@mail.gmail.com>
In-Reply-To: <CAF8kJuPoJrYu30YPqze7oSPBm0qJ1Qutpw3=cQMQeSmboGnQKg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 11 Jun 2025 13:16:25 +0800
X-Gm-Features: AX0GCFuHLf0sChQXW_NasvtYEsRWlK5vN2xRpQMPyVovYeE9O1vpb1oZMD2uTlA
Message-ID: <CAMgjq7BhLdQNKs7aT1Eopvgdwug3qEU4tP7xgj4VTjHBE36dPA@mail.gmail.com>
Subject: Re: [PATCH v4] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Barry Song <21cnbao@gmail.com>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 8:15=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Wed, Jun 4, 2025 at 8:10=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > On seeing a swap entry PTE, userfaultfd_move does a lockless swap
> > cache lookup, and tries to move the found folio to the faulting vma.
> > Currently, it relies on checking the PTE value to ensure that the moved
> > folio still belongs to the src swap entry and that no new folio has
> > been added to the swap cache, which turns out to be unreliable.
> >
> > While working and reviewing the swap table series with Barry, following
> > existing races are observed and reproduced [1]:
> >
> > In the example below, move_pages_pte is moving src_pte to dst_pte,
> > where src_pte is a swap entry PTE holding swap entry S1, and S1
> > is not in the swap cache:
> >
> > CPU1                               CPU2
> > userfaultfd_move
> >   move_pages_pte()
> >     entry =3D pte_to_swp_entry(orig_src_pte);
> >     // Here it got entry =3D S1
> >     ... < interrupted> ...
> >                                    <swapin src_pte, alloc and use folio=
 A>
> >                                    // folio A is a new allocated folio
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
> >                                    // S1 is freed, folio B can use it
> >                                    // for swap out with no problem.
> >                                    ...
> >     folio =3D filemap_get_folio(S1)
> >     // Got folio B here !!!
> >     ... < interrupted again> ...
> >                                    <swapin folio B and free S1>
> >                                    // Now S1 is free to be used again.
> >                                    <swapout src_pte & folio A using S1>
> >                                    // Now src_pte is a swap entry PTE
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
> > deliberately constructed reproducer and increased time window, it
> > can be reproduced easily.
>
> Thanks for the fix.
>
> Please spell out clearly what is the consequence of the race if
> triggered. I assume possible data lost? That should be mentioned in
> the first few sentences of the commit message as the user's visible
> impact.

Hi Chris,

This commit fixes two kinds of races, they may have different results:

Barry reported a BUG_ON in commit c50f8e6053b0, we may see the same
BUG_ON if the filemap lookup returned NULL and folio is added to swap
cache after that.

If another kind of race is triggered (folio changed after lookup) we
may see RSS counter is corrupted:

[  406.893936] BUG: Bad rss-counter state mm:ffff0000c5a9ddc0
type:MM_ANONPAGES val:-1
[  406.894071] BUG: Bad rss-counter state mm:ffff0000c5a9ddc0
type:MM_SHMEMPAGES val:1

Because the folio is being accounted to the wrong VMA.

I'm not sure if there will be any data corruption though, seems no.
The issues above are critical already.

>
> >
> > This can be fixed by checking if the folio returned by filemap is the
> > valid swap cache folio after acquiring the folio lock.
> >
> > Another similar race is possible: filemap_get_folio may return NULL, bu=
t
> > folio (A) could be swapped in and then swapped out again using the same
> > swap entry after the lookup. In such a case, folio (A) may remain in th=
e
> > swap cache, so it must be moved too:
> >
> > CPU1                               CPU2
> > userfaultfd_move
> >   move_pages_pte()
> >     entry =3D pte_to_swp_entry(orig_src_pte);
> >     // Here it got entry =3D S1, and S1 is not in swap cache
> >     folio =3D filemap_get_folio(S1)
> >     // Got NULL
> >     ... < interrupted again> ...
> >                                    <swapin folio A and free S1>
> >                                    <swapout folio A re-using S1>
> >     move_swap_pte
> >       double_pt_lock
> >       is_pte_pages_stable
> >       // Check passed because src_pte =3D=3D S1
> >       folio_move_anon_rmap(...)
> >       // folio A is ignored !!!
> >
> > Fix this by checking the swap cache again after acquiring the src_pte
> > lock. And to avoid the filemap overhead, we check swap_map directly [2]=
.
> >
> > The SWP_SYNCHRONOUS_IO path does make the problem more complex, but so
> > far we don't need to worry about that, since folios can only be exposed
> > to the swap cache in the swap out path, and this is covered in this
> > patch by checking the swap cache again after acquiring the src_pte lock=
.
> >
> > Testing with a simple C program that allocates and moves several GB of
> > memory did not show any observable performance change.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCzi+=
EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > Link: https://lore.kernel.org/all/CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+t=
Ai=3D8Y560K8eT=3DA@mail.gmail.com/ [2]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>
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
> > V3: https://lore.kernel.org/all/20250602181419.20478-1-ryncsn@gmail.com=
/
> > Changes:
> > - Add more comments and more context in commit message.
> >
> >  mm/userfaultfd.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index bc473ad21202..8253978ee0fb 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1084,8 +1084,18 @@ static int move_swap_pte(struct mm_struct *mm, s=
truct vm_area_struct *dst_vma,
> >                          pte_t orig_dst_pte, pte_t orig_src_pte,
> >                          pmd_t *dst_pmd, pmd_t dst_pmdval,
> >                          spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > -                        struct folio *src_folio)
> > +                        struct folio *src_folio,
> > +                        struct swap_info_struct *si, swp_entry_t entry=
)
> >  {
> > +       /*
> > +        * Check if the folio still belongs to the target swap entry af=
ter
> > +        * acquiring the lock. Folio can be freed in the swap cache whi=
le
> > +        * not locked.
> > +        */
> > +       if (src_folio && unlikely(!folio_test_swapcache(src_folio) ||
> > +                                 entry.val !=3D src_folio->swap.val))
> > +               return -EAGAIN;
> > +
> >         double_pt_lock(dst_ptl, src_ptl);
> >
> >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_s=
rc_pte,
> > @@ -1102,6 +1112,25 @@ static int move_swap_pte(struct mm_struct *mm, s=
truct vm_area_struct *dst_vma,
> >         if (src_folio) {
> >                 folio_move_anon_rmap(src_folio, dst_vma);
> >                 src_folio->index =3D linear_page_index(dst_vma, dst_add=
r);
> > +       } else {
> > +               /*
> > +                * Check if the swap entry is cached after acquiring th=
e src_pte
> > +                * lock. Otherwise, we might miss a newly loaded swap c=
ache folio.
> > +                *
> > +                * Check swap_map directly to minimize overhead, READ_O=
NCE is sufficient.
> > +                * We are trying to catch newly added swap cache, the o=
nly possible case is
> > +                * when a folio is swapped in and out again staying in =
swap cache, using the
> > +                * same entry before the PTE check above. The PTL is ac=
quired and released
> > +                * twice, each time after updating the swap_map's flag.=
 So holding
> > +                * the PTL here ensures we see the updated value. False=
 positive is possible,
> > +                * e.g. SWP_SYNCHRONOUS_IO swapin may set the flag with=
out touching the
> > +                * cache, or during the tiny synchronization window bet=
ween swap cache and
> > +                * swap_map, but it will be gone very quickly, worst re=
sult is retry jitters.
> > +                */
> > +               if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_H=
AS_CACHE) {
>
> Nit: You can use "} else if {" to save one level of indentation.
>
> Reviewed-by: Chris Li <chrisl@kernel.org>

Thanks!

