Return-Path: <stable+bounces-120406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02523A4F87A
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 09:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222EF16D8FA
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D71EE03D;
	Wed,  5 Mar 2025 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eWgeGFu/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214702E3360
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162375; cv=none; b=riQSqFzfc+FY5aGZevOGb08Lm8egJlGzpA9Ik0w+Hua7g4Y1as+k9JW8lPLHIJdNKxHABsxRYrSb03kCuflSEq6IL5h+sfsJ4rfapIsWe0RwinYWK9Z7CuS2WvwfWngmQViA/wpOMYbL2C7R6Q0yXNaxYekoAY/Rv/W6VVuDGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162375; c=relaxed/simple;
	bh=C0/8hW1TkNk5j1MdVgSV3Ikl0qmLYuEJPKaklUIObiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbpMODprgYvR3L4KtwDkFpyFbkEIQd4gKv/FmNS73uf7f3D/jOkwO8+UGvaO9Ip/KS57pfxqBYHy1/gubftE7jcG6i+8OxXspQqszHWLxC/8EXR4jbP+RgAngHYRsHlyWzJIV6ij/+2Y5SLP3JTfOZvZMn4paPRFlEsdrH3AtWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eWgeGFu/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab744d5e567so101066466b.1
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 00:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741162372; x=1741767172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXA/TkGXM5NxtIFR0Rkc5MLIvPVEhtWeAVEIdjIqSAA=;
        b=eWgeGFu/1Kedmj4Kzd304QUXKg+sJRL+Bb06jsRnGMWCiid6NcX15byRJPQQlWAW9+
         hCdfYHmyrXaVnN7Oabe31N1Ou3jQQgoEmXKRHeKf6msvSwOqZqo6LMDK9rIOzOiu4JCn
         nRMgsWJd6sgosZvojlVX5UUmscTuiav8Lue1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162372; x=1741767172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXA/TkGXM5NxtIFR0Rkc5MLIvPVEhtWeAVEIdjIqSAA=;
        b=K2rZZKfceGn7lDZ4InVduA4+y9XwNn7VlOWqXO/f1csmhAxNPtAlZlPKp5vCgrUXMe
         7Vu6Pui6StnHycIZcM49gBUhM+yjsKUBKicQUXc56MteVRT97uwvxysunlT04bHkFMp3
         oKWzFhm2+jmGO8S9F2kd16SJw1a7lsYzabIhXsVGGM1+2jocOS6n2dSeUfxbF4jzfeOF
         gTnEbmiNF8cqAAA6G054pYjKLfzpoFE+2fzzIl+maajVN7Ij0jYKC3zYiQ2kgldDkuLh
         Ipn65YLjCTPtkjY+a3sMAFYn49L7IHgxGXTWpI34V5qzsXj2tBuWYOx60oRqE0OxwNFs
         dO2g==
X-Forwarded-Encrypted: i=1; AJvYcCW5L+hlY2XkLUs29jJDUrDuJrz9Jy/yamITthIQf8/Bl+u5kReSZk39plKhSaa8SLjvkZU9Xkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxPubj3GBHb3BQW8avLUXhdylOO2ar8GEHfjLvrV6LVxHUFca
	BD4E2m74rtgin2Be9daRbHS4SPZbhVN9bEyWXC2QX4MZ/id9EhebCsKZBPSFJZD+X9olHdWsqkq
	cww==
X-Gm-Gg: ASbGncuQfR+qQS7QdZ+5lpBe6R30CS7NdoiUHlsRMUA4Gsr7snk+fNaFYSySjMvsRlO
	Lmox+jRxDcfqepMx7FPwAARsMADG5KUWQuagBLrR+hg7zktLcXGV2M7Uuc9CdN/EXbN8czooHod
	iHR7SMQKZxrfvmCfmPXxOeMKlt3r42/NgXh25lVOHWVQAm3j0NpB1fQuAQVYlipDJplQBklzs1L
	v4msSx0Zh/tpe9ZwbJ8vQNqqlEpPg6+6/ODA8GDMjbQGeTlcGaiX6mxGkcrBGX+MffL7106B10B
	qIJytdwizwEEbM/xY8SeFq0Ikkh0fBoSV9PTydbbIUp05o9zdemivT41cmMikfGUMvrNRfrvyoA
	hwO/x
