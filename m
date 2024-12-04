Return-Path: <stable+bounces-98207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764B49E3197
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05D3B296F2
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 02:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A55674E;
	Wed,  4 Dec 2024 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boQjkTkI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850FBE4E
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280559; cv=none; b=A6mjltt8fUfrGk1h2DzlYNIv7PvYcH0OQMK2sNGtNqi7BdYVpgPaB5c+cSvBCOl9+TeW5Ln/b1x8tDIf8MHlXmH5M5Ky3laK8h7kssKx/3UKaeLdnyyH1X3I4O9dVREYUvF8oIJ/in2rDQ3/oEVyg/CNhEJtjOncSxG1SOs5dcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280559; c=relaxed/simple;
	bh=TOKXJ9rIYYz9mEp3F9nZfG9+id1wmYy7VtWtelOVUxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aURo+gV1/67P4DCs5/lMiqaFM9/ehiFJQ/LZd+l4tXStqUTCIsgJcaqZM+XBb39wKnnBEauXgm3/RG88SGBOBAPofZ75GI255u9ReI6p+c3rqQTOJxeG4MCRbjaqwWyEBQkvBr5r3YV9jw3WOCCXOeh26b4nRSLDamvHyDuaUws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boQjkTkI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733280556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c24b0aojPcSy5fMUgMajgZWX2t8sneTXVxIv1lQUC1A=;
	b=boQjkTkIEIUKjQoCyiPVeXh9UhqzOm88YH+8L++XGG8RMlhBlV4AyhLvgf2zQetOdDzgfX
	aFlECIcOOaFKuC10uj1k+eWuJ1UjEHGg9TzVAHkalWclr0KizSrTYugqtJGRSWZ+oxq0xq
	6wfAb0tvFjBmvFr7MBXO/9PoS5TqyY0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-9yy50imgNV6LPFLWDeX_sA-1; Tue, 03 Dec 2024 21:49:15 -0500
X-MC-Unique: 9yy50imgNV6LPFLWDeX_sA-1
X-Mimecast-MFC-AGG-ID: 9yy50imgNV6LPFLWDeX_sA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee3206466aso423438a91.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 18:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280554; x=1733885354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c24b0aojPcSy5fMUgMajgZWX2t8sneTXVxIv1lQUC1A=;
        b=K3y3y+3nRurnWsvsCfYPtRZ7hl5B7QlP2InTkTFHx5aNaOPlSoauNqM3MYWm1Km+L3
         nDQ2K4YN3EZCCQncbwhIBuiJWfY01a4prPCCQchkTuYhud5llJlV3t96FKlCjXHsgMAV
         Dl8GoiTYycKpZGXB+EOJdyVFH+tioqQHCnMmrRAzUKasga+tw6JyHwkdrR3OIdBzHHcM
         zJJD5XHoUUrEIPnQWlzVyUJWekgghBb3kyiDywJaDYekbBQzUd2+enSRmfDgMra6EogB
         Y/pODCaPialvYnQyBb+F6GVt/jriK01nvQM51xkomZ5gKj8EankXVHDQRN5JgggPAiaG
         r+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUH9Uz9nNuQYptYIk8htmgj6vzSZ7KjGw4cz7/GDAdmh6j/Iy2CD3wtNSvW3EWddzvGXy3Ot0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9IN7d/csRovXUZ/zpVobYrbjAj7edHIsnZoRNC/LtuhEjMqk
	dcPrYafTJOUIzOvdXfvTEYxPjejVtN9d3Bi5QFPd3fqypzM858HasK7pwhBNqDWMPhSq8ttA1/p
	bu2wnqKw9mNJ90y3LV0SnOIQ/mgscR/H7lhWgONJobB9lmjE2Re2fz3jTgp0H0L3JwKwKsexRuz
	/w64vOo6cqq2jBAcEk15d6fdWRs/gn
