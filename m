Return-Path: <stable+bounces-98224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B9B9E329A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B02850EA
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A417557C;
	Wed,  4 Dec 2024 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EksffH91"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9816F27F
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285708; cv=none; b=np38YGBvqF84e6l6y8OhOF59cIZSK6m+2sTxH1i+PF3ExUo3qoDUBEbfb0wHSpcOf+CkXdTJ1MSFeC9E5s2f7bh2HnxDuH4Qng++ok2RsXna6WBHf2DVmoo934C0toV52iPr50ElHDbb7XnQnAGw7bP7eqQWS2g9diROSt87ZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285708; c=relaxed/simple;
	bh=IrUEeeXk0XqjRNrEb78avFaZBzk2PWSNq8LbhH2Q5vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GagoEovFvHX0BoPcfhdW/BbL4zf63b6okhXk26Hd4fyngi7pS2oqMH1/2BDHFlmAhCGA2OwyMScZilBJksZfpRsdOFfzFI4ALFJOANcM15S1RqIuI+2SXHhtKJM8vGGPB0u/JQU/0H/My06W49FFieXdxYi5wV2Abp7c2F6DfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EksffH91; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A99C83F31C
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 04:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733285695;
	bh=Q24GDRfJXQyjTe8o63+C0HsFRR+/g6kWIzNile+zMUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=EksffH91slgbCiU5/TxXHLq6LFOPz/G9JiNodlPs8f/6TwGRKYNLTfesbFWx3F98C
	 2xMupUMvs1i1Uk74Vi3kwbO4HKEbBx8XWkqQiAFjv+KAIebkBbailN1HWybNRCZDpD
	 Y/+7TLfKoA7/1c62zV72V5PZhLoyzPvSj85iU5cR2PjETiUvhzqee+u5ZOOJrixil9
	 0XTaQyTsT4XVPnYiHitPGCw4kDg9QgHF9LOGKuGZWeHJlHuWGcvXBS15Nl6tlrDCAH
	 paap9DNWku8yTSFlfBFTfoFOFIYupBXpmUI/MvPF8cl/TDBya7D7M/yTUVmJWwSPp1
	 sd8VOnOYIUV1g==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2eec0bad68dso3163131a91.2
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 20:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733285694; x=1733890494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q24GDRfJXQyjTe8o63+C0HsFRR+/g6kWIzNile+zMUE=;
        b=Wm/ZVwgApDLyuqfFuoR2qFN4Tv5cJb7O7x6tEDqi/VdJTQeziaYS4myu9Uhf/wa0Gz
         KDmz9z6N0bZrj+pFeP0DLTxOlycWegD+DAdvikkt5+BAwa0E+qzombbQ2pfAZDtVWHIl
         8Wmf4oIk1rkdScA1NHymQ0noXQbCWRexpfdV3ehukOgqDB9YFp1Dz+FK1/QKoz26iuKJ
         JXUrgqadW0E/r8dW9lsAtHAtfJhir/g0lEg8Y42r05zuzUtw7aIWeTYTvqSfaKIkpx3g
         dmbLkLoNIMpv+wndwxPax79Q1/k7NQN3ba0ct0HLRdFwxm9+r5lPiRuCyTEfnWh8mXwG
         9TVA==
X-Forwarded-Encrypted: i=1; AJvYcCUZyHI2Peqx1ThpUz7YaIXt5UOH3X/BqY9c0p9tnK3BCqCMO/Q/vRCyB8vsHGFExLJOnOKNevY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynn4eCfzGO/KJPnqudY38dOTCfZtSUzX7VxQPcpYAaRY4b6A8G
	QFyGmyprSnEhemtzeXoBm0tSv8yOBFZaEizSEOmSrP8dKJvz3jYq4mQj1/+J35y4Yp2RFpi0XNV
	XT1WdNm8Wa735R9/CvdRw2+Pnnx45e31JGiMPU2SkW9rmj8E86Y5s2M94iCa2b9jG8VCS6Q==
X-Gm-Gg: ASbGncsBZTTbEGTUDLYwyu8GdsZnIwtVwa99Wi8haTLhvWsLVIqSEj1fWi7KBNusP9g
	SqTDXJsjx2APB4tLZpqVhfLMjsGUzo/cYGas37oID2/H9a+Q505uDxdZxOHjgLa99GzPQK/+Era
	Q03lKJvBMS9Yt4WUODGZC+p/Rn5n3b54tcGYw9n9FFoYvrarnkD+y0vPE5hStqgHXG4oAiWkXgs
	hpCA2hhg59NBCpMoAeyc86ba+31s87wlXwrv5zTGL5qHbLWCcMu
