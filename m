Return-Path: <stable+bounces-194765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46804C5B80D
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 07:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C94324E793D
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3A2EFDAF;
	Fri, 14 Nov 2025 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvmvNdZ0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxwNDyNi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1C2EB5D5
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763101532; cv=none; b=f5xjqgBjKVhdP6pZk3UD9EJMAzdalDBsheZhN9aPV2Cb5EIgb7PvYIkF+zhF4JXhQVFg/yo/LyaVxzDrt36V2TQSkdqp2dWvyibn3Q3Yp33sYOl4LCsC/6OFuZQSZQFDk3vx2RPG92x0DzocstSHr12579iMnZ2GDceXZelt3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763101532; c=relaxed/simple;
	bh=3vKFCQLofr/1zoURho0koJUA0rngLWCIwZTyV7pvcjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEBqkn2hj7I0k0NJcJdX/c0SZXwZ/gZhdC6wo+/EgrmZozNPWk08Y2YAnAJWxIQ/XV18xQ2sX89a2e0lXIwCHsprasw6NB4J6hw9pe8nl89CkJM8B76ICGfqTjBzIgGc90/54pfHzYAlA4NqbBIgGKi615cbX/jDYTqYNtREFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvmvNdZ0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxwNDyNi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763101529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgMHjHM098UEawzFUi7lVEISE+9xrVfyLeIqI26gUB8=;
	b=PvmvNdZ0CIdSlV0r8CLemLki2g4ylhAv0iHalpqgJofn0hwDEqC9Ax7YsK7ZBOTKpJLYDA
	Zl32L/9h0fWcl7CAa5PtnQV/cb8LldHo+3cDnkGu9KW7+UZS57wccRVdtlNSz0z08LkLCF
	PrXoFZYvQJiU+zQCNPEBdgoLjPT1rKI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-olW3sw8AM0WQc4zUUR9zng-1; Fri, 14 Nov 2025 01:25:26 -0500
X-MC-Unique: olW3sw8AM0WQc4zUUR9zng-1
X-Mimecast-MFC-AGG-ID: olW3sw8AM0WQc4zUUR9zng_1763101525
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4777a022d1fso14104185e9.0
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 22:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763101525; x=1763706325; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WgMHjHM098UEawzFUi7lVEISE+9xrVfyLeIqI26gUB8=;
        b=IxwNDyNiMgMLpqx4LGmFIHWTSYmoPCVzIHPOTaJN9WmrveyEfNdzFP9wT+7EUEPYc3
         MqMNtgr/zjukxkSqm0ITcV/KEShAdrzd3iGoTLJ6R6nvfs72snXDkNtLZI8Q+GU3chLR
         tdlkM9dX/FkmyA74gx4WlltGDhWbLIY4jtyvx0uQKq2o/Faa5b23HfIKt1t+/FHMic2A
         Y2nhNRjHLt8xshv9Fy/pTY0lSptIKfDmv0NnPA0HJfn173EYbw+J/VDmq/zyvgjSHjIy
         cyawRPGDn0uMn+WfKgXfERr5cKhUve+hJfX3dsj/qYoKD8cfSox/S9eTopKoipk/yGcf
         x2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763101525; x=1763706325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgMHjHM098UEawzFUi7lVEISE+9xrVfyLeIqI26gUB8=;
        b=jU+W1XTkQWOFeS+W11hxX6Cu4hCCpupheGt9mWC69hUiWU9KWyMPBj9gHHRPiMyWRU
         YJdynV6eLf710/Cu2thHuxaYdWxhOu98IRg9E+5ZRzm8AOtRItZZYPT8fdKqsP9/IWlk
         kTUiZ/XCfMrfC4b4NS9BNpOLETFvufCdxCT08pfpB9EeAYteKSLjC1xRR4uRCqcvHVYP
         6zY8JR51FnbpLpRynBDbtFwbdtG9b39WsQgjMWSk+GuRYuA7IbSqH5ug7dkmBPTPodBp
         z2EnOBh7is4PdFTAELqFoFHuvmz93JO6wkNWXODi87j41myAI91YSIJx4Zx5OCt5E/6g
         JM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmyQ/St7F595ccvzs3RWCVMm40G+Ke3RmyV9g1jC2yw1RDRbFi3XTsXpMrhSH07z/P09MTysA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6ug/jsFAP3e3BJI+sXlSJUoqBACzX0YtyZ7t9BzLO3luCb8U
	eJPkVmdu7gJFbBDkk8JArkZJSuo/veF43NYpgB+aE1A2rFPLA89ZcbZCHz4wNqA57kAum/iW8aP
	DMoinswf/+l/33ZmYQ9/9RNHvhoXzvT/2KWb6gOiNBcqUur1nRSbPSocAbQ==
