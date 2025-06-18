Return-Path: <stable+bounces-154620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76892ADE0FA
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 04:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035A8179B04
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0953918FDA5;
	Wed, 18 Jun 2025 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5FT4XRO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ADC2904;
	Wed, 18 Jun 2025 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750212702; cv=none; b=Zb2xh8UW7+wePfJE4ni7NOw4GjC89eg9ewJtSJIiHdWO1NE/thJ7C++SMruupHNY6NoBB9r1nxDcT/KeYZf/tsI437fikNK+dQ9gWfP2BydDQjFpSojd3dFQfHeelNAKGaYcLcjG/X/cPe/aJYD5W9hJaniqTl9aDmqUlwRZ4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750212702; c=relaxed/simple;
	bh=kPKxV8tG49aw+tzlVixtXtskhMAnk0JYrXhy4728ygQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5w3H6NI3VSwB3RvCdTnXn/Vebk+ExoebqmNSIH0AE9lSnGoLHgXyZZ98meMkPh29AdWZ0LFAvOI837QHwdrxDeaAjGzCqqrz+cGDSQmI8djA42WYxlly1xyED0UDyL35wMWR47chNfWyZmZ5ubMD+fKS0tMKacODfQghYw5Kmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5FT4XRO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32addf54a01so66305231fa.3;
        Tue, 17 Jun 2025 19:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750212699; x=1750817499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHAOHa3W5FppAF2bP4Z945KCWTGy+r+Tavq5xMn89hc=;
        b=K5FT4XROJWk2rKAJJQJZzpzP7ZyJ6wICuNdO6sNd/eA9NbvJyhqAYyzJyVeYFUoUtR
         k8fYPbAu0kKO/osN5aOCA3VMkeIISAJxzn07Y5Kxw6mRKypDxqHpQHtTgxkWOIRNNO34
         tyRktTeTH30lPv0TS3Y06yAVQuLyP+9LCpwA1DGvatJTrc3l6/TbuRrzmUEs+l9I7I5l
         gEEsVh3UU2PDlZWi6k06VGgNoF0UIG6UIkITENv4FKx2WlNZ6lJmBsb3LZ9H2YWP8NaN
         39bjpeIZiL2uS2UcT0HXAFqSAu1U2w76umNbg2aWR7fFn+v7tnXG0/+9yLndyw4EXGKB
         zF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750212699; x=1750817499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHAOHa3W5FppAF2bP4Z945KCWTGy+r+Tavq5xMn89hc=;
        b=thrbkIAFX5bgGGYzYTHt85mMcaSeXG0hWBvVK9kJx9xZ5K3pe4qPShK07hb5Gt7zdh
         r9aenVEJyWBP1q2H1tZE3U4SBfJWsmPnM+eeXV20SnpE6mdHDaxwlSS/axBbk+eXh8TO
         HKmY05PWO1JWNrs4YRQb4e+za2tYGeNT4q7mt/fTLuNWCEbSLDwROLhEIrxW9DYI+k8Y
         DqmyeqJKo7qndoNJogsR9NiHdBTPSOj30bSPbRWoKD4JxhhsdImyNSrl1z5FrYdtcYmg
         LvmnWlm0CzPVE/SlehE7/eIblFaySZ6xO4ApUNPijcFKU8ntbKB3eaUuMpPfbbUwyOnz
         /ptA==
X-Forwarded-Encrypted: i=1; AJvYcCUd7fAMkJi3ubjqzyaiJKmdr4gmlHivzOAx4xQBZftJ+1bgKxocnRIcMeu2PWS5aXl6Kr6kPw49VBloYMU=@vger.kernel.org, AJvYcCWSwVqSwalX1VNns8S4V/kkFUo7TriVCJnpjQ5Eyrt4+goaT6HNFRhyVfP6ulDQcpHn/Irh93BU@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbRaexpLP+G0MGesdhWjs4cHRWAZ/Q2JD5ivC/x/tSv5AAmFZ
	tb2Pe8Idx6RpHSazEs2/bUzxymsXNkn9YnUBYB9UyRrB9REOpJYvNqLhVQPCWKQuqy3XZuPvd+k
	s2OGbDD4fVmvgnBUOH7IXw5nx5e7xGxsDekBordDinA==
X-Gm-Gg: ASbGnct56pX/QW2JqiXqQBml1QFRlpUM7wNjK0uHxVSSKl56P/2vmm817N/I08c7J0k
	RIOYnBmXSeVj8/+TLohvxWpR4y3AVlTVBBNmMKPTC4TYXruOaHBESGOn2XfYacYnTEljJydKHm2
	BHixQqCKUR1Udh09t0v8OB74NGQXt+upS9nYjhEeqWOsI=
X-Google-Smtp-Source: AGHT+IEWmjNCjVIII2C4kehsPINz+G10W880sadxhkKf0w+OjGqLSdLsl1+0Ja4C/dNMdsJy7vnBtzqP6Qm34MCkvdA=
X-Received: by 2002:a05:651c:e03:b0:31e:9d54:62ec with SMTP id
 38308e7fff4ca-32b4a610f99mr24777831fa.31.1750212698780; Tue, 17 Jun 2025
 19:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617183503.10527-1-ryncsn@gmail.com> <20250617183503.10527-2-ryncsn@gmail.com>
 <20250617155857.589c3e700b06af7dff085166@linux-foundation.org>
In-Reply-To: <20250617155857.589c3e700b06af7dff085166@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 18 Jun 2025 10:11:21 +0800
X-Gm-Features: AX0GCFv1v9kZZHvMtOV0WpsR0JWyiXoh-ZY6ZwkEGekrLicOy00i1MR-9buMnvQ
Message-ID: <CAMgjq7BLKv8d5+TNbEqSiPSteJvjTBsbphwDsxdR4Mk0gj7C7g@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/shmem, swap: improve cached mTHP handling and fix
 potential hung
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Matthew Wilcox <willy@infradead.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 6:58=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 18 Jun 2025 02:35:00 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > The current swap-in code assumes that, when a swap entry in shmem
> > mapping is order 0, its cached folios (if present) must be order 0
> > too, which turns out not always correct.
> >
> > The problem is shmem_split_large_entry is called before verifying the
> > folio will eventually be swapped in, one possible race is:
> >
> >     CPU1                          CPU2
> > shmem_swapin_folio
> > /* swap in of order > 0 swap entry S1 */
> >   folio =3D swap_cache_get_folio
> >   /* folio =3D NULL */
> >   order =3D xa_get_order
> >   /* order > 0 */
> >   folio =3D shmem_swap_alloc_folio
> >   /* mTHP alloc failure, folio =3D NULL */
> >   <... Interrupted ...>
> >                                  shmem_swapin_folio
> >                                  /* S1 is swapped in */
> >                                  shmem_writeout
> >                                  /* S1 is swapped out, folio cached */
> >   shmem_split_large_entry(..., S1)
> >   /* S1 is split, but the folio covering it has order > 0 now */
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
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 058313515d5a ("mm: shmem: fix potential data corruption during s=
hmem swapin")
> > Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
>
> The Fixes: tells -stable maintainers (and others) which kernel versions
> need the fix.  So having two Fixes: against different kernel versions is
> very confusing!  Are we recommending that kernels which contain
> 809bc86517cc but not 058313515d5a be patched?

809bc86517cc introduced mTHP support for shmem but it's buggy, and
058313515d5a tried to fix that, which is also buggy, I thought this
could help people to backport this.

I think keeping either is OK, I'll keep 809bc86517cc then, any branch
having 809bc86517cc should already have 058313515d5a backported.

