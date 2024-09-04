Return-Path: <stable+bounces-73050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD9896BDC9
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 15:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48C8B28C36
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9F81DA63E;
	Wed,  4 Sep 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr6oyYIM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FE1DA114
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455089; cv=none; b=sby/3P1q6NOr8KR4ZDEZ2+l0c1XrYvy/W2x/cs3AHoM/UDDPvSflrpyS3d17PLPjkdBFRUn8WxNLCcO3FCHQKTuFVvwFlLUhpwTBaCV8hc3PAmDAQCsiI3sry9Ed/EPvxVeXSm8HiMVfWQ8gotOviiAnC8eC12En4NPnyipJlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455089; c=relaxed/simple;
	bh=7ak4XrEdnlRi2v/8yamUtfMc99iT2J630o3+jOFReH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwxFdzpj8RP1kMmF/U7d84AE1rrvhSq8cCJOkDDYDogtqtU7F+EgeC6bowzZ4gGZ2MoaLtLdFuqvNQ+qAo9O93fthCPKoJHmvVUAbmjkIan2LwX/Px0XpKBMVgCLXY5oqFLlVin3tiN1XWbBTkIHh43Z536MrDZRKckjtk+IE0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr6oyYIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725455086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSmRkKcwStoVZz4ycbGuELyN9bbatZOLmay6g4DKLKw=;
	b=Xr6oyYIMRuM9PBzxQ6hTHsL3Gmdi2W4Ak6Sel+CJR6KsxWkUQ+pypyo6q99haA3lS3grYz
	+ebBV3C5qa57+vpdEC0yKOcz5E2eThxMNt01kUn0/bJN4+X5CPNaQ2UPQ1583qdBd7WW8I
	PpXqU+FP6h4sHUNYf+JziawZBxef2pc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-8quKOHEAMIa7bzdo6jPLpQ-1; Wed,
 04 Sep 2024 09:04:43 -0400
X-MC-Unique: 8quKOHEAMIa7bzdo6jPLpQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4ACF19560AE;
	Wed,  4 Sep 2024 13:04:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.59])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95DF3195605A;
	Wed,  4 Sep 2024 13:04:36 +0000 (UTC)
Date: Wed, 4 Sep 2024 21:04:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: axboe@kernel.dk, yukuai1@huaweicloud.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] block: fix ordering between checking
 BLK_MQ_S_STOPPED and adding requests
Message-ID: <Ztha3hb962mok1wf@fedora>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-4-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903081653.65613-4-songmuchun@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Sep 03, 2024 at 04:16:53PM +0800, Muchun Song wrote:
> Supposing first scenario with a virtio_blk driver.
> 
> CPU0                                                                CPU1
> 
> blk_mq_try_issue_directly()
>     __blk_mq_issue_directly()
>         q->mq_ops->queue_rq()
>             virtio_queue_rq()
>                 blk_mq_stop_hw_queue()
>                                                                     virtblk_done()
>     blk_mq_request_bypass_insert()                                      blk_mq_start_stopped_hw_queues()
>         /* Add IO request to dispatch list */   1) store                    blk_mq_start_stopped_hw_queue()
>                                                                                 clear_bit(BLK_MQ_S_STOPPED)                 3) store
>     blk_mq_run_hw_queue()                                                       blk_mq_run_hw_queue()
>         if (!blk_mq_hctx_has_pending())                                             if (!blk_mq_hctx_has_pending())         4) load
>             return                                                                      return
>         blk_mq_sched_dispatch_requests()                                            blk_mq_sched_dispatch_requests()
>             if (blk_mq_hctx_stopped())          2) load                                 if (blk_mq_hctx_stopped())
>                 return                                                                      return
>             __blk_mq_sched_dispatch_requests()                                          __blk_mq_sched_dispatch_requests()
> 
> Supposing another scenario.
> 
> CPU0                                                                CPU1
> 
> blk_mq_requeue_work()
>     /* Add IO request to dispatch list */       1) store            virtblk_done()
>     blk_mq_run_hw_queues()/blk_mq_delay_run_hw_queues()                 blk_mq_start_stopped_hw_queues()
>         if (blk_mq_hctx_stopped())              2) load                     blk_mq_start_stopped_hw_queue()
>             continue                                                            clear_bit(BLK_MQ_S_STOPPED)                 3) store
>         blk_mq_run_hw_queue()/blk_mq_delay_run_hw_queue()                       blk_mq_run_hw_queue()
>                                                                                     if (!blk_mq_hctx_has_pending())         4) load
>                                                                                         return
>                                                                                     blk_mq_sched_dispatch_requests()
> 
> Both scenarios are similar, the full memory barrier should be inserted between
> 1) and 2), as well as between 3) and 4) to make sure that either CPU0 sees
> BLK_MQ_S_STOPPED is cleared or CPU1 sees dispatch list. Otherwise, either CPU
> will not rerun the hardware queue causing starvation of the request.
> 
> The easy way to fix it is to add the essential full memory barrier into helper
> of blk_mq_hctx_stopped(). In order to not affect the fast path (hardware queue
> is not stopped most of the time), we only insert the barrier into the slow path.
> Actually, only slow path needs to care about missing of dispatching the request
> to the low-level device driver.
> 
> Fixes: 320ae51feed5c ("blk-mq: new multi-queue block IO queueing mechanism")
> Cc: stable@vger.kernel.org
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


