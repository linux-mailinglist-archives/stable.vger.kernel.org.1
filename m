Return-Path: <stable+bounces-35608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B598B895597
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709FB289430
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B885650;
	Tue,  2 Apr 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2EZej/8t"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7C81AB6
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065301; cv=none; b=njirHTleHz2Z0/LpgbK37Z1WrZf/vKOCYQ1v10ZC021aeZfNLMbx7QTogMHtY7RimQQp892XIzEVm1SF9AK+/PyifagK4Ao6JsHdaairotX/hxLO1De1VESXPerO6JHgEdFD6rtH0ly268IUlHJQ3c+ujfZG514Yep+QVlYYMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065301; c=relaxed/simple;
	bh=0LtRApWIgSlpJ9ww/YIqK7ZhGrxEnPNn5T2jGau3Mqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TP2J75XX+x8F0Oi2Ioi/q6pmFRVr3tSE0vI6zrkjswhnCJv6skyq3Lkzuh2wSJp+swVO0mtFPx+CjhuNTWPUEzq2WisRLMvUf0jafRQNJYqGpGcnAy9KX5MArtYe/j5nv40RPSB2JOItJIqNTMe9VBCBT6XTLlhqMkq67KVBCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2EZej/8t; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso32155639f.1
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712065299; x=1712670099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ayu5f1JpVyjh9EymQM1sQHOrd/giDk3ss1JwfvraeE=;
        b=2EZej/8tfFfaTOOX95T9KAJg10lp4PXkT6jn1C7LiXCjN5WS3dwzcy1DCWxNFCGGfv
         8kiAglMtxO69/47BJASC6t5M0R4dE4M4+FvlzJcuICsomBrtDXmIP4VEzsquX648L6ZV
         0hNcdiRxQGRMu9khCkr6mpOdLt3TOkmBaZHh4cg+0y2S9CvgcShknHjWeWdWWNJ77Lo0
         gJxs9MPG67Mx3qdNOCUSIO+0i88BJki+DOeIa8ZxuTcrmIKOFqNRDu9labKWvMTg9Qpx
         rhpkVkkCaAYyuJAS5meMpvzDjvqV3aKKsKhcu2XtEVSEhEW+ZNqT5EG6DU/cnV5zK+6R
         XtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065299; x=1712670099;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ayu5f1JpVyjh9EymQM1sQHOrd/giDk3ss1JwfvraeE=;
        b=IiC9HPRP2cE41SL3B335bl17U6FcyzjOIu1JtUNOKItsyWN3zzSOxerrRGzfK436VR
         64bLYYxuWdCN8obs9PALMUksEm0EecGGN7v+0GAtBEroYn4nel+hGWV6HZnvwG7/WqBa
         dFNugOrbXamU+4wtV9XR4JJ4GBaq8GinPbkd7QRAZ0KBo3TwateIWy9MTRjSHKMM6wqq
         BdnhR5P/vtlbHO70vM2aRXRkyVA0eg1lWpFMtpuIDKhEKHsjTRiyRZVH4MMhTeRPK0TO
         YJ1Js07tVcvBqQDB/4CMe3Ll0l+rkKNeEOoaxHrfvVinSv0xONjBsesWznd1STPMJEbv
         hXAw==
X-Forwarded-Encrypted: i=1; AJvYcCUonvW0S9jrBYQbwdtkntwIawmpHnWTmSYKZlTFasCTW7mlwQcTAXlljabfP4Sp3j7B2TLNwVB+buyvpCO3OuBoZHQOj83K
X-Gm-Message-State: AOJu0YzQ9HPDCWK80ZmX0Z662mKndbIdrzp0owTZFNd2bjqd2G8d9Loz
	GspbC3lg6Nqfv1lvAzzTKB0BLy9L7Xja0+gCao+QaX/O6IxMCdy37ntEyyPuUAI=
X-Google-Smtp-Source: AGHT+IGDUMItsDY7XwZRAzi1VsGUdRgc2+dwdqgArOafC34sSXfwfBgED9VOJLRu6JugwPpSDO3KfQ==
X-Received: by 2002:a6b:7d0c:0:b0:7d0:3f6b:6af9 with SMTP id c12-20020a6b7d0c000000b007d03f6b6af9mr12019000ioq.0.1712065298876;
        Tue, 02 Apr 2024 06:41:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id it37-20020a05663885a500b00476f1daad44sm3194814jab.54.2024.04.02.06.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 06:41:38 -0700 (PDT)
Message-ID: <2ff5d891-2120-475d-be8e-82bf20a8b7b7@kernel.dk>
Date: Tue, 2 Apr 2024 07:41:37 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 015/715] io_uring: remove unconditional looping in
 local task_work handling
Content-Language: en-US
To: Jiri Slaby <jirislaby@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-16-sashal@kernel.org>
 <bcf80774-98c2-4c14-a1e7-6efcb79a7fee@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <bcf80774-98c2-4c14-a1e7-6efcb79a7fee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/24 2:12 AM, Jiri Slaby wrote:
> On 24. 03. 24, 23:23, Sasha Levin wrote:
>> From: Jens Axboe <axboe@kernel.dk>
>>
>> [ Upstream commit 9fe3eaea4a3530ca34a8d8ff00b1848c528789ca ]
>>
>> If we have a ton of notifications coming in, we can be looping in here
>> for a long time. This can be problematic for various reasons, mostly
>> because we can starve userspace. If the application is waiting on N
>> events, then only re-run if we need more events.
> 
> This commit breaks test/recv-multishot.c from liburing:
> early error: res 4
> test stream=1 wait_each=0 recvmsg=0 early_error=0  defer=1 failed
> 
> The behaviour is the same in 6.9-rc2 (which contains the commit too).
> 
> Reverting the commit on the top of 6.8.2 makes it pass again.
> 
> Should the test be updated or is the commit wrong?

The commit is fine, it's the test that is buggy. Sometimes test cases
make odd assumptions that are just wrong but happen to work, for some
definition of work. Eg it would work fine on an idle system, but not
necessarily if not. For this one, the fix is in liburing:

https://git.kernel.dk/cgit/liburing/commit/test/recv-multishot.c?id=a1d5e4b863a60af93d0cab9d4bbf578733337a90

-- 
Jens Axboe


