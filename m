Return-Path: <stable+bounces-110387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1790A1B93A
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 16:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8A17A5FC5
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B586E16EC19;
	Fri, 24 Jan 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJ6Nl9fu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9D136E09
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737732027; cv=none; b=AbQJlUoVi+zk4l4Y7dGrNH1TFh0weGFlJlvs313JH8gDKkucgX1yybN7z/hIcamH88SVab64yYz5jSN5kBQa0P3oPgqljbWHRyhLDNtz5qDJxFVW75bsY62YTlvDCKmUDQKm7SEchfjck7QA7+pSfHp2UZSKVPn+oF3rORRq6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737732027; c=relaxed/simple;
	bh=1LgISIknWMWWSc5+NNGftAGETQJS0Apc+dbSz86FMwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq85WvfJ/SqCmaQnVry6THw4xBZmxbNhIk9+WUoFWvlRQIeVKN3vGUqNgHTvmOuukoC3RkKb0ytKZdmivhAxt/3+JimT337PdxaGIpFz+QJAlCh/rlB+uvcBajtWZuvoZ5qWYDkZpxVKb82Ce2FWlcMWUr1RlIKbNnTtNVPHhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJ6Nl9fu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f6ca9a81so103535ad.1
        for <stable@vger.kernel.org>; Fri, 24 Jan 2025 07:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737732025; x=1738336825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYPf2LUjlgrOWAVceU7WuHio67CjjBc5MKyrd+YyW78=;
        b=AJ6Nl9fuxuLLOyKXyD7T46coGiQ3OvccjOnHzvT5Mwyq2SpwZ3G3yaAmvMCRGK/A4U
         1rcicqGNFgkerEpD7nmV9exM4F6CI41GtuvmOW4zCPEJVoeGDe+kh15Hhwap7JSuRxfy
         BptWtDYIDnBrxCovmibmy9lsR3Tia5IeKdKeT14N5UQMnrCi46TgtKkHR+4zLA7CEVbK
         oqKzahtcIc6MJr48N3/TJ1Imy69WyyiUWP3BUCVfs3Y5bn3Xjb8uv0fpCCBXiwtFKT0i
         wjNrRxwEGI71Nd4BGgM5FlYXD8pMAcXVSB07oCookSIXr9EeydNFnJIejFA5sB3gpuxH
         I6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737732025; x=1738336825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYPf2LUjlgrOWAVceU7WuHio67CjjBc5MKyrd+YyW78=;
        b=bTn+m+SbzCJ+Ba+iZtbqML5fz1XiWsls4VdhUIobDc5ixft8I6D1nNvIgmxfQD0fPA
         DoWh3+B/ardZeoeXVIVgzvl6LvXRQU/J6WVtGRc/joM5IgB/LKLjNMnL/7ag8+rj1LEI
         Q2CmxPnij8I8CmI+o24gFQP7QeCUKE/19h1tsecj57cLLn87iTq1m3Bx/TPJICideXgm
         THe2yyp/CRgBxmaS7XIP3blRgT3jSGq86vVpqH9W2qb8Ae4AQG8fA7SFtcIncnxmH5e8
         gIP2yHpJI1GWVX8s766BFxNjdE5y4YD6HBZvBJj7pF61w6EbY2m0mVIOPxByXiAtTZ7j
         oGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7rkLlIXCzvgMk5LBx6WfLL3Zsz9XLCG8PxSFGyU18S7w3LV79nIUKqZbQ55Snz2A/qXx0+JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwejRaLUEgZhnCQxhA00uon6mHhydQkTzwuiO6c23njsjYPNNom
	5A9ZB0X3c+c5fImn8q6SRiPgA7o22c19Sg8urXtO2PQkZDAqujYhkni6EGhJI8dW4NZpppqAKc2
	pnH51nhothwdzH0GSUPWNcWWFjL1gWcHe6BgR
X-Gm-Gg: ASbGncsX+d3fuN0juKe+OLGiN4l4hDwAT5kEanI4Ht3QH7URZT8hMu4NbQCB9+TAVEM
	dQctQ3QFSEKYMAeih9MfwgRQyMstowEM9tmGiG58AlOED0gF86xyZvC5vrZik
X-Google-Smtp-Source: AGHT+IG9ohQRM9HL76Qi+3nwEdd3Es5b/Nm30tErg2OwJ7Xs9TmLtXt37CZs7X0OMbTwlvFUfx+bMx0Iwf++I1DvJmw=
X-Received: by 2002:a17:903:320a:b0:20b:5e34:1850 with SMTP id
 d9443c01a7336-21d9ad2f38amr5652575ad.23.1737732023343; Fri, 24 Jan 2025
 07:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116155340.533180-1-bgeffon@google.com> <PH7PR11MB8252B7BF1D1B6ADE94839F8F89E02@PH7PR11MB8252.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB8252B7BF1D1B6ADE94839F8F89E02@PH7PR11MB8252.namprd11.prod.outlook.com>
