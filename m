Return-Path: <stable+bounces-114273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035D3A2C888
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B8D16A0D7
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A23189BAC;
	Fri,  7 Feb 2025 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JUbYWZNH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D71182D9
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945350; cv=none; b=luit5QTBqt2N+MLH7jqAdCHMQMUHwiEe1nFEpZ7QHxm/qyEEbeRXgTzVJh4kdHnr4sZjnFHkzDeZhT1YgDBlrI7uwaN2uMspd5LzlpcP6/IGzDJQEcnWypYM7ce8Lt4l1DDpekP2q0w65EiuPj4LELz452tLvnksI1zIHGCxtG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945350; c=relaxed/simple;
	bh=iTsuxyEIymohulJzY7JTD8IGPdVLrm5BWF6T6qQbtUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suIGYQQkQ7/MwL753UBrGFjW4/NT8jUvQLIu+A4kHVxWSZ8OwLWgA48z2SMFmRBMzpmhMnAwXQ4zipBm09iL+y2sKxQr5RLVePhJKdn0i3Ht9GaDgidFJCpFMAsVqjUU/8F0/03L8o+TsYifmzA2JhcXVgALXGr2t2aXZqKv2xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JUbYWZNH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dce1d61b44so4187555a12.2
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738945346; x=1739550146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCn5Dk3vMVo7X1t68AtKlpToAukuif5wkQVCcdE+FHY=;
        b=JUbYWZNHAyUHLGGBjQk9NOUHCfDIgvwTalD6XE6mPQ0WD95Fk925PgC0riqYDQXoeg
         RnzfGEo0QdKWEGEyqiQu66bBEnL09SnM9UEBHkxtRJHK1MOibOjzQ94yDEgZo7RC8b2F
         h93byUEHrxLBsraVPGxjm1Agtzl09YaJvoCaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738945346; x=1739550146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCn5Dk3vMVo7X1t68AtKlpToAukuif5wkQVCcdE+FHY=;
        b=AHboGrotRDUR78HZT8gZDo/Ud+o3wLYOtj497HYq02mubekaa4zURtIpTx1AEBtPNQ
         qtclidTIPxJRtjhgE0v1+mBFur0k/DdGgsN025H7UMcf0eC6A+lyM7dQEwuQbNFDtVwW
         AI+PbV8fQtEAqek2N4u3prPATsJCQzO3vgHLIYIQBNtREvknUEdPI+nknaCLVz0oQaVR
         BlKSObiuGnm1IwHFQDT3E/StY8AEBnjaXRWaUg83t/cnug9nGkfUrIOUke4dYzLToUU4
         2wpj2148yTeoIqN5wC2CPPXr1gZrn4IC2ggHeni2qwdh+AR9WDsf63/X6myDOiywUb9s
         GFyA==
X-Forwarded-Encrypted: i=1; AJvYcCXmPJEe9gmDULslufU6asYApftyxraTcKhUID532EoqHximtFEY/qOnwzo7ftZaTd21zWF0AOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1rgKGfiSjm6lX77Uimg/y/h09hrRNcSaEVs2XO13WOilK9+Y
	dvGpDNHbqK3akpSZOFtH4Q5klM9FTu7qOPT7Ts3V0Ta7DjxsK/4IdPzzlb9wRQH5t1BiCtPrLEF
	Q1VDq
X-Gm-Gg: ASbGncts8y7hvgRoAw9n1cVMSDN0tl7yL8yZS9y/iuBHsnpxXp/t+FWnaRM6aYUG3Sn
	mbw9YIcQfA8yoI01UBYRyEQAVmtjE1DTdudLni4ORlWkF3h1HUV2t6GOgbr7u5F1a9U8ZLr+T42
	ux/0yMEhmHf3Sh1egerm0gXtdn9Jhv2XocYhJQINHn/QnTMX3Ji7zcOZBXQhpyacZkYQZ5y4t0P
	oXE8rjKhTVcZryNVY5VM5FPIjncPxJoSYtVN8t8vnpwED+4qAXM4n4itEb5TD2vA1yEa1MmtJrz
	psl8k8A9QqkIGO/xZOBjzORILiLSW9WayCs0wRLsd6F56aZvnz4=
