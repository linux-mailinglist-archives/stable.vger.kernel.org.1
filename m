Return-Path: <stable+bounces-110852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B0A1D535
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C577A1E73
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95B91FECAB;
	Mon, 27 Jan 2025 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZwmzFTSm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF71FDA85
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737976748; cv=none; b=hgu0AeQqObPJEmOITR5tDSXdZ8OX3gya6D4i1AOp5SfmjOvQELR/LbFgVndnsagHBVTi+62eXx83SOvs1Zr2FdFBGzbwUb/n2BLU3MBY3dzn2yjp7TGogIpv02zrMp0KBlct6iIWRC8S3dDMWgOIFVb78xIeLT+IVCPMDqNabHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737976748; c=relaxed/simple;
	bh=5F6uSRVC3kc2d2TPQ/hsrGAUqJkivNawdY+eXrPoi50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcbhbTDh+HtKKTyJhrastC50xfL+5O1K+2gEcDUuWIiFYx2pLt5AwO5Lqy6J0xYaqp7scx0Vt8qDmHGxfGHu9BbFfJ1Rqzhp1/TmHSYHWPmZIFCXyAm+vf2fGLFSMsLEnVwputbOFIuBAughY6C5OZGySiAJCYse8ZRiJtROSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZwmzFTSm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so8390519a12.2
        for <stable@vger.kernel.org>; Mon, 27 Jan 2025 03:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737976744; x=1738581544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj/btp7iB/WVExe7HRHgQ+HsqxBZyERYlUan4lSFhKQ=;
        b=ZwmzFTSmaE5SN1RhnIfg5DQEJL9qit3X75EKk07O+ZkXqwAdTy3tVEdulRJdd5CB7h
         2/PMJPTve9KxSi+E9b2iNJ2xmHMfasyn5hAGVgztF7GfX+s3HeFwmh3DmFmqBh4PEV6v
         fKuVK79HFMLOMdXcAn2Pe+J9W3vRXHLhO72VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737976744; x=1738581544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bj/btp7iB/WVExe7HRHgQ+HsqxBZyERYlUan4lSFhKQ=;
        b=kJ6nnDlvTAy8MoII4UamyLtPPXzy0gjDVsMjHhnGDsCN0ehxKz//Q4mL8m+WnIdFui
         zsQgkWtg3toNmKfJ0l+7OezD+/FxfcMbJ/ucKwvUqTpk+MKRsedUjuWLt9cpI5CydxoI
         jCOvLBMma5YCxSDBvV+7ru6JSAf67ezS83dWtvvojgLBTgiA/W2ADhh9ZmZa4EJI+7I4
         vbQV/XK6KcSCJ1TaxfscDHyRJqFi818O4zckE+EE4ZMy0ET3btxD5ww4cpQvFR97tuYc
         rzpt03ju6G5NmIKVHv0Dypnl26snIsnfBzfxA5itchzrFJduD2V5iQeUKnRGa51qH/rW
         r+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt7SBisvYeV5UTjnPqtvO5zfODgoswY+BubNAKIB+Rjl01pPvJbSEkbCq/sjJ6uDm9ZaKYHpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/v0uei6I3MAClyo5R33cB5JIyhPkFUSdBd1/+K39MJufHoLXB
	nXfKcXg/PE973BByzE3kzBlSJ/faPAOsBBCe/W8y+oHFTY2uMPk4Y6Z8zGKh1W3HCtwbGUSi+LW
	UUw==
X-Gm-Gg: ASbGncsfo78XYpnI4amtdBcL1jiRJFAqJ+SanO0jwFI/BA5j7Oop3RYvjk7BaLkwkmq
	Cnx+n0fTXXEn9iImbW4fEBPilGd6F+WE4zFFevWPreIKMXduKolq3EzLUgzvrXxcAyegjmkTwEr
	zCkxZRPy0hQW2umEPr1WBq7YuG47iGV+jQZ2sbPgekaia5esVn6sZJspMgL6SaKG0KsIWjfTHb3
	JIdhWxecMot8VkF7fdMNbm0s0KoRLdWw48nqekLtBLziJweqks46k1tFnKppJ/vnrn5zsWkR4gj
	9EYhmIT6E3K9YVfzWuj6WJougSVQNfhu7kbaUCgC
