Return-Path: <stable+bounces-109180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6651A12E88
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 23:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792593A4BDE
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FDF1DC9BA;
	Wed, 15 Jan 2025 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF+qHA5L"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243EC1DC9B3;
	Wed, 15 Jan 2025 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981339; cv=none; b=cZ+ARysowEW6diHtNVimIO9CeuGghgl/DPsH0eTdh9Q0fTPc8A5c4uLPXV0/W0rcPQXK8Wg4Si9Updu8s5/60lso7t1QCugO/cDHz1OJK9X7WV9vF6MzPil/UpprrPsrcO7G3jOKBJAGnbttGe2xJppYNqo8QvNeNLQfrCvfUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981339; c=relaxed/simple;
	bh=NdFF9kX1/Vnozkr4mCse44pEonummA6x4jJYIoQGiOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGhMdgObH15JKb8lh968zVbR14hwWilLA2RlCp9J2rlD/dmLSMa+e6c/vvcVec7AihK/39hkAzrBp3s+NTQ7GN+T22OTIuj1jxZ8hqchadGT5UWr2WuoMs7D65vyj1TPZbSthSf27ub2hvunOFfAL3GKZaPPGrKc8yboPzKWtq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF+qHA5L; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2a3c075ddb6so212451fac.2;
        Wed, 15 Jan 2025 14:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736981337; x=1737586137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IIZv+cKYKHCdFLLY6CZ4A4ADQJbuIZXylkRNjMRB0to=;
        b=kF+qHA5LxwimYGeNXmO+zqcLOIbyP4skaos2LljlqeW3hhkzVEarqHR/Uy1dm03UbW
         vHc3y5HBYQj7Xzhtzr6MRFUJtEsMuJrVgYbO7TCw7r0oHdxVi/+FSvGB2cOY3XIxz9TB
         eEjEVru3Jr+BqyfQnCun9oPnGiEoHKEk7zVc4ypLE8RtswDxVk8IL49GLsdtmbvXYZ3L
         0kns7JruMvcDGqfD9ogoRc3YSnkdOOhpjI1qbNugSHQzYHfqc0bd8waAFfpdZyIT65/S
         30vtWXpHUqXASc/3vUZvWtmZeGfo/7pB3wsANhLEmdSS5mrOzCjnesMbf/rSf08utkUb
         CK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736981337; x=1737586137;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIZv+cKYKHCdFLLY6CZ4A4ADQJbuIZXylkRNjMRB0to=;
        b=dG9hoQatcztUNLe6eKNXmbNSp8nDRGkUuPK1ZCIqhG5tqCrcjkKqYH6lKLVMLxJGEF
         +8LNpAvbzlFWIODdZTyiVIZPcrABCliYxxztWYAfDAmroHHhWcDyvCyIHmpn8p2gJdn/
         2D71INd1FBB0kj2ZXKKFdRz4Mo1MmovFDp902xyBB/DB0mMo+8tB/gPDVB60EAI35udo
         +bKLskTqkNBOYQZMf7am26E9G9YK0u60txjxGX/FYuQmpIG5H4OQ2Vp9K+bCf3cX0yUN
         LAJ/WGtamqt/MF0llgHbwRzlIinjuvQLhPnyuDDpMn8KiZZtzG95vDQSjj+IZWDwv64E
         XVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfJcFDrKWOdq75+gwqw+f1Cgo0Gau55i3AGlPtHZyx5dkXG1UZ5NZW1NG2dpHelasmIoCcFobH@vger.kernel.org, AJvYcCWntik37jBJzSTjqevXjSiF/zFxruTmGErWxQw7Oyz5HOsBqtsPQhP931onkPrMv494un4ubB5mFZl3zuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZ801YY01k5fdORl29q3RZUSyaGGSBRbqV/shLO4lYYbazd3+
	yj99vWVvrrbhFKVMqL28ERnpvtTe79YazOJxg4NnNVYJfNOOMYH/
X-Gm-Gg: ASbGncuOrX5jY0ExQSRVsgpuRGVL7h4Iu7Sq4z8EhyFPn61WsHyYzNwvMxwr0aOdMod
	nRcnyxXMM3ANGWPB85/NZ8KUqM4MwWvLvXEuNYoH26iTumZOs9mj9k3NwLrtGEhhMmT9qzt1Tml
	E23r/jLisF0AMvrEOtoSGL+G3bfh30ZAcnSMfvjyWddMl/JXetSOoD63HMA8/mPwxUp9zculm2A
	h0VjEVTZ8wvWrMqqAdB1tJr0uhCZPk/FnpOHwcp9ZzUcmkDWtZkHKq1px4mX6lo+37le9Zow6Cn
	BfpSoFxk
X-Google-Smtp-Source: AGHT+IGzubkSbjP36Rdu/ReqhlmhZkX2ApxvwtIQkzuE+0/4QKWU20ejTiAgbt2mK0jhNN6560dqOQ==
X-Received: by 2002:a05:6870:2a46:b0:29e:2da3:3f7b with SMTP id 586e51a60fabf-2aa065102fbmr17380989fac.7.1736981337209;
        Wed, 15 Jan 2025 14:48:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad80a5cb64sm6777406fac.47.2025.01.15.14.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 14:48:56 -0800 (PST)
Message-ID: <52233679-07ea-44ed-b3e6-cc356001d505@gmail.com>
Date: Wed, 15 Jan 2025 14:48:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/189] 6.12.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250115103606.357764746@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 02:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.10 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.10-rc1.gz
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

