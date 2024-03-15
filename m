Return-Path: <stable+bounces-28246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B131F87CF6D
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 15:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AB62824D7
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDC3838C;
	Fri, 15 Mar 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GzXaIvL+"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260073C6A3
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514180; cv=none; b=oFKZGcj35iLDjGU4NxV4/Ol+2E+YJKQ2Y5EzPfIKK5NHl8BnQ0Kv27b9TEZyaDUtgOSh1YzGD1rHrZcaKAAstQSo062ZruX/cua/YwHnMdhMkGe2JC4LUbtvtK9hVPa7cma8RIxrKVcQX6QANiLDPNTsrwcPnUwozmwWciX+OBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514180; c=relaxed/simple;
	bh=s7LMTi0Fg6fuD7ecyJ7KOusbMT2olk0yATR75gQc3Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqoxZ3EYmNGwvuKNNZlrB3qiZDTW/2SKtx+p14/GWlatqSmTvWSwcSeY0pnXbeWWVgdDZsPYejSXoX2BCxqRKi9jJlg3Il3wO2lTlMfUFPn1bgNX2G51lpJhB3ztsq0tYPJPZszSkL5XVTxhnMBW2qNsGuquSZP2MluUW14+6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GzXaIvL+; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a47d07e9c3so12797eaf.0
        for <stable@vger.kernel.org>; Fri, 15 Mar 2024 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710514177; x=1711118977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5unUc7E0mRlRw9bQh5QKWA0VCTQs123Z4x6PEhioE8=;
        b=GzXaIvL+4vsvtKi+tYFf/ZBjEVhtd8J1F8QC5McO5drkDdMQliRoe4d6Fb7EbsjtgW
         Y/3gMCb22JGActSuekVXusbem9AUC9mkdyM1YBwqM6rbCgiUZb7rnDyBTMFoqHJGNxRS
         VhsIJEdRjvdcs2SIULYLM+l1B389C5eFWJ6us44T/ik6WLXMoJ4/V+zsezV9tYC7NYea
         H6+S5Iy4bGEdLpDElPRNgvnZavuE2PUwQ2LdGMWHlIYqRe9g69mN24u6k3mKnyvInAL5
         YwRr13WOy+FCkVbH4baciTTJp38CPNC/8L/CRUGqL6APdC5t7C8/K1bPWD4YhMgtA+qP
         zgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710514177; x=1711118977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5unUc7E0mRlRw9bQh5QKWA0VCTQs123Z4x6PEhioE8=;
        b=a4dvrEcP1FpdTY1q2o6W/Bxrd+xvSvYViSE2MtkyOQvIO08R7rGN8TabpXli97OYBa
         hCfB1SZeKflRqddpeWo0uxMTcz/Zt3ceG/i5VKonq5FTBp1thMtHqwwamm8GI+bkNvAz
         syjIJe56mZIUkRSN0h0ojhJLaOePrDDA/UIzDAbrs/TvcVzGX9AcQld++OLTWOiqyuTs
         fkIz4+lNIx/y5wQ9Tup+tALZOFb/6txfTfeYObC/FBDBVAKOq8+W6hI3uI+uPnby9am3
         RcGjkBZZB6t2QLr8CJ78B8izLh66Xr+Ap+ykZ5LMM8aR+8LCP8mpnSDSch+Z+N86Z+e5
         1ERA==
X-Forwarded-Encrypted: i=1; AJvYcCWzMKw14KDs28ce5oGbvGY3wq4QjMzsBTdrc0E04KWIJ6J6huScqORm2NIv+DoCHu22pxBLAgHMnSiry/E2rpfHIHXR2rJ/
X-Gm-Message-State: AOJu0YxFsm9D2h4W7l8dgS+RDYSjvhlPNGCh3890vZNY5ZtQYS7MaTCa
	Z7zlR1OQQ8ALW5vmalNtT4nOPyBcxHIz4HlGJIPNXTN8VHRsCRBOmFNR8dHT1fU=
X-Google-Smtp-Source: AGHT+IH3semG+OPUZGyW1qq1jr3UrZ8khY3sC+mB0oIe8DrsRqkZxMQ8RVmbbSbQrzH4Ea4V3lyjSQ==
X-Received: by 2002:a05:6358:5907:b0:17e:b6cf:4859 with SMTP id g7-20020a056358590700b0017eb6cf4859mr3193427rwf.0.1710514176989;
        Fri, 15 Mar 2024 07:49:36 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21d6::1191? ([2620:10d:c090:400::5:e738])
        by smtp.gmail.com with ESMTPSA id b192-20020a6334c9000000b005bd980cca56sm2601460pga.29.2024.03.15.07.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 07:49:36 -0700 (PDT)
