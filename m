Return-Path: <stable+bounces-155283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1076AE33FE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 05:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE9E189125C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 03:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140B19C554;
	Mon, 23 Jun 2025 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ8qbwFZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23910E5;
	Mon, 23 Jun 2025 03:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750649749; cv=none; b=qHiEPk+bNqxEnw47Ndez3SsKHbM4px4e/2KTiWxavER95OULxfjy+fROQ6tb1ULTl6/wjGQMX7hJJRxPPc+lVlBsfJ2NOalVSbhmGRn+keoUlcTJKOeL2bGh0dnNFeOaAlIsQCFgv+vHa9WtOKpk7hKFxdoDro2pGgUGmOiFi+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750649749; c=relaxed/simple;
	bh=eC3mQ1BPbWzRY5q+GC2R3xqn9bsZ4une3H7zphJciho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F70+Jg5IhHhcpa6Cf6vytDz64yd+rkz2t632UQm3yFDwvCgMpxSXtc26zhl+mZKdWE3G3juseaP2R6XxWcEaU8dOXdEw8jX6D2KxY9oDKF93DqTzQqJvA0pZQtY1wRj689RbRCWvaKGQrQyV3arx8dGueHsvWwyZvFVQu9JVKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ8qbwFZ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b43cce9efso29557571fa.3;
        Sun, 22 Jun 2025 20:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750649745; x=1751254545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KkbxdAFOFuv0wtY/Wddj5+p/K6uagaBbTkE8j++1e4=;
        b=UQ8qbwFZe1ygPrkbNGRK4DE/y/bumpy0hniP9NXpy4wffJt5iIoQm+blUV1G7XKLbb
         +ryKI4T3rNNYiXu+ZFnTd54pEM5hkqngProDVf2A2mkL2EVhAPFKhCOE4DIoDI+DXo3c
         NCGq984bkfWVg559ABgVc8GZRYnL/+McRUILjkelRZhcPYaQOz2gRTfeeb06gTbfLEJN
         nRhWqTmIY/IAETzAVO2GH6XA1aR9UjHsJW4VRCP+GLh+6Xq3J/Mp9SuEOfdvFQicvPhV
         Evb+NczCkQIKGBS3YjFLwfWpcI+hCnPctEKtCvLxvfh5lsUiEV6yaPAUBE9/OIZgIU71
         fddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750649745; x=1751254545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KkbxdAFOFuv0wtY/Wddj5+p/K6uagaBbTkE8j++1e4=;
        b=rdyMcry9rQ8gFRHr3rrWmQPJ/971lYkA3yg+ueysRwrmnMs9vReD1qjFx+duIak7cK
         8+KbzK3Kdq8aV0vY7JHpTkY+NZJ0W8jgcz/pn/4O2DgcKUuqhVCKQbjrXUNrDJbf29dC
         /nwqxA7+S6/KHUzI7aoNvVAKB3WE/ID0i6FCg5/LrKHGgCA9KlJnqmI5eFL5Av9l5VH3
         z+DonsuqemdgAXd3zXturohyR3R1NSh1BR+R+0TWeM3qS5TBCHcmpQDvt/GcAXu2HFvT
         S1jGXEorarJjK12DSYiAdHEQZMr8H2L04l6W/rp5kTLHYy8WPcB+Gc+DsTQVssf0RLMC
         IHSA==
X-Forwarded-Encrypted: i=1; AJvYcCWj8TOLAvgJ/2+SjUa+8yeBDYgD0T0jaLF2XCg5KlCfiM2kJkho9v6KglmHK2C8bfT5I+Crk/Me@vger.kernel.org, AJvYcCXqvAY0GfL8HnR5PiPNUxggUR+dI86IIrWDbvPVkSZKok/jQZq/szSRP4f8NbY8dwDSzFZfxlw/tphh6Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtgaAajjIrH09jfMTBQ2CBsVdAdlD/NtjDx+fGkF8jyu2RDUD
	nGZDa8fHA0B/HofQXyNv8nh3rSNuNhMKRx3YHp9MNgPF47tuDOhAX2nn7uI51KDTNEWLH4RoNE2
	MYcZ377oz9PNCZPMFO3GC/3PfA8iHUHw=
X-Gm-Gg: ASbGncsYRGiw04AD3sHZCW1x/sktsBXqAdpA/Z+geInDtjVc2jKvp8VYa8Dk5yfg/Rf
	d5kWkkuuVjKxzLxvKwD92p0AaqLM6uf2E3gr5VOT8brH0jZWFWoKAjf2idQJrJYAgV9WVesRquZ
	O5GFJTUbjIs6gPndzDOi6wSxEMhKoaxBUsiDO25c1zb+s=
X-Google-Smtp-Source: AGHT+IEJAOvAOWS6dCDGKZ6ptZAXHZMrZ7qNx8rjaBjlnfLRaz07f4dXTs4XM3J1EB5DX887tBnUXwpyIjca2YxtKUw=
X-Received: by 2002:a05:651c:19a9:b0:32c:a097:4199 with SMTP id
 38308e7fff4ca-32ca0974d60mr11089061fa.14.1750649745012; Sun, 22 Jun 2025
 20:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619175538.15799-1-ryncsn@gmail.com> <20250619175538.15799-2-ryncsn@gmail.com>
 <f90a6072-b75a-40df-a58c-9a98e9ca10ad@linux.alibaba.com>
