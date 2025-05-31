Return-Path: <stable+bounces-148336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F3AC9926
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 05:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9503BA901
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 03:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236CD13F434;
	Sat, 31 May 2025 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLrAyDZM"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BF208AD;
	Sat, 31 May 2025 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748662649; cv=none; b=nMNbHW2K45iPylP6lIUnCXqPT4kbhji7y3KXrMVMNRl4fqHV1w7xhuvHGjjiz9EqIjalydcCpZhzCbkRLqTXYIPFdvg9LQhbRFf5P+D0tQJwZnN+4JWg3njAMaL5Onw6Xn1jKi3kHz/JceU80xN8hGN8LwMqHFqOCuDZfqKTYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748662649; c=relaxed/simple;
	bh=yvgPTNoeSf1yl5RBlyNmUFnzjhk++4jygyL/a9s/wiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpYRDRsOzSHb4x/gEwuIlJyJNzh1sy7eT0QJgp9Ydv6rMRDWCoMqzucx9H+XpLFzSU5sLAqLiGwSODwUH8xynO6a8LdQLcdtPZZ7bsMOWcMjrsVWFnJrCSiWCwxrEZ3Oq9HKyeCud4uA16b3AJG4N9GMgEsIyYW59bDxAIeqG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLrAyDZM; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-525da75d902so834573e0c.3;
        Fri, 30 May 2025 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748662645; x=1749267445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGwZBMRFt6jbCLRVxUb7j9waKAG8jOd2Lwyhl2zPBAk=;
        b=MLrAyDZMfD9BtkvmEKlk3bT/QsYLSoh14vs4S5sBl7YxnIVxbbMSkSZfxerW0jq/2O
         KIaRts2xBDW4m+Ka7kI6xnLG6a02v3dOh9HkxxVUYLeWqpFQnZ22sItqAr5DqUwOqVST
         TJ99XYNmHqQPe3M+5HDJPkIbMmZhyvSws3jLL2Zu96tL5MbEhEfcRJpazDmi1BHUbGT/
         QvittnOSsXPtTZbjynSaVDWISLgTxClqNrFkDKWuemWzUOcDmkjXZgRZAErfCIZemPTN
         PcndeVOkyAXPvLS5XZZ6Obq7VWu9SMNwc3TUCBmJnIBIJWHhukRhV6Bf6qQQchMIuC+0
         kmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748662645; x=1749267445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGwZBMRFt6jbCLRVxUb7j9waKAG8jOd2Lwyhl2zPBAk=;
        b=tIE2gZeBthp4xEw1yoPsI1SFqoun8yIW0YoXvvoNrXsVTYXENgjlvZNZS6Y89xfS+L
         zkpQl+SjzzjV99kRHRcttrkRgsld1+iADBOGXaLCo1tl3e58tSdoHADOt9eMFp4HT9uS
         uvC7uNzi8H9pUusFhDZWbz8l0TTdTcB0GRp6OLVbVp7EGNf712HElRV9lySkmjuYOPGn
         v0Nt08IxSsnUjzWuE/v/fn95jsR5I3ZhbjbveJU0XRr3dM4SnLvmeCl/WBzebw6zb760
         3ESEYdJuDZNC3Cvjw8b9ZB4FjGGAUFdAk4j8HchoWV8Qx9qFbQR5fiRVfHsJ9dEDCQtd
         g8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWyN1SFGN4Q2TzcjQVvjz3hfLiavcYNLBZjAT1igWAM+Y4hzJcJ7bXyQQ0Rv9CqzUe+yJS3MzbCPC49kEM=@vger.kernel.org, AJvYcCXsZCWqX2w2Zu6fjYXYcKCOrOzPveJr9cdX8EVe76ytdd+RVmFF0m4Z1uQ9io2OnH7UfBBDYbpW@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/iInFC+SIS2CxkbhXhIm9EfBtiEXMv6cXhJxIzyrjOq2kI/M
	j2oZPFPerhkggjl1O54ZhKGg+XXbs9vbUqkozJRvDN720H4sAgkTo3O3Bhj3qxqhVGM52RurMRr
	z/5/RbarSDK8aPgDZ4VMR5H13I/wAePA=
X-Gm-Gg: ASbGncv8X5HDe/AgIWSt8WSsGXuOb+N8qyfV6D4uGoMG9JKKxvyeE5QlKubK38kYWMq
	G1K3EWt+oTdFA9flgNHT4XPlpm/uvXRrlHMURz51FEQqHa3BH8iIFkKuhvWJKQYAe7Nb3I0M2v2
	xuetCrjEq40cJi06zPhBwOhdIgWMPWYcohnQ==
X-Google-Smtp-Source: AGHT+IHq1tb1kp0wioRxhcquhpJ4/PzMdUDaAUgOIsgaHJicmUM65/TwwdvJXoRdST01SoJh57N3rUaJX43EfrtmD0s=
X-Received: by 2002:a05:6122:3c93:b0:52a:ee1a:4249 with SMTP id
 71dfb90a1353d-530810a4c4dmr5992647e0c.7.1748662645483; Fri, 30 May 2025
 20:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
In-Reply-To: <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 May 2025 15:37:14 +1200
X-Gm-Features: AX0GCFuSmuG3GMYnK0fqlEZH7Yq5qdzlPKHVTdmddHslftb2Tjj-Ax5NFqXl97I
Message-ID: <CAGsJ_4wkY8UcyU3LnNc1a55AvjYsVjBiST=Dy07UiaH8MU5-yg@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 11:40=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
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
> 2. You mentioned that the 'current dir is on a block device'. Are you
> indicating that if we are using zram for swap then it doesn't
> reproduce?
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

not quite sure as we have a folio_lock(src_folio) before move_swap_pte().
can we safely folio_move_anon_rmap + src_folio->index while not holding
folio lock?

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

Thanks
Barry

