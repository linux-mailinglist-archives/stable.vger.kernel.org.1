Return-Path: <stable+bounces-208430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C80B8D233E2
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 09:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1A85304743D
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 08:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF133507D;
	Thu, 15 Jan 2026 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b7nCwnNO"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889A30C63A
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466913; cv=none; b=bTy2B9CWwvP3+EE/3NhZpnoISPoOF9ea60B/zjARd3WuoGYtcHCbYqaepJ70FVWluRYgRek4vEEkMb2thtvfysozLGtJZ8ron7OwtizeRXgEGc/GwrUfgg16KzVGf0tf3UgLNQ+wwZKde4SxVj0MghFhnOlO3t8Sina77XADH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466913; c=relaxed/simple;
	bh=JUbergQkO24XPqVs3lI5gAaLlT6sxyYL7vHiKKUgAOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzDHTrxkH2aY8ovAlhbodResYQnc4uW03HU2BBC2J8StP80hKa7FC1yRJIpv8XdsMWoXLR1NW+Kwr8e9PbZbbfD7lrRfl9PkUo6OEpFwWwQ8/ekboL+VttDYE5KOHy2BnFfqns7NOixyXowyQXokRVPl5fndAnoZkOPTyPdgyls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b7nCwnNO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Jan 2026 03:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768466862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auKEimaGsYLcRLHzu88Am179GFhdeoqN0YYpcvN1Cu0=;
	b=b7nCwnNOohRA2wJs2M+Zmd8coMIn3TChpCylMeYNZuP0WTicQ/43Gzlqk5E33GDOCEgkz3
	z/QWaB3fvZ6NtoTmBFt5Rwpess/DiB86hxentTgVxPT7jlFRm+Yim9VGuOImFqBt6ZgAh4
	8OvDsOD4RiqEF4XNkmhnN5qWfnrupR8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, zhangshida@kylinos.cn, 
	Coly Li <colyli@fnnas.com>
Subject: Re: Patch "bcache: fix improper use of bi_end_io" has been added to
 the 6.6-stable tree
Message-ID: <aWipoJjgc2cQpcl5@moria.home.lan>
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

Sasha, has this been dropped?

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

