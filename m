Return-Path: <stable+bounces-132291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A800CA863DA
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 19:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1164A0013
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E23321D584;
	Fri, 11 Apr 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFz9AhNb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE381F3FED
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390763; cv=none; b=hwZgRxyt7Se7VnyJy+89En5IhNhlHHMpqKPysgOl6/fXyVlNv2cqwnpd/hSXlga15UqfLDQuNl30otduRWFvrs6lPG+pVUZDpp6jwNGRjrRRF5c8r2qEJnR1RGaJEHXtNRnT8ehcP0PXiFMVtzLSupL9AWQyZOHHLgz6HdlTUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390763; c=relaxed/simple;
	bh=7CHKsti2/PYbs9GG2ylP1IP5kzMjVZNIXW09K8zUSmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMYxByWHiqDtyHytgxRSnId09wfMWZg88JleBRVMGHHSG7zODTWvvIulnFeUnuFuMDYOyF1J9O7Mb94hHrf+rbXJcHLPrmNfNH204r19t2xLiwCuNJUw5jq6lL2FD+wvvS0IwTRI4M8IHNV0PJpvJZNDMi0+szF3XOTl1i4afeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WFz9AhNb; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4774611d40bso11091cf.0
        for <stable@vger.kernel.org>; Fri, 11 Apr 2025 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744390760; x=1744995560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JcWT8F950TD+QqQ0UqNeDHA12hwY89YTBPGXVQrv5I=;
        b=WFz9AhNbfYrj6nu+qML2Lt0OPEMJOTKflpB48cgxXYfIWWQ/EyPDlghxu1KcjfJlax
         7h6sXJl1LPODCpXcOSjv8HQTP1hoitu39zjeDc1kTajSwtq1Z2+pPAKyDkb9wte9lJu/
         nInjTe05l7NZfzlWg+yZ+7H5jm5kT46qVatF4O4lF1WJ3WX0oPDvEwajuqKPZj4NcS6v
         HAX7jKUfm7KXs+kK1vqI+AP4JYx5aQ3F4oEw8MrZJwry/wfnEwNSVsEElYVFw393ll/i
         /X9dHKQbbPMy2ic4kN2Y+GKtZtVPbZzpI8sGASMGy/o+keQnLdE4MDGyDjkQQtRf+caY
         UyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390760; x=1744995560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JcWT8F950TD+QqQ0UqNeDHA12hwY89YTBPGXVQrv5I=;
        b=iZSlGouXzwZ7dfnM/fGa/sXQwnGzr3mF9fSOu4CPrIh6XKV4pd9pdawECDl6CJDbAW
         29EWFaOkowN4t2mcRTAp+oS4J6pycjMNKLYB8OaCmEj9X6TjuOQIdGZOPhGdbOFZUXni
         fYYVr4HzUEt0CTUsaIJx/svKi0LXQV8BRFep4U6POaPAURLLedvDx+giceOV6v+u49/M
         yRR9i5d9v3TR+jpRes2KYGGy6yHL41wolJ/xHyrOFwB2ls/uCT2p/xpffgFofR4rg0sO
         +6xzYa+/vjdNc/mjRSWdn9s2Kk1Zqx23BckxgUZ8w/YgcYZNm5IRerpxSCcm1xHMaBQI
         yYSg==
X-Forwarded-Encrypted: i=1; AJvYcCU5DVQB7+oHW75kAvPQmW9bBDq21hYuQW0Gaen/vFj0fHnx2i/i/HozH2swg1aewUfYjULES80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9KLeiekqWvGAcy3GHx6FSIiEFG1r6ZIztZC+LEEPuHJ5pjbA
	J0V/84jJKlOz6HaN1WL9CNAesgw0/CwqgF970MHo9+2PAm+kIHK8mgdnmoRdDRYKCAVpTOFAJNJ
	rzfRuH4iFRqmjILbo7RKP3VuGGI4mIhASbIaS80TgWUASIQkEFWLo53s=
X-Gm-Gg: ASbGncvuHtFa6T0mVm+Pp7PM+toPbinfoFV6ueNjkLEowmfWCDpjfslZwJPakwN4Wx7
	fPO0I6psSHOlbxTz5pgrFx4NaFKvXgO5jOL1ZKtpFa0OKQrWy+2mHAAM+sPBuuHDL9LZS0lgCYm
	Y/Ztbrx2egrzLyAeKAi1Us
