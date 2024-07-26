Return-Path: <stable+bounces-61897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA1993D71D
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA18728602B
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E17317C22F;
	Fri, 26 Jul 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R25yLhEK"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4317C211
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722012024; cv=none; b=qx3xSoE424mn60snDgCGJkiNNgBZiehvqrz0H1lkO20AXpjZwTNx+pxOEINKVWxLT2QXTZ61T0PIbTzUoUzcjOMkcjyUv0mZcmcWulpMsmNUsvG7BOfFGfdC/exkHuQJVRre28YhK8AxXhZF2mPf3Q9oHjqZryTA6doQmfKSmVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722012024; c=relaxed/simple;
	bh=YFkHJmgMoHj+m0y0ahZe+tVJx9yx6DTmVWfvugjJLTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZtXvK77HsZ3FGTommhrpFPN6mr3QVdOj/hWxzE+pvbw/g5MTgNiZZVmfZaJmywL0A+AnSdCRanc6Vjbg1FMXbgSGjnJ1oF0xl12jukBe8zrQY/tkTy8TXSzv/rWmnDB7FoLZXRkgDT8GGfUAgn3MLFIrmNQc4iiQfgArsdD9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R25yLhEK; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-81f8d55c087so5858239f.2
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722012022; x=1722616822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdeqIp1amBwYh9X1rRkUL9HFaDcjtUcMUkWTNmSG1HQ=;
        b=R25yLhEKQtJvrlEoET7ks7ttJHWboe6iY4OwXH/dLKHgYh56ZgbKeOgBa0G9P1WOG7
         tDdenBNJmkWYDnFv5AGr5I9E0ujzmllqaqEQEyFlSI7n3HYzW1szErabx9eVIRWoH5Uh
         /zJGrqdKB+0civGtBVsuBLTrHgGVBkGp40DXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722012022; x=1722616822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdeqIp1amBwYh9X1rRkUL9HFaDcjtUcMUkWTNmSG1HQ=;
        b=T3e1j4lk25iQmhtpdfN4sizwBmKAwwCfVBuDpOoEx4QwYIgF/JUoNWsApwCBzsQiGC
         +ibHjtD0pT3/G3XNqUVM3vl4dnI9AJnTXU/NkacrbrCWjgCLKMtbQApPV1e9EYNNX8j7
         JBpmSmA4SHQfLI4g5E+BMtWAB10W6vQykw9WqZXc2+m6bePwPFaw009/ExmEwLxGuuJ0
         vgoZhrWH/yxIHwSpIx8pE56ikSjzEPQ9uxdxRvFcYS6HI6Qq2RLOZTqVUYqnvyqlyivl
         vU9X5z1o+oo8gknKAXYUaIXG0BUuuhKULXc7lRaEh3lVGg8h/9eqX49zv5ipCG0Joq8f
         f7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV7fLu4ueB+ScKMsRUht3cHyYYbAs/S8MojtEjvTM2OjFrWdTMd7oHvE9G0G6mApOJbjvnI8/kIJGJJl+T1nIJ07G8jwoxr
X-Gm-Message-State: AOJu0Ywhao1NGsm9UR3J8CKx6h2VQDHGYu2w9mvKBIZQQ+HMBwcezLpb
	y5LLEAJljucjyEI4Ljn6FuoALSKQ7Q1bB+tmld2j8Hf4S55Zmdslhc2DC6LlUDA=
X-Google-Smtp-Source: AGHT+IEVTuMiNnfHYyl+FJNl81Dbpul+4YdQEdWL60VJeEzpubbsWkDjTyXJMssUsftU8oZSnDHKrg==
X-Received: by 2002:a05:6e02:1aa4:b0:396:94f3:a9de with SMTP id e9e14a558f8ab-39a22d465d2mr48021365ab.5.1722012021928;
        Fri, 26 Jul 2024 09:40:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22e976besm15575205ab.31.2024.07.26.09.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:40:21 -0700 (PDT)
Message-ID: <642ef95a-62bf-4a4e-922d-91249d3b8ddb@linuxfoundation.org>
Date: Fri, 26 Jul 2024 10:40:20 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/43] 5.4.281-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725142730.471190017@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725142730.471190017@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.281 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.281-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

