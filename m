Return-Path: <stable+bounces-23863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECF4868BA5
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADAF3B27CB9
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E01353F9;
	Tue, 27 Feb 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NU3Qnet5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D91332AA;
	Tue, 27 Feb 2024 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024801; cv=none; b=anpcvGmv7kvE9u3+w214eBtQ2HC9NKY42KJQafzuyQSoAgXUyCKvhUhf3anMMFGVBecto+ov8fMRJxc9ONZ/aMIeNqcaHs+pTptC8Af0uCVRs/9FNp9NE9qbCzj2MUWAVt47Vw7mWOzom277Pf7IsVoF2sdFwmYlM+JAV6LdGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024801; c=relaxed/simple;
	bh=TTZJrnTIFJCbLCIzk9Jv5e0pFgQa3oludyzZHZ81E74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmH7X5dBf69D1RdnJ2Na9+9kcFI4Ia9EIg1pDVwyUbkX+8lydMk8m/LDYVXBUxOCMLB8HB9uhFOoRrbfC6utcC5uEbQ6CY4vp5Q9mGUvxVnekRypemjdIByJWZMpGlCbyj6soOEdNJ1dg9EHpBrwGpyvfovDORP58ayolK9kkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NU3Qnet5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D8FC43390;
	Tue, 27 Feb 2024 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024800;
	bh=TTZJrnTIFJCbLCIzk9Jv5e0pFgQa3oludyzZHZ81E74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NU3Qnet5H/qUIgUxp0zxie5QxsJiS13J0MlfJ9N3eiVn4GoSwcP/901grM17n6FH+
	 eRmPC1ZcjCjFmgWNR23qpbFrVWO+F5a/o9kXKraLJ1KaJ2OeiNYItEedUj99OUgabx
	 KEjlp19ILK78asNqDP92B4Kf7Kr1xMIcT5LCtDiU=
Date: Tue, 27 Feb 2024 10:06:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: stable@vger.kernel.org, linux-m68k@vger.kernel.org,
	geert@linux-m68k.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: ataflop: more blk-mq refactoring fixes
Message-ID: <2024022726-magnitude-molecule-d251@gregkh>
References: <20240227013728.15935-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227013728.15935-1-schmitzmic@gmail.com>

On Tue, Feb 27, 2024 at 02:37:28PM +1300, Michael Schmitz wrote:
> [ commit d28e4dff085c5a87025c9a0a85fb798bd8e9ca17 upstream ]
> 
> As it turns out, my earlier patch in commit 86d46fdaa12a (block:
> ataflop: fix breakage introduced at blk-mq refactoring) was
> incomplete. This patch fixes any remaining issues found during
> more testing and code review.
> 
> Requests exceeding 4 k are handled in 4k segments but
> __blk_mq_end_request() is never called on these (still
> sectors outstanding on the request). With redo_fd_request()
> removed, there is no provision to kick off processing of the
> next segment, causing requests exceeding 4k to hang. (By
> setting /sys/block/fd0/queue/max_sectors_k <= 4 as workaround,
> this behaviour can be avoided).
> 
> Instead of reintroducing redo_fd_request(), requeue the remainder
> of the request by calling blk_mq_requeue_request() on incomplete
> requests (i.e. when blk_update_request() still returns true), and
> rely on the block layer to queue the residual as new request.
> 
> Both error handling and formatting needs to release the
> ST-DMA lock, so call finish_fdc() on these (this was previously
> handled by redo_fd_request()). finish_fdc() may be called
> legitimately without the ST-DMA lock held - make sure we only
> release the lock if we actually held it. In a similar way,
> early exit due to errors in ataflop_queue_rq() must release
> the lock.
> 
> After minor errors, fd_error sets up to recalibrate the drive
> but never re-runs the current operation (another task handled by
> redo_fd_request() before). Call do_fd_action() to get the next
> steps (seek, retry read/write) underway.
> 
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Fixes: 6ec3938cff95f (ataflop: convert to blk-mq)
> Fixes: 86d46fdaa12a (block: ataflop: fix breakage introduced at blk-mq refactoring)
> CC: stable@vger.kernel.org # 5.10.x
> Link: https://lore.kernel.org/r/20211024002013.9332-1-schmitzmic@gmail.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> [MSch: v5.10 backport merge conflict fix]

Now queued up, thanks.

greg k-h

