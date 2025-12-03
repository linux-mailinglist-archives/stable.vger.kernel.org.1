Return-Path: <stable+bounces-199902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA5CA0DFE
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B92C3001DD3
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9C1EB5DB;
	Wed,  3 Dec 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZfiCWae"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52325EFBE
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785456; cv=none; b=hQYBWLSvYVC7t5uPtupdXGzGr6fzDkG1iBDudjzW6T8XhcSTqUEzquNMvYN7BsLwRsfPpVpl3IDq/52DT3Tq5XMbOGbi6CCCnxMZ/0nEenLHL+da2+BR9kZ8j3rLKmhfKs33MSz2WB0lDgErNUhQus1NbEnhGi/HtPWX+xs6Hjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785456; c=relaxed/simple;
	bh=13G27CGnHbrJI4bqNi9oU22KF+i1tcG3HTSAfhgnGM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3mEmimvnhBOhPjRpc44Ym2eQ7RXz3sBKLQKUqaDjXPChOl5Ktc8vfbz23+jSwCG2YKyLrdNOyoPnLv65JYC1Lntc5YYQU/D+wtwFSikbgqGBaD1BuUOk1qhFHnfWtZdaLoou/RZ3tOb10jIkmtovJLXjclrY5LxoojuD1z3M2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZfiCWae; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8824888ce97so97120006d6.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 10:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764785452; x=1765390252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dT5mKy0txTpJbp7ljcHsvhb/t9sv80MRauLsPTmmEW0=;
        b=FZfiCWae33qclvZZVNEcuKVWvVDaIYr1fPFjS0HCPQBcFV/vq6C+kkRueYIwSYFmod
         +NPC0wz1uqpi+qEr0t8Tiq1IMyvSRfuBrat4W/4axaPAFqzb48H0N51eP7XVyZwx7oJs
         qq2uz6HIgVp1GDUGVAakl9Yp/vqW5hrba8nOgtzjajAah1fWO3rhQyAF9HzlIsBocB1d
         okVx9HFoePefU4js/DQaUum/9EUu7oFERAb0FpsTQgQJK0bhuMh+e2W/ch6LDik0gXwA
         x3wNTAdpyZsPsraRJQUPOLU9N3gr+1latsw6oolUQfTqPtT9UIAB51RnDA541HjXVxk0
         kITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764785452; x=1765390252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT5mKy0txTpJbp7ljcHsvhb/t9sv80MRauLsPTmmEW0=;
        b=rE+V+4FUrAeMohyyY1loY5RucKB8a29QMLDayIza6Cvjv7YbTqBqPz54Tnr2mXhbI8
         XM25eQ07hUwxLBlL5/5co7N/R5S94zCvA6twl/WFTOyLfCXbWYdaDp9hg91PPnPtR/xF
         6TCFsOPDnxW6cYp9MG8QQ3P825NgaoS0UaL+DrrhPEvE1eSdL0LFEc6Zj2HFxP37nE7A
         4VmAUgYzw7RQOqA9fIhOpu2dzzbx2owwefdIj2ce4hY6IAmfYqTrwFbDU/UOTg4bcy98
         P9BlNzOl9IHyijPpETI1oO/NGQR03EuioDws6KL4aGiuXIazZ7ApS5kD0Niekfd9pxvb
         UCpg==
X-Forwarded-Encrypted: i=1; AJvYcCX8nKyKFb7xqlyLAQPjbC/5k+ZjRpuKeln8J90/+DKgnCS9dO6WqHTmFuDEcJxWNGn1DaJH4yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFU8NOWUlbPSIq8ykxaszeX6ypbmd+ETIuuSOxWJXl45LdLmXd
	XIUeQ/ojZWLkeY7w+CbJqHgZpCHUdlE34qHNsFgR4liJkyo8ivGSLYzx
X-Gm-Gg: ASbGncsvBFcZ//CDmbZHFNwHOAO+aaas3v01TfZ8uX6wyUzHwp6GyWapfCi5RQ8A8hH
	CfOOJjRaXMMiaQpwVLOLsutXfJf6Ql/9AiSgJip3Zd4HVfpzcyW79Ok35lfUpq1EGD9fhnAhLJX
	S0LuPZ5B6E0my98bdSWG7lOErE2F7q1/8xtZIV4PQA2M/WgyhfqrtJ+cLKfG0BRKUV7dNuQ2xSL
	3CUW/wG4Mo1ptMZEAG1uxw/TQn1BAiTvxmUmeOw8CvscZdqeIkT/CQupdhQGJxL3x+lxLU75Vey
	wLYCMiGhS/MRkjUveXnn02tjmplxbO/GFGFkCvwHbWiOzptojIf/eDcvi5qsT619UBbVoHRY8HN
	yqiFGTU2ECYr62CJsQ88r4DsAlavT5hdqFAVlES5v2Fa0fZoLbijmXZYMnZq37cNID+82DwOoZV
	hHaVzhO1evOnHSsJ3g6OaQxx8Qr6g55Ys7Ky5UZg==
X-Google-Smtp-Source: AGHT+IHJiMm96D9owfTt6fxCt383LMWsYv6CqWficwGSIv+STHNx/qvB90Ov/ekSwrHk0/51lKcDEw==
X-Received: by 2002:a05:6214:2469:b0:880:531a:e656 with SMTP id 6a1803df08f44-888195080bfmr52504656d6.29.1764785452287;
        Wed, 03 Dec 2025 10:10:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524aff3csm136195896d6.5.2025.12.03.10.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 10:10:51 -0800 (PST)
Message-ID: <4339d616-71fc-4aab-89ba-ce0b1b50e95c@gmail.com>
Date: Wed, 3 Dec 2025 10:10:48 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/132] 6.12.61-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251203152343.285859633@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251203152343.285859633@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.61 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.61-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

