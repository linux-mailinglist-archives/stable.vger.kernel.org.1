Return-Path: <stable+bounces-54780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E55C9114C1
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 23:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393811F2158A
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 21:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC8A8005C;
	Thu, 20 Jun 2024 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OyhJ066I"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA27B3FE
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919360; cv=none; b=gOdk74UYBmqtGT7YWYAbid/z2nnITofcRXzIFumLvQ1/gL38jXm2leBULMiohfBRJPdnLFVMqWgAWaMoP2ureAMh8Kp9NZdbonqdn5JzYIA0agEtOxoOl+hp8Jm0gBBc9bfbPKAR3wpEkkV+QZ6DKzDv5zvFwZmXtR2AJfKQXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919360; c=relaxed/simple;
	bh=ZTcgaK56+v9pAJfpyBCcK7AMQ31SZcS+ia5+MEWwcGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FY/iXoKxeGhkmrUPBghy38/rRO/MqCH61pI6yDphPrfgK7QyhX3eyEtec2FqkkG1WgVb8NNWnwTC5KaBW+XwIVU4DoXlqyKhUAPsBEy/EzUW/24aHqJecWswv2CxRaq/sjVyhltdLjrzOJD5s6wBMi+FxsawEigsyNMh74jR/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OyhJ066I; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-375dea76edaso736665ab.2
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718919357; x=1719524157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9ofIQLYPdOS8TshOJj7rEW8hxg19zcYrASvxB8ul8U=;
        b=OyhJ066Im7YQZNDdXGqDrXmnQOXFJAfE+AD/rBOa0H9UYGUlCOIwmF8Ea5TiZ6C3i9
         V8sADRrxy8jTDhPp/riqmW4VNahzfZlziWUDuLBsrPsjmFcCu+cz7kwj6Ym2u+R3IkR7
         6idCxRIEqigs/DPTo6mpTNXvIjPc/S2pzjVW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919357; x=1719524157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9ofIQLYPdOS8TshOJj7rEW8hxg19zcYrASvxB8ul8U=;
        b=Wnr7vqp1MyiAzTvFaR4PewSvlMb9j2AcdpkWsLP6HOdygbn1yr2RyAYbJvxRi1b4OV
         rZKeZGXTVgzd8IFGgiBrsnZ6Sh+MilFmLxKB/e8cZER6bNIWKIKW8DwIXcSGWwkhFiLs
         ns5ReDSSJLbZ3Mw7ntE05IQSKCN0ybOB5Kz+V5Ol4FbI7FPOfai8iK5roeaLy4UTIXE6
         VTjsEacambId25WSZhNLhL3Zo7VvfH0/FapogjAFkbqF8+VtnkDbLlw4FsU8PB7ZMXZt
         ITrZhdlnDfukkgcnOUFtKyLZBq8zfD/c+7t2WQ68cfP+ABeoIdM+4jPny8FtXNGvPIHi
         mq5A==
X-Forwarded-Encrypted: i=1; AJvYcCUecjo7Nz/CIfR52+PMvJd2rlowibCOvGpEOq6rw8kir/AGMwcCTNemeDObrEue1Mph9wtlKToRoZCuWlwaM2K0aYGuXYvY
X-Gm-Message-State: AOJu0Yy2eXxke6wXHidGt/m1ySifnEhQq56lKFmmHQjqbjd9fNHjiHGY
	zolyCdsrQoNht9pLa6xVMA7qficFWUGf8jOHAplSDFMDRkeHFGRP98baJkLhiGc=
X-Google-Smtp-Source: AGHT+IHqCribPqhw2Ibl2+02wGY69rP8DtYR7MopXoSYep1ws5H8GQkoWY3heLjFA/IvrIKssmwzyQ==
X-Received: by 2002:a05:6e02:1194:b0:375:a1e3:d66d with SMTP id e9e14a558f8ab-3761d627f10mr55203895ab.1.1718919357283;
        Thu, 20 Jun 2024 14:35:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3762f38bafdsm434325ab.62.2024.06.20.14.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 14:35:56 -0700 (PDT)
Message-ID: <fae309ae-cd1c-46a8-b6a0-e34e7ba7c44e@linuxfoundation.org>
Date: Thu, 20 Jun 2024 15:35:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/267] 6.6.35-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/24 06:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.35 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.35-rc1.gz
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

