Return-Path: <stable+bounces-128572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83611A7E3C0
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 17:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23B1189C049
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1301FBCA7;
	Mon,  7 Apr 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Rzuixa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE411FBCB6
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038322; cv=none; b=gnHaA6opk9LXQTqlSM1bP9TOrwlWfL5li2gzAGNdKWuHV0WLiEbR40OteA7ZRtUaNHztQzg0HFKvE3EGor/8hm2/7q3hx6zLWgTuyTD63gkLCNR5IWDJ8PO9pKcXVnNay4GPTTXCynt/oJllxqyGQYlWDpNtUgMkCaH35YNeXcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038322; c=relaxed/simple;
	bh=i9n0P/HwDFlqdPu7BAMwDAnf/+qX5b2uHGVldRouw14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXwA2vLCmt96ngG7oW5DC3VX4l/q+7eRhxaijnmcZTkYVUeDhyLcegIF6a9OkVqvi68eDRSkkTGViE33Kfkjt/P2FpJE//KtRl8ZSxG/0+18aAu2JSPB8wdQzBHpUwLiwtLivhi+anMRwZfgAKaiqFKf4K5B+4b1kPysxcsJGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/Rzuixa; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3032a9c7cfeso924675a91.1
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744038320; x=1744643120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssQkPgtWHpg5qaEQQQk7L7Pz6LQv2SK5PMPPrhZLDD0=;
        b=K/RzuixaLLlclyUsJnnnylvBcHqGBsECWUYz7qR+yKsfJCZFm27bkqQZbWD9TXSC+i
         jrpW1FQrDLp7y3DhURS3PU51xZ2b40bSqcljH2FzGTEuf8rhE6jUdanKllwYbEYDLyQg
         te6p02byqJb2wGlxw6TFgHACrVyKbKCFjsnUAl7evzXSv8rJec0XJYHzdcfGslA8ENJg
         AMRnpDbMDOn69dtEiXZcJI4RRAQJLwGDk4v8sc54uWFiq6/JSZRswuqKRiOgBxKWkToc
         hHQKz+t4LIbgd2SJNt701raEtAFz+ArPW7PWbckGgMy+8kuYqNiJHAguJAPoXQlmcitq
         qmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744038320; x=1744643120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssQkPgtWHpg5qaEQQQk7L7Pz6LQv2SK5PMPPrhZLDD0=;
        b=TtxRdbVHNlOXtJ1iLhl0B6VetT5ZSkQPsLWM8WQl5cDWAWAd0OmP9dpcmgewPaThsX
         xg1bEfmi1+vu6JHo4KwUmIdONy93bgIDJ8anWZziXvAG1ePHivJA7vmq9UVEn6gWA/Uf
         OdBzOxwaijmA6GPHGeHC8u1dhCHLVN7YFlz3o06YFtiLRgNIFGDM5T8kIz/cxnGHwtjf
         M+jI6iinOYb49QG1oz1P3RZFaO2OddaVGjzd3j565JpEIlg19j2WPXwGpY4NNmVv3AJF
         veb7JLoLAez3Y8NtxwkvSuKfaHhmugfrfiySvQfTyzRrSQbM9UwANVlUK+2a3ViFBYVK
         qFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPSyXHVb4GM8yQd6nZFzzk4qqlx6A/begc3Va98l4xh2QDZder0GtrEaBuMUmm5PeFydQxpjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOg/bXkhXNN+0fOw/2E6/ahixbOLl45qUuT1HxW46jQWuDq/AJ
	02d1CsBO+dq9zShExDDXn1HyWS3Xfi/0HFj8DDA/PMdyKPH2KlkvRgRPWQVqRJ8JHjyQ3SLtD8u
	om9chRBNcW/L5FpO/hOg1I2xEljg=
X-Gm-Gg: ASbGnctBRtIrDZnrcOl6Po5rR03WaQiRTBso6nrqSt5ODuQ1/5lVI4G1f16MxzO6nKM
	XIB8SQu+J+fc9w0aPhIc0vabb4Zn2BeX0UkJGF2rK8zmCbuznQF6OFgrsxt11RuiCNp1RTWgPev
	0vOtAlxPMFBReDtaqRqbXmC8ZqQg==
X-Google-Smtp-Source: AGHT+IG3CcW8PNxBithByiKIoDwQtwb4MnM6pyE6J7swZNrMySsujjXMjLGzZDeXRyeckuo1cr6kBZnjAKY9R5oxkrk=
X-Received: by 2002:a17:90b:1c91:b0:2ff:4be6:c5bd with SMTP id
 98e67ed59e1d1-306a496b0c7mr7190956a91.8.1744038320305; Mon, 07 Apr 2025
 08:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407141823.44504-3-matthew.auld@intel.com>
 <20250407141823.44504-4-matthew.auld@intel.com> <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
In-Reply-To: <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 11:05:08 -0400
X-Gm-Features: ATxdqUFzbinX2Mkhe3iiE61F6xMhv6ybqKJIZzLsDt3WD66qk-EiQvU74RAp5zs
Message-ID: <CADnq5_NKa0seCJs7XvxUemyWPFCsuO3dX=n34OVJVn0cz2DuzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/dma_buf: fix page_link check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Apr 7, 2025 at 10:42=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 07.04.25 um 16:18 schrieb Matthew Auld:
> > The page_link lower bits of the first sg could contain something like
> > SG_END, if we are mapping a single VRAM page or contiguous blob which
> > fits into one sg entry. Rather pull out the struct page, and use that i=
n
> > our check to know if we mapped struct pages vs VRAM.
> >
> > Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using =
DMA-buf v3")
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v5.8+
>
> Good point, haven't thought about that at all since we only abuse the sg =
table as DMA addr container.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Were is patch #1 from this series?
>
> Thanks,
> Christian.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_dma_buf.c
> > index 9f627caedc3f..c9842a0e2a1c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > @@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_att=
achment *attach,
> >                                struct sg_table *sgt,
> >                                enum dma_data_direction dir)
> >  {
> > -     if (sgt->sgl->page_link) {
> > +     if (sg_page(sgt->sgl)) {
> >               dma_unmap_sgtable(attach->dev, sgt, dir, 0);
> >               sg_free_table(sgt);
> >               kfree(sgt);
>