X-Google-Smtp-Source: AGHT+IFNCkECOF/4RUVrmmZrtr5X6NNOxIvUa6cUDsx7jrRz0J7jFjLKNPLhhm6DC1O9UvkHzLKWiZ/u3eEUA7iSzBA=
X-Received: by 2002:a05:622a:649:b0:472:915:a200 with SMTP id
 d75a77b69052e-479766a6b4cmr5960931cf.28.1744390760129; Fri, 11 Apr 2025
 09:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411155737.1360746-1-surenb@google.com> <c88ec69c-87ee-4865-8b2a-87f32f46b0bc@suse.cz>
In-Reply-To: <c88ec69c-87ee-4865-8b2a-87f32f46b0bc@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Apr 2025 09:59:08 -0700
X-Gm-Features: ATxdqUETX9K1wffK9PtEH3J3qFn8MD3LfPBIvEHH6O6tBTLAX7jyrRgfnIPMYHY
Message-ID: <CAJuCfpE6_Hb40kyM7E4ESw8-_ptm3SARuL0q_YBB49cqkVbPig@mail.gmail.com>
Subject: Re: [PATCH 1/1] slab: ensure slab->obj_exts is clear in a newly
 allocated slab page
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	roman.gushchin@linux.dev, cl@linux.com, rientjes@google.com, 
	harry.yoo@oracle.com, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 9:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 4/11/25 17:57, Suren Baghdasaryan wrote:
