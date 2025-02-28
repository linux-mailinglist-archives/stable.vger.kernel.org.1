Return-Path: <stable+bounces-119927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CAAA4972E
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 11:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC10718836F4
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CFA25F7AA;
	Fri, 28 Feb 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EJGhoXB1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9625F7A2
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738357; cv=none; b=nob1JMnVpqiIUh9e/9Thz1uoBr/WbTLkxgI8A0Tu8HHv+Yh9AqdtGisryJ2k4ykvn+GcVC4G2+MHm5tF/1aVUhHpAA7TMQe0oPl6h7aLp7GAWtFCvI00GVGUnoOqAI9/YFgSzdfi+8XhKjYC4R/oIBMtUYsZlbLw1CuV2p/EKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738357; c=relaxed/simple;
	bh=bnYGrNktnSSLWrDFtsq76cPCF2tBeDvXcfc8CAy88ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=madidFRzjy1ttZEmUwNi3DEIeHYsfe3qdJOKvCMrKGDp5YLvLkSkpnwOXd3vs23jvFpSO/aEVILxJfxto52NftJEwNRUJJI83T6A9+Zmuuyg4CLhHesfHiIL9/DVJmAN7vrefFKwh7/bS1PVewR6J9V8FW1+TQ84NmqLaIiqoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EJGhoXB1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf1da0cb66so206847566b.3
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 02:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740738353; x=1741343153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb9NUQhb3bplKyawSYK7wGLTz8Fx3itEvvEthZZH/DE=;
        b=EJGhoXB1Y9u79VfD5P5ssNMCo/r6iimUk+w5PyYkXg8sXtebkU2a9UIp35zi9l1fCm
         V2SrKq5QI8g0DSs4BY0kz6UM3NDQbNlHgAZ/9D3lBzPsPpmAAUBzz31z/5DI+kWYdsXE
         /Vnd9gZv81jxAb9vDOWWRUCKhL0ggjrm7EXY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738353; x=1741343153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb9NUQhb3bplKyawSYK7wGLTz8Fx3itEvvEthZZH/DE=;
        b=fsYQh8okItUXw7cC9dIR6fdfTIJaqyvVKOTNoWSv+VMUGpjpx3P3SS3tCa6MlgtjAx
         xuGJO+QU/cfhDxcSIyuw9T4CoSnXsv17EWROotCG0WHcm2BJJq0J09uPWH1wnGebDYV3
         aJsIxnsXygZjQnoe38tgEFlp18A1x/4w8FGy8hUi1KaUKaNlXivNT/9yCf/C2wVvT2Or
         5C+xoYTbWnyG8CZzwVHuMUJQsoh7l79uUp3zMiJWQwORhy00KCEcHqWLYRreVgSU6dZ3
         m7XBuFMYXvuKa3XEEiH+7pbOPqi5HINaAk2x+L1AkqVUcVKVThausBOuKaSs6hIQreZ3
         hZUA==
X-Forwarded-Encrypted: i=1; AJvYcCUvyuBIq4tIF0XaGxW8fnSPwxQeZjeNnrLTefEWunC+VQiXdRFX2K2jwbh09rBmSvjTuhrkAgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVFas7cGUDyFuXFchJlwqeZilJaq4fl4KfpqnT7q6YYSKpoXi
	oCut0o4SRF+VJMjOJIzyOhphTwewxhXF1eV1xzX7wbgwvokjwsJyYgEfJYZ9DOx4KH8VE7yJR0B
	d4w==
X-Gm-Gg: ASbGncsxZgSswIMzq/xareZRXvex5kvjA3gbBcQcxYch1/C0Qmw6zV+OCL7EbAJOLt1
	YGwd27utR27OSogg6HJIG13BEsIMwi7EVvVAQS6/944rq+jCaRpW9qPrkIHL5j926deEh9HNz6n
	0SjNbBPmbRhOhyppSneRP0luvG/RBVvpBjTE0Yqbouf9Qofj99YBRFp/ojqQ9nknQisUDj28oQL
	WQUFfKSEqcM1eJR+fsJGSkeEv6o1enGfrd25ZW7wjzcDRuUQpDYwClQ4OwKNok74r3EJ2KI7mUN
	DAGOyQppfOlFnZKZaXFnH3WABu1XyEb+/rkAcVIHjzbk++QvzQRBzWy7OueP3g==
X-Google-Smtp-Source: AGHT+IF7sorANiqu5X3C/X7dHiImc0zbc9px0Mfoav7eBtno0gich+xDq4FVr+O1zsBjCXsNHOXG/w==
X-Received: by 2002:a17:907:7b89:b0:abf:2ab:8561 with SMTP id a640c23a62f3a-abf25f8f358mr277815666b.5.1740738352902;
        Fri, 28 Feb 2025 02:25:52 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3fab70e1sm23654066b.50.2025.02.28.02.25.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 02:25:51 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e05ac70b61so4641a12.1
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 02:25:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7rvkMH3ndHDxj+2Ir1TiDVTSDvmtNNR6pdF1ebDmvrtOp/aqWQlSWELFoXMh4BClSQgeXXpA=@vger.kernel.org
X-Received: by 2002:a50:d7dd:0:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5e4d74dea39mr77472a12.4.1740738351014; Fri, 28 Feb 2025
 02:25:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128-b4-rkisp-noncoherent-v3-0-baf39c997d2a@gmail.com>
 <20250128-b4-rkisp-noncoherent-v3-1-baf39c997d2a@gmail.com> <25beec7ea929b624d845f5ba4abce6267974ed82.camel@ndufresne.ca>
