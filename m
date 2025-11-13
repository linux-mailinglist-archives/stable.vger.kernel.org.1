Return-Path: <stable+bounces-194662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A43C56354
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09FC9346BF0
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230DB330B12;
	Thu, 13 Nov 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXT2YJTY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tQ8ygYT2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E41330B39
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021591; cv=none; b=Ah3lpG3NR6+622zz7gO1c7j5Jf7TdUdOQa8hyfqNON7ZaRbnXXPInms7RuDBv74DgPrUPCNB7lxp015sxt7Koq6VjrX9ojcMP0kKnx6HKHBC3tFTl/Y9/fJVFOcd8BNkoDnuvCIqVtex/UGtZ48DMsUrEPKRPjIhvq99TPYmnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021591; c=relaxed/simple;
	bh=Ap2yBhzXTU6O9fGE+Hj6HPv06KYwiyh5Yi2mJXSIy64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an8Nm1n2H20kMdubBt80yXDMnIA8T/C8Dz6D3O57YlRKtrYrN103qE1pphVnSz0t1zoW62Wl9BhwOb5yBxB933l84W4ByZtnfbpPRGf6TGmlNoXRPeEFbAxvGQkibpaTp6a0rGfz1kpUSOJ5UPDrdNUE4onAdaEhZ3xVMdr3m4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXT2YJTY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tQ8ygYT2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763021588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DGVaSw4kPeGIDKxD03tfYFZ4BdD6dssNRKM1w0msCk=;
	b=CXT2YJTY1Nqk/lRMblEf1ThTmZhqk+8CDp6xVJiLsccz5izRRKz1GAssE17iBPgQwl0yy+
	oTtGgPrQ9MJyIFlK/we2QuBsSuldxlFYqYbGLWeGZtg9FwZK4iy3wMhRlVZvgJRpdgnE6j
	Ebd9Wwv+deY7u9OdakQxUYs985309G0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-54OkhLomP0evZ0oBdJO02g-1; Thu, 13 Nov 2025 03:13:07 -0500
X-MC-Unique: 54OkhLomP0evZ0oBdJO02g-1
X-Mimecast-MFC-AGG-ID: 54OkhLomP0evZ0oBdJO02g_1763021586
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477632ce314so2739795e9.3
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763021585; x=1763626385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DGVaSw4kPeGIDKxD03tfYFZ4BdD6dssNRKM1w0msCk=;
        b=tQ8ygYT2KXIVLTxEqOnYpfU84+aeEYs/ynC0ksVdF7l5gHr1901LuF71ejSpa1I+6V
         96EYNgfnxsR9WBD+c3aq3cuG3VN7C93KyPQvMmrdBnqjysj0Te5uSw9oFKXHexaRUN4f
         BujKbbWoF/YQgeK+Y7bGxC1bit36qBhgHp4UQB86ynuRDpyrvsyBfxiS7hTl9utNeuus
         s1htUObCPi4RUWNzMUUaX1XWWfyxkaEp2n7o1LE6cE9Cfp+PhuOrxFVaSXjJcnIgEkDR
         dgBXwVZwanH0/Eor2PD8irjT2aeYJTWYJeS6I2rB0NaDvJ2cQhq+7bAHQQKfilAghTya
         Xd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763021585; x=1763626385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DGVaSw4kPeGIDKxD03tfYFZ4BdD6dssNRKM1w0msCk=;
        b=fD2DKaP7YMqhoPycnT4egTe7Z7z9JixEk1eM4s6s+fhnOtlclNNfcAyXFo/c6nVyTT
         DzewPoM2s4te+9c4eod5UPLKwpR6hJhGAas/+HxUdBkof35bQU4GsohbS1wpJstBw7yd
         f45FRDjrA+c9ejoE4JJly5gEDRmUe7e5osWIK7LkWYMCYhIrJC/y7bs1GdI3OCU9LhCz
         L0KlVH+MCRU/nARDeOrXHCNOmQbPnwf2jJSghXdFkX8zvY3Kll/pp/hGA3Ud+ZyTXFVp
         CEcKN+tGYKcyZa4i+Om6ieJA2B2DtlVluR12SNtC7bYrcrKOeo9WtLFBoy/h1IAsRF/5
         qM9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUijRWRCTcSxU2f+dcUwCziFaaZ0mYaZ6yqWPfPTzjx+1fzG+5cHyODX5JZ60xoiILmHnvmcrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1quhxFCdLn24Pgjj6zv5NBS5DNW7UFuMzY20mMfj4tO0PvSPY
	CCurPFW58BWWioNj+1H+v6vUUxs2Je1w+DrJUbHekW18w5/6+/eA8m77Cg//Up/Grz7KXs3Mx3E
	yNkvAm4Oc0GGuSQwXVxuitBoZ1PiSxPvACvhPI5f42GYkNhZ+/m2nLY/26lOdsFC9147i
