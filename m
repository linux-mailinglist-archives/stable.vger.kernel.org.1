Return-Path: <stable+bounces-65969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ABE94B255
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 23:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169561C21086
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 21:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46197149DE4;
	Wed,  7 Aug 2024 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzhcIcXA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C1212C460;
	Wed,  7 Aug 2024 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067294; cv=none; b=qRlRedQJq782d9Jjdv+bEDdMrVATtSZV0jLmVTKdTbyLZA/+MXnVsh2hx5a5tQoiGjGPPRPsGQK4ANxkh7n6JITBzAJ0SKKpB8mFNWZ9Ov6cWwmT/0Kq1sCfp3YCsPsMw1FtdgrSZ5AwhxeUYWjqgwNi77WQTMsLY+f+oet59GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067294; c=relaxed/simple;
	bh=ikHrDHxrIlxO7Av4gQzjNSiQgY/ZMnBK+K+bWKNpGEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCcXamgkRWiygEnmgs2k4nrFn8tD5cy6+e5xDfUHOP2jD/1j2CZo6Epk6wasaaGsq8IWuRZ1LsehoR0wMK6dlQMHfTvcwILBMZPPw/BMU/AQcGDh3q8rmeIGYPJwN0SakPYvzFfky7aNRMMwkxCz0W7eeZk3Rzywj2ZWkLob0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzhcIcXA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so271866a12.1;
        Wed, 07 Aug 2024 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723067292; x=1723672092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwnAvupY4s0tGUxoV29OC1pw14aRUUNlkJE3yq1W4l4=;
        b=bzhcIcXAn8Fb0YfNz3rYrPolG1j9L0muAOINtTUXN9EnrjFS7+oxpjuAsVnXTH96Kr
         BEFp4EeQrY3vLK7+aT5v59zZTYsANBpoSLizTXTy5H5FcrUNRhWCugWcZsl5bnvWSMvG
         ix6vSceGGATAU0DIqKe6GcE1vNUgjFcyf98AEY84FNwACdYnFxx3DOYCp+Uhigrjjk9o
         rbrcYdi9Nfv6E48QkbF+fEZhP1ycbcrkEkGUk4TemuysiSKs21y81jk+5nN0H5M6Twqy
         Ra5TwfCv9Sld6X0ZnnluAh6sNY74rn6gmYzNQxW/ABM1WG2tCkw6IKhMUoR0o86/o8FW
         JGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723067292; x=1723672092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwnAvupY4s0tGUxoV29OC1pw14aRUUNlkJE3yq1W4l4=;
        b=UVNkPMgBjF6P0gVkxj9fbvRErRhNthS3Q1Ej6g3FTBzKhEIRCvFgVSqSGJNwf+uMUC
         Z3BvXcXwtsWd2T9vEXUyJNh1UlLbSQ5KmGO/3MCKDY3fSAl3VcEj/9317bH+k7y34MFJ
         h6H6zE4y12mGozjdkPbxa5fzVmd5ITpwbszr+PCXYVgflDzA55413zExQVVx/ACJY7IC
         j+riAiZ99+FapgyXrOtQ47HcHpicD0yZDg6Yk07WkyOTU+coSueXpRGUPViQ5KSofhXA
         9a5W37yOir63TVQ/gW5LvGGpZ1jRGJgqa09vSD5LMMGCATs1okKPqhnpQnyKyv9tF+D9
         HLYw==
X-Forwarded-Encrypted: i=1; AJvYcCUEMbu7V3xEPSojqoFsBHYFoOWE92do3Gkid0iAgrZEwZHchX4+cEI4gP04hCo/BzO8xcg/5gdSXVK5lZEuEOFWQHScqwXmVsHHoWMPeQsN7CGVltHpQ+wnOw+PhOF4c3EzabP4
X-Gm-Message-State: AOJu0Yz5mTZWzxdHWpMA00WViX0xT7mgVF4EWh0dxjPNyiN3R8y+NB/K
	jm1SJQvUQs60F05xQukOlVzJ6V02gJZ0HlkhiLwOK/OVd6KB0Fq1
X-Google-Smtp-Source: AGHT+IGw6duZP0Dlz2YBvISY62DQJZX6EzKf/9DR6v+6hasCmSzLdLX1MaagaF6MVIhiK1G/LlhQYQ==
X-Received: by 2002:a17:90a:16c2:b0:2c9:67f5:3fae with SMTP id 98e67ed59e1d1-2cff952cffemr18586049a91.28.1723067291659;
        Wed, 07 Aug 2024 14:48:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d1b3ab3baesm2096565a91.15.2024.08.07.14.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:48:11 -0700 (PDT)
Message-ID: <fd6a7f02-7ef7-4b91-bacb-1129049b0343@gmail.com>
Date: Wed, 7 Aug 2024 14:48:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240807150020.790615758@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 07:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.4 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 14:59:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENEIRC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


