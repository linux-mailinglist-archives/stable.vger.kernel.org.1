Return-Path: <stable+bounces-52254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2B90958C
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 04:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09B4B2221B
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD92B567D;
	Sat, 15 Jun 2024 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Is5W2UuX"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71C749A
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417378; cv=none; b=COJg3E/BUOoXEJQEWl51xb/I9UTpVIWUgVzCqgrsSyWYXK+Lo5M/d+txOba1T84QSmEQMGARSi226jgWi5dDj0Q6oWc31WqxwPpjbV6BHWXWaBWVPm/SDNgTCAAIjDXmz2gXurIPOE59xW0Hl4aEHu5VEyDv2W2aDIHGNR+98Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417378; c=relaxed/simple;
	bh=2rJq94MZ2ecqUa9DEBquCVlM0N4B3BQ+yYzW964DKfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2c/uzWYqbKjN/IQawnkQCZJWxOXTmAdbKnYd/3ym4JjFc5AkmXX97yEB10r/fJ+8lTleWn12EgLF+V31yI189dmIOz4stS57CriZbNF5ZqSrxUFwGwr9dHs9qQRH45gRJUwQs4Q86hfUb5mwPBX88yestmYpdEh8N4UMdbjzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Is5W2UuX; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ebb58f4f4bso5527839f.3
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 19:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417375; x=1719022175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWgXBk6Yxc1BKmHVd7Vm+RJCPaj9sFMDtkNeQIjJSiI=;
        b=Is5W2UuXmk42Z1QyWSmG2x5sYm65eDuBUtwJgA3ZYiM426wZx6yV+ZJuPCc2CODjPU
         iZhNNfk3fN6TBxq5p6/HqLS7b03bHxE6gMQCOKTYCM1bGg7VbH9Vx/0z/8cxA0wRuELH
         VKPvs1FAxdZl9osbDObWNEo9NmRHH1T2h2/OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417375; x=1719022175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWgXBk6Yxc1BKmHVd7Vm+RJCPaj9sFMDtkNeQIjJSiI=;
        b=UrtkFfblhzTvR44SezRE60h2GcQK2BUYSbKjZIo+fOz0QVoFlxdQVOb5CV2CVrxLTD
         J3uXP4BgQmuORFdkc9x8A2Oa0XV2vH3RJ9/CZl5k9G80unDVEX/XEkz3UTGaGySwJ39v
         C77wZ9rOGXG4eaHjoPR5F71N9apOKL9NGv3EDIOQpzme+nsK6r7FiryrDbvl+9Z3bMiS
         Am9JdxX1qjHL1Gqfbv/3s0V4jK1eXcIbPyk1gnI1/a0q0osMo9ncF4NnQCotgU5Gqhj7
         H1CXIwCnSLrz58F8+mn0t9DIf+PLt7zQR83L5pTd8gq/JhSZymdH7cLbcLYCbGjwbeOq
         NqWg==
X-Forwarded-Encrypted: i=1; AJvYcCXgflaaznrjjVuryyB8TUwtDxv0zujkFcQw2XtqunvYTpsD09nRD2LJpv8tfd4iYxCiq5A1Ronvq+K7il7gVU4XALbyoA5v
X-Gm-Message-State: AOJu0Yw6U/Pd+jPcr+NuZhAjnMpj7sQRfHC8IW/pZaXxp0HR6iSZYo6Q
	1swUyfhtalwAGIehMCQuVaFFisu6eHYb2BDwn98YfW03apmoyLUGjx3b+MxXFw8=
X-Google-Smtp-Source: AGHT+IGk00SCYmx4ZxhqB38uGdMi+LqnfHffbXmkoJHJ4EMoATX0OF+G4W1HnEZMnhcHq5plpyP1Dg==
X-Received: by 2002:a5e:dc48:0:b0:7eb:ea26:3471 with SMTP id ca18e2360f4ac-7ebeb51e56dmr431851339f.2.1718417375580;
        Fri, 14 Jun 2024 19:09:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a1f4f8sm1243193173.121.2024.06.14.19.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:09:35 -0700 (PDT)
Message-ID: <61781c7a-841a-48cf-9f62-e1d38488e87f@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:09:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/137] 6.6.34-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.34 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.34-rc1.gz
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