X-Gm-Gg: ASbGncs9rtdhbrfbnE3+kUl8FRB/A/PoCtjCNbdh1k3saGCA7wZqHdiKj/cAU0dJO4J
	K3C6izbKjcB/W+S17AtZTm6JuBqVise5N/iUhvbfVwsVQ/lTfkxtIiFbZAq9oq8wLiWuPDyb99M
	wNlCmp4VtP0Nvs6d2B5S3DhvprhP4HXAPevkwT9c7lLqd/x4wjGyA0m8f7iIYaHLZf56rhuLXRL
	HvLrwBamL3lhkk8PkJZmuriVrJmhEoNmfyLAnQVYMevUjtrXBYLIMvD0Krqs7d9lvBytoOMBtia
	qhnO66LhBHmV6NITljFbF3Ke99z2okL/3yRH7eWmW1BuVupTsaetnXantK7EU3v94BN6HoyOpj/
	OAwL5h8fSO4mDqANu66k=
X-Received: by 2002:a05:600c:a44:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778707ca20mr55192335e9.12.1763021585442;
        Thu, 13 Nov 2025 00:13:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIQgN138Wh9SyzvdeVmx3/FSQLTRYGtc1iBG+F/973cdwN4YYhSCw6TLEU3JsjzbHZAdvt9g==
X-Received: by 2002:a05:600c:a44:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778707ca20mr55191905e9.12.1763021584764;
        Thu, 13 Nov 2025 00:13:04 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c8a992bsm20321275e9.16.2025.11.13.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:13:04 -0800 (PST)
Date: Thu, 13 Nov 2025 03:13:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] vhost: rewind next_avail_head while discarding
 descriptors
Message-ID: <20251113030230-mutt-send-email-mst@kernel.org>
References: <20251113015420.3496-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113015420.3496-1-jasowang@redhat.com>

On Thu, Nov 13, 2025 at 09:54:20AM +0800, Jason Wang wrote:
> When discarding descriptors with IN_ORDER, we should rewind
> next_avail_head otherwise it would run out of sync with
> last_avail_idx. This would cause driver to report
> "id X is not a head".
> 
> Fixing this by returning the number of descriptors that is used for
> each buffer via vhost_get_vq_desc_n() so caller can use the value
> while discarding descriptors.
> 
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Wow that change really caused a lot of fallout.

Thanks for the patch! Yet something to improve:


