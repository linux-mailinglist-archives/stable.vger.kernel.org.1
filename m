Return-Path: <stable+bounces-150651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2FACC0B3
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06CF7A316B
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 07:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F671FECD4;
	Tue,  3 Jun 2025 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4GnDdvQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3642A96;
	Tue,  3 Jun 2025 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748934212; cv=none; b=PApi2kpbllmzWWDcwN5B5bBhm8qDq2Eu69Kinp+aLz3jq5SF2b4LtXSNtdi2nGy/wMehcWB9dCn+ZUN4YrBhezudDEjWWcHh2D+lqKB+Fm7xnAihws3mFHhLWN7wy5t7ajWDYXpuIozLgUgBAQpQEFeCBrVlMCkNj7s3w+IXfyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748934212; c=relaxed/simple;
	bh=mEiKmlKFieLojpMWXsguW+Q+nOsw8ifImyjbc8c+WF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVBljnI2UzV5YZKtiwPjRrEUVe2LQgNvKfkz0gkZJYTCgKjvx2xhPssBC+AeaVEccpMARlniXtUPoHYqnCAcFllgdyRn08FvKZQX6KslriRvUHrLFLyQk2TLcfA5Ah0YtKxBOXYepqTniaD1RYjlk8bgzyf00sZB+Np/MKUMUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4GnDdvQ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3106217268dso44913031fa.1;
        Tue, 03 Jun 2025 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748934208; x=1749539008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dT7WqbqtKt8W1daG7MTBJ0atov+qwpnMMDskvCo+QI=;
        b=I4GnDdvQXd33eL2QH/QJzdRzF6a47+a/xgXaEvV/eJBkpqJNHuJM3aNn9GXAPMN+TK
         5iRWrIAuRu8hocMCCrucgJno65+ztLqhBaBYkfFe9r4KBXuI0qpLKMzuMULcG3+9lOHf
         ZLqUJ7+0RoyR7Gr4rytMXH6WJnILMrMyC5gt5BGQmw1ef16qIi69W+TMQhDrVC0z2NIv
         eqxkEbwMcwH8cEb76RDH9Ee5TRop2menIObU1LwbL3MWn9OL7Hb+tyZvuKDWqujjn24e
         2yQP6b2QCOUoSgwyPbss3nZuppvKbblqzrLGoPHdsXiCXb0HwfJcakkUPhV7vbPRDNhK
         77jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748934208; x=1749539008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dT7WqbqtKt8W1daG7MTBJ0atov+qwpnMMDskvCo+QI=;
        b=JilLhW8FGMKY3egg4k2x1DC04X0JpiCyji4Rt2w/YD+pG/O79HXl+lCDbvaOqSzDnY
         IIrYsBS5ujmwPOuW0aXUdpZsBarLPT4TZgqzPQisO45x1xqWU0vtcLPyLuLatJzO+Wv+
         XPbsJqkBUAaBOHo1g4RvrYztRsTOzsH8bZwEjIxpkQXJsjAOu3pY/FsaOwPx0DqI2EA5
         sJgXaYLpr+NuNGT297tpbfyFfL2zHOSzbG733tFUCBj//WDahqJNE9NaB8UUkTjbf1KK
         zM34BnUt6ckdYDKl/JpqnB55yeKpXyKU13km4kbhwteU/J9Vs0hRF8Rb80RUD8UH+yLK
         9tcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdGILKnpyN4V8g+yR48TkXliGKYIBAqj2ImzYAkPVcKlKuttTpETYzg+wO+pSs+3alI7PIsZaz@vger.kernel.org, AJvYcCX3q/TUK50xdU8p/unSy6n2SamUeB7WCRy+A+/oHCyMCnX5olqbVdEgIjo7252i9n3UFptydO8cf0iy7p0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKUfPp5oFNf3XBuU3yddxuvyQCYIHZYg4+CNSo8jYlrET9yMQ
	jgDK/FSS3fdadq7b37N9FaPAKfLg3Yrqine5/BHEtVTQzDD8eJIgO2arsP79DvycPFeY0fBI4yp
	Pp8oY1yHgk7fZvLm495lICmCdANG0PNU=
X-Gm-Gg: ASbGncuXHGkUzXbnoHv+XgSCsL1S44iMG8Y2tMhdwaECedtRDABF+KJJ4MSAELN11IL
	G/LkSEvtRPBi4IF4mLKmvJRDadpFJmVcS9Q2LQLX8AcWt2ZerI39+nihT3vcH4XO486VtdFfNJJ
	BNOI3P9mEyrPLw94U0wAQRS8qPVwepzfhu
X-Google-Smtp-Source: AGHT+IGnOaoXfRDc8wENHB7ftsUeRKl6dkZW7ROwPATi+QEN4kv+OgZpwURqdvXET1pFOPIM++/PwJLnVxwy01Gkf2s=
X-Received: by 2002:a05:651c:30c8:b0:32a:604c:504e with SMTP id
 38308e7fff4ca-32a9ea7e3d1mr34030951fa.38.1748934208051; Tue, 03 Jun 2025
 00:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602181419.20478-1-ryncsn@gmail.com> <aD4KyHz_H5WPLLf4@x1.local>
In-Reply-To: <aD4KyHz_H5WPLLf4@x1.local>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 3 Jun 2025 15:03:10 +0800
X-Gm-Features: AX0GCFuWW3YAYCssO1rwk88946aShV5_1GijPSRyW18Gr9SFJkf0tK_p7b5ZjC4
Message-ID: <CAMgjq7AZXzeDxWhxFsaRS8PdM4ZqDOKyex1f0dwuL97yzV9-Zg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <21cnbao@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 4:34=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
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

Hi Peter, Thanks for the review!

>
> Do we need data_race() for this, if this is an intentionally lockless rea=
d?
>
> Another pure swap question: the comment seems to imply this whole thing i=
s
> protected by src_pte lock, but is it?

It's tricky here, in theory we do need to hold the swap cluster lock
to read the swap_map, or it will look kind of hackish (which is the
reason I tried to avoid using that SWAP_HAS_CACHE bit in V1). But
I think it's OK to be lockless here because the only case where it
could go wrong is:
A concurrent swapin allocated a folio for the entry and updated
the PTE releasing the swap entry, then another swapout left the same
folio in swap cache and changed the PTE back reusing the entry. PTE
lock is acquired then released twice here, so holding the PTE lock
here will surely see the updated swap_map value. In other cases, the
is_pte_pages_stable check will fail and there is no race issue.

> I'm not familiar enough with swap code, but it looks to me the folio can =
be
> added into swap cache and set swap_map[] with SWAP_HAS_CACHE as long as t=
he
> folio is locked.  It doesn't seem to be directly protected by pgtable loc=
k.

You mean "as long as the folio is unlocked" right?

> Perhaps you meant this: since src_pte lock is held, then it'll serialize
> with another thread B concurrently swap-in the swap entry, but only _late=
r_
> when thread B's do_swap_page() will check again on pte_same(), then it'll
> see the src pte gone (after thread A uffdio_move happened releasing src_p=
te
> lock), hence thread B will release the newly allocated swap cache folio?

The case you described is valid, and there is no bug with that, it's
not the case I'm fixing here.

> There's another trivial detail that IIUC pte_same() must fail because
> before/after the uffdio_move the swap entry will be occupied so no way to
> have it reused, hence src_pte, even if re-populated again after uffdio_mo=
ve
> succeeded, cannot become the orig_pte (points to the swap entry in
> question) that thread B read, hence pte_same() must check fail.

Swap entry can be freed before the uffidio_move's PTE lock: a swapin
can finish and release it. Then another swapout can reuse it.

