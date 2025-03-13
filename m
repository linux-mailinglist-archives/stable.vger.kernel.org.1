Return-Path: <stable+bounces-124314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542CA5F71C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 14:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4857E7A9667
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501FF2E3366;
	Thu, 13 Mar 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXafg86c"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA3266EF5;
	Thu, 13 Mar 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874370; cv=none; b=C8XnG+WwBpyRQpHzYKDDYZIFh5NhTuRxCg5clqrZK2qwLi6vRdClxLglLEAfAO2NjvPlfggbA/LUIU/lLaQ3pEMCnbpE1e8nypjkaBiyBsz3JdabGbmOC3F4NCyo8d/PGm0uo4e+r6h5MegLk+wzTZc/rrtmM0Z6joWajoxLF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874370; c=relaxed/simple;
	bh=THm6FaQQgLW/8m8yRNpcmIzkqlxy2yVeotJDAywN9dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEA134UIS2846jr0XvVG/Bg9njJRVec6ui0UJVKcyczYshwfBh0D0nk9U1I/Af7wW3vor0JqjaYghk0UGVqpmVNnb9pQCTtD8dTxlIF/ReIqbsMgG9Ldxn0msu2zui2SfYWKVMTfchH9uGRFDAayAfQEIs2vpmtf2Z4kQZNlKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXafg86c; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72726a65cbaso676457a34.0;
        Thu, 13 Mar 2025 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741874367; x=1742479167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5OPl5i71ZdSAzYa7F6yiKwtJ4dNnBEhCh3JI29+eh4I=;
        b=kXafg86c3znNijlZUJFbsAyKY+KXSh/QX8z8cOEND+QgglyvVF8DpY7AEfOGmT/oo2
         5+afZJwRetGmII8d9RoR8MHgRYEerOu4lkMS5GdC0R53NTQGzfgzoJNjbfEkS/haGo8k
         4uVK8IVBjzDk5aX4S9CdH9kvYIjnLvQtR+uCyms+mlfM/LtQXFaNK5aJvx3vpsO6L0vy
         Ljp2davnbABh0a4wNWy+D/ZEYPPw8nDxrTHXI6WdupeNB0njhQnTpJhShsrUM5tDOMeZ
         s/lEmAz/kncuDfmt3vqZLfjMteVMIn9fUkul2+FYBuWp9aTm19rp1sHwb/sOayIvH4C7
         KR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741874367; x=1742479167;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OPl5i71ZdSAzYa7F6yiKwtJ4dNnBEhCh3JI29+eh4I=;
        b=BnJySQO7p/xVtU+/zSEVKaaZKdSWoT1NAdai82mEsudKrIYQTvUkXJS8Aela0w0umE
         ojzlprK6gDMN5UFJkYLJLCAB9b0Q1VD+4yppABXwx/B6fxLazzljDJMsQwjF3oy4pPEb
         kkK+vHMTXRSyZQFcBnVrRyuJg8rfRXph3WsWyZ+F7Cd7cYt93L5WRklOBTaTHsfMfcSQ
         wUhMuat+u5DFjsMxsy/ZA7s8ZTqX/NAmzYFFrYBIpeHzvBENhvWGq64SPOCMvOhOYZnz
         e5aOEb7AYKPMh0TrH+kD9kdKuqVI9Z+B/5RiLI1UkaNfn6ZIau1KbKFktzoTETy99kMr
         ZBDA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5gYdRwblKFLLh8x1+xkgCWyW2LJq+Tx2YstAdTurSsqhSYcKYgX4uQFjsUD8KHkV3oluUCQ8lAT/fdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMd2jfMqcuORoI5YIAAMnucEvvJ0k2pgciw9GeHbu3wF0R6drK
	7WRkQuukmwtB/AuyUTsBLcJ/FGCeGQXrNCnTQLfuKvjiC3vfuxGp
X-Gm-Gg: ASbGnct5wJN4Nsc/LIqarY8ThcSUo+R+8bdqXgrnWTzBmLmDhgoZzDn/RojbfdrAYvO
	1wbrflc/pTjoxQPeZfC6LHurPIQs7wdeRey04KAYUh/meCyZjaIcqsczjC30IaZaisa3lIzxLT5
	2onU+05zrsnZ+Q9kiJd/s+K/PQkjOs0PGs4ROHMxUG22PWTUGkQr6ESRdATlM0ET6933cMTCdvR
	u+rBFX1grfJuc6OljrYyQ051SlZY3R4SRum132RdR3+B2j+XV2Z0HQohf0abfd206xB56apqEIq
	6b3K1N5xAbM8UvB+nUYSZXZFBFNMtQjOk3H+QrVoiRxcPo25Cs47vLlaK+o4cW9Z1U5yIt3oKHv
	wXGPqSek=
X-Google-Smtp-Source: AGHT+IHvFoab+GDvaJG+xkWK0e3xxY4hzqJWEGrTyUuy0qbkjGICwxHCh6DPBxJ+i2yexq/5R3XwHA==
X-Received: by 2002:a05:6830:6e99:b0:72b:8a8b:e02d with SMTP id 46e09a7af769-72b9b319d94mr6962019a34.5.1741874367573;
        Thu, 13 Mar 2025 06:59:27 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb269dfbesm213185a34.22.2025.03.13.06.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 06:59:26 -0700 (PDT)
Message-ID: <603b3f10-6ad9-46af-8b31-d11e46f4698a@gmail.com>
Date: Thu, 13 Mar 2025 06:59:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/328] 5.4.291-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250311145714.865727435@linuxfoundation.org>
 <CA+G9fYtG9K8ywO4w2ys=UEuD_r1LgOuZhG4cg62YKAX0qK35cg@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <CA+G9fYtG9K8ywO4w2ys=UEuD_r1LgOuZhG4cg62YKAX0qK35cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/13/2025 12:19 AM, Naresh Kamboju wrote:
> On Tue, 11 Mar 2025 at 20:33, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 5.4.291 release.
>> There are 328 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 13 Mar 2025 14:56:14 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>          https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.291-rc1.gz
>> or in the git tree and branch at:
>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> NOTE:
> The following build errors noticed on arm, arm64 and x86 builds
> net/ipv4/udp.c: In function 'udp_send_skb':
> include/linux/kernel.h:843:43: warning: comparison of distinct pointer
> types lacks a cast
>    843 |                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>        |                                           ^~
>   Link:
>    - ttps://storage.tuxsuite.com/public/linaro/anders/builds/2uDcpdUQnEV7etYkHnVyp963joS/

Yep, this is seen with net/ipv6/udp.c for the same reasons, see my 
comment here:

https://lore.kernel.org/all/0f5c904f-e9e3-405f-a54d-d81d56dc797e@gmail.com/
-- 
Florian


