Return-Path: <stable+bounces-92875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FA49C66B1
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 02:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F440B2AEBF
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 01:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707E12744D;
	Wed, 13 Nov 2024 01:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NThcMks6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DA4204D;
	Wed, 13 Nov 2024 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461158; cv=none; b=KxlkRFYQpsKc9GVTP10NNnKmB/eQXp0P+UugFAJkv+N/L0DBj6THy37AOgccP0VMfYrHsqr2dgtEzDVHXhhPQ2oK2NF/Kkz+YvMphK2rTZGVprfjGwqu05HvjbO1B5blWqnSwoGHccqptSekRQ5LEC5TiVAJbjWSE+FAz4NXIyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461158; c=relaxed/simple;
	bh=zvPk0z1WtaD2LEmmW1+NrujXJicKuDtlrxUtADgF2hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iG+az718rpdAxt6lqTwOpJaCKGm5qxegYZlwf+S9ZXcY26EDFXwYiUEIv37UH1LLH2eXGjR0OBVPYumbWEZfHobzl6S43eGWbiy9uH4hSbviQ/wbHDkzIDG29BOCYT2NikHv66JKOpA8Bnp3csQNaInKx0n/zk7txEhAZJCcNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NThcMks6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso5285253b3a.3;
        Tue, 12 Nov 2024 17:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731461156; x=1732065956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCibdKuuOg5wGr9GDYj3LPP+K4ghk/C450E9uKvDUWU=;
        b=NThcMks6rcj7RQVH6ROSWK5F7L5rF5JYl8KrEeZjzwroqrCI3POZqe2b7ln8Rhpknb
         IgMW9+y2afvpk3bT7M/mCM3skptsz3rb5sTX9IWPsMRJqm1WYVzmIfvLpcl7IxSFy654
         zuxErfTD5T40wdJ+PYediyGVoNpFglu4rNoFHPBJMuK0wWdDPpPXR94xSh/1o28/wGRA
         hLrPfvfgYpKg80SYIfMgJyDePkjYBofvKoCOQ9EkhTQHq1qNSGDpYbc/xcFZhqF1QHAA
         g2CSG/9fkNk/5d/OK9tPlstq9Q+v+0LHR2SBKTLfngC+Ug1AVQR1cCQ9Mul/JHKkUgzs
         M5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731461156; x=1732065956;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCibdKuuOg5wGr9GDYj3LPP+K4ghk/C450E9uKvDUWU=;
        b=ZqcZ3ZZ985DxlekAL63pd15iH4oygAPnPPaOfbDcb2A0qyoEAoYzC8R5AuXn+FsYZH
         1etthZScs0yqu2mWXAQ++ZHELsJOA6V+7mLHZPmsWw5zHE5JXBKy4dozbC+4mWRNgeV+
         03W+yq0R0iNU0jVx4b8YHSFex5xMzUGWqjdLCO7QCUzTd9qyl8ptyrfTZ9yrP7A9m/dZ
         QBts8zTZdP5PdKF/X9YGf9SicOsPHsQUPNvQftrqRoEOeqtC3nE814vXucRMyZtE4+XM
         P1KyusNX7uZzv5Xkm27LmGoJBYIAKPw6d+pPiY4wxNIrbID+up5ClH8zVToaeimSV/mm
         G6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVYfwoaqSNXwx4jjYGSHpliPbGQyNtt6p/9lhh3pKZZC+Isr+e5Cb4k4Ul01/dRxERv7NyOjgwLaws4/FM=@vger.kernel.org, AJvYcCX6aVo0NXW31QfgLN7G6zvc54SKSVdHjHQnJIHLXrUKpeAPVQyPbr3Ix70zBZJ+VoI5JFPmc/Pi@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAsd6+RPlxV3iwpLNG0f9+qyKKk7cTMcGbUzpYtyUsDQMmCBE
	wbVT+OosVYocpuWbaE6QqdAKtd2drz195g8AE6tpiYZZRFgFPX6k
X-Google-Smtp-Source: AGHT+IHBljO9osWnNNq4Fay80sVJULagfFxSj9dYa2I6DHgxjBtSqmXUkWbhB9Ua8fAqLX/9UJn1CQ==
X-Received: by 2002:a05:6a00:a09:b0:71e:7cb2:57e7 with SMTP id d2e1a72fcca58-7241328bcdcmr26588441b3a.10.1731461155506;
        Tue, 12 Nov 2024 17:25:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a57113sm12317581b3a.180.2024.11.12.17.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 17:25:54 -0800 (PST)
Message-ID: <fb078045-dc05-426e-b21e-72ffae3e8e1b@gmail.com>
Date: Tue, 12 Nov 2024 17:25:52 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/184] 6.11.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241112101900.865487674@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 02:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.8 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

No problems on 32-bit ARM kernels, including building perf, however on 
ARM64 and MIPS, I got the following:

/local/users/fainelli/buildroot/output/arm64/host/bin/aarch64-linux-ld: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/tests/shell/lock_contention.sh.shellcheck_log: 
file not recognized: file truncated
make[6]: *** 
[/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/build/Makefile.build:164: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/tests/perf-test-in.o] 
Error 1
make[5]: *** 
[/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/build/Makefile.build:158: 
tests] Error 2
make[4]: *** [Makefile.perf:775: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/perf-test-in.o] 
Error 2
make[3]: *** [Makefile.perf:290: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [package/pkg-generic.mk:300: 
/local/users/fainelli/buildroot/output/arm64/build/linux-tools/.stamp_built] 
Error 2
make: *** [Makefile:29: _all] Error 2

Will run a bisection to figure out where it is coming from.
-- 
Florian

