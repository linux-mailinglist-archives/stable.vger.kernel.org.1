Return-Path: <stable+bounces-182972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609DCBB13BD
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21ADF2A6F1A
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193F27F749;
	Wed,  1 Oct 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQ9ZdcPp"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7ED27056D
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335543; cv=none; b=Pokf5FnnaUZXJf16nBXtd/sArwWP+jeRyQOxKeOlVJkKSl84QuhlqcuK9k+qAN4ln5sQRaL0W6BcVeDnuUfZWnvUQlLy0QQYgBwmvjy2OKRmkfFtdIOtVcAIQndgDyXm9qZATJVXoHUilZltnS8DbD+L7tfToWoXkYn6ixjgrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335543; c=relaxed/simple;
	bh=VfIZnBuuXwbK3IWB7Akbz8kdzqSwGJv1M2L6QUoR7uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPZuAxo0Q46FYXjlGn6Om4EteXkS5b9WDZYqI6dReUmsO0vzmr4lsdeNLR17GZ9CtbJ30ITl/68/HbfTwnSdeeFGH57sXe9uOmNg+WS158O62lH6rSmiMbKN0edl0Cc0EJUnvFNNy0Lv2KvKOquPK7fFZ1/gTHJWOuLxboNTdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQ9ZdcPp; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42594fb2fe9so63425ab.3
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759335541; x=1759940341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=310GXMr4EGkw4tBWn7jL9r751VwpOohlwnfgRE/DlJM=;
        b=VQ9ZdcPpXchhVFMY4Rmi49HlajYbraoMDHLKPjRHODsnmKNRS5SZCBlt/maTUlK6Tm
         v/VxepczpZzt84o4EKkrdNL046bx3N3K4Wd0kxFbIjE5k6Axguim7JNCpfrkbelO7/CW
         vKxA9J3V0SC9KZlrkPEBO88b5HYwOo3zc/nH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335541; x=1759940341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=310GXMr4EGkw4tBWn7jL9r751VwpOohlwnfgRE/DlJM=;
        b=FZOVAgm6Zp4TY3mqXH63f/PsbW4uhRjvpeOiB9PEFSEnm9OHmuCtm0pdqdYvZFUfvH
         KfLHfMwYW4dlZIXsL7ZrRNfPQM+FeLTNTMKT15PGcxgGMGf7TlaO0yxxl3QKx6w9GVhY
         L75TIuwlj4c7QJveL94tom0ddWT57mgy2gfSEGaL2Rr53JXnmXf80zAZsue+GjS8o2iW
         pMCZqUAulhe80mZB51VfknJJt9AzEBuXzzQU2vE/b435aMlsiGreY7IcA16JOHvmu2UI
         PJuoymbEdxP3JOb36wzoslohOH/fS9CsKu/6SsGL6xP1orfqpE6Y1WIYGrD7zAsnHhQV
         lLkA==
X-Forwarded-Encrypted: i=1; AJvYcCXx+M9rQhTi51UPrPEHIzdPmgdb+QoNdMk5WRS4j9WH1KNRvWc4x5lsdoUAQTAiHwp5I4qe/QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBs9Mrz4gEqbRx9Aw/BLKnpB29NYPHdShp/tGpHtavxptqA/zf
	ydo6agDE8NjVArr/vhjiZikEgh25xWytiPLGDNkMUQSfoF+OMPpzIf5FikX3uZLxwl8=
X-Gm-Gg: ASbGncuaYnMFWV/1quBuSwYJAVZP6zJbs7m0Pva7Gx4SQwTR+BFJoGajKUAMKpk+fiM
	rbki3t9Wna2r8nT5fnekr3HpvShRL4vl5HQ2HKMvikuYkQ2cXP93rbyxiNJcBO0eFg8aKdpZIiy
	8QxACB4L2W4R4VhOUeXImCRoR6Nd3lLoVUdj5BljFBiVfTLUxgkzgvZ+0/xAQuIBDal0VkIBqWo
	puBs5pU3+hSYQNSQ6NuedjDrQo7KSoz0562ZKdYy/ibiyKRAoKPd5slugMZ7aqHLrvNcenCnxAv
	nyoKHg/B9BoykmPF9x0Jvqdzln9b0Gu2Qmsz861vgsmZj7nt4F92Mp+maaEOI8UVocD2JNbpRV7
	1KqUiw86GhfwvkB6hY6HG1eep7s4PlkwaGtyOcnAVMHuqmQBxN+FiDBz0LbZg5J2KMH6ePg==
X-Google-Smtp-Source: AGHT+IEnXWfyHiu0RepE/42DRKFrYsy1KrLdW46lG4vj8sMVf/WcdNKD770NIyGOoBca6Vs+nul+gg==
X-Received: by 2002:a05:6e02:219b:b0:427:de6d:b6ed with SMTP id e9e14a558f8ab-42d81611b33mr58944135ab.9.1759335540828;
        Wed, 01 Oct 2025 09:19:00 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6508a1bfsm6995443173.18.2025.10.01.09.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:19:00 -0700 (PDT)
Message-ID: <09ba5f85-701f-4889-962e-f7bf5bc2dd4e@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:18:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/151] 5.15.194-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.194 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.194-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

