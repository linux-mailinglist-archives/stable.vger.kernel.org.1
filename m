Return-Path: <stable+bounces-119881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9510A48F21
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 04:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525B21892561
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 03:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD94157A55;
	Fri, 28 Feb 2025 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="ajGRkQ6K"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61AD2BAF8
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713438; cv=none; b=KtkAi+exTRJ/av6wSbBaObOjrYDZURn39pu10h6BAekabjggPv/vn6TMB3G8dNMwpfzcsbmkc9SIdNw1c4CHY920ohNgP0UGaHIdzpdJsXVJyllhjU98g/G63rxw38ijfeorfD4IGEWfsBrY1Yh3Ce9uPkmgyxKM0wtx92PoT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713438; c=relaxed/simple;
	bh=ZwRtAKiHSC+DlCDipLWMPBo0fB0XJxa/oWhdVHUyLJQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ObWWUCYyAIye/bP7GzmukXG/kwY6Jnnu90gmLmkZXvzbCY5xSNp8jLdZeyYyq1K1OBzYWSS/zfvpUQyBek7RGzNxLlETxEoGsaxn90kxJMvQAzJ/8Ck38hCyqZZ0L4GgTZMTnJNQg4KxaCrAX/fTDa/pAaq/V4DtbMTXgcCJBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=ajGRkQ6K; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471f9d11176so17551211cf.0
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 19:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1740713436; x=1741318236; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RVVG2IwvthWW/+RBCG6i5JXoqhlYqngpobZWnBOaYI4=;
        b=ajGRkQ6KbkU6CaieJzUpDTy6koJTD9kkT+ESqHpKWLAyOA8CwvcMQdSwGz/5nLQSNX
         yljW7FZZ6qPOmjuK5e2fQ9gGfJWr9XR53eMnS5Lhj4m6TI/QRfoZVExTFyd+DR5RH4hJ
         kH8g6u050Y5z0vbU81LqFNaSbkFXNOWeQ1WvPb6hyipqfZ6RceEfPa6li0Uy6nD4R3AA
         J9yDf7YKSdxWGgkYnPqhufeAdLML+b7O/CZxcB8vhpVMd3R5psFXAlfGrk56BibgAz5m
         hLwWbpy4xSWwQeJ1UhtTkGEbpbGyJlMYh/sk94usPLDdsUz/B/5lBAUcsRYisPbc1HLu
         cRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740713436; x=1741318236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVVG2IwvthWW/+RBCG6i5JXoqhlYqngpobZWnBOaYI4=;
        b=gr88SPO7uwxfusx20iTJ5UHL1qsPepf6SpzdcdR4bhZ+8GF69OtEs/ENqNtzgU26za
         mW1fNLBC3a/qhuSZAdqQOkE+FlTDFojMPTMKu2SxovSKXyD6hrOyUQwVBsC4ghQUiN7h
         Qfly3fADO6mzEm+R1fEqHhXd1r7t6lQmD5k87atO++QOfPK0STHGcAzKhKF3f8BFnOcf
         jAOih6VooecCTAOd6QC1nFPC7sDkttzQ3tF9E6kvhgNG5oPJBalIxjjC0XbnyvIsR+Nc
         A4xM9+498pv5EEGvBIGad8o/hjIKK0GPYoF28R6G3cofFFiI04jnA5BN1A/3X7Nmjg1M
         LfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA2tg/DSWoxJe4Eal9hWUd4acaJCwgbtletpVcYpJ15JHWdD5I8kkRmaaUv78k31lIoxVIzS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyke529zjV+qKgpfw1xsmkGeYQkiNsLNsx21eQw+iuZYs82XG32
	E7aj7e/MkAFujczeYOeN68lCguYt1qn2R+rmySCyhdRPfIvdrT7Tyu1l4rdkAO4=
X-Gm-Gg: ASbGncu/90gBB7u0dy6lQnMgE6eHsbWeCbXpfou5eZKbgR12rrYx6x/ygM56/+mEIRa
	he2aAHtHRjr2WwQn0lwfoQm1KvbSRjzDpKgaiuTFTT7lNjoTzSBcpQWeeCo8f/bBzQZW1gd4xyS
	ztPuRLBKytP4zRuoZKwzMH1WmxPvh81NNh3CugyPljBdaq108cz3oUrksl3DULkDEn22Ev2tg9g
	YgTmUvX33SQ87pxOOOJga+pe6tg9/XW0F9ohY7lgSq/MJkl4/AxAxeSOcACozlx7a0dM2pCVCn2
	Je7H5koH4lfJrhysTFzm6afLDzjJxmM=
