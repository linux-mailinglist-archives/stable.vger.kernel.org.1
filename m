Return-Path: <stable+bounces-164660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8CFB110BE
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F567BA18B
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B572EBBBA;
	Thu, 24 Jul 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRKkxOu5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE754723;
	Thu, 24 Jul 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381054; cv=none; b=mCvGPpfArOemc/EpMzN4RcKm0DAvPZdOnd6jVRBCeYBVOVN+941lBC772zQT9JCLvXiYVwr8gUOVsuUCOJh0M3Db7znG4fTI/vBAzGU9kTMThnRhqBmpRYfnfcKjq8uo5krBFMt3zXSIpkI4A2q/4ttYcbAmz1fNrykgFXdh5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381054; c=relaxed/simple;
	bh=+XmjL4SmKD/mIhS+vn7ygaURr4JTI6WDc2xFm9NJMFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUXmn9XWyMl0OES4TpiRY7/M3+Z944r3n3mkKy7GvKFguxbpoh4GUHG+8EB6AyYW1nDCEWDy2HTLo/1SInmLYgZuhDuhN4M6wRYYlwuo1yaH3pqVJza5nDWuOfZmlBPJthUI9vEjmRV5dGERQQC2z9aWMcy/ipeKc/a3AL2zIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRKkxOu5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so12800731fa.1;
        Thu, 24 Jul 2025 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753381050; x=1753985850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mstO5bBA8SlBMK0W+sc+fnBo7qspVaUrHWJekQ5o+x8=;
        b=nRKkxOu5jSEo4FoYKuOEdGXQRd2gosv3pCV7RT2fshHOavhdUglz3MX/V5Evfzd18S
         2L3lK+UgjURNy9PY/QwHns6kBAB84lgCIUydl7dWpn9UKxrrUa/9XCU35SBtFoMMncCA
         aFe63RYFSpNaNefXEpH0h3M1McKdiHTptmrqhdUByV8aR5Zjpel6797oyHkM7ItEcT6V
         QjJ1lW+U9r30SVmXtJE2QjPwRnynBVyisivQye72gbTkij8ZX4561D6vey0SMt8cBMVd
         8Y5WLWCfksrRJsQR70VePZuWRgDMRSpVTv0CN1Sa23R7vcju/vt5XXr5ZoDgJT7NxdNT
         BdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753381050; x=1753985850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mstO5bBA8SlBMK0W+sc+fnBo7qspVaUrHWJekQ5o+x8=;
        b=t/iyuK5mIfHY70PprKrh/53InB+pYvaQRweIXET2fevcsQO9mzwCDK9yUVijgivAFP
         3Va7fDJQxmUgtxCsGaIxlyzWoMiPyPhsKjmiVoC1yVKukP3OCkQz1sq6X/adciTOo98V
         pEhmk9RFDBhVy8nhN2nGCpysPQUDLlioI2ufpqAQmQNOIifeUGDDDsvMwI4MUmthV45F
         +fAodYM/FKQuBdt8pGbqKHyk6qbEzCHFw/gBn9slfo4RYnVz4Y+7pogGat/Qf55R4r9C
         Mg83FS8cif7jqqKX3e0i6ejZ1pd70xtkw55fgzU2vG9IyiC/PXeXU4hm4vNIRqNvoYEK
         g+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU6JpAuJJwl4rQqv4AErA7omvZu2t56/QdhE8YcGp/aNT6W0JVm65l9osxDy5d0v9CNwe8n/5IdCtjEqoM=@vger.kernel.org, AJvYcCWq/Hiek9J9UE4cqhyn3IEJqXx5LcZTV5I5vbaT1OfITn+KYZuWVjUy+Amb99MJw8p+mJpH9hNf@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUPqswNYp2QZhZ8c8s+ImO9geief6phEcJjAHI3thyGRJA0k2
	sgh0Yh2dZsH+eyEbEDfGAutgihY2BRa2zF4BIStM6tjgWamUeF1vn38ye46lMlF78qxec2tgTv0
	/xRaY4xejFoM8AtGubRQ7vyydKxXuWaw=
X-Gm-Gg: ASbGncsLBjTres6bYHoF4eSqetEf/g8qvqtrlpc0YcXiIkVxS49MFhYb8vgFWp7K24Q
	jpBpDrhZkxSXm6TyQw8WU7NkhNuaHd+9sJAiWALImTQzgIOWOx1CObm0v2/8QYWf8cfic4qvFa1
	NweqHbqSpaaJvC5kUdPsRrsIBWBYSkwQA2WmhHsvAt+AX49wPFxPqKiIYuC5XfyHok2bz5fNQMd
	ekq45o=
