Return-Path: <stable+bounces-111073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B353A21780
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 06:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D35166D22
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 05:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7580188734;
	Wed, 29 Jan 2025 05:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWEQMKJj"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932995672
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738129729; cv=none; b=sJhIyvslaPbn2/zmiowYCNVWRbZO27vCW7Tx06lZrP4QopIX73Ny86pPyzot2FvaOCujzltO29c9PmZEAzMk+HQWHng+KjMetdHYksxt0zHoJFb+Wih3oXXZup6bUpInCvE40BDWlS15ZGajs8830ilGbs9M5Ee6fZ3jDzVvbJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738129729; c=relaxed/simple;
	bh=zLTeDQN2/d5rwjgyaUmBoJMnBYYa7HFNSk6DWrKc41k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdOoWKz14HT8N0f165CZv2pDhDTfSjRicHE58Wm0NUAFjnxLQftnclzpgTqegnQ6Edfq61naqOvIuIebBcsDN5+0zSzxYsxtpwZlKbmSli4FG4NF4zVmUgiZVYrzj3+G1TV+q/6AJQkc++ZiOUkFJlV7LfZidKRWHAi9024Jda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWEQMKJj; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54024aa9febso6745797e87.1
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 21:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738129726; x=1738734526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4Flo92Ws1CKjLfySXJwEmj1yJvKOvZWv8ayX8yn5X4=;
        b=mWEQMKJjaWlp/3JO198JuBZQJdT7gePJTHVaRRVNh/uUdWa7qsKF6BbuN4z+zbsO0J
         JH6ZkQYckP0o9Kerp26yKMWUpQmtt6YNtbKYeY1LAsIDa5RTfVgCbgjyZ7ZoSKp3N7tT
         AcSv/BoMbi3payOCeTNSF8NvxKdNpH4gOM1LOCfbsEaJgZ1MQfIWBeu1yqOMOYLrhVVc
         ydroG4GZboaLe38xCUk2bCO0Ep1W/HPsFUUSjzXHivhOUc14v9Q836C8H6hYIpNJmBui
         0ALdLd1FLynVmRVsKVBj/ZwsUACSKwUlwLWpaHSnFibnwRTBLxu2X7hdr5wsJwx6oh7r
         Aydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738129726; x=1738734526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4Flo92Ws1CKjLfySXJwEmj1yJvKOvZWv8ayX8yn5X4=;
        b=MhyqgNskd2hOv7zUmuG9gmRkd4hNmNAlKwF5tXmWoawGG+A6IVVRIrjWZgO94tcdzL
         fct1Vnuwp5gJFTWzRBijdjEDbUx3+wv15I68uTEH0HHbNIKtq93/+iKOi5lA6a2Gvcwk
         s2BL5JuHbgiyNPUYqP4wgHIFPklIP47/yGPh5ZLWxom0RuaAP6tZlpzMUd7Qz6NyeDMs
         fZTijTasZFvfXRvHJ4bkxuC45/WhjmhY+g+x4Bvssqmgl0KkKFg9+m2q0pK1YmbijmRl
         Wy7mUNKA23sIPr/9jpw3MoN7I4K1RJC54gHlQSWNqZI2aOQjtNLdZXZ+gtSi6ldUQBP9
         bNeA==
X-Forwarded-Encrypted: i=1; AJvYcCVx0Ul5yODD1DcJ7yntyiLBPgOthlTTgBOZ6DlD7TAyaUc7sIp9l5hgSajsJc4OKC9Y0xkvNMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3g4Ett54DMQIbtR8IFMFjC/Bm6823mOrOzkn2u4Iw6LBkHtB
	6QdGbOFX/ztUBaHTskuJd29kII6ynm7a+2WPL92yuMD6X3C3z2RXWeAJWm4cZbLdu4QPmZLtV1o
	7cVy9xXR4iANrbFA6YfGyCk5QCHE=
X-Gm-Gg: ASbGncu26SEVfxAoFpo+c7ompTy4XEpZvRWQMNxnWlBd0NVfd030mipsuMHkvrOU5Ab
	jMRbqfcdamo6mSFoXNjP8Lyrf5DDClVCaZD7BeZJGwmeqBcIIbjeHx1BQ24vs1cz/PStfmvecHe
	w=
