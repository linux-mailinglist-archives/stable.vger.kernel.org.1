Return-Path: <stable+bounces-110907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C598A1DD5F
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 21:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88E43A4517
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE3A1953A2;
	Mon, 27 Jan 2025 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ycOFINsD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28275192D76
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738009723; cv=none; b=QYySRQZhcNFuOmscIpURbQQV7G6kxiAEt2MKpqACisRkbdDYIAp56iNHeEFKjvpurKm7896th8Ve8/j8h0ePgm8Eya1h355BhiRW5eb9iwCNy2MAeiW+jKCwJ8JB7d7i7Nbpoy2KXTueKvyrleUSCPnlWpXcs4DlZ1+fHOQFzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738009723; c=relaxed/simple;
	bh=AborfojXMkdHVeC0CZdpOrZCkrl0lTa6QbwNmdY9ui0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poYat1FjB1H/1fjhJlsLYP+qrLNFnUHQBmWaH7TCOfYFvToWWl3AoV7WtVkj+60Yre6voz8e/bNcdQolyjuZwgAXijjzWSQCLnI/RKpqIuoucbsxc73qR5MAYBAjGb9zPFXGvjDrllFhtj3gZk+EZ67jUPu75mCeiZu/RgCrVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ycOFINsD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-219f6ca9a81so665ad.1
        for <stable@vger.kernel.org>; Mon, 27 Jan 2025 12:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738009720; x=1738614520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5OAdXw40aZ4dT7REZL8UkCNLdOIipIEDQD+Nm1Wqv8=;
        b=ycOFINsDBxbSVEIdJZ+EZLjg1N3YqY9Bp2egupmV0KveV3+8QRgDuCSTTwS1qtGpFD
         4rERsWzClToUO2zj1GfqF/9unxSSeSEkTHVdEJeuJrHSAETZEioAkWWJaKJCwjwwe1+O
         hPkTUrUQofeu2X0WhFO7lrBBD2K6NEXOfMytykFB6Xyh7AzVZRtCvvq4hoFEe9QAfnX0
         Hyl+MI3n05omkow0SgiXUdUMXXZE3VObAhRTYE/YPIhoPJUQVAx+YpYaS2LOq9JcSdM2
         p7IG6PxxLuqKRKdvgzXTCnlnzctgqRiUS/geX522LUG0YXekjhHv+gXIR+qmceNCWXTA
         wL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738009720; x=1738614520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5OAdXw40aZ4dT7REZL8UkCNLdOIipIEDQD+Nm1Wqv8=;
        b=STX0ByNLqkTMatuU5p2GnT1/OO6z2B//tLPAnDuFW9FbcILuVwOaHpO2DlqlMxR9RM
         O5bx06cLONVdS0qdaExifCJDLzT2A1PM5I4rF2xDNG+3LEwZij90v5JFlFBUMY5U6Z+U
         SjkaB9H26aOGTJg/Kmn2t5vKFkra+tu4bg/MW0s8iMN5QPxGfvXfThVMWcmjHGSjvLwO
         bEYp26Q5flkTIyQGm7mcajSwUt45ZIoeBTNKm3eqRGGL5J7GSzhNHbCG2/dekPpuvqBo
         M+eQ58cop7tleIMtZ4KGTzyo7JvbUrJVV0A7Pm1DubyB3BAxF4xjzzGd3dUFfhATo4pf
         38NA==
X-Forwarded-Encrypted: i=1; AJvYcCW9VUNRdjaFrYniaNwiYMah5r3Zqmykpum+ceaRrjkqBbfjmH6vgrOEiA/1yxA6VT/pFaLGMnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRvbbmMpiVBsgi9Px1tSKNQGPWLMblDuba2xyBON2OuDHZEu8
	KECn0ez6RInxW0h5fdHdKQAIeHKZOrR24H0vX8AT5TG5q+TG3JotK5zZJjP87wsQBW1dKn2mdP6
	PWCnbhVFuv/PgDiqp9/yzodCYlko6st0vVaMfiH8mnXIHq7UT5A==
X-Gm-Gg: ASbGncsHDQGXntOEUBXGPICVUkHSVmmPCNNLQbcLBY+2z2NBGR9cK1JZ3Sav2qQPBDv
	q0MwibNxj7AdBSqaBRe3xiFMpCN5WUJXtp60kU2qMgBjS5mgD4aDcFZgGd4kG
X-Google-Smtp-Source: AGHT+IHQQWlj9A5Y+oU1MNKOjRz24HDoHDlGL9yFwzCrpFh7hRMi1+6J5hAZDLP/0s8perABjyvTuA6qZzS+Lt5CfPM=
X-Received: by 2002:a17:902:d54d:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-21dcce27897mr433355ad.10.1738009719528; Mon, 27 Jan 2025
 12:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116155340.533180-1-bgeffon@google.com> <Z5fUu6XwUrZESb5H@intel.com>
In-Reply-To: <Z5fUu6XwUrZESb5H@intel.com>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 27 Jan 2025 15:28:03 -0500
X-Gm-Features: AWEUYZmrdWBrpeOq77qUt8ll3RhZFOiic5MYZqwb2Iuf8OL_KV5fC51sJr6Th5M
Message-ID: <CADyq12weg0ydT90Nc62AYE6w45oY4onU19C2MWU6nT6SWr7PSA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: Fix page cleanup on DMA remap failure
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, chris.p.wilson@intel.com, 
	jani.saarinen@intel.com, tomasz.mistat@intel.com, vidya.srinivas@intel.com, 
	jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, stable@vger.kernel.org, 
	Tomasz Figa <tfiga@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 1:47=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Thu, Jan 16, 2025 at 10:53:40AM -0500, Brian Geffon wrote:
