Return-Path: <stable+bounces-161483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D9FAFF0C9
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 20:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3EF1C224D8
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD44239E89;
	Wed,  9 Jul 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LyK4lXZJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652323770D
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085319; cv=none; b=aYlwH5/j6sOKwLV5QQ62ihC0YPn49nMux0YnauDjHPw6Nlc8Yq87bzp+EFVfpMCljNpVcAUDgVbEcYIbrsmnNfzuqubT0DbnzwEKeq+nBTRxJ2bW8IpDgrbW804h4gDYurY+dy3df4oEPcF1YvEUJvkoduGggZAEbSo4jVEUikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085319; c=relaxed/simple;
	bh=8LvNsabc0my7V+hNxMMtYFnztRuOaqiig2opJPSQKqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0+/tH23KHwophGdjyFvEEXzp8GAhWdDA6v/4FMfx2cUjL8iCXkim7NupNmbYdM2YMsv+qrsxBjk4ARPaoFVpjTFVjCEhPeAoggpr3AQ3kCPvTspF5oA66288Bu41F0TYvhYmMDdf52hWW2wFgckM0fquayoJINz58JHyof1MGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LyK4lXZJ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df2e7cdc69so459885ab.2
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752085317; x=1752690117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBRfgTf7RIgKnJwuu7ZvDO6OZoixjZPMxFISgPsX2vc=;
        b=LyK4lXZJOyLF8sUbdoTwK7ROhfvMOnxHvlwAxJFV0jdLMgsJce2k7Woo5w4XPzdVbZ
         lg8eJz51kTL18OKNxDEWxCUH9BdZFtIVCJ2ISfVqubk9mJ3RKEZ6S6XYSPuT4FhOVisA
         9zT2t/zK2THWQCQWc7sZyu/oR+sQARBiuW6Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085317; x=1752690117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBRfgTf7RIgKnJwuu7ZvDO6OZoixjZPMxFISgPsX2vc=;
        b=ZvtJT7jts9Ef9XN6WzEb5Ljrr/cCwDwRU9wXL2cKasj1BWE6juAtLAd/9ZLxsK2q1j
         IcjH7Bz15+pDmv8A2UsrU1RUD46f8ZdcVGDQPDffeQRdlwQMWj223irQJFjgYFeqGe/t
         SdGSuOIM4OKX9+B3Dj996oXPshaCCydgVHolXS2rkifLb+SwLo817hRpLyx+iiCXwEUV
         0BQWqNNHmrjldXjmV+tG5pI6EDlorKSi0oCANj3vfu/Io5Qw6JEvFBwT7Veu5pqJ8TOO
         klkzOw+Mr5Pum1uy4C85Fz+rACbccghYKhthBb8YztRfKiPLM9BclDGuUhHfboXSyS56
         I7zg==
X-Forwarded-Encrypted: i=1; AJvYcCV8NsvJYaYt7SEHrejI/kKVXktpTsCo7BFGCK8jUna08mqL9ngFfb5goNdt33uUbucG0RTko6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIIBDzF62HBBGC6v0ATNVP+hxPL5gNEZItUl6SXa7QPZDFTi6
	9dKmtDxqdxgluBQ+1IesSAfZ3sa8uYTULQmkWXVIankrZ8eI86+/LeYwGu3O8I7+Td0=
X-Gm-Gg: ASbGncthVXbaw2tmysZClyYC0LvhyXibe4H3cFoVYhy/azFNeRdfSjYLqJ9etrNoLYu
	3X+2pmp26xVrHvl8fLl9GR1vZSSI1u5/p0HeU8AFCLiSaDazx4N3MGm1BQ/wp1xFQz01xutoIbs
	rqIZ30c5vK98Ef2qnbDTMpfzn4R1OsCgDGd78wzATu2zrka+5JARI35NsZkEYuF5hXwuSSjo3N1
	/zXiUhRHTFsIuRAdiDkHDESpWK3lEJmBkATPKgo4ldb9qZ8afDnaL662gzIIuqebosxhyzu7HYS
	hImTfH4dgOKelP9fHcQCRqm98ogne7ijHGJHiMZbs9CCpors4S/671mYpfOc8qu5sIF0mPALlxe
	p/rbQJao9
X-Google-Smtp-Source: AGHT+IHiWna6bSyXG2HZPU9BES5Uu3BzehbrD/ysyplTdibJ/xd0zNUZnSNOWYpFqmRipgJGKDYT9A==
X-Received: by 2002:a05:6e02:3487:b0:3e1:5f8c:10e6 with SMTP id e9e14a558f8ab-3e243ff1490mr8804495ab.13.1752085317104;
        Wed, 09 Jul 2025 11:21:57 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b573ab0fsm2823317173.0.2025.07.09.11.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 11:21:56 -0700 (PDT)
Message-ID: <a7227104-f537-4e76-b567-4b3e3d3306aa@linuxfoundation.org>
Date: Wed, 9 Jul 2025 12:21:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.6 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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