X-Gm-Gg: ASbGnctIwD3ZTiPe25NTmOydg/3OlOWiOKcj90LnFp9YLkXuAY8T0ByTMofOQj2j3wX
	GFhqGnv8E7NYHApmg86ku3wBKD8D1lJJc8ZrnZ7XgxPNhhF00nyIjFBcHVtSAM4L5gPtoLqn9xZ
	3Vg/r+SIki4YxNAmJJKFQbdd3pBSRS/vpqAqA60mgxrjCLg8qPMFWjAEilGBcCKeWfPPHZ2HzFE
	C0HZ79UISDheh4nkbLU+QyNjLG5Cz9Wq+YzPaAt/MvZ/LMGlF1UIIgS6USag5fTpiwoEG8gjp6n
	IBuXtnwzw6SG3m8SXsxhckJvimpmBmTiigB28Q2qGuyBH+5KKbLHhMPDyXTrTT2KIPb+C4MZuY5
	KSLTSUAhWU7hX985g8/4=
X-Received: by 2002:a05:600c:1f91:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4778fe9aaadmr15340155e9.23.1763101524978;
        Thu, 13 Nov 2025 22:25:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6S93JtbCMSal0KnBjGm2eMz3lOM+4qbxORtWQqZJWiZ7XE1mt0dK8Yd6AKfkCy8ztRoHcLw==
X-Received: by 2002:a05:600c:1f91:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4778fe9aaadmr15339855e9.23.1763101524271;
        Thu, 13 Nov 2025 22:25:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c857311sm77984885e9.8.2025.11.13.22.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 22:25:23 -0800 (PST)
Date: Fri, 14 Nov 2025 01:25:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] vhost: rewind next_avail_head while discarding
 descriptors
Message-ID: <20251114012141-mutt-send-email-mst@kernel.org>
References: <20251113015420.3496-1-jasowang@redhat.com>
 <20251113030230-mutt-send-email-mst@kernel.org>
 <CACGkMEtnihOt=g+zs0gVQ=wnx8_YF_F=QSuLQ4RGWBVuOeFi7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtnihOt=g+zs0gVQ=wnx8_YF_F=QSuLQ4RGWBVuOeFi7w@mail.gmail.com>