In-Reply-To: <25beec7ea929b624d845f5ba4abce6267974ed82.camel@ndufresne.ca>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 28 Feb 2025 19:25:33 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A4YOaSCn=xe7OM-hPKcUhqkD5hTiMUo5F9pwhKNFJ2Lg@mail.gmail.com>
X-Gm-Features: AQ5f1JoHaD84fv2X5fHk6A_BWpTZQNcf1bz4WEEDQ8FkApfINlkKzBEV-PkKHU4
Message-ID: <CAAFQd5A4YOaSCn=xe7OM-hPKcUhqkD5hTiMUo5F9pwhKNFJ2Lg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] media: videobuf2: Fix dmabuf cache sync/flush in dma-contig
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Mikhail Rudenko <mike.rudenko@gmail.com>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:30=E2=80=AFPM Nicolas Dufresne <nicolas@ndufresn=
e.ca> wrote:
>
> Le mardi 28 janvier 2025 =C3=A0 23:35 +0300, Mikhail Rudenko a =C3=A9crit=
 :
> > When support for V4L2_FLAG_MEMORY_NON_CONSISTENT was removed in
> > commit 129134e5415d ("media: media/v4l2: remove
> > V4L2_FLAG_MEMORY_NON_CONSISTENT flag"),
> > vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions were made
> > no-ops. Later, when support for V4L2_MEMORY_FLAG_NON_COHERENT was
> > introduced in commit c0acf9cfeee0 ("media: videobuf2: handle
> > V4L2_MEMORY_FLAG_NON_COHERENT flag"), the above functions remained
> > no-ops, making cache maintenance for non-coherent dmabufs allocated
> > by
> > dma-contig impossible.
> >
> > Fix this by reintroducing dma_sync_sgtable_for_{cpu,device} and
> > {flush,invalidate}_kernel_vmap_range calls to
> > vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions for non-coherent
> > buffers.
> >
> > Fixes: c0acf9cfeee0 ("media: videobuf2: handle
> > V4L2_MEMORY_FLAG_NON_COHERENT flag")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> > ---
> >  .../media/common/videobuf2/videobuf2-dma-contig.c  | 22
> > ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > index
> > bb0b7fa67b539aa73ad5ccf3c3bc318e26f8a4cb..146d7997a0da5989fb081a6f28c
> > e0641fe726e63 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > @@ -427,6 +427,17 @@ static int
> >  vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
> >                                  enum dma_data_direction
> > direction)
> >  {
> > +     struct vb2_dc_buf *buf =3D dbuf->priv;
> > +     struct sg_table *sgt =3D buf->dma_sgt;
> > +
> > +     if (!buf->non_coherent_mem)
> > +             return 0;
> > +
> > +     if (buf->vaddr)
> > +             invalidate_kernel_vmap_range(buf->vaddr, buf->size);
>
> Am I correct that this is mostly to prevent the kernel from reading
> back old data from the cache after an application or other driver did
> CPU writes ? If so, can't we restrict that to DMA_TO_DEVICE and
> DMA_BIDIRECTIONAL ?

Note that this function must also synchronize between the user-space
and kernel mappings, where the DMA direction doesn't really matter.
Also it's unlikely for it to be called when not needed - why would one
begin a CPU access before the DMA, when the DMA is FROM_DEVICE?

>
> As for pending kernel writes, they should have been flushed before the
> buffer is made available for dequeue.

There is no implicit flushing for imported DMA-bufs. All the flushing
needs to be executed directly by the CPU accessors by surrounding the
access with begin and end CPU access, be it in the kernel or
userspace.

> And any access while a buffer is
> queued is concurrent access, which is expected to have undefined
> behaviour.
>

Correct.

> > +
> > +     dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
>
> Isn't there a link to make between buf->dma_dir and direcction before
> calling this ? Also, shouldn't we use direction insead of buf->dma_dir
> to possibly limit the scope ?

Oh, yes, that's a good catch. It should be |direction| passed here and
not |buf->dma_dir|, since the former determines what CPU access will
be done.

>
> > +
> >       return 0;
> >  }
> >
> > @@ -434,6 +445,17 @@ static int
> >  vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
> >                                enum dma_data_direction direction)
> >  {
> > +     struct vb2_dc_buf *buf =3D dbuf->priv;
> > +     struct sg_table *sgt =3D buf->dma_sgt;
> > +
> > +     if (!buf->non_coherent_mem)
> > +             return 0;
> > +
> > +     if (buf->vaddr)
> > +             flush_kernel_vmap_range(buf->vaddr, buf->size);
> > +
> > +     dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
>
> Similar questions for the end_cpu_access implementation.

Yeah, same here.

>
> Nicolas
>
> > +
> >       return 0;
> >  }
> >
> >
>

