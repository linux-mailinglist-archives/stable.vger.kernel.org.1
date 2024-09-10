Return-Path: <stable+bounces-75647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE51F973880
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4BB1C2471B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85E191F7B;
	Tue, 10 Sep 2024 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CQM5Gegt"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD8137772
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974540; cv=none; b=hoS6xGNh7Z0O1EkQh5ZjmExd5chv6gzXqClBXg7uaUosuSUEMvL+ZnRO/fDFc6c4JVC20gYMFEJqHNbZFnHF9mkF2CtlLjKIEBvp7S/UbVBsHrL0vToGobw3/LzuXLnVQCSSs2AyWTSlUR2rZEGZgZ4Y/8PwllyJKa0jmpNMSHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974540; c=relaxed/simple;
	bh=deRKyH3f6+NKtnRTdaKPmr3pYmPE5cboc2WOMy0EHUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fd8O0XM3S+TJlUlc60AGbsXVvYyaSEnQSMF0A6qUboLoRX1zY/ZBdNJ711lzFXwExLdxH7Go6ebnHSNg77xg7v1t+JL0gzEpAGz/Ncw/Zxxnz2giUx15GJIe0Jgf3VFY+Mx7IsqkzL9xtn/hbYSXQ2O2vEDYqzj7q10JjaM+XWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CQM5Gegt; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82a151a65b8so34362539f.2
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725974538; x=1726579338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bj56BQt9ZSzV0CrSCRpKEAjflySC2ncoGghlooYLTWU=;
        b=CQM5Gegt6FYiLtDD6/7i1b0GDgWgP034WLtT0SIJfqfJ7O3jn6nqn1NarLtIOYLLz0
         ZS0or9c3G1/x3YWgeJFuIV++RvPLfeow6laHFlco8Qeg3kIe14Usp2pNm3+sXBhwzopP
         MCSVPx6341ff5Elt00nBCVShxfb+vcREpHo18a7zMCmX5bZKYJ+c1dxHnYQwQPjOHWRj
         AphkHfarSBq6hcwvyDNXeJnSLpx+1akqVyO8ncBqaucH8awpZNiCSlvh1l5tWb8tC9v7
         09T6QLt/NerCNK3R62JlP2L0/y0PqB/n21X4qiEq2niqiFDLgFQQV927bBR1JCzOwicO
         G2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725974538; x=1726579338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bj56BQt9ZSzV0CrSCRpKEAjflySC2ncoGghlooYLTWU=;
        b=gFc36HOnydPovST31vGDB25si5R6ZTPVD2MgvQB+DoyFLJKjua/oPtxgEQl3BMVRdm
         ot1lRNez4g73iz2nXQHQF64Is91nFxrwR9EXECiINbS459X8VkhlToxgLU7kl7qWtZNY
         5vclyzsMrSNEs8O8AKPYqF2rLrDznaqinwz3Ufai1KWxEiOcigdtzm25pGDqnuEZGWqj
         jnxhcNcikTGMHN/82HLYgwt3Rk+EqHSkU9Ic0kBaqPEoySyXpEVLSPx/xscfhcHLfeRs
         N+XndDH849QL9Hv6bdIM/SSIV6BCxa9zx6FYy/aggpIK7D/bAngUJaIrnyWpx6iXpsKi
         SuRg==
X-Forwarded-Encrypted: i=1; AJvYcCWmGoO7M84uvgSVNleqBbo0jCBtVEQDtF6TeYA1/cRVWAHk/Tao8MUq3C6QGlmvYVFlRqDsR04=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa7giYTckICS9UmX2I7VylrMd3yMaZa+r7FuutcygON+T4hMi/
	QKir2gVn6y8CkHVEKrSiIRfv7qUo98EXmfCbJFFmYmbVqUxgcTaMttLHQdHCLNA=
