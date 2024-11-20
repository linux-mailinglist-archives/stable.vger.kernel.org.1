Return-Path: <stable+bounces-94473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF99D4467
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 00:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4822825F3
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 23:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9891C3319;
	Wed, 20 Nov 2024 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yn8Iaj5m"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C31B5337
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144816; cv=none; b=rhJ7jfyyZj2BrNVkawOhF/RjmYKfPVPhYTQvgps4aBT3nJ5u774bpepsS8QijM6KRDzVeP8LFaBHrySk6zuWr0dYjgf+nlOoBwdaaq/gUElri1u+Skmssxb8+pkh1LXWj5gCZVZOFkdXtq92oWM0Ozx7xt0pnnSnoe/oexu1Nx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144816; c=relaxed/simple;
	bh=jI4SLcBURQUIVjCq9OmPkKskQ+oV7R1slDut6JAMdUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcynmKM6Kk1mZ6N+YBkSd/LRN756osE0PJOBXDWlPQPIBqcIeQBq6hWHGa2NSQnsobyII1FTM/zjEwRFdwiMORP4HoBk4yun7UhYlbJuvbwJNQqI0O7yjRDpiICWmzBnqYmnp5TKkFnnnr931kgeyD74SZvCVWPxn2KhxNw5Lzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yn8Iaj5m; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a6c1cfcb91so945325ab.0
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732144814; x=1732749614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8xHzRHGzi5IfxFH+OvUgtLCMdNgx5N5MbYr0Qa4lIc=;
        b=Yn8Iaj5mj+C3dJDzZQ9CnXoN8cPSWEXlAHE1vIaQuw8wrNzzfIW1t57/eUuB/N9TM3
         hz++3IvcGJtrcGE/CFmdoRuHvbKyCU7siPtUF+hocZJtJUBjuF7BjOMKEIhXa5AJe1Ad
         pDyFWfCell2yJwDLVMPF3M2DUBZXjWgHMCjh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144814; x=1732749614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8xHzRHGzi5IfxFH+OvUgtLCMdNgx5N5MbYr0Qa4lIc=;
        b=X/AY5mJNE00JRVKwwUGyzZLUKWuo7JNVQ1thU3Y+MLa3Civqoy3iIVyKluZZShHmWS
         b7s1JEWPwKLF+qKt2RhLwM8KEE1XGFTY4l01BLigCJ3msa1Kw2nDPyBRXvjH26UkIssE
         fcMv8F9MQwUHNrQUVkCt6ZboVDHpFrBU9GcNa9RlMT4jqImTkHg4pIWNKo7l7QE1htbH
         2qM7i72eU75SMtXVwdgSoYzZ4uUcYuyCKzPotazGfgekZw2r6E8PRCon8fZXsltPVC06
         Yj4KX+fem6SPO3MKqpnD+mc8iaOqqz7e92BhmJt01uUd9nDiUuuslRZNv0YsHhO/Zdaa
         hRcA==
X-Forwarded-Encrypted: i=1; AJvYcCXQw+2c8Jh7vUfwkPM8VWJBYacgHA0G6Ya782lNxOfb+cFll8eJ+MtdA7dSDqfuZ7kB8QL3WDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSRf+jcT/hELDr7UilYwt+RLsvGFQgJ7ggMtbmZMdJWK+drgs
	FKTfPkI8rE1CydBo0BVVFEk4IAACiVfBrblHiDl4gpP3eT6Nsz1wEq0bgjlfadnUybCozVBiLgj
	4
X-Google-Smtp-Source: AGHT+IGLUc+IIYiZvfXusLHHAf1JPdTjyjFweeMLIA2azNgB7h1pYfNPCmSUCryRIBxpqnB9hzFEzg==
X-Received: by 2002:a92:c24d:0:b0:3a7:776e:93fb with SMTP id e9e14a558f8ab-3a7864a9067mr60036555ab.8.1732144814408;
        Wed, 20 Nov 2024 15:20:14 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a74807dba4sm33826665ab.29.2024.11.20.15.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:20:13 -0800 (PST)
Message-ID: <bba15d36-e82f-4d78-912f-fe12d2d6f179@linuxfoundation.org>
Date: Wed, 20 Nov 2024 16:20:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/107] 6.11.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241120125629.681745345@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 05:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.10 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:56:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