X-Google-Smtp-Source: AGHT+IF0MypcK2dGjntx3r2pyL18T1BhDfo21rUZX5OIUZyEse8hxlJDbtuCftcm3hJcCuDQ2VNQSNQn/6GmBzSuwRU=
X-Received: by 2002:a2e:a58d:0:b0:331:e667:90e5 with SMTP id
 38308e7fff4ca-331e667abd6mr7021501fa.18.1753381050141; Thu, 24 Jul 2025
 11:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710033706.71042-1-ryncsn@gmail.com> <20250710033706.71042-2-ryncsn@gmail.com>
 <CAMgjq7A+DBw=z8RPP-P1hcCH4Mid0txfmKqgqXghoE_v7zGEoA@mail.gmail.com>
In-Reply-To: <CAMgjq7A+DBw=z8RPP-P1hcCH4Mid0txfmKqgqXghoE_v7zGEoA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 25 Jul 2025 02:16:51 +0800
X-Gm-Features: Ac12FXzqsdCRJwzfvRgVf_lgFJ6snqpfuboJ4Spb636Mjve2Z4ipOQIX7-yQ6oE
Message-ID: <CAMgjq7DfPXS4PkpGK-zem2L1gZD0dekbAyHa-CPHjf=eonoFXg@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] mm/shmem, swap: improve cached mTHP handling and
 fix potential hung
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:02=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, Jul 10, 2025 at 11:37=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > The current swap-in code assumes that, when a swap entry in shmem mappi=
ng
> > is order 0, its cached folios (if present) must be order 0 too, which
> > turns out not always correct.
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
> > Now any following swapin of S1 will hang: `xa_get_order` returns 0, and
> > folio lookup will return a folio with order > 0.  The
> > `xa_get_order(&mapping->i_pages, index) !=3D folio_order(folio)` will a=
lways
> > return false causing swap-in to return -EEXIST.
> >
> > And this looks fragile.  So fix this up by allowing seeing a larger fol=
io
> > in swap cache, and check the whole shmem mapping range covered by the
> > swapin have the right swap value upon inserting the folio.  And drop th=
e
> > redundant tree walks before the insertion.
> >
> > This will actually improve performance, as it avoids two redundant Xarr=
ay
> > tree walks in the hot path, and the only side effect is that in the
> > failure path, shmem may redundantly reallocate a few folios causing
> > temporary slight memory pressure.
> >
> > And worth noting, it may seems the order and value check before inserti=
ng
> > might help reducing the lock contention, which is not true.  The swap
> > cache layer ensures raced swapin will either see a swap cache folio or
> > failed to do a swapin (we have SWAP_HAS_CACHE bit even if swap cache is
> > bypassed), so holding the folio lock and checking the folio flag is
> > already good enough for avoiding the lock contention.  The chance that =
a
> > folio passes the swap entry value check but the shmem mapping slot has
> > changed should be very low.
> >
> > Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  mm/shmem.c | 30 +++++++++++++++++++++---------
> >  1 file changed, 21 insertions(+), 9 deletions(-)
>
> Hi All,
>
> Just found some issue here with this patch...
>
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 334b7b4a61a0..e3c9a1365ff4 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *fo=
lio,
> >                                    pgoff_t index, void *expected, gfp_t=
 gfp)
