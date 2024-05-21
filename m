Return-Path: <stable+bounces-45507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B838CAEBD
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730082810F1
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9688C770F1;
	Tue, 21 May 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="L67jfMij"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315E770E2
	for <stable@vger.kernel.org>; Tue, 21 May 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296309; cv=none; b=F2yUc1OtGeSPnowQecryNZJ7hpNsSEVbl5xOrEps8popyoIw+YYyoEVQQ0iNUvzqIfihiGXmU6oRysi/uzVyZwjNWk14Zuto1tR/BGbH0d5tDYdiEPdPAfuaaj4BxHvdGFjnp6+6VP313J5nyvoOzv/o3q29ZH7oZm90npExy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296309; c=relaxed/simple;
	bh=wGkCVr/vTOvKJpwLYPD4pZTjMeDlZUjUE0DFrGFnH0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaXtU+kq8LojXhfluxhPjnPDa6Os/Vy2mBBJ5Yc4Mv5sMSfTC8b357W/LcBtl8STXGFtuBVj01f0vrd50l4vQ5l+87+xlXPHCEQ1iyZaUj39ENaDPvi7j1/fES+Y8ZQkrxBaoMcbbtDXVPGiYcSNiL6at6o2H7TnpR2DLP9xDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=L67jfMij; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f929b9f10so1060322e87.2
        for <stable@vger.kernel.org>; Tue, 21 May 2024 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1716296306; x=1716901106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xL4sO2Du5udtePocStbPxV+46lZn+8qWvHd7QbGr4NQ=;
        b=L67jfMij/0Dzzx2YCV0pLs0JKY8tYqM0sPcrvgzvrjpR9CpeMhe6Pu8fAcRWD6w+VW
         to0oZq5DjPMtHxPWFFh2Wn6sqhWgg+nthJoRTUqFGzq05grEQfxjl7LdSr5/06pOXIy+
         7d6lFZuHA/1xrYyOXv9oShehAgk1GfGpJHVjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716296306; x=1716901106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xL4sO2Du5udtePocStbPxV+46lZn+8qWvHd7QbGr4NQ=;
        b=utP0NbgRhyvWQvM4EP0bhVXlHaYPkvDv6FNwlwC3Oxg42gm6bgKeEdAH5Rzbakz4G4
         /c4xxePQ7JVHO4nLfLEaPXlUeq5E3FJOEWYQW0fMhFfqaxgZ33mvuBbziw7fNHyuiyvR
         N/XiPLPs9tIYd9n5KDS62O8nhLlLJTSaCrQ2UdC0zop8zyXmWMSJdL3Pd1U2Urc4A52H
         JHdsriHMOX1RlrdaYaF+si5oLD7K2X4XRs1SmxHmdo5r8OGw9JUWEBOIC+zv4o2ztqYU
         Aq1JF8ALf/yphY7Amm8BxO1x2RR1hCukHn7k2iOvoITkqrQs2etaYNqRepkBmBWtuO2Q
         lOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgBsmLrA/b62g4+31WrnO21dCVaHndXK2/Rf5BFAuXiDfqxII//ZqP7OqLbS+eu2D/OjMgpsPqgzjFQNVgcnabnFxR4BoQ
X-Gm-Message-State: AOJu0Yx9y9+MKiYCFU6w0nenrhPSW358b3rDsdw30HR/R9PUymL/HNIe
	W/iYhLpMAfyPr97TKnBeB7ldDiST5IL/qZuPm+oYjDcgkXXCodylKJ2aVv8IHpqM/WFSJXyegJz
	x0MqpdHuYaXp8MI2RcNIMKFEWa+XFtMqHoGZvdg==
X-Google-Smtp-Source: AGHT+IGWEfy2X6cC8DVw9rDd+ZVNbuUXVS091grZksXxwgGTDkygIdCxsI9rrnx/WN/BzZz1nXWZnrZNUrRsdtx3HvM=
X-Received: by 2002:a05:6512:3c9e:b0:51f:3bc2:1ed2 with SMTP id
 2adb3069b0e04-52210478710mr22489408e87.4.1716296305878; Tue, 21 May 2024
 05:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520100514.925681-1-jacek.lawrynowicz@linux.intel.com> <ZkyVyLVQn25taxCn@phenom.ffwll.local>
In-Reply-To: <ZkyVyLVQn25taxCn@phenom.ffwll.local>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 21 May 2024 14:58:12 +0200
Message-ID: <CAKMK7uFnOYJED0G2XJk4mf-dAD1VWrpVUvccFGz_g2sZSpTsVA@mail.gmail.com>
Subject: Re: [PATCH] drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, 
	"Wachowski, Karol" <karol.wachowski@intel.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, 
	Eric Anholt <eric@anholt.net>, Rob Herring <robh@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 21 May 2024 at 14:38, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, May 20, 2024 at 12:05:14PM +0200, Jacek Lawrynowicz wrote:
> > From: "Wachowski, Karol" <karol.wachowski@intel.com>
> >
> > Lack of check for copy-on-write (COW) mapping in drm_gem_shmem_mmap
> > allows users to call mmap with PROT_WRITE and MAP_PRIVATE flag
> > causing a kernel panic due to BUG_ON in vmf_insert_pfn_prot:
> > BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
> >
> > Return -EINVAL early if COW mapping is detected.
> >
> > This bug affects all drm drivers using default shmem helpers.
> > It can be reproduced by this simple example:
> > void *ptr =3D mmap(0, size, PROT_WRITE, MAP_PRIVATE, fd, mmap_offset);
> > ptr[0] =3D 0;
> >
> > Fixes: 2194a63a818d ("drm: Add library for shmem backed GEM objects")
> > Cc: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> > Cc: Eric Anholt <eric@anholt.net>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v5.2+
> > Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
> > Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>
> Excellent catch!
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> I reviewed the other helpers, and ttm/vram helpers already block this wit=
h
> the check in ttm_bo_mmap_obj.
>
> But the dma helpers does not, because the remap_pfn_range that underlies
> the various dma_mmap* function (at least on most platforms) allows some
> limited use of cow. But it makes no sense at all to all that only for
> gpu buffer objects backed by specific allocators.
>
> Would you be up for the 2nd patch that also adds this check to
> drm_gem_dma_mmap, so that we have a consistent uapi?
>
> I'll go ahead and apply this one to drm-misc-fixes meanwhile.

Forgot to add: A testcase in igt would also be really lovely.

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#validating-changes-w=
ith-igt
-Sima


>
> Thanks, Sima
>
> > ---
> >  drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/d=
rm_gem_shmem_helper.c
> > index 177773bcdbfd..885a62c2e1be 100644
> > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > @@ -611,6 +611,9 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object =
*shmem, struct vm_area_struct
> >               return ret;
> >       }
> >
> > +     if (is_cow_mapping(vma->vm_flags))
> > +             return -EINVAL;
> > +
> >       dma_resv_lock(shmem->base.resv, NULL);
> >       ret =3D drm_gem_shmem_get_pages(shmem);
> >       dma_resv_unlock(shmem->base.resv);
> > --
> > 2.45.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

