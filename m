Return-Path: <stable+bounces-155284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC5AAE3401
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 05:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C583AAAB6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 03:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD83419C554;
	Mon, 23 Jun 2025 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4F1hJht"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C910E5;
	Mon, 23 Jun 2025 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750649908; cv=none; b=Dyl3e5NKHRyz6SRMEzoqCz4B5/0WLwbbiNdmBgkkhduEIRlQqvv2a2+BJ2QS23LBxHmzgaPsd1DXOiRkErqm5wGAf+8linBBLs1kH8QSVeZB9b51nebKACWD9T9rNqUHrEp9IiENOanntPmMHqDKM3V1K+1lwcDn/3Mbdry37NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750649908; c=relaxed/simple;
	bh=p0uRzZ3P1vOdWoWcZWEqpKn7/+bx+Ol3tEFkICXHK3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmuMckkO7EAzsSCEQ97w5iXs2NTreAR6nJOKHWtOQufBkh6fg2iWYJgUXsWxPzp09pij6R2XDWB1oyfvppeR6c8q/KdWH8sSe+RyZFkPzsFvxKunjBohwMa01H3SDw0GErLLNmN5WzwgSL+xCglFA1+KKO9ZtxuFQ/3PCGgDULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4F1hJht; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b553e33e6so31790791fa.2;
        Sun, 22 Jun 2025 20:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750649905; x=1751254705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ1AbjGt4auz1KCPnf6rfW6+GLOGIFLk8pJenKl3bro=;
        b=E4F1hJht/POD2+VQuDPLF19t7dOdu4IeKZT8EdIWOAgqkaGNuDkyk8c/ir8TXFUqWg
         MOX4833LB/17MPJbl+UBHqGjVTfu1j8n753q7q5BuDIxcpdwecMIseEQaJQYwpwt3CA9
         BTBw8YH3a1jap1Fpl6DkoRj7rEm0nFS0KJ3u30am0JEaVMt9KOdmF4Mc+lGdpTAyQaH6
         fd6C6z+vtzlSFcUFgB8GMObC+VtqSsja43iJ6r0haCTQ0S9SEV6PW77GbXKjlZlG/HfK
         liImf4n+Cokj4/c7QI1mHLekm2NMfUzdcbqm7MU9Wv5uO6idgUzStBWPnkVts72aqa9H
         O2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750649905; x=1751254705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZ1AbjGt4auz1KCPnf6rfW6+GLOGIFLk8pJenKl3bro=;
        b=cfbO6ifEi5mf2mIMSfTZUR9aQkjzJh2Fb8HJWc1jK2tA1Mlp1Kmf/lpbA4JLbQ/wmf
         KASVk/52KDXq0AwkfLzzgNYEK6xwTe3AK4inGR6Nvxb24z+xSdcvfMviOK7IHhz/chpO
         upftDWttu7HYWt6Ox37RzIWLxhRpqg0h79MfBa8hDiIR65vxZ6cOTeP+fNmG6DrsK9g6
         D68f2NsQhMVo4xPZ2OrFyRunhoXP+4KeHDJxvlt1SeNHTnRiLsUfiR1czLQfy+jzmMzn
         3EyctDoTQpqIwQmrP3GWGCeVnyIkZn5857Nf3z+Ox6y1rRW8iM2InUUslqAssFX6eUZm
         Wfqw==
X-Forwarded-Encrypted: i=1; AJvYcCU2TlDPb/UBjFDDaSPwPhCKbCAP6SR+IeihKdDmpkUcO+Sci/rRn5DAf8bTeDHucTFV6dSnQ6oTCt31bUc=@vger.kernel.org, AJvYcCV/JXoagKqb4sySSpApgkDhYFBek97tZx830GjEqUQsFiU7AfJPse7udR6fxSixHOYDLRWCaUH2@vger.kernel.org
X-Gm-Message-State: AOJu0YysDRfNAcS5waf6JBb05WSfv5bRHJqczDjP+aCR0qcn4rxJrLri
	c1gnqbQLIfzniPpMkyGO9E7/2Q6unGXp+GTvTatSpVytQf85P2DfAF2w2aCBXYnx2nqIu5rxQNm
	E/Np33JFKD88m0pp9vY3lDeqDmc7Zq0Y=
