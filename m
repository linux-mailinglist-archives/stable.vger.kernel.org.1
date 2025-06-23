Return-Path: <stable+bounces-155286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 346FBAE3407
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 05:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6763188CB9F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 03:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E451AD3E5;
	Mon, 23 Jun 2025 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URRBUTaR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70578C2FA;
	Mon, 23 Jun 2025 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750650065; cv=none; b=YHF0A+Z6Lkk3Ew++8f6J7Xyk0AXMmhk6GEbVy4blaWosUJN0oa+wZBQ1mLbkrhq1xczwW5p2lvek1LFmO6K1WGfQ/z02p+EZ376vopp2A9KybqA/4zSRw55ElTojxSaP/iFaw/IHAqBx4sTiioqQp9XrQqoulbi6ERN99RS+qHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750650065; c=relaxed/simple;
	bh=PfgxTgg1w9b44LnyP6MGK6vQ5O1KXAaemhxCQNnN3Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjzZ37ypqr1QJ7f1oOhwp7o1wxsVWtl2RxPHVsCFSNPpN0RLd8R2ovLPrQDBvhCfbT3nkkwfBzK5KrbFackhUkrNyUCugOX4OnFPbpmd9FrESiwWUUJtjY/ef98Ak0GihWlwc2BNjQh5twXb8sDg43LTV2nYQz5pawA+v5BcAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URRBUTaR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso35256711fa.1;
        Sun, 22 Jun 2025 20:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750650061; x=1751254861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c49PzwWt7CcmCqEvzNnLBXT5IZU8zFU5FglZ/KCmv0=;
        b=URRBUTaRytgVIGOBroUXg4jWcWuvCk4RFzLGXJDtpHuHE8HQgZNkUxybbVutFPhf3E
         WIi/NP5BqzbZd0PTZpfPKWFpSzfOmXAtmaZDywpRbLf4f9g5U7LezTWx6vkcrmfgnmyL
         IOtBaDPsQx20naYs4ziF+LaoqvzgXFPQ0DvGDDYy4uPooEhp75nuDJBxOkuLbWvI7zrv
         j83ywPDu5w9MOwbqz8CHZATxxVqmboVGn/XgCQpKEyP4vNI/DV+n5azMphV4gnbTlTJg
         q/nwDSefQ/Jny/uesCFVekPqb5mptPCqN1RN8oIrVxWtOkxecr1uEHSiZl2IUyyZw8Ev
         i4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750650061; x=1751254861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/c49PzwWt7CcmCqEvzNnLBXT5IZU8zFU5FglZ/KCmv0=;
        b=VwCsdmZy4AFID2QSeyK1wXISdmOKQfJ5Ny7PlcXl1R0h1h4LDXV7OPbmKKccUES/q1
         8xiZFw8G/hqzSHwR+G11n3gtOaAJIrCwm10037RQL1zv5ua2JtrRQnK8eIbN1lVYq2S+
         a2XXKhoadtFo+2NDJTId5iYQ8bT79fkAuMUEkBTd1ZE+mewGcDXvttrAwJ6EjN+UXftX
         BLFi6OXQZLHTEkvZFCAC9sTgIQMe8mROG7rHnWN/sUfKc2PtfrQDPTewK5eaIMO9qQaL
         eg6mRK7kjqEbnhsLDJehk9CULvoKqTk3w3BShEX+acRSL66ZjxHF4u2shyoDhfeA46Hm
         vzXw==
X-Forwarded-Encrypted: i=1; AJvYcCVWI2RNUoBvoZYo5n30kgrI4QimbTUNHz/d9RbfIoeY0iQmMMitfH0IMlu9/w3+O/8/JJ/cFUgE@vger.kernel.org, AJvYcCXUN3sRGdne41OY3gVwcUicstTne8ISUJT9aw+6ZZhfSOmXL4pPOpKs/ic0jPPq02zLXwyrPVKYpY9mpwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4YaDewmI1f8NBxPjtXvtR7qtAHn/KNsbDmDeVZ9Nj5fA//FR
	wlqSga1vwZQt/2se4/sTlMDUgcUxPWo7RkSCJR1+f3vqeqP/vp3/ryjSNFRV+10/V4cqPdcq1jM
	iWL+e6xIPmwvy4YWYD0ZulU3STxfctF8=