X-Gm-Gg: ASbGncu0sZ/XKSm/cI3btrC1BYXcpAgxzOXuNlp90hfoponEqf5/nbPQvx/YpZ3aKi9
	dc/LVnrz+kJUR9olLdnPpPvmuPI9VME1b
X-Received: by 2002:a17:90b:1e4f:b0:2ee:ad18:b310 with SMTP id 98e67ed59e1d1-2ef0262ddc4mr7260537a91.18.1733280554226;
        Tue, 03 Dec 2024 18:49:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZcqsAhghjmH/484dFh700xwwcOiFPYlB810UI197DONEX9jOMQzSsmaISh5CyYuH1hhBd5fKSpxOiglUbnhk=
X-Received: by 2002:a17:90b:1e4f:b0:2ee:ad18:b310 with SMTP id
 98e67ed59e1d1-2ef0262ddc4mr7260510a91.18.1733280553846; Tue, 03 Dec 2024
 18:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203073025.67065-1-koichiro.den@canonical.com> <20241203073025.67065-5-koichiro.den@canonical.com>
In-Reply-To: <20241203073025.67065-5-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:49:02 +0800
Message-ID: <CACGkMEuUa+6_uaa7H2CSvUnfNzBr-rdoQ+cp8eZD+Ay1CZ=A-g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] virtio_ring: add 'flushed' as an argument
 to virtqueue_reset()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:31=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_reset() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new argument 'flushed' to
> explicitly indicate whether it has really occurred.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  drivers/net/virtio_net.c     | 6 ++++--
>  drivers/virtio/virtio_ring.c | 6 +++++-
>  include/linux/virtio.h       | 3 ++-
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0103d7990e44..d5240a03b7d6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5695,6 +5695,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_=
info *vi, struct receive_queu
>                                     struct xsk_buff_pool *pool)
>  {
>         int err, qindex;
> +       bool flushed;
>
>         qindex =3D rq - vi->rq;
>
> @@ -5713,7 +5714,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_=
info *vi, struct receive_queu
>
>         virtnet_rx_pause(vi, rq);
>
> -       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, &flush=
ed);
>         if (err) {
>                 netdev_err(vi->dev, "reset rx fail: rx queue index: %d er=
r: %d\n", qindex, err);
>
> @@ -5737,12 +5738,13 @@ static int virtnet_sq_bind_xsk_pool(struct virtne=
t_info *vi,
>                                     struct xsk_buff_pool *pool)
>  {
>         int err, qindex;
> +       bool flushed;
>
>         qindex =3D sq - vi->sq;
>
>         virtnet_tx_pause(vi, sq);
>
> -       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, &flus=
hed);
>         if (err) {
>                 netdev_err(vi->dev, "reset tx fail: tx queue index: %d er=
r: %d\n", qindex, err);
>                 pool =3D NULL;
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 34a068d401ec..b522ef798946 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2828,6 +2828,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   * virtqueue_reset - detach and recycle all unused buffers
>   * @_vq: the struct virtqueue we're talking about.
>   * @recycle: callback to recycle unused buffers
> + * @flushed: whether or not unused buffers are all flushed
>   *
>   * Caller must ensure we don't call this with other virtqueue operations
>   * at the same time (except where noted).
> @@ -2839,14 +2840,17 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   * -EPERM: Operation not permitted
>   */
>  int virtqueue_reset(struct virtqueue *_vq,
> -                   void (*recycle)(struct virtqueue *vq, void *buf))
> +                   void (*recycle)(struct virtqueue *vq, void *buf),
> +                   bool *flushed)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>         int err;
>
> +       *flushed =3D false;
>         err =3D virtqueue_disable_and_recycle(_vq, recycle);
>         if (err)
>                 return err;
> +       *flushed =3D true;
>

This makes me think if it would be easier if we just find a way to
reset the tx queue inside virtqueue_disable_and_recycle().

For example, introducing a recycle_done callback?

Thanks