On Fri, Nov 14, 2025 at 09:53:12AM +0800, Jason Wang wrote:
> On Thu, Nov 13, 2025 at 4:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 13, 2025 at 09:54:20AM +0800, Jason Wang wrote:
> > > When discarding descriptors with IN_ORDER, we should rewind
> > > next_avail_head otherwise it would run out of sync with
> > > last_avail_idx. This would cause driver to report
> > > "id X is not a head".
> > >
> > > Fixing this by returning the number of descriptors that is used for
> > > each buffer via vhost_get_vq_desc_n() so caller can use the value
> > > while discarding descriptors.
> > >
> > > Fixes: 67a873df0c41 ("vhost: basic in order support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Wow that change really caused a lot of fallout.
> >
> > Thanks for the patch! Yet something to improve:
> >
> >
> > > ---
> > >  drivers/vhost/net.c   | 53 ++++++++++++++++++++++++++-----------------
> > >  drivers/vhost/vhost.c | 43 ++++++++++++++++++++++++-----------
> > >  drivers/vhost/vhost.h |  9 +++++++-
> > >  3 files changed, 70 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index 35ded4330431..8f7f50acb6d6 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -592,14 +592,15 @@ static void vhost_net_busy_poll(struct vhost_net *net,
> > >  static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
> > >                                   struct vhost_net_virtqueue *tnvq,
> > >                                   unsigned int *out_num, unsigned int *in_num,
> > > -                                 struct msghdr *msghdr, bool *busyloop_intr)
> > > +                                 struct msghdr *msghdr, bool *busyloop_intr,
> > > +                                 unsigned int *ndesc)
> > >  {
> > >       struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
> > >       struct vhost_virtqueue *rvq = &rnvq->vq;
> > >       struct vhost_virtqueue *tvq = &tnvq->vq;
> > >
> > > -     int r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> > > -                               out_num, in_num, NULL, NULL);
> > > +     int r = vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> > > +                                 out_num, in_num, NULL, NULL, ndesc);
> > >
> > >       if (r == tvq->num && tvq->busyloop_timeout) {
> > >               /* Flush batched packets first */
> > > @@ -610,8 +611,8 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
> > >
> > >               vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, false);
> > >
> > > -             r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> > > -                                   out_num, in_num, NULL, NULL);
> > > +             r = vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> > > +                                     out_num, in_num, NULL, NULL, ndesc);
> > >       }
> > >
> > >       return r;
> > > @@ -642,12 +643,14 @@ static int get_tx_bufs(struct vhost_net *net,
> > >                      struct vhost_net_virtqueue *nvq,
> > >                      struct msghdr *msg,
> > >                      unsigned int *out, unsigned int *in,
> > > -                    size_t *len, bool *busyloop_intr)
> > > +                    size_t *len, bool *busyloop_intr,
> > > +                    unsigned int *ndesc)
> > >  {
> > >       struct vhost_virtqueue *vq = &nvq->vq;
> > >       int ret;
> > >
> > > -     ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, msg, busyloop_intr);
> > > +     ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, msg,
> > > +                                    busyloop_intr, ndesc);
> > >
> > >       if (ret < 0 || ret == vq->num)
> > >               return ret;
> > > @@ -766,6 +769,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >       int sent_pkts = 0;
> > >       bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> > >       bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> > > +     unsigned int ndesc = 0;
> > >
> > >       do {
> > >               bool busyloop_intr = false;
> > > @@ -774,7 +778,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >                       vhost_tx_batch(net, nvq, sock, &msg);
> > >
> > >               head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
> > > -                                &busyloop_intr);
> > > +                                &busyloop_intr, &ndesc);
> > >               /* On error, stop handling until the next kick. */
> > >               if (unlikely(head < 0))
> > >                       break;
> > > @@ -806,7 +810,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >                               goto done;
> > >                       } else if (unlikely(err != -ENOSPC)) {
> > >                               vhost_tx_batch(net, nvq, sock, &msg);
> > > -                             vhost_discard_vq_desc(vq, 1);
> > > +                             vhost_discard_vq_desc(vq, 1, ndesc);
> > >                               vhost_net_enable_vq(net, vq);
> > >                               break;
> > >                       }
> > > @@ -829,7 +833,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >               err = sock->ops->sendmsg(sock, &msg, len);
> > >               if (unlikely(err < 0)) {
> > >                       if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
> > > -                             vhost_discard_vq_desc(vq, 1);
> > > +                             vhost_discard_vq_desc(vq, 1, ndesc);
> > >                               vhost_net_enable_vq(net, vq);
> > >                               break;
> > >                       }
> > > @@ -868,6 +872,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> > >       int err;
> > >       struct vhost_net_ubuf_ref *ubufs;
> > >       struct ubuf_info_msgzc *ubuf;
> > > +     unsigned int ndesc = 0;
> > >       bool zcopy_used;
> > >       int sent_pkts = 0;
> > >
> > > @@ -879,7 +884,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> > >
> > >               busyloop_intr = false;
> > >               head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
> > > -                                &busyloop_intr);
> > > +                                &busyloop_intr, &ndesc);
> > >               /* On error, stop handling until the next kick. */
> > >               if (unlikely(head < 0))
> > >                       break;
> > > @@ -941,7 +946,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> > >                                       vq->heads[ubuf->desc].len = VHOST_DMA_DONE_LEN;
> > >                       }
> > >                       if (retry) {
> > > -                             vhost_discard_vq_desc(vq, 1);
> > > +                             vhost_discard_vq_desc(vq, 1, ndesc);
> > >                               vhost_net_enable_vq(net, vq);
> > >                               break;
> > >                       }
> > > @@ -1045,11 +1050,12 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
> > >                      unsigned *iovcount,
> > >                      struct vhost_log *log,
> > >                      unsigned *log_num,
> > > -                    unsigned int quota)
> > > +                    unsigned int quota,
> > > +                    unsigned int *ndesc)
> > >  {
> > >       struct vhost_virtqueue *vq = &nvq->vq;
> > >       bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> > > -     unsigned int out, in;
> > > +     unsigned int out, in, desc_num, n = 0;
> > >       int seg = 0;
> > >       int headcount = 0;
> > >       unsigned d;
> > > @@ -1064,9 +1070,9 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
> > >                       r = -ENOBUFS;
> > >                       goto err;
> > >               }
> > > -             r = vhost_get_vq_desc(vq, vq->iov + seg,
> > > -                                   ARRAY_SIZE(vq->iov) - seg, &out,
> > > -                                   &in, log, log_num);
> > > +             r = vhost_get_vq_desc_n(vq, vq->iov + seg,
> > > +                                     ARRAY_SIZE(vq->iov) - seg, &out,
> > > +                                     &in, log, log_num, &desc_num);
> > >               if (unlikely(r < 0))
> > >                       goto err;
> > >
> > > @@ -1093,6 +1099,7 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
> > >               ++headcount;
> > >               datalen -= len;
> > >               seg += in;
> > > +             n += desc_num;
> > >       }
> > >
> > >       *iovcount = seg;
> > > @@ -1113,9 +1120,11 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
> > >               nheads[0] = headcount;
> > >       }
> > >
> > > +     *ndesc = n;
> > > +
> > >       return headcount;
> > >  err:
> > > -     vhost_discard_vq_desc(vq, headcount);
> > > +     vhost_discard_vq_desc(vq, headcount, n);
> >
> > So here ndesc and n are the same, but below in vhost_discard_vq_desc
> > they are different. Fun.
> 
> Not necessarily the same, a buffer could contain more than 1 descriptor.


