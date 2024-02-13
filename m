Return-Path: <stable+bounces-19765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA588535C7
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A8028B823
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626765F861;
	Tue, 13 Feb 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iBM8xcfR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233245DF29
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840940; cv=none; b=RCTioOVmSRCnCoUPu07KMIxazNa7GTiPOVrTXq4zsH2Njn5vja10Nv7xG69sbUrr6yaV7+GLMVjxJKBIICIMenTdRoG3aPL6VNb3Q11YnSk352mqDRqS+wvoTog1vBzEAApc8aoplO9krSGoEXGBx01RFLEcaTOo1iAJj5ePC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840940; c=relaxed/simple;
	bh=akd0A5+FmfHrTd9vUQMWkmJOUf4lxMShaaRQUOV3zlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6Gdt9B81F1BRcO8Ts20EJNH7XT9kE/tTsOCpuAbeMrXCkLpb5o3a/swM9fb/JjUXJA6WrGu5Jek/64cAYpbc/AdOB9gtU3r/WBWR/nA6MtHGyBRAm8fFaH6B8Vow3MXDDVDMd399+ikuj2WKNls1Scq0oBeeYoaJFRzlCaQgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iBM8xcfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F62C433C7;
	Tue, 13 Feb 2024 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707840939;
	bh=akd0A5+FmfHrTd9vUQMWkmJOUf4lxMShaaRQUOV3zlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBM8xcfRSCm64UrQ2GkQla4BA01wVEolQ3FXHTvMmwJ4/nZONgrD+8IVYQe5NsRW7
	 I2v+bWOz0s0pWa499CvQoZRjo5REFhSfeKwkh3oF9Q//j1qlu60i2NNH25hp1Qwgso
	 iXXs38Ta7VRvLPUbgIZgDf6LOKeW/sY2fc/9UgCM=
Date: Tue, 13 Feb 2024 17:15:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/net: limit inline multishot
 retries" failed to apply to 6.6-stable tree
Message-ID: <2024021304-flypaper-oat-7707@gregkh>
References: <2024021330-twice-pacify-2be5@gregkh>
 <57ad4fde-f1f4-405b-a1cb-8a1af9471da4@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57ad4fde-f1f4-405b-a1cb-8a1af9471da4@kernel.dk>

On Tue, Feb 13, 2024 at 07:52:53AM -0700, Jens Axboe wrote:
> On 2/13/24 6:19 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 76b367a2d83163cf19173d5cb0b562acbabc8eac
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021330-twice-pacify-2be5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Here's the series for 6.6-stable.
> 
> -- 
> Jens Axboe
> 

> From 582cc8795c22337041abc7ee06f9de34f1592922 Mon Sep 17 00:00:00 2001
> From: Jens Axboe <axboe@kernel.dk>
> Date: Mon, 29 Jan 2024 11:52:54 -0700
> Subject: [PATCH 1/4] io_uring/poll: move poll execution helpers higher up
> 
> Commit e84b01a880f635e3084a361afba41f95ff500d12 upstream.
> 
> In preparation for calling __io_poll_execute() higher up, move the
> functions to avoid forward declarations.
> 
> No functional changes in this patch.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  io_uring/poll.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/io_uring/poll.c b/io_uring/poll.c
> index a4084acaff91..a2f21ae093dc 100644
> --- a/io_uring/poll.c
> +++ b/io_uring/poll.c
> @@ -226,6 +226,30 @@ enum {
>  	IOU_POLL_REISSUE = 3,
>  };
>  
> +static void __io_poll_execute(struct io_kiocb *req, int mask)
> +{
> +	io_req_set_res(req, mask, 0);
> +	/*
> +	 * This is useful for poll that is armed on behalf of another
> +	 * request, and where the wakeup path could be on a different
> +	 * CPU. We want to avoid pulling in req->apoll->events for that
> +	 * case.
> +	 */
> +	if (req->opcode == IORING_OP_POLL_ADD)
> +		req->io_task_work.func = io_poll_task_func;
> +	else
> +		req->io_task_work.func = io_apoll_task_func;
> +
> +	trace_io_uring_task_add(req, mask);
> +	io_req_task_work_add(req);
> +}
> +
> +static inline void io_poll_execute(struct io_kiocb *req, int res)
> +{
> +	if (io_poll_get_ownership(req))
> +		__io_poll_execute(req, res);
> +}
> +
>  /*
>   * All poll tw should go through this. Checks for poll events, manages
>   * references, does rewait, etc.
> @@ -372,30 +396,6 @@ static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
>  		io_req_complete_failed(req, ret);
>  }
>  
> -static void __io_poll_execute(struct io_kiocb *req, int mask)
> -{
> -	io_req_set_res(req, mask, 0);
> -	/*
> -	 * This is useful for poll that is armed on behalf of another
> -	 * request, and where the wakeup path could be on a different
> -	 * CPU. We want to avoid pulling in req->apoll->events for that
> -	 * case.
> -	 */
> -	if (req->opcode == IORING_OP_POLL_ADD)
> -		req->io_task_work.func = io_poll_task_func;
> -	else
> -		req->io_task_work.func = io_apoll_task_func;
> -
> -	trace_io_uring_task_add(req, mask);
> -	io_req_task_work_add(req);
> -}
> -
> -static inline void io_poll_execute(struct io_kiocb *req, int res)
> -{
> -	if (io_poll_get_ownership(req))
> -		__io_poll_execute(req, res);
> -}
> -

This first patch fails to apply to the 6.6.y tree, are you sure you made
it against the correct one?  These functions do not look like this to
me.

confused,

greg k-h

