Return-Path: <stable+bounces-119424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F75A430E8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 00:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6383E3A560F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 23:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B607720B213;
	Mon, 24 Feb 2025 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OqFrgjlw"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61B2AF11
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439893; cv=none; b=N+RUXd7rcnzFwIfHjdTYtMo772z4nAcS7lHhBYbuO+tcK7clhDLQPkB3JKYX0qRIA6Dbz+z54ZnV3eYxl9oCnDvtLtBf+yJz2WgBth+GoCGdAhaEl3nHa/Fj8Mvcvs6qJI8NLlTik+kjZMg9i4teGFheVGQUAF+8agUetp3syt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439893; c=relaxed/simple;
	bh=F8UT4UMK4QmeAK+GaOuaql6of5z9HYtWyR13pd9pBfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R92NIxFUGbskAmcQaM6dhyDJ17ybcO1U3Gp+74nlBfrVu1bw6ccIUa//T/8uW8TP0KVMT3WTUX2AMRBtRV9memI+M+siNNbv+AZDgj0onNJJOoeAsIbMCNkukFNegoOmRdCSrEuHnYfhgoGKwQfjFzHqrXeqQeOgb33wfIT75Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OqFrgjlw; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8559461c2c2so132206039f.0
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740439890; x=1741044690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuRSt/BHONOE6HTRUiUSM7fHedYhfmWMvn29Sp24F9M=;
        b=OqFrgjlw9Xb4nZaYtbvSN9xtpW6olF7J1pS9YKKO6sNDpfGAyhr/+Q8NNPxLfUgflk
         cD3RzBaLYszhrCstFEHxmWW8QhjQYuYpzsdeu+IYDBsKp91j3S+D5L9aLvfA4F99oL0u
         0dvJ9X5beVdVaMTXUjgvnpZ6bN/4lZRv9g1eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439890; x=1741044690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuRSt/BHONOE6HTRUiUSM7fHedYhfmWMvn29Sp24F9M=;
        b=CK3TFnljsEI4Gae0PgGyE4mB4ztmc+I06KGy5ydUFqjLZweQ1qiSjoqzGhdvHeigwb
         Vck0IxFyJT7YSFex7Gk9/2LES5/kSY5PZqIU2mgmrKp0Lrqq0Ti1nA5hpkZkw4ECwUhN
         mk14Z1ky9FL1Q22v7bAjRh2sfdMVAfgyySkxQIGCGtSE5zHOj5FV6SY8m1I5rgHzWUUI
         pIh5KP5XiucyjYnhJFOYPehBeMNvBg1ViVT+ajnMEHkrsaRu18CaHhNV0d+piYz6yTs0
         0R/m9ZZST0YXXF5Nb82F43uvsuvtgLLnhazWTnsaRR/Zep608N0WOhFphR9y4dTgIN3t
         nCfg==
X-Forwarded-Encrypted: i=1; AJvYcCVgoRSKdjqM36AvMFEbUCSPa6g+6u5x9BKLQ13U2mdAZSNmYnXLSPE5A1CvaEqlFZwTlr8G3Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/uVyRIYfJp1U8HGCU/sAZY20jO/ccW0ly4rVJDrFeqY2obTD
	Onqt2pOXc9/V2sQDK3b9BWbY8BbFshvp3hTRD1y0YVHcO8L1o5aVyV5/cCredBw=
X-Gm-Gg: ASbGncv29BWsLnSg2q/DoR5VKOMmCDcM9G6TQuLKp6vCTqcllI/XByVSQkrDdq1/TQZ
	J4TbyhsU9QtzPMsEf3Rq6ABs1agkKF8uCo0Am+Mg4BUc/KK+8bae1JRT5QHBpfVDNmy/W+nnD35
	Sjv3g4GtV+hah31A8nUJ2owhQow31lELgQlKruAieOCOrIXmHEf66RiaFQFkQTEqSIgQGJGpYBA
	6yAtUaWjTLV7iEF4j+RGwPtlH6pzMSgSBnL6wsjEUzlNE45lXLl52ciZcTcu0bo49XJCAJNgh61
	jL2ELNqBzRnteux/YJ8Cdn7YMEGRxYf4UrmW
X-Google-Smtp-Source: AGHT+IG9gf7nMvoYHQuZUgZkRuJLv+urEXbaqRvetCRicjL4lLP+FRGp47rpDpRCVcbY4jajLs3q2g==
X-Received: by 2002:a05:6602:3411:b0:84f:2929:5ec0 with SMTP id ca18e2360f4ac-855da9be5d5mr1898313439f.4.1740439890143;
        Mon, 24 Feb 2025 15:31:30 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f047530437sm126053173.116.2025.02.24.15.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 15:31:29 -0800 (PST)
Message-ID: <a3c8ff01-c9a2-4d1a-b479-a18cbc510023@linuxfoundation.org>
Date: Mon, 24 Feb 2025 16:31:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/154] 6.12.17-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.17-rc1.gz
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