*ndesc = n kinda guarantees it's the same, no?

> >
> > >       return r;
> > >  }
> > >
> > > @@ -1151,6 +1160,7 @@ static void handle_rx(struct vhost_net *net)
> > >       struct iov_iter fixup;
> > >       __virtio16 num_buffers;
> > >       int recv_pkts = 0;
> > > +     unsigned int ndesc;
> > >
> > >       mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> > >       sock = vhost_vq_get_backend(vq);
> > > @@ -1182,7 +1192,8 @@ static void handle_rx(struct vhost_net *net)
> > >               headcount = get_rx_bufs(nvq, vq->heads + count,
> > >                                       vq->nheads + count,
> > >                                       vhost_len, &in, vq_log, &log,
> > > -                                     likely(mergeable) ? UIO_MAXIOV : 1);
> > > +                                     likely(mergeable) ? UIO_MAXIOV : 1,
> > > +                                     &ndesc);
> > >               /* On error, stop handling until the next kick. */
> > >               if (unlikely(headcount < 0))
> > >                       goto out;
> > > @@ -1228,7 +1239,7 @@ static void handle_rx(struct vhost_net *net)
> > >               if (unlikely(err != sock_len)) {
> > >                       pr_debug("Discarded rx packet: "
> > >                                " len %d, expected %zd\n", err, sock_len);
> > > -                     vhost_discard_vq_desc(vq, headcount);
> > > +                     vhost_discard_vq_desc(vq, headcount, ndesc);
> > >                       continue;
> > >               }
> > >               /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
> > > @@ -1252,7 +1263,7 @@ static void handle_rx(struct vhost_net *net)
> > >                   copy_to_iter(&num_buffers, sizeof num_buffers,
> > >                                &fixup) != sizeof num_buffers) {
> > >                       vq_err(vq, "Failed num_buffers write");
> > > -                     vhost_discard_vq_desc(vq, headcount);
> > > +                     vhost_discard_vq_desc(vq, headcount, ndesc);
> > >                       goto out;
> > >               }
> > >               nvq->done_idx += headcount;
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 8570fdf2e14a..b56568807588 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -2792,18 +2792,11 @@ static int get_indirect(struct vhost_virtqueue *vq,
> > >       return 0;
> > >  }
> > >
> > > -/* This looks in the virtqueue and for the first available buffer, and converts
> > > - * it to an iovec for convenient access.  Since descriptors consist of some
> > > - * number of output then some number of input descriptors, it's actually two
> > > - * iovecs, but we pack them into one and note how many of each there were.
> > > - *
> > > - * This function returns the descriptor number found, or vq->num (which is
> > > - * never a valid descriptor number) if none was found.  A negative code is
> > > - * returned on error. */
> >
> > A new module API with no docs at all is not good.
> > Please add documentation to this one. vhost_get_vq_desc
> > is a subset and could refer to it.
> 
> Fixed.
> 
> >
> > > -int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> > > -                   struct iovec iov[], unsigned int iov_size,
> > > -                   unsigned int *out_num, unsigned int *in_num,
> > > -                   struct vhost_log *log, unsigned int *log_num)
> > > +int vhost_get_vq_desc_n(struct vhost_virtqueue *vq,
> > > +                     struct iovec iov[], unsigned int iov_size,
> > > +                     unsigned int *out_num, unsigned int *in_num,
> > > +                     struct vhost_log *log, unsigned int *log_num,
> > > +                     unsigned int *ndesc)
> >
> > >  {
> > >       bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> > >       struct vring_desc desc;
> > > @@ -2921,16 +2914,40 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> > >       vq->last_avail_idx++;
> > >       vq->next_avail_head += c;
> > >
> > > +     if (ndesc)
> > > +             *ndesc = c;
> > > +
> > >       /* Assume notifications from guest are disabled at this point,
> > >        * if they aren't we would need to update avail_event index. */
> > >       BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
> > >       return head;
> > >  }
> > > +EXPORT_SYMBOL_GPL(vhost_get_vq_desc_n);
> > > +
> > > +/* This looks in the virtqueue and for the first available buffer, and converts
> > > + * it to an iovec for convenient access.  Since descriptors consist of some
> > > + * number of output then some number of input descriptors, it's actually two
> > > + * iovecs, but we pack them into one and note how many of each there were.
> > > + *
> > > + * This function returns the descriptor number found, or vq->num (which is
> > > + * never a valid descriptor number) if none was found.  A negative code is
> > > + * returned on error.
> > > + */
> > > +int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> > > +                   struct iovec iov[], unsigned int iov_size,
> > > +                   unsigned int *out_num, unsigned int *in_num,
> > > +                   struct vhost_log *log, unsigned int *log_num)
> > > +{
> > > +     return vhost_get_vq_desc_n(vq, iov, iov_size, out_num, in_num,
> > > +                                log, log_num, NULL);
> > > +}
> > >  EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
> > >
> > >  /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
> > > -void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
> > > +void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n,
> > > +                        unsigned int ndesc)
> >
> > ndesc is number of descriptors? And n is what, in that case?
> 
> The semantic of n is not changed which is the number of buffers, ndesc
> is the number of descriptors.

