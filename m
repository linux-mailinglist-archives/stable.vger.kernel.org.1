Return-Path: <stable+bounces-148349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E76EBAC99CA
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 09:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FBA189F208
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CD6230BC3;
	Sat, 31 May 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS1DqQG7"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F321FF22;
	Sat, 31 May 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748675478; cv=none; b=fBrBr7DerU5KKPGNPBOBXqqNXbzQh/nKvZ8d4xVc4YiE3KXXi6MmB1Kqs4p/6bjnn0Fp6MmXZhQS+fRu6PYqM22YtLBEpyItGKA1PP/bCTX/61IxXKlzV7Sz1mniKChobrziFhnBCc6IM5CDYWMxfiJsmAHFgUR40kucbaMLln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748675478; c=relaxed/simple;
	bh=ppV6aCRntQoV78dY3rGerJkONaYfJnukmDOhixGNeno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIB4RntB/ISpctx3U5Xl5MmtlwSHUJkUp5QjrYsd2fRJPmlS1hgw7LvNqzm9e08sxEwuSgJY0uzcBWNZ14TLom7X8+eN/ow/MjLhBI3l6Rk9Dv2FjtM00x4ROiz5knLjpCILYpVIgfF9uy4QRftiai9w6a+CDSNZf81NfJouP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS1DqQG7; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e58d270436so877092137.3;
        Sat, 31 May 2025 00:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748675475; x=1749280275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsVbopQSHGNxCU+521RTaC06XQglnnQiS9YtQjoinYU=;
        b=lS1DqQG7hNQUqyY3Wnf2yyNU81iBEy3f5erLB32rbOTanzzXAEzVLyNm7F6cvkv29+
         LC6kXTh4g+Kn3frisOB7RHGgbIcyflytslcfimaV0MiKBwMUru5PgBE3DfhiGkSNYG4K
         KukXR7ztxG0vg9Bgo+dydLTxfyTwMbicO29fAkJRXL+Kz5z6fYiVYGB6SUaobxSRLlKe
         bZHAlPbEvGkL4Tlj+Ftq4SDHQOrE+A6SA4NVAzP4+wQxPgFSf93mKK7F5ea7q7ir7d12
         0IEcXyrkb/nV6W1F+u0G/eHfk6G7/QW/at86vGM7oN9BJIsicXIvT1q0mI9Pr/tjMLTw
         RrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748675475; x=1749280275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsVbopQSHGNxCU+521RTaC06XQglnnQiS9YtQjoinYU=;
        b=jCG8YTAUt/nFyzMpMoQcwVWqliocMAhZcAaa7NwmTGHMSalWNAeAwsZZILIa0pBKxO
         Y4G7wwL29OLP+zKbjFTm1gED76PMxiF6Luedfm+koG+BFpF2+7eG8CDSS+idbHKbiyIG
         ey3QrU6XW3Jj8fKmir3o73LG14ZWcIQuyGtxnKHU1zx16R5fH7f9D5dJwrxPXWD8Hcyq
         8GCjF8DsIsJtWuT+6OGzO1RrVpdZR77/X2zC2RldiPeaq2eXebECV36pOakjou6ExnCb
         Gh2w1fMnzwkIZ5fu083ZF9bAwFWrX2YdNNacoviyO1I39FTB5TzSatbGOetmWPPQLZjQ
         7kKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4iHTtky5035sgjMIreDxSMkNvx/bYJaJ+M2aO7UzHkN2vKuULyeKjiwEQ8nCW+bGzwYqmPUxQIc2kg+Q=@vger.kernel.org, AJvYcCXNBmR2femnls9pLMYYm17lkOXh1v9LXf+qcVCOjI2JXfSBBoI+vGwgud0cwhdz70KIUvAAIFdD@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5kpw6w+vcm/TiPWanuCj4px1uDot0Fc2mXHXck4CIoL27j58
	wLhw2o6KIvm9+lTuUEI70e5DTuxRdi7gJGY+6zt9VB8o+IsuD7fK+qjeXwATK5Azg1HKy3Zuk7d
	+c0b3/dd8t474kLi+yDLA2+f+4J7drww=
