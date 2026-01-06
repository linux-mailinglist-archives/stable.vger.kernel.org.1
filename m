Return-Path: <stable+bounces-205111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C709BCF91B0
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72DF53035302
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C9C33DEFE;
	Tue,  6 Jan 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2yrldDq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaOtllve"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9953128B6
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713356; cv=none; b=OIfFTMyJopv+ZqqlK4LWIX7X0BX/ObFYyLwQPV4AexmoVY44snaHo729GHLo9tFOKK4cHc08ksKAzhZVPZ8QVOn4NmvkTlFsQWbZf/nwK+O1xU2GN3UqOVDh87TN/Q5euP5V74hQhZ4hXkHk9cS+v75LvK82oE7+aiJ5/MqwUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713356; c=relaxed/simple;
	bh=ORBUTAza06yVYLn8Gg5h7JdLV16kPZGZnkfL1uLRIPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbgZslm21WDm+Y0zkjOSlZU+rDPOZu9HjFZeFFLCty/oEMX66k3zIuLs2/jkY4nZUYvFKHLjGKwU340QbHtFuDkGVYPeGeafJULkXIDeZDearZPASbLmU9rpLiRzYRikEdtfLTCpM/68XDRmvptTQszeKCwMu/5BEDyzxWs1zrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2yrldDq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AaOtllve; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767713352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mutPiJahqf07tX0K9jDs+Vqe+Q2f0S7Ia0chn9JrkM=;
	b=a2yrldDqBs69zbkz3iUaSTBqaGGB5t44t3qZtUhpLz29YrJ/roSt1mtE3ojdUQgryx+Chj
	BO0CWHhSOfgCATLIAUXlI9KVlahGrmZgzk7cWjIzOzE1od3Qlewrxah6ILoCfKxwd6rTeL
	HFeTHs8DrZaff9+5PJ68bZmloFJIHuA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-Z1-o0ZAjNpeEuHCTehpAwA-1; Tue, 06 Jan 2026 10:29:11 -0500
X-MC-Unique: Z1-o0ZAjNpeEuHCTehpAwA-1
X-Mimecast-MFC-AGG-ID: Z1-o0ZAjNpeEuHCTehpAwA_1767713350
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64981bd02a4so1464952a12.0
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 07:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767713350; x=1768318150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mutPiJahqf07tX0K9jDs+Vqe+Q2f0S7Ia0chn9JrkM=;
        b=AaOtllvenVvjWeWtkkiyOORyEOZ0bg1USex3MDtecTmShUSwYqny/lzE+39GbYspYE
         XW6QE+tMvIDnpML4fvCfGo/UNHihVt+FBA2T9yQJxow4+mkcov5tPc/jo+85YEN/lv1S
         cMCBpiPAKaCs9pZDoVCr+cVmtY/tUl068Eyak1Q6Sq+khFScb3FQtWusVSGFtGPP7qi4
         lGtc3tt6oTcKutIWtZROeF4X7+V8+tdtOSZKars/Co0fxI0MZ2GCn7OD23t/tXOVTsXb
         6F0exZGLEFsd74x/urofx1tbsI7WGuyBBVXMYF6VGJyAC6xkYsjv3moH2dleyfTf8ixh
         Ae5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713350; x=1768318150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mutPiJahqf07tX0K9jDs+Vqe+Q2f0S7Ia0chn9JrkM=;
        b=YxDtlIc8idFFp1dWMHcZlxqF7vzjFMZMw+6u3MoOkd6LzOUgTuhHEqP56IZu5iHU43
         vAb113ypu1irgOSc7xuW823X9B1bvwrR67z6JrORNGprTGkLA1O/Wvssemq6fl3GOh6K
         aBEIK+YCiA5Vy7X0A/qgVsbDwwhLupBI9NoKr5QudrT8lRiZdavql7radzOjld/aeZbb
         7UrAgnmNrOPRKegiQJDICGl3jmuF7R7tYr7KJfCttIcneAEmTbNE3mTCjISsVTA6+/Mb
         3VUdDcPCSJYWLmpklrjlp5t/vK1H07rJfxNI6w7p9tpKXOIaOKV3Hs/41bu/2f5XZy4M
         RcRw==
X-Forwarded-Encrypted: i=1; AJvYcCVq5couWG1RVpFeKQVjOBTUY+PLkgs6OgZ3MnWU/SyBStGI9Qj4eBwKo2tnIhx7mD+W9MhnUU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLRJIRvmrcZ5pPDbWhYtYceKIW8zCSa7KSPUuzaicMFVrUzB6
	shGnmnqGtjyPh5O3XtcGHe2ucrSC5QfUFDgN8/Uhnyu3ZMP2MGl/P0tGEUGbwM2a53vPZxOu4BF
	MgWh2Q9qvcieNIb2DSyBuoeg5Xom+PVYuWroCKsRk9qgpgZFMxYbdjydq1Q==
