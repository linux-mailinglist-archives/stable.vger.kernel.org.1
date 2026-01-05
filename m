Return-Path: <stable+bounces-204920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E615BCF588D
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2173B30B6C1F
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5777C2D0606;
	Mon,  5 Jan 2026 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1310ei0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtPDQXch"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18725783A
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767645348; cv=none; b=OROR0uQ9vsokkfu3/klTVe9+G+MPIcAJb//7R+s5KLikHX5mK8S4OXAitu/DXCrDlXwsMlxpeTLw0f8lTd8bOoaIG2lRV3UYZkaHSG37jsJoK8fTpyo9SCUx+UYzNOQTSq91ThLMF7XVmhlTGCQ/IiHVUTIh64EbZ+MvM1ITeng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767645348; c=relaxed/simple;
	bh=2LuBmyR3IekF0SZOB74Fmvk3VLKqRwUshOum38QH6+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neP32mH0t4kss1Mrw/Y2ACM+zcWyFIZlPkeIxRA9oTv3L0T5Znc4QF9WL3YvC4IHSsSu6XcNxbFRCFIMiT+bpAvR6iHyaQ5f2TLUQ4/Lc22uSxONvnrQoQKo39lZ7cj1ijLXOhgDZL8dlifAsJjRcnBQ8z1kbsr3asyFa5Iq+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1310ei0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtPDQXch; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767645345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbqBHou7Fg2DFd9GjNYOzj37gfeSm09wtoslHTPigQs=;
	b=c1310ei0vxXOwcfwQlBOcqAS7Oa2P0jsN8heNGJEuoC1+qNifypByS3v9hJhH9YjH67y2M
	si6ejZCzO1Cq1bovjXgC799Ox3dDrMwoyn7WT/fBONql4idcPBdCJr55MsG6FHIzl/hZYc
	xz+2OzgaAWGcr+QH+D4GK0lfcI/+Dp4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-OL83nYoNPSOfgeOOSMQajQ-1; Mon, 05 Jan 2026 15:35:43 -0500
X-MC-Unique: OL83nYoNPSOfgeOOSMQajQ-1
X-Mimecast-MFC-AGG-ID: OL83nYoNPSOfgeOOSMQajQ_1767645342
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3ffa98fcso1936725e9.3
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 12:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767645342; x=1768250142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TbqBHou7Fg2DFd9GjNYOzj37gfeSm09wtoslHTPigQs=;
        b=YtPDQXch1eHmvsjFEmeopU+w9842V10yPmIyjlv6HSljCYAhP76gdzQ0nmKv1PtFJP
         Q1FERpsp7DpKqOSiB0W6SIk771naePqdpnzqLm0ilMseZWzoacG+uz0e24n/UT3LaGZ4
         rM3fFbk+kDmBDdf5+Zw8+fSCdIGn+zMI0FQ0RH0otXB9VlgDQAZRIUHXzJBwgzoPPiN/
         jmIz3I2luUMfZqzxK9BBFzyammOjHK+YgckBphgaZjSNO8uSumXj95z9iqaCqzZVI1bj
         UxwSu0Lco1KZlcmS197o+DmcDakJPsimzRK5KykQQNUwVPfh8KxNUFTPkLTiv92k+G8b
         vuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767645342; x=1768250142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbqBHou7Fg2DFd9GjNYOzj37gfeSm09wtoslHTPigQs=;
        b=QpRIMvi507jqFpeVBFzs4SNjXWnG9tpY/QBn6ahvhArRXjX7GVJ778/xZBfWuxMuZa
         pnRi/aHae84iDhV9GzskaW3gyVK88qUxSDciZkNp4mAxjH7TiIJi6KiM3/CTRA2LIqA2
         I9bJN6eRB6HPekP1kDUDIkCw0UB5PmLo+R2n8vOTPslTqdndgfmCSsIM+WyrSo+So7im
         eK2V0xiSmIBIJr6jbk6T080by43dlgyYtUvoAb9zXpA/Tnob3eJEa4oGvh8UIMyF/SpH
         c8/B+RAfLZPCbzQQix3Il0YiewbudoMG0j9oS/HqAYSRkVtJ+xKLtqxvrbV3ltd0qn6D
         v79Q==
