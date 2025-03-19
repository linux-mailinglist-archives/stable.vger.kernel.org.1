Return-Path: <stable+bounces-125587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F08A69518
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C5216AFC2
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FC21DF974;
	Wed, 19 Mar 2025 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xzQrTZ1X"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E251DE3A3
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402245; cv=none; b=EfX2KioHneXl3Z5MdTkkaDySCysMYhBAHilwnBLNkai8B28mbADuxlLdgr6muAzOx72u0n0y//+OYhTI+6o4kqV5IAwnrGD9AX/P2VJmVyZgoe7pQrUKtjhgqTWAprRlmNhg+Vtk2fEvtB2pxEkShNPXBIzXdkf5r8RfKHNCO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402245; c=relaxed/simple;
	bh=aP0Rl7w80xWkGkqKHRr67yXDm7ulD+sujdgDABoMhX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIEGrejAzqEquU5JEiKexinnG6dlLp4jgXc4GoqCVeU7Hie3iSwWWHmWheE+yjIw0jfbbHNtTQOwk7yq/KRgeeMauu7REMNRE/24WsVZDuyyslda8kqRBPeV7j0NPoTUoRxULwbshJonC+bwH/QVl8RFzsmBM1LnlCqOtEfl138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xzQrTZ1X; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ce87d31480so38962595ab.2
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742402242; x=1743007042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jhbbYo54FrkdrbzdWrKMeFfQjie6aK1LbfZTGe7VZs=;
        b=xzQrTZ1XIVc6mPXq022aBYdfXbDbWyNwCCT5DJmOBDwaE/mpk5u9iqK4cHk9eD9YOQ
         /67wuWkwOIX80yILEJUB/KUG+G52PESppL26V5pDNpCkTz+p/C+SJbTT405x1bnOU747
         Jju5j5FvcxcL5W4MIYwT3abumdxA94kkIU7xA1X80lbv4a13mB4ir2JEE/GENujCi6p/
         sSPXimimK10gDdfOT76hWPLFW6fZ3rDzj/Em7cPjo3V+vkZfsC0m3FsxFkHBzpixjGZM
         oEBkWpS4blVRxl3J9J6GCzLundEC4RDc7uZe0PYx6CMy2pholBJnrr0ZxDxhWy+7r/jE
         buOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402242; x=1743007042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jhbbYo54FrkdrbzdWrKMeFfQjie6aK1LbfZTGe7VZs=;
        b=L5LqbmS1YohHXMzpLUnIsmKpPQ7OfhFmNEvGUqEnb8U5HwxwTH9BAd5Z+D0otGoPCt
         jhd5P9PNnz6SLN0pZ+JAEwYleqcNkSjE6r/olRkwFvvMwcd6yHgeQKpYbrrb18wN7ONJ
         yImlo1EQIpyDMSJbFtIeZQJ79COTLDvY39YfgxBNe+u6RZJuWIjwb3Ylk0Qnn6/irxmS
         Kb+L4jbPKeCyJhDs7aH/isBj6kpgzm3S42R4BXilPIWczJgx5eFztEQL0Gi+PMeL22tu
         w6Lx7gjzyb55TKVgIsIFEemQCHaqHXJCBiEj5ltjf9tWRrXjAp++ordbdaH+V2yWePWB
         YNEA==
X-Gm-Message-State: AOJu0Yx8OI1ZntVEUPeCyPiM+GlWpT9EkqebMoAJSzva9sG2gQ6y7KLZ
	rJbyP95ox/zCgnBv5Va983Dp9rLqQp7QRrpJYJAxapmYW91rdOc9O6CpXetbNsg=
X-Gm-Gg: ASbGncurYOx7E5Vc3KW01RLZ00N5byRe/T+OXysdK35bkzTwu18OE0txeoTYJmsmDKo
	ZzCxy0YssZ/B0Nd+ZlKbPXKdrEIezr3TGDef73eElNM0ah1QM7Cy6BM9j7D5JY091T5F1dE19a+
	O/SYGqsnxGDKbXGbc3I9aImfOJv0olLNY7/Sq8kvxt0RJ3L6PyyLGiDsbPlMY1b8E/YwKJwmQsZ
	0D3YxvWX8Zmez7uksKM8TuR8T2ZcKE3wXYJUiAhVoExIwRINxdtmqJk0bnpBCZIV9ReYqf8CpXc
	D05+xl7LypAuWtugRi2lIvnHgL4RZGj6E7Euzdxpi9/8Toyly8A=
X-Google-Smtp-Source: AGHT+IGaCxxqOmIU5qslU5LzXO4appalUTv0emoln2y9KsdecB1szM6soHATQf4I1FwwkjFCnXzgvA==
X-Received: by 2002:a05:6e02:1d0e:b0:3d4:36c3:7fe3 with SMTP id e9e14a558f8ab-3d586b44302mr26627605ab.9.1742402241910;
        Wed, 19 Mar 2025 09:37:21 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637fb2b2sm3303066173.94.2025.03.19.09.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:37:21 -0700 (PDT)
Message-ID: <2deb9e86-7ca8-4baf-8576-83dad1ea065f@kernel.dk>
Date: Wed, 19 Mar 2025 10:37:20 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/166] 6.6.84-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 io-uring@vger.kernel.org
References: <20250319143019.983527953@linuxfoundation.org>
 <CA+G9fYvM_riojtryOUb3UrYbtw6yUZTTnbP+_X96nJLCcWYwBA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+G9fYvM_riojtryOUb3UrYbtw6yUZTTnbP+_X96nJLCcWYwBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 10:33 AM, Naresh Kamboju wrote:
> On Wed, 19 Mar 2025 at 20:09, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 6.6.84 release.
>> There are 166 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.84-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Regressions on mips the rt305x_defconfig builds failed with gcc-12
> the stable-rc v6.6.83-167-gd16a828e7b09
> 
> First seen on the v6.6.83-167-gd16a828e7b09
>  Good: v6.6.83
>  Bad: v6.6.83-167-gd16a828e7b09
> 
> * mips, build
>   - gcc-12-rt305x_defconfig
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducibility? Yes
> 
> Build regression: mips implicit declaration of function 'vunmap'
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Ah that's my fault, forgot to include the backport of:

commit 62346c6cb28b043f2a6e95337d9081ec0b37b5f5
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Mar 16 07:21:43 2024 -0600

    mm: add nommu variant of vm_insert_pages()

for 6.1-stable and 6.6-stable. Greg, can you just cherry pick that one?
It'll pick cleanly into both, should go before the io_uring mmap series
obviously.

Sorry about that! I did have it in my local trees, but for some reason
forgot to include it in the sent in series.

-- 
Jens Axboe

