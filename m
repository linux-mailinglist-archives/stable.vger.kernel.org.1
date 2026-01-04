Return-Path: <stable+bounces-204561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87120CF0FE2
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 14:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5CA1301D640
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2BB30648C;
	Sun,  4 Jan 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LF6XlyAm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkbtXYVV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F742285CB4
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767533111; cv=none; b=IMeDyrxXbzfVKWn0xBFajYulorLN4UJZtxoOk1H46zft9mRC0QcBNZyk9+RyYx1Nmc6jMAuoZa8X4KcAtGb7PilMxX394vnXxxLkeUZeOmXAZ9MyY9MJoGbxVzoxEctzA1dxs5WLXhJ2CAEzQX/5+Kbo7AMuL5IZYWgvx4CS+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767533111; c=relaxed/simple;
	bh=pt4Ft0f8zBb0BXPfk3zfpDj8EDt8GHhqcWmJHb6Iu9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/fFRCQR2mW0kdr4WqTmqw5+LncxWNcbq9p++i3o96tMcexgcitBlRm1yFM9J5AshZ0bu41mIlKBCSrimAl/J4qvikTU3eTeBsjl/5CCDKv0lfXZD0uAPlH//c1DFN22yU26itpsE99sgAYtIB6we5nGLcHVVpS/SEGa5c8kyzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LF6XlyAm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkbtXYVV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767533108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8YPdMudVAK8KArltJ+4J4SS6CmP1ZCJFN1CviZOebrs=;
	b=LF6XlyAmz8FYA6DFTpkXjqKEbnXve89zVfAE1eO9om438cRtKbEz6nCBWOC1mNvXaP6v38
	YZjPDY+X60l86gVI2AffpUx8UGGtynBYe2QnZZyls3WOjF9l6R+NFKct/TwG0AWHcIa4mo
	fzlq8W6hlICRj3+oiiOkilQ9v+6/4bU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-Xa2OwE_JNxymOkWMKlRC4Q-1; Sun, 04 Jan 2026 08:25:07 -0500
X-MC-Unique: Xa2OwE_JNxymOkWMKlRC4Q-1
X-Mimecast-MFC-AGG-ID: Xa2OwE_JNxymOkWMKlRC4Q_1767533106
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so112206525e9.0
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 05:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767533106; x=1768137906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8YPdMudVAK8KArltJ+4J4SS6CmP1ZCJFN1CviZOebrs=;
        b=NkbtXYVVt7msccI09r01GyphfVa8Y47aXfICA5NoHdlWr/0UFH8nakjWKvTPMToZ+L
         HBl4Ewd81Ai3SsJvPzlftXIj1l/0D5kaE/2WypAyTV3RweVzXZmc0cDV96cHqfBl/pRz
         LTFrTSbm8jJI0FpI5gUJ7PmRmT7zZhTtyKRFIVXvT2glqN//33r3UEkgUTPWiNZAlN2J
         NWLPeIfV/tiRruE+krJXyB6S1TBKlyJhfotO5QglsweMQDCc6BomB5O3fOvolLu9469q
         EM4OZW+FQu0lIBrhnvYQ8PMiTZuPK+IDmHKoee+aO9aoZtKrRrSEjVYZSxwgNW13JXm6
         Daiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767533106; x=1768137906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YPdMudVAK8KArltJ+4J4SS6CmP1ZCJFN1CviZOebrs=;
        b=JB3CNl26zuS8yb2bekus7F9/F6DF3vh97vaaWX5OZkwO4hT8qXQbr6ng2r+s3g/cEg
         z70Xf5ll6d+HyUyeomdIRPf9QkqPwHEdsc4Xl7E1duJqRZBFg7PRiuKQxQDAuNUTuiB/
         eGxKxY2xGHIMFGRBHfxhgWS86wuMBjDcCwQJrAKm2bsrj66cvB5cjk9Ojl7Bh5bqg8cl
         Svjqd581HhZYQxSGsfOK9vWx5MeyectJaaXZHbPvnOhPk68pXw0p4TEoc3j/8GGo74gy
         VOylihq8ZNOPbC1XH32h3Osim9HYW7ZhsTgkTvR4spOgwnFkZtb+Rcmyt3soztiVpH4i
         v1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpGEL2krxg006vhzv+fLIqocMZhHLnAllb6EftOd2pgh2RfP8j/5akZUyftl1EbtiImkFvcLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSJikVvX3STBL2dPkf+4qUqDlDkxNHjVOt4wh5mPjArhcXrpC
	79Z2Sabe9PVx29p2DO+LpZAgEdy5xJvcawhKT+SHd97pzioPEEsosweQ5mdik0yQQSOPos+LD6I
	VWojCrEQW/cfjr8c6jAAStaCLYFPE+t/eh9OdV/94+B+CGfkHNENmSnzrdA==
