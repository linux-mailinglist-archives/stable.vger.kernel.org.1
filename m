Return-Path: <stable+bounces-28208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3260787C4F6
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 23:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55ADF1C213C5
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 22:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF4F768F5;
	Thu, 14 Mar 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mSmRrKTt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CCC7641F
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453905; cv=none; b=bB14aHl1BZjLPTdSN8f0OCk5LAl7ZpUf7Biwag3RBFPoWpmj83OvtIDMZmx+ySTxptsiCd4F6pepqzEG5RqvwymtlT0RuegBakmszhm2o+KQP99vpOcEHqAwDdRczsdBBk+bD3efW2tIlZFO2yB9kg7RKhHDe4QbyeJhcyQ0llc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453905; c=relaxed/simple;
	bh=0ta4xpsyXn+IlOMSksA4Z72gxeLEkm+CyK+rbVbJyq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijcA/4mKn6ahoZrwi1iNyCKxiTq/3YLJN0WTVv9Rwe16BO2iEYBAfgDFzCB2AWKLOTaVvYCaqJHbvgfLApviUDH2hSY2l6Jg15Q6vYsJyNbKPMoUrqMJp0TLxkljNtCaA1ccOjLEuEqgIO71/wz4T/tZ9y7syJ6O52khEIQjURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mSmRrKTt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29de7593a0dso76998a91.1
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710453902; x=1711058702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hm8d1Hcbvrz1Xm7p+pPzVG8m/S18y76QUC/hnjvuXiE=;
        b=mSmRrKTtj8YuvZn5LGlwN+a1DCw56wtG6HOqtG8hpb6F9kU3IaUNVHo5APSC8dzf1E
         qJYva4U5I357foxSVx3Z6Caav2yKFoN/BHmidt6nsBos/EzT0nNOry6yvg1y0yMrD1fh
         cW+C+jF00sfRKcWYQW+61ePmAw4O2iCKE7O1xepk/nn3t1Y6Oq2gwsbnNhCu0wXDY70E
         lGrGP6lQGtJw8KIQYYRMt+S6/K7LfQVvUmWSQ135AsbXqhszB0In3Xag1DSem6kgLV4i
         uWPyu4GtRFLRkBrWMVH8oMIfmbibJcU/hxAZI8rScyGtmY1xKOkMoDbyceoa58/7A/m9
         Iffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710453902; x=1711058702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hm8d1Hcbvrz1Xm7p+pPzVG8m/S18y76QUC/hnjvuXiE=;
        b=FprvMabc+STjlu6cVJQALHidCfg0YorkzkSDNv6ZhJOEf5unW2OZi1REMIH0TYrwMU
         8fIDxGc8xw65Sw9N1aedpFkO3xbziMnAuWw2LDpoxiYKVAmH6SSDewrt3ypKI9QmaeOj
         GBxNOlJii8V9x4h4u3ae8vnBlqcFNEPNM4BX2qE5MQ6uqerfST48YIoYX0eRhL6spMas
         rFmIo/sv0a6rX5uXNTZVhOMQeWFNUnqh8b0TcooxskM3/DmD8ZD76Xc76Ewb+TM+nw2S
         MI0it3HCF51aLJAIXEMEyjuQyC1Ucasm1oHzAblRAAzZZskUFCKGHcULS/RlMnQbOqB2
         6b5w==
X-Forwarded-Encrypted: i=1; AJvYcCW//6/EqhJVKaZ1KvykaJleEse3rCyplib0Lp1Fh2f7/HZWWhJpxo6aXirkd0AKnKfVc4lZgUJ3C85kpDkpK0aL0/+fICGF
X-Gm-Message-State: AOJu0Yzo1f34CutVldGvRi7F8/08OOTH6DwGPaqNZjvXAnHBwdMp6RmM
	GL7YnGu9gizUlXwsgTl/ySyVFTmkuufeWQwcqbgTRXLyX9Vs5qCOpByZUBnWyGw=
X-Google-Smtp-Source: AGHT+IHxRLhscRlIUF7ruwUsmYgw/7D+idYOlWQ7Z5GDHDpFmoiNfIb8D5q0I/tt8qoaZ6Mab7ztZQ==
X-Received: by 2002:a17:90a:b890:b0:29b:cc5a:c00a with SMTP id o16-20020a17090ab89000b0029bcc5ac00amr2858259pjr.3.1710453902350;
        Thu, 14 Mar 2024 15:05:02 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ss3-20020a17090b2ec300b0029de7f89d96sm736417pjb.36.2024.03.14.15.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 15:05:01 -0700 (PDT)
Message-ID: <38563683-300a-487b-81c6-b2ea4dbb925c@kernel.dk>
Date: Thu, 14 Mar 2024 16:04:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
Content-Language: en-US
To: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
 Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de,
 Andreas Herrmann <aherrmann@suse.de>, Tejun Heo <tj@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
 <73072bdd-590a-44b4-8e6d-34bd17073bb5@o2.pl>
 <ecb0b6a1-a8e7-4645-9a2c-56ada368f733@o2.pl>
 <ba297ed4-a74a-4786-a303-ce617b2de09b@o2.pl>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ba297ed4-a74a-4786-a303-ce617b2de09b@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/14/24 3:12 PM, Mateusz Jończyk wrote:
> W dniu 13.03.2024 o 22:27, Mateusz Jończyk pisze:
>> W dniu 13.03.2024 o 21:13, Mateusz Jończyk pisze:
>>> W dniu 13.03.2024 o 17:38, Sasha Levin pisze:
>>>> This is the start of the stable review cycle for the 6.1.82 release.
>>>> There are 71 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Fri Mar 15 04:39:56 PM UTC 2024.
>>>> Anything received after that time might be too late.
>>>>
>>>> The whole patch series can be found in one patch at:
>>>>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.81
>>>> or in the git tree and branch at:
>>>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>>> and the diffstat can be found below.
>>>>
>>>> Thanks,
>>>> Sasha
>>>>
>>> Hello,
>>>
>>> Kernel hangs during early boot. No console messages, nothing in pstore.
>>>
>>> Tested on a HP 17-by0001nw laptop with an Intel Kaby Lake CPU (Intel i3-7020U) and Ubuntu 20.04.
>>>
>>> This CPU is not affected by RFDS (at least according to the Kconfig message), so I have set
>>>
>>> CONFIG_MITIGATION_RFDS=n
>>>
>>> in Kconfig. I do not have any updated microcode (if any will be provided at all for this CPU).
>>>
>>> Greetings,
>>>
>>> Mateusz
>>>
>> [snip]
> 
> Bisected down to
> 
> commit d3d517a95e83a7d89e1ff511da1a0a31c9234155
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri Feb 3 16:03:54 2023 +0100
> 
>     blk-rq-qos: make rq_qos_add and rq_qos_del more useful

Do you have:

commit e33b93650fc5364f773985a3e961e24349330d97
Author: Breno Leitao <leitao@debian.org>
Date:   Tue Feb 28 03:16:54 2023 -0800

    blk-iocost: Pass gendisk to ioc_refresh_params

in there?

-- 
Jens Axboe