X-Gm-Gg: ASbGncv7sxnQX+IilV/3zLowkL1n5yKHF3gsATkq3UXBAfj4YL9YKtexgQfI71bbZjQ
	fIAT2el90AeAEDAUiNy8BZ0VzAQUEvEvkT7NxxqHNEIVF0ZCgm2UH3c860Tdepe0OyuNbEiGx0V
	/mgPZC32SWBjibsZd3LgJRhBCsFcfaDEi6Ms+SNAPJCGM=
X-Google-Smtp-Source: AGHT+IHpBlE7pwmohT5p8mSJ9Krlh+08B0qObwm4HzHIRj8/nfduF/1u7PX/Tx+auJJ8/t6Qr8MpqahlzbyC+tpk0zs=
X-Received: by 2002:a2e:a007:0:b0:32b:82bf:cc53 with SMTP id
 38308e7fff4ca-32b99460f29mr20238341fa.31.1750650061318; Sun, 22 Jun 2025
 20:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619175538.15799-1-ryncsn@gmail.com> <20250619175538.15799-2-ryncsn@gmail.com>
 <f90a6072-b75a-40df-a58c-9a98e9ca10ad@linux.alibaba.com> <CAMgjq7B4RSDYAJ5aGijqq9cAzC8Jd8TF6gu-gpKjO5=E9a-RbQ@mail.gmail.com>
 <9e31bbb8-73e7-4e67-973d-491f93ba938f@linux.alibaba.com>
In-Reply-To: <9e31bbb8-73e7-4e67-973d-491f93ba938f@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 23 Jun 2025 11:40:23 +0800
X-Gm-Features: AX0GCFsnCGsy1B2Sk45knqmIyOdVKZSU64PmZdWLmlltku9gxf2_ligOXdXe0yY
Message-ID: <CAMgjq7Amf-ceW914NojmFFGPyypN4iFw7FJNLp7iHKoG=kms2A@mail.gmail.com>
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

On Mon, Jun 23, 2025 at 11:39=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
> On 2025/6/23 11:35, Kairui Song wrote:
> > On Mon, Jun 23, 2025 at 11:26=E2=80=AFAM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >> Hi Kairui,
> >>
> >> On 2025/6/20 01:55, Kairui Song wrote:
> >>> From: Kairui Song <kasong@tencent.com>
> >>>
> >>> The current swap-in code assumes that, when a swap entry in shmem
> >>> mapping is order 0, its cached folios (if present) must be order 0
> >>> too, which turns out not always correct.
> >>>
> >>> The problem is shmem_split_large_entry is called before verifying the
> >>> folio will eventually be swapped in, one possible race is:
> >>>
> >>>       CPU1                          CPU2
> >>> shmem_swapin_folio
> >>> /* swap in of order > 0 swap entry S1 */
> >>>     folio =3D swap_cache_get_folio
> >>>     /* folio =3D NULL */
> >>>     order =3D xa_get_order
> >>>     /* order > 0 */
> >>>     folio =3D shmem_swap_alloc_folio
> >>>     /* mTHP alloc failure, folio =3D NULL */
> >>>     <... Interrupted ...>
> >>>                                    shmem_swapin_folio
> >>>                                    /* S1 is swapped in */
> >>>                                    shmem_writeout
> >>>                                    /* S1 is swapped out, folio cached=
 */