X-Gm-Gg: AY/fxX6KXGW2xVEHKB1w2gXbwckg9kasfjwrpjc5OWzPECPcbsPGWtr/Q6xkzEE4wCt
	zLtRUXiBdMPLX/E1FLCSUL2YaCW854qj1Diis9tfs8iOesJ8KS/YXn7DE0qsg2zrXwBYeGeZHC6
	C8YSnuPxP8QOSckI+YXx8Pn4fBMZto2/Cnj8TwxySU65WSFfxm+zsFbKJXVolMmcLzHVSvrra9W
	J4jl43sQ3lUV0KSAEQc0/a96DzjwZIucV1QODxmX5XR+Fv+p5lSV9GgAgM5nQOuHwRZAtW2cmod
	ubx/u4FgguLKurxtWdX5qm2IGuPWv2/TDhEy307Cy6JhgNDnYM+1swsB7AGkXY73wf9HXzLU/RR
	C+MI3IqirxDdCMpcaWgaiSsB0JF0NvEADUw==
X-Received: by 2002:a17:907:97c7:b0:b80:11fd:793b with SMTP id a640c23a62f3a-b8426a6849bmr317260866b.19.1767713349820;
        Tue, 06 Jan 2026 07:29:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWb6y9xsvseC+MSQM10NdjJ3BS0aRkbGgQvy+bzZrBc9IB4ICJIxfQsaMFe9coDqIqquWjJA==
X-Received: by 2002:a17:907:97c7:b0:b80:11fd:793b with SMTP id a640c23a62f3a-b8426a6849bmr317258866b.19.1767713349329;
        Tue, 06 Jan 2026 07:29:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c760sm261977866b.24.2026.01.06.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:29:08 -0800 (PST)
Date: Tue, 6 Jan 2026 10:29:05 -0500
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
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260106100959-mutt-send-email-mst@kernel.org>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106150438.7425-2-minhquangbui99@gmail.com>

On Tue, Jan 06, 2026 at 10:04:36PM +0700, Bui Quang Minh wrote:
> When we fail to refill the receive buffers, we schedule a delayed worker
> to retry later. However, this worker creates some concurrency issues.
> For example, when the worker runs concurrently with virtnet_xdp_set,
> both need to temporarily disable queue's NAPI before enabling again.
> Without proper synchronization, a deadlock can happen when
> napi_disable() is called on an already disabled NAPI. That
> napi_disable() call will be stuck and so will the subsequent
> napi_enable() call.
> 
> To simplify the logic and avoid further problems, we will instead retry
> refilling in the next NAPI poll.
> 
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> Cc: stable@vger.kernel.org
> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and CC stable I think. Can you do that pls?

> ---
>  drivers/net/virtio_net.c | 48 +++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..f986abf0c236 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3046,16 +3046,16 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  	else
>  		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>  
> +	u64_stats_set(&stats.packets, packets);
>  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -			spin_lock(&vi->refill_lock);
> -			if (vi->refill_enabled)
> -				schedule_delayed_work(&vi->refill, 0);
> -			spin_unlock(&vi->refill_lock);
> -		}
> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +			/* We need to retry refilling in the next NAPI poll so
> +			 * we must return budget to make sure the NAPI is
> +			 * repolled.
> +			 */
> +			packets = budget;
>  	}
>  
> -	u64_stats_set(&stats.packets, packets);
>  	u64_stats_update_begin(&rq->stats.syncp);
>  	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
>  		size_t offset = virtnet_rq_stats_desc[i].offset;
> @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
> -			/* Make sure we have some buffers: if oom use wq. */
> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->refill, 0);
> +			/* Pre-fill rq agressively, to make sure we are ready to
> +			 * get packets immediately.
> +			 */
> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
> @@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  				struct receive_queue *rq,
>  				bool refill)
>  {
> -	bool running = netif_running(vi->dev);
> -	bool schedule_refill = false;
> +	if (netif_running(vi->dev)) {
> +		/* Pre-fill rq agressively, to make sure we are ready to get
> +		 * packets immediately.
> +		 */
> +		if (refill)
> +			try_fill_recv(vi, rq, GFP_KERNEL);
>  
> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_refill = true;
> -	if (running)
>  		virtnet_napi_enable(rq);
> -
> -	if (schedule_refill)
> -		schedule_delayed_work(&vi->refill, 0);
> +	}
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	}
>  succ:
>  	vi->curr_queue_pairs = queue_pairs;
> -	/* virtnet_open() will refill when device is going to up. */
> -	spin_lock_bh(&vi->refill_lock);
> -	if (dev->flags & IFF_UP && vi->refill_enabled)
> -		schedule_delayed_work(&vi->refill, 0);
> -	spin_unlock_bh(&vi->refill_lock);
> +	if (dev->flags & IFF_UP) {
> +		local_bh_disable();
> +		for (int i = 0; i < vi->curr_queue_pairs; ++i)
> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> +
> +		local_bh_enable();
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.43.0