> ---
>  drivers/vhost/net.c   | 53 ++++++++++++++++++++++++++-----------------
>  drivers/vhost/vhost.c | 43 ++++++++++++++++++++++++-----------
>  drivers/vhost/vhost.h |  9 +++++++-
>  3 files changed, 70 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..8f7f50acb6d6 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -592,14 +592,15 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
>  				    struct vhost_net_virtqueue *tnvq,
>  				    unsigned int *out_num, unsigned int *in_num,
> -				    struct msghdr *msghdr, bool *busyloop_intr)
> +				    struct msghdr *msghdr, bool *busyloop_intr,
> +				    unsigned int *ndesc)
>  {
>  	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
>  	struct vhost_virtqueue *rvq = &rnvq->vq;
>  	struct vhost_virtqueue *tvq = &tnvq->vq;
>  
> -	int r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> -				  out_num, in_num, NULL, NULL);
> +	int r = vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> +				    out_num, in_num, NULL, NULL, ndesc);
>  
>  	if (r == tvq->num && tvq->busyloop_timeout) {
>  		/* Flush batched packets first */
> @@ -610,8 +611,8 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
>  
>  		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, false);
>  
> -		r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> -				      out_num, in_num, NULL, NULL);
> +		r = vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> +					out_num, in_num, NULL, NULL, ndesc);
>  	}
>  
>  	return r;
> @@ -642,12 +643,14 @@ static int get_tx_bufs(struct vhost_net *net,
>  		       struct vhost_net_virtqueue *nvq,
>  		       struct msghdr *msg,
>  		       unsigned int *out, unsigned int *in,
> -		       size_t *len, bool *busyloop_intr)
> +		       size_t *len, bool *busyloop_intr,
> +		       unsigned int *ndesc)
>  {
>  	struct vhost_virtqueue *vq = &nvq->vq;
>  	int ret;
>  
> -	ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, msg, busyloop_intr);
> +	ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, msg,
> +				       busyloop_intr, ndesc);
>  
>  	if (ret < 0 || ret == vq->num)
>  		return ret;
> @@ -766,6 +769,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  	int sent_pkts = 0;
>  	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> +	unsigned int ndesc = 0;
>  
>  	do {
>  		bool busyloop_intr = false;
> @@ -774,7 +778,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			vhost_tx_batch(net, nvq, sock, &msg);
>  
>  		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
> -				   &busyloop_intr);
> +				   &busyloop_intr, &ndesc);
>  		/* On error, stop handling until the next kick. */
>  		if (unlikely(head < 0))
>  			break;
> @@ -806,7 +810,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  				goto done;
>  			} else if (unlikely(err != -ENOSPC)) {
>  				vhost_tx_batch(net, nvq, sock, &msg);
> -				vhost_discard_vq_desc(vq, 1);
> +				vhost_discard_vq_desc(vq, 1, ndesc);
>  				vhost_net_enable_vq(net, vq);
>  				break;
>  			}
> @@ -829,7 +833,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		err = sock->ops->sendmsg(sock, &msg, len);
>  		if (unlikely(err < 0)) {
>  			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
> -				vhost_discard_vq_desc(vq, 1);
> +				vhost_discard_vq_desc(vq, 1, ndesc);
>  				vhost_net_enable_vq(net, vq);
>  				break;
>  			}
> @@ -868,6 +872,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  	int err;
>  	struct vhost_net_ubuf_ref *ubufs;
>  	struct ubuf_info_msgzc *ubuf;
> +	unsigned int ndesc = 0;
>  	bool zcopy_used;
>  	int sent_pkts = 0;
>  
> @@ -879,7 +884,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  
>  		busyloop_intr = false;
>  		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
> -				   &busyloop_intr);
> +				   &busyloop_intr, &ndesc);
>  		/* On error, stop handling until the next kick. */
>  		if (unlikely(head < 0))
>  			break;
> @@ -941,7 +946,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  					vq->heads[ubuf->desc].len = VHOST_DMA_DONE_LEN;
>  			}
>  			if (retry) {
> -				vhost_discard_vq_desc(vq, 1);
> +				vhost_discard_vq_desc(vq, 1, ndesc);
>  				vhost_net_enable_vq(net, vq);
>  				break;
>  			}
> @@ -1045,11 +1050,12 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
>  		       unsigned *iovcount,
>  		       struct vhost_log *log,
>  		       unsigned *log_num,
> -		       unsigned int quota)
> +		       unsigned int quota,
> +		       unsigned int *ndesc)
>  {
>  	struct vhost_virtqueue *vq = &nvq->vq;
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> -	unsigned int out, in;
> +	unsigned int out, in, desc_num, n = 0;
>  	int seg = 0;
>  	int headcount = 0;
>  	unsigned d;
> @@ -1064,9 +1070,9 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
>  			r = -ENOBUFS;
>  			goto err;
>  		}
> -		r = vhost_get_vq_desc(vq, vq->iov + seg,
> -				      ARRAY_SIZE(vq->iov) - seg, &out,
> -				      &in, log, log_num);
> +		r = vhost_get_vq_desc_n(vq, vq->iov + seg,
> +					ARRAY_SIZE(vq->iov) - seg, &out,
> +					&in, log, log_num, &desc_num);
>  		if (unlikely(r < 0))
>  			goto err;
>  
> @@ -1093,6 +1099,7 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
>  		++headcount;
>  		datalen -= len;
>  		seg += in;
> +		n += desc_num;
>  	}
>  
>  	*iovcount = seg;
> @@ -1113,9 +1120,11 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
>  		nheads[0] = headcount;
>  	}
>  
> +	*ndesc = n;
> +
>  	return headcount;
>  err:
> -	vhost_discard_vq_desc(vq, headcount);
> +	vhost_discard_vq_desc(vq, headcount, n);

So here ndesc and n are the same, but below in vhost_discard_vq_desc
they are different. Fun.