X-Gm-Gg: AY/fxX5adYFQN6TqjnfIVx9h1bBflqBWgJtm0cHCvT1g4kTSbTACRXsEKCWLMrhs6Tn
	DAwuYj7dDhoW/KB4tqMJm8fto9ZA1955h9sR3jupN6dIrePnZ6lbPVgIGuX17ZQ4vbpRVKFVT/8
	TSCpPmnv6DHHOUEMV0Zd/bYC2ymbJ7lt9IP4T1zymq+X2XBASZ8cXmWzzoz9wAm4qBxg7GZakFJ
	o97RBcmRedpJcn+LEsJgIdKSEcgedNL1nsbZAeTw1j6oU94HQpNO9Ui7SEJrnMUUwnhi1u2+3wq
	hariFXSAf18v8EX+gRIWSrKEp+gT1eWhh1+39Lkv7iVs/yeqxGOr7AEvhEcS3lt0TwJEDq/mF2e
	EeD57dXfGUCsXZd9h5Y82mpKgOGUzwc9Xxg==
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d19566f0dmr586056925e9.13.1767533106089;
        Sun, 04 Jan 2026 05:25:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9n2IXegpY2a6njEOIdjuU/rWiMWOsDThZn7SfjrxGhffkfgmpIMOugjNkPPojtCWvEKN+gg==
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d19566f0dmr586056585e9.13.1767533105585;
        Sun, 04 Jan 2026 05:25:05 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f6asm95868255e9.6.2026.01.04.05.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 05:25:05 -0800 (PST)
Date: Sun, 4 Jan 2026 08:25:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260104082446-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
 <CACGkMEs9wCM8s4_r1HCQGj9mUDdTF+BqkF0rse+dzB3USprhMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs9wCM8s4_r1HCQGj9mUDdTF+BqkF0rse+dzB3USprhMA@mail.gmail.com>

On Sun, Jan 04, 2026 at 02:09:06PM +0800, Jason Wang wrote:
> On Fri, Jan 2, 2026 at 11:20 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> >
> > When we fail to refill the receive buffers, we schedule a delayed worker
> > to retry later. However, this worker creates some concurrency issues
> > such as races and deadlocks. To simplify the logic and avoid further
> > problems, we will instead retry refilling in the next NAPI poll.
> >
> > Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> > Cc: stable@vger.kernel.org
> > Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
> >  1 file changed, 30 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1bb3aeca66c6..ac514c9383ae 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
> >  }
> >
> >  static int virtnet_receive(struct receive_queue *rq, int budget,
> > -                          unsigned int *xdp_xmit)
> > +                          unsigned int *xdp_xmit, bool *retry_refill)
> >  {
> >         struct virtnet_info *vi = rq->vq->vdev->priv;
> >         struct virtnet_rq_stats stats = {};
> > @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> >                 packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
> >
> >         if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > -               if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > -                       spin_lock(&vi->refill_lock);
> > -                       if (vi->refill_enabled)
> > -                               schedule_delayed_work(&vi->refill, 0);
> > -                       spin_unlock(&vi->refill_lock);
> > -               }
> > +               if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > +                       *retry_refill = true;
> >         }
> >
> >         u64_stats_set(&stats.packets, packets);
> > @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> >         struct send_queue *sq;
> >         unsigned int received;
> >         unsigned int xdp_xmit = 0;
> > -       bool napi_complete;
> > +       bool napi_complete, retry_refill = false;
> >
> >         virtnet_poll_cleantx(rq, budget);
> >
> > -       received = virtnet_receive(rq, budget, &xdp_xmit);
> > +       received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
> 
> I think we can simply let virtnet_receive() to return the budget when
> reill fails.

