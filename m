Return-Path: <stable+bounces-108445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2FA0B914
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0585E16799F
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478BB23ED43;
	Mon, 13 Jan 2025 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MDu2/QZM"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2C23ED60
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777290; cv=none; b=pmqyo5eoTCUKgqnztI2LVgK9ScZGqVycWlxm0oOzx1dv+umoEIBN3h0+odggH1LA6a8dsnd6dEKJMZ/NZ35KQsdyQLGFh53wD1f9TLl8EVeink9j271mbW85JLA2wVDUXVeXICxge6TdQ9wSy0gtjxTb3n3lGwPicGEJOsIxSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777290; c=relaxed/simple;
	bh=pHGqBJkgSi5PGNtTYNHsQMr46ONL0sWIaL27UgJejNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW0V1h7eoQsGwHsKlvMwz+wfPUwJh6xYB7KssvzECFH4nN6Xrm6fFMEFWp2/9PDvpOaUAMeqI/8Irpt2raH0yd4oqo8MQ2z9VvPmzylpswC1SeT8XZwYcDN6+QE5t1qF7fDxBNOINyhITSCnnQfyEHhLB+MpaLAqizLmJvjeZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MDu2/QZM; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ce7935d38cso418585ab.3
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 06:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736777285; x=1737382085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSY2atUxxXPJ486OXRrkAxw8Ijjfhg5H8BJosY4ViKI=;
        b=MDu2/QZMMSCpqpTrC3ytwxePSwZ6CYI4j7wPwNXUgT7P0fKvDnX1k/UCu93apY2pFi
         kiO600do0u2Q2q095T7GaWZtXqH0O6p+EKsz+vVEfzberskrTzhlEo7OHMTJz3clPHSA
         HZsF5Fne127LKPoGhlcRovYjKM1ZUDss/8SBElhis+elbEIFS7MrtlvH0+hn6Wk0c/HL
         G0AqSoo0aZCC1JMRmpChMoCtpEAkY0Xv/R9Vopvo38+6o8wLUQ6yy+vpcEAfmlfcNy39
         zgnbS9utYyeTy0qO9aPSZefiFE1rynJmbEuTHQb25ETegrnkdrw+Y9FwDUoyaZ2QHA4u
         /B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736777285; x=1737382085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSY2atUxxXPJ486OXRrkAxw8Ijjfhg5H8BJosY4ViKI=;
        b=vhmTf+DexttdNlrVv/x6EmULeivZCime6YGem3Q7Yf2sM48WLqSfPA5eGoDmOn7Tfm
         J8STEf5lvbWUlIV8yPWoVHvj+/hWhw1Z6Z0ypmqCUp47DyiYEvTHEPrD7W9auCBj48I6
         +DwXQP7JkpOZ/Cxvp3DZUqjrW+717MLUunomzS7gyltu9jaCrEuh3YxtTkohvDOQtbQ1
         NG0dmdGJQmohRBKYyMZhAB/XEtyDtnj6mmNNM6cSBjLjtlLCe6fMSYAOQJVEQL9Yc0tI
         tReLHy6pkQ/OWdEWe8+sYAb/ywYC4anrz/MPmA5rJjJmyvU8scxAD+Lbr7WukvHv2hbb
         sfCw==
X-Forwarded-Encrypted: i=1; AJvYcCX4LJpIGP2oDTFYG+fq3F08LYi53nD8iRYoH3FOLsZr5Wy6Ymxg+mCDO/ZA45eKAnDH2mmRLJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzsUg+GpNsSXt624NxwDpOvyVw+0ziRe+V0a2mGVaXZuZUtyV
	nFbBxvegBzaCE1UbNV5ZkgEhs9pSIbJQFt1fZNJYLC665AUupXUMmwp2MerYFKw=
X-Gm-Gg: ASbGncv3GGY885hj82RoCPP9rodwxWLFgzzZdGlnfam2R9LRN/losAlUS5D/+snAwSv
	n7jrZU+tcqHlnbMRiDTqPcUfO/ObV2NKIUAohaUGpTn73+MKDVKxq/U+VtjHQLzZG2pdBAU7WKL
	Tu0ydud1+CWJ0wRpH82xw1MJtFYtT1w0IrX0uS3SqH1qOYmvmm3JbKAUCVUclgqTuXbgVrNVCHv
	LmcGYYbGL6BZH+VmNxmbo2ueOwvatYWF3mtbDAj4V2ZeLtJs2W6
X-Google-Smtp-Source: AGHT+IEv0nyRyGhMO2sKYGFQWMIcEo2GbGQ/+x5OA13vvXhfSov381P+NLV9aTXIRdbVzEuU5HG0Uw==
X-Received: by 2002:a05:6e02:3201:b0:3a7:7811:1101 with SMTP id e9e14a558f8ab-3ce3a8df631mr162570085ab.20.1736777284902;
        Mon, 13 Jan 2025 06:08:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce4adb3aaasm27062005ab.24.2025.01.13.06.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 06:08:04 -0800 (PST)
Message-ID: <82531a6e-11cd-4503-af64-c77719d96af8@kernel.dk>
Date: Mon, 13 Jan 2025 07:08:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/eventfd: ensure
 io_eventfd_signal() defers another" failed to apply to 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jannh@google.com, lizetao1@huawei.com, ptsm@linux.microsoft.com,
 stable@vger.kernel.org
References: <2025011246-appealing-angler-4f22@gregkh>
 <aa85959b-2890-42c9-beb8-0e0109494d90@kernel.dk>
 <2025011314-skinhead-thigh-b568@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025011314-skinhead-thigh-b568@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 3:50 AM, Greg KH wrote:
> On Sun, Jan 12, 2025 at 07:55:26AM -0700, Jens Axboe wrote:
>> On 1/12/25 2:16 AM, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.1-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x c9a40292a44e78f71258b8522655bffaf5753bdb
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011246-appealing-angler-4f22@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>>
>> And here's the 6.1 version.
> 
> Thanks, all 3 now queued up.

Thanks Greg!

-- 
Jens Axboe

