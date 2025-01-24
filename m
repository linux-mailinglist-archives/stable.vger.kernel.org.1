Return-Path: <stable+bounces-110425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B06AA1BDD9
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 22:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC32188519A
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 21:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFFE1DD0F2;
	Fri, 24 Jan 2025 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JXa6Foa7"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FEC1DC070
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737753832; cv=none; b=NkNUdq10aQ2bjvJ7LTNbkKTO3s27j7RVNttdiaYPjhrSCb2EB/jkecJUZNNBjkuGA6jOKGBhwKWsXMlSYEFgsZG2vIfzI+yGBS9HeCLVffcn9wgiaf6+TdwNeMK10f/pwBtAIWuY7Z7O/zupn/LODbahtfuAnOpYv5YLoRHa00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737753832; c=relaxed/simple;
	bh=rQIc2KQEjTVWIrmJToHxIfBXM7cYL7IfGQsszIxoXyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MX6DK3Xo0DMu2RdFvopjQX1Xu00sZPDkhrvHSivWY/UCf/L8boW4S3rJ2vMu6SrmQCYkDKZ7jkt0gd5zLMDQAKlw6tBhmEslb+tq/u7WpXsV63CNXV2WgAIXbr+tkquYnO2WNzMwz3cqjNdEOJWP8tAJ4XW9CjQrez1vxG8juDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JXa6Foa7; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cfc1ff581dso5514465ab.3
        for <stable@vger.kernel.org>; Fri, 24 Jan 2025 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737753828; x=1738358628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFE/86LlpI8R5Z4Y+XyrjI15dIwEYCPt4gXhui4nwQA=;
        b=JXa6Foa7BOk1q3CbRnC2SvbYjvMnKhqPyeu3dKP7DMu5dInA8K5A18rF3Q1kKPyUuA
         Ttx9pnUbc5XUGZDpD6Sh8IH+NBtX3Xw54ZUUmnB52aGUuTFO2c96zSmHbUuzzDAITVJ9
         F6UWSfsZAYafJZZs5REG3tcBflH034MjA6vX3ySuX/SDKe0i1zRPRy1NQJ6nd++wYcBZ
         d7LJEcxbdepk/t/T2T3CZA1H7qupljTXLR1g43BIKpS1BYfyNboRgkWV3oFDCbWhiikt
         ZFUU1mJPV8rku1cCnmg0pH2238RwyJISf6pO5G0Bv3JzLvEi7j8kM6qHWFcWgGH5rPHT
         smxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737753828; x=1738358628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFE/86LlpI8R5Z4Y+XyrjI15dIwEYCPt4gXhui4nwQA=;
        b=Yyk7emt/NHVRNIsw1VxPBQv/StEbpSmPFzQZPFoWyWDtaZVlIlgW5A57TQQwehQ4Jr
         pnG7AiKSfi74xSeyi2ViBlm7oDumiZomz/IOrwGy7zIUL3WcFHfu1bDJrYm7+naRLR9W
         Hs9l0jKw+tialpIjDuX15dYGiQqnodz/fgxU+zMEnx1vKiClEu/eiFSujY84MPEcRKHA
         wzysXj+vKc1BVAVLuhWiJU467V7qBHGi7u+OWzuM6Z0B8i4YJdTEi0Cknfq8YtmdRkwO
         Jfu7+KZmRlT/oXPNxVtlVQLtEh2cl50UJ2HiwxAtj5yp7VxjgLM47i2NSqXGvxmBPhqC
         f4bg==
X-Forwarded-Encrypted: i=1; AJvYcCU/bXwvpaY+G+L7JGd6ztjjzXFRefM0G/orTDRS2/euIIQFZe/IO44vc13LWgbHOcpyXAz6CDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQeBLhKToichDi/G/3ktAOVihueTIfYXLeutlp417eEOIuzHK
	L8CD4mfDs4iZf65mkyOHZoR9yQeCZR4hreRv96Pwi7SWPbtFFmwUuCbRYQG5IFg=
