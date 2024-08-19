Return-Path: <stable+bounces-69617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629C0957210
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 19:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C79B2B0CD
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 17:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB618B46D;
	Mon, 19 Aug 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtUSTUeg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC023187FFE;
	Mon, 19 Aug 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087041; cv=none; b=Q1i16Uwjio8s85rv6SzJwV/8J3hjeF1VxJaMupo12LHAW0kQb+tIYerNiAiacQkhDKUf43X9AI+M0WeM5Z0/+XZcg9iuu9EtYDwxlRDCVc68fEQyoPkW34zFOb3g1T/8MbJwSPk/NSVXDDRjBGR6SLu/ySndu7vDYd0Lr+xfHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087041; c=relaxed/simple;
	bh=JgmieXg4Iblau/5Q/kxt2DnEgSgVYdSGYAbJ5VjaqKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjlqhnyeFPTYY5T+16Y1VMZdflu2EH+pRJZOjrORU3BOs6/B4/THIYgJ90zhFdSzcW2ynGlF4Aqj52duPFEIDx1cuyL2jtTx2U55YVbB/65oW+T5d3u6UVrdj7xZ23zwIWzv4GwLF/Nxnfqk4yPMKu21aUzDoh4OlyvcfL3JWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtUSTUeg; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1dcba8142so424116285a.0;
        Mon, 19 Aug 2024 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724087039; x=1724691839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a3BIaVWnwxuWR27UJ/fveub/Cw3H6dA+grq2xxd+b3c=;
        b=UtUSTUegylrYusi8Cu42qtjkDnrplW/ihsdKyTaqHXWSTMniXBlvoTaib/pHKQlBdr
         AGgwYvRSuzCundNNpFtxiQPp2heEcWRBtuEwlT/373De5101ri9s5FrSgjsEY8kwi79V
         yVyGvc8r/IBKP+EIHLIgQ05GyXop0gqCq9RNmvzJD+M1zufGVq9hEa0tmyhNOOBF+22c
         32+2PYGnMBqJyfxTlIOulIb6mxLwSsne9JwSzyMAHXvHX/LfzdPEbXsEFmyzcmdenDTa
         b/YZMfaJLs5xjNTZ+JgdSl59kTVOfxMUFoD7fQbzSdskBoSl1JZbVSSWC1AbVY/bBFXT
         9czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087039; x=1724691839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3BIaVWnwxuWR27UJ/fveub/Cw3H6dA+grq2xxd+b3c=;
        b=njuK3sRARmiJCO4H8fCPdtrtO1t6YHVsidXkJ+w3x6EVjXWw9wZtzTlS3EuaIg1Ten
         Gzfxk9hSCFE6zIMxeTe7llTAn6vhMUxnYKmS1guHr9U98/fzjvIdW+XXcZ94Q+NLbI3J
         aem7QljxDEi93lxR0Y/X0TZnJMTlxqU+J35KDL/Al4dUPH4pPvLB0JEafIl8GFm2YyW7
         r4u3u4xNtrb3mPyo8dKVWsliBK1L6XlcjNra7vaj5zmYHlsTe+qcueqzFsk8sD+ekcmi
         kCwYObvJvIQpFKxzGuetDiz+/i+dMbPVqq+OYMkWRpvbmQiPpqcHvbOZOOKyS9aEOlDM
         2YxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV49t7QtE+/dWghiM7txIqKj1kGVOC1FOa+90vV+Vxd1F6rGCXtKj1g5fd0/K2DRTxz62brqYLX9WpTmXlTN+uZuA9rs96E8WTVqszTppBlbWNEjQWHm5+rYMp0C/hm3gL4Yywm
X-Gm-Message-State: AOJu0Yxb9Z6hj5S+shjIntq8cIc9uKU7E4EZZpKssqi3Zic7/wsTkooR
	7blayJKbHq6POKiuAJ1cgTzG9vk5IdnFjj6nuVutulBxSd4Z0EwW
X-Google-Smtp-Source: AGHT+IFbUhEcPgxK/XfmNoG6Hn+cKrtm8a4uxXkzp4ZBuOe/ugGXCGOPKI+bgtCqYGHfkyGl+yVDfQ==
X-Received: by 2002:a05:620a:24cb:b0:7a2:1bc:be05 with SMTP id af79cd13be357-7a667c53723mr46511485a.31.1724087038449;
        Mon, 19 Aug 2024 10:03:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a4ff0faec2sm444637185a.105.2024.08.19.10.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:03:55 -0700 (PDT)
Message-ID: <96ad9bc6-1cac-4ebf-8385-661c0d4f1b99@gmail.com>
Date: Mon, 19 Aug 2024 10:03:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: 5.10.225-rc1 [Was: Re: [PATCH 5.10 000/345] 5.10.224-rc3 review]
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240817074737.217182940@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240817074737.217182940@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/24 00:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.224 release.
> There are 345 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 19 Aug 2024 07:46:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.224-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build on ARM/ARM64/MIPS with:

/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `bitmap_zero':
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:40: 
undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `bitmap_alloc':
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:126: 
undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:126: 
undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:126: 
undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:126: 
undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o:/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:40: 
more undefined references to `ALIGN' follow
collect2: error: ld returned 1 exit status

this is coming from "bitmap: introduce generic optimized bitmap_size()".
-- 
Florian


