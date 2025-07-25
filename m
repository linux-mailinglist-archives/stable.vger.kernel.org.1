Return-Path: <stable+bounces-164717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D2B11788
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 06:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D197AB54A
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 04:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C11E1DEC;
	Fri, 25 Jul 2025 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCpb01AX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E4184E;
	Fri, 25 Jul 2025 04:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753419324; cv=none; b=BrLrQYEu8gQ5uxzyl5cIM3MR4qFLdaRUGSiR2tz5NsjoZx3B/oehi/hj/ePwV6Ve7tTcwuMAAvcc6/L5nAO3/gh1nwX8N1Hn1z9cHm/LPg7kuo83ZcsjnIIWJBFo7JNt/8LSaPu3jyOfkVhZz4rwk5Wzf0wsi005pZoCmJsHBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753419324; c=relaxed/simple;
	bh=OvhM9ClZGH+jarQYJEcdMWrylbq2HAVleFVQ+N/lQ2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYZoNvGOvzGjH8lzh5cfgg8uRTS5d2nawgFNlIjZmj8r2Is5qSFfTltKmGFfmZPY0hQ9lLz//iTr4xSnr5vXsAR3WEpdJxBDQ3y6Ao843fNhc5zsUKsDWWPyVPiBLPNQhr93tzmY3Vc4WlDdcVr0qMHxhm9aFIYmMsK9/xPXqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCpb01AX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32cd499007aso13783151fa.0;
        Thu, 24 Jul 2025 21:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753419321; x=1754024121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjRvxsIHZ595y0DEJWKmPyqBjiMK7a2mQwpXKP8AxLc=;
        b=fCpb01AX2tL0RJeJGy6z0uVF2SzViXFVDMFkxLgyHsVxlu73RPbJDl9vRX9O5BjhHT
         AFdjoO5q9IP3DEbu4TTCc3baRU5a9WguG790uN2O5h9OsFpkbcyB5f3cKg+h7F22/aPQ
         kRi/nXDnys9YyMpQxzixHLqu4Oyn6rz431Oz6XoULGIP/6mQ9eiYZfFIWAY9DSlIwTqA
         KukCv6pjTAdQrLD8bvZfhOj0IHIgcYYKrW2Pf3UWAWH0ZiOuZd5bLBZCUeBimRn5lwVK
         ahL8cIR3+7iI7S7l5LtJneZWULiDsVxzglNRX1+SfLl1y3vkO+0cw1LhZ6ik79omXCjV
         mv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753419321; x=1754024121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjRvxsIHZ595y0DEJWKmPyqBjiMK7a2mQwpXKP8AxLc=;
        b=EKiQ5rZHWKflAG1H0lgXXb7SrKLbPWsZMjnbzPDgEJSuYe6QNtezFz8St0p+/wCse7
         gBPm6URNW/7qSUxwkX9bPT2orB8kJ5ze8tGsYaoOKOc6JpHFNG0c/n74inwjEYrTw7b0
         p99CRpN2qhtDwvuqvsTbt5iomOZygYv0l3SmKUxwbNJFnbu+5SKdMT1JMwzHNAnr4iQl
         8XmiR5tQgl6EE5eFhqXSBOydpU4mrJ30CWthqySM7bo+hmk68pjGAxjftKzowkdFfvqo
         a8OSp3yJQURAgZhaHaAOBDC2HEv+KLIMmq+jSwRlhqVzPWcERONjIIqjjj/ZrrAqSUcR
         GV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlNk8rmQMUnl8a/QWUt0uu+2ijhadcD7iPrXyxfXjzp/C6f0jXYQPESU+hQGDWxbwLvz8Gmyiw@vger.kernel.org, AJvYcCV2xVCH9GnuZ8hdMbZCmwqZNsDOEej9EFOLfGuzuttLE6txzw7G7wWndZL4jmACPtedRuPC424RAtnIUYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFN5zzCLFgkpZX9XLq0OxqcZCq4KXtuDxES6yxUFjhtFlcKfsi
	bKEeN7xM5c0ssKk7jZagSkkFgMPDfvOXS9RkRU8vv1ObGPSFX+HXyfpAa/zoFU6plZk9f8ijR4/
	/Zu4y/hPReV+bA+A2zlGGkDR7nsAUzCg=
