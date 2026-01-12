Return-Path: <stable+bounces-208194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0ED14A41
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 19:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C115F30060EB
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3A93803D3;
	Mon, 12 Jan 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o7qmAVzO"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BD37FF5D
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240927; cv=none; b=kc9RmxvGQ1rWjxs1XVoyAulBGnlBpyKLfF0xoTzajwu9qZBH5k13mL2VLQnJMZ0O9hHJZ1sRvgZ+5MYSmg8a9UVbPdXuGW6D9FyvNfWMV7uk+d9lnnruNqy3oxUv8Y1sfdHJq0Gpsv9ObmFi4u39zju4+cvM9+0cuPut03v8gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240927; c=relaxed/simple;
	bh=fbbkJ1HcNO/xEglsohwdOWAHOIjhNXmIV5BVhDqfmPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnNhImNFutwI/A5JOpqpwVAc9YZHYWHM81o1WaQQaCRfXAPIXB+o6ULVOED71yLa8U0Mxyo8zGORA0Wb4/jczOxRanQMXIOry6+ySqXe/mEiYlVPsKcTNJ1Tfc5x8nIXnLQu+Kdq6zdd+PvZASwzxNXd/JdWxIdiB0eHHTfGDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o7qmAVzO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Jan 2026 13:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768240920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTa4582jbf+Ut9Vr/4Uoi61aR4qHz7EPGR2TFmJo+rg=;
	b=o7qmAVzO3IkrYVGwJceCBPbVxo9tzsjOTY1FvHWbmmSKDeM6xwMpl5YDZ+MI8GuO9XWrwX
	EvXZo3tHwwfSccVuw/QvH6ni8HWsrSwkE1/Rq4Q24SPr7PlB+avglt620HB/GujBhO4Ne5
	mSem1c1K3tz6Gdq1Dt2qLMa3bkjkc6k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, zhangshida@kylinos.cn, 
	Coly Li <colyli@fnnas.com>
Subject: Re: Patch "bcache: fix improper use of bi_end_io" has been added to
 the 6.6-stable tree
Message-ID: <aWU2mO5v6RezmIpZ@moria.home.lan>
References: <20260112172345.800703-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112172345.800703-1-sashal@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 12, 2026 at 12:23:45PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     bcache: fix improper use of bi_end_io
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      bcache-fix-improper-use-of-bi_end_io.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Yeah, this is broken.

Coly, please revert this.

> 
> 
> 
> commit 81e7e43a810e8f40e163928d441de02d2816b073
> Author: Shida Zhang <zhangshida@kylinos.cn>
> Date:   Tue Dec 9 17:01:56 2025 +0800
> 
>     bcache: fix improper use of bi_end_io
>     
>     [ Upstream commit 53280e398471f0bddbb17b798a63d41264651325 ]
>     
>     Don't call bio->bi_end_io() directly. Use the bio_endio() helper
>     function instead, which handles completion more safely and uniformly.
>     
>     Suggested-by: Christoph Hellwig <hch@infradead.org>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index a9b1f3896249b..b4059d2daa326 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -1090,7 +1090,7 @@ static void detached_dev_end_io(struct bio *bio)
>  	}
>  
>  	kfree(ddip);
> -	bio->bi_end_io(bio);
> +	bio_endio(bio);
>  }
>  
>  static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
> @@ -1107,7 +1107,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
>  	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
>  	if (!ddip) {
>  		bio->bi_status = BLK_STS_RESOURCE;
> -		bio->bi_end_io(bio);
> +		bio_endio(bio);
>  		return;
>  	}
>  
> @@ -1122,7 +1122,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
>  
>  	if ((bio_op(bio) == REQ_OP_DISCARD) &&
>  	    !bdev_max_discard_sectors(dc->bdev))
> -		bio->bi_end_io(bio);
> +		detached_dev_end_io(bio);
>  	else
>  		submit_bio_noacct(bio);
>  }

