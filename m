Return-Path: <stable+bounces-83103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F45995980
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 23:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D303B20FD7
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A76C216459;
	Tue,  8 Oct 2024 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RPun93I+"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA74216444
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424754; cv=none; b=bfZLC7j3OsUmL4HtZUMSZ0m0Q8XCFu3aYBZo9Rsfpdu7TkALEYHQJ1ZKC8ecjsKKtyFcT9EhJBpOXwj/98Uo0KeKY9PGm9vCknjTdU8rtKI9TKG0//SRw0kTIAdLYN6dztlkdPQ+iT9Az+OLYBMHup07wDyrjoY1v7FLr0v5veM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424754; c=relaxed/simple;
	bh=uQ/KpIk0W+YBt9/OgdauzL55cI4XSv1lQND1Cb7MKwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mv+WDo7jUPqZa137bxk6D49Kf/wH6znOE5yigGXMBnc2TFSesfRVcw/uV3WgPQ1MycD/9grx3vAMPwDKzx8sm/t5m2iFxzn6w1XEwl3keCpRPqvuxYEV3fWOw+CDQ+xPEIIFZhW2y9DmDWHk+jF4NOxghUNWlI/T/GOezIkjDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RPun93I+; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so283883439f.0
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728424751; x=1729029551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJx+qK9x7CGLsACm3HeKgqtf2MT9KIQffopF3Jz5VWs=;
        b=RPun93I+zs51ZvOgwhWop7mE3le8BNuzUucLdEWb+OLy2Oucy7Sm4+GVBlI9D9zy5E
         sSthZ12DXn47DiuAJKua51jfFV5611JNxe+cLJLOVR90ypXhIc1BXfKk5DNbK/m3HUzF
         ihRX44BhR7YehYhSxnkVVrrNNcHQP6Y3FFqQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424751; x=1729029551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJx+qK9x7CGLsACm3HeKgqtf2MT9KIQffopF3Jz5VWs=;
        b=AkL/uzE4l5qIWj68neDKDtPZU5cR7eCEs0CjqzZczWB/oclDNDJQn3siId3S7W314I
         0mOC5sdCPchBU3oR4uWgi+qtamhgbPQ7m/shz/SrE28aZvhtotAYbf+u5AhHKnjbCJfS
         VXqmKYiQGoa6Yd1Ie7S7IzGMS/gAQShcPHkqRaKqkPck4oznn1vhuTC211Zvn5gfSdDw
         A4sFjsKlRO8+AR9OogaBhd1TwZvzm7Y2MutvCFRvFtYkG2DDA2Ka9hQy+JrHCYBz1/0s
         VxaTyFS+GNd7FkFsA9DOcV6PLbxxlFSRHQGUtBYX4Qrn/2qVuPDX0TneUpeyxEkL3bnd
         PcAg==
X-Forwarded-Encrypted: i=1; AJvYcCXr58EmApjsqv2jfP/CSHQiyowmY9jRSVc0a1LGflkPSY4D9JlztF5QpAo/aS9SqKawx8xGISI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHWJP/z+FFtkV7HCaKAGuIbAw2FqQsx/V3k+oBiTGKhCP4GpKk
	4z8/6hkhxGfXQCG1RrYP/8X0Qz6EOvT3AAPlx3MofFz/hj3jeaInBSqAsJQBhIkmC90igkg0dLD
	e
X-Google-Smtp-Source: AGHT+IGLgxzcQdWZneVSWhW62HZHmsGOqji8cjnJIuTkoYxB/qoiwZjKFfT5jisQmK/UwSTC82IpeQ==
X-Received: by 2002:a92:cd83:0:b0:3a2:74f8:675d with SMTP id e9e14a558f8ab-3a397d19ce9mr4507215ab.20.1728424751454;
        Tue, 08 Oct 2024 14:59:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ec4f62dsm1816011173.156.2024.10.08.14.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 14:59:11 -0700 (PDT)
Message-ID: <2efe3fc4-e860-49ba-aeb9-383bd3257a90@linuxfoundation.org>
Date: Tue, 8 Oct 2024 15:59:10 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/386] 6.6.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 06:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.55 release.
> There are 386 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.55-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

