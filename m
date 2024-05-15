Return-Path: <stable+bounces-45181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FEB8C693C
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBC11F2195F
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10778155743;
	Wed, 15 May 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S4nuTNKJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8457E15573D
	for <stable@vger.kernel.org>; Wed, 15 May 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785617; cv=none; b=II/E2iLpoCFo0rLPLdUq2SQrd9yuRlRu7O+eCYQrW3rvEwg+uB4LhyYOU+bpSrkxU0SaCGz8E7V8hH5sYcdeqtB/wzgiqYVsW9ofV3qoB4qM5tD3Uh5fCEJ6iHgI9abjAHgRM7kMZTskCNs1GOXBvrG5umQgCAdc2Fx+eOCxiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785617; c=relaxed/simple;
	bh=RIAoqjM14Fu2GXpQuniUrr5udioxLXnLSlEc1B8cx3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owhF+Py53WkYIK4eAOfUkSRpHE3RPJcqR7y2ptxo/tlhTUI/btpxhBtH+DCpwEpUergGewv9MYts1rs1swGA3YhXyWxrz3/EwyQaisMsy7B3rtU7O/wvdcgpwsET/ZxNwEjVpH5k8pHXEZ/BdV3guYFVhEDvvVfn52rC5tYxhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S4nuTNKJ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7e195fd1d8eso57559039f.0
        for <stable@vger.kernel.org>; Wed, 15 May 2024 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715785615; x=1716390415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcYN10FfDn14US5p3x/TxdGIIki13NwqcWmNX431Yx8=;
        b=S4nuTNKJPVHEdwgJr6WwWEJ3KsTAnCEjAfbJB5fHQsEnwzvgUY++Nf943JGEXq8AdD
         H9pm/n1JpmNvM0WUBooUZ1jM2s1w6KGMwuxUvuo/gs4vq3HJKkpj4WKblDNm3G6EKVYz
         gyHOFzhPfYViv0+0KRKRJ2eRVUGOJbR3IVGJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785615; x=1716390415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcYN10FfDn14US5p3x/TxdGIIki13NwqcWmNX431Yx8=;
        b=DBP+B2anqZr3QhH40RuGdC/LWH5mvvgh5NJbmlW6S9LkVVrMGREyJ1KKmGQkVI/ysS
         M5nJtxExbBcOu9ttG5vyvvJ3IXy0uFxXvu5qp5Ww2AJ48kIx6Te3nlPSVHrDynz0ZQda
         NKlMdchI0AKC4PXdag8wFVD3ra2STCYDkWeEyAoqWAQC007Ir/HcBjYOkSsBVg5SaZ9d
         gofy1ut3iDxv2adzbL+9n/eQkkBTwuatouWnKXe5zudkD2Ocu8Ckye1lWsm5sHyh7+9+
         w9qluujTuqOsTwL045gH21abjzLVNRetWkLxm8OQC//k6QqOIvK0ktAjrvjxMWFzSKSB
         VuvA==
X-Forwarded-Encrypted: i=1; AJvYcCUMUpHhdt8zz/pLkE1f6AnYtNzHPuhSVJOy+XBuw8hjl6P/ZzHIxDIX9CBOjf5tZAJ5sUHVdJEJknvHgym5WQ6YYGAX6wJA
X-Gm-Message-State: AOJu0YwbBFZpUZt/O+3Y8afrBrfZ/iR14XlQOKAr6xLUoBcf45rii4Nb
	2WbwpAFRKAUUmtlscUGTbaQQqqcC+mkMk5T53IlUZ2oojEItYKCBYJUgVkLnCv8=
X-Google-Smtp-Source: AGHT+IHswPwsFnweSMcvLm+AWWS2t1fafeIrDiKAyKpwgDgiLQqvE94t9I8Os3WbhkkDOZrFGH3Ucw==
X-Received: by 2002:a92:cb0f:0:b0:36c:532c:d088 with SMTP id e9e14a558f8ab-36cc1391118mr158636705ab.0.1715785615724;
        Wed, 15 May 2024 08:06:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893700e469sm3634804173.30.2024.05.15.08.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 08:06:55 -0700 (PDT)
Message-ID: <97dec171-048e-44c2-bf19-7d1a1c8694d3@linuxfoundation.org>
Date: Wed, 15 May 2024 09:06:54 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/301] 6.6.31-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/24 04:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 301 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.31-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


