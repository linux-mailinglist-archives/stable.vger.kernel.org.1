Return-Path: <stable+bounces-164646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2410DB11020
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E7F1685BC
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65CB2EACEF;
	Thu, 24 Jul 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcSp8PLl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F122083;
	Thu, 24 Jul 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376593; cv=none; b=f2KkUeStsxsY0ZquIA++9a2Zy7HwcBkdWYxghKD08DFz7LX5z+2tOS9ADE908q4n3krljNq752BXiyIe20OZsftpFxdtC9iQJuVrbtu77Ed6MYmsPEOa2NRhXrPYfzeyB1uVjdQ7rr0lJj9qahDio7ppbfp4xetsBj+3cSo+CuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376593; c=relaxed/simple;
	bh=rwSPoon0E7mhNdh+2hHRnGAvqDzdRjJyRJp84+Blkz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDo5oiG+x8HphcXxWh0VFIm5dU9WpwhPPhObEsH0og/9p/aVhhefPDmvwZIY99nbFaD0batY9rGS4KqIJmlRaY+OjUrIV9VskSQc8LpKjRsHp7Tw/0QziNyVmxs/OJ8JEF5SPMhS4BTjcY2m1VbtC5DVVEQfsQttbDei9FHElU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcSp8PLl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so14865391fa.1;
        Thu, 24 Jul 2025 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753376587; x=1753981387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FGOOiPVQqYASE7Wmz67+AH5G3BHXQxt/qem1BnGLQw=;
        b=hcSp8PLlB7Gj8bBXHv9nTlss+9iLw/3oTi9AgS61Nat9HYAzUAlW9M3L3Yh5tTYzPH
         wfX+avzB2xA6qlbImm97klU7x86sXM6yt3/cfhtsT3VBBgeJqxjwZejJyzpnnm4A3Uvg
         iaPVOlHCl4/NVDy8Mdsye8UhimlnL6nBj1P5Z0EmwmnRuhs9bb/94PQkB/7XgwoA3tz5
         qRUSQdxSUR/7x8GQOFa276XxbXjkSB2HmtYzbrsptz+OrzO3EuK88NRMCF7YXa+1T8BH
         iP7yGRTz4iNzeKHi3RHwuZtvcT38pmD7Ut+C0cvBqsyrBWpno0rOnxFLB8951YTsg12o
         9+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753376587; x=1753981387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FGOOiPVQqYASE7Wmz67+AH5G3BHXQxt/qem1BnGLQw=;
        b=qflYQmQGHU+ygwTU+9tDYkxypx1F57cC6Ha/j+C4XCLQe7cighT1O4QALx/mNCz7mZ
         2KD6+cXFR5eM6+ejblJxEwE3g+2ituUvuyzasAvESSmvh0UNXJAK8ADyCd96UoU9BY1W
         Bl+oJmcyCuVMx4rMSsDfhJwFTOP7Kl6NxcSHkE3til+y2F+tSgWiRS4/AJ2aR0MDRAbI
         Qg4XRqPAFmHLwXmhURu7jozmIEnKqA2xzn4KSukkA88lcuaEjmLJ1hAbWaIZJSTeId5f
         Jo8bGlrjUe7YKtJmLWmso/HJr3jKjk0msedMMkd4T2iuykpnufYHha/8OVcZOCgK5nZI
         3GXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCdUMQu1wD9fXnfEXO0pEyQefn8E2sKJyDdbI72d+Ybh2RJPgCvZR27kO1MvqQEk3SuTsJLMM9@vger.kernel.org, AJvYcCX7MxqPLX1/6xrtwrYzWb8Rbj4ZhSto6HuCyIC4ak/PQiVSdWwSysK7U02XOkBib0TwuWqDAav5OBzpTjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyqZ3UvIrOAlzmhPtBlv7KmrpoPlHKXVMZF3m2JK930Ckzpof
	9JXGjFeJBSHqGY4sEjYJr7uVdKy583X2AbtrWKwld9OlT32EE+65enYeH+h8mtReRqbIs1HaiZW
	3yfhjiqLwkXmFLALI3s7z6qWW+HmULxA=