>  	return r;
>  }
>  
> @@ -1151,6 +1160,7 @@ static void handle_rx(struct vhost_net *net)
>  	struct iov_iter fixup;
>  	__virtio16 num_buffers;
>  	int recv_pkts = 0;
> +	unsigned int ndesc;
>  
>  	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
>  	sock = vhost_vq_get_backend(vq);
> @@ -1182,7 +1192,8 @@ static void handle_rx(struct vhost_net *net)
>  		headcount = get_rx_bufs(nvq, vq->heads + count,
>  					vq->nheads + count,
>  					vhost_len, &in, vq_log, &log,
> -					likely(mergeable) ? UIO_MAXIOV : 1);
> +					likely(mergeable) ? UIO_MAXIOV : 1,
> +					&ndesc);
>  		/* On error, stop handling until the next kick. */
>  		if (unlikely(headcount < 0))
>  			goto out;
> @@ -1228,7 +1239,7 @@ static void handle_rx(struct vhost_net *net)
>  		if (unlikely(err != sock_len)) {
>  			pr_debug("Discarded rx packet: "
>  				 " len %d, expected %zd\n", err, sock_len);
> -			vhost_discard_vq_desc(vq, headcount);
> +			vhost_discard_vq_desc(vq, headcount, ndesc);
>  			continue;
>  		}
>  		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
> @@ -1252,7 +1263,7 @@ static void handle_rx(struct vhost_net *net)
>  		    copy_to_iter(&num_buffers, sizeof num_buffers,
>  				 &fixup) != sizeof num_buffers) {
>  			vq_err(vq, "Failed num_buffers write");
> -			vhost_discard_vq_desc(vq, headcount);
> +			vhost_discard_vq_desc(vq, headcount, ndesc);
>  			goto out;
>  		}
>  		nvq->done_idx += headcount;
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 8570fdf2e14a..b56568807588 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2792,18 +2792,11 @@ static int get_indirect(struct vhost_virtqueue *vq,
>  	return 0;
>  }
>  
> -/* This looks in the virtqueue and for the first available buffer, and converts
> - * it to an iovec for convenient access.  Since descriptors consist of some
> - * number of output then some number of input descriptors, it's actually two
> - * iovecs, but we pack them into one and note how many of each there were.
> - *
> - * This function returns the descriptor number found, or vq->num (which is
> - * never a valid descriptor number) if none was found.  A negative code is
> - * returned on error. */

A new module API with no docs at all is not good.
Please add documentation to this one. vhost_get_vq_desc
is a subset and could refer to it.

> -int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> -		      struct iovec iov[], unsigned int iov_size,
> -		      unsigned int *out_num, unsigned int *in_num,
> -		      struct vhost_log *log, unsigned int *log_num)
> +int vhost_get_vq_desc_n(struct vhost_virtqueue *vq,
> +			struct iovec iov[], unsigned int iov_size,
> +			unsigned int *out_num, unsigned int *in_num,
> +			struct vhost_log *log, unsigned int *log_num,
> +			unsigned int *ndesc)

>  {
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>  	struct vring_desc desc;
> @@ -2921,16 +2914,40 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  	vq->last_avail_idx++;
>  	vq->next_avail_head += c;
>  
> +	if (ndesc)
> +		*ndesc = c;
> +
>  	/* Assume notifications from guest are disabled at this point,
>  	 * if they aren't we would need to update avail_event index. */
>  	BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
>  	return head;
>  }
> +EXPORT_SYMBOL_GPL(vhost_get_vq_desc_n);
> +
> +/* This looks in the virtqueue and for the first available buffer, and converts
> + * it to an iovec for convenient access.  Since descriptors consist of some
> + * number of output then some number of input descriptors, it's actually two
> + * iovecs, but we pack them into one and note how many of each there were.
> + *
> + * This function returns the descriptor number found, or vq->num (which is
> + * never a valid descriptor number) if none was found.  A negative code is
> + * returned on error.
> + */
> +int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> +		      struct iovec iov[], unsigned int iov_size,
> +		      unsigned int *out_num, unsigned int *in_num,
> +		      struct vhost_log *log, unsigned int *log_num)
> +{
> +	return vhost_get_vq_desc_n(vq, iov, iov_size, out_num, in_num,
> +				   log, log_num, NULL);
> +}
>  EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
>  
>  /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
> -void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
> +void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n,
> +			   unsigned int ndesc)

ndesc is number of descriptors? And n is what, in that case?


>  {
> +	vq->next_avail_head -= ndesc;
>  	vq->last_avail_idx -= n;
>  }
>  EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 621a6d9a8791..69a39540df3d 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -230,7 +230,14 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
>  		      struct iovec iov[], unsigned int iov_size,
>  		      unsigned int *out_num, unsigned int *in_num,
>  		      struct vhost_log *log, unsigned int *log_num);
> -void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
> +
> +int vhost_get_vq_desc_n(struct vhost_virtqueue *vq,
> +			struct iovec iov[], unsigned int iov_size,
> +			unsigned int *out_num, unsigned int *in_num,
> +			struct vhost_log *log, unsigned int *log_num,
> +			unsigned int *ndesc);
> +
> +void vhost_discard_vq_desc(struct vhost_virtqueue *, int n, unsigned int ndesc);
>  
>  bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
>  bool vhost_vq_has_work(struct vhost_virtqueue *vq);
> -- 
> 2.31.1


