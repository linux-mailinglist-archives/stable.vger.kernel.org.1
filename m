Return-Path: <stable+bounces-135110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C821BA96903
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1068C17D222
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1428627C85F;
	Tue, 22 Apr 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hW7f/Ol3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F61F2C52
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324502; cv=none; b=Q6xAVLG8NrM/jidWpmEjvy3W8JaW7zcyzKBZ1ki39RKmJnhck9EsLutBUroOaBYrtmNdOCvEGskfCBS6cSNp2q00hpfEySz1Fo5phimQDB/r5dQtkNDRX5PEjSUlKTsuoJ7SNKwVzdbxtVoAL0Qo9o0s9z/7O6Rbjphoy/0Ar+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324502; c=relaxed/simple;
	bh=lf0LhBGzLdmzGwWcHpTy2pWAzeDkex6Gxkosgmr/sBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYrtuA18st+5UQXFBxgfaJFsq4mLWDoEp615nno6FLO9aM7xi8mPKdilL0PU3mOoAlLsLGTGxtp2nExByNHX9ghuf780/wtmf2NAolu96WEFUMkOJEf9rxkpwPVX/nVsj5nFTijOduxN1vN/uFT6chzbdC8R8LXxRdRD97HrYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hW7f/Ol3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DEFC4CEE9;
	Tue, 22 Apr 2025 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745324500;
	bh=lf0LhBGzLdmzGwWcHpTy2pWAzeDkex6Gxkosgmr/sBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hW7f/Ol3TZTXOcGmTJhYrSqCsVlz+NlhXALVOLlxOURNbMx967CzOzzisIBt7+2tn
	 QrgauQTIsqOnoUFb/6wPmlX7mAFwVBgS6lIVbBzrpEiao68pQlzBLaHMy6u4UljiHf
	 yBkLSOPDe9okoBJR4tGFwnOKYpaHJcqSI6vBvFG4=
Date: Tue, 22 Apr 2025 14:21:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: stable@vger.kernel.org, muchun.song@linux.dev,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5.15.y] block: fix ordering between checking
 QUEUE_FLAG_QUIESCED request adding
Message-ID: <2025042259-gab-earflap-ba40@gregkh>
References: <2024120342-monsoon-wildcat-d0a1@gregkh>
 <20250317072021.22578-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317072021.22578-1-songmuchun@bytedance.com>

On Mon, Mar 17, 2025 at 03:20:21PM +0800, Muchun Song wrote:
> Supposing the following scenario.
> 
> CPU0                        CPU1
> 
> blk_mq_insert_request()     1) store
>                             blk_mq_unquiesce_queue()
>                             blk_queue_flag_clear()                3) store
>                               blk_mq_run_hw_queues()
>                                 blk_mq_run_hw_queue()
>                                   if (!blk_mq_hctx_has_pending()) 4) load
>                                     return
> blk_mq_run_hw_queue()
>   if (blk_queue_quiesced()) 2) load
>     return
>   blk_mq_sched_dispatch_requests()
> 
> The full memory barrier should be inserted between 1) and 2), as well as
> between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED
> is cleared or CPU1 sees dispatch list or setting of bitmap of software
> queue. Otherwise, either CPU will not rerun the hardware queue causing
> starvation.
> 
> So the first solution is to 1) add a pair of memory barrier to fix the
> problem, another solution is to 2) use hctx->queue->queue_lock to
> synchronize QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since
> memory barrier is not easy to be maintained.
> 
> Fixes: f4560ffe8cec ("blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue")
> Cc: stable@vger.kernel.org
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Link: https://lore.kernel.org/r/20241014092934.53630-3-songmuchun@bytedance.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> (cherry picked from commit 6bda857bcbb86fb9d0e54fbef93a093d51172acc)

For obvious reasons we can not take a change for an older stable kernel
tree, and NOT a newer one.

Please resubmit the backports for ALL relevant stable kernel branches.
You do not want to upgrade and have a regression.

thanks,

greg k-h