X-Gm-Gg: ASbGncvGA0hmNTUnySACPmruiG0sfntLYebgN8FwmcwPbEVVyehIKHWO2cuQtiPgzsG
	xoAUYEcfjDh1WhxWs8I5uyPqoyQpbDodFBfR1Ex+BF18n+kLFiLpIGQOImClkdqfrnX/TA1dABj
	s3hGnFVViuZVnlnll2NxN47meBuDS9vauc5A==
X-Google-Smtp-Source: AGHT+IFdt0WJQZOrJQ/qTeXDjQqzXwWZ6VhvBm4MP2zhXRpqKV+ZIDDV1VU9b2qQi+t9GvnVnU3coSTIKJVM5qcGXRk=
X-Received: by 2002:a05:6102:6cb:b0:4c1:91da:dac1 with SMTP id
 ada2fe7eead31-4e6e40f3fd1mr5506320137.6.1748675475505; Sat, 31 May 2025
 00:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530201710.81365-1-ryncsn@gmail.com> <CA+EESO4-L5sOTgsTE1txby9f3a3_W49tSnkufzVnJhnR809zRQ@mail.gmail.com>
 <CAGsJ_4wkY8UcyU3LnNc1a55AvjYsVjBiST=Dy07UiaH8MU5-yg@mail.gmail.com>
 <CAMgjq7CFhboj1qDjdzwb2_vWKpzSzY5d0s-kWmE2ZYDDJ4s-JQ@mail.gmail.com>
 <CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+tAi=8Y560K8eT=A@mail.gmail.com>
 <CAMgjq7BzBFTOb-urmfuF5y6qsWxwFMy0Eq=Fym+2x2pjcqg1fQ@mail.gmail.com> <CAGsJ_4wm1hf54UgYJMrOyfBHDU=ZTYcGtcWTNOqo-OjmRNtXmg@mail.gmail.com>
In-Reply-To: <CAGsJ_4wm1hf54UgYJMrOyfBHDU=ZTYcGtcWTNOqo-OjmRNtXmg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 May 2025 19:11:03 +1200
X-Gm-Features: AX0GCFsaMwsDpHvv6Hpgi7mtLb8MSO853OVaDRVrebJRuPjklZMIm8ZvYtyjsWI
Message-ID: <CAGsJ_4yypxqRx5PdLY70tCP93cFUs_jgipcm68mhj4R0Ov_Vsw@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 7:06=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sat, May 31, 2025 at 7:00=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Sat, May 31, 2025 at 2:36=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Sat, May 31, 2025 at 6:25=E2=80=AFPM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > On Sat, May 31, 2025 at 11:39=E2=80=AFAM Barry Song <21cnbao@gmail.=
com> wrote:
> > > > >
> > > > > On Sat, May 31, 2025 at 11:40=E2=80=AFAM Lokesh Gidra <lokeshgidr=
a@google.com> wrote:
> > > > > >
> > > > > > On Fri, May 30, 2025 at 1:17=E2=80=AFPM Kairui Song <ryncsn@gma=
il.com> wrote:
> > > > > > >
> > > > > > > From: Kairui Song <kasong@tencent.com>
> > > > > > >
> > > > > > > On seeing a swap entry PTE, userfaultfd_move does a lockless =
swap cache
> > > > > > > lookup, and try to move the found folio to the faulting vma w=
hen.
> > > > > > > Currently, it relies on the PTE value check to ensure the mov=
ed folio
> > > > > > > still belongs to the src swap entry, which turns out is not r=
eliable.
> > > > > > >
> > > > > > > While working and reviewing the swap table series with Barry,=
 following
> > > > > > > existing race is observed and reproduced [1]:
> > > > > > >
> > > > > > > ( move_pages_pte is moving src_pte to dst_pte, where src_pte =
is a
> > > > > > >  swap entry PTE holding swap entry S1, and S1 isn't in the sw=
ap cache.)
> > > > > > >
> > > > > > > CPU1                               CPU2
> > > > > > > userfaultfd_move
> > > > > > >   move_pages_pte()
> > > > > > >     entry =3D pte_to_swp_entry(orig_src_pte);
> > > > > > >     // Here it got entry =3D S1
> > > > > > >     ... < Somehow interrupted> ...
> > > > > > >                                    <swapin src_pte, alloc and=
 use folio A>