X-Gm-Gg: ASbGncv8sQHZSM3U3wAb74bd0GWpKskzLdQ1ZW2rzleSf7lKQMIPNYTqiS0tWIqT9j2
	QrrDfFxaZyA1Qq7JzYggkUrlSGHKLepvJ1lp3FozWyCAExTiqzdZ+BsTJeZDzV8WLbMgO+mLn/w
	DuJ4H3pTGcE7nzRGvfp2omgR1/7ze3Q9Jxx5mACugprcGS6al+yojFCarnTEgW4QfgB6PB9KeAQ
	K8vdkA=
X-Google-Smtp-Source: AGHT+IHqMl2rUjbDV1waYyUjl7JoYdOEn2Tf6QXhm2MqddA+SlKwGNxw3VHcGi7scZ6WdkNORrS1HOuAFcuWmANaEiE=
X-Received: by 2002:a2e:bcca:0:b0:32a:7d73:9101 with SMTP id
 38308e7fff4ca-331ee7c8f3bmr1367871fa.26.1753419320425; Thu, 24 Jul 2025
 21:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710033706.71042-1-ryncsn@gmail.com> <20250710033706.71042-2-ryncsn@gmail.com>
 <CAMgjq7A+DBw=z8RPP-P1hcCH4Mid0txfmKqgqXghoE_v7zGEoA@mail.gmail.com>
 <CAMgjq7DfPXS4PkpGK-zem2L1gZD0dekbAyHa-CPHjf=eonoFXg@mail.gmail.com> <437bdc7a-d570-4602-9715-c716a660e762@linux.alibaba.com>
In-Reply-To: <437bdc7a-d570-4602-9715-c716a660e762@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 25 Jul 2025 12:54:43 +0800
X-Gm-Features: Ac12FXy8WN5w18XQCx7kjrQOVKWGkH7JUFyMUqQuQRsW2HacQOSFJKuMPAoqVSo
Message-ID: <CAMgjq7CuwHEWqmUG=4-nAtCrGJJjUM_1TY=ToFUAm0NXxMV3iA@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] mm/shmem, swap: improve cached mTHP handling and
 fix potential hung
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:52=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/7/25 02:16, Kairui Song wrote:
> > On Fri, Jul 25, 2025 at 1:02=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> >>
> >> On Thu, Jul 10, 2025 at 11:37=E2=80=AFAM Kairui Song <ryncsn@gmail.com=
> wrote:
> >>>
> >>> From: Kairui Song <kasong@tencent.com>
> >>>
> >>> The current swap-in code assumes that, when a swap entry in shmem map=
ping
> >>> is order 0, its cached folios (if present) must be order 0 too, which
> >>> turns out not always correct.
> >>>
> >>> The problem is shmem_split_large_entry is called before verifying the
> >>> folio will eventually be swapped in, one possible race is:
> >>>
> >>>      CPU1                          CPU2
> >>> shmem_swapin_folio
> >>> /* swap in of order > 0 swap entry S1 */
> >>>    folio =3D swap_cache_get_folio
> >>>    /* folio =3D NULL */
> >>>    order =3D xa_get_order
> >>>    /* order > 0 */
> >>>    folio =3D shmem_swap_alloc_folio
> >>>    /* mTHP alloc failure, folio =3D NULL */
> >>>    <... Interrupted ...>
> >>>                                   shmem_swapin_folio
> >>>                                   /* S1 is swapped in */
> >>>                                   shmem_writeout
> >>>                                   /* S1 is swapped out, folio cached =
*/
> >>>    shmem_split_large_entry(..., S1)
> >>>    /* S1 is split, but the folio covering it has order > 0 now */
> >>>
> >>> Now any following swapin of S1 will hang: `xa_get_order` returns 0, a=
nd
> >>> folio lookup will return a folio with order > 0.  The
> >>> `xa_get_order(&mapping->i_pages, index) !=3D folio_order(folio)` will=
 always
