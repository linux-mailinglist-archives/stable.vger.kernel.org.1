Return-Path: <stable+bounces-125646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 972EBA6A694
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 13:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6188189FE74
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735D200B0;
	Thu, 20 Mar 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iiV3JzPa"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957F5258
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475312; cv=none; b=F3JAyksoPQr4v5IKuXI0c2Xv9b4bA0IWoXWMdEsysV6TFiPTCFLc8OBtYAReQXOeRr0D/nZLOxcavftICOjn3We5YXuIKq7QYYzX3hVsaDC89iRHpEuHHeQbC0c2xmOCMxv/MJoK8POdURdIlmliYqOX81gHFL3ihAYg4yO8gVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475312; c=relaxed/simple;
	bh=zaGLhQEKaTi2oTxalubOkO7crjcho7RWd5O/NDqW5sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJCsSFkGl8a7/323n4j7zxj2kVFd/DHmHwe8tWj2qsy5kRdP2f2XWJi458401mrXGs0BV0pIpIeap/aeIkjgRQOyTe1Ftwgx2hctuFMbqUXTLm79FWStRe/XM+YH7jvV8lTnyQvcAOlz20Z/oJEPooGENGu42yuxzzIQ7ogIinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iiV3JzPa; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85ad83ba141so98644539f.2
        for <stable@vger.kernel.org>; Thu, 20 Mar 2025 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742475309; x=1743080109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOwMMS9hglRzxW3ezI0QinI0heUZsr03hz7ekDle39Y=;
        b=iiV3JzPaYSQIvSWquNWOgo3qX02zMjTr/Tfu4krs8tljOGnzIyrDc8tmme1QD4k4x5
         pcCYdytfBlB4qBjeQZ7oulV4lzAc429qlVZwOfscP5lpDok7+s+YwP3bWfbRSBIBoAWE
         u4JOsc4n6g74UGw3vAW8Kgk1xGhFEu8B75O1cmTvzVsNV7fg2fXifoaRo8Yqgahbsxcf
         Lrsbh8puExdB40o00Fb9UZPqhmzEnc6aBWohpVAHtJcD5qm6mNugNo/NhUom6v2DYSHm
         JvtfDUv9cur/Q1GciKGc1KbipPWG8JhNzZC0isx6iM9z2ai2wjjv7AiHPUGd0QilpX6r
         FBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475309; x=1743080109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOwMMS9hglRzxW3ezI0QinI0heUZsr03hz7ekDle39Y=;
        b=NzYch6cEO6qQezKlD9PoM2KsBqnCwh/e7asiV4eLq5v65YMskBc8k7pcRzsz7U07LI
         +B4bK8eJYFthblWBvzHe6wxW6k8S580A2WR++PhQRtbX8S6SaZ6bDA4KL0Tkq+otp84J
         jxMYRbg9b2EoloR+vST6tjw5YilPY9Bcu8svaZkWfnxdeej/x1SMXcag226+rh+ZTJWJ
         +N9mA87ofpHMrs69oss0ZXsfam8cQXGATbZ7yTT54DvipbuoenjL1czzDW0iHFqy4Pib
         eByTfeaW5aQtjqN/OOe5nwDxP1FVthoDrGeV2JdiRhmdEeXJreh6/I7AEEEUFzQWJFZu
         49pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbLUHvn8NHefk6A6+qWGi0n3T8pQiWEpFvZuFw0nlm859Ekdjs6D+nlKSJ4XCWYdlCJPfoKvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKxH3QVUEzPuANMqdCVDkonfLX3aV67lF9HKj9zS+89F0ELG8
	ahO2nIVMr9jy7KLKKR3MnqYymdnrOhs77dsnZWRlQSUs0GuE5FXGEUNDjyoLVyQ=