> >>>     shmem_split_large_entry(..., S1)
> >>>     /* S1 is split, but the folio covering it has order > 0 now */
> >>>
> >>> Now any following swapin of S1 will hang: `xa_get_order` returns 0,
> >>> and folio lookup will return a folio with order > 0. The
> >>> `xa_get_order(&mapping->i_pages, index) !=3D folio_order(folio)` will
> >>> always return false causing swap-in to return -EEXIST.
> >>>
> >>> And this looks fragile. So fix this up by allowing seeing a larger fo=
lio
> >>> in swap cache, and check the whole shmem mapping range covered by the
> >>> swapin have the right swap value upon inserting the folio. And drop
> >>> the redundant tree walks before the insertion.
> >>>
> >>> This will actually improve the performance, as it avoided two redunda=
nt
> >>> Xarray tree walks in the hot path, and the only side effect is that i=
n
> >>> the failure path, shmem may redundantly reallocate a few folios
> >>> causing temporary slight memory pressure.
> >>>
> >>> And worth noting, it may seems the order and value check before
> >>> inserting might help reducing the lock contention, which is not true.
> >>> The swap cache layer ensures raced swapin will either see a swap cach=
e
> >>> folio or failed to do a swapin (we have SWAP_HAS_CACHE bit even if
> >>> swap cache is bypassed), so holding the folio lock and checking the
> >>> folio flag is already good enough for avoiding the lock contention.
> >>> The chance that a folio passes the swap entry value check but the
> >>> shmem mapping slot has changed should be very low.
> >>
> >> Thanks for fixing the issue. Sadly, I haven't reproduced this issue fr=
om
> >> my previous test cases :(
> >>
> >> And I have a question below.
> >>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> >>> Signed-off-by: Kairui Song <kasong@tencent.com>
> >>> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> >>> ---
> >>>    mm/shmem.c | 30 +++++++++++++++++++++---------
> >>>    1 file changed, 21 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>> index eda35be2a8d9..4e7ef343a29b 100644
> >>> --- a/mm/shmem.c
> >>> +++ b/mm/shmem.c
> >>> @@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *=
folio,
> >>>                                   pgoff_t index, void *expected, gfp_=
t gfp)
> >>>    {
> >>>        XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(foli=
o));
> >>> -     long nr =3D folio_nr_pages(folio);
> >>> +     unsigned long nr =3D folio_nr_pages(folio);
> >>> +     swp_entry_t iter, swap;
> >>> +     void *entry;
> >>>
> >>>        VM_BUG_ON_FOLIO(index !=3D round_down(index, nr), folio);
> >>>        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >>> @@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio=
 *folio,
> >>>
> >>>        gfp &=3D GFP_RECLAIM_MASK;
> >>>        folio_throttle_swaprate(folio, gfp);
> >>> +     swap =3D iter =3D radix_to_swp_entry(expected);
> >>>
> >>>        do {
> >>>                xas_lock_irq(&xas);
> >>> -             if (expected !=3D xas_find_conflict(&xas)) {
> >>> -                     xas_set_err(&xas, -EEXIST);
> >>> -                     goto unlock;
> >>> +             xas_for_each_conflict(&xas, entry) {
> >>> +                     /*
> >>> +                      * The range must either be empty, or filled wi=
th
> >>> +                      * expected swap entries. Shmem swap entries ar=
e never
> >>> +                      * partially freed without split of both entry =
and
> >>> +                      * folio, so there shouldn't be any holes.
> >>> +                      */
> >>> +                     if (!expected || entry !=3D swp_to_radix_entry(=
iter)) {
> >>> +                             xas_set_err(&xas, -EEXIST);
> >>> +                             goto unlock;
> >>> +                     }
> >>> +                     iter.val +=3D 1 << xas_get_order(&xas);
> >>>                }
> >>> -             if (expected && xas_find_conflict(&xas)) {
> >>> +             if (expected && iter.val - nr !=3D swap.val) {
> >>>                        xas_set_err(&xas, -EEXIST);
> >>>                        goto unlock;
> >>>                }
> >>> @@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> >>>                        error =3D -ENOMEM;
> >>>                        goto failed;
> >>>                }
> >>> -     } else if (order !=3D folio_order(folio)) {
> >>> +     } else if (order > folio_order(folio)) {
> >>>                /*
> >>>                 * Swap readahead may swap in order 0 folios into swap=
cache
> >>>                 * asynchronously, while the shmem mapping can still s=
tores
> >>> @@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *i=
node, pgoff_t index,
> >>>
> >>>                        swap =3D swp_entry(swp_type(swap), swp_offset(=
swap) + offset);
> >>>                }
> >>> +     } else if (order < folio_order(folio)) {
> >>> +             swap.val =3D round_down(swp_type(swap), folio_order(fol=
io));
> >>
> >> Why rounding down the swap type? do you mean rounding down the swap of=
fset?
> >
> > Ouch, right, it should be the value:
> >
> > swap.val =3D round_down(swap.val, folio_order(folio));
> >
> > I messed up the code here during a rebase, let me send a V3 then.
>
> Should be
>
> swap.val =3D round_down(swap.val, 1 << folio_order(folio));
>
> ?

Yes, exactly.