From: Brian Geffon <bgeffon@google.com>
Date: Fri, 24 Jan 2025 10:19:47 -0500
X-Gm-Features: AWEUYZl6QulbUxISxp6-vL7i1ZnPpkKwqUg007rJfLqh0Cih4D1oUBq_JzuWIIw
Message-ID: <CADyq12xLorH1kzH6ezp2Z_SYv-AVbrp+h98FeYP+hbt2R1_1Nw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: Fix page cleanup on DMA remap failure
To: "Srinivas, Vidya" <vidya.srinivas@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"Wilson, Chris P" <chris.p.wilson@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
	"Mistat, Tomasz" <tomasz.mistat@intel.com>, 
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, 
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Tomasz Figa <tfiga@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 10:07=E2=80=AFPM Srinivas, Vidya
<vidya.srinivas@intel.com> wrote:
>
> Hello Brian, Many thanks for the fix. I am adding my tested-by.
> Tested-by: Vidya Srinivas <vidya.srinivas@intel.com>

Thanks for testing Vidya.

Can we get a maintainer to take a look?

>
>
> > -----Original Message-----
> > From: Brian Geffon <bgeffon@google.com>
> > Sent: 16 January 2025 21:24
> > To: intel-gfx@lists.freedesktop.org
> > Cc: Wilson, Chris P <chris.p.wilson@intel.com>; Saarinen, Jani
> > <jani.saarinen@intel.com>; Mistat, Tomasz <tomasz.mistat@intel.com>;
> > Srinivas, Vidya <vidya.srinivas@intel.com>; ville.syrjala@linux.intel.c=
om;
> > jani.nikula@linux.intel.com; linux-kernel@vger.kernel.org; dri-
> > devel@lists.freedesktop.org; Joonas Lahtinen
> > <joonas.lahtinen@linux.intel.com>; Brian Geffon <bgeffon@google.com>;
> > stable@vger.kernel.org; Tomasz Figa <tfiga@google.com>
> > Subject: [PATCH v2] drm/i915: Fix page cleanup on DMA remap failure
> >
> > When converting to folios the cleanup path of shmem_get_pages() was
> > missed. When a DMA remap fails and the max segment size is greater than
> > PAGE_SIZE it will attempt to retry the remap with a PAGE_SIZEd segment =
size.
> > The cleanup code isn't properly using the folio apis and as a result is=
n't
> > handling compound pages correctly.
> >
> > v1 -> v2:
> >   (Ville) Fixed locations where we were not clearing mapping unevictabl=
e.
> >
> > Cc: stable@vger.kernel.org
> > Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> > Cc: Vidya Srinivas <vidya.srinivas@intel.com>
> > Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13487
> > Link: https://lore.kernel.org/lkml/20250116135636.410164-1-
> > bgeffon@google.com/
> > Fixes: 0b62af28f249 ("i915: convert shmem_sg_free_table() to use a
> > folio_batch")
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > Suggested-by: Tomasz Figa <tfiga@google.com>
> > ---
> >  drivers/gpu/drm/i915/gem/i915_gem_object.h |  3 +--
> > drivers/gpu/drm/i915/gem/i915_gem_shmem.c  | 23 +++++++++-------------
> >  drivers/gpu/drm/i915/gem/i915_gem_ttm.c    |  7 ++++---
> >  3 files changed, 14 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h
> > b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> > index 3dc61cbd2e11..0f122a12d4a5 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> > @@ -843,8 +843,7 @@ int shmem_sg_alloc_table(struct drm_i915_private
> > *i915, struct sg_table *st,
> >                        size_t size, struct intel_memory_region *mr,
> >                        struct address_space *mapping,
> >                        unsigned int max_segment);
> > -void shmem_sg_free_table(struct sg_table *st, struct address_space
> > *mapping,
> > -                      bool dirty, bool backup);
> > +void shmem_sg_free_table(struct sg_table *st, bool dirty, bool backup)=
;
> >  void __shmem_writeback(size_t size, struct address_space *mapping);
> >
> >  #ifdef CONFIG_MMU_NOTIFIER
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > index fe69f2c8527d..b320d9dfd6d3 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > @@ -29,16 +29,13 @@ static void check_release_folio_batch(struct
> > folio_batch *fbatch)
> >       cond_resched();
> >  }
> >
> > -void shmem_sg_free_table(struct sg_table *st, struct address_space
> > *mapping,
> > -                      bool dirty, bool backup)
> > +void shmem_sg_free_table(struct sg_table *st, bool dirty, bool backup)
> >  {
> >       struct sgt_iter sgt_iter;
> >       struct folio_batch fbatch;
> >       struct folio *last =3D NULL;
> >       struct page *page;
> >
> > -     mapping_clear_unevictable(mapping);
> > -
> >       folio_batch_init(&fbatch);
> >       for_each_sgt_page(page, sgt_iter, st) {
> >               struct folio *folio =3D page_folio(page); @@ -180,10 +177=
,10
> > @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_ta=
ble
> > *st,
> >       return 0;
> >  err_sg:
> >       sg_mark_end(sg);
> > +     mapping_clear_unevictable(mapping);
> >       if (sg !=3D st->sgl) {
> > -             shmem_sg_free_table(st, mapping, false, false);
> > +             shmem_sg_free_table(st, false, false);
> >       } else {
> > -             mapping_clear_unevictable(mapping);
> >               sg_free_table(st);
> >       }
> >
> > @@ -209,8 +206,6 @@ static int shmem_get_pages(struct
> > drm_i915_gem_object *obj)
> >       struct address_space *mapping =3D obj->base.filp->f_mapping;
> >       unsigned int max_segment =3D i915_sg_segment_size(i915->drm.dev);
> >       struct sg_table *st;
> > -     struct sgt_iter sgt_iter;
> > -     struct page *page;
> >       int ret;
> >
> >       /*
> > @@ -239,9 +234,8 @@ static int shmem_get_pages(struct
> > drm_i915_gem_object *obj)
> >                * for PAGE_SIZE chunks instead may be helpful.
> >                */
> >               if (max_segment > PAGE_SIZE) {
> > -                     for_each_sgt_page(page, sgt_iter, st)
> > -                             put_page(page);
> > -                     sg_free_table(st);
> > +                     /* Leave the mapping unevictable while we retry *=
/
> > +                     shmem_sg_free_table(st, false, false);
> >                       kfree(st);
> >
> >                       max_segment =3D PAGE_SIZE;
> > @@ -265,7 +259,8 @@ static int shmem_get_pages(struct
> > drm_i915_gem_object *obj)
> >       return 0;
> >
> >  err_pages:
> > -     shmem_sg_free_table(st, mapping, false, false);
> > +     mapping_clear_unevictable(mapping);
> > +     shmem_sg_free_table(st, false, false);
> >       /*
> >        * shmemfs first checks if there is enough memory to allocate the
> > page
> >        * and reports ENOSPC should there be insufficient, along with th=
e
> > usual @@ -402,8 +397,8 @@ void
> > i915_gem_object_put_pages_shmem(struct drm_i915_gem_object *obj,
> > struct sg_
> >       if (i915_gem_object_needs_bit17_swizzle(obj))
> >               i915_gem_object_save_bit_17_swizzle(obj, pages);
> >
> > -     shmem_sg_free_table(pages, file_inode(obj->base.filp)->i_mapping,
> > -                         obj->mm.dirty, obj->mm.madv =3D=3D
> > I915_MADV_WILLNEED);
> > +     mapping_clear_unevictable(file_inode(obj->base.filp)->i_mapping);
> > +     shmem_sg_free_table(pages, obj->mm.dirty, obj->mm.madv =3D=3D
> > +I915_MADV_WILLNEED);
> >       kfree(pages);
> >       obj->mm.dirty =3D false;
> >  }
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > index 10d8673641f7..37f51a04b838 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > @@ -232,7 +232,8 @@ static int i915_ttm_tt_shmem_populate(struct
> > ttm_device *bdev,
> >       return 0;
> >
> >  err_free_st:
> > -     shmem_sg_free_table(st, filp->f_mapping, false, false);
> > +     mapping_clear_unevictable(filp->f_mapping);
> > +     shmem_sg_free_table(st, false, false);
> >
> >       return err;
> >  }
> > @@ -243,8 +244,8 @@ static void i915_ttm_tt_shmem_unpopulate(struct
> > ttm_tt *ttm)
> >       bool backup =3D ttm->page_flags & TTM_TT_FLAG_SWAPPED;
> >       struct sg_table *st =3D &i915_tt->cached_rsgt.table;
> >
> > -     shmem_sg_free_table(st, file_inode(i915_tt->filp)->i_mapping,
> > -                         backup, backup);
> > +     mapping_clear_unevictable(file_inode(i915_tt->filp)->i_mapping);
> > +     shmem_sg_free_table(st, backup, backup);
> >  }
> >
> >  static void i915_ttm_tt_release(struct kref *ref)
> > --
> > 2.48.0.rc2.279.g1de40edade-goog
>

Thanks
Brian