X-Gm-Gg: ASbGncv4dT45zfIhzB3DtyqpvQtgIlqz/swF9YfFcGPLp/u1bg7SXdJETOdAweYswOB
	1tGNPsUha4uyMLKEGsCrKjFblV5FiapiZZxPjChsN22Z0I40FucagFxJWaWlqq31yRR3PvU+iau
	ogST1c8dbl0QDDvu9WlixDT6TW0KEn75P5EigGdreCeBFO7J6oOIMFps7dB/DmBn7SxyEo7a0rV
	nZsGsrx3W8o9c3HeJw3LQ3Z6gyEMRo5rBMbhJGlAxfkesU4yx1kvZClTUYIYYfH3gunHrukn/Af
	RyHJdp5cFqls4nhQ6LKArgmNpy5riheFib4B0z/ykccK/9WyrPKs
X-Google-Smtp-Source: AGHT+IEON63IV/8wSGuratVRSV3sBgQWopW8fhTGMX30EPgngC5K3ox6n2FPHmHwhdzbBzI5XNq9aQ==
X-Received: by 2002:a05:6602:3791:b0:85e:1879:18df with SMTP id ca18e2360f4ac-85e1f4c058fmr390863839f.2.1742475308710;
        Thu, 20 Mar 2025 05:55:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637fabd4sm3725628173.85.2025.03.20.05.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:55:08 -0700 (PDT)
Message-ID: <3dc5b070-0837-4737-be78-ba846016c02e@kernel.dk>
Date: Thu, 20 Mar 2025 06:55:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/166] 6.6.84-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 io-uring@vger.kernel.org
References: <20250319143019.983527953@linuxfoundation.org>
 <CA+G9fYvM_riojtryOUb3UrYbtw6yUZTTnbP+_X96nJLCcWYwBA@mail.gmail.com>
 <2deb9e86-7ca8-4baf-8576-83dad1ea065f@kernel.dk>
 <2025031910-poking-crusher-b38f@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025031910-poking-crusher-b38f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:51 PM, Greg Kroah-Hartman wrote:
> On Wed, Mar 19, 2025 at 10:37:20AM -0600, Jens Axboe wrote:
>> On 3/19/25 10:33 AM, Naresh Kamboju wrote:
>>> On Wed, 19 Mar 2025 at 20:09, Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> This is the start of the stable review cycle for the 6.6.84 release.
>>>> There are 166 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>> The whole patch series can be found in one patch at:
>>>>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.84-rc1.gz
>>>> or in the git tree and branch at:
>>>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
>>>> and the diffstat can be found below.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> Regressions on mips the rt305x_defconfig builds failed with gcc-12
>>> the stable-rc v6.6.83-167-gd16a828e7b09
>>>
>>> First seen on the v6.6.83-167-gd16a828e7b09
>>>  Good: v6.6.83
>>>  Bad: v6.6.83-167-gd16a828e7b09
>>>
>>> * mips, build
>>>   - gcc-12-rt305x_defconfig
>>>
>>> Regression Analysis:
>>>  - New regression? Yes
>>>  - Reproducibility? Yes
>>>
>>> Build regression: mips implicit declaration of function 'vunmap'
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> Ah that's my fault, forgot to include the backport of:
>>
>> commit 62346c6cb28b043f2a6e95337d9081ec0b37b5f5
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Sat Mar 16 07:21:43 2024 -0600
>>
>>     mm: add nommu variant of vm_insert_pages()
>>
>> for 6.1-stable and 6.6-stable. Greg, can you just cherry pick that one?
>> It'll pick cleanly into both, should go before the io_uring mmap series
>> obviously.
>>
>> Sorry about that! I did have it in my local trees, but for some reason
>> forgot to include it in the sent in series.
> 
> Wait, this is already in the 6.6.y and 6.1.y queues, so this can't be
> the fix.  Was there a fixup for that commit somewhere else that I'm
> missing?

Huh indeed, guess I didn't mess up in the first place. What is going on
here indeed... Is that mips config NOMMU yet doesn't link in mm/nommu.o?

Checking, and no, it definitely has MMU=y in the config. Guess I
should've read the initial report more closely, it's simply missing the
vunmap definition. Adding linux/vmalloc.h to io_uring/io_uring.c should
fix it.

How do we want to deal with this?

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 058c89f72e8c..efa7849b82c1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -70,6 +70,7 @@
 #include <linux/io_uring.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <linux/vmalloc.h>
 #include <asm/shmparam.h>
 
 #define CREATE_TRACE_POINTS

-- 
Jens Axboe

