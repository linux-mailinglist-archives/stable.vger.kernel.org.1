Return-Path: <stable+bounces-59204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A7892FF1D
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10981C20751
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E7176FD6;
	Fri, 12 Jul 2024 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvzJ6CN7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A817623E;
	Fri, 12 Jul 2024 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803979; cv=none; b=AUcS4eMwRLvIirNvgY9zwu3kCH9zQWKcS0QeqifmD54njmAjaCtYqa4gvWgswPhgv2qB0QZbZoJWjuElsQoiTpKDJCulDCJl0nbOEz9o1nCcjlpczQ2xxQuL2o/GAleGRaP7noom8WVJkJM+mCRHMBvfIWaoiwJLQ+GhWKY9p+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803979; c=relaxed/simple;
	bh=g4HosscmGTGzLql1pINXl2ryFOeiOcS0JD/J8utFiG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQov+AXEjHRhhRBVwcOfAMqvBEo+g3dJ9NLMCezjeE65bjeH27WsOaeRqzv/wQYRz6j11s6Yx0MqtADfwkI1uUb7hWMOqcFc7mVCFGOGQifwJiz54ztCRC6sQ4ci3dfq6owDj28EZDeNA37p0IvsQTtDL0/g4Q4jmA9f8xwO62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvzJ6CN7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b03ffbb3aso1875253b3a.0;
        Fri, 12 Jul 2024 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720803978; x=1721408778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXBbNRNVh7Jf3s8Zs2bOIxvS1kfw/H6qMUrvf21hgkM=;
        b=TvzJ6CN7vu+enYqwSHZDFwoB7G6vT9zmasezQvUZSzL+2tANmkPZWux3Xo6yV5O1DC
         JpOnjolW5OO4oGJLNwT5TpeI462vF6Posj1EhdzKjAeeFqvTVflZMHpFJaJIRqPu4n2P
         2tN3f7pUtROm9CjODvkkb2RGJKBytOchd5Wmjqmfq240cLEwwx2S0T9S2VkL1tCSM8xm
         4Fo3xHTsm86QMLkc3Wxdnnw3DWi+RE+/Gqq0aQnLnzrUCdQPh+2cobaCOcB0yITeC7n/
         yG3B4jSVhP30k8kj0PUOKnSpOGcK0tcYDi7V+uwE1DRr9eIqp6gwhgA6kfpGUoPiH6YV
         yJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720803978; x=1721408778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXBbNRNVh7Jf3s8Zs2bOIxvS1kfw/H6qMUrvf21hgkM=;
        b=FAay3bVmPrXY+5S7dRAx8MKr80uZCiyoh3lGvCUaWtATRs7NAFIShTHoF8F4k88KQd
         FpRozwpuhYxm6QO0olOBslH36IIVdfh9+3GVDOWTno/H0NuIvyGv7Et2QVaSah8YKA6i
         1NplVjQLrK+j6poG7JamcusWTOYOJoAj8rAd6e4RIdBXmA5vArZYy+R7RC8mL1L1LU5U
         a9NbbTfTUKszWje5GenHeHMLO8JXHSN1wDlRhCOUrJfc0ooYsDbxqul6Wx5UPcJTxFGt
         O88j1sWELMM0Rfa18+5g5G+QeE0AoDADWWlrK1p6LVsyg9W8uNEKBseEWUDNkrITKYA9
         ryEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNQZ116Gugz7p0U2ywtO6IDyRIQcYgzyVaNtn1rnEnvWM0yHDf5AHAiFw5l1EpFw+lmz/+D9EtmX8I6snwxEulcNXRUstjCE6dh6M1lgXsb+xXTrTRyY4r0r1Cycrgd4w1Ncy7
X-Gm-Message-State: AOJu0Yzg+MhBe5hP/JRFR1/TasDBiN2U1j8lWKoVeDrqTG4qUBYbqCMr
	hy2ukqEzQQXtS3btiPQpWRRJsc7TqNnHm+4DF1h3DhmEWnSxa9UI
X-Google-Smtp-Source: AGHT+IHnbDShKr97eQTu93Ri/R0ihvF9+DxpM+vu/Mjzng4jauBBUJJj1nBUn1qCkVTWy4PIz+SS9A==
X-Received: by 2002:a05:6a00:3e21:b0:70a:f40e:f2c7 with SMTP id d2e1a72fcca58-70b435e7aa4mr14970162b3a.24.1720803977591;
        Fri, 12 Jul 2024 10:06:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b4398039csm7720181b3a.154.2024.07.12.10.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 10:06:16 -0700 (PDT)
Message-ID: <6f42557f-9c13-4c31-978d-3a7385456e02@gmail.com>
Date: Fri, 12 Jul 2024 10:05:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240709110651.353707001@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 04:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.98 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.98-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


