Return-Path: <stable+bounces-184038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDACBCEB05
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 00:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9871A66B31
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 22:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E28275870;
	Fri, 10 Oct 2025 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XZSWzrsv"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FDD254AE1
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134874; cv=none; b=aloF4I1dUHVcWTwk+YmF/XlZNfgOQtLATl4nA6VkQsVJ6jIy51GTe2DONsyDSL9hBDl3H2je7wGDJkPRJfmTKboEopnW7SsNO7NdMXD0Ut+XdjRxrFUJFH/Px4hGZGF2LUmkDpMbG+ODnPWXtYLSc+Jn2IatOda2ZBln7kCUJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134874; c=relaxed/simple;
	bh=ArQy/aBxepqtqZjpmtkPhu0y/QoRlipcXP0SdEbn4mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kL4Y9sYFujIwncjfrGAM7Nh8ChR1bmQyZVf+H3mWoEGR0gMyIiYZdqqHyFG/6gIEdSiLcbTS84rtaDqZExvIwg3WcyGXJI/Lp79IOid4pRKAZQ5QgceaQ71RjZN9veop3CAcjAOX09lYMEYkMMZB9BmRUmWM/UefXl5sFvED67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XZSWzrsv; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-92aee734485so102884939f.1
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760134871; x=1760739671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx5r5CLrhF3bcMJ0X7SPGFexB90B8MChAA3VoqSyKsE=;
        b=XZSWzrsv0Gff3MHM9iLJdOyG2WIcR1Ykh8ph60heEVADzB6nB3XxzOpD8Su5QWE7Qm
         JPWdXoLPduxj4dabnGXPPQufFlparqmdIPVRVQrfnRBPBQEiZIeDFQ72Mo6SsftD0bb/
         YVXWz6BAVoTNBk2t6ZYPvb/h/x8GQTkexnHbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134871; x=1760739671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lx5r5CLrhF3bcMJ0X7SPGFexB90B8MChAA3VoqSyKsE=;
        b=fFqQ+H7zXPgLs5Yt5+EF2svUggiqYXd0o9aB7OlvIvrmkNfbXmlT+gEKlSEkcVxWuh
         CGU9fiGcGgVioN+zqey1IWCQjjyc8SF/ct9hwcHEYHK43LYxoxuImEcVhr4/RlBp+s7K
         8sTWF96YkC6GyiLNLcc3axC0nrQFGclKDSAr7o39Ksp6Je6y8dJaNPRsghNrad5/OwKa
         TqLIdAryWjl2C7FqMuRkVEn44yeasI3hxTaY9w28ex4/JJkrHWpp3tlvoaavqCQfyFOB
         yIBK4py4GbZ9ssMf50tpIuQb8/etX6QB5sAaeNUvZHGy5Zp1uLjJ27DDZee3OV2qTIyS
         Nw2w==
X-Forwarded-Encrypted: i=1; AJvYcCXw0KlAClmOn68QrplDLB8swco916OR3l693plyKb6MY+X8tC3ldqrns+leJSAu7lubum7xRD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFMRcHWg7OSyUBHRXybtSzNhayEwdYA6i43d0fHK3H4Yg14sBD
	Dcl4M9YSxyLTum5YmANtSCLIQeqjiVHbPoNtK3fahnFN2T2h2OxnQA4iZ1PGajUPPE3brzf8IQN
	dZtDS
X-Gm-Gg: ASbGnctlwkuXSE/jaBaVnEBh85LRuuU3tWmTYy8f+XBZb/HQulOmxmxuKA2MKPtkGgz
	q1O9jwRpUPi7BiyXuJSV1B1eWklYrSZ6QdG+yysj6sK48v2yCx1hT0yp6aB/0O6aD7A6kSBv2Su
	fgdVxEebxsarzSOzzAuY5FbACsaCdoi3g3uzu2R77f1KkKgRSQMuuqkPIHdSr/D23GcoIglY8Xo
	dhgz+v+c+NfS3oluPGMb0utwGmmLit+XxO1RCtn5CKg/yfb/NYjb+DB+2z92OUWh70Q7MiYWrxE
	N+ACVz88kvRreLoDyavC0v+QJS2ldRLd3eugWqVzT2et6orPldS9jXGeUrPuxESXyRbiM3euuE2
	yl02Y+QxDuD++OMgdtzPKPLYO4m4EtNT5MJ5oUTZYSXbCo5JqonD/3+YE8kz9RaHP
X-Google-Smtp-Source: AGHT+IFxBtMZTPCXc1lKr5S6PbgrQdr+9ayyIqV8P0135BbdiNaXWyMPA4gEYyZCfPG7eNjUg7lCqA==
X-Received: by 2002:a05:6e02:2164:b0:42b:2f98:3fc2 with SMTP id e9e14a558f8ab-42f873ec98bmr149773715ab.17.1760134871512;
        Fri, 10 Oct 2025 15:21:11 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6cd59fe3sm1310332173.20.2025.10.10.15.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 15:21:11 -0700 (PDT)
Message-ID: <f5fdae10-56a3-4933-833e-fc69a7cf914d@linuxfoundation.org>
Date: Fri, 10 Oct 2025 16:21:10 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/35] 6.12.52-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251010131331.785281312@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251010131331.785281312@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 07:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.52 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.52-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