X-Google-Smtp-Source: AGHT+IH79ysMd+zfQo6uBZ0P4S8xhWIAGh1/HlmQybma6Yavn/m0erKd2wqY31sKpFEx9Z05ILrtR9RrQbjx39Y9TrI=
X-Received: by 2002:a05:6512:2344:b0:540:1b07:e033 with SMTP id
 2adb3069b0e04-543e4c3e1afmr517020e87.45.1738129725446; Tue, 28 Jan 2025
 21:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128185507.2176-1-42.hyeyoo@gmail.com> <SA3PR11MB81206771932B54FCFFD0DF2CC9EF2@SA3PR11MB8120.namprd11.prod.outlook.com>
 <Z5kty3MCeILaoLwz@google.com>
In-Reply-To: <Z5kty3MCeILaoLwz@google.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 29 Jan 2025 14:48:33 +0900
X-Gm-Features: AWEUYZmVHVUggp5omvsnyTnYuvT9BZPcI1izdir3u0U3m6Yig7rXwfsLREKHx2o
Message-ID: <CAB=+i9TaXDdGa0+EgyK=0Sq-DKqs5GAhyoJuUypdCPSqDrk1zg@mail.gmail.com>
Subject: Re: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 4:19=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Tue, Jan 28, 2025 at 07:09:05PM +0000, Sridhar, Kanchana P wrote:
> > Hi Hyeonggon,
> >
> > > -----Original Message-----
> > > From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > Sent: Tuesday, January 28, 2025 10:55 AM
> > > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; Johannes Wein=
er
> > > <hannes@cmpxchg.org>; Yosry Ahmed <yosryahmed@google.com>; Nhat
> > > Pham <nphamcs@gmail.com>; Chengming Zhou
> > > <chengming.zhou@linux.dev>; Andrew Morton <akpm@linux-
> > > foundation.org>
> > > Cc: linux-mm@kvack.org; Hyeonggon Yoo <42.hyeyoo@gmail.com>;
> > > stable@vger.kernel.org
> > > Subject: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging w=
hen
> > > zswap_store_page() fails
> > >
> > > Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store(=
)")
> > > skips charging any zswapped base pages when it failed to zswap the en=
tire
> > > folio.
> > >
> > > However, when some base pages are zswapped but it failed to zswap
> > > the entire folio, the zswap operation is rolled back.
> > > When freeing zswap entries for those pages, zswap_entry_free() unchar=
ges
> > > the pages that were not previously charged, causing zswap charging to
> > > become inconsistent.
> > >
> > > This inconsistency triggers two warnings with following steps:
> > >   # On a machine with 64GiB of RAM and 36GiB of zswap
> > >   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
> > >   $ sudo reboot
> > >
> > >   Two warnings are:
> > >     in mm/memcontrol.c:163, function obj_cgroup_release():
> > >       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> > >
> > >     in mm/page_counter.c:60, function page_counter_cancel():
> > >       if (WARN_ONCE(new < 0, "page_counter underflow: %ld
> > > nr_pages=3D%lu\n",
> > >       new, nr_pages))
> > >
> > > While objcg events should only be accounted for when the entire folio=
 is
> > > zswapped, objcg charging should be performed regardlessly.
> > > Fix accordingly.
> > >
> > > After resolving the inconsistency, these warnings disappear.
> > >
> > > Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store(=
)")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > ---
> > >
> > > v1->v2:
> > >
> > >  Fixed objcg events being accounted for on zswap failure.
> > >
> > >  Fixed the incorrect description. I misunderstood that the base pages=
 are