Message-ID: <e03d0f75-b9bc-4f60-9824-d827df840425@kernel.dk>
Date: Fri, 15 Mar 2024 08:49:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 Andreas Herrmann <aherrmann@suse.de>, Tejun Heo <tj@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
 <73072bdd-590a-44b4-8e6d-34bd17073bb5@o2.pl>
 <ecb0b6a1-a8e7-4645-9a2c-56ada368f733@o2.pl>
 <ba297ed4-a74a-4786-a303-ce617b2de09b@o2.pl>
 <38563683-300a-487b-81c6-b2ea4dbb925c@kernel.dk> <ZfN7wtnVeb9vOL1H@sashalap>
 <267b0000-fba0-4dcf-945d-72b8ca4704c8@kernel.dk> <ZfQ7wRX06R-d3X7F@sashalap>
 <ZfReb38_gCrKno7A@sashalap>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZfReb38_gCrKno7A@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 8:42 AM, Sasha Levin wrote:
> On Fri, Mar 15, 2024 at 08:14:57AM -0400, Sasha Levin wrote:
>> On Thu, Mar 14, 2024 at 04:40:53PM -0600, Jens Axboe wrote:
>>> On 3/14/24 4:35 PM, Sasha Levin wrote:
>>>> On Thu, Mar 14, 2024 at 04:04:59PM -0600, Jens Axboe wrote:
>>>>> On 3/14/24 3:12 PM, Mateusz Jo?czyk wrote:
>>>>>> W dniu 13.03.2024 o 22:27, Mateusz Jo?czyk pisze:
>>>>>>> W dniu 13.03.2024 o 21:13, Mateusz Jo?czyk pisze:
>>>>>>>> W dniu 13.03.2024 o 17:38, Sasha Levin pisze:
>>>>>>>>> This is the start of the stable review cycle for the 6.1.82 release.
>>>>>>>>> There are 71 patches in this series, all will be posted as a response
>>>>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>>>>> let me know.
>>>>>>>>>
>>>>>>>>> Responses should be made by Fri Mar 15 04:39:56 PM UTC 2024.
>>>>>>>>> Anything received after that time might be too late.
>>>>>>>>>
>>>>>>>>> The whole patch series can be found in one patch at:
>>>>>>>>>        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.81
>>>>>>>>> or in the git tree and branch at:
>>>>>>>>>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>>>>>>>> and the diffstat can be found below.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Sasha
>>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> Kernel hangs during early boot. No console messages, nothing in pstore.
>>>>>>>>
>>>>>>>> Tested on a HP 17-by0001nw laptop with an Intel Kaby Lake CPU (Intel i3-7020U) and Ubuntu 20.04.
>>>>>>>>
>>>>>>>> This CPU is not affected by RFDS (at least according to the Kconfig message), so I have set
>>>>>>>>
>>>>>>>> CONFIG_MITIGATION_RFDS=n
>>>>>>>>
>>>>>>>> in Kconfig. I do not have any updated microcode (if any will be provided at all for this CPU).
>>>>>>>>
>>>>>>>> Greetings,
>>>>>>>>
>>>>>>>> Mateusz
>>>>>>>>
>>>>>>> [snip]
>>>>>>
>>>>>> Bisected down to
>>>>>>
>>>>>> commit d3d517a95e83a7d89e1ff511da1a0a31c9234155
>>>>>> Author: Christoph Hellwig <hch@lst.de>
>>>>>> Date:   Fri Feb 3 16:03:54 2023 +0100
>>>>>>
>>>>>>    blk-rq-qos: make rq_qos_add and rq_qos_del more useful
>>>>>
>>>>> Do you have:
>>>>>
>>>>> commit e33b93650fc5364f773985a3e961e24349330d97
>>>>> Author: Breno Leitao <leitao@debian.org>
>>>>> Date:   Tue Feb 28 03:16:54 2023 -0800
>>>>>
>>>>>   blk-iocost: Pass gendisk to ioc_refresh_params
>>>>>
>>>>> in there?
>>>>
>>>> It's not in the 6.1 tree, do we need it?
>>>
>>> If the bisected commit is in there, then yes we need it. It's marked as
>>> fixes that, so puzzled why it isn't in there?
>>
>> Sorry, I take it back - both e33b93650fc5 ("blk-iocost: Pass gendisk to
>> ioc_refresh_params") and d3d517a95e83 ("blk-rq-qos: make rq_qos_add and
>> rq_qos_del more useful") are currently in the 6.1 tree.

I didn't see e33b93650fc5 in there, but maybe it was part of the series
that this is about.

> I'll go ahead and drop the backport of f814bdda774c ("blk-wbt: Fix
> detection of dirty-throttled tasks") as well as the dependencies (which
> is where this issue bisected to), and all follow-up fixes.
> 
> We can revisit this for the next release.

Sounds reasonable.

-- 
Jens Axboe


