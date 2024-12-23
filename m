Return-Path: <stable+bounces-106026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD099FB73D
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 23:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF90B1883E2D
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 22:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10451A9B4F;
	Mon, 23 Dec 2024 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F3qg4Hbj"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90418E35D
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734993585; cv=none; b=RoUpsjArpbOMfiPXwd0ZtGb0NyswyxqzUgp9Mmdt/RiOHdchz9FR69ELuSXrLgvJQOSjAMKr+qSbCM3Ltv9vH9/leEE5caqExQ+vm88yli3Kns67dDmGxpyEf3OXqTsgmdgxUHO6EdHTJTyzcQ462fqaNoZ2k9e37LxCloEQwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734993585; c=relaxed/simple;
	bh=RiAI0tXdGDHFALVdgJYntF6iUfac1gyKXXGoBqwuDRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nR/29MWh9DjKZAP+myAQrM2ELcBrh3U9xbufjjXEN4oRNPpMORV11KkKJsP6c6tU+wgXJgIyCI42xfrAQkzLx33ABR2dDLfwlaLjzD+C0zRSVAOXQlR9hvhZBS0vS1hBaPjdBg5bG6KR3fW/Sl+m39N3/OgTHQT4QBYsRFd9K1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F3qg4Hbj; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844d5444b3dso165354339f.1
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 14:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734993583; x=1735598383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=be7/RonVhjmu08VwAsKg4vuMbBxzDsJ2p7eX93MnT2k=;
        b=F3qg4HbjQ/YnC5UDRPmOmd0fP8h1u+jx3TBIH/VxiA7unjy4pbu19NeiWvHUzGXHxf
         /1Ckyr78NmBYqoWXfMRixLcSTp6AkR2KW5NB6QHjcwOxe1/SBY8AX0XGhzRYzHq8r49r
         R/bqelXABwsx+CfPtnhTLI//P4xAb29XSobEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734993583; x=1735598383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=be7/RonVhjmu08VwAsKg4vuMbBxzDsJ2p7eX93MnT2k=;
        b=hD017wo5KbZw7FUxEPzEa3M7ERyDIG8xxzU3KFnDb+eGNadgbqrdvyqjfxAPWJehqn
         fSuKFzeRAteOBpx88T5NhpyC6e2mPYUFs+NkZT30APZojTbGuqetHN08OPp+8HRAhRV8
         qdMWUXO0PXyoCDJp1h3ncaYhpGrR6ZNDv2ODgsfGHGR0dJ0FCYIH1LPF+0X0TQMgwN4K
         /cYrEV2O9IDulR7S874o8ne+/lAGRznTVTuSNEAvjYJj85wGz8MtjlQBTz4A2txUm/+P
         BOEhgOFoGJcUjbShAsUYbIUa9ECbLZ72oyU1ihVyRkc7+ggzhVYvCV0hQnrfBkVMh9Vy
         Izng==
X-Forwarded-Encrypted: i=1; AJvYcCU8SEdMe3mf+zLYEgquiE7dBEKxcjGFtnW/nNmZW5iBHO0B0AaNRc8d3k7y8lky+Lt+Us9GNyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pWt4Jb3AHVNzu69PqNOsYgf97WEPZnFztmnFF1IqekzL58qY
	4HABqbXrXCV65eiOyZM9p+sTV2b3MxKP7XUKGOFdOBMrsYbdWg/a+MMew1i1OBA=
X-Gm-Gg: ASbGncuZN+ko0JJgckLwF9iftkyq0SdVxoDWVme5uGb5K75XDosEHXSIXIMKTYgNjKu
	o0Fe41i67PmPKi6lp3ZuCS5Y/AfbgGOjlwiV04k46rCmGhkT2BxvjV8dphePBu1iU52o8aRrVob
	C665L3WYwU+RJbqmAk3+LNcuq7xJNl+2FY4IX59ljqZbGTnDSlvMHfgPN6zACu8KRWL3x8O6TOp
	63w6pjjI22Fz72lRXohh92LAlq8gexKszIVM5jEzMLKa1wsVuUZ2eliOA0y6sEpocLY
X-Google-Smtp-Source: AGHT+IEz+NIDzSEZUcGPPKarHrLAfuW2OviDkOfngOuKgwzh34HNpGJ2TKkOEJkYaXJ9EqsA+Mqy+A==
X-Received: by 2002:a05:6602:3a86:b0:844:2ef3:a95a with SMTP id ca18e2360f4ac-84988d25967mr1988497939f.7.1734993583027;
        Mon, 23 Dec 2024 14:39:43 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d8eb32asm239386639f.42.2024.12.23.14.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 14:39:42 -0800 (PST)
Message-ID: <33cb0bbb-d6d4-4637-818e-83ba4e7f278f@linuxfoundation.org>
Date: Mon, 23 Dec 2024 15:39:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241223155408.598780301@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/24 08:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.7 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.7-rc1.gz
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


