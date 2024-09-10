Return-Path: <stable+bounces-75646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA3973872
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8941C2478E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7E18CBE0;
	Tue, 10 Sep 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xWBGKbdJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A0137772
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974256; cv=none; b=HWO4saRC0toXd9sK38ThZDgWUfmZgpqUSTO5hRzym0HwbtLKc6N9uwukV7P/ZxtArKt54P1R/OlP2rMCDfiBuIftuyAlNlCnqGrikBIER0kVvdVvgeqHmQRi3VJvGKZ1sGV5GkMUR0hC3i5Hjjge10CC+bJCxt/XmZT3khISun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974256; c=relaxed/simple;
	bh=rElpwe74QCdlkppKx+/nrl9b08LTiSv9pKFzn9ku2nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k792cRc6FeUXONKhSA3Kwf67BEIUwwSYKhNV44dYVLsSjMux5ue2aRQ6IZux4QLkPnGND4bVYzMf6yFVClPh99jTjXCwSF9z7MfcoyAhRqYqcbb72nV8UtlZ/bUdYbHWfbFBwwedsQFwcet5yzSPVwjF34m3Aa66QbkKer3qnjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xWBGKbdJ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d47a9ffb9so17724685ab.1
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725974252; x=1726579052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpD4HVzD9Ke7dsGx30VPgTZhr78oR5oyb23tn64z8zE=;
        b=xWBGKbdJ2J/1CDF+P/sXVYKNEJt3Q/70tGAkgOqs2Hyua1+QzZh7YmPpTa0oy6xZus
         347j7c3HqIUsGL11OrQYC0rBXb1poSbi1eMj+YPQYgHhI3iogN9P9PS6eWIW0Yjky/oW
         M9xb7EuJLhhML3WD3yba7iQM8PoA/TExvSLThLKoCzqIuxv28pHNlBTYs2Ukx4PYzxRv
         sjLUKhekijddatC7hSOi6QEXjmHI9oaTChPLY2y/h77ue59zi3Z8Z1BmGZi0bTNJgFzb
         +LpNnlmmQe/rJDUEwBJ6lknYYcZxSqpKkHYwV5dE+n96DZai0Sm7E8J6DVhmc3wGQruS
         rhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725974252; x=1726579052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpD4HVzD9Ke7dsGx30VPgTZhr78oR5oyb23tn64z8zE=;
        b=CwaduZDkuXXtKqIbJiIVPNllnU+dw8B92uldki1qMxn/7EMaNuW7SFW0vPKhzTtF2B
         wu0fgDIsC9OjGO8lNRYnr8KFaG2E2w8Yy84eaDUU4FCYAJgXCNERWCKpiWTXkrpb9/jt
         dNRGazyv6Z7NUmsoWbu8oQIWOqtFSnuwdrFBHsB7mIoMC8Sc4h8dpTCjIQrcOOxazU06
         3dv/JWy+tB/seK3LcHNj71Q2E6EgfBjbFYSHnj0pNNSucyDn+60ODllJFYdt1uRrUdt2
         YRK02r+7cLZ5W/jheOAhqx5elRxxiUfk578/yeB8z3avAsLR9xvZHY+VlDN4yAVYsGLQ
         gHFg==
X-Forwarded-Encrypted: i=1; AJvYcCUuhaW1BU8K4tb+q9JSe22xfC1XkC+9ojglsZ6RDAv7o5cxhHskl+1hVHoObidm83a3mM+Zt2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzFxAiZW4cHuw1rzSj4F/C1RttYRvo+JkF83qt0+y1R15rhEeh
	HRzBWzcrQeDehWFHynjWpQ91CNSXhY7vg0VBYFbf16UxtZE3S4mBzSE/61+UtsQ=
X-Google-Smtp-Source: AGHT+IGfyK24HYfbbx9rnx5YqzuHbqBuNQFAY7I1lFziboEeJC6YZXRSh2213qMBbZThLW4sVWXvqw==
X-Received: by 2002:a05:6e02:194e:b0:3a0:4355:11f7 with SMTP id e9e14a558f8ab-3a0576adeddmr107270105ab.17.1725974252303;
        Tue, 10 Sep 2024 06:17:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d1ff20867csm456359173.167.2024.09.10.06.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 06:17:31 -0700 (PDT)
Message-ID: <0e4e1f5a-30fd-430b-99ec-8b1004d8e3fd@kernel.dk>
Date: Tue, 10 Sep 2024 07:17:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] block: fix missing dispatching request when queue
 is started or unquiesced
To: Muchun Song <songmuchun@bytedance.com>, ming.lei@redhat.com,
 yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 muchun.song@linux.dev, stable@vger.kernel.org
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-2-songmuchun@bytedance.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240903081653.65613-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 2:16 AM, Muchun Song wrote:
> Supposing the following scenario with a virtio_blk driver.
> 
> CPU0                                    CPU1                                    CPU2
> 
> blk_mq_try_issue_directly()
>     __blk_mq_issue_directly()
>         q->mq_ops->queue_rq()
>             virtio_queue_rq()
>                 blk_mq_stop_hw_queue()
>                                         blk_mq_try_issue_directly()             virtblk_done()
>                                             if (blk_mq_hctx_stopped())
>     blk_mq_request_bypass_insert()                                                  blk_mq_start_stopped_hw_queue()
>     blk_mq_run_hw_queue()                                                               blk_mq_run_hw_queue()
>                                                 blk_mq_insert_request()
>                                                 return // Who is responsible for dispatching this IO request?
> 
> After CPU0 has marked the queue as stopped, CPU1 will see the queue is stopped.
> But before CPU1 puts the request on the dispatch list, CPU2 receives the interrupt
> of completion of request, so it will run the hardware queue and marks the queue
> as non-stopped. Meanwhile, CPU1 also runs the same hardware queue. After both CPU1
> and CPU2 complete blk_mq_run_hw_queue(), CPU1 just puts the request to the same
> hardware queue and returns. It misses dispatching a request. Fix it by running
> the hardware queue explicitly. And blk_mq_request_issue_directly() should handle
> a similar situation. Fix it as well.

Patch looks fine, but this commit message is waaaaay too wide. Please
limit it to 72-74 chars. The above ordering is diagram is going to
otherwise be unreadable in a git log viewing in a terminal.

-- 
Jens Axboe