X-Forwarded-Encrypted: i=1; AJvYcCXw6UIlqVTSrdaDrk+qGg8t2hz37gujitbnSGsEDuVGRbnFwVi+9SHuSfgoufu259roL8YdvzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1svVN1EPgNt1h34MhQU2pSd9f/SaQNe4bOIC7P9FINJ86r9jb
	ONuVsinxOat3PjUCPmyFJEOx3BFOdfwp23U3G0bTpuZuIGGwT1JiW+jA109jK/Z/8/Z2KO8JlYX
	C3NMyq+wfU1QXXJSwzdJlFQQFFGwl5LfK5RayYPCQASw0OL8O5RKIrKzuLQ==
X-Gm-Gg: AY/fxX71lWKCeWrC/DPVt4JKe5CSMSht+lT5Gw+peAo3V9cqNveVhoFri6HSi7V7afU
	26lFUZjbq5BiDWKrbRHM3gUPk7irekln6S6+iGx+m8DFJJ+wmMJdKp9kxEIevDgvAbuDfYqUzSP
	3pICMgK7/U5Xr82fj94VMk07gos9hCcRSuBD3n64sdjIIpTvogSuKKbdfL7rLD1OPJnD5oheqjk
	y+vbjfxN2S6oIp9T0821pE2XliDm26eE8lxeDudSDvNEFkn9lu3a9OJW6B8Ft7Xs3BZlvr87hxs
	B4nGaE/O/l1Hn855LFYQ+ee7jtIOvYVDELN0XGwrozBEpr+3IeD7DeZ7VB0THfA9w3Ide6RGpN/
	Z7FNatTAcmt/VGqRetS6FP4yBpolEAF5Q9Q==
X-Received: by 2002:a05:600c:a41:b0:477:b0b8:4dd0 with SMTP id 5b1f17b1804b1-47d7f0983afmr7791565e9.17.1767645342120;
        Mon, 05 Jan 2026 12:35:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzVEuqv/rOu6OKsLwc7zC6R9Z09rc5wgjW8+zv7YqDShun20oUmu8UtpvBcXW5FX2Wa6r68g==
X-Received: by 2002:a05:600c:a41:b0:477:b0b8:4dd0 with SMTP id 5b1f17b1804b1-47d7f0983afmr7791165e9.17.1767645341569;
        Mon, 05 Jan 2026 12:35:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f66cd6bsm5144055e9.15.2026.01.05.12.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 12:35:41 -0800 (PST)
Date: Mon, 5 Jan 2026 15:35:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
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
Message-ID: <20260105153517-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
 <CACGkMEs9wCM8s4_r1HCQGj9mUDdTF+BqkF0rse+dzB3USprhMA@mail.gmail.com>
 <6bac1895-d4a3-4e98-8f39-358fa14102db@gmail.com>
 <20260104085846-mutt-send-email-mst@kernel.org>
 <f4ac3940-d99c-4f63-bab3-cc68731fc9f1@gmail.com>
 <20260104100912-mutt-send-email-mst@kernel.org>
 <a20950fe-455a-4c7b-b132-e8090e8d0c0f@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a20950fe-455a-4c7b-b132-e8090e8d0c0f@gmail.com>

