Return-Path: <stable+bounces-28215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA5787C53F
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 23:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C748428341D
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 22:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D7D64D;
	Thu, 14 Mar 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uSjoLIYA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D0C13D
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456059; cv=none; b=TPfjXJkXSAvYw+0iywR38suSStrNAo9lefZvUK521kS2zTHfR35NmuQuAD5oxtE9ItYOy3FXW1Cb4/SLQWjUSl/7JfqyYg5YM/XumWphVhsx5iftip42KgjxTAqNF6VJnzJrjcpzncdZ0zRC7tu2OkEpeXCv7Q25knm/hwmfcJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456059; c=relaxed/simple;
	bh=NXSsCunqHmPTbfFf2oyWdUfXJxYPElOJwoRBAwDhicE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9KTEturmrTX3I/0gy7WraplhAAJICIkDIJPKXaT5DlXsJAnmLBJcphbwK7k9GEWtcVL2BEwO19XY5GbPtLhliwEluGVfljDsoK/Fz49kDlqj4WYa66RK8SDNClxvYZvh5ZhZ8NFAfWVsVb9aexfuAyer1cwcXLs0Avg0PnckYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uSjoLIYA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6c9f6e654so295206b3a.0
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710456056; x=1711060856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MG0ZxSxwkpwszjQtH3EW4CVH6bqHDbV18Vis5JdehwA=;
        b=uSjoLIYAsA08wA7Zt+teJ4k3yY3OPjCcR8v8czWoyY39aeq8/Ne2e9ruP67gZSJPEm
         cJrnF5SnaU5jdrq6ntXOYz6SEu1ok2XEOKD7pwRMPLyec203EwQyP3JyJ+lVDyot0LAf
         ZPXD0CIy8lvjLGoB102r5+zPg+g003S20Brp0Cp7F0Y5OKsLP5sW83140zRZeSeXPNKJ
         WjBaB55tUvwV6dNWxgU4XOsKYXR+jiz3zBIW6EeVX4aTJvigdncvT6o7XxJAkuJj+skc
         kodrGSmqqMFu2numsQ3VAnXbDhYdXvYlKw2uM9HNCrRDXfE34gEGcUvhNjTsBt8PZ1W3
         TVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710456056; x=1711060856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG0ZxSxwkpwszjQtH3EW4CVH6bqHDbV18Vis5JdehwA=;
        b=GISqxP4tXZZGW8p0SNZOkcChoYSQsjizKcR1TPwNYjMJmxundC07gd+sYUPt89hBc0
         o7w9m+3gxyiicVi8qhZWndFIivvzhG2nFDN9lc7TLzHykBLm7AMpebDayEGZVJBiYXJR
         xvwXsBivRCnYZeAAlp6qsC5xv3GDKi3n7kZNCjt31bsHTu7xUHr9pbgHr4fdNy2bPyRl
         oVMW+R32PkXPvaQo1QUEjuIkXZe+HlD1dZbES08e9beK6ZNBF6kpbrEHuaF1ggUEEhRT
         VQw2EfqE5ipC456awvBouaSUhYAemKFUImFn7OeRQkdDUhRKpXhGqtUAWEKlfuaC0x7v
         UYEw==
X-Forwarded-Encrypted: i=1; AJvYcCXq42ErCCuAX4bQnGbmU22u/vSQwsnYfe2az81drT4daNGKrMqo0eUlROXDCD5j4pCNoMOw19CCH9lvZnI5BJ5JJIWDua1B
X-Gm-Message-State: AOJu0Yx1VTDvs8IG6vyPKd9LmsiagvKQfLM6154lGsbEVVH95Z4DENSu
	fKSCtpfojy9or3BYcaCT6TUGFebs/DUfo3Y8+LW4v8ybVcsdpnJNBbTNA6kdV+Q=
X-Google-Smtp-Source: AGHT+IGmzVHnggzMjRdOQbO7C7VMVvlqyXn5EzqCSSl3W6KcB/g0N89RbCBlT9bw91P9sOmCXf/rpQ==
X-Received: by 2002:a17:902:ce91:b0:1dc:df03:ad86 with SMTP id f17-20020a170902ce9100b001dcdf03ad86mr1528988plg.2.1710456055617;
        Thu, 14 Mar 2024 15:40:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id y17-20020a170903011100b001db5b39635dsm2250263plc.277.2024.03.14.15.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 15:40:54 -0700 (PDT)
Message-ID: <267b0000-fba0-4dcf-945d-72b8ca4704c8@kernel.dk>
Date: Thu, 14 Mar 2024 16:40:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
Content-Language: en-US
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZfN7wtnVeb9vOL1H@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/24 4:35 PM, Sasha Levin wrote:
> On Thu, Mar 14, 2024 at 04:04:59PM -0600, Jens Axboe wrote:
>> On 3/14/24 3:12 PM, Mateusz Jo?czyk wrote:
>>> W dniu 13.03.2024 o 22:27, Mateusz Jo?czyk pisze:
>>>> W dniu 13.03.2024 o 21:13, Mateusz Jo?czyk pisze:
>>>>> W dniu 13.03.2024 o 17:38, Sasha Levin pisze:
>>>>>> This is the start of the stable review cycle for the 6.1.82 release.
>>>>>> There are 71 patches in this series, all will be posted as a response
>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>> let me know.
>>>>>>
>>>>>> Responses should be made by Fri Mar 15 04:39:56 PM UTC 2024.
>>>>>> Anything received after that time might be too late.
>>>>>>
>>>>>> The whole patch series can be found in one patch at:
>>>>>>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.81
>>>>>> or in the git tree and branch at:
>>>>>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>>>>> and the diffstat can be found below.
>>>>>>
>>>>>> Thanks,
>>>>>> Sasha
>>>>>>
>>>>> Hello,
>>>>>
>>>>> Kernel hangs during early boot. No console messages, nothing in pstore.
>>>>>
>>>>> Tested on a HP 17-by0001nw laptop with an Intel Kaby Lake CPU (Intel i3-7020U) and Ubuntu 20.04.
>>>>>
>>>>> This CPU is not affected by RFDS (at least according to the Kconfig message), so I have set
>>>>>
>>>>> CONFIG_MITIGATION_RFDS=n
>>>>>
>>>>> in Kconfig. I do not have any updated microcode (if any will be provided at all for this CPU).
>>>>>
>>>>> Greetings,
>>>>>
>>>>> Mateusz
>>>>>
>>>> [snip]
>>>
>>> Bisected down to
>>>
>>> commit d3d517a95e83a7d89e1ff511da1a0a31c9234155
>>> Author: Christoph Hellwig <hch@lst.de>
>>> Date:   Fri Feb 3 16:03:54 2023 +0100
>>>
>>>     blk-rq-qos: make rq_qos_add and rq_qos_del more useful
>>
>> Do you have:
>>
>> commit e33b93650fc5364f773985a3e961e24349330d97
>> Author: Breno Leitao <leitao@debian.org>
>> Date:   Tue Feb 28 03:16:54 2023 -0800
>>
>>    blk-iocost: Pass gendisk to ioc_refresh_params
>>
>> in there?
> 
> It's not in the 6.1 tree, do we need it?

If the bisected commit is in there, then yes we need it. It's marked as
fixes that, so puzzled why it isn't in there?

-- 
Jens Axboe


