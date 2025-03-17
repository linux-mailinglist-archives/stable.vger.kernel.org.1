Return-Path: <stable+bounces-124604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB10A64242
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A041F18912F4
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ADE21884A;
	Mon, 17 Mar 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmZzl9Ej"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324420328
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194673; cv=none; b=IR1yny5W2wdZeUWfQntEEjPd1J+xZWEOHqEwVrJ7a7dvZCjL3GIzXOziFMjQRB9YOmWDnmd6AaXzxwVswhvOST7OmZlOcIa0avk6oVhxKZqEyNgiegwAeT3dINdvpNNx4fWgXVd40e+9jMwrx5b7yL64/mEC875bbhOEepHrfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194673; c=relaxed/simple;
	bh=bGbdd9J7gUZshwYr6Q4ijUkR75kuqV68jE0Fx1+d3x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpN62rGVPLXCaDt08fs6QVYLszkaqErhn01rEgLJ+MbPaPq/OUHAT3kyEGPAPgADqCVxGHiwg9Dt/27higWpgFNgQnCHe3ylopmHpeXCBRCcnv5vKqUan6EjtftUXlDv42xSuRpamZBI3AhUfv96n3hysRgzzEYiGpoR8bOuaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmZzl9Ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78DCC4CEE3;
	Mon, 17 Mar 2025 06:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742194673;
	bh=bGbdd9J7gUZshwYr6Q4ijUkR75kuqV68jE0Fx1+d3x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmZzl9EjP2AeN0vGFat3nNj2mPG5y7/IBdJdIYJohLOhpsloTArnG6HPlVCW8rfMQ
	 A17LNgts1tyuWQXrGI+S5ZTpt0OHffgLM370+FTiksBUCwcLLkzXkhENZsamCY7Wsg
	 FzifBcuUw4tmm0e8kwr85WmRDmAE3ZzW9Lxh+tZE=
Date: Mon, 17 Mar 2025 07:56:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: stable@vger.kernel.org, muchun.song@linux.dev,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5.15.y] block: fix missing dispatching request when queue
 is started or unquiesced
Message-ID: <2025031727-overstay-reckless-bfef@gregkh>
References: <2024120323-snowiness-subway-3844@gregkh>
 <20250317033039.6475-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317033039.6475-1-songmuchun@bytedance.com>

On Mon, Mar 17, 2025 at 11:30:39AM +0800, Muchun Song wrote:
> Supposing the following scenario with a virtio_blk driver.
> 
> CPU0                    CPU1                    CPU2
> 
> blk_mq_try_issue_directly()
>   __blk_mq_issue_directly()
>     q->mq_ops->queue_rq()
>       virtio_queue_rq()
>         blk_mq_stop_hw_queue()
>                                                 virtblk_done()
>                         blk_mq_try_issue_directly()
>                           if (blk_mq_hctx_stopped())
>   blk_mq_request_bypass_insert()                  blk_mq_run_hw_queue()
>   blk_mq_run_hw_queue()     blk_mq_run_hw_queue()
>                             blk_mq_insert_request()
>                             return
> 
> After CPU0 has marked the queue as stopped, CPU1 will see the queue is
> stopped. But before CPU1 puts the request on the dispatch list, CPU2
> receives the interrupt of completion of request, so it will run the
> hardware queue and marks the queue as non-stopped. Meanwhile, CPU1 also
> runs the same hardware queue. After both CPU1 and CPU2 complete
> blk_mq_run_hw_queue(), CPU1 just puts the request to the same hardware
> queue and returns. It misses dispatching a request. Fix it by running
> the hardware queue explicitly. And blk_mq_request_issue_directly()
> should handle a similar situation. Fix it as well.
> 
> Fixes: d964f04a8fde ("blk-mq: fix direct issue")
> Cc: stable@vger.kernel.org
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Link: https://lore.kernel.org/r/20241014092934.53630-2-songmuchun@bytedance.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 46cb802cfcf05..a15c665a77100 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2048,7 +2048,6 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	 * and avoid driver to try to dispatch again.
>  	 */
>  	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
> -		run_queue = false;
>  		bypass_insert = false;
>  		goto insert;
>  	}
> -- 
> 2.20.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