On Mon, Jan 05, 2026 at 10:03:22PM +0700, Bui Quang Minh wrote:
> On 1/4/26 22:12, Michael S. Tsirkin wrote:
> > On Sun, Jan 04, 2026 at 09:54:30PM +0700, Bui Quang Minh wrote:
> > > On 1/4/26 21:03, Michael S. Tsirkin wrote:
> > > > On Sun, Jan 04, 2026 at 03:34:52PM +0700, Bui Quang Minh wrote:
> > > > > On 1/4/26 13:09, Jason Wang wrote:
> > > > > > On Fri, Jan 2, 2026 at 11:20 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> > > > > > > When we fail to refill the receive buffers, we schedule a delayed worker
> > > > > > > to retry later. However, this worker creates some concurrency issues
> > > > > > > such as races and deadlocks. To simplify the logic and avoid further
> > > > > > > problems, we will instead retry refilling in the next NAPI poll.
> > > > > > > 
> > > > > > > Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > > > > > > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > > > > > > Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > > > > > ---
> > > > > > >     drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
> > > > > > >     1 file changed, 30 insertions(+), 25 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > index 1bb3aeca66c6..ac514c9383ae 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
> > > > > > >     }
> > > > > > > 
> > > > > > >     static int virtnet_receive(struct receive_queue *rq, int budget,
> > > > > > > -                          unsigned int *xdp_xmit)
> > > > > > > +                          unsigned int *xdp_xmit, bool *retry_refill)
> > > > > > >     {
> > > > > > >            struct virtnet_info *vi = rq->vq->vdev->priv;
> > > > > > >            struct virtnet_rq_stats stats = {};
> > > > > > > @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> > > > > > >                    packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
> > > > > > > 
> > > > > > >            if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > > > > > > -               if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > > > > > > -                       spin_lock(&vi->refill_lock);
> > > > > > > -                       if (vi->refill_enabled)
> > > > > > > -                               schedule_delayed_work(&vi->refill, 0);
> > > > > > > -                       spin_unlock(&vi->refill_lock);
> > > > > > > -               }
> > > > > > > +               if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > > > > > > +                       *retry_refill = true;
> > > > > > >            }
> > > > > > > 
> > > > > > >            u64_stats_set(&stats.packets, packets);
> > > > > > > @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > > > > > >            struct send_queue *sq;
> > > > > > >            unsigned int received;
> > > > > > >            unsigned int xdp_xmit = 0;
> > > > > > > -       bool napi_complete;
> > > > > > > +       bool napi_complete, retry_refill = false;
> > > > > > > 
> > > > > > >            virtnet_poll_cleantx(rq, budget);
> > > > > > > 
> > > > > > > -       received = virtnet_receive(rq, budget, &xdp_xmit);
> > > > > > > +       received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
> > > > > > I think we can simply let virtnet_receive() to return the budget when
> > > > > > reill fails.
> > > > > That makes sense, I'll change it.
> > > > > 
> > > > > > >            rq->packets_in_napi += received;
> > > > > > > 
> > > > > > >            if (xdp_xmit & VIRTIO_XDP_REDIR)
> > > > > > >                    xdp_do_flush();
> > > > > > > 
> > > > > > >            /* Out of packets? */
> > > > > > > -       if (received < budget) {
> > > > > > > +       if (received < budget && !retry_refill) {
> > > > > > >                    napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
> > > > > > >                    /* Intentionally not taking dim_lock here. This may result in a
> > > > > > >                     * spurious net_dim call. But if that happens virtnet_rx_dim_work
> > > > > > > @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > > > > > >                    virtnet_xdp_put_sq(vi, sq);
> > > > > > >            }
> > > > > > > 
> > > > > > > -       return received;
> > > > > > > +       return retry_refill ? budget : received;
> > > > > > >     }
> > > > > > > 
> > > > > > >     static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > > > > > @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
> > > > > > > 
> > > > > > >            for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > > > >                    if (i < vi->curr_queue_pairs)
> > > > > > > -                       /* Make sure we have some buffers: if oom use wq. */
> > > > > > > -                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > > > > > > -                               schedule_delayed_work(&vi->refill, 0);
> > > > > > > +                       /* If this fails, we will retry later in
> > > > > > > +                        * NAPI poll, which is scheduled in the below
> > > > > > > +                        * virtnet_enable_queue_pair
> > > > > > > +                        */
> > > > > > > +                       try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> > > > > > Consider NAPI will be eventually scheduled, I wonder if it's still
> > > > > > worth to refill here.
> > > > > With GFP_KERNEL here, I think it's more likely to succeed than GFP_ATOMIC in
> > > > > NAPI poll. Another small benefit is that the actual packet can happen
> > > > > earlier. In case the receive buffer is empty and we don't refill here, the
> > > > > #1 NAPI poll refill the buffer and the #2 NAPI poll can receive packets. The
> > > > > #2 NAPI poll is scheduled in the interrupt handler because the #1 NAPI poll
> > > > > will deschedule the NAPI and enable the device interrupt. In case we
> > > > > successfully refill here, the #1 NAPI poll can receive packets right away.
> > > > > 
> > > > Right. But I think this is a part that needs elucidating, not
> > > > error handling.
> > > > 
> > > > /* Pre-fill rq agressively, to make sure we are ready to get packets
> > > >    * immediately.
> > > >    * */
> > > > 
> > > > > > >                    err = virtnet_enable_queue_pair(vi, i);
> > > > > > >                    if (err < 0)
> > > > > > > @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
> > > > > > >                                    bool refill)
> > > > > > >     {
> > > > > > >            bool running = netif_running(vi->dev);
> > > > > > > -       bool schedule_refill = false;
> > > > > > > 
> > > > > > > -       if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> > > > > > > -               schedule_refill = true;
> > > > > > > +       if (refill)
> > > > > > > +               /* If this fails, we will retry later in NAPI poll, which is
> > > > > > > +                * scheduled in the below virtnet_napi_enable
> > > > > > > +                */
> > > > > > > +               try_fill_recv(vi, rq, GFP_KERNEL);
> > > > > > and here.
> > > > > > 
> > > > > > > +
> > > > > > >            if (running)
> > > > > > >                    virtnet_napi_enable(rq);
> > > > here the part that isn't clear is why are we refilling if !running
> > > > and what handles failures in that case.
> > > You are right, we should not refill when !running. I'll move the if (refill)
> > > inside the if (running).
> > Sounds like a helper that does refill+virtnet_napi_enable
> > would be in order then?  fill_recv_aggressively(vi, rq) ?
> 
> I think the helper can make the code a little more complicated. In
> virtnet_open(), the RX NAPI is enabled in virtnet_enable_queue_pair() so we
> need to add a flag like enable_rx. Then change the virtnet_open() to
> 
>     for (i = 0; i < vi->max_queue_pairs; i++) {
>         if (i < vi->curr_queue_pairs) {
>             fill_recv_aggressively(vi, rq);
>             err = virtnet_enable_queue_pair(..., enable_rx = false);
>             if (err < 0)
>                 goto err_enable_qp;
>         } else {
>             err = virtnet_enable_queue_pair(..., enable_rx = true);
>             if (err < 0)
>                 goto err_enable_qp;
>         }
> 
>     }

ok then, feel free to ignore this suggestion.

> > 
> > > > > > > -
> > > > > > > -       if (schedule_refill)
> > > > > > > -               schedule_delayed_work(&vi->refill, 0);
> > > > > > >     }
> > > > > > > 
> > > > > > >     static void virtnet_rx_resume_all(struct virtnet_info *vi)
> > > > > > > @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> > > > > > >            struct virtio_net_rss_config_trailer old_rss_trailer;
> > > > > > >            struct net_device *dev = vi->dev;
> > > > > > >            struct scatterlist sg;
> > > > > > > +       int i;
> > > > > > > 
> > > > > > >            if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
> > > > > > >                    return 0;
> > > > > > > @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> > > > > > >            }
> > > > > > >     succ:
> > > > > > >            vi->curr_queue_pairs = queue_pairs;
> > > > > > > -       /* virtnet_open() will refill when device is going to up. */
> > > > > > > -       spin_lock_bh(&vi->refill_lock);
> > > > > > > -       if (dev->flags & IFF_UP && vi->refill_enabled)
> > > > > > > -               schedule_delayed_work(&vi->refill, 0);
> > > > > > > -       spin_unlock_bh(&vi->refill_lock);
> > > > > > > +       if (dev->flags & IFF_UP) {
> > > > > > > +               /* Let the NAPI poll refill the receive buffer for us. We can't
> > > > > > > +                * safely call try_fill_recv() here because the NAPI might be
> > > > > > > +                * enabled already.
> > > > > > > +                */
> > > > > > > +               local_bh_disable();
> > > > > > > +               for (i = 0; i < vi->curr_queue_pairs; i++)
> > > > > > > +                       virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> > > > > > > +
> > > > > > > +               local_bh_enable();
> > > > > > > +       }
> > > > > > > 
> > > > > > >            return 0;
> > > > > > >     }
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > > 
> > > > > > Thanks
> > > > > > 
> > > > > Thanks,
> > > > > Quang Minh.


