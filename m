Return-Path: <stable+bounces-26743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8985A87192B
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 10:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4645F281782
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D257A4F898;
	Tue,  5 Mar 2024 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc/+uHGp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF164DA1F;
	Tue,  5 Mar 2024 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629867; cv=none; b=EFSYKlUrb5NB6IntO3KA3jW9t9DzE2UZ5Ukjk9DOsauzE2JKe7hCgHAeDwRN7fu1Gy6xezIBq7ax/a7uV4S7ADWTeWvUS6QegrQ1JW2ZkOvRQwoLpprkYYfr3/ctUTw0LLYpNXIUNvB+czPAaLtcPLHivBcqUnowjwNchP35X1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629867; c=relaxed/simple;
	bh=H+2wlslZkHG5WJTMkedhIAxZ71n6oHIBbYXZAqgOaZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAsrFsyVEKkRlIfVyWYBcIGu7AwL5vqX85jLGMczSQW29Lpkaq/f/kwd0PCqeah80YDyt1DAOe4+CizJB7xafSGQ2a++5r44zqsD7px0s1o4qvomlck5/yqT6RTR/vxYe3WsaQt4UaFHstfPQGUI/YcGMyR57QnVA0eM6ZrdZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc/+uHGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D16C43394;
	Tue,  5 Mar 2024 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709629867;
	bh=H+2wlslZkHG5WJTMkedhIAxZ71n6oHIBbYXZAqgOaZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uc/+uHGpnp1P2VH3AWg0LLYN1WK+jtpThZcZpatgIWyYJqafxriuAeORhX2Tb/oF/
	 JISu5NenwDGh1LqcXMIPJx0/rHkMLoPhtI5mNmed7b6TIeMti00+c/FobEZSqc6JXu
	 RKUE5ptAnoDyy5vQXRWPWzuTSQ+T4y3/sJK3UwlVOsIBc/fnTMogrmFF11HzGd3o5B
	 vZ8jBUnhGPTdQPTEXDOzv5s5F4+uZxuznlV/U9zZP3x7cf0adx9fgfxQ/K3imMS01v
	 pnBnHTpAu8xgi8wqikA7GHev5BBoUKvOUXXhiUh2xOPjEmogOazBinXeTjxSV5R0wn
	 9nE2tj92VH72A==
Date: Tue, 5 Mar 2024 10:11:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>, 
	Eric Biggers <ebiggers@kernel.org>, Benjamin LaHaise <ben@communityfibre.ca>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Eric Biggers <ebiggers@google.com>, Avi Kivity <avi@scylladb.com>, 
	Sandeep Dhavale <dhavale@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb
 conversion
Message-ID: <20240305-leerlauf-hinauf-b44c47f26f4e@brauner>
References: <20240304235715.3790858-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304235715.3790858-1-bvanassche@acm.org>

On Mon, Mar 04, 2024 at 03:57:15PM -0800, Bart Van Assche wrote:
> The first kiocb_set_cancel_fn() argument may point at a struct kiocb
> that is not embedded inside struct aio_kiocb. With the current code,
> depending on the compiler, the req->ki_ctx read happens either before
> the IOCB_AIO_RW test or after that test. Move the req->ki_ctx read such
> that it is guaranteed that the IOCB_AIO_RW test happens first.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Cc: Benjamin LaHaise <ben@communityfibre.ca>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Avi Kivity <avi@scylladb.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: stable@vger.kernel.org
> Fixes: b820de741ae4 ("fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

Can I please get a review from Eric and/or Benjamin, please?

>  fs/aio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index da18dbcfcb22..9cdaa2faa536 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -589,8 +589,8 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  
>  void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
>  {
> -	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
> -	struct kioctx *ctx = req->ki_ctx;
> +	struct aio_kiocb *req;
> +	struct kioctx *ctx;
>  	unsigned long flags;
>  
>  	/*
> @@ -600,9 +600,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
>  	if (!(iocb->ki_flags & IOCB_AIO_RW))
>  		return;
>  
> +	req = container_of(iocb, struct aio_kiocb, rw);
> +
>  	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
>  		return;
>  
> +	ctx = req->ki_ctx;
> +
>  	spin_lock_irqsave(&ctx->ctx_lock, flags);
>  	list_add_tail(&req->ki_list, &ctx->active_reqs);
>  	req->ki_cancel = cancel;

