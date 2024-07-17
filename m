Return-Path: <stable+bounces-60485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A5E934340
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 22:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CB21C213AF
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622C818308B;
	Wed, 17 Jul 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm84l8Os"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02122611;
	Wed, 17 Jul 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248639; cv=none; b=aI06kT8ctO4QNcAugEnWuI/lU7PQSfivNIorEmZfkKHE8Hc/O32xVAbjlIYEnz2ddtWpoRX3Il9Cvgc5PGyy5zf1mms1tz/0h6uS7aTuETZoul0Z870Rc0/wAec+2WIXzaxr89UbYnvW1jYoO1vmnmkww3e7Bt0VbypC5aDPZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248639; c=relaxed/simple;
	bh=c/Rf3VkOzW10Ej6A7brjLwqRd4iYmvCUnxVt6/CofQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uH0FT0h/gxIJj5EGlaezH/xE621ZTCL89TQFGXHttGO1bmZgDWRkTdnDr7teRdj/YWQVlszkRc1K2RKxLf2r5CqPJ6tMv6ZDAz54ROuWbz7wQh7rS2fPwN3lwIpVBzBWfUoz9iFpwLVQzE8h9YjzabcA6YfZXNjL4YPJgB9e31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm84l8Os; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79f15e7c879so2741385a.1;
        Wed, 17 Jul 2024 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721248637; x=1721853437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eHeadkJ/ycm/EEj2Bw8QXUOmorlJ8hGNchwcd5kwgo=;
        b=Jm84l8OsVNi8V0oL8Pq5I/J5Ya75QUSCCVm0M19BXnBMjFesxA2i8MqG3N80wBtaW7
         pqVvKVNJpvHEAG4+Z5OHndDaoEhapBCFesdqwMbMjcuIfpktzJLcu68nbeFyNgfYWeRE
         B/6AhEPNEnJhP8AZjiZDR6TopOhuSX7KJzm8ZR0PytzcIIqb78zTR3LoHJeisijIfpBa
         SRCMnG+rWlo/uknK/8wYoJxtN15O0RcyTauyrXbzN2BK8DbQjcOKNlZXm4iLg8sBbd1N
         UBNk00S2CwLm9QRq9xNKgfdkn00xbp67V5emZwQAGdh1YxJFZ8v3uwUzGi1ItC2Cneq0
         Sh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721248637; x=1721853437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eHeadkJ/ycm/EEj2Bw8QXUOmorlJ8hGNchwcd5kwgo=;
        b=erh76IX2ofH3p/MmRdhyuEOsYqOQYpM7Y+qPdywzQMsswbmj3EoiJKx6pjdKeWBPpX
         19TDDHsYcMflsPermS5vDaM3sqbd32STnTSezCeN0SDRNVjQYI7KK91JsK8MPpb9vXRt
         tUGsl86XE0odZ7HiSxUiEOTivplIjHKxIBGFIoP3qJxWi9ZX6hIiKZQg+TtbdvAuaCTP
         4yhiRW2ah9SVbZzlHAh6NSsenBEMUaFvpzr6zc4xt0hCVkShBb6Uu7OHzjDMRa6DmYgb
         acStfbamzuugfjDtV3Vi73biY/CeCNyjk2wWt8aSp6xfxDctFNZ9icOXjhaN616aOFbG
         W6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAwp2lqWO6rK4qxFzN/Jj18wwFCXPVb9YaRWyhGAe9R81H0uEfx2VkxZ9rG/Kq2hhX6x+c2FsI3VcVpDDPByNd3FoGReuVJFPJW9mFCWHRrmE/KBdLTmgsoMiUFsB5K46Yg1nv
X-Gm-Message-State: AOJu0YzGQdk/CRjq87+0r99jdepsW19K4i3q7EZrhUUtZaxbYf0Jf6uX
	3LXr0CKrlAghRQEwo0cHAUQ1J69O4Hy3FW8wOpPC/3zoEuD55OZb
X-Google-Smtp-Source: AGHT+IH5p+ouQnr78z7HNB+2NOypqK4DdN4PPgyTFTXGMDArLdN1QusI9EcM7BN4jDrHnWeP7RfJxA==
X-Received: by 2002:a05:620a:244b:b0:79f:58e:1198 with SMTP id af79cd13be357-7a18749d57dmr290721185a.43.1721248636664;
        Wed, 17 Jul 2024 13:37:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a160bdee37sm446119885a.69.2024.07.17.13.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 13:37:16 -0700 (PDT)
Message-ID: <4af8a6b1-695a-4feb-bedd-6d8aa11bd40e@gmail.com>
Date: Wed, 17 Jul 2024 13:37:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/109] 5.10.222-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063758.061781150@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240717063758.061781150@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 23:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.222 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.222-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