X-Google-Smtp-Source: AGHT+IE6MBNDyrVhEBsA4cssk0boKT8bpHfdlLhGwbiFavLD+EsZvuXgAzGuMVZ/V1JjVtUTIwc85A==
X-Received: by 2002:a05:6602:6281:b0:82c:d966:6bf7 with SMTP id ca18e2360f4ac-82cd9666ce0mr999405339f.6.1725974537925;
        Tue, 10 Sep 2024 06:22:17 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa77b2a97sm202153339f.50.2024.09.10.06.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 06:22:17 -0700 (PDT)
Message-ID: <91ce06c7-6965-4d1d-8ed4-d0a6f01acecf@kernel.dk>
Date: Tue, 10 Sep 2024 07:22:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] block: fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests
To: Muchun Song <songmuchun@bytedance.com>, ming.lei@redhat.com,
 yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 muchun.song@linux.dev, stable@vger.kernel.org
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-3-songmuchun@bytedance.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240903081653.65613-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 2:16 AM, Muchun Song wrote:
> Supposing the following scenario.
> 
> CPU0                                        CPU1
> 
> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
> blk_mq_run_hw_queue()                       blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
>     if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
>         return                                      blk_mq_run_hw_queue()
>     blk_mq_sched_dispatch_requests()                    if (!blk_mq_hctx_has_pending())     4) load
>                                                            return
> 
> The full memory barrier should be inserted between 1) and 2), as well as
> between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
> cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
> Otherwise, either CPU will not re-run the hardware queue causing starvation.
> 
> So the first solution is to 1) add a pair of memory barrier to fix the
> problem, another solution is to 2) use hctx->queue->queue_lock to synchronize
> QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory barrier is not
> easy to be maintained.

Same comment here, 72-74 chars wide please.

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b2d0f22de0c7f..ac39f2a346a52 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2202,6 +2202,24 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
>  }
>  EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>  
> +static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hctx)
> +{
> +	bool need_run;
> +
> +	/*
> +	 * When queue is quiesced, we may be switching io scheduler, or
> +	 * updating nr_hw_queues, or other things, and we can't run queue
> +	 * any more, even blk_mq_hctx_has_pending() can't be called safely.
> +	 *
> +	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
> +	 * quiesced.
> +	 */
> +	__blk_mq_run_dispatch_ops(hctx->queue, false,
> +				  need_run = !blk_queue_quiesced(hctx->queue) &&
> +					      blk_mq_hctx_has_pending(hctx));
> +	return need_run;
> +}

This __blk_mq_run_dispatch_ops() is also way too wide, why didn't you
just break it like where you copied it from?

> +
>  /**
>   * blk_mq_run_hw_queue - Start to run a hardware queue.
>   * @hctx: Pointer to the hardware queue to run.
> @@ -2222,20 +2240,23 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>  
>  	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
>  
> -	/*
> -	 * When queue is quiesced, we may be switching io scheduler, or
> -	 * updating nr_hw_queues, or other things, and we can't run queue
> -	 * any more, even __blk_mq_hctx_has_pending() can't be called safely.
> -	 *
> -	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
> -	 * quiesced.
> -	 */
> -	__blk_mq_run_dispatch_ops(hctx->queue, false,
> -		need_run = !blk_queue_quiesced(hctx->queue) &&
> -		blk_mq_hctx_has_pending(hctx));
> +	need_run = blk_mq_hw_queue_need_run(hctx);
> +	if (!need_run) {
> +		unsigned long flags;
>  
> -	if (!need_run)
> -		return;
> +		/*
> +		 * synchronize with blk_mq_unquiesce_queue(), becuase we check
> +		 * if hw queue is quiesced locklessly above, we need the use
> +		 * ->queue_lock to make sure we see the up-to-date status to
> +		 * not miss rerunning the hw queue.
> +		 */
> +		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
> +		need_run = blk_mq_hw_queue_need_run(hctx);
> +		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
> +
> +		if (!need_run)
> +			return;
> +	}

Is this not solvable on the unquiesce side instead? It's rather a shame
to add overhead to the fast path to avoid a race with something that's
super unlikely, like quisce.

-- 
Jens Axboe

