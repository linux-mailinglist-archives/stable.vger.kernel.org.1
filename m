Return-Path: <stable+bounces-135109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 656DDA968F6
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A150417B088
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C781B221289;
	Tue, 22 Apr 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WZFjCbHJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6E1EBA0C
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324422; cv=none; b=jeGPaFId9tfBAjitThzz+W89zafeMCpz9mMzxoSUSMv8RF5K5fqAyNXrbQjhU9czvEeKItCHb9fv+zuscQQE7RwBg1teS2m7xX6bGJTa7FPV71yERB+8xwg6yOKeqBoCXVo9Dsszws43RjTZvdvIKjL2solPzTOcd9Y5Vl402Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324422; c=relaxed/simple;
	bh=mp04PA8rCGYHfHuAQSj289Pe6LjtHq0UynSyGLCYNfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRJQe32VKy/4v9s03kAFD28dGsOh7EiALC1wNzXB6Ju7U4orb6/Xpym/vCuKg6/K7EETDY5oYDHaREIhboVxomGoikNHW+PBYKsuJo3s/oYMkh/XZFK3TjJByjzF89Eg30Wj9kWgZ9b7CVQSNuE9GrmrxZjroNTd1pRyHzEAo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WZFjCbHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0EAC4CEE9;
	Tue, 22 Apr 2025 12:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745324421;
	bh=mp04PA8rCGYHfHuAQSj289Pe6LjtHq0UynSyGLCYNfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZFjCbHJngwG6n0CkxdZgLe6MjOv5RgbogQZDnslOMRXL8g8c6TEX34No7V315FVS
	 LAj2oelH9rf+7ipt6zZkmJ9n6+DnB4sgUCy+5AkaLS2ztPFvfymNCaueqGEuFQjQmz
	 F+rdn2X9FCx1NSG+hDZlRmplQFMh6JAjqvUyQTt8=
Date: Tue, 22 Apr 2025 14:20:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: stable@vger.kernel.org, muchun.song@linux.dev,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5.15.y] block: fix missing dispatching request when queue
 is started or unquiesced
Message-ID: <2025042244-knoll-defensive-0f43@gregkh>
References: <2024120323-snowiness-subway-3844@gregkh>
 <20250317071821.22449-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317071821.22449-1-songmuchun@bytedance.com>

On Mon, Mar 17, 2025 at 03:18:21PM +0800, Muchun Song wrote:
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
> (cherry picked from commit 2003ee8a9aa14d766b06088156978d53c2e9be3d)

This was NOT a clean cherry-pick, always document what you had to do
differently from the original change please.

Please fix this up and resend a new version.

thanks,

greg k-h