X-Google-Smtp-Source: AGHT+IGQY0EgugnkNwcO50fHeT4Q0vqZpZyijZnKfpLqpI+BxRGGK5sZxYlElrNUUgQjoVPLGi9QHQ==
X-Received: by 2002:a17:907:6e86:b0:aa6:9eac:4b8e with SMTP id a640c23a62f3a-ab789bfc7d9mr441639566b.41.1738945346552;
        Fri, 07 Feb 2025 08:22:26 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab784d33c59sm188876166b.183.2025.02.07.08.22.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 08:22:25 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d442f9d285so8040a12.1
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 08:22:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8EpgB0L8E/dhYBOcS9Wik2y9W8stWSpuGJkn2WS/Piga8g12n/EHEGCqjOT5fjOrL80Ee6Qc=@vger.kernel.org
X-Received: by 2002:a50:ee16:0:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5de46901c8dmr116990a12.4.1738945344498; Fri, 07 Feb 2025
 08:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128-b4-rkisp-noncoherent-v3-0-baf39c997d2a@gmail.com> <20250128-b4-rkisp-noncoherent-v3-1-baf39c997d2a@gmail.com>
In-Reply-To: <20250128-b4-rkisp-noncoherent-v3-1-baf39c997d2a@gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 7 Feb 2025 17:22:08 +0100
X-Gmail-Original-Message-ID: <CAAFQd5BkbJz4VJOvj8P5gBtbi=VCgsgebw12PnepLj6Qn6C_AQ@mail.gmail.com>
X-Gm-Features: AWEUYZkLRr1JxCvNI8JDDZBOdbLkP21kufM0wZUw4Akj7bxs1aInWlFMBNe_a0o
Message-ID: <CAAFQd5BkbJz4VJOvj8P5gBtbi=VCgsgebw12PnepLj6Qn6C_AQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] media: videobuf2: Fix dmabuf cache sync/flush in dma-contig
To: Mikhail Rudenko <mike.rudenko@gmail.com>, Christoph Hellwig <hch@lst.de>, 
	Robin Murphy <robin.murphy@arm.com>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: Dafna Hirschfeld <dafna@fastmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 9:36=E2=80=AFPM Mikhail Rudenko <mike.rudenko@gmail=
.com> wrote:
>
> When support for V4L2_FLAG_MEMORY_NON_CONSISTENT was removed in
> commit 129134e5415d ("media: media/v4l2: remove
> V4L2_FLAG_MEMORY_NON_CONSISTENT flag"),
> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions were made
> no-ops. Later, when support for V4L2_MEMORY_FLAG_NON_COHERENT was
> introduced in commit c0acf9cfeee0 ("media: videobuf2: handle
> V4L2_MEMORY_FLAG_NON_COHERENT flag"), the above functions remained
> no-ops, making cache maintenance for non-coherent dmabufs allocated by
> dma-contig impossible.
>
> Fix this by reintroducing dma_sync_sgtable_for_{cpu,device} and
> {flush,invalidate}_kernel_vmap_range calls to
> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions for non-coherent
> buffers.
>
> Fixes: c0acf9cfeee0 ("media: videobuf2: handle V4L2_MEMORY_FLAG_NON_COHER=
ENT flag")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  .../media/common/videobuf2/videobuf2-dma-contig.c  | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/driv=
ers/media/common/videobuf2/videobuf2-dma-contig.c
> index bb0b7fa67b539aa73ad5ccf3c3bc318e26f8a4cb..146d7997a0da5989fb081a6f2=
8ce0641fe726e63 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -427,6 +427,17 @@ static int
>  vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
>                                    enum dma_data_direction direction)
>  {
> +       struct vb2_dc_buf *buf =3D dbuf->priv;
> +       struct sg_table *sgt =3D buf->dma_sgt;
> +
> +       if (!buf->non_coherent_mem)
> +               return 0;
> +
> +       if (buf->vaddr)
> +               invalidate_kernel_vmap_range(buf->vaddr, buf->size);
> +
> +       dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
> +
>         return 0;
>  }
>
> @@ -434,6 +445,17 @@ static int
>  vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
>                                  enum dma_data_direction direction)
>  {
> +       struct vb2_dc_buf *buf =3D dbuf->priv;
> +       struct sg_table *sgt =3D buf->dma_sgt;
> +
> +       if (!buf->non_coherent_mem)
> +               return 0;
> +
> +       if (buf->vaddr)
> +               flush_kernel_vmap_range(buf->vaddr, buf->size);
> +
> +       dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
> +
>         return 0;
>  }

I took some time (over)thinking the kernel vmap range synchronization,
because these functions can be called both from the kernel space using
respective dma_buf_*() kAPI and also from the user space using the
DMA_BUF_SYNC IOCTLs, so we could in theory have the multiple
invocations racing with each other, but then I realized that we don't
really provide any guarantees for concurrent writes and reads from the
CPU, so I believe this should work fine. Sorry for the delay.

Acked-by: Tomasz Figa <tfiga@chromium.org>

Let me add @Christoph Hellwig and @Robin Murphy just in case I'm wrong
on that, though... Hans, let's give them some time to take a look
before applying this.

Best regards,
Tomasz

