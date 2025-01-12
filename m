Return-Path: <stable+bounces-108319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DA5A0A81E
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 10:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38053A1A13
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1F19DF8D;
	Sun, 12 Jan 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wo8+e26b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713AE19D06E
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736675855; cv=none; b=YhQhKcahPPRE7/viJ+jpvl56pUC9Hkqk/Bcu3URksGh1mg5dTdjrZx02AumCCBD8LHeCEYF9qtrDukxCnZLpsakDzbFBma1l8wtm7j2e8b0mNRl7t9EVJURhRSRct4YAuBUwxe0dTbzxY4TXgWZp7FFtrBZa+djuaX979SZb5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736675855; c=relaxed/simple;
	bh=XnWvBAoFrp3Vv3sgBf7MhnK5+pfF7Cmgpa7MD7eEchI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGauQH+ccfDrDod40UrO7DAkgP+qzQ0h1oZ7wCa6tKuboGNIR8iUFfzBbr5qsA592oezWO+fZIKwm+PtKJnpfhuTf+H8PCsSwgJihVQfEgwBus3m0yZLSPXUuB7eb2O3TbJHG1+zOjBBzglQyh57hthE1ghZ2xfGRY/VYyp2nTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wo8+e26b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BFDC4CEDF;
	Sun, 12 Jan 2025 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736675855;
	bh=XnWvBAoFrp3Vv3sgBf7MhnK5+pfF7Cmgpa7MD7eEchI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wo8+e26bXZ3I9RWUwibn3JFhNVkQHLTzQjwvt4qIIJikzy0H1OnHduDbOOyIg3RME
	 U2iV3GS8+AtCZJeaAhVKLENCmSs7B4Rfr+XsP8xxwbEJiE2wWHb77cgN7adhVJu9sG
	 aDB8ajSP5YVai784gKmA6XjUHl7kCaSGzyieS1qs=
Date: Sun, 12 Jan 2025 10:57:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: asml.silence@gmail.com, axboe@kernel.dk, lizetao1@huawei.com,
	minhquangbui99@gmail.com
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: don't touch sqd->thread off tw
 add" failed to apply to 6.12-stable tree
Message-ID: <2025011206-flammable-underdone-de1e@gregkh>
References: <2025011256-extinct-expanse-d059@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025011256-extinct-expanse-d059@gregkh>

On Sun, Jan 12, 2025 at 10:36:56AM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x bd2703b42decebdcddf76e277ba76b4c4a142d73
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011256-extinct-expanse-d059@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From bd2703b42decebdcddf76e277ba76b4c4a142d73 Mon Sep 17 00:00:00 2001
> From: Pavel Begunkov <asml.silence@gmail.com>
> Date: Fri, 10 Jan 2025 20:36:45 +0000
> Subject: [PATCH] io_uring: don't touch sqd->thread off tw add
> 
> With IORING_SETUP_SQPOLL all requests are created by the SQPOLL task,
> which means that req->task should always match sqd->thread. Since
> accesses to sqd->thread should be separately protected, use req->task
> in io_req_normal_work_add() instead.
> 
> Note, in the eyes of io_req_normal_work_add(), the SQPOLL task struct
> is always pinned and alive, and sqd->thread can either be the task or
> NULL. It's only problematic if the compiler decides to reload the value
> after the null check, which is not so likely.
> 
> Cc: stable@vger.kernel.org
> Cc: Bui Quang Minh <minhquangbui99@gmail.com>
> Reported-by: lizetao <lizetao1@huawei.com>
> Fixes: 78f9b61bd8e54 ("io_uring: wake SQPOLL task when task_work is added to an empty queue")
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Link: https://lore.kernel.org/r/1cbbe72cf32c45a8fee96026463024cd8564a7d7.1736541357.git.asml.silence@gmail.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index d3403c8216db..5eb119002099 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -1226,10 +1226,7 @@ static void io_req_normal_work_add(struct io_kiocb *req)
>  
>  	/* SQPOLL doesn't need the task_work added, it'll run it itself */
>  	if (ctx->flags & IORING_SETUP_SQPOLL) {
> -		struct io_sq_data *sqd = ctx->sq_data;
> -
> -		if (sqd->thread)
> -			__set_notify_signal(sqd->thread);
> +		__set_notify_signal(tctx->task);
>  		return;
>  	}

Note, this breaks the build, it applies just fine, it's just that ->task
is not a valid field here :(

thanks,

greg k-h

