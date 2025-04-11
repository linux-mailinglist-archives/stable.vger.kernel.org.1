Return-Path: <stable+bounces-132295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C55A864FE
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 19:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B858A082E
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DDF23F28A;
	Fri, 11 Apr 2025 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrShjECg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEA22068A
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393521; cv=none; b=sm86nd1a7dj4tCj1AxDTE+SdA2WIRFNlUnrGJ0Ujg2SmjFAVu2+AOeolYFy4vrXsxg/GpcFT8/p96EQwU6nkGT5HkscMvicI7qCshbuIazdqHvR4EwlDylvcZOkEYez/N+uq7zcQHwr9X497mlsBI6hIcRXjTdVFMg1ud90QzsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393521; c=relaxed/simple;
	bh=KiEVXA/Q0poANwYyZ4gqi2WQuP89+Iijb6G3+Hig41o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma7FY9D2qRTuMTaPeRw15j/4WiUtQhaPVBTtyB3wXsVIAup0+KCMbSTxUC0LSGrfK2dLuJhvJPC0EVJoXRS1rwRGeuEQiF5FIrHiJPx+GMJjFhWfHBBWKhD1q3pmu741pn3ko6/UVg9e/SylYNpllK+cQCG4bwaseFQ6svGAOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrShjECg; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47681dba807so14181cf.1
        for <stable@vger.kernel.org>; Fri, 11 Apr 2025 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744393518; x=1744998318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmYXhvJwA000VWMeCK8milYpnMkrsLEvAm6JDEvQW/0=;
        b=GrShjECgFvYgSe4LQQOO0KZq2Pmp7ub6T7JU+Gr2qVLRCiRIK7qjQMtXerW3Gij0qe
         9fy12GcnCPn11tle6luuN/Js3+e+wURUTece8x3uwgtWtfc6THyYDxReldH9Egu5eHXb
         Frv0KX7nexT+BuA83z94cwSpqdtn2W9FF4kXq9+2pG1XQgU+J3XAGfCeQazChq4RxKNn
         imJDa4xjd9zipLl8RuFvPGuAPysg1hB/xv8p38AEfqndUxFxGN4JmpCHFwXkDC1AVImX
         rNzeFwFv8itqCTjOPSZEpraWb4SEqYbOvvEiARFaOJHX43+hHSqA2amxiwU58N1+0uQ+
         g8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744393518; x=1744998318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmYXhvJwA000VWMeCK8milYpnMkrsLEvAm6JDEvQW/0=;
        b=Dw9yCEiBJ0FuyxJs+3iwTk8KPqBInfqkXIa+VCE3vV/D0AvQplIDySuntYskxbBWAs
         h+XxPSa87bMw8HwsXzsz3pTQhPmCKVHSzmDi64fDOR0l2B2KTY098YLvcxYF9t+NOs8F
         7yGurKdy/Xzh4IvtUydc/wP3LRdc3Ac7tJj2vNj5jSG6ewzP2UK3o68PngVRV0kW+Uj/
         m6gph8veXhoBqtRA4xrrCnVOLURofd0TWH6wh5RQ5Enyn6LyMw1w+9GOWR6Wuh+dPXLW
         YHKJNYMAUv2wHm/a4ku9OubIeByG3HuZixZpnYfpqZRY1J2sKbkIykIL+TgG2XyU/dCN
         JA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2VG2Vi4QtiMFySjPpH/zg29td1XhtVHgMUoJF2GVcNlE/S4BC9b6tIlMoO4btgSsr1elMnpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDcnH0o2ez1YZ3fZDvu6lfIHDpXliIWA4q+afqlvOkLjYv0yc
	na1WGppkVDuuphLvu4SY7j8+mick1ETXlb9ZKl0lMECUPv9IHh2634W1lqt/6EsV9lJ+M1m6QXI
	A8khShKDLlIIQQ8zrXn4wOk1DP1Sb/5SenUYJ
X-Gm-Gg: ASbGncsvAzVWpwMFQliTcSMqteCzoEybnkLhHYzZbQfJczHD+2u5vnBKMFfOZdekzWw
	RCHlEaokCWvWh+mdLCfYa2n0SjQlUKyEuzm3SljqGnzfisfc1KNj2C20jTdYCDT90cb4sqXVJWf
	n79nY17a7c//o55tTiGHbv
X-Google-Smtp-Source: AGHT+IHpwrjXSN6F4QCOmiuy6BbuSaN1+LsfqI5XkD54bWWbea8IxYWQLbQiHd58FbUQro6BdgwbXf2cDgtUZk2rlbQ=
X-Received: by 2002:a05:622a:19a3:b0:477:635f:5947 with SMTP id
 d75a77b69052e-4798152c235mr109641cf.12.1744393517762; Fri, 11 Apr 2025
 10:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411155737.1360746-1-surenb@google.com> <c88ec69c-87ee-4865-8b2a-87f32f46b0bc@suse.cz>
 <CAJuCfpE6_Hb40kyM7E4ESw8-_ptm3SARuL0q_YBB49cqkVbPig@mail.gmail.com>