X-Gm-Gg: ASbGncvilIQUtbeTniI6kTLLmFj3Y0yHIS9HAaXEqKUdDz9oCE1bCJzgyTzsY/ltGgY
	NeLOPgKX0iDVVAfCcvVST2R02OYWXweKbEHuDGAnpUgB3VBUDJxNvauhClOH6hzX7BeF1CQDC3W
	CqSvcDRZZmyFHX+9M2w79CPTA0VeucryutSgRr4tnRS0FzqrMAiuoCi13tmhZTnxPaCcvAMcX72
	1noOIs=
X-Google-Smtp-Source: AGHT+IH2SK9nNFgrAJTPUO9UuVWjDcmLx1aMVGa4BQ7jWyaoMvsByiN2oGkEo7mQNMXKziQVY3Jn0YtJZ4JLlWl3sdU=
X-Received: by 2002:a2e:a00f:0:b0:32e:aaa0:e68c with SMTP id
 38308e7fff4ca-331e25b98eamr7355731fa.19.1753376587111; Thu, 24 Jul 2025
 10:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710033706.71042-1-ryncsn@gmail.com> <20250710033706.71042-2-ryncsn@gmail.com>
In-Reply-To: <20250710033706.71042-2-ryncsn@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 25 Jul 2025 01:02:28 +0800
X-Gm-Features: Ac12FXz-JktFoi6dxbYyvTuXYPqprk55h_78M1lLvSRdsUEznKRvFtJBvXljRws
Message-ID: <CAMgjq7A+DBw=z8RPP-P1hcCH4Mid0txfmKqgqXghoE_v7zGEoA@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] mm/shmem, swap: improve cached mTHP handling and
 fix potential hung
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 11:37=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> The current swap-in code assumes that, when a swap entry in shmem mapping
> is order 0, its cached folios (if present) must be order 0 too, which
> turns out not always correct.
>
> The problem is shmem_split_large_entry is called before verifying the
> folio will eventually be swapped in, one possible race is:
>
>     CPU1                          CPU2
> shmem_swapin_folio
> /* swap in of order > 0 swap entry S1 */
>   folio =3D swap_cache_get_folio
>   /* folio =3D NULL */
>   order =3D xa_get_order
>   /* order > 0 */
>   folio =3D shmem_swap_alloc_folio
>   /* mTHP alloc failure, folio =3D NULL */
>   <... Interrupted ...>
>                                  shmem_swapin_folio
>                                  /* S1 is swapped in */
>                                  shmem_writeout
>                                  /* S1 is swapped out, folio cached */
>   shmem_split_large_entry(..., S1)
>   /* S1 is split, but the folio covering it has order > 0 now */
>
> Now any following swapin of S1 will hang: `xa_get_order` returns 0, and
> folio lookup will return a folio with order > 0.  The
> `xa_get_order(&mapping->i_pages, index) !=3D folio_order(folio)` will alw=
ays
> return false causing swap-in to return -EEXIST.
>
> And this looks fragile.  So fix this up by allowing seeing a larger folio
> in swap cache, and check the whole shmem mapping range covered by the
> swapin have the right swap value upon inserting the folio.  And drop the
> redundant tree walks before the insertion.
>
> This will actually improve performance, as it avoids two redundant Xarray
> tree walks in the hot path, and the only side effect is that in the
> failure path, shmem may redundantly reallocate a few folios causing
> temporary slight memory pressure.
>
> And worth noting, it may seems the order and value check before inserting
> might help reducing the lock contention, which is not true.  The swap
> cache layer ensures raced swapin will either see a swap cache folio or
> failed to do a swapin (we have SWAP_HAS_CACHE bit even if swap cache is
> bypassed), so holding the folio lock and checking the folio flag is
> already good enough for avoiding the lock contention.  The chance that a
> folio passes the swap entry value check but the shmem mapping slot has
> changed should be very low.
>
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/shmem.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)

Hi All,

Just found some issue here with this patch...