X-Google-Smtp-Source: AGHT+IFuxI9laL5lEhTWTy/rdU+sTUsjFzq2p7dkFO9JZ9eNg9Ii/YiyhSVf6xj8hwXxBdJ/eyG77g==
X-Received: by 2002:a05:6402:2683:b0:5db:6880:360 with SMTP id 4fb4d7f45d1cf-5db7d2f9bbcmr34633990a12.9.1737976743636;
        Mon, 27 Jan 2025 03:19:03 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc186df3e3sm5260811a12.69.2025.01.27.03.19.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 03:19:01 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d442f9d285so8120a12.1
        for <stable@vger.kernel.org>; Mon, 27 Jan 2025 03:19:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6Bo9dPoYVapFKLGFvbe7Sea6mj1vJPCem8Ki5Esw2pfvJt4A6VSs5BxtXQqWJ4rDURa6e/H0=@vger.kernel.org
X-Received: by 2002:a50:8a8e:0:b0:5d9:693e:346 with SMTP id
 4fb4d7f45d1cf-5dc243b84e8mr130774a12.4.1737976741062; Mon, 27 Jan 2025
 03:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115-b4-rkisp-noncoherent-v2-0-0853e1a24012@gmail.com> <20250115-b4-rkisp-noncoherent-v2-1-0853e1a24012@gmail.com>
In-Reply-To: <20250115-b4-rkisp-noncoherent-v2-1-0853e1a24012@gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 27 Jan 2025 20:18:43 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DFuw9e85X-UhVfonb5C9F0tG6xyn9RUGitKDQXifcUyA@mail.gmail.com>
X-Gm-Features: AWEUYZn0_AfnNbH4PuJVO5cenPSqx6huf_K_307ofmg4I9T9Tf9BB4t2frTysv0
Message-ID: <CAAFQd5DFuw9e85X-UhVfonb5C9F0tG6xyn9RUGitKDQXifcUyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: videobuf2: Fix dmabuf cache sync/flush in dma-contig
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: Dafna Hirschfeld <dafna@fastmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On Thu, Jan 16, 2025 at 2:25=E2=80=AFAM Mikhail Rudenko <mike.rudenko@gmail=
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
> Fix this by reintroducing dma_sync_sg_for_{cpu,device} calls to
> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions for non-coherent
> buffers.
>
> Fixes: c0acf9cfeee0 ("media: videobuf2: handle V4L2_MEMORY_FLAG_NON_COHER=
ENT flag")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-dma-contig.c | 14 +++++++++++++=
+
>  1 file changed, 14 insertions(+)
>

Thanks a lot for the patch!
Sorry, for the delay. Ended up being sick with some nasty cold that
took quite a while to recover.
Please take a look at my comments inline.

> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/driv=
ers/media/common/videobuf2/videobuf2-dma-contig.c
> index bb0b7fa67b539aa73ad5ccf3c3bc318e26f8a4cb..889d6c11e15ab5cd4b4c317e8=
65f1fef92df4b66 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -427,6 +427,13 @@ static int
>  vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
>                                    enum dma_data_direction direction)
>  {
> +       struct vb2_dc_buf *buf =3D dbuf->priv;
> +       struct sg_table *sgt =3D buf->dma_sgt;
> +
> +       if (!buf->non_coherent_mem || buf->vb->skip_cache_sync_on_finish)

skip_cache_sync_on_finish shouldn't apply to this function, because
the buffer was shared with an external DMA-buf importer and we don't
know in what state it is at this point.

> +               return 0;
> +

We should also take care of the kernel mapping if it exists, because
on some platforms it may not be coherent with the userspace one -
using flush_kernel_vmap_range(). Please check how
vb2_dc_prepare()/vb2_dc_finish() do it.

> +       dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir)=
;

We can use the dma_sync_sgtable_*() variant here so we can just pass
the entire sgt to it.

>         return 0;
>  }
>
> @@ -434,6 +441,13 @@ static int
>  vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
>                                  enum dma_data_direction direction)
>  {
> +       struct vb2_dc_buf *buf =3D dbuf->priv;
> +       struct sg_table *sgt =3D buf->dma_sgt;
> +
> +       if (!buf->non_coherent_mem || buf->vb->skip_cache_sync_on_prepare=
)
> +               return 0;
> +
> +       dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_d=
ir);
>         return 0;

Overall the same comments here as for
vb2_dc_dmabuf_ops_begin_cpu_access() +/- flush would change to
invalidate.

Best regards,
Tomasz