Great idea.

> >         rq->packets_in_napi += received;
> >
> >         if (xdp_xmit & VIRTIO_XDP_REDIR)
> >                 xdp_do_flush();
> >
> >         /* Out of packets? */
> > -       if (received < budget) {
> > +       if (received < budget && !retry_refill) {
> >                 napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
> >                 /* Intentionally not taking dim_lock here. This may result in a
> >                  * spurious net_dim call. But if that happens virtnet_rx_dim_work
> > @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> >                 virtnet_xdp_put_sq(vi, sq);
> >         }
> >
> > -       return received;
> > +       return retry_refill ? budget : received;
> >  }
> >
> >  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> > @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
> >
> >         for (i = 0; i < vi->max_queue_pairs; i++) {
> >                 if (i < vi->curr_queue_pairs)
> > -                       /* Make sure we have some buffers: if oom use wq. */
> > -                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > -                               schedule_delayed_work(&vi->refill, 0);
> > +                       /* If this fails, we will retry later in
> > +                        * NAPI poll, which is scheduled in the below
> > +                        * virtnet_enable_queue_pair
> > +                        */
> > +                       try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> 
> Consider NAPI will be eventually scheduled, I wonder if it's still
> worth to refill here.
> 
> >
> >                 err = virtnet_enable_queue_pair(vi, i);
> >                 if (err < 0)
> > @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
> >                                 bool refill)
> >  {
> >         bool running = netif_running(vi->dev);
> > -       bool schedule_refill = false;
> >
> > -       if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> > -               schedule_refill = true;
> > +       if (refill)
> > +               /* If this fails, we will retry later in NAPI poll, which is
> > +                * scheduled in the below virtnet_napi_enable
> > +                */
> > +               try_fill_recv(vi, rq, GFP_KERNEL);
> 
> and here.
> 
> > +
> >         if (running)
> >                 virtnet_napi_enable(rq);
> > -
> > -       if (schedule_refill)
> > -               schedule_delayed_work(&vi->refill, 0);
> >  }
> >
> >  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> > @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> >         struct virtio_net_rss_config_trailer old_rss_trailer;
> >         struct net_device *dev = vi->dev;
> >         struct scatterlist sg;
> > +       int i;
> >
> >         if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
> >                 return 0;
> > @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> >         }
> >  succ:
> >         vi->curr_queue_pairs = queue_pairs;
> > -       /* virtnet_open() will refill when device is going to up. */
> > -       spin_lock_bh(&vi->refill_lock);
> > -       if (dev->flags & IFF_UP && vi->refill_enabled)
> > -               schedule_delayed_work(&vi->refill, 0);
> > -       spin_unlock_bh(&vi->refill_lock);
> > +       if (dev->flags & IFF_UP) {
> > +               /* Let the NAPI poll refill the receive buffer for us. We can't
> > +                * safely call try_fill_recv() here because the NAPI might be
> > +                * enabled already.
> > +                */
> > +               local_bh_disable();
> > +               for (i = 0; i < vi->curr_queue_pairs; i++)
> > +                       virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> > +
> > +               local_bh_enable();
> > +       }
> >
> >         return 0;
> >  }
> > --
> > 2.43.0
> >
> 
> Thanks


