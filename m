Return-Path: <stable+bounces-207954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB10D0D492
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 11:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D818302FA03
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE6303A0A;
	Sat, 10 Jan 2026 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL5xClzi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4QzRFMl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F923016F4
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768040060; cv=none; b=PntUcHneyZCy0DB+B3++ZAGhA7zPu8cpvQL9uBBIjmg0yY0mFwmjl50636GAKWk+ABjTdGnFTSZ4ix3wEXyHfR3Dd7TIl9gbxiiI33H263gFfwYyhA5KHRrFs7Tml5iC6Hm/f8JFHj9QyVzIA1Aidf9WOH3jbmQt3WqMFF9IfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768040060; c=relaxed/simple;
	bh=GR3k999HC/wBwuDdQiVyvY8an+sH4jRx08ZnxkTnhTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLOxYpJjOuq39q7To0y60ZzUwxiPYpioQjtFE5O2Cx6ShFT/kEUL6NTfDyJy6p0jA7EpkoBAO72aw6GsV+wPnLwWfZDx+VvbWuy/sSTIV8biO7pw0GW4Ez6CrO+fCy0uwATJ8yk1xMw9yHxLgO+PSIdsMP4CSN6kdlXz00T7fzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gL5xClzi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4QzRFMl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768040057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dA+ZbEhpNNEZeZ/tio972zkgtuSqnUftWgoWPgE0LNo=;
	b=gL5xClziAG9lNksl1hWzHMS19QBdTivcmBH8YXIO4fxJCQgtm1GdvmGgBLNhYUuIlotsRQ
	Xtw4RJqznksZoagfVCuyQEyJo5TlOeDUVXvmsBW16iGLRokdtSIJdBpA8ybiy4ojqtsz5t
	5Kx2J6Ewd05Z6Wm+diuayROmXfTWuVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-qM4vbb1oP9CZjFRmlFS5PA-1; Sat, 10 Jan 2026 05:14:16 -0500
X-MC-Unique: qM4vbb1oP9CZjFRmlFS5PA-1
X-Mimecast-MFC-AGG-ID: qM4vbb1oP9CZjFRmlFS5PA_1768040055
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3c4468d8so32834305e9.2
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 02:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768040055; x=1768644855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dA+ZbEhpNNEZeZ/tio972zkgtuSqnUftWgoWPgE0LNo=;
        b=I4QzRFMlWOFi3KV+JByMCoA23MPO67gH87nMHRc9u00qkuGYokwoYWbFpi20TAMftc
         VgSSPJaIHqyUhrR1V/BClHsuQ2YXWVGsPBbiHzHKIsfGYC1XEIM+F0FO0S+XjvV6PTV4
         wagFII/vl9VnY1RMds8c4jptmLR4FfzJClT8qlobCm1jx/xp94WYYBTeDiILcEHMLrDm
         54xvrkzHIi3MFfSpS1Grw+lv8/pPTU8BRBHL9U30lMOigyFfYRzv9CfHokzh/VPIFs1s
         UN1uaM2TRrBSf4NnKtDgjg6dvWHXQW40Bxgt3ISxnuCv04bVVq35umpngh9O+PISg9j4
         UMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768040055; x=1768644855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA+ZbEhpNNEZeZ/tio972zkgtuSqnUftWgoWPgE0LNo=;
        b=uJmiaTgTwy1cYviTzWGnQRRuppL1VgOG68BSnWzBcECmA0xSVApQLYSN7arNQJjgfG
         zkjSbMhUu4SDZLYZwDLyVdzKnWYJY8RheyHk1U0Fn+oAeQf5ZY6/AzVpfN+Xy9dY/P5G
         Oc4FL+Ee6k3nZXK0O14KWEXVAuaAxSt34BrIHzP6ZkmtQ6gTvLXgM6ZMX9+UhYyJ8Ozc
         CLDJPW1L4sXj/YGriOp4xgkoW0mPwrDyJHeR88+8p6hfvOE0qmj/AFXYLiYxvYJucdTF
         GOqgCKN9RBPvA36p8ojXfALXs25TU2BsjHHZtBPEZW7dnMnEe+eZu+IOy1Jx/ynpvme1
         DTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtF1j5twDXMZpbeZfOqEVbYrIyAqx0+bJKC3NAn0ho+n4+STd8y1Q/lL0pCeGmnNQB4rr+hTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeVUH1FMqTT2i7ioTgHSeP2XWlesGiZCrFjKQ/K6vC/d8o52Eq
	ZhIUOH9YsrJ8k5cqbtZ3F5pPy++ZdHSxHb8FtpjiN1VNGUKR8IyE8z9XxhfMYEdfmyLvSlhP258
	aH1F9M5YNoyKwiF0hLg6x9pK1gADFAo7mXiQHiU0qR4E2gvZt+r7KFj6WWA==