> > When converting to folios the cleanup path of shmem_get_pages() was
> > missed. When a DMA remap fails and the max segment size is greater than
> > PAGE_SIZE it will attempt to retry the remap with a PAGE_SIZEd segment
> > size. The cleanup code isn't properly using the folio apis and as a
> > result isn't handling compound pages correctly.
> >
> > v1 -> v2:
> >   (Ville) Fixed locations where we were not clearing mapping unevictabl=
e.
> >
> > Cc: stable@vger.kernel.org
> > Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> > Cc: Vidya Srinivas <vidya.srinivas@intel.com>
> > Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13487
> > Link: https://lore.kernel.org/lkml/20250116135636.410164-1-bgeffon@goog=
le.com/
> > Fixes: 0b62af28f249 ("i915: convert shmem_sg_free_table() to use a foli=
o_batch")
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > Suggested-by: Tomasz Figa <tfiga@google.com>
> > ---
> >  drivers/gpu/drm/i915/gem/i915_gem_object.h |  3 +--
> >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c  | 23 +++++++++-------------
> >  drivers/gpu/drm/i915/gem/i915_gem_ttm.c    |  7 ++++---
> >  3 files changed, 14 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/d=
rm/i915/gem/i915_gem_object.h
> > index 3dc61cbd2e11..0f122a12d4a5 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> > @@ -843,8 +843,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
> >                        size_t size, struct intel_memory_region *mr,
> >                        struct address_space *mapping,
> >                        unsigned int max_segment);
> > -void shmem_sg_free_table(struct sg_table *st, struct address_space *ma=
pping,
> > -                      bool dirty, bool backup);
> > +void shmem_sg_free_table(struct sg_table *st, bool dirty, bool backup)=
;
> >  void __shmem_writeback(size_t size, struct address_space *mapping);
> >
> >  #ifdef CONFIG_MMU_NOTIFIER
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/dr=
m/i915/gem/i915_gem_shmem.c
> > index fe69f2c8527d..b320d9dfd6d3 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > @@ -29,16 +29,13 @@ static void check_release_folio_batch(struct folio_=
batch *fbatch)
> >       cond_resched();
> >  }
> >
> > -void shmem_sg_free_table(struct sg_table *st, struct address_space *ma=
pping,
> > -                      bool dirty, bool backup)
> > +void shmem_sg_free_table(struct sg_table *st, bool dirty, bool backup)
>
> This still makes the alloc vs. free completely asymmetric.
> This is not what we want because it just makes it very easy
> to make it mistake in the caller.
>
> I think the correct fix is to simply call the current
> shmem_sg_free_table() from the now broken failure path.
> mapping_{set,clear}_unevictable() just seems to be some
> bit operation so AFAICS the slight ping-pong should be
> inconsequential.

Ok, I guess that's true, it'll be set unevictable again in the call to
shmem_sg_alloc_table() after it jumps back to rebuild_st. I'll send a
v3 which should then become a 1 line change.

>
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
> >               struct folio *folio =3D page_folio(page);
> > @@ -180,10 +177,10 @@ int shmem_sg_alloc_table(struct drm_i915_private =
*i915, struct sg_table *st,
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
> > @@ -209,8 +206,6 @@ static int shmem_get_pages(struct drm_i915_gem_obje=
ct *obj)
> >       struct address_space *mapping =3D obj->base.filp->f_mapping;
> >       unsigned int max_segment =3D i915_sg_segment_size(i915->drm.dev);
> >       struct sg_table *st;
> > -     struct sgt_iter sgt_iter;
> > -     struct page *page;
> >       int ret;
> >
> >       /*
> > @@ -239,9 +234,8 @@ static int shmem_get_pages(struct drm_i915_gem_obje=
ct *obj)
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
> > @@ -265,7 +259,8 @@ static int shmem_get_pages(struct drm_i915_gem_obje=
ct *obj)
> >       return 0;
> >
> >  err_pages:
> > -     shmem_sg_free_table(st, mapping, false, false);
> > +     mapping_clear_unevictable(mapping);
> > +     shmem_sg_free_table(st, false, false);
> >       /*
> >        * shmemfs first checks if there is enough memory to allocate the=
 page
> >        * and reports ENOSPC should there be insufficient, along with th=
e usual
> > @@ -402,8 +397,8 @@ void i915_gem_object_put_pages_shmem(struct drm_i91=
5_gem_object *obj, struct sg_
> >       if (i915_gem_object_needs_bit17_swizzle(obj))
> >               i915_gem_object_save_bit_17_swizzle(obj, pages);
> >
> > -     shmem_sg_free_table(pages, file_inode(obj->base.filp)->i_mapping,
> > -                         obj->mm.dirty, obj->mm.madv =3D=3D I915_MADV_=
WILLNEED);
> > +     mapping_clear_unevictable(file_inode(obj->base.filp)->i_mapping);
> > +     shmem_sg_free_table(pages, obj->mm.dirty, obj->mm.madv =3D=3D I91=
5_MADV_WILLNEED);
> >       kfree(pages);
> >       obj->mm.dirty =3D false;
> >  }
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/=
i915/gem/i915_gem_ttm.c
> > index 10d8673641f7..37f51a04b838 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > @@ -232,7 +232,8 @@ static int i915_ttm_tt_shmem_populate(struct ttm_de=
vice *bdev,
> >       return 0;
> >
> >  err_free_st:
> > -     shmem_sg_free_table(st, filp->f_mapping, false, false);
> > +     mapping_clear_unevictable(filp->f_mapping);
> > +     shmem_sg_free_table(st, false, false);
> >
> >       return err;
> >  }
> > @@ -243,8 +244,8 @@ static void i915_ttm_tt_shmem_unpopulate(struct ttm=
_tt *ttm)
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
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

Thanks,
Brian