>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 334b7b4a61a0..e3c9a1365ff4 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *foli=
o,
>                                    pgoff_t index, void *expected, gfp_t g=
fp)
>  {
>         XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio))=
;
> -       long nr =3D folio_nr_pages(folio);
> +       unsigned long nr =3D folio_nr_pages(folio);
> +       swp_entry_t iter, swap;
> +       void *entry;
>
>         VM_BUG_ON_FOLIO(index !=3D round_down(index, nr), folio);
>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> @@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio *fo=
lio,
>
>         gfp &=3D GFP_RECLAIM_MASK;
>         folio_throttle_swaprate(folio, gfp);
> +       swap =3D iter =3D radix_to_swp_entry(expected);
>
>         do {
>                 xas_lock_irq(&xas);

I missed a xas_reset here, also better reset iter value too.

> -               if (expected !=3D xas_find_conflict(&xas)) {
> -                       xas_set_err(&xas, -EEXIST);
> -                       goto unlock;
> +               xas_for_each_conflict(&xas, entry) {
> +                       /*
> +                        * The range must either be empty, or filled with
> +                        * expected swap entries. Shmem swap entries are =
never
> +                        * partially freed without split of both entry an=
d
> +                        * folio, so there shouldn't be any holes.
> +                        */
> +                       if (!expected || entry !=3D swp_to_radix_entry(it=
er)) {
> +                               xas_set_err(&xas, -EEXIST);
> +                               goto unlock;
> +                       }
> +                       iter.val +=3D 1 << xas_get_order(&xas);
>                 }
> -               if (expected && xas_find_conflict(&xas)) {
> +               if (expected && iter.val - nr !=3D swap.val) {
>                         xas_set_err(&xas, -EEXIST);
>                         goto unlock;
>                 }
> @@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>                         error =3D -ENOMEM;
>                         goto failed;
>                 }
> -       } else if (order !=3D folio_order(folio)) {
> +       } else if (order > folio_order(folio)) {
>                 /*
>                  * Swap readahead may swap in order 0 folios into swapcac=
he
>                  * asynchronously, while the shmem mapping can still stor=
es
> @@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
>
>                         swap =3D swp_entry(swp_type(swap), swp_offset(swa=
p) + offset);
>                 }
> +       } else if (order < folio_order(folio)) {
> +               swap.val =3D round_down(swap.val, 1 << folio_order(folio)=
);
>         }
>
>  alloced:
>         /* We have to do this with folio locked to prevent races */
>         folio_lock(folio);
>         if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
> -           folio->swap.val !=3D swap.val ||
> -           !shmem_confirm_swap(mapping, index, swap) ||
> -           xa_get_order(&mapping->i_pages, index) !=3D folio_order(folio=
)) {

And this part is incorrect. This `shmem_confirm_swap(mapping, index,
swap) ` can't be simply omitted. Some functions below before the
shmem_add_to_page_cache shouldn't be called on folios might have
already been mapped by others. This shmem_confirm_swap ensures that
won't happen.

It may seem like a small change, but it leads to some minor conflicts
in one or two following commits, the benchmark result will change too.
So I'll have to send a V6 I think.

We can remove this `shmem_confirm_swap`, but not in this series I
think, maybe after this. Need to re-arrange some functions, with some
clean ups for shmem_add_to_page_cache and others.

> +           folio->swap.val !=3D swap.val) {
>                 error =3D -EEXIST;
>                 goto unlock;
>         }
> --
> 2.50.0
>

In summary, I'll squash this patch into it and do a rebase of later commits=
:

diff --git a/mm/shmem.c b/mm/shmem.c
index e3c9a1365ff4..4ca0b665b79e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -898,9 +898,11 @@ static int shmem_add_to_page_cache(struct folio *folio=
,

        gfp &=3D GFP_RECLAIM_MASK;
        folio_throttle_swaprate(folio, gfp);
-       swap =3D iter =3D radix_to_swp_entry(expected);
+       swap =3D radix_to_swp_entry(expected);

        do {
+               iter =3D swap;
+               xas_reset(&xas);
                xas_lock_irq(&xas);
                xas_for_each_conflict(&xas, entry) {
                        /*
@@ -2365,9 +2367,16 @@ static int shmem_swapin_folio(struct inode
*inode, pgoff_t index,
        }

 alloced:
-       /* We have to do this with folio locked to prevent races */
+       /*
+        * We have to do this with folio locked to prevent races.
+        * The shmem_confirm_swap below only checks if the first swap
+        * entry matches the folio, that's enough to ensure the folio
+        * is not used outside of shmem, as shmem swap entrie
+        * and swap cache folios are never partially freed.
+        */
        folio_lock(folio);
        if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
+           !shmem_confirm_swap(mapping, index, swap) ||
            folio->swap.val !=3D swap.val) {
                error =3D -EEXIST;
                goto unlock;

And I'll do some clean up afterward to get rid of this
shmem_confirm_swap. How do you think?

