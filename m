Return-Path: <stable+bounces-194599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3E1C51C52
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 562944F08DA
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7B23016F1;
	Wed, 12 Nov 2025 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv/j9nxi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A859186294
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944177; cv=none; b=tvoCkoTfX9PX0rDRHLSF7jhp5l2PRNF4Q3uz5CAjI1I1kb4HmxYDW+lf2v9gUj+b7p3sEX1wobdlQGDG8WNhfOM+YH0A+fJHegqJtHdXToiZYsdDrqA7qQ2qNwIoqfFpXZJZ9VVZUTt9gXm/VHa5eqZvfgpmkDeXyx5gKNpsm3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944177; c=relaxed/simple;
	bh=yd524j2UYdF9T60dZKoUWbXfiU/+4GqqehDLlNYZFPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3p+Noz6XTJFYU7yQKoY/HqobfFg7cPzJ9CxF058WYxZ6cmi++sv+/HoyRHP8TGcsX7Y7CuIaybhIxlBQZyGRIPzEGVfSxgExi/IaJyIGHlIu3VxIAQC/9a8IG8dOA4EIQ6QJa/tRCLV7JP+2QjPnwj94Vyi/ds12wIKsozK3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv/j9nxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B120FC16AAE
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762944176;
	bh=yd524j2UYdF9T60dZKoUWbXfiU/+4GqqehDLlNYZFPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nv/j9nxiepBqtVQU8PK3bUIFsPYEb9kXlebOfV8SEtbg96Lpxb1gK5sI80MAYGaub
	 moDxcoLxZH1q2BvPcTPyr5XLwe3KSmDmLjtiKRYXFGZiw/CYrWJFbvngwJRUUzGLAA
	 9s8+xOZdHeOShR0y/1BKdDAuIm0c6ESTgFXnOM3/Lqu6nMvja67LtVc48sV3CjcnXT
	 O/4hs4fo3sgK9YkY00Qyu8x9Mdb4z7FxmSso8ro5o75o9LDy5DtmZ4nYNM45BbSAJq
	 Qm44CO9X0KmtX9/IoJZMYsAhnFXz0WFjT7eeCAqhi2MRb0ZwsOCEKxgSB9n+SAmuB2
	 J6yTWlWqf4tJg==
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63e2cc1ac4aso611826d50.2
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 02:42:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4C6hdYsgth1bEfC2WMLuQ8ucBmZHq9FATNJxypAQdL0ZJnet2rfJd1/wORvNmJNFpWrzYcDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb08/dpWc1Y1pIDe3lWyQq9bHDRiiVKmmzDytNiqnufZMnYbHG
	co6DZQLx9ZJUC8M6AVSpbiPw59XbG1gTMgNInU0JfcYHmngi2EvgtLBnKUrJDfDLv/5S9Liq0kc
	lFE0zHNQhk8LRplGZcBj9ek2I6YJkHu2oen7skrISjQ==
X-Google-Smtp-Source: AGHT+IGpzC31MKqwjg37OYzkgE4JfNhCv8x/koPXoGpSYX9bTIBUawoA0Cj3921m0wicSy1w8LKVD7CXORcIJ008s+A=
X-Received: by 2002:a05:690e:d4a:b0:63f:b9fc:c65d with SMTP id
 956f58d0204a3-64101a34891mr2438331d50.12.1762944176056; Wed, 12 Nov 2025
 02:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com> <87ldkchv4r.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <87ldkchv4r.fsf@DESKTOP-5N7EMDA>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 12 Nov 2025 02:42:45 -0800
X-Gmail-Original-Message-ID: <CACePvbW+WT2obgoKs_ZPoMqnyCzO=_ir4uKX6xxY+rk_+=Zrcw@mail.gmail.com>
X-Gm-Features: AWmQ_bm5A-7V0WTqXR0dV28f2BzUEkhRXXIItSKog2jneau9hBijp83WKJIbfs0
Message-ID: <CACePvbW+WT2obgoKs_ZPoMqnyCzO=_ir4uKX6xxY+rk_+=Zrcw@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: fix potential UAF issue for VMA readahead
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 5:56=E2=80=AFPM Huang, Ying
<ying.huang@linux.alibaba.com> wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Since commit 78524b05f1a3 ("mm, swap: avoid redundant swap device
> > pinning"), the common helper for allocating and preparing a folio in th=
e
> > swap cache layer no longer tries to get a swap device reference
> > internally, because all callers of __read_swap_cache_async are already
> > holding a swap entry reference. The repeated swap device pinning isn't
> > needed on the same swap device.
> >
> > Caller of VMA readahead is also holding a reference to the target
> > entry's swap device, but VMA readahead walks the page table, so it migh=
t
> > encounter swap entries from other devices, and call
> > __read_swap_cache_async on another device without holding a reference t=
o
> > it.
> >
> > So it is possible to cause a UAF when swapoff of device A raced with
> > swapin on device B, and VMA readahead tries to read swap entries from
> > device A. It's not easy to trigger, but in theory, it could cause real
> > issues.
> >
> > Make VMA readahead try to get the device reference first if the swap
> > device is a different one from the target entry.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
> > Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> > Sending as a new patch instead of V2 because the approach is very
> > different.
> >
> > Previous patch:
> > https://lore.kernel.org/linux-mm/20251110-revert-78524b05f1a3-v1-1-8831=
3f2b9b20@tencent.com/
> > ---
> >  mm/swap_state.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 0cf9853a9232..da0481e163a4 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -745,6 +745,7 @@ static struct folio *swap_vma_readahead(swp_entry_t=
 targ_entry, gfp_t gfp_mask,
> >
> >       blk_start_plug(&plug);
> >       for (addr =3D start; addr < end; ilx++, addr +=3D PAGE_SIZE) {
> > +             struct swap_info_struct *si =3D NULL;
> >               softleaf_t entry;
> >
> >               if (!pte++) {
> > @@ -759,8 +760,19 @@ static struct folio *swap_vma_readahead(swp_entry_=
t targ_entry, gfp_t gfp_mask,
> >                       continue;
> >               pte_unmap(pte);
> >               pte =3D NULL;
> > +             /*
> > +              * Readahead entry may come from a device that we are not
> > +              * holding a reference to, try to grab a reference, or sk=
ip.
> > +              */
> > +             if (swp_type(entry) !=3D swp_type(targ_entry)) {
> > +                     si =3D get_swap_device(entry);
> > +                     if (!si)
> > +                             continue;
> > +             }
> >               folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, =
ilx,
> >                                               &page_allocated, false);
> > +             if (si)
> > +                     put_swap_device(si);
> >               if (!folio)
> >                       continue;
> >               if (page_allocated) {
>
> Personally, I prefer to call put_swap_device() after all swap operations
> on the swap entry, that is, after possible swap_read_folio() and
> folio_put() in the loop to make it easier to follow the
> get/put_swap_device() rule.  But I understand that it will make
>
> if (!folio)
>         continue;
>
> to use 'goto' and introduce more change.  So, it's up to you to decide
> whether to do that.

Personally I prefer it to keep the put_swap_device() in the current
location, closer to the matching get_swap_device(). To me that is
simpler, I don't need to reason about other branch out conditions.
Those error handling branch conditions are very error prone, I have
made enough mistakes on those goto branch handling in my past
experience. The si reference is only needed for the
__read_swap_cache_async() anyway.

To it to the end also works, just take more brain power to reason it.

> Otherwise, LGTM, Thanks for doing this!  Feel free to add my
>
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

Thank you for the review.

Chris

