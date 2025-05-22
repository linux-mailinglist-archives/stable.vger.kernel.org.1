Return-Path: <stable+bounces-146113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612BFAC123B
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 19:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0AF3B137A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807618FDBE;
	Thu, 22 May 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LG1VvoQo"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49E189F57
	for <stable@vger.kernel.org>; Thu, 22 May 2025 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935536; cv=none; b=UksLY2tTLKezdqiI/VoWHCH4eNPVqJXSAkrsaVgb2kOdGMEcdLXk2+P28tNkAkiHasKrBkLboqmooFnGAaqu3lRqIKrRu8QiPpoGKCvfjc5ziGzPKQsdhicxR+SBc9c89g7qf6hdqW3JSbdwLXZJxP+nFWCK2ns8R7T+PjJGsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935536; c=relaxed/simple;
	bh=mPNvJWQfwSWJIqhLs1HlrDn/WYuYPmB8wfxtTNGfuDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jp/8ZoBN0y2cBurcYm8o0R83OPPdx+i/HZnljixjm8MsTVwkg295flSGPT7tXjzChKN3sH0BHGLjV08jP6cssQfHO0qgOBHC8+8+uannuR6+ja7x9kvBaYDB7dZlJhiL/WN9yOzc3nJIlnNh/0evblsfqbARJCQEUjjPI3/9I3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LG1VvoQo; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8647a81e683so203650339f.1
        for <stable@vger.kernel.org>; Thu, 22 May 2025 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747935533; x=1748540333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nM6gVpWW7hwcfcfH51deVSV04V713QkHpPw2pc8ZGq0=;
        b=LG1VvoQoDhqaMS4RWdQx94vF+mu/UYVO0FnOsD3JF0toWz9MjUzjIYKnl7/XHPKErf
         ZdCNevR+O8TMusd0tQPQTjWFhabBk6GckLrwIMRr+5T4S22Xk0tjEpNZsx47DdmZN+aK
         SgmeKJe46M9ssZApIJVJsxf15hAFiP6c79CRqLlP5M9tL+c0o9C15qOe9GuGik7hOuHS
         Kp7fR5rxjE6GkPGchRPJU6OkCEYGl3JzFNFZb/2ydoLHrFONZtAAiBa+Dnn3vMHYywot
         DUjV5fVw3+aTmV9R0viM0RReHocOThudTOlcN5DvBqFCPIeiBV026/vc64T2JeQH0N3U
         gY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747935533; x=1748540333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nM6gVpWW7hwcfcfH51deVSV04V713QkHpPw2pc8ZGq0=;
        b=b+L4rL0eIKoPSdD1rzKKpTdDjDcYQqq00IwgpUkzLV3tDlu12HjQ5R8e+kDd9UzuVA
         bucQFNo0NORp/4EwYKVXSGlny0UG7JivgGWbVtkMi4dMWa9vhsZl3lLkpAVvEOjN7UOV
         zeIaIGqzciFE8BLzJ6AZmW5Lnro1DgSWcC+9H183d7IufAGiEZrO9v0Den2zUz/Bi0gh
         beMrm+zSORZHfNMWXKyUUWIKp5QZMWIqiAN1qG35ITlVn7hHuOcCafi0pl5RMftPH9CF
         UmqeWna/8CeGKgG2lTbydhFb2q/MZcUpLeT/lcW9I7HeC9XdGZv+UtS/54k0xj31RH8Q
         ug9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+odoTG8axcE3HMPoihSZPvKxENMH1CcxuN1uNLQjqTXAN7Ro2GbSymb08DNTFV/ZnyUTf5oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykqD5TCzKfYG3kyxqlOuo0ij1VM8at6uxXvNUQvBs/AT/lRKVt
	43lSj7R6+sz28jZpp1wRRsCMcgPveJ5UTs8iK5xaBZuofejtF5OdRtV5LSHvhnxotgw3rMnoUNP
	isP+f
X-Gm-Gg: ASbGncsz9ANfKK22d32Wcx5XsqxTJZvZfuN5V2S2oS59dSlB2QU8DqSIBAKty4vWd7q
	E4gZMoaEP5pLnByhRfo8rR7zA/UaIJSLD5Ufy6DI772emLvrf/zDbgzLQ/YlwhbyJZgLiWhqJzj
	RkeQWVzmDg1NcEmpxLaggHXdlX1XMyPC4FBrnVqa7o28sNfeKHiJPem38jMUPU4Nd4w9IAf24WE
	0Wgd3Ui4M6kNNqi1jRNdLem3wF4Cel5rVUNlTlbi1URxhQ1MLoTh5x4BwM3vBY2Hxs0HMtfV0w2
	KthV3nDKmdBME2pSZjKSz+OTnn2QDEG19fdohBwyDg3xq2w=