In-Reply-To: <CAJuCfpE6_Hb40kyM7E4ESw8-_ptm3SARuL0q_YBB49cqkVbPig@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Apr 2025 10:45:06 -0700
X-Gm-Features: ATxdqUHCT-k-GR4pvwi0nv1jejzjDGqDtAGhqf1BigdhISanxeHgLCIg8Cp8WgY
Message-ID: <CAJuCfpGrJNiDWxsD=53ZOzWKHAh=xw2pGidg6oAgwj8mETGPQQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] slab: ensure slab->obj_exts is clear in a newly
 allocated slab page
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	roman.gushchin@linux.dev, cl@linux.com, rientjes@google.com, 
	harry.yoo@oracle.com, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 9:59=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Apr 11, 2025 at 9:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 4/11/25 17:57, Suren Baghdasaryan wrote:
> > > ktest recently reported crashes while running several buffered io tes=
ts
> > > with __alloc_tagging_slab_alloc_hook() at the top of the crash call s=
tack.
> > > The signature indicates an invalid address dereference with low bits =
of
> > > slab->obj_exts being set. The bits were outside of the range used by
> > > page_memcg_data_flags and objext_flags and hence were not masked out
> > > by slab_obj_exts() when obtaining the pointer stored in slab->obj_ext=
s.
> > > The typical crash log looks like this:
> > >
> > > 00510 Unable to handle kernel NULL pointer dereference at virtual add=
ress 0000000000000010
> > > 00510 Mem abort info:
> > > 00510   ESR =3D 0x0000000096000045
> > > 00510   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > 00510   SET =3D 0, FnV =3D 0
> > > 00510   EA =3D 0, S1PTW =3D 0
> > > 00510   FSC =3D 0x05: level 1 translation fault
> > > 00510 Data abort info:
> > > 00510   ISV =3D 0, ISS =3D 0x00000045, ISS2 =3D 0x00000000
> > > 00510   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
> > > 00510   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > 00510 user pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000104175000
> > > 00510 [0000000000000010] pgd=3D0000000000000000, p4d=3D00000000000000=
00, pud=3D0000000000000000
> > > 00510 Internal error: Oops: 0000000096000045 [#1]  SMP
> > > 00510 Modules linked in:
> > > 00510 CPU: 10 UID: 0 PID: 7692 Comm: cat Not tainted 6.15.0-rc1-ktest=
-g189e17946605 #19327 NONE
> > > 00510 Hardware name: linux,dummy-virt (DT)
> > > 00510 pstate: 20001005 (nzCv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=3D-=
-)
> > > 00510 pc : __alloc_tagging_slab_alloc_hook+0xe0/0x190
> > > 00510 lr : __kmalloc_noprof+0x150/0x310
> > > 00510 sp : ffffff80c87df6c0
> > > 00510 x29: ffffff80c87df6c0 x28: 000000000013d1ff x27: 000000000013d2=
00
> > > 00510 x26: ffffff80c87df9e0 x25: 0000000000000000 x24: 00000000000000=
01
> > > 00510 x23: ffffffc08041953c x22: 000000000000004c x21: ffffff80c00021=
80
> > > 00510 x20: fffffffec3120840 x19: ffffff80c4821000 x18: 00000000000000=
00
> > > 00510 x17: fffffffec3d02f00 x16: fffffffec3d02e00 x15: fffffffec3d007=
00
> > > 00510 x14: fffffffec3d00600 x13: 0000000000000200 x12: 00000000000000=
06
> > > 00510 x11: ffffffc080bb86c0 x10: 0000000000000000 x9 : ffffffc080201e=
58
> > > 00510 x8 : ffffff80c4821060 x7 : 0000000000000000 x6 : 00000000555555=
56
> > > 00510 x5 : 0000000000000001 x4 : 0000000000000010 x3 : 00000000000000=
60
> > > 00510 x2 : 0000000000000000 x1 : ffffffc080f50cf8 x0 : ffffff80d801d0=
00
> > > 00510 Call trace:
> > > 00510  __alloc_tagging_slab_alloc_hook+0xe0/0x190 (P)
> > > 00510  __kmalloc_noprof+0x150/0x310
> > > 00510  __bch2_folio_create+0x5c/0xf8
> > > 00510  bch2_folio_create+0x2c/0x40
> > > 00510  bch2_readahead+0xc0/0x460
> > > 00510  read_pages+0x7c/0x230
> > > 00510  page_cache_ra_order+0x244/0x3a8
> > > 00510  page_cache_async_ra+0x124/0x170
> > > 00510  filemap_readahead.isra.0+0x58/0xa0
> > > 00510  filemap_get_pages+0x454/0x7b0
> > > 00510  filemap_read+0xdc/0x418
> > > 00510  bch2_read_iter+0x100/0x1b0
> > > 00510  vfs_read+0x214/0x300
> > > 00510  ksys_read+0x6c/0x108
> > > 00510  __arm64_sys_read+0x20/0x30
> > > 00510  invoke_syscall.constprop.0+0x54/0xe8
> > > 00510  do_el0_svc+0x44/0xc8
> > > 00510  el0_svc+0x18/0x58
> > > 00510  el0t_64_sync_handler+0x104/0x130
> > > 00510  el0t_64_sync+0x154/0x158
> > > 00510 Code: d5384100 f9401c01 b9401aa3 b40002e1 (f8227881)
> > > 00510 ---[ end trace 0000000000000000 ]---
> > > 00510 Kernel panic - not syncing: Oops: Fatal exception
> > > 00510 SMP: stopping secondary CPUs
> > > 00510 Kernel Offset: disabled
> > > 00510 CPU features: 0x0000,000000e0,00000410,8240500b
> > > 00510 Memory Limit: none
> > >
> > > Investigation indicates that these bits are already set when we alloc=
ate
> > > slab page and are not zeroed out after allocation. We are not yet sur=
e
> > > why these crashes start happening only recently but regardless of the
> > > reason, not initializing a field that gets used later is wrong. Fix i=
t
> > > by initializing slab->obj_exts during slab page allocation.
> >
> > slab->obj_exts overlays page->memcg_data and the checks on page alloc a=
nd
> > page free should catch any non-zero values, i.e. page_expected_state()
> > page_bad_reason() so if anyone is e.g. UAF-writing there or leaving gar=
bage
> > there while freeing the page it's a bug.
> >
> > Perhaps CONFIG_MEMCG is disabled in the ktests and thus the checks are =
not
> > happening? We could extend them for CONFIG_SLAB_OBJ_EXT checking
> > _unused_slab_obj_exts perhaps. But it would be a short lived change, se=
e below.
>
> Correct, CONFIG_MEMCG was disabled during these tests. We added
> BUG_ON() in the slab allocation path to trigger on these low bits and
> it did trigger but the same assertion in the freeing path did not
> catch anything. We suspected 4996fc547f5b ("mm: let _folio_nr_pages
> overlay memcg_data in first tail page") to cause this but Kent's
> bisection did not confirm that.
>
> >
> > > Fixes: 21c690a349ba ("mm: introduce slabobj_ext to support slab objec=
t extensions")
> > > Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Tested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Acked-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Cc: <stable@vger.kernel.org>
> >
> > We'll need this anyway for the not so far future when struct slab is
> > separated from struct page so it's fine but it would still be great to =
find
> > the underlying buggy code which this is going to hide.
>
> Yeah, we will try to find the culprit. For now to prevent others from
> stepping on this mine I would like to get this in. Thanks!

Kent asked me to forward this (his email is misbehaving for some reason):

Yes, ktest doesn't flip on CONFIG_MEMCG.

Those checks you're talking about are also behind CONFIG_DEBUG_VM,
which isn't normally on. I did do some runs with it on and it didn't
fire - only additional asserts Suren and I added - so something's
missing.

In the meantime, this needs to go in quickly as a hotfix because it's
a 6.15-rc1 regression, and I've been getting distros to enable memory
allocation profiling and I'd be shocked if it doesn't cause memcg
crashes as well.




>
> >
> > > ---
> > >  mm/slub.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index b46f87662e71..dc9e729e1d26 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -1973,6 +1973,11 @@ static inline void handle_failed_objexts_alloc=
(unsigned long obj_exts,
> > >  #define OBJCGS_CLEAR_MASK    (__GFP_DMA | __GFP_RECLAIMABLE | \
> > >                               __GFP_ACCOUNT | __GFP_NOFAIL)
> > >
> > > +static inline void init_slab_obj_exts(struct slab *slab)
> > > +{
> > > +     slab->obj_exts =3D 0;
> > > +}
> > > +
> > >  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> > >                       gfp_t gfp, bool new_slab)
> > >  {
> > > @@ -2058,6 +2063,10 @@ static inline bool need_slab_obj_ext(void)
> > >
> > >  #else /* CONFIG_SLAB_OBJ_EXT */
> > >
> > > +static inline void init_slab_obj_exts(struct slab *slab)
> > > +{
> > > +}
> > > +
> > >  static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache =
*s,
> > >                              gfp_t gfp, bool new_slab)
> > >  {
> > > @@ -2637,6 +2646,7 @@ static struct slab *allocate_slab(struct kmem_c=
ache *s, gfp_t flags, int node)
> > >       slab->objects =3D oo_objects(oo);
> > >       slab->inuse =3D 0;
> > >       slab->frozen =3D 0;
> > > +     init_slab_obj_exts(slab);
> > >
> > >       account_slab(slab, oo_order(oo), s, flags);
> > >
> > >
> > > base-commit: c496b37f9061db039b413c03ccd33506175fe6ec
> >

