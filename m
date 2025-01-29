Return-Path: <stable+bounces-111074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF5BA217C3
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 07:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90BA18881E5
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 06:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658617E015;
	Wed, 29 Jan 2025 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnyiIe+o"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36057823DE
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738132821; cv=none; b=t37BD11mMsYiAlHh3ezEzbFjrP25deInMlsjCfBNv5amkD8757mYVvo/swao2Icg6GGbX5dTu5NnO3GZHNVa8/6QLpDr84tslfHu9+CSvsfmEReft6axWySTtDug4/njrUD0Hm7Onph7MJ4ihQ6LJdpfSQPGuXKZe+RdzJ1nMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738132821; c=relaxed/simple;
	bh=ZRcULMiXr2k2wrTS1ngqsXPs9uxw8+wIFBYKhHIxk0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivuAlaoqnqd9HG+bEu2HpP272aNgRSJJ2CQ8SdCMKb8hahZTbL89bpdzuO8vYsJ9phL1AV79QG6l5THMQ23MY5I0s5bg6nTJYiGGqIl3P3a4fOpMtPsEGNPL1sQwfI0497RJJI6u4kGTvMd4cBYvPaqF5SCNzwN1lTlhDd0UbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnyiIe+o; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54024aa9febso6781758e87.1
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 22:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738132817; x=1738737617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6isReLAdoS6aWuC2/rSil8l7f86NbJOTiZ62Ip7Wor4=;
        b=OnyiIe+oq5XNNs76rLJnkHbiW0Mbq+VNYKj8gj6YjL69k7VXVzhhg5DPnd9bZWigCB
         VMZCJC5s0u5W9g8ki8Ic4Sh0Lhd1wOqxWATMmZGPe0m6xoYMCeucPFh1rsZ9ReuFVCI4
         myxjNQEAq3dYKxlBTTLPCKsmaXGc/xHt3EQcsrL3Mzks8aFR6r76PfZHwLn4mvPmB9XC
         yrcykyL0qPbq0daMwyur0PsFe83w2aM5r9pbNIDwwhUSteAxXQJI/6cw5AsIZqfqIZYZ
         DBIQK5Zt1gl4j9B8On8iyiddmvjXx65YXGuRwHd7yUrSRJ2LGy31curdKF2XLmilPN4r
         VEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738132817; x=1738737617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6isReLAdoS6aWuC2/rSil8l7f86NbJOTiZ62Ip7Wor4=;
        b=oRZw6LqAc5iHte2zImvaXflpykkWx3+ellimQUJ/3JA41f7hz3dtUVbFP4djcb4Tjy
         U9b63fuw1sjZV13bT7Z+UGfxLbRKtj0tM5Eg5bOnUGPRRYKek7jMVmu6yyX6gpBgHmDH
         eoUaDER0AypTjGIp58eWcspAHzFBTBPJnGKWhR4cLTZbITQNKQ8J/+Sdp7Ys6f+pZwqj
         7KxwD4K1QEZxqNxvk4CjsGJ99EcsK/R0F4iLa8sVHUW924nA61yTygc9Ut+/LJKxWlWB
         UzwNjPOG80EBygZn4gu+TE4DSMvpfPzayS4MiitrqgA3Wrhf4ol7gFx8J0FV0KTw1xqc
         6Xhg==
X-Forwarded-Encrypted: i=1; AJvYcCW6y2GZjDljlg1Q4L4oL4+5If3Ve5h8hZkVFfyYnrPiM/nYbG149GpDeeAA5tNBPQmA9PgoMfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tVVsiIcKllObsvBcN01SPfvEaeEpFe9UBBHi8CKmpWMtwqMK
	RbY/9MDqpDGLxc4y2yUuNXf7GXene2rAG6qXVO+3rowHgS1FH0DKkCkZQ+CCHQgP4Ah3M4sP0BX
	V3bA2EUE/CJszVKob0e3avGN3SFs=
X-Gm-Gg: ASbGncsHORzU0pTKVdA+xDhM/VRaLAQEqTatWx7vUvKHFJTVMcAmHCoszPnLx8wAVOw
	oRhLvUm0AWR9ltFQ0nt8y4H+jesgz/uvbB365FiZnEYmrAx7M55+vmpeTiK5pRLs9V8GwIDkeck
	C88LEdEhmkbg==
X-Google-Smtp-Source: AGHT+IHUv39tyL1eOqadyRt1GHW006Tn6NmbmkMSTBUsczjrXgo01QsD/3dSO97xOFc+k9ROweae1TwHCuFzPuZgfTc=
X-Received: by 2002:a05:6512:3d92:b0:540:2022:e3b7 with SMTP id
 2adb3069b0e04-543e4c3fdc4mr386879e87.53.1738132816871; Tue, 28 Jan 2025
 22:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128185507.2176-1-42.hyeyoo@gmail.com> <SA3PR11MB81206771932B54FCFFD0DF2CC9EF2@SA3PR11MB8120.namprd11.prod.outlook.com>
