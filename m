Return-Path: <stable+bounces-204520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A658CEF84B
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 01:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0DA630198B4
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 00:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEEB217F33;
	Sat,  3 Jan 2026 00:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EM6irS3i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjdvncfR"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CE46A33B
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399373; cv=none; b=o1J0BwadGSJiPMapoEST0tdbrK3VUIxed9sjsX0wKseab3JxA9I9+8qNXtVC3ihYm84+1PErwqVd7AimfRp+aMDTb5utZO/7y1gHmby5LHBHJnYPwu3exRi4sxozTD5ECwEpCcRkbLsEEVlpwnnIQ8RUirqiEkoNIek8cqtEM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399373; c=relaxed/simple;
	bh=oeixh7OIs8mUJmcLOGI3IzkhbDJiXpGDI0HEiz+o0bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNB991gG+sBJTIAE25JepMRNa9Qx574GV4zeDIlmBVPOdiARfL+qy5ovg9kYuhrZoMIvdVLATVxbl2UtxuFAxXQq9v65aWMnbmndyDVVIxepbNG40nncQJzH2hH6IRDilG/iroa9zIs05r3cDLc2ieGXfDIn95x6u9iiQQ+3p2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EM6irS3i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjdvncfR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767399370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgmwNMSPn56V/BSylDuVjsVQwHfchpHkar4n4cWE59k=;
	b=EM6irS3iUM7UDrBn37KOXIsVKJq5mgZlvIqOIeoESyQKczlnfdA88fVjVa2S5+Bq0MgG1V
	2nAJEo2s9svwpgLJA6mQbvLtwim7kaEJiflEcdcGv+jmkM/opzQxnDTjSbOmNrl0CEz3Lo
	by/MxqHY5FKAsoET23VLw31ili4BqlM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-IGSkkRG2OC-KnOOwStzJYw-1; Fri, 02 Jan 2026 19:16:07 -0500
X-MC-Unique: IGSkkRG2OC-KnOOwStzJYw-1
X-Mimecast-MFC-AGG-ID: IGSkkRG2OC-KnOOwStzJYw_1767399366
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f5dso29205205e9.2
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 16:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767399366; x=1768004166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LgmwNMSPn56V/BSylDuVjsVQwHfchpHkar4n4cWE59k=;
        b=WjdvncfRf5n53SHe0OsSm2VkH9cRfVBUFmyxvQhRrV+xSedquWUIcDC5w9zii5N/Ti
         M2i6hbeIDYAyObE4y4EZhdVKA7oqmWLjDAC8elekvz/cHSlXlC5hneLbttt65jj7ATYB
         XFRT/z41YRYs6ftgPgz9I+vA3iMZtKg3huzQMRcHtagOWGvtbQsDWtpOhwlydOYVpKYd
         keWe+UvRsyTsD8Zbw2GpiOiVSrxSXjE2F3NCmnGFKLSjZXjz0Hesu3SSLFZDEGVAnZOP
         WvdTeSq8zE6NeSeIBHmD5myiujVBDKsOrWOB3MmpRd2L8cf1wxKKkRMrWuc5bk2h6wih
         DZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767399366; x=1768004166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgmwNMSPn56V/BSylDuVjsVQwHfchpHkar4n4cWE59k=;
        b=DlwhZs5/yBuGn8Fd39QFJtglNV7ND45uQOl2vSLO7mvi35haP7mh6z0ZlyQkzJst7G
         ax+au9IaUajVUxgBRil3E0LW3j4oetREOU0s+WsFj/N2yw167kOl/YctBKdm8O+pgLIq
         RuY4ZuzAqXayLV8ZJrJDLuSNr3L6bG9Fa9+t9IeMN6dY3gk7hf4aD7IdTXcZT+GupfSj
         +ImQOyZdE7lqHjMQJv/AzJ03YOG0dFOCRxdGVhaFpfgu/QvDU7Qe9TeibXKgmUcljoVz
         /CYY4XzPWTnCPPG5wfHIm7MX8qwVNYJUVC0yOZ45/vTKEJPZWc3Y7ocO9lxW1s/oQOv4
         VOkg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ASJ1rL38qq3zdzWUf5hX58CSRxoHZU424LaREvMufCaYkRNgMgE4eZpqMBNPNMlqVrD6AB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHjkIDWXV37du4Q80YmaDuN2D1snMNFecDaFd3uG83zaxPAjH
	1ocbWo4xWFoHJ79+dlM50cc+8gRX3MYfvBqITJFqbw9Ilb2MG7jXGPyV7OZHGRd5O2Lsze0328i
	pOFc1mtlCmS1Q0qCco6DmEoPYHl9ltJMtBPlTWbeX+oPJyqKjtfovENj2/g==
X-Gm-Gg: AY/fxX7fwKAQoShN+SwZXIOORVZjqUQ66v9ClzJ5101yi+jkftNfKMiv1fqC/rmIu0S
	yRglgz4v3kgD0RjVIatlm24NXxDH3YN5JaPsbXceMYmIFgAUSiBPJHw0szvc8kLi7I2xt5PfiV8
	YsvpAfQcKWSUiJheuCKsEhQyUDeiCRpfyxLbykXcnGuojUk4Bop/tYk/NqA3m9DaoioItuApz9h
	Fs27wnSqbw7C8hzNy4peJvAyMoCHOZqOC5O5AW5axPqSQEHG9kPcpgDO2r/LQ+CtikDxcmXiHc6
	syikNW+00XgML0IIewhTgmIcKaHeIA6HqB1HhiiEl0GKfjxXu5Pac12ueccFv1ACrU6LmGu69y/
	XOqwEOg==