X-Received: by 2002:a17:90a:e70c:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2ef0127597bmr5969988a91.31.1733285694348;
        Tue, 03 Dec 2024 20:14:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmmxQJst2LuugrSZJhqPzCTrbLye21ezDzuZBBWTLDHpaGBRfvTE3sFkECyoe3UpjTjDpNpw==
X-Received: by 2002:a17:90a:e70c:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2ef0127597bmr5969973a91.31.1733285694019;
        Tue, 03 Dec 2024 20:14:54 -0800 (PST)
Received: from localhost ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27050103sm388122a91.41.2024.12.03.20.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:14:53 -0800 (PST)
Date: Wed, 4 Dec 2024 13:14:51 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] virtio_ring: add 'flushed' as an
 argument to virtqueue_reset()
Message-ID: <ub7pbfodhjpubwixxsbxlkiclthp3adbxin7etff5seoxqs5i7@aj3c7tpeirwq>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
 <20241203073025.67065-5-koichiro.den@canonical.com>
 <CACGkMEuUa+6_uaa7H2CSvUnfNzBr-rdoQ+cp8eZD+Ay1CZ=A-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuUa+6_uaa7H2CSvUnfNzBr-rdoQ+cp8eZD+Ay1CZ=A-g@mail.gmail.com>

On Wed, Dec 04, 2024 at 10:49:02AM +0800, Jason Wang wrote:
> On Tue, Dec 3, 2024 at 3:31 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > When virtqueue_reset() has actually recycled all unused buffers,
> > additional work may be required in some cases. Relying solely on its
> > return status is fragile, so introduce a new argument 'flushed' to
> > explicitly indicate whether it has really occurred.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > ---
> >  drivers/net/virtio_net.c     | 6 ++++--
> >  drivers/virtio/virtio_ring.c | 6 +++++-
> >  include/linux/virtio.h       | 3 ++-
> >  3 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0103d7990e44..d5240a03b7d6 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -5695,6 +5695,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
> >                                     struct xsk_buff_pool *pool)
> >  {
> >         int err, qindex;
> > +       bool flushed;
> >
> >         qindex = rq - vi->rq;
> >
> > @@ -5713,7 +5714,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
> >
> >         virtnet_rx_pause(vi, rq);
> >
> > -       err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> > +       err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, &flushed);
> >         if (err) {
> >                 netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
> >
> > @@ -5737,12 +5738,13 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> >                                     struct xsk_buff_pool *pool)
> >  {
> >         int err, qindex;
> > +       bool flushed;
> >
> >         qindex = sq - vi->sq;
> >
> >         virtnet_tx_pause(vi, sq);
> >
> > -       err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> > +       err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, &flushed);
> >         if (err) {
> >                 netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
> >                 pool = NULL;
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 34a068d401ec..b522ef798946 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2828,6 +2828,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> >   * virtqueue_reset - detach and recycle all unused buffers
> >   * @_vq: the struct virtqueue we're talking about.
> >   * @recycle: callback to recycle unused buffers
> > + * @flushed: whether or not unused buffers are all flushed
> >   *
> >   * Caller must ensure we don't call this with other virtqueue operations
> >   * at the same time (except where noted).
> > @@ -2839,14 +2840,17 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> >   * -EPERM: Operation not permitted
> >   */
> >  int virtqueue_reset(struct virtqueue *_vq,
> > -                   void (*recycle)(struct virtqueue *vq, void *buf))
> > +                   void (*recycle)(struct virtqueue *vq, void *buf),
> > +                   bool *flushed)
> >  {
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> >         int err;
> >
> > +       *flushed = false;
> >         err = virtqueue_disable_and_recycle(_vq, recycle);
> >         if (err)
> >                 return err;
> > +       *flushed = true;
> >
> 
> This makes me think if it would be easier if we just find a way to
> reset the tx queue inside virtqueue_disable_and_recycle().
> 
> For example, introducing a recycle_done callback?

It sounds reasonable and much cleaner. I'll prepare and send v3 shortly.
Thanks for the review.

-Koichiro Den

> 
> Thanks
> 

