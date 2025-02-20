Return-Path: <stable+bounces-118469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5660A3E035
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693BC3B4B62
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A3D202C36;
	Thu, 20 Feb 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PILe3mLY"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D2B20C024
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068028; cv=none; b=KRubT4u6g8BadMtbQmHCRZ4Hka977Ed451QCki7PU5EDOxtEtWkCpe8TdO4ebQJPEV/ZybECwx9Wb8ifP03HXCSpIwsidYerb5qcm5LMnoUNBKd+9tI24S/TvEIgwJt8JYMaQPqYwTwd96WXwv3m4QYmoBmGFD9MjwnBrwiOpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068028; c=relaxed/simple;
	bh=8bQ+eHlnlUU17DnVx6Tg/96s0TIWsZ8zu20MAi+7+NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJ3htzvdBXc507eginmQAy32dNPAtepoCPJRoijBaI/nw6YgRiNT8Wwc947jkgK6gd9RLPGas3y4XoUmt8ldWjtnvQOWE/CCngp6RSpRNwjXvR+72oP/JlFpGnFJx700s/2ZVufs4hfcZ1/PojOmQtQN1/aM4kyAdSu5GV9ciYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PILe3mLY; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d1987cce10so7878465ab.3
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 08:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740068025; x=1740672825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/Fj7ezvz/oB9SkmTl6eJBk1br7rLRHa//ITeH4ze3g=;
        b=PILe3mLYdrTPQJnrmJPB/qAsxYRrzMfrtDvmjUCA6BZxXcwCipYIuIuqOEko7bmzHh
         tz/zYzlALslydzAwVTiVA8MEupMCei7LizQJoiQJCJZBnIjYPTWL+jgVopFwhHaDUMq/
         vAZTUUj5i9TUk5G7GmeqVgcTmzgG8ia/rrcSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068025; x=1740672825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/Fj7ezvz/oB9SkmTl6eJBk1br7rLRHa//ITeH4ze3g=;
        b=Xtc1mLzX6jSxa2+3aPZnLh3Wu8a1ZiAXuBBV9c5V9ADRUF5XlW4pfjA3b7iLeGvV+s
         MDSHxRduyLfkhcaWlsobRm8N/UnOJWwctWkSZ6DbN76lucxgEuGpqjvwjVlhxB30FzGx
         S6LW15hBwwbfwhYzIf12NwpuAZ7w9IMNquj9WTVHffX7NcXfd6ftcGGDK8uiUbsIgYkH
         CLJ8A012kgZQSdA0ysdtIBnyEaRTu4aR50NkhOK6MjQ+R159++pT3vVjQjdQwFGEPB6g
         Ryve82i9RwxJCx0kLAZqpq/zwLig1pP8M/TQOrNF0b6+KZjtoeREAZV7IqKzBwB9ctqA
         jkCg==
X-Forwarded-Encrypted: i=1; AJvYcCW2FKrdbzmGirQPcOlQb6tTTOTlU+iOOxuepo8cYVIyNOIABghHpA+zpMwm6ixq2eusQMDFpnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyplNguZRbm5Ixa49t+XLvoeASmDyJui7M2/3OU4/I6OCH4XAsx
	ZQQrGQRuAJwZ6/8FeGJ2lc45G1u/OVsXqyb/5q92L2xXXjPnfAv8J5sGnwlplTP/0pcPua7w/Lm
	h
X-Gm-Gg: ASbGncsAcfjt/DqDFEqdh5k6rG4NZnJTNebJBJk7PTbqp7vWGzQP0C55iziEBv6UNTf
	2nhk18rG4/jqzqahTeHq1LtwIeBNQ3plvHa2GX1sfv/CsR0cieUfcpAw74LOtT4FljdIhjXTW/M
	BeOcZJ3MOdYEygPcimKkjeIrx179AyBuRgCkr+CwjLeZVu+JPXC/FvuFMb0YCC35ohpaeB0Ry/P
	qOqW+RqxQokt68juaTZJ8l7YOulA3iU4rH4uxWM5VaOFMNBRal3tAShr0DPwdr2wc4b+GwyVUre
	npbNf93Y7WXttiZj4oYx8F+Ysg==
X-Google-Smtp-Source: AGHT+IGcSeYu2MQaV5yGR45eedGFuM3Cc5su9wfHeFkMoBkw+wHJEoPeb8gbQCzXu3GfMbmvhR9FQQ==
X-Received: by 2002:a05:6e02:1849:b0:3ce:8ed9:ca94 with SMTP id e9e14a558f8ab-3d2c25deed3mr30899665ab.14.1740068025107;
        Thu, 20 Feb 2025 08:13:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eeb9359772sm966464173.60.2025.02.20.08.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:13:44 -0800 (PST)
Message-ID: <2861e7f2-1f53-4107-8386-e8268d3a2cfd@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:13:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/230] 6.12.16-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 01:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.16 release.
> There are 230 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.16-rc1.gz
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