History is not that relevant. To make the core readable pls
change the names to readable ones.

Specifically n is really nbufs, maybe?




> >
> >
> > >  {
> > > +     vq->next_avail_head -= ndesc;
> > >       vq->last_avail_idx -= n;
> > >  }
> > >  EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
> > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > index 621a6d9a8791..69a39540df3d 100644
> > > --- a/drivers/vhost/vhost.h
> > > +++ b/drivers/vhost/vhost.h
> > > @@ -230,7 +230,14 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
> > >                     struct iovec iov[], unsigned int iov_size,
> > >                     unsigned int *out_num, unsigned int *in_num,
> > >                     struct vhost_log *log, unsigned int *log_num);
> > > -void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
> > > +
> > > +int vhost_get_vq_desc_n(struct vhost_virtqueue *vq,
> > > +                     struct iovec iov[], unsigned int iov_size,
> > > +                     unsigned int *out_num, unsigned int *in_num,
> > > +                     struct vhost_log *log, unsigned int *log_num,
> > > +                     unsigned int *ndesc);
> > > +
> > > +void vhost_discard_vq_desc(struct vhost_virtqueue *, int n, unsigned int ndesc);
> > >
> > >  bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
> > >  bool vhost_vq_has_work(struct vhost_virtqueue *vq);
> > > --
> > > 2.31.1
> >
> 
> Thanks


