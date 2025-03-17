Return-Path: <stable+bounces-124603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F76A64241
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7EF16F13A
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DDE219A67;
	Mon, 17 Mar 2025 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cMBbEt1P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707F1E1E0F
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194666; cv=none; b=OEQ2OR5SP1A+1vNAlvgUzN6zeB8lwIw9fjvTdNC5NrsOJp9F+KeRP0202Ch9G+Un76CGjM8QLWf88DELtEWd/cKX9GLoEgEFb6oIFqLLlHDDaI2aGKSmbYsi0NxzG1kfqWLkHC2L9Q0F34CaI/cHK+4Y16xAvrQHJVA3aD3rehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194666; c=relaxed/simple;
	bh=XoVpvDD3wi+6rUEhRrIrtNgQ9W31eLQuA8PREg3BFUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD+Oxgwrp8CLoiGAgODXmjcqeFsO8xJmc8qqnb7QH+j2w1P90OdpTVcyKXDe65ckP7rpetop2smrwF5048QiPG4TSrWl//cE5Hj1VCX4E+N3xTnYVnm39rA4yMku+OpgMHtb2AFuJjhtkwMw7vXpcpqSP37s9UFCVRzzPMhm4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cMBbEt1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BBBC4CEE3;
	Mon, 17 Mar 2025 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742194664;
	bh=XoVpvDD3wi+6rUEhRrIrtNgQ9W31eLQuA8PREg3BFUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMBbEt1PYkCfbHHTNM/U8reAeYsRjnm0J1ccwqXBHgeMcOa3h/Ify+NL2Ev46kPEF
	 mrDv3101TsBGyy85cQ6fUvogGfB40lU22pxiMDeEp4HdrLPMNUlFkvmXBtdvb3N/Re
	 64whE8iHgD4iTUNubeYDWaQPTUT1RGq+jnTmWUVs=
Date: Mon, 17 Mar 2025 07:56:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: stable@vger.kernel.org, muchun.song@linux.dev,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5.15.y] block: fix ordering between checking
 QUEUE_FLAG_QUIESCED request adding
Message-ID: <2025031712-defame-kite-f9af@gregkh>
References: <2024120342-monsoon-wildcat-d0a1@gregkh>
 <20250317032934.6093-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317032934.6093-1-songmuchun@bytedance.com>

On Mon, Mar 17, 2025 at 11:29:34AM +0800, Muchun Song wrote:
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
> ---
>  block/blk-mq.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

