Return-Path: <stable+bounces-208188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 692C6D1467D
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BC973011ECA
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1F24397A;
	Mon, 12 Jan 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WiW5fFlH"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06FD378D60
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239304; cv=none; b=pQslBDs1Us82W1RvW7FgL0DuX+E1lrBCPtr04bRFaVueUjSRRUNQ6+hWY5R3QU0ZoSDRHBj8yimX5uqahFLMybgMH053qA102Q+MCyfJgvtYKGquGH+WFCKNgv9kOMiUv2sQ/yFhtYm6DRrWlaBzeBvO/99BFAIfEILl+KoZsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239304; c=relaxed/simple;
	bh=kieQNTGpsJIGpbXGFnRt8FFgOJRfO9iKcjSuaUbUQW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/+jHnueVz23LouVhZ+x7/Q1KwoEo+hJn6r8n9Jcy3Xz8nlH2vlcVZtCkiJajCx6YB6j0PGnZEy6mkd2+m0vIhDv4SeojuMnRp2XwtXUlze6l+NCZDcJhFqsbyMjEni1bNwtgRjw3oV5S+7Q2aytxzV1PdlFMHni9HVo9m6z0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WiW5fFlH; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Jan 2026 12:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768239301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2i8ZuoT4+BIeR2Q6d+MAix0iVMCT8oNedw/2XY3ri8=;
	b=WiW5fFlH7XDUhVL/pFsLC84hwMwFGsjtdNTEegcpqYErP2bWHRwFWyKBI51gp/nd1bBpOY
	eRsqWun4KnJb07OYSrBJe3BpZfQlq70dQf+PCpFLnLUSM2wDMpriO5LD8uzUl55wlUW2QY
	dLqg/7at7kJNv2So7vBHRNjZGvNl67c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, zhangshida@kylinos.cn, 
	Coly Li <colyli@fnnas.com>
Subject: Re: Patch "bcache: fix improper use of bi_end_io" has been added to
 the 6.6-stable tree
Message-ID: <aWUwUJm3snKKvLhy@moria.home.lan>
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

Has this code been tested?

bio_endio() is not equivalent to calling bi_end_io; if the code is
swapping out bi_end_io to pass it down the stack, then you have two
completions on the same bio - you cannot call bio_endio() twice on the
same bio.

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