> > ktest recently reported crashes while running several buffered io tests
> > with __alloc_tagging_slab_alloc_hook() at the top of the crash call sta=
ck.
> > The signature indicates an invalid address dereference with low bits of
> > slab->obj_exts being set. The bits were outside of the range used by
> > page_memcg_data_flags and objext_flags and hence were not masked out
> > by slab_obj_exts() when obtaining the pointer stored in slab->obj_exts.
> > The typical crash log looks like this:
> >
> > 00510 Unable to handle kernel NULL pointer dereference at virtual addre=
ss 0000000000000010
> > 00510 Mem abort info:
> > 00510   ESR =3D 0x0000000096000045
> > 00510   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > 00510   SET =3D 0, FnV =3D 0
> > 00510   EA =3D 0, S1PTW =3D 0
> > 00510   FSC =3D 0x05: level 1 translation fault
> > 00510 Data abort info:
> > 00510   ISV =3D 0, ISS =3D 0x00000045, ISS2 =3D 0x00000000
> > 00510   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
> > 00510   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > 00510 user pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000104175000
> > 00510 [0000000000000010] pgd=3D0000000000000000, p4d=3D0000000000000000=
, pud=3D0000000000000000
> > 00510 Internal error: Oops: 0000000096000045 [#1]  SMP
> > 00510 Modules linked in:
> > 00510 CPU: 10 UID: 0 PID: 7692 Comm: cat Not tainted 6.15.0-rc1-ktest-g=
189e17946605 #19327 NONE
> > 00510 Hardware name: linux,dummy-virt (DT)
> > 00510 pstate: 20001005 (nzCv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=3D--)
> > 00510 pc : __alloc_tagging_slab_alloc_hook+0xe0/0x190
> > 00510 lr : __kmalloc_noprof+0x150/0x310
> > 00510 sp : ffffff80c87df6c0
> > 00510 x29: ffffff80c87df6c0 x28: 000000000013d1ff x27: 000000000013d200
> > 00510 x26: ffffff80c87df9e0 x25: 0000000000000000 x24: 0000000000000001
> > 00510 x23: ffffffc08041953c x22: 000000000000004c x21: ffffff80c0002180
> > 00510 x20: fffffffec3120840 x19: ffffff80c4821000 x18: 0000000000000000
> > 00510 x17: fffffffec3d02f00 x16: fffffffec3d02e00 x15: fffffffec3d00700
> > 00510 x14: fffffffec3d00600 x13: 0000000000000200 x12: 0000000000000006
> > 00510 x11: ffffffc080bb86c0 x10: 0000000000000000 x9 : ffffffc080201e58
> > 00510 x8 : ffffff80c4821060 x7 : 0000000000000000 x6 : 0000000055555556
> > 00510 x5 : 0000000000000001 x4 : 0000000000000010 x3 : 0000000000000060
> > 00510 x2 : 0000000000000000 x1 : ffffffc080f50cf8 x0 : ffffff80d801d000
> > 00510 Call trace:
> > 00510  __alloc_tagging_slab_alloc_hook+0xe0/0x190 (P)
> > 00510  __kmalloc_noprof+0x150/0x310
> > 00510  __bch2_folio_create+0x5c/0xf8
> > 00510  bch2_folio_create+0x2c/0x40
> > 00510  bch2_readahead+0xc0/0x460
> > 00510  read_pages+0x7c/0x230
> > 00510  page_cache_ra_order+0x244/0x3a8
> > 00510  page_cache_async_ra+0x124/0x170
> > 00510  filemap_readahead.isra.0+0x58/0xa0
> > 00510  filemap_get_pages+0x454/0x7b0
> > 00510  filemap_read+0xdc/0x418
> > 00510  bch2_read_iter+0x100/0x1b0
> > 00510  vfs_read+0x214/0x300
> > 00510  ksys_read+0x6c/0x108
> > 00510  __arm64_sys_read+0x20/0x30
> > 00510  invoke_syscall.constprop.0+0x54/0xe8
> > 00510  do_el0_svc+0x44/0xc8
> > 00510  el0_svc+0x18/0x58
> > 00510  el0t_64_sync_handler+0x104/0x130
> > 00510  el0t_64_sync+0x154/0x158
> > 00510 Code: d5384100 f9401c01 b9401aa3 b40002e1 (f8227881)
> > 00510 ---[ end trace 0000000000000000 ]---
> > 00510 Kernel panic - not syncing: Oops: Fatal exception
> > 00510 SMP: stopping secondary CPUs
> > 00510 Kernel Offset: disabled
> > 00510 CPU features: 0x0000,000000e0,00000410,8240500b
> > 00510 Memory Limit: none
> >
> > Investigation indicates that these bits are already set when we allocat=
e
> > slab page and are not zeroed out after allocation. We are not yet sure
> > why these crashes start happening only recently but regardless of the
> > reason, not initializing a field that gets used later is wrong. Fix it
> > by initializing slab->obj_exts during slab page allocation.
>
> slab->obj_exts overlays page->memcg_data and the checks on page alloc and
> page free should catch any non-zero values, i.e. page_expected_state()
> page_bad_reason() so if anyone is e.g. UAF-writing there or leaving garba=
ge
> there while freeing the page it's a bug.
>
> Perhaps CONFIG_MEMCG is disabled in the ktests and thus the checks are no=
t
> happening? We could extend them for CONFIG_SLAB_OBJ_EXT checking
> _unused_slab_obj_exts perhaps. But it would be a short lived change, see =
below.

Correct, CONFIG_MEMCG was disabled during these tests. We added
BUG_ON() in the slab allocation path to trigger on these low bits and
it did trigger but the same assertion in the freeing path did not
catch anything. We suspected 4996fc547f5b ("mm: let _folio_nr_pages
overlay memcg_data in first tail page") to cause this but Kent's
bisection did not confirm that.

>
> > Fixes: 21c690a349ba ("mm: introduce slabobj_ext to support slab object =
extensions")
> > Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Tested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: <stable@vger.kernel.org>
>
> We'll need this anyway for the not so far future when struct slab is
> separated from struct page so it's fine but it would still be great to fi=
nd
> the underlying buggy code which this is going to hide.

Yeah, we will try to find the culprit. For now to prevent others from
stepping on this mine I would like to get this in. Thanks!

>
> > ---
> >  mm/slub.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index b46f87662e71..dc9e729e1d26 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1973,6 +1973,11 @@ static inline void handle_failed_objexts_alloc(u=
nsigned long obj_exts,
> >  #define OBJCGS_CLEAR_MASK    (__GFP_DMA | __GFP_RECLAIMABLE | \
> >                               __GFP_ACCOUNT | __GFP_NOFAIL)
> >
> > +static inline void init_slab_obj_exts(struct slab *slab)
> > +{
> > +     slab->obj_exts =3D 0;
> > +}
> > +
> >  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >                       gfp_t gfp, bool new_slab)
> >  {
> > @@ -2058,6 +2063,10 @@ static inline bool need_slab_obj_ext(void)
> >
> >  #else /* CONFIG_SLAB_OBJ_EXT */
> >
> > +static inline void init_slab_obj_exts(struct slab *slab)
> > +{
> > +}
> > +
> >  static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s=
,
> >                              gfp_t gfp, bool new_slab)
> >  {
> > @@ -2637,6 +2646,7 @@ static struct slab *allocate_slab(struct kmem_cac=
he *s, gfp_t flags, int node)
> >       slab->objects =3D oo_objects(oo);
> >       slab->inuse =3D 0;
> >       slab->frozen =3D 0;
> > +     init_slab_obj_exts(slab);
> >
> >       account_slab(slab, oo_order(oo), s, flags);
> >
> >
> > base-commit: c496b37f9061db039b413c03ccd33506175fe6ec
>

