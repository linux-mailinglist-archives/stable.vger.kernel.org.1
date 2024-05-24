Return-Path: <stable+bounces-46070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF218CE726
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD543B2295B
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A82F86AE2;
	Fri, 24 May 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O7ZEuo0h"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657412C7FF
	for <stable@vger.kernel.org>; Fri, 24 May 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561258; cv=none; b=PaSRSqTwlr6nl7IgDkMwW+9+8xm2HcmjYW1IeG2Xciu6wZVRo+OAplXMTXImw5I3idjv0IHYjkECrB0kbu0Zw4ckW5gqCG7Z7zNBDNvkUFqO+6ZMzUW+c5E/ZQMxN9ZtqdM/Cc4hOfhgi1IJ7heC+1rvMDOdRE9ZAhhH7qEYb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561258; c=relaxed/simple;
	bh=0LW5kQpkKcNA01e08onMNUViqKVomd1eBF+QginYHSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbWyjVjylEa6FL1cs0MO3aVmF1qhNENvdnPVxwlWcKAs8fN6RBaSNDJr7nXnSLZEgbXLnSCNo4e3tO8bQEl4gdBO2omHEEOMqSbHtNB6rZCwUcyA7il06JQZQbmvUIWLpYxNrfUv415CeBKSfo7zu01P5/bmwCHd/dfh4IrxDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O7ZEuo0h; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7e8e5875866so3708339f.1
        for <stable@vger.kernel.org>; Fri, 24 May 2024 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716561255; x=1717166055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IU6lh+O/rhQRAe/th7cj4rZYezjTqNUFq7EDizlAG6k=;
        b=O7ZEuo0hFp2A21fL030VfBd8L/tFW7pZOuokfYUhyZ75YBPHWNl21zrSgY49g/d28S
         LGrq6cXpAaF8xJz6hFG1zTzId/qTEdJ87D1p5bpkUGbkE/c6GMg7cNCYU53Y4yZKgJNH
         m2pQ9Uo/UX9LIrIxTp/meVOYh0iDvjjHes7lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561255; x=1717166055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IU6lh+O/rhQRAe/th7cj4rZYezjTqNUFq7EDizlAG6k=;
        b=Rs63qy3cItqAwvn7wta8e/6HHqdzVJELMTaJBHSZrHyfc/7wVjwWzStcTT4Du2rjsA
         vcZ2g3y6m4+g0JOnVLNAW7YHiIxjxVG7z7THOhsX9LaiSbEYlTX4hp8eUfb+FibX0Skb
         hcekRGG+NwMS7BlO9W//jY/e8Ik7WwoHb27sWmvPaLI6SwtOaoAvexp2c6snBOk7NhXn
         y+cIL1fpGow39BB5g+Z6SFom/PVdLapJBwzuuo58kHwF5+flI2zCuRzT1+7gfR37ylu9
         YlthfonhbcxL9SUBEAqilLoxVRmLx2IrtQVJPDeROVvoICbYK4DOdVbnyFT71AEEhWic
         V9FA==
X-Forwarded-Encrypted: i=1; AJvYcCVuAQuLp4UDWy+SULOIVd6CppC1kW6toq8cO7dcNttVpAcG+FsVNDaXsTSluJnS9XCMOqr2u35vuAxWPkPl+XmxAGXpNBy9
X-Gm-Message-State: AOJu0YwmLpPQqeWM4av81Rnk0fCpr20Y+OORb5r+Btab3bfnI0h/GgcF
	giaWRgylGdKk+/5upMpaZuxljjWeSH0eqmID9y7GT2HsMUvi8X8aOlK1EUWUNGc=
X-Google-Smtp-Source: AGHT+IExzU8zbY3DeGKVrh+NlSIqHpY29IJlBPp0jT/XzxP1MOnFoZUl/sXSGgwPcNb5JNNHmGTscg==
X-Received: by 2002:a6b:f70b:0:b0:7de:dc52:18b6 with SMTP id ca18e2360f4ac-7e8c6650f02mr288446239f.2.1716561255536;
        Fri, 24 May 2024 07:34:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e9041e7657sm38068739f.12.2024.05.24.07.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:34:15 -0700 (PDT)
Message-ID: <5e9f6cf3-7ba9-4d74-815a-17d2578548ff@linuxfoundation.org>
Date: Fri, 24 May 2024 08:34:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 00/25] 6.9.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523130330.386580714@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240523130330.386580714@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.2 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