X-Google-Smtp-Source: AGHT+IEEio0A7nIEAZI3ddno0TpSgz9fND8CuYHuE1x0cFd3ArDKQjvW9X1ozId7B5F4Eo4JdE2bJw==
X-Received: by 2002:a05:622a:11d0:b0:471:eca0:113c with SMTP id d75a77b69052e-474bc0fef42mr23052141cf.42.1740713435715;
        Thu, 27 Feb 2025 19:30:35 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:e976::c41? ([2606:6d00:11:e976::c41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474b7696709sm11029291cf.48.2025.02.27.19.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 19:30:34 -0800 (PST)
Message-ID: <25beec7ea929b624d845f5ba4abce6267974ed82.camel@ndufresne.ca>
Subject: Re: [PATCH v3 1/2] media: videobuf2: Fix dmabuf cache sync/flush in
 dma-contig
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Mikhail Rudenko <mike.rudenko@gmail.com>, Dafna Hirschfeld	
 <dafna@fastmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  Mauro Carvalho Chehab	 <mchehab@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Tomasz Figa	 <tfiga@chromium.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Hans Verkuil	 <hverkuil@xs4all.nl>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, stable@vger.kernel.org
Date: Thu, 27 Feb 2025 22:30:33 -0500
In-Reply-To: <20250128-b4-rkisp-noncoherent-v3-1-baf39c997d2a@gmail.com>
References: <20250128-b4-rkisp-noncoherent-v3-0-baf39c997d2a@gmail.com>
	 <20250128-b4-rkisp-noncoherent-v3-1-baf39c997d2a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mardi 28 janvier 2025 =C3=A0 23:35 +0300, Mikhail Rudenko a =C3=A9crit=
=C2=A0:
> When support for V4L2_FLAG_MEMORY_NON_CONSISTENT was removed in
> commit 129134e5415d ("media: media/v4l2: remove
> V4L2_FLAG_MEMORY_NON_CONSISTENT flag"),
> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions were made
> no-ops. Later, when support for V4L2_MEMORY_FLAG_NON_COHERENT was
> introduced in commit c0acf9cfeee0 ("media: videobuf2: handle
> V4L2_MEMORY_FLAG_NON_COHERENT flag"), the above functions remained
> no-ops, making cache maintenance for non-coherent dmabufs allocated
> by
> dma-contig impossible.
>=20
> Fix this by reintroducing dma_sync_sgtable_for_{cpu,device} and
> {flush,invalidate}_kernel_vmap_range calls to
> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions for non-coherent
> buffers.
>=20
> Fixes: c0acf9cfeee0 ("media: videobuf2: handle
> V4L2_MEMORY_FLAG_NON_COHERENT flag")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
> =C2=A0.../media/common/videobuf2/videobuf2-dma-contig.c=C2=A0 | 22
> ++++++++++++++++++++++
> =C2=A01 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index
> bb0b7fa67b539aa73ad5ccf3c3bc318e26f8a4cb..146d7997a0da5989fb081a6f28c
> e0641fe726e63 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -427,6 +427,17 @@ static int
> =C2=A0vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
> =C2=A0				=C2=A0=C2=A0 enum dma_data_direction
> direction)
> =C2=A0{
> +	struct vb2_dc_buf *buf =3D dbuf->priv;
> +	struct sg_table *sgt =3D buf->dma_sgt;
> +
> +	if (!buf->non_coherent_mem)
> +		return 0;
> +
> +	if (buf->vaddr)
> +		invalidate_kernel_vmap_range(buf->vaddr, buf->size);

Am I correct that this is mostly to prevent the kernel from reading
back old data from the cache after an application or other driver did
CPU writes ? If so, can't we restrict that to DMA_TO_DEVICE and
DMA_BIDIRECTIONAL ?

As for pending kernel writes, they should have been flushed before the
buffer is made available for dequeue. And any access while a buffer is
queued is concurrent access, which is expected to have undefined
behaviour.

> +
> +	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);

Isn't there a link to make between buf->dma_dir and direcction before
calling this ? Also, shouldn't we use direction insead of buf->dma_dir
to possibly limit the scope ?

> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -434,6 +445,17 @@ static int
> =C2=A0vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
> =C2=A0				 enum dma_data_direction direction)
> =C2=A0{
> +	struct vb2_dc_buf *buf =3D dbuf->priv;
> +	struct sg_table *sgt =3D buf->dma_sgt;
> +
> +	if (!buf->non_coherent_mem)
> +		return 0;
> +
> +	if (buf->vaddr)
> +		flush_kernel_vmap_range(buf->vaddr, buf->size);
> +
> +	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);

Similar questions for the end_cpu_access implementation.

Nicolas

> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
>=20