In-Reply-To: <f90a6072-b75a-40df-a58c-9a98e9ca10ad@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 23 Jun 2025 11:35:06 +0800
X-Gm-Features: AX0GCFtzItZYKRxpqdml7b_LAPN3NsUUZvRGHxiVFpFVW0Xh9YT2Ur-pVbfmadM
Message-ID: <CAMgjq7B4RSDYAJ5aGijqq9cAzC8Jd8TF6gu-gpKjO5=E9a-RbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/shmem, swap: improve cached mTHP handling and
 fix potential hung
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:26=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Hi Kairui,
>
> On 2025/6/20 01:55, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > The current swap-in code assumes that, when a swap entry in shmem
> > mapping is order 0, its cached folios (if present) must be order 0
> > too, which turns out not always correct.
> >
> > The problem is shmem_split_large_entry is called before verifying the
> > folio will eventually be swapped in, one possible race is:
> >
> >      CPU1                          CPU2
> > shmem_swapin_folio
> > /* swap in of order > 0 swap entry S1 */
> >    folio =3D swap_cache_get_folio
> >    /* folio =3D NULL */
> >    order =3D xa_get_order
> >    /* order > 0 */
> >    folio =3D shmem_swap_alloc_folio
> >    /* mTHP alloc failure, folio =3D NULL */
> >    <... Interrupted ...>
> >                                   shmem_swapin_folio
> >                                   /* S1 is swapped in */
> >                                   shmem_writeout
> >                                   /* S1 is swapped out, folio cached */
> >    shmem_split_large_entry(..., S1)
> >    /* S1 is split, but the folio covering it has order > 0 now */
> >
> > Now any following swapin of S1 will hang: `xa_get_order` returns 0,
> > and folio lookup will return a folio with order > 0. The
> > `xa_get_order(&mapping->i_pages, index) !=3D folio_order(folio)` will
> > always return false causing swap-in to return -EEXIST.
> >
> > And this looks fragile. So fix this up by allowing seeing a larger foli=
o
> > in swap cache, and check the whole shmem mapping range covered by the
> > swapin have the right swap value upon inserting the folio. And drop
> > the redundant tree walks before the insertion.
> >
> > This will actually improve the performance, as it avoided two redundant
> > Xarray tree walks in the hot path, and the only side effect is that in
> > the failure path, shmem may redundantly reallocate a few folios
> > causing temporary slight memory pressure.
> >
> > And worth noting, it may seems the order and value check before
> > inserting might help reducing the lock contention, which is not true.
> > The swap cache layer ensures raced swapin will either see a swap cache
> > folio or failed to do a swapin (we have SWAP_HAS_CACHE bit even if
> > swap cache is bypassed), so holding the folio lock and checking the
> > folio flag is already good enough for avoiding the lock contention.
> > The chance that a folio passes the swap entry value check but the
> > shmem mapping slot has changed should be very low.
>
> Thanks for fixing the issue. Sadly, I haven't reproduced this issue from
> my previous test cases :(
>
> And I have a question below.
>
> > Cc: stable@vger.kernel.org
> > Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> > ---
> >   mm/shmem.c | 30 +++++++++++++++++++++---------
> >   1 file changed, 21 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index eda35be2a8d9..4e7ef343a29b 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *fo=
lio,
> >                                  pgoff_t index, void *expected, gfp_t g=
fp)
> >   {
> >       XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio))=
;
> > -     long nr =3D folio_nr_pages(folio);
> > +     unsigned long nr =3D folio_nr_pages(folio);
> > +     swp_entry_t iter, swap;
> > +     void *entry;
> >
> >       VM_BUG_ON_FOLIO(index !=3D round_down(index, nr), folio);
> >       VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> > @@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio *=
folio,
> >
> >       gfp &=3D GFP_RECLAIM_MASK;
> >       folio_throttle_swaprate(folio, gfp);
> > +     swap =3D iter =3D radix_to_swp_entry(expected);
> >
> >       do {
> >               xas_lock_irq(&xas);
> > -             if (expected !=3D xas_find_conflict(&xas)) {
> > -                     xas_set_err(&xas, -EEXIST);
> > -                     goto unlock;
> > +             xas_for_each_conflict(&xas, entry) {
> > +                     /*
> > +                      * The range must either be empty, or filled with
> > +                      * expected swap entries. Shmem swap entries are =
never
> > +                      * partially freed without split of both entry an=
d
> > +                      * folio, so there shouldn't be any holes.
> > +                      */
> > +                     if (!expected || entry !=3D swp_to_radix_entry(it=
er)) {
> > +                             xas_set_err(&xas, -EEXIST);
> > +                             goto unlock;
> > +                     }
> > +                     iter.val +=3D 1 << xas_get_order(&xas);
> >               }
> > -             if (expected && xas_find_conflict(&xas)) {
> > +             if (expected && iter.val - nr !=3D swap.val) {
> >                       xas_set_err(&xas, -EEXIST);
> >                       goto unlock;
> >               }
> > @@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
> >                       error =3D -ENOMEM;
> >                       goto failed;
> >               }
> > -     } else if (order !=3D folio_order(folio)) {
> > +     } else if (order > folio_order(folio)) {
> >               /*
> >                * Swap readahead may swap in order 0 folios into swapcac=
he
> >                * asynchronously, while the shmem mapping can still stor=
es
> > @@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> >
> >                       swap =3D swp_entry(swp_type(swap), swp_offset(swa=
p) + offset);
> >               }
> > +     } else if (order < folio_order(folio)) {
> > +             swap.val =3D round_down(swp_type(swap), folio_order(folio=
));
>
> Why rounding down the swap type? do you mean rounding down the swap offse=
t?

Ouch, right, it should be the value:

swap.val =3D round_down(swap.val, folio_order(folio));

I messed up the code here during a rebase, let me send a V3 then.