X-Gm-Gg: ASbGncv9z+YbsD+ed02N432drme/uBrBpPCAMtYpFa1Jr/CAlBYyRd31DSwvrQkSyey
	d8KbHqHUnCGZfwzBiumrty9IqiPhkvwDtt6rVspnJt5JN4PSVjAnyoruNgCqJqLltClTWQXnrAN
	c/H/5iGPipG5ARXMXRzWzR47GN02p6zEiEYTrv3rfMUfk=
X-Google-Smtp-Source: AGHT+IHCteR3rL5yqNc8IXBlqTm7+3SwBcFGG3LMXIscuiAe1FJxt9u28jimU6FFEb99vyCSKpQy9b4LjecBjt13ihw=
X-Received: by 2002:a05:651c:4184:b0:32b:7413:503 with SMTP id
 38308e7fff4ca-32b98e8e674mr28117831fa.16.1750649904821; Sun, 22 Jun 2025
 20:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619175538.15799-1-ryncsn@gmail.com> <20250619175538.15799-2-ryncsn@gmail.com>
 <f90a6072-b75a-40df-a58c-9a98e9ca10ad@linux.alibaba.com> <CAMgjq7B4RSDYAJ5aGijqq9cAzC8Jd8TF6gu-gpKjO5=E9a-RbQ@mail.gmail.com>
In-Reply-To: <CAMgjq7B4RSDYAJ5aGijqq9cAzC8Jd8TF6gu-gpKjO5=E9a-RbQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 23 Jun 2025 11:37:47 +0800
X-Gm-Features: AX0GCFu2jGEpYfrIe9qC-n9hl8s92eqhNotRcx_FUzHlzHr8_OMJW2bXPNtIbgU
Message-ID: <CAMgjq7DOzpZ1joujvnK2HrojXwB7akhNZnEQUM+BeD5PPDrWig@mail.gmail.com>
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

On Mon, Jun 23, 2025 at 11:35=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Mon, Jun 23, 2025 at 11:26=E2=80=AFAM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> > Hi Kairui,
> >
> > On 2025/6/20 01:55, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > The current swap-in code assumes that, when a swap entry in shmem
> > > mapping is order 0, its cached folios (if present) must be order 0
> > > too, which turns out not always correct.
> > >
> > > The problem is shmem_split_large_entry is called before verifying the
> > > folio will eventually be swapped in, one possible race is:
> > >
> > >      CPU1                          CPU2
> > > shmem_swapin_folio
> > > /* swap in of order > 0 swap entry S1 */
> > >    folio =3D swap_cache_get_folio
> > >    /* folio =3D NULL */
> > >    order =3D xa_get_order
> > >    /* order > 0 */
> > >    folio =3D shmem_swap_alloc_folio
> > >    /* mTHP alloc failure, folio =3D NULL */
> > >    <... Interrupted ...>
> > >                                   shmem_swapin_folio
> > >                                   /* S1 is swapped in */
> > >                                   shmem_writeout
> > >                                   /* S1 is swapped out, folio cached =
*/
> > >    shmem_split_large_entry(..., S1)
> > >    /* S1 is split, but the folio covering it has order > 0 now */
> > >
> > > Now any following swapin of S1 will hang: `xa_get_order` returns 0,
> > > and folio lookup will return a folio with order > 0. The
> > > `xa_get_order(&mapping->i_pages, index) !=3D folio_order(folio)` will
> > > always return false causing swap-in to return -EEXIST.
> > >
> > > And this looks fragile. So fix this up by allowing seeing a larger fo=
lio
> > > in swap cache, and check the whole shmem mapping range covered by the
> > > swapin have the right swap value upon inserting the folio. And drop
> > > the redundant tree walks before the insertion.
> > >
> > > This will actually improve the performance, as it avoided two redunda=
nt
> > > Xarray tree walks in the hot path, and the only side effect is that i=
n
> > > the failure path, shmem may redundantly reallocate a few folios
> > > causing temporary slight memory pressure.
> > >
> > > And worth noting, it may seems the order and value check before
> > > inserting might help reducing the lock contention, which is not true.
> > > The swap cache layer ensures raced swapin will either see a swap cach=
e
> > > folio or failed to do a swapin (we have SWAP_HAS_CACHE bit even if
> > > swap cache is bypassed), so holding the folio lock and checking the
> > > folio flag is already good enough for avoiding the lock contention.
> > > The chance that a folio passes the swap entry value check but the
> > > shmem mapping slot has changed should be very low.
> >
> > Thanks for fixing the issue. Sadly, I haven't reproduced this issue fro=
m
> > my previous test cases :(
> >
> > And I have a question below.
> >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> > > ---
> > >   mm/shmem.c | 30 +++++++++++++++++++++---------
> > >   1 file changed, 21 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index eda35be2a8d9..4e7ef343a29b 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *=
folio,
> > >                                  pgoff_t index, void *expected, gfp_t=
 gfp)