> > > > > > >                                    // folio A is just a new a=
llocated folio
> > > > > > >                                    // and get installed into =
src_pte
> > > > > > >                                    <frees swap entry S1>
> > > > > > >                                    // src_pte now points to f=
olio A, S1
> > > > > > >                                    // has swap count =3D=3D 0=
, it can be freed
> > > > > > >                                    // by folio_swap_swap or s=
wap
> > > > > > >                                    // allocator's reclaim.
> > > > > > >                                    <try to swap out another f=
olio B>
> > > > > > >                                    // folio B is a folio in a=
nother VMA.
> > > > > > >                                    <put folio B to swap cache=
 using S1 >
> > > > > > >                                    // S1 is freed, folio B co=
uld use it
> > > > > > >                                    // for swap out with no pr=
oblem.
> > > > > > >                                    ...
> > > > > > >     folio =3D filemap_get_folio(S1)
> > > > > > >     // Got folio B here !!!
> > > > > > >     ... < Somehow interrupted again> ...
> > > > > > >                                    <swapin folio B and free S=
1>
> > > > > > >                                    // Now S1 is free to be us=
ed again.
> > > > > > >                                    <swapout src_pte & folio A=
 using S1>
> > > > > > >                                    // Now src_pte is a swap e=
ntry pte
> > > > > > >                                    // holding S1 again.
> > > > > > >     folio_trylock(folio)
> > > > > > >     move_swap_pte
> > > > > > >       double_pt_lock
> > > > > > >       is_pte_pages_stable
> > > > > > >       // Check passed because src_pte =3D=3D S1
> > > > > > >       folio_move_anon_rmap(...)
> > > > > > >       // Moved invalid folio B here !!!
> > > > > > >
> > > > > > > The race window is very short and requires multiple collision=
s of
> > > > > > > multiple rare events, so it's very unlikely to happen, but wi=
th a
> > > > > > > deliberately constructed reproducer and increased time window=
, it can be
> > > > > > > reproduced [1].
> > > > > >
> > > > > > Thanks for catching and fixing this. Just to clarify a few thin=
gs
> > > > > > about your reproducer:
> > > > > > 1. Is it necessary for the 'race' mapping to be MAP_SHARED, or
> > > > > > MAP_PRIVATE will work as well?
> > > > > > 2. You mentioned that the 'current dir is on a block device'. A=
re you
> > > > > > indicating that if we are using zram for swap then it doesn't
> > > > > > reproduce?
> > > > > >
> > > > > > >
> > > > > > > It's also possible that folio (A) is swapped in, and swapped =
out again
> > > > > > > after the filemap_get_folio lookup, in such case folio (A) ma=
y stay in
> > > > > > > swap cache so it needs to be moved too. In this case we shoul=
d also try
> > > > > > > again so kernel won't miss a folio move.
> > > > > > >
> > > > > > > Fix this by checking if the folio is the valid swap cache fol=
io after
> > > > > > > acquiring the folio lock, and checking the swap cache again a=
fter
> > > > > > > acquiring the src_pte lock.
> > > > > > >
> > > > > > > SWP_SYNCRHONIZE_IO path does make the problem more complex, b=
ut so far
> > > > > > > we don't need to worry about that since folios only might get=
 exposed to