In-Reply-To: <SA3PR11MB81206771932B54FCFFD0DF2CC9EF2@SA3PR11MB8120.namprd11.prod.outlook.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 29 Jan 2025 15:40:04 +0900
X-Gm-Features: AWEUYZnFcyk0wJcOv9GOVR5zQlNeyY4r21oAmDUugcXoq4-ygFcFJ_ateoC4o4I
Message-ID: <CAB=+i9SwTtZjM+E346C6moZCbZMsGuT14qwbbL0k26mwTJ-oug@mail.gmail.com>
Subject: Re: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 4:09=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi Hyeonggon,
>
> > -----Original Message-----
> > From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Sent: Tuesday, January 28, 2025 10:55 AM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; Johannes Weiner
> > <hannes@cmpxchg.org>; Yosry Ahmed <yosryahmed@google.com>; Nhat
> > Pham <nphamcs@gmail.com>; Chengming Zhou
> > <chengming.zhou@linux.dev>; Andrew Morton <akpm@linux-
> > foundation.org>
> > Cc: linux-mm@kvack.org; Hyeonggon Yoo <42.hyeyoo@gmail.com>;
> > stable@vger.kernel.org
> > Subject: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging whe=
n
> > zswap_store_page() fails
> >
> > Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()"=
)
> > skips charging any zswapped base pages when it failed to zswap the enti=
re
> > folio.
> >
> > However, when some base pages are zswapped but it failed to zswap
> > the entire folio, the zswap operation is rolled back.
> > When freeing zswap entries for those pages, zswap_entry_free() uncharge=
s
> > the pages that were not previously charged, causing zswap charging to
> > become inconsistent.
> >
> > This inconsistency triggers two warnings with following steps:
> >   # On a machine with 64GiB of RAM and 36GiB of zswap
> >   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
> >   $ sudo reboot
> >
> >   Two warnings are:
> >     in mm/memcontrol.c:163, function obj_cgroup_release():
> >       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> >
> >     in mm/page_counter.c:60, function page_counter_cancel():
> >       if (WARN_ONCE(new < 0, "page_counter underflow: %ld
> > nr_pages=3D%lu\n",
> >         new, nr_pages))
> >
> > While objcg events should only be accounted for when the entire folio i=
s
> > zswapped, objcg charging should be performed regardlessly.
> > Fix accordingly.
> >
> > After resolving the inconsistency, these warnings disappear.
> >
> > Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >
> > v1->v2:
> >
> >  Fixed objcg events being accounted for on zswap failure.
> >
> >  Fixed the incorrect description. I misunderstood that the base pages a=
re
> >  going to be stored in zswap, but their zswap entries are freed immedia=
tely.
> >
> >  Added a comment on why it charges pages that are going to be removed
> >  from zswap.
> >
> >  mm/zswap.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 6504174fbc6a..10b30ac46deb 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1568,20 +1568,26 @@ bool zswap_store(struct folio *folio)
> >
> >               bytes =3D zswap_store_page(page, objcg, pool);
> >               if (bytes < 0)
> > -                     goto put_pool;
> > +                     goto charge_zswap;
> >               compressed_bytes +=3D bytes;
> >       }
> >
> > -     if (objcg) {
> > -             obj_cgroup_charge_zswap(objcg, compressed_bytes);
> > +     if (objcg)
> >               count_objcg_events(objcg, ZSWPOUT, nr_pages);
> > -     }
> >
> >       atomic_long_add(nr_pages, &zswap_stored_pages);
> >       count_vm_events(ZSWPOUT, nr_pages);
> >
> >       ret =3D true;
> >
> > +charge_zswap:
> > +     /*
> > +      * Charge zswapped pages even when it failed to zswap the entire
> > folio,
> > +      * because zswap_entry_free() will uncharge them anyway.
> > +      * Otherwise zswap charging will become inconsistent.
> > +      */
> > +     if (objcg)
> > +             obj_cgroup_charge_zswap(objcg, compressed_bytes);
>
> Thanks for finding this bug! I am thinking it might make sense to charge
> and increment the zswap_stored_pages counter in zswap_store_page().
> Something like:
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b84c20d889b1..fd2a72598a8a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1504,11 +1504,14 @@ static ssize_t zswap_store_page(struct page *page=
,
>         entry->pool =3D pool;
>         entry->swpentry =3D page_swpentry;
>         entry->objcg =3D objcg;
> +       if (objcg)
> +               obj_cgroup_charge_zswap(objcg, entry->length);
>         entry->referenced =3D true;
>         if (entry->length) {
>                 INIT_LIST_HEAD(&entry->lru);
>                 zswap_lru_add(&zswap_list_lru, entry);
>         }
> +       atomic_long_inc(&zswap_stored_pages);
>
>         return entry->length;
>
> @@ -1526,7 +1529,6 @@ bool zswap_store(struct folio *folio)
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
>         struct zswap_pool *pool;
> -       size_t compressed_bytes =3D 0;
>         bool ret =3D false;
>         long index;
>
> @@ -1569,15 +1571,11 @@ bool zswap_store(struct folio *folio)
>                 bytes =3D zswap_store_page(page, objcg, pool);
>                 if (bytes < 0)
>                         goto put_pool;
> -               compressed_bytes +=3D bytes;
>         }
>
> -       if (objcg) {
> -               obj_cgroup_charge_zswap(objcg, compressed_bytes);
> +       if (objcg)
>                 count_objcg_events(objcg, ZSWPOUT, nr_pages);
> -       }
>
> -       atomic_long_add(nr_pages, &zswap_stored_pages);
>         count_vm_events(ZSWPOUT, nr_pages);
>
>         ret =3D true;

Hi Sridhar, It looks much clearer!
And we can optimize if it turns out to be worth the complexity.

May I ask your permission to add your Signed-off-by: and Co-developed-by: ?
I'm afraid to use this without your confirmation due to the
Developer's Certificate of Origin.

Best,
Hyeonggon

> >  put_pool:
> >       zswap_pool_put(pool);
> >  put_objcg:
> > --
> > 2.47.1
>