> > >   {
> > >       XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio=
));
> > > -     long nr =3D folio_nr_pages(folio);
> > > +     unsigned long nr =3D folio_nr_pages(folio);
> > > +     swp_entry_t iter, swap;
> > > +     void *entry;
> > >
> > >       VM_BUG_ON_FOLIO(index !=3D round_down(index, nr), folio);
> > >       VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> > > @@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio=
 *folio,
> > >
> > >       gfp &=3D GFP_RECLAIM_MASK;
> > >       folio_throttle_swaprate(folio, gfp);
> > > +     swap =3D iter =3D radix_to_swp_entry(expected);
> > >
> > >       do {
> > >               xas_lock_irq(&xas);
> > > -             if (expected !=3D xas_find_conflict(&xas)) {
> > > -                     xas_set_err(&xas, -EEXIST);
> > > -                     goto unlock;
> > > +             xas_for_each_conflict(&xas, entry) {
> > > +                     /*
> > > +                      * The range must either be empty, or filled wi=
th
> > > +                      * expected swap entries. Shmem swap entries ar=
e never
> > > +                      * partially freed without split of both entry =
and
> > > +                      * folio, so there shouldn't be any holes.
> > > +                      */
> > > +                     if (!expected || entry !=3D swp_to_radix_entry(=
iter)) {
> > > +                             xas_set_err(&xas, -EEXIST);
> > > +                             goto unlock;
> > > +                     }
> > > +                     iter.val +=3D 1 << xas_get_order(&xas);
> > >               }
> > > -             if (expected && xas_find_conflict(&xas)) {
> > > +             if (expected && iter.val - nr !=3D swap.val) {
> > >                       xas_set_err(&xas, -EEXIST);
> > >                       goto unlock;
> > >               }
> > > @@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> > >                       error =3D -ENOMEM;
> > >                       goto failed;
> > >               }
> > > -     } else if (order !=3D folio_order(folio)) {
> > > +     } else if (order > folio_order(folio)) {
> > >               /*
> > >                * Swap readahead may swap in order 0 folios into swapc=
ache
> > >                * asynchronously, while the shmem mapping can still st=
ores
> > > @@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *i=
node, pgoff_t index,
> > >
> > >                       swap =3D swp_entry(swp_type(swap), swp_offset(s=
wap) + offset);
> > >               }
> > > +     } else if (order < folio_order(folio)) {
> > > +             swap.val =3D round_down(swp_type(swap), folio_order(fol=
io));
> >
> > Why rounding down the swap type? do you mean rounding down the swap off=
set?
>
> Ouch, right, it should be the value:
>
> swap.val =3D round_down(swap.val, folio_order(folio));
>
> I messed up the code here during a rebase, let me send a V3 then.

Later commit reworked this part so I didn't notice it. It will be a
problem if this commit got cherry-picked. Thanks for the review!

