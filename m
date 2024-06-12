Return-Path: <stable+bounces-50336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E45905DCE
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 23:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309F71F21E7C
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 21:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA55084E0D;
	Wed, 12 Jun 2024 21:37:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F6537FF;
	Wed, 12 Jun 2024 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228249; cv=none; b=m7IfhjYx3diKSP6D12QuzhoOYrgzaIPfX9zYwMYd+IUdIV52Uy0YbjhWPBI4FreHa2SkRKjkvyqxAyyB8NGjTXBfCtCqbXbSu8ZBabqvB08WdBLz/HJLPs/+AUjAz/j/OKyTK4hKa7O6dGE0e6wFcrGbeujF+2EZlL2cHet4KKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228249; c=relaxed/simple;
	bh=bhKvs8D06n4pcQ7fNZQQ/3XqHs7BTL3nX8StQflzXlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvttL1mmZ1oh02fTcV1AR+8KwLuX7xImS8XQeKRGGwKn7aZa6lrmjiGM9Bx2mz3pGvXQ7sx/9On54/lS1teZloeVWECTpUycy+qnYR51MUZZtAN6LSLRbC/t/dM46wbKFUbVFaPyWuegSpjInebd82bbRC4NKU7hY0wVCifJbcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-80b8e5cab7bso89712241.0;
        Wed, 12 Jun 2024 14:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718228247; x=1718833047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGrQ4kC0usDlo6X7rb0FFn4z1I4iV8UOfsxmWyJU8T8=;
        b=mcNKucnkcDbEqf1tekqrC8BEPD2LISBWfDwrggWw/f2uypNjI/pRed07LZJj9zq5og
         R0S+OkOFzHn621lrX+N1gwR3VEsE7mdvk5HeDHwrFfrtF3U0rP2L3VdFD461dJNXtEXK
         BDnxaboc/cZ8UPeMZonbIyv3806v59lpmTvqKVShXISPzeHA9uUgTbL6F+EY28J6/g8v
         gEv1TN4rUV7FLvS3jfxmuZmZqr4HUaOVrBsjiVcerBHBdQOa3PTFG2hlhNynrnY21mP3
         ccR+xfC+O2YHrzRrrOiEakGxzrkpkPQAS1+VX3fh2XMMwCa/E/5jyYA35nWukYZtNYYu
         NDgA==
X-Forwarded-Encrypted: i=1; AJvYcCX98iYw5vSfSaSHKpN/0rFuQUIfJE21bDnYa4LGTvT/gw8S73Mq7aRoT4A1m9K9ytYa8n7exRxiKMlvRszgqxmnBYjLYbwoGIS/8W5oT+b163GiGxvpO/YexGaNzxjNA7njSILS
X-Gm-Message-State: AOJu0YzDGmz5VyggIUlj+nmac7X8DPe6aSarvghkGnESJTHMWroS4tt8
	sQP5paNGFfCIqGC4q2TCJ7fUwSz03CMp2NJyrbDmJfWThqWjqqBnikjU06oPUhGdhq0w7Hp8vy9
	ZTncByzpRN0+6ZkoiyQvhRkwPwSk=
X-Google-Smtp-Source: AGHT+IFxF8EN06J17xFY/m06JGL5/Bofq4OOHKPvS2e7I791mJG11bjTcP4Zr47YKFd5X7pKAZ20ZqNeu7FQRBIxKg8=
X-Received: by 2002:a05:6102:4646:b0:48c:454f:e7ea with SMTP id
 ada2fe7eead31-48d91e67d3cmr3414916137.29.1718228246725; Wed, 12 Jun 2024
 14:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612081216.1319089-1-zhai.he@nxp.com> <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
In-Reply-To: <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
From: Barry Song <baohua@kernel.org>
Date: Thu, 13 Jun 2024 09:37:15 +1200
Message-ID: <CAGsJ_4wsAh8C08PXutYZx9xV3rLRwLG-E6Mq-JgoSO5LA1ns=A@mail.gmail.com>
Subject: Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "zhai.he" <zhai.he@nxp.com>, sboyd@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, zhipeng.wang_1@nxp.com, 
	jindong.yue@nxp.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 6:47=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he" <zhai.he@nxp.com> wrote:
>
> > From: He Zhai <zhai.he@nxp.com>
>
> (cc Barry & Christoph)
>
> What was your reason for adding cc:stable to the email headers?  Does
> this address some serious problem?  If so, please fully describe that
> problem.
>
> > In the current code logic, if the device-specified CMA memory
> > allocation fails, memory will not be allocated from the default CMA are=
a.
> > This patch will use the default cma region when the device's
> > specified CMA is not enough.
> >
> > In addition, the log level of allocation failure is changed to debug.
> > Because these logs will be printed when memory allocation from the
> > device specified CMA fails, but if the allocation fails, it will be
> > allocated from the default cma area. It can easily mislead developers'
> > judgment.

I am not convinced that this patch is correct. If device-specific CMA
is too small,
why not increase it in the device tree? Conversely, if the default CMA
size is too
large, why not reduce it via the cmdline?  CMA offers all kinds of
flexible configuration
options based on users=E2=80=99 needs.

One significant benefit of device-specific CMA is that it helps
decrease fragmentation
in the common CMA pool. While many devices allocate memory from the same po=
ol,
they have different memory requirements in terms of sizes and
alignments. Occasions
of memory allocation and release can lead to situations where the CMA
pool has enough
free space, yet someone fails to obtain contiguous memory from it.

This patch entirely negates the advantage we gain from device-specific CMA.
My point is that instead of modifying the core code, please consider correc=
ting
your device tree or cmdline configurations.

> >
> > ...
> >
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -357,8 +357,13 @@ struct page *dma_alloc_contiguous(struct device *d=
ev, size_t size, gfp_t gfp)
> >       /* CMA can be used only in the context which permits sleeping */
> >       if (!gfpflags_allow_blocking(gfp))
> >               return NULL;
> > -     if (dev->cma_area)
> > -             return cma_alloc_aligned(dev->cma_area, size, gfp);
> > +     if (dev->cma_area) {
> > +             struct page *page =3D NULL;
> > +
> > +             page =3D cma_alloc_aligned(dev->cma_area, size, gfp);
> > +             if (page)
> > +                     return page;
> > +     }
> >       if (size <=3D PAGE_SIZE)
> >               return NULL;
>
> The dma_alloc_contiguous() kerneldoc should be updated for this.
>
> The patch prompts the question "why does the device-specified CMA area
> exist?".  Why not always allocate from the global pool?  If the
> device-specified area exists to prevent one device from going crazy and
> consuming too much contiguous memory, this patch violates that intent?
>
> > @@ -406,6 +411,8 @@ void dma_free_contiguous(struct device *dev, struct=
 page *page, size_t size)
> >       if (dev->cma_area) {
> >               if (cma_release(dev->cma_area, page, count))
> >                       return;
> > +             if (cma_release(dma_contiguous_default_area, page, count)=
)
> > +                     return;
> >       } else {
> >               /*
> >                * otherwise, page is from either per-numa cma or default=
 cma
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 3e9724716bad..6e12faf1bea7 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -495,8 +495,8 @@ struct page *cma_alloc(struct cma *cma, unsigned lo=
ng count,
> >       }
> >
> >       if (ret && !no_warn) {
> > -             pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu p=
ages, ret: %d\n",
> > -                                __func__, cma->name, count, ret);
> > +             pr_debug("%s: alloc failed, req-size: %lu pages, ret: %d,=
 try to use default cma\n",
> > +                         cma->name, count, ret);
> >               cma_debug_show_areas(cma);
> >       }
>

Thanks
Barry