X-Google-Smtp-Source: AGHT+IEknj/nHRZd6MXlbzX3zLCPHYVIzNXzJdp3pVwb5siNTF5pLOvoN1OkoUB9GsArd6nu8ZV/Mw==
X-Received: by 2002:a17:907:9450:b0:abf:6e88:3a63 with SMTP id a640c23a62f3a-ac20ed51c3amr180794566b.9.1741162371709;
        Wed, 05 Mar 2025 00:12:51 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1fa431529sm215853066b.148.2025.03.05.00.12.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:12:51 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so7228a12.0
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 00:12:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXL+mVDT4yrlMNadgKMeT6Vpqr3bTx07K0pKOfuzfPrRG2LFKuQx/86dSd2fVLmXYjPrVM3plU=@vger.kernel.org
X-Received: by 2002:a05:6402:682:b0:5e0:8003:67a7 with SMTP id
 4fb4d7f45d1cf-5e59f582d2bmr77034a12.0.1741162370247; Wed, 05 Mar 2025
 00:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-b4-rkisp-noncoherent-v4-0-e32e843fb6ef@gmail.com>
 <20250303-b4-rkisp-noncoherent-v4-1-e32e843fb6ef@gmail.com> <8b3dac7baed1de9542452547454c53188c384391.camel@ndufresne.ca>
In-Reply-To: <8b3dac7baed1de9542452547454c53188c384391.camel@ndufresne.ca>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 5 Mar 2025 17:12:31 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CMsgjs9t3Lp-r3rqHG1dFJV5bFEFciWmKU+vq=TtAOvA@mail.gmail.com>
X-Gm-Features: AQ5f1JqMbRJjwTyn4eHWZnhmp3yyPL8Rgkfmk3Wh029t14UkPKDmnySUbUDhBgc
Message-ID: <CAAFQd5CMsgjs9t3Lp-r3rqHG1dFJV5bFEFciWmKU+vq=TtAOvA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: videobuf2: Fix dmabuf cache sync/flush in dma-contig
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

On Tue, Mar 4, 2025 at 12:24=E2=80=AFAM Nicolas Dufresne <nicolas@ndufresne=
.ca> wrote:
>
> Hi Mikhail,
>
> Le lundi 03 mars 2025 =C3=A0 14:40 +0300, Mikhail Rudenko a =C3=A9crit :
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
> > a13ec569c82f6da2d977222b94af32e74c6c6c82..d41095fe5bd21faf815d6b035d7
> > bc888a84a95d5 100644
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
> What would make me a lot more confortable with this change is if you
> enable kernel mappings for one test. This will ensure you cover the
> call to "invalidate" in your testing. I'd like to know about the
> performance impact. With this implementation it should be identical to
> the VB2 one.

I agree that it would be good to test that path as well. I wonder if
we could somehow do it with one of the vi* drivers...

>
> What I was trying to say in previous comments, is that my impression is
> that we can skip this for CPU read access, since we don't guaranty
> concurrent access anyway. Both address space can keep their cache in
> that case. Though, I see RKISP does not use kernel mapping plus I'm not
> reporting a bug, but checking if we should leave a comment for possible
> users of kernel mapping in the future ?

We can't skip it for CPU read access, because it may be the first read
after the DMA writing to the buffer, so we need to invalidate the
caches.

That said, on majority of systems this will be a no-op, because it
only applies to VIVT and VIPT aliasing caches + only when the kernel
mapping is actually used (the buf->vaddr mapping is created on
demand).

>
> > +
> > +     dma_sync_sgtable_for_cpu(buf->dev, sgt, direction);
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
> > +     dma_sync_sgtable_for_device(buf->dev, sgt, direction);
> > +
> >       return 0;
> >  }
> >
> >
>

