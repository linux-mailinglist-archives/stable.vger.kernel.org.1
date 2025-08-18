Return-Path: <stable+bounces-171618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7028B2AC6B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656807AE327
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9621ABDB;
	Mon, 18 Aug 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nIY1hIpM"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACF233140
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530275; cv=none; b=OcqY+gQU8gvnKLSSewL39mUbGvnaIjqhBSFsX/f9rz9fMvC0yeLOOWwNLVzW5siOu/4bk5YWk7SMRx3UY7KAAWBSKUIRVQjV1VAjhMTYS/vdqdkOLiujzpylqFrNNp+sD/cBe1xxyKfQV2R7KaA+WQtaABQgjHPM4/3wZDYEMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530275; c=relaxed/simple;
	bh=RO14iBAw61nrFjI/7h8B8uMHRgnycra6niqzc3j3C3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANicX6QZw9xzP5IQd2IB2xzSAesXjrRE3DQq9T0O7NQ21HBFjXY1gXkMMphOFtOhPWYvSh+OPTv80/XglHpUlrFeWfJ1ZaDqOBpTgW5gD+xYMcdLqhrU6A3/E3rFkmZ6pRKNoR3naY0ekXdt0IMQnLBg5J6xHXDSoX7EkWCdMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nIY1hIpM; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-884328c9473so51019039f.0
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755530270; x=1756135070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMT4eDK36qr+C4BysxeOv7rVGcyn/FbLH8SqiJK3J3Y=;
        b=nIY1hIpMF0z0GwYcA3mgdgYRAnOQGL1UN+PQNHJVx7obRSp3a3QfTDnao/FulItUpa
         X6jLSV6f12mc0dqIizP6uQ0NFvFnqVQi13kuzBwy9RgU5EE3CoscIcVHKhWooYaA8aoL
         iMETajL9r6ucmKmH4TiNXnjYK96t931v7EwaGTEuRCVMj8v7rigxXGw6rJQxvGnmBJkQ
         bQFan4w9YAAmShwBMv0X2TZCwBKHbOX8XsYZkUh0WXkg5a4jKLK2NVO1oF+xEPUpt9sm
         S7YjxH1l+rSzwpUez0qn/KawoKVizQGCIrIJ/96GYNxIz8t67uEhK9sjF6lGUvs4rQIk
         qG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530270; x=1756135070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMT4eDK36qr+C4BysxeOv7rVGcyn/FbLH8SqiJK3J3Y=;
        b=MLDkuYcBgXAgihthSntz9JfL02SvrroL01KJCpvve/k1Oow0WEKAnKzMr47IMXFKZF
         qowRcjZo87DCdF7O1l/vn/pV7nEc2P/Sz4X+2/BaQf9Tagj7o2hW+/6YntkD1Mwbqv8K
         BHIeLv7aL833HZ25BPNfsCLaQt+u7zL3hRq5oXkqlhJcaZMYvhmRez1Nxw4EAGZUNTiq
         DkJNtlC/VGX/cKjN/112vEWhwM9tlNXuZKTIiWzjhLoHXw5b4VcOq3IRhuFhQILhihHR
         MWM34vHRjkWFeZCz6P1Wr2l31XMfCbSnHGll+Pgrv+MbTKI/JOTN8wWFDK3qAAg7bsMF
         T6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCV9+GaoBuHG6oz9cQnC8t56WoBWj/ucQGB+/zC9wBHqk6Ku7APk2NSciLEMValmUM/O7DlbSgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbi5gdR1WMgwQfEhVBOgwz44ve41oRJEXeJ97NsXiNIsF+3XF
	ajyqTBBYjSs4/Gd2TPVnKWqfMSTvjkXIezozKGqeXD0H6zlxnwxV2/Htea91g8aCW8JHrXQU3e5
	Shk+n
X-Gm-Gg: ASbGncvU7OS6eI4KuKerVTyQjvo2+t7Sttsweuk1LfSlcBPqeaA8Zptf8UjwO+wAbqY
	y4JoRUSHDocN1PD04YzNbcQw1vgRpsdRf7jcAODEMDC5k5SdeQW7j16KL1J/zzZLk81k8DvYKuP
	MbGVltydOxySo66i9ksN+H7iv07k6tPq/7pBi/7xaVfCtlGt+67kjMyBa0teSGvjgXYCVV6t6iT
	RqST0DLtzBNgILyIWECTk0DihZEQv0h1uw4wNjU33RAXuULYMZdIWbXXUMkTsCz7soSnK0TLfuB
	FZumTwpYS4bY/si1MbYy7jKPY2u3VoQ04d9H8Oh8fapFCpdAs9E5fMRGSNcOdlnFbtLnrwbI+hf
	pJKFsHxVwAgcRWr4VAcEN0V5DmUJIbPWkbS56AneA
X-Google-Smtp-Source: AGHT+IHXhYoPQ+AzHhxPiTBYDpiMlSq6Ai+VMYTtgAToM2mqkxDWzo7lEsQPU8lTyHTAO80RLCCUUg==
X-Received: by 2002:a5d:928f:0:b0:884:b65:c3f1 with SMTP id ca18e2360f4ac-88434489c0bmr2511116139f.5.1755530270298;
        Mon, 18 Aug 2025 08:17:50 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c9477f29bsm2503118173.12.2025.08.18.08.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:17:49 -0700 (PDT)
Message-ID: <edb34177-6e3c-446b-8689-287b69b0ef08@kernel.dk>
Date: Mon, 18 Aug 2025 09:17:49 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: commit partial buffers on
 retry" failed to apply to 6.6-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: superman.xpt@gmail.com, stable@vger.kernel.org
References: <2025081549-shorter-borrower-941d@gregkh>
 <15e7ab1a-46d9-4d3d-b48e-3e10e570829e@kernel.dk>
 <2025081558-scion-joylessly-a7b6@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025081558-scion-joylessly-a7b6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 9:57 AM, Greg KH wrote:
> On Fri, Aug 15, 2025 at 09:46:53AM -0600, Jens Axboe wrote:
>> On 8/15/25 9:26 AM, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.6-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x 41b70df5b38bc80967d2e0ed55cc3c3896bba781
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081549-shorter-borrower-941d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>>
>> Here's one for 6.6-stable.
>>
>> -- 
>> Jens Axboe
> 
>> From c16cb4e2a4b1a487ca7feae5931dfb22ac495b76 Mon Sep 17 00:00:00 2001
>> From: Jens Axboe <axboe@kernel.dk>
>> Date: Tue, 12 Aug 2025 08:30:11 -0600
>> Subject: [PATCH] io_uring/net: commit partial buffers on retry
>>
>> Commit a6dfda7da5c65b282c1663326be16e57aec3d1bd upstream.
> 
> Nit, wrong git id :(
> 
> I'll go fix it, thanks.

Oops sorry about that, guess I took it from the other my other backport
rather than upstream.

-- 
Jens Axboe