X-Google-Smtp-Source: AGHT+IF6b+fW8vRi48fyuKhfYCPzjJZNoYLDWjSHJ031JPvz5fE62vULtRWlBoHyfcTLf0e9Puh3Xg==
X-Received: by 2002:a05:6602:371b:b0:85b:3f1a:30aa with SMTP id ca18e2360f4ac-86a23229aabmr3343648039f.9.1747935532879;
        Thu, 22 May 2025 10:38:52 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a236e69acsm313856039f.31.2025.05.22.10.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 10:38:52 -0700 (PDT)
Message-ID: <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
Date: Thu, 22 May 2025 11:38:51 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250522171405.3239141-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 11:14 AM, Bart Van Assche wrote:
> blk_mq_freeze_queue() never terminates if one or more bios are on the plug
> list and if the block device driver defines a .submit_bio() method.
> This is the case for device mapper drivers. The deadlock happens because
> blk_mq_freeze_queue() waits for q_usage_counter to drop to zero, because
> a queue reference is held by bios on the plug list and because the
> __bio_queue_enter() call in __submit_bio() waits for the queue to be
> unfrozen.
> 
> This patch fixes the following deadlock:
> 
> Workqueue: dm-51_zwplugs blk_zone_wplug_bio_work
> Call trace:
>  __schedule+0xb08/0x1160
>  schedule+0x48/0xc8
>  __bio_queue_enter+0xcc/0x1d0
>  __submit_bio+0x100/0x1b0
>  submit_bio_noacct_nocheck+0x230/0x49c
>  blk_zone_wplug_bio_work+0x168/0x250
>  process_one_work+0x26c/0x65c
>  worker_thread+0x33c/0x498
>  kthread+0x110/0x134
>  ret_from_fork+0x10/0x20
> 
> Call trace:
>  __switch_to+0x230/0x410
>  __schedule+0xb08/0x1160
>  schedule+0x48/0xc8
>  blk_mq_freeze_queue_wait+0x78/0xb8
>  blk_mq_freeze_queue+0x90/0xa4
>  queue_attr_store+0x7c/0xf0
>  sysfs_kf_write+0x98/0xc8
>  kernfs_fop_write_iter+0x12c/0x1d4
>  vfs_write+0x340/0x3ac
>  ksys_write+0x78/0xe8
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Yu Kuai <yukuai1@huaweicloud.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> 
> Changes compared to v1: fixed a race condition. Call bio_zone_write_plugging()
>   only before submitting the bio and not after it has been submitted.
> 
>  block/blk-core.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b862c66018f2..713fb3865260 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -621,6 +621,13 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  	return BLK_STS_OK;
>  }
>  
> +/*
> + * Do not call bio_queue_enter() if the BIO_ZONE_WRITE_PLUGGING flag has been
> + * set because this causes blk_mq_freeze_queue() to deadlock if
> + * blk_zone_wplug_bio_work() submits a bio. Calling bio_queue_enter() for bios
> + * on the plug list is not necessary since a q_usage_counter reference is held
> + * while a bio is on the plug list.
> + */
>  static void __submit_bio(struct bio *bio)
>  {
>  	/* If plug is not used, add new plug here to cache nsecs time. */
> @@ -633,8 +640,12 @@ static void __submit_bio(struct bio *bio)
>  
>  	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
>  		blk_mq_submit_bio(bio);
> -	} else if (likely(bio_queue_enter(bio) == 0)) {
> +	} else {
>  		struct gendisk *disk = bio->bi_bdev->bd_disk;
> +		bool zwp = bio_zone_write_plugging(bio);
> +
> +		if (unlikely(!zwp && bio_queue_enter(bio) != 0))
> +			goto finish_plug;
>  	
>  		if ((bio->bi_opf & REQ_POLLED) &&
>  		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
> @@ -643,9 +654,12 @@ static void __submit_bio(struct bio *bio)
>  		} else {
>  			disk->fops->submit_bio(bio);
>  		}
> -		blk_queue_exit(disk->queue);
> +
> +		if (!zwp)
> +			blk_queue_exit(disk->queue);
>  	}

This is pretty ugly, and I honestly absolutely hate how there's quite a
bit of zoned_whatever sprinkling throughout the core code. What's the
reason for not unplugging here, unaligned writes? Because you should
presumable have the exact same issues on non-zoned devices if they have
IO stuck in a plug (and doesn't get unplugged) while someone is waiting
on a freeze.

A somewhat similar case was solved for IOPOLL and queue entering. That
would be another thing to look at. Maybe a live enter could work if the
plug itself pins it?

-- 
Jens Axboe