> >>> return false causing swap-in to return -EEXIST.
> >>>
> >>> And this looks fragile.  So fix this up by allowing seeing a larger f=
olio
> >>> in swap cache, and check the whole shmem mapping range covered by the
> >>> swapin have the right swap value upon inserting the folio.  And drop =
the
> >>> redundant tree walks before the insertion.
> >>>
> >>> This will actually improve performance, as it avoids two redundant Xa=
rray
> >>> tree walks in the hot path, and the only side effect is that in the
> >>> failure path, shmem may redundantly reallocate a few folios causing
> >>> temporary slight memory pressure.
> >>>
> >>> And worth noting, it may seems the order and value check before inser=
ting
> >>> might help reducing the lock contention, which is not true.  The swap
> >>> cache layer ensures raced swapin will either see a swap cache folio o=
r
> >>> failed to do a swapin (we have SWAP_HAS_CACHE bit even if swap cache =
is
> >>> bypassed), so holding the folio lock and checking the folio flag is
> >>> already good enough for avoiding the lock contention.  The chance tha=
t a
> >>> folio passes the swap entry value check but the shmem mapping slot ha=
s
> >>> changed should be very low.
> >>>
> >>> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> >>> Signed-off-by: Kairui Song <kasong@tencent.com>
> >>> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> >>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>> Cc: <stable@vger.kernel.org>
> >>> ---
> >>>   mm/shmem.c | 30 +++++++++++++++++++++---------
> >>>   1 file changed, 21 insertions(+), 9 deletions(-)
> >>
> >> Hi All,
> >>
> >> Just found some issue here with this patch...
> >>
> >>>
> >>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>> index 334b7b4a61a0..e3c9a1365ff4 100644
> >>> --- a/mm/shmem.c
> >>> +++ b/mm/shmem.c
> >>> @@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *=
folio,
> >>>                                     pgoff_t index, void *expected, gf=
p_t gfp)
> >>>   {
> >>>          XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(fo=
lio));
> >>> -       long nr =3D folio_nr_pages(folio);
> >>> +       unsigned long nr =3D folio_nr_pages(folio);
> >>> +       swp_entry_t iter, swap;
> >>> +       void *entry;
> >>>
> >>>          VM_BUG_ON_FOLIO(index !=3D round_down(index, nr), folio);
> >>>          VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >>> @@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio=
 *folio,