> > > > > > > swap cache in the swap out path, and it's covered in this pat=
ch too by
> > > > > > > checking the swap cache again after acquiring src_pte lock.
> > > > > > >
> > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2O=
UZ0-tqCzi+EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > > > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > > > ---
> > > > > > >  mm/userfaultfd.c | 26 ++++++++++++++++++++++++++
> > > > > > >  1 file changed, 26 insertions(+)
> > > > > > >
> > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > > index bc473ad21202..a1564d205dfb 100644
> > > > > > > --- a/mm/userfaultfd.c
> > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > @@ -15,6 +15,7 @@
> > > > > > >  #include <linux/mmu_notifier.h>
> > > > > > >  #include <linux/hugetlb.h>
> > > > > > >  #include <linux/shmem_fs.h>
> > > > > > > +#include <linux/delay.h>
> > > > > > I guess you mistakenly left it from your reproducer code :)
> > > > > > >  #include <asm/tlbflush.h>
> > > > > > >  #include <asm/tlb.h>
> > > > > > >  #include "internal.h"
> > > > > > > @@ -1086,6 +1087,8 @@ static int move_swap_pte(struct mm_stru=
ct *mm, struct vm_area_struct *dst_vma,
> > > > > > >                          spinlock_t *dst_ptl, spinlock_t *src=
_ptl,
> > > > > > >                          struct folio *src_folio)
> > > > > > >  {
> > > > > > > +       swp_entry_t entry;
> > > > > > > +
> > > > > > >         double_pt_lock(dst_ptl, src_ptl);
> > > > > > >
> > > > > > >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_p=
te, orig_src_pte,
> > > > > > > @@ -1102,6 +1105,19 @@ static int move_swap_pte(struct mm_str=
uct *mm, struct vm_area_struct *dst_vma,
> > > > > > >         if (src_folio) {
> > > > > > >                 folio_move_anon_rmap(src_folio, dst_vma);
> > > > > > >                 src_folio->index =3D linear_page_index(dst_vm=
a, dst_addr);
> > > > > > > +       } else {
> > > > > > > +               /*
> > > > > > > +                * Check again after acquiring the src_pte lo=
ck. Or we might
> > > > > > > +                * miss a new loaded swap cache folio.
> > > > > > > +                */
> > > > > > > +               entry =3D pte_to_swp_entry(orig_src_pte);
> > > > > > > +               src_folio =3D filemap_get_folio(swap_address_=
space(entry),
> > > > > > > +                                             swap_cache_inde=
x(entry));
> > > > > >
> > > > > > Given the non-trivial overhead of filemap_get_folio(), do you t=
hink it
> > > > > > will work if filemap_get_filio() was only once after locking sr=
c_ptl?
> > > > > > Please correct me if my assumption about the overhead is wrong.
> > > > >
> > > > > not quite sure as we have a folio_lock(src_folio) before move_swa=
p_pte().
> > > > > can we safely folio_move_anon_rmap + src_folio->index while not h=
olding
> > > > > folio lock?
> > > >
> > > > I think no, we can't even make sure the folio is still in the swap
> > > > cache, so it can be a freed folio that does not belong to any VMA
> > > > while not holding the folio lock.
> > >
> > > Right, but will the following be sufficient, given that we don=E2=80=
=99t really
> > > care about the folio=E2=80=94only whether there=E2=80=99s new cache?
> > >
> > > if (READ_ONCE(si->swap_map[offset]) & SWAP_HAS_CACHE) {
> > >              double_pt_unlock(dst_ptl, src_ptl);
> > >              return -EAGAIN;
> > > }
> >
> > The problem is reading swap_map without locking the cluster map seems
> > unstable, and has strange false positives, a swapin will set this bit
> > first, while not adding the folio to swap cache or even when skipping
> > the swap cache, that seems could make it more complex.
>
> As long as it's a false positive and not a false negative, I think it's
> acceptable=E2=80=94especially if we're concerned about the overhead of
> filemap_get_folio. The probability is extremely low (practically close
> to 0%), but we still need to call filemap_get_folio for every swap PTE.

By the way, if we do want to eliminate the false positives, we could do
the following:

if (READ_ONCE(si->swap_map[offset]) & SWAP_HAS_CACHE) {
              folio =3D filemap_get_folio()
              if (folio....) {
                   double_pt_unlock(dst_ptl, src_ptl);
                   return -EAGAIN;
              }
}

This might eliminate 99.999999...% of filemap_get_folio calls, though my
gut feeling is that it might not be necessary :-)

Thanks
Barry