> >  {
> >         XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio=
));
> > -       long nr =3D folio_nr_pages(folio);
> > +       unsigned long nr =3D folio_nr_pages(folio);
> > +       swp_entry_t iter, swap;
> > +       void *entry;
> >
> >         VM_BUG_ON_FOLIO(index !=3D round_down(index, nr), folio);
> >         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> > @@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio *=
folio,
> >
> >         gfp &=3D GFP_RECLAIM_MASK;
> >         folio_throttle_swaprate(folio, gfp);
> > +       swap =3D iter =3D radix_to_swp_entry(expected);
> >
> >         do {
> >                 xas_lock_irq(&xas);
>
> I missed a xas_reset here, also better reset iter value too.
>
> > -               if (expected !=3D xas_find_conflict(&xas)) {
> > -                       xas_set_err(&xas, -EEXIST);
> > -                       goto unlock;
> > +               xas_for_each_conflict(&xas, entry) {
> > +                       /*
> > +                        * The range must either be empty, or filled wi=
th
> > +                        * expected swap entries. Shmem swap entries ar=
e never
> > +                        * partially freed without split of both entry =
and
> > +                        * folio, so there shouldn't be any holes.
> > +                        */
> > +                       if (!expected || entry !=3D swp_to_radix_entry(=
iter)) {
> > +                               xas_set_err(&xas, -EEXIST);
> > +                               goto unlock;
> > +                       }
> > +                       iter.val +=3D 1 << xas_get_order(&xas);
> >                 }
> > -               if (expected && xas_find_conflict(&xas)) {
> > +               if (expected && iter.val - nr !=3D swap.val) {
> >                         xas_set_err(&xas, -EEXIST);
> >                         goto unlock;
> >                 }
> > @@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
> >                         error =3D -ENOMEM;
> >                         goto failed;
> >                 }
> > -       } else if (order !=3D folio_order(folio)) {
> > +       } else if (order > folio_order(folio)) {
> >                 /*
> >                  * Swap readahead may swap in order 0 folios into swapc=
ache
> >                  * asynchronously, while the shmem mapping can still st=
ores
> > @@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> >
> >                         swap =3D swp_entry(swp_type(swap), swp_offset(s=
wap) + offset);
> >                 }
> > +       } else if (order < folio_order(folio)) {
> > +               swap.val =3D round_down(swap.val, 1 << folio_order(foli=
o));
> >         }
> >
> >  alloced:
> >         /* We have to do this with folio locked to prevent races */
> >         folio_lock(folio);
> >         if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
> > -           folio->swap.val !=3D swap.val ||
> > -           !shmem_confirm_swap(mapping, index, swap) ||
> > -           xa_get_order(&mapping->i_pages, index) !=3D folio_order(fol=
io)) {
>
> And this part is incorrect. This `shmem_confirm_swap(mapping, index,
> swap) ` can't be simply omitted. Some functions below before the
> shmem_add_to_page_cache shouldn't be called on folios might have
> already been mapped by others. This shmem_confirm_swap ensures that
> won't happen.
>
> It may seem like a small change, but it leads to some minor conflicts
> in one or two following commits, the benchmark result will change too.
> So I'll have to send a V6 I think.
>
> We can remove this `shmem_confirm_swap`, but not in this series I
> think, maybe after this. Need to re-arrange some functions, with some
> clean ups for shmem_add_to_page_cache and others.
>
> > +           folio->swap.val !=3D swap.val) {
> >                 error =3D -EEXIST;
> >                 goto unlock;
> >         }
> > --
> > 2.50.0
> >
>
> In summary, I'll squash this patch into it and do a rebase of later commi=
ts:
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e3c9a1365ff4..4ca0b665b79e 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -898,9 +898,11 @@ static int shmem_add_to_page_cache(struct folio *fol=
io,
>
>         gfp &=3D GFP_RECLAIM_MASK;
>         folio_throttle_swaprate(folio, gfp);
> -       swap =3D iter =3D radix_to_swp_entry(expected);
> +       swap =3D radix_to_swp_entry(expected);
>
>         do {
> +               iter =3D swap;
> +               xas_reset(&xas);

Correction: this xas_reset is not needed, the iter =3D swap is needed.

>                 xas_lock_irq(&xas);
>                 xas_for_each_conflict(&xas, entry) {
>                         /*
> @@ -2365,9 +2367,16 @@ static int shmem_swapin_folio(struct inode
> *inode, pgoff_t index,
>         }
>
>  alloced:

And it needs `nr_pages =3D folio_nr_pages(folio); index =3D
round_down(index, nr_pages);` here...

> -       /* We have to do this with folio locked to prevent races */
> +       /*
> +        * We have to do this with folio locked to prevent races.
> +        * The shmem_confirm_swap below only checks if the first swap
> +        * entry matches the folio, that's enough to ensure the folio
> +        * is not used outside of shmem, as shmem swap entrie
> +        * and swap cache folios are never partially freed.
> +        */
>         folio_lock(folio);
>         if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
> +           !shmem_confirm_swap(mapping, index, swap) ||
>             folio->swap.val !=3D swap.val) {
>                 error =3D -EEXIST;
>                 goto unlock;
>
> And I'll do some clean up afterward to get rid of this
> shmem_confirm_swap. How do you think?

