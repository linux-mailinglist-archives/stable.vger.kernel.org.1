Return-Path: <stable+bounces-75649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A99973887
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D8FB25D91
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A57191F94;
	Tue, 10 Sep 2024 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wjqq6YcI"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437218FC67
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974576; cv=none; b=fJM9VU3/GIvVo9bbkL+QkZEMUEbazNSwsCigZNdmODuUB6M6RtkmS4fT7DPMd5+Tn9c3DqOR9jO/Wx3vg+dXtTWLtWkDkScqMmjZGP9sSSBzYD2LSRMvlzPMhWoMxzDdwFtib2me9kaHrqz/R4XhMI14r3j3gKjVn9kG6wV//h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974576; c=relaxed/simple;
	bh=f3PKTxtggDOgToEGYYGgjQ0uDntcy+Y/oFBGor32rWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxFySB1grMTk9AWxATQAYb3I0pCdVH2zUpLlLFC6VOTRP35D5TeKeIGDfnwIoo+VUsQ5UQ+VgaZEIuv5ZxmGmqGu67ft/yH/FjKbUYkSLv7Ns2ZbiPTwJDZbxVzNyYme74lyGSF1kkCqCpAex2YuyXtLFT3UfghXh3ddIBs3pFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Wjqq6YcI; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39f54ab8e69so22690215ab.1
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725974574; x=1726579374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zsz2DawbKokjmCBHoMj/5IgWeYCvivyMxUGL8HZEg8Y=;
        b=Wjqq6YcIwekcYIUP82qaSo5KJRNUo/vaoYe6mbB4Gu5qDpHtmn0ea0wKVoaxC2jrr2
         CgTE9MRUyj0jkMbwTmFHAGpNwWZ75opRaDmCbdrzWhOIO8FxGLEPj0pZZEtJ3LZQ/RZb
         77obYaHF8oEuyOQgTU3zgmlOENzKP74hYg9dxc0Pzrp4Mw2q/w+tN7RoC27wZcZBNqtf
         brnMkgUH8kOZMvFp/BVyUt1RMCsQPeMGQNm1emjrSV68iOnsnWg4v6DNel9tt2YN4ZO2
         QFeKvyNMoL/dPFNE8MgDuav213H/7XU3S0raD2dhPrkmLi+AfCfgnbeVgErtnLgSAiIk
         a0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725974574; x=1726579374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsz2DawbKokjmCBHoMj/5IgWeYCvivyMxUGL8HZEg8Y=;
        b=BDYtV6RB8VOJaQyYQDSaer8B0BMqRjgoQR3SvF+n69Z7NeLmn+pKMptDnbX+oKoSjy
         p3tBdp1vEJOEOtlvQgNh1eVNslfFmmVfd6eRcJJeBSYpKMwlCbcMfNM4vLA0plcWdSYq
         8yuYUtBXDp20QJj0XqNeVnobYcnD5vqB5OignPTictg3qJ3sG8U/hVJgIDb+yhvahqeg
         5CRIaAPSV3zlw1TesamQWz6q/ET5fDSTtZIG7h+d8SLZIzo1mGpK5ThgAgKWp+iBm1+A
         QnP5JxOn9v1zdVdKxD1GsWXiVQHWIc+pGyJKnCmCwRwYFIB6YjMhFcvQ1XtDpSSqYWwb
         aRUg==
X-Forwarded-Encrypted: i=1; AJvYcCW8w7xaj8riPiVgspFiJnYAtDG+gQamu8zc93fCvnB+PYzeSwqxEXs2qwM8q2calKCl92FBuFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRRWPUveR6uM/Ajy1pDTQxNODWc+ETBYrRNVCg3vE3X7CTIQ3Z
	2krEYbo/BMwWYAyo6+S56/bnYwj603Lhr339aflrZKTRd1HH7a1+xTBmCCV9gL8=
X-Google-Smtp-Source: AGHT+IHDvPZKRi5OPPT6Zxfq8GNcWYpeSOUaFFkDUjr74r3mQgiKPzPecXFzXvcX2Pd0XEIj7P7WGQ==
X-Received: by 2002:a05:6e02:17c6:b0:39f:558a:e414 with SMTP id e9e14a558f8ab-3a06b15a49emr25341685ab.7.1725974574552;
        Tue, 10 Sep 2024 06:22:54 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0590161cfsm20022565ab.77.2024.09.10.06.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 06:22:54 -0700 (PDT)
Message-ID: <db5193e8-5b8e-46f9-bbfc-a1821217f5a6@kernel.dk>
Date: Tue, 10 Sep 2024 07:22:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] block: fix ordering between checking
 BLK_MQ_S_STOPPED and adding requests
To: Muchun Song <songmuchun@bytedance.com>, ming.lei@redhat.com,
 yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 muchun.song@linux.dev, stable@vger.kernel.org
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-4-songmuchun@bytedance.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240903081653.65613-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 2:16 AM, Muchun Song wrote:
> Supposing first scenario with a virtio_blk driver.
> 
> CPU0                                                                CPU1
> 
> blk_mq_try_issue_directly()
>     __blk_mq_issue_directly()
>         q->mq_ops->queue_rq()
>             virtio_queue_rq()
>                 blk_mq_stop_hw_queue()
>                                                                     virtblk_done()
>     blk_mq_request_bypass_insert()                                      blk_mq_start_stopped_hw_queues()
>         /* Add IO request to dispatch list */   1) store                    blk_mq_start_stopped_hw_queue()
>                                                                                 clear_bit(BLK_MQ_S_STOPPED)                 3) store
>     blk_mq_run_hw_queue()                                                       blk_mq_run_hw_queue()
>         if (!blk_mq_hctx_has_pending())                                             if (!blk_mq_hctx_has_pending())         4) load
>             return                                                                      return
>         blk_mq_sched_dispatch_requests()                                            blk_mq_sched_dispatch_requests()
>             if (blk_mq_hctx_stopped())          2) load                                 if (blk_mq_hctx_stopped())
>                 return                                                                      return
>             __blk_mq_sched_dispatch_requests()                                          __blk_mq_sched_dispatch_requests()
> 
> Supposing another scenario.
> 
> CPU0                                                                CPU1
> 
> blk_mq_requeue_work()
>     /* Add IO request to dispatch list */       1) store            virtblk_done()
>     blk_mq_run_hw_queues()/blk_mq_delay_run_hw_queues()                 blk_mq_start_stopped_hw_queues()
>         if (blk_mq_hctx_stopped())              2) load                     blk_mq_start_stopped_hw_queue()
>             continue                                                            clear_bit(BLK_MQ_S_STOPPED)                 3) store
>         blk_mq_run_hw_queue()/blk_mq_delay_run_hw_queue()                       blk_mq_run_hw_queue()
>                                                                                     if (!blk_mq_hctx_has_pending())         4) load
>                                                                                         return
>                                                                                     blk_mq_sched_dispatch_requests()
> 
> Both scenarios are similar, the full memory barrier should be inserted between
> 1) and 2), as well as between 3) and 4) to make sure that either CPU0 sees
> BLK_MQ_S_STOPPED is cleared or CPU1 sees dispatch list. Otherwise, either CPU
> will not rerun the hardware queue causing starvation of the request.
> 
> The easy way to fix it is to add the essential full memory barrier into helper
> of blk_mq_hctx_stopped(). In order to not affect the fast path (hardware queue
> is not stopped most of the time), we only insert the barrier into the slow path.
> Actually, only slow path needs to care about missing of dispatching the request
> to the low-level device driver.

Again, this is way too wide, it's unreadable.

Patch looks fine, though.

-- 
Jens Axboe