> > >  going to be stored in zswap, but their zswap entries are freed immed=
iately.
> > >
> > >  Added a comment on why it charges pages that are going to be removed
> > >  from zswap.
> > >
> > >  mm/zswap.c | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 6504174fbc6a..10b30ac46deb 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1568,20 +1568,26 @@ bool zswap_store(struct folio *folio)
> > >
> > >             bytes =3D zswap_store_page(page, objcg, pool);
> > >             if (bytes < 0)
> > > -                   goto put_pool;
> > > +                   goto charge_zswap;
> > >             compressed_bytes +=3D bytes;
> > >     }
> > >
> > > -   if (objcg) {
> > > -           obj_cgroup_charge_zswap(objcg, compressed_bytes);
> > > +   if (objcg)
> > >             count_objcg_events(objcg, ZSWPOUT, nr_pages);
> > > -   }
> > >
> > >     atomic_long_add(nr_pages, &zswap_stored_pages);
> > >     count_vm_events(ZSWPOUT, nr_pages);
> > >
> > >     ret =3D true;
> > >
> > > +charge_zswap:
> > > +   /*
> > > +    * Charge zswapped pages even when it failed to zswap the entire
> > > folio,
> > > +    * because zswap_entry_free() will uncharge them anyway.
> > > +    * Otherwise zswap charging will become inconsistent.
> > > +    */
> > > +   if (objcg)
> > > +           obj_cgroup_charge_zswap(objcg, compressed_bytes);
> >
> > Thanks for finding this bug! I am thinking it might make sense to charg=
e
> > and increment the zswap_stored_pages counter in zswap_store_page().
> > Something like:
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index b84c20d889b1..fd2a72598a8a 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1504,11 +1504,14 @@ static ssize_t zswap_store_page(struct page *pa=
ge,
> >       entry->pool =3D pool;
> >       entry->swpentry =3D page_swpentry;
> >       entry->objcg =3D objcg;
> > +     if (objcg)
> > +             obj_cgroup_charge_zswap(objcg, entry->length);
> >       entry->referenced =3D true;
> >       if (entry->length) {
> >               INIT_LIST_HEAD(&entry->lru);
> >               zswap_lru_add(&zswap_list_lru, entry);
> >       }
> > +     atomic_long_inc(&zswap_stored_pages);
> >
> >       return entry->length;
> >
> > @@ -1526,7 +1529,6 @@ bool zswap_store(struct folio *folio)
> >       struct obj_cgroup *objcg =3D NULL;
> >       struct mem_cgroup *memcg =3D NULL;
> >       struct zswap_pool *pool;
> > -     size_t compressed_bytes =3D 0;
> >       bool ret =3D false;
> >       long index;
> >
> > @@ -1569,15 +1571,11 @@ bool zswap_store(struct folio *folio)
> >               bytes =3D zswap_store_page(page, objcg, pool);
> >               if (bytes < 0)
> >                       goto put_pool;
> > -             compressed_bytes +=3D bytes;
> >       }
> >
> > -     if (objcg) {
> > -             obj_cgroup_charge_zswap(objcg, compressed_bytes);
> > +     if (objcg)
> >               count_objcg_events(objcg, ZSWPOUT, nr_pages);
> > -     }
> >
> > -     atomic_long_add(nr_pages, &zswap_stored_pages);
> >       count_vm_events(ZSWPOUT, nr_pages);
> >
> >       ret =3D true;
> >
> > What do you think?
> >
> > Yosry, Nhat, Johannes, please let me know if this would be a cleaner
> > approach. If so, I don't think we would be losing a lot of performance
> > by not doing the one-time charge per folio, but please let me know
> > your thoughts as well.
>
> This is certainly cleaner, and thanks for catching that
> zswap_stored_pages cleanup is also wrong.

Oh, yeah. Thanks for catching zswap_stored_pages.

> I am not sure if this has meaningful impact on performance, but it seems
> like we are doing a bit more work in the common success case to avoid
> the work in the uncommon failure case.

Right, but at the same time I think we need some evaluation to sacrifice
readability for performance. No need to be in a hurry to optimize when
fixing a bug, I think.

> Moving the charge (and atomic addition) above the zswap_store_page()
> loop would be doing the opposite, albeit less clean.

I think that wouldn't work because zswap won't uncharge for pages that
zswap_store_page() fails to store. And we don't know how many pages are
going to be stored in zswap in advance.

IMO v2 of this patch is efficient and it works while charging just to
uncharge doesn't look great.

> I don't feel strongly either way, but I slightly prefer the latter.

I'd prefer writing more readable code because it's a hotfix.
Let me post v3 with Sridhar's feedback (the former) adjusted!

