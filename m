Return-Path: <stable+bounces-196553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FC0C7B3D6
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903EE3A257F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C061FF61E;
	Fri, 21 Nov 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll8mPv1F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56FB2E6CD2
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748759; cv=none; b=e+6AkNHlGTvQeknL+Kvpzl7mkwGhN6dt9B8q96ZoMcNlXkKFipTUlQ/XSzYvztUtErxEx7jtMVP+5w+KJ1kKAjFqA+aVNYtQpavCt3hxdJuNyM07icgG2SRYfyCdvhq0f5iKlyBz3QNNfX5YZK7IL7d1lebmwWe0cGlFQ7Ny/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748759; c=relaxed/simple;
	bh=LPrDGpbQnKvwM7kMqfxF5Ldd1SuXNo98KEBkPC8gibg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjDek93dAMO2LkcHYRKqUFd3I6+plVvLA4+U8W+WpYmP0Cfu7uSPKTA22aeAWc6x4FbRO7X2nh7vStJXrXqTRkrNCNoXjE486WzqiHiGd9bmUZ1CV4HFnS8U1oU3NvH4PhFjFWO3Ec1xktZuun+ECWwKvWuqLvKJX4kyFQhNiJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll8mPv1F; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7c66822dd6dso95972b3a.0
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 10:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763748757; x=1764353557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RR/i1yaFaavbNdSsVmJ9IzHV+HQy5kzJWXUbmdZhUUo=;
        b=ll8mPv1FNO7LA7HYf3NxLhyV0C7Z0MLjgmnEeXqSGjTDeN5b0VfCi1uLpdCobMYAYr
         dy8aqMlwnrjCIpxPcLj0Z8PZ1ix9VYXlWs/oUlm4btbueoXnIQKwmCDFYjmoHpQc/NnF
         5/WyOggXDxE/3TLTGt5g5ySYLEw92v7tMC9fKYLSr00IihP/KCNy5ofznamarxrYfk9d
         nHWWBrCu5UeYDKOwlc2/n50hOGPZva1G2ldduLczxhqOa2agQnevYWdKZhHmWCxeRxoG
         vJrUVFVecVUHd0uUyE5MZk/Uq9t7HWcENbsMrg1xR7pMfF/l691FKes3M5pcJf2arE4b
         9akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748757; x=1764353557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RR/i1yaFaavbNdSsVmJ9IzHV+HQy5kzJWXUbmdZhUUo=;
        b=b+6QVuS60ByDYe5f+MJK1O4xrNZB3bG9jaJpgHuvQ4AVg1lio7QAqXGX4SMCmMrBhu
         y3xcNWVkmezkfyp8Z3VEeP0U9lK3m4UE/pV44tT2InfgbVqqC4UsrB9wu6Pq7hvrwx8d
         +OQhn3ZB+qTefRWxCHDLo1/KELBGrTIY6EFzjyds26W91+ZkmOwjCd5oGgNFp4CkO1O1
         LOIed6JvyxOj7a17b6sAlbY8mVJNBNAtG4+QomsS/DVLGTIxgMTTM3kyXD4PzdGtPqK7
         z/w7WKHbB2LXsYWXD1ngd4HV2X1LoMGk1Ni/RVLQIlNQotKWyzlWz7iyhKGHHzwxOnVW
         6flA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ggLVIEHUixb5QdFxz+KFJ0XxRD8ssTupJKzLqjo9AhCVWhLXj+0qvOHXE85Kk2AM1TizFNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZoJoHTtYyUHr+BKbBsnurw+dydiy7IrXGi+/yeHAclaBcYAM
	2kAudnw/ODfQtcqUMNMf9BvEaGhwwtq1nbmNEW6K6FruUv9oU3v5YNMX
X-Gm-Gg: ASbGnctO6BmsUfLbzwWu/rL1JEf7ird6DTtK+u0LSIGShGEoL+kBWWNk1jnUiFEqHAp
	0qrQMbdg+klTYVN6FrMgk+9AvwJhiTjC4zZvSSm/hzCtjHinTpcWWR9zhvhgfVK3ps99Ec5sSHw
	9p9zu1zyPI9qp4fYNPAeba4PTW1zC4SIfRtVn4QpAaK5cW07PVa/KpqJDTcAFIAAXPFcr1Vo05U
	j7FGLkt5YaQKbyS8VXVJr16II+/zxnRBfUvYNz8mT8wL9xUrcJxDkCPhVMVaef8ePLSXVObCavo
	GMkxhDFeokflVxnz+JWTuUoajM/pOAKFtQFQDzS6oMjjJ52Oy0fKtwYHinF31BmN4/Z91e0u/Vb
	xn8MnF+TXJI8dx4653RmwIxYg4Qpgd4jujQM/8UNxtG2zdbiYmG9m+SIk/2rKs2m9R6ndB8OPGF
	NcmJBG5c4K3mg9OSUxswNMS9YSS1rQby/IOdzBVQ==
X-Google-Smtp-Source: AGHT+IF/fz6OcfhFX3lvq9ZzMVTzDGYHMbljXg6ptX45yQgciSaOLtMD5D+NHOa0dapg4ZJBqlUhVg==
X-Received: by 2002:a17:90b:2b8f:b0:343:85eb:4fc7 with SMTP id 98e67ed59e1d1-347298501abmr7984056a91.6.1763748756719;
        Fri, 21 Nov 2025 10:12:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f1262364sm6701964b3a.58.2025.11.21.10.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 10:12:36 -0800 (PST)
Message-ID: <ef85c608-7f90-4c22-85f7-eafbb88e3665@gmail.com>
Date: Fri, 21 Nov 2025 10:12:33 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/529] 6.6.117-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251121130230.985163914@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 05:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.117 release.
> There are 529 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Nov 2025 13:01:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