X-Received: by 2002:a05:6000:2909:b0:430:f97a:6f43 with SMTP id ffacd0b85a97d-4324e709710mr66217948f8f.53.1767399365827;
        Fri, 02 Jan 2026 16:16:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9aB7zkIrFTuuZ7xl2WvyXAoAEavadLOe7DzHD1qTfvtUGbDJjbs2g2P+Yqoa6knBaVtt76Q==
X-Received: by 2002:a05:6000:2909:b0:430:f97a:6f43 with SMTP id ffacd0b85a97d-4324e709710mr66217916f8f.53.1767399365267;
        Fri, 02 Jan 2026 16:16:05 -0800 (PST)
Received: from redhat.com ([2a06:c701:73d7:4800:ba30:1c4a:380d:b509])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm87134943f8f.35.2026.01.02.16.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:16:04 -0800 (PST)
Date: Fri, 2 Jan 2026 19:16:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20260102190935-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102152023.10773-2-minhquangbui99@gmail.com>

On Fri, Jan 02, 2026 at 10:20:21PM +0700, Bui Quang Minh wrote:
> When we fail to refill the receive buffers, we schedule a delayed worker
> to retry later. However, this worker creates some concurrency issues
> such as races and deadlocks.

include at least one example here, pls.

> To simplify the logic and avoid further
> problems, we will instead retry refilling in the next NAPI poll.
> 
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> Cc: stable@vger.kernel.org
> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..ac514c9383ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>  }
>  
>  static int virtnet_receive(struct receive_queue *rq, int budget,
> -			   unsigned int *xdp_xmit)
> +			   unsigned int *xdp_xmit, bool *retry_refill)
>  {
>  	struct virtnet_info *vi = rq->vq->vdev->priv;
>  	struct virtnet_rq_stats stats = {};
> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>  
>  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -			spin_lock(&vi->refill_lock);
> -			if (vi->refill_enabled)
> -				schedule_delayed_work(&vi->refill, 0);
> -			spin_unlock(&vi->refill_lock);
> -		}
> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +			*retry_refill = true;
>  	}
>  
>  	u64_stats_set(&stats.packets, packets);

So this function sets retry_refill to true but assumes caller
will set it to false? seems unnecessarily complex.
just have to always set retry_refill correctly
and not rely on the caller.


> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	struct send_queue *sq;
>  	unsigned int received;
>  	unsigned int xdp_xmit = 0;
> -	bool napi_complete;
> +	bool napi_complete, retry_refill = false;
>  
>  	virtnet_poll_cleantx(rq, budget);
>  
> -	received = virtnet_receive(rq, budget, &xdp_xmit);
> +	received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>  	rq->packets_in_napi += received;
>  
>  	if (xdp_xmit & VIRTIO_XDP_REDIR)
>  		xdp_do_flush();
>  
>  	/* Out of packets? */
> -	if (received < budget) {
> +	if (received < budget && !retry_refill) {
>  		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>  		/* Intentionally not taking dim_lock here. This may result in a
>  		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
> @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  		virtnet_xdp_put_sq(vi, sq);
>  	}
>  
> -	return received;
> +	return retry_refill ? budget : received;

a comment can't hurt here, to document what is going on.

>  }
>  
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
> -			/* Make sure we have some buffers: if oom use wq. */
> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->refill, 0);
> +			/* If this fails, we will retry later in
> +			 * NAPI poll, which is scheduled in the below
> +			 * virtnet_enable_queue_pair
> +			 */
> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  				bool refill)
>  {
>  	bool running = netif_running(vi->dev);
> -	bool schedule_refill = false;
>  
> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_refill = true;
> +	if (refill)
> +		/* If this fails, we will retry later in NAPI poll, which is
> +		 * scheduled in the below virtnet_napi_enable
> +		 */
> +		try_fill_recv(vi, rq, GFP_KERNEL);
> +
>  	if (running)
>  		virtnet_napi_enable(rq);
> -
> -	if (schedule_refill)
> -		schedule_delayed_work(&vi->refill, 0);
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	struct virtio_net_rss_config_trailer old_rss_trailer;
>  	struct net_device *dev = vi->dev;
>  	struct scatterlist sg;
> +	int i;
>  
>  	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>  		return 0;
> @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	}
>  succ:
>  	vi->curr_queue_pairs = queue_pairs;
> -	/* virtnet_open() will refill when device is going to up. */
> -	spin_lock_bh(&vi->refill_lock);
> -	if (dev->flags & IFF_UP && vi->refill_enabled)
> -		schedule_delayed_work(&vi->refill, 0);
> -	spin_unlock_bh(&vi->refill_lock);
> +	if (dev->flags & IFF_UP) {
> +		/* Let the NAPI poll refill the receive buffer for us. We can't
> +		 * safely call try_fill_recv() here because the NAPI might be
> +		 * enabled already.
> +		 */
> +		local_bh_disable();
> +		for (i = 0; i < vi->curr_queue_pairs; i++)

you cam declare i here in the for loop.
and ++i is a bit clearer.

> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> +
> +		local_bh_enable();
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.43.0