X-Gm-Gg: ASbGncsZlE9P9PPd1keyzY2zREoWD4v0jSe33E+F/mRww/VXOxHP3jCaFmtMsuipKUc
	v/YpjveXPj6ht6AsUG2RbLOaTZYjhriAIEdkdfFnxQYEk3eyzivlY11R7xWGJurbKWn7+0UMzKD
	uzsHageavroTwnI4ZaRQ+LYxE3dZ+b+JeSbMvHIPWAVFGcL/G/8UaYkZxy7J3B18lV2iwpbv2Ra
	blW9vme1zj2INY37AIUwtVja+uaL13lR5sIXgGUHI2wpzKY8epeTFai4ot5vFKeO2ky3cgZ18Au
	MA==
X-Google-Smtp-Source: AGHT+IE2wUO3cR2PbEkPM3r4ze97FP3yesKSEAHuxMfW+jXFJwBMIVoLTOyB7iMDWxKFazVpPEvp2w==
X-Received: by 2002:a05:6e02:19c8:b0:3cf:c82f:586c with SMTP id e9e14a558f8ab-3cfc82f591dmr35855075ab.4.1737753826436;
        Fri, 24 Jan 2025 13:23:46 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1da0397bsm866293173.1.2025.01.24.13.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 13:23:45 -0800 (PST)
Message-ID: <7a9a4b5a-93c6-4b63-aa32-83e9a2642511@kernel.dk>
Date: Fri, 24 Jan 2025 14:23:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable-6.1 1/1] io_uring: fix waiters missing wake ups
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 stable@vger.kernel.org
Cc: Xan Charbonnet <xan@charbonnet.com>,
 Salvatore Bonaccorso <carnil@debian.org>
References: <760086647776a5aebfa77cfff728837d476a4fd8.1737718881.git.asml.silence@gmail.com>
 <721da692-bd23-4a73-94df-1170e3d379be@kernel.dk>
 <de8f5241-e508-4c30-b807-f16fd1cdbe9f@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <de8f5241-e508-4c30-b807-f16fd1cdbe9f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/24/25 2:23 PM, Pavel Begunkov wrote:
> On 1/24/25 20:47, Jens Axboe wrote:
>> On 1/24/25 11:53 AM, Pavel Begunkov wrote:
>>> [ upstream commit 3181e22fb79910c7071e84a43af93ac89e8a7106 ]
>>>
>>> There are reports of mariadb hangs, which is caused by a missing
>>> barrier in the waking code resulting in waiters losing events.
>>>
>>> The problem was introduced in a backport
>>> 3ab9326f93ec4 ("io_uring: wake up optimisations"),
>>> and the change restores the barrier present in the original commit
>>> 3ab9326f93ec4 ("io_uring: wake up optimisations")
>>>
>>> Reported by: Xan Charbonnet <xan@charbonnet.com>
>>> Fixes: 3ab9326f93ec4 ("io_uring: wake up optimisations")
>>> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1093243#99
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>> ---
>>>   io_uring/io_uring.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>>> index 9b58ba4616d40..e5a8ee944ef59 100644
>>> --- a/io_uring/io_uring.c
>>> +++ b/io_uring/io_uring.c
>>> @@ -592,8 +592,10 @@ static inline void __io_cq_unlock_post_flush(struct io_ring_ctx *ctx)
>>>       io_commit_cqring(ctx);
>>>       spin_unlock(&ctx->completion_lock);
>>>       io_commit_cqring_flush(ctx);
>>> -    if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
>>> +    if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN)) {
>>> +        smp_mb();
>>>           __io_cqring_wake(ctx);
>>> +    }
>>>   }
>>
>> We could probably just s/__io_cqring_wake/io_cqring_wake here to get
>> the same effect. Not that it really matters, it's just simpler.
> 
> Right, I noticed but am keeping it closer to the original
> in case we'd need to port more in the future.

Yep that's fine, let's just go with this one as-is.

-- 
Jens Axboe


