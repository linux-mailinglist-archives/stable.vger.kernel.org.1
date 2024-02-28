Return-Path: <stable+bounces-25391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B4286B52B
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C865B1F26D28
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDE120312;
	Wed, 28 Feb 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X3f9VYqa"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887A1F604
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138369; cv=none; b=l+ZyKYbkw1t7/fpqyCdMBBHpfo3RRZQ9pnYOw3nBYtd0Kmlnmplb82Y4jllmGSNw1haxGEJ/U/MZKML4B7xi9smuigCKxWfvrrDIyVp7fpSknyJhPJqH3i3hh0nb2GMvyTEpx1h8jx0/Ki8hx4R6zOECX7I5I8p8Q5QkRUUKuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138369; c=relaxed/simple;
	bh=ZZYZjjBoPY25nB94qJ/iXB7sLKjUp5eutwi9DVAvdO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNmUcEtJWMpS1zJjCM9fzH7fmiXZcwQreCenG/BsGzv3akewFg8/0BU1YGDZFOuiZucTpzbNAUKphq2OsmeHVJZRP0d/LG6mIwPnIYbhG9CYM2/6BAr1hv78iZDKRG2gWwd+G8kV7XXSVPuZK+ahM5tbi0118dpygmEdAf//aZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X3f9VYqa; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-365c0dfc769so410535ab.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 08:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709138364; x=1709743164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywQ2N+51LDfOyR1ODhnc+p+KZScDU+E/nSoRgEWr78U=;
        b=X3f9VYqayxx/dZocQVhTvf7sS4HNw4BTPdUavVD8Qzzs+nbdO1F3a5VXSm43UwCfiV
         DdAZWgK23/GD7VBrzEv2vgleltHCtuXYLChFRfn16g8qxwnYlNe8ImwUAYc6v8S1EMJ9
         A1xKdOfE/akJwUlmfpwBUD9xppTlDFi/yqSyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138364; x=1709743164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywQ2N+51LDfOyR1ODhnc+p+KZScDU+E/nSoRgEWr78U=;
        b=nBMocUO3lnWFZ0Ktgj89noI352CVK/8QaXH/B9sI0tz8pkQ/EsDbfHrvnvlDsJDBZ3
         ktfVaNO+/jXtiEMDViOD8zSZ8aqTXcrDeWlhFPaGWV8yvLXfAZ1khXzUuqpdTp+3W9Hp
         LCDwJH9PDxUzugvQxS6KCUcqpKHFuh1cRLLiw4o3oJ2aPTG+e3Kjiis2AjRKyorTcNFO
         fdCxXoGFqNEMSf5bXfOK4eJgXXjLN9XXB64wC1DtkQMSHqapnEk+gEZHc7bzu9wrFyIv
         KsKzyqzMCyo2u5kEdBe+hACLCiKFb8ZkxJfRerN7TZfzlwV7KdcqZ12nbhSUxjjRAMQi
         YcVA==
X-Forwarded-Encrypted: i=1; AJvYcCUt9wvsblwBX2WB0VckqbglsW8cvg97KsL9gPZnNjMi/ngU4JIoeK2+g9DscGyiyNYVnieuwHOUmuu0C4iCA1qclLawG9AO
X-Gm-Message-State: AOJu0Yw4zhJd9eE3rNl8wm/x6Tuht691eFJ/q7QeF3/51yrlX2L3qnfM
	1J7MiCIb4eOeOBISQJXhwMHQoJWTfx6gdqmgqe4IMJRYVQOEUhHMZFV/5AtZ0FA=
X-Google-Smtp-Source: AGHT+IGsF9/a+7Ca+mGlICoWd8c8ICEa5PoYE/zWk1d7/NEcuLYBJkjLS0sP29zqANvE8DiQhmIt0w==
X-Received: by 2002:a05:6e02:1d86:b0:363:b545:3a97 with SMTP id h6-20020a056e021d8600b00363b5453a97mr12989996ila.0.1709138363186;
        Wed, 28 Feb 2024 08:39:23 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bs17-20020a056e02241100b003642400c96bsm2891272ilb.63.2024.02.28.08.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:39:22 -0800 (PST)
Message-ID: <1d657e86-c1f1-440f-99a0-5705a29dc2a3@linuxfoundation.org>
Date: Wed, 28 Feb 2024 09:39:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.7 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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