> >>>
> >>>          gfp &=3D GFP_RECLAIM_MASK;
> >>>          folio_throttle_swaprate(folio, gfp);
> >>> +       swap =3D iter =3D radix_to_swp_entry(expected);
> >>>
> >>>          do {
> >>>                  xas_lock_irq(&xas);
> >>
> >> I missed a xas_reset here, also better reset iter value too.
> >>
> >>> -               if (expected !=3D xas_find_conflict(&xas)) {
> >>> -                       xas_set_err(&xas, -EEXIST);
> >>> -                       goto unlock;
> >>> +               xas_for_each_conflict(&xas, entry) {
> >>> +                       /*
> >>> +                        * The range must either be empty, or filled =
with
> >>> +                        * expected swap entries. Shmem swap entries =
are never
> >>> +                        * partially freed without split of both entr=
y and
> >>> +                        * folio, so there shouldn't be any holes.
> >>> +                        */
> >>> +                       if (!expected || entry !=3D swp_to_radix_entr=
y(iter)) {
> >>> +                               xas_set_err(&xas, -EEXIST);
> >>> +                               goto unlock;
> >>> +                       }
> >>> +                       iter.val +=3D 1 << xas_get_order(&xas);
> >>>                  }
> >>> -               if (expected && xas_find_conflict(&xas)) {
> >>> +               if (expected && iter.val - nr !=3D swap.val) {
> >>>                          xas_set_err(&xas, -EEXIST);
> >>>                          goto unlock;
> >>>                  }
> >>> @@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> >>>                          error =3D -ENOMEM;
> >>>                          goto failed;
> >>>                  }
> >>> -       } else if (order !=3D folio_order(folio)) {
> >>> +       } else if (order > folio_order(folio)) {
> >>>                  /*
> >>>                   * Swap readahead may swap in order 0 folios into sw=
apcache
> >>>                   * asynchronously, while the shmem mapping can still=
 stores
> >>> @@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *i=
node, pgoff_t index,
> >>>
> >>>                          swap =3D swp_entry(swp_type(swap), swp_offse=
t(swap) + offset);
> >>>                  }
> >>> +       } else if (order < folio_order(folio)) {
> >>> +               swap.val =3D round_down(swap.val, 1 << folio_order(fo=
lio));
> >>>          }
> >>>
> >>>   alloced:
> >>>          /* We have to do this with folio locked to prevent races */
> >>>          folio_lock(folio);
> >>>          if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
> >>> -           / ||
> >>> -           !shmem_confirm_swap(mapping, index, swap) ||
> >>> -           xa_get_order(&mapping->i_pages, index) !=3D folio_order(f=
olio)) {
> >>
> >> And this part is incorrect. This `shmem_confirm_swap(mapping, index,
> >> swap) ` can't be simply omitted. Some functions below before the
> >> shmem_add_to_page_cache shouldn't be called on folios might have
> >> already been mapped by others. This shmem_confirm_swap ensures that
> >> won't happen.
>
> OK, thanks for the reminding. But could you elaborate a bit? Which
> function should not be called, and what problem might be caused?

Yes, first shmem_add_to_page_cache itself will reset the
folio->mapping and index before verifying the mapping.

So even if the folio is still a valid swap cache folio and the
folio->swap.val matches swap.val, a parallel swapin could have swapped
in the freed this folio from swap, and now it's possible that the
folio is now part of anon memory:

CPU1                      CPU2
/* Start swap in of swap entry S1 */
shmem_swapin_folio
/* Interrupted */
                          /* Raced swap in of swap entry S1 */
                          shmem_swapin_folio
                          /* Swapin done, S1 is freed */

                          /* Anon swapout of folio A using S1 */
                          pageout(folio) !=3D PAGE_SUCCESS
                          /* Now anon folio A is in swpa cache */
folio =3D swap_cache_get_folio
/* Got folio A */
if (!folio_test_swapcache(folio)
    folio->swap.val !=3D swap.val))
       error =3D -EEXIST;
/* Check passed, folio A is using S1 as swap entry */
shmem_add_to_page_cache
  folio->mapping =3D mapping
  /* BUG: folio->mapping is an anon mapping, info lost */

And I managed to trigger this issue, it will result in at least an RSS
counter error like this:

[  1944.374356] BUG: Bad rss-counter state mm:ffff0000c1539640
type:MM_ANONPAGES val:1
[  1944.374384] BUG: Bad rss-counter state mm:ffff0000c1539640
type:MM_SHMEMPAGES val:-1

Clearly it will trigger even more issues.

And other helpers like arch_swap_restore and shmem_replace_folio, they
seems to be OK, but if the folio is not part of shmem anymore they
better stay off of it too. So for safety measure I think we'd better
add the shmem_confirm_swap back. And only checking the first swap
entry is good enough.


>
> >> It may seem like a small change, but it leads to some minor conflicts
> >> in one or two following commits, the benchmark result will change too.
> >> So I'll have to send a V6 I think.
> >>
> >> We can remove this `shmem_confirm_swap`, but not in this series I
> >> think, maybe after this. Need to re-arrange some functions, with some
> >> clean ups for shmem_add_to_page_cache and others.
> >>
> >>> +           folio->swap.val !=3D swap.val) {
> >>>                  error =3D -EEXIST;
> >>>                  goto unlock;
> >>>          }
> >>> --
> >>> 2.50.0
> >>>
> >>
> >> In summary, I'll squash this patch into it and do a rebase of later co=
mmits:
> >>
> >> diff --git a/mm/shmem.c b/mm/shmem.c
> >> index e3c9a1365ff4..4ca0b665b79e 100644
> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -898,9 +898,11 @@ static int shmem_add_to_page_cache(struct folio *=
folio,
> >>
> >>          gfp &=3D GFP_RECLAIM_MASK;
> >>          folio_throttle_swaprate(folio, gfp);
> >> -       swap =3D iter =3D radix_to_swp_entry(expected);
> >> +       swap =3D radix_to_swp_entry(expected);
> >>
> >>          do {
> >> +               iter =3D swap;
> >> +               xas_reset(&xas);
> >
> > Correction: this xas_reset is not needed, the iter =3D swap is needed.
>
> Indeed, my tests do not cover the scenario where xas_nomem() returns true=
.
>
> >>                  xas_lock_irq(&xas);
> >>                  xas_for_each_conflict(&xas, entry) {
> >>                          /*
> >> @@ -2365,9 +2367,16 @@ static int shmem_swapin_folio(struct inode
> >> *inode, pgoff_t index,
> >>          }
> >>
> >>   alloced:
> >
> > And it needs `nr_pages =3D folio_nr_pages(folio); index =3D
> > round_down(index, nr_pages);` here...
>
> IIUC, the index alignment should move into the 'order <
> folio_order(folio)' branch?

Ok, I'll move it here. It should be fine either way.

>
> >> -       /* We have to do this with folio locked to prevent races */
> >> +       /*
> >> +        * We have to do this with folio locked to prevent races.
> >> +        * The shmem_confirm_swap below only checks if the first swap
> >> +        * entry matches the folio, that's enough to ensure the folio
> >> +        * is not used outside of shmem, as shmem swap entrie
> >> +        * and swap cache folios are never partially freed.
> >> +        */
> >>          folio_lock(folio);
> >>          if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
> >> +           !shmem_confirm_swap(mapping, index, swap) ||
> >>              folio->swap.val !=3D swap.val) {
> >>                  error =3D -EEXIST;
> >>                  goto unlock;
> >>
> >> And I'll do some clean up afterward to get rid of this
> >> shmem_confirm_swap. How do you think?
>

