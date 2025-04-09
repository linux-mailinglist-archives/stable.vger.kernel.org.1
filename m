Return-Path: <stable+bounces-131985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E1A82F3A
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 20:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7B1880BDF
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9627703E;
	Wed,  9 Apr 2025 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y7yGeB3Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C91DE88C
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224439; cv=none; b=V8q7f9J77ikCNEOOExybG9slRVc/EadzB8PwwD0PeXHteSd4CCn8cIKzMjRDdFSGfky+7eCFvN4M7yvs2O4iiu5O5k4H79uduLgM1kAKZh2LRLUmfUXavOl7H61kpOU+qcjaaA3cOER9MRh+l8XqNzCH9i7JvvJ6zr55wDG0XHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224439; c=relaxed/simple;
	bh=9uGR+HlNTOhrXA095hQNTm97hB/TKjBwj210dxqNyc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msCNj+cBxdaVJxSo5QjOInM9fkERA5kOvaPimH5r0FcdPfgnihsBCAKoFQHVK/xbjKPsnDhJVieVy5TzWeqn8rCQSldHxWkxkA4dT9TknJrBmXRfoN8AadwqNpxqrYLpbp36OHadlSz9FXz0p7Aj5Tnm7OGQyU6XSVhVvFHv8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y7yGeB3Q; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d46fddf357so183755ab.2
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744224435; x=1744829235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a31MfxrWak0Tuq7rl1lgBguffZPL2d36CVBR6DtahIk=;
        b=Y7yGeB3QK1itttb1RNQt+PAe9oH/2mNoTh3QKaHrCZY4/6KUUwIAGkfMn7EsNvWKk9
         3lb6Qf1oRiFgdJxnJyNZjXQhWCr6rsPT2PPE8DtKSR6dDSrd54ATvFnRcT6XXsuVOkIQ
         JYyrrciOtJI9mlyXUarGfJepz44fV+U/XIm6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224435; x=1744829235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a31MfxrWak0Tuq7rl1lgBguffZPL2d36CVBR6DtahIk=;
        b=pRiD7AFjLg8DQ33Ug3PgLWgBYCak4fraBaW1EKt5hgZ9zImr7eOhPdfO+O0H7FXHR/
         l4Qc7q8dbVNQ/i6f3L/sfEaiNrmRtqpJH8cdalPNVdD47GE0oBg/rBSQn5zA8YkSQv6x
         NGqT0Mg6Z6abCyEwci8Bx4Mtz/cWIccQr4wRJRAQlsilX38dWgO6GmNo3UpQwz3CtZHZ
         PTy6YrhBv3wkRGmKHoqzmfvK4sIosDt/5R3sd3rcOfbErNDWDdzBxlKsEPrkqAoMFgbk
         5L+pxm8kl24eth1aWdSCHS7Uj/qrIgcwvTaNiA9XtR3XEtGqRrCNoXt6dtSfU283kYxK
         Tz/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwUCZrS2QQdVJImPFVBqUySLpmcwpqDSyCX7GsZkzFUeMrsh2QH9jI6e4YRaJfuQfCyGzDAg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXW3mHQlK1juU9ZoWo82I8halG/Jzw7JXaDWkJYwVYLCf7yB6Z
	6KHk3qpW66Gr6/S6g3nMPF3XJjNwwfKL+YC1uIIwR2CpPKceeMWYDOA9gs/Q139xfdS6V+liaYA
	X
X-Gm-Gg: ASbGncuOTSKOZ+T0QcQWt7RYdYux69HfmcKA9bLTqk1Ya7sPqz/Q3MQ5va3QJGoFLDJ
	UoN7G377IUG+OfNfdp9eQ1X9jGzeosmiNrPJO//XMqZdJ+2PEVMPWPbJ1sm5daeXeW66ts7+sbl
	0cPoYHKnnUSu74G8Rm86pQ4Hk0uO99sN+62/cIgdKCeSF9lD0Ss5g3MyXIwZ1uQZe42AQYksTOs
	5BZxbfnmG6C+QTCBMmOS72uQ9VenidUJsRufME0MYTH+/WHaJ8hym1jx9M2VW0ts26TyMNWBFj0
	zczMNgmwr3v8bU5+f+yNgtm+8sjgBC42XlYn6dWQQt+HZxrXQlU=
X-Google-Smtp-Source: AGHT+IE1GYrAa2BVgNVP9u5xF/JM4y9iYhKK1RMzet910nVc/m6SR/0Qfa9Lmpa3lh20JCyNmvbQxA==
X-Received: by 2002:a05:6e02:2281:b0:3d3:dece:3dab with SMTP id e9e14a558f8ab-3d7e46e42d0mr2327065ab.1.1744224435402;
        Wed, 09 Apr 2025 11:47:15 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dc5828cesm3913995ab.47.2025.04.09.11.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 11:47:15 -0700 (PDT)
Message-ID: <2dee54f1-e333-4466-beff-c4b202c9644d@linuxfoundation.org>
Date: Wed, 9 Apr 2025 12:47:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/423] 6.12.23-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250408154121.378213016@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250408154121.378213016@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 09:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.23 release.
> There are 423 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 15:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.23-rc2.gz
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