X-Gm-Gg: AY/fxX7Jy7ABXOb9fTgzbaXS9qTNWWZT7Zg6aBkhvPewhjs10xyfA50FWrVw12XiS4G
	ubeb7dKN99Lj80yiaYAUf5YFUW/9T2bH3VTJP8I0TQ7becy0kzh3XyI88wzBu5cZnsuZCtEjxLm
	PJvgO/30st3qxfhYgnkw3iyl0XRuHqpKawblZaP4IpZvM3vCm0vBh4Fl8eFpXiXs9BKoS9J2kFK
	47zwifRweMriq85xT07G3bdLpPsEocTCbeCuN0eBU5Wh3fpQntfdCSirkYVRAD2KBz4Bs6bAGPV
	k4eWKoAD8APQe5HreaU2UE0ttTxWEbOa7Fyv4yi+2VU+VYWncdvHI35RCBK0L5aAobmKbhYa7+R
	Iy/rk
X-Received: by 2002:a05:600c:4fd4:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-47d84b3b687mr144672815e9.30.1768040054563;
        Sat, 10 Jan 2026 02:14:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsvcWZT602v6D3Jk4OZpQRCrttnIFGdd1e0R1U9h/xIHk0Xd/hakt57g7VJk+sGDBWCw9vRw==
X-Received: by 2002:a05:600c:4fd4:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-47d84b3b687mr144672455e9.30.1768040054093;
        Sat, 10 Jan 2026 02:14:14 -0800 (PST)
Received: from redhat.com ([2a06:c701:73f2:9400:32c:f78d:ab04:e7a0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d87167832sm86921535e9.7.2026.01.10.02.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 02:14:13 -0800 (PST)
Date: Sat, 10 Jan 2026 05:14:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260110051335-mutt-send-email-mst@kernel.org>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
 <20260109181239.1c272f88@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109181239.1c272f88@kernel.org>

On Fri, Jan 09, 2026 at 06:12:39PM -0800, Jakub Kicinski wrote:
> On Tue,  6 Jan 2026 22:04:36 +0700 Bui Quang Minh wrote:
> > When we fail to refill the receive buffers, we schedule a delayed worker
> > to retry later. However, this worker creates some concurrency issues.
> > For example, when the worker runs concurrently with virtnet_xdp_set,
> > both need to temporarily disable queue's NAPI before enabling again.
> > Without proper synchronization, a deadlock can happen when
> > napi_disable() is called on an already disabled NAPI. That
> > napi_disable() call will be stuck and so will the subsequent
> > napi_enable() call.
> > 
> > To simplify the logic and avoid further problems, we will instead retry
> > refilling in the next NAPI poll.
> 
> Happy to see this go FWIW. If it causes issues we should consider
> adding some retry logic in the core (NAPI) rather than locally in
> the driver..
> 
> > Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> 
> The Closes should probably point to Paolo's report. We'll wipe these CI
> logs sooner or later but the lore archive will stick around.
> 
> > @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
> >  
> >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> >  		if (i < vi->curr_queue_pairs)
> > -			/* Make sure we have some buffers: if oom use wq. */
> > -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > -				schedule_delayed_work(&vi->refill, 0);
> > +			/* Pre-fill rq agressively, to make sure we are ready to
> > +			 * get packets immediately.
> > +			 */
> > +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> 
> We should enforce _some_ minimal fill level at the time of open().
> If the ring is completely empty no traffic will ever flow, right?
> Perhaps I missed scheduling the NAPI somewhere..

Practically, single page allocations with GFP_KERNEL don't
really fail. So I think it's fine.

> >  		err = virtnet_enable_queue_pair(vi, i);
> >  		if (err < 0)
> > @@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
> >  				struct receive_queue *rq,
> >  				bool refill)
> >  {
> > -	bool running = netif_running(vi->dev);
> > -	bool schedule_refill = false;
> > +	if (netif_running(vi->dev)) {
> > +		/* Pre-fill rq agressively, to make sure we are ready to get
> > +		 * packets immediately.
> > +		 */
> > +		if (refill)
> > +			try_fill_recv(vi, rq, GFP_KERNEL);
> 
> Similar thing here? Tho not sure we can fail here..
> 
> > -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> > -		schedule_refill = true;
> > -	if (running)
> >  		virtnet_napi_enable(rq);
> > -
> > -	if (schedule_refill)
> > -		schedule_delayed_work(&vi->refill, 0);
> > +	}
> >  }
> >  
> >  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> > @@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> >  	}
> >  succ:
> >  	vi->curr_queue_pairs = queue_pairs;
> > -	/* virtnet_open() will refill when device is going to up. */
> > -	spin_lock_bh(&vi->refill_lock);
> > -	if (dev->flags & IFF_UP && vi->refill_enabled)
> > -		schedule_delayed_work(&vi->refill, 0);
> > -	spin_unlock_bh(&vi->refill_lock);
> > +	if (dev->flags & IFF_UP) {
> > +		local_bh_disable();
> > +		for (int i = 0; i < vi->curr_queue_pairs; ++i)
> > +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> > +
> 
> nit: spurious new line
> 
> > +		local_bh_enable();
> > +	}
> >  
> >  	return 0;
> >  }


