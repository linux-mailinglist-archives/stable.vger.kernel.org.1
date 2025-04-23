Return-Path: <stable+bounces-136484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED2A99A99
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 23:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392E21890440
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 21:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F00027F4F5;
	Wed, 23 Apr 2025 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CzC88QbI"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D609D28C5DB
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442883; cv=none; b=JCbLCGVXQrMdRziKN73M7QZqkIT0qaQXkQNXCM7ZPT8nibjxs48hq+IYv42MoA8s9O9ZH87iJ2MViu2L4zSTBrEgzltBkN4raZng3kDR3BaJ92Rr9dY6Ijx2Fh9G1vTu4v0wpnItrEnv9/0ufxnm+UiMQpVqOcrLGRwVv2r5+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442883; c=relaxed/simple;
	bh=6tq9Ua/xdZaRB1yMj385Xjabj8eAWItkrC8osTxEbew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ole5VxQ/0abnIKf3z7lZKdaqxaUeo/Z4yHu2b7zWoFmzlkEpFR+ZIVKC89GFvEvZOJk2B+upGIQLMjb7+S66N5I6DSHgJtgeJBw21/VhkJtrc1e5IbeqxK6M07QAbyOHbDuw25ke33Im/5j18UUXWzCXxivfLC8RV+wVskF3pE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CzC88QbI; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d8020ba858so3207895ab.0
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745442881; x=1746047681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nk82mK/oVbn/gatmlztXyHlLD3lRtbsVbG0sPLQKW/s=;
        b=CzC88QbI1WxKUxgkGzpXLBEXadUshrPt01GUaKj5+RFShGY9YEO9PlxwokTkAf+h8W
         HV86LZjuVgJlsJ3uSJOmQ2S0D0hnSc2Li7zjd+fE1VOOP/Zl8KWb9MaNSSTuKwqAWEd0
         gU4ZIHPuBdfMvm2K3vetNePDRakLaDkmNyZAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745442881; x=1746047681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nk82mK/oVbn/gatmlztXyHlLD3lRtbsVbG0sPLQKW/s=;
        b=d+l4Ox836YE+nESxrb311lM7nGv+qsvVdflFffEzX3k57/5cAyd9tLpMVyUtzZ4WbD
         dLy3yQeRE7b1ecn72MUEeCcOwkeTyYZ91leBlhYcYA5srWvK/wzvy8NQEI4B2VGPBPJL
         PczTNXD2zlf6/A1p0C8VzpRDV35q0qWyn6WyoN/yhl+Mp83Z2yUd1z2RdbMawIuTfpkF
         j0MVDFEULtJRHSjnCvtyGn9UTTziQPZKIhMl7dI2EPLAegVoD65LvFxMu5ckZFFBk3lO
         BFKDOeczflePwgTC1mWEjdDSsXUY0qaYZ5cphypZyQK9ZSEdbo2lhrQ9uAgl029cQbd2
         lkGw==
X-Forwarded-Encrypted: i=1; AJvYcCXy5SK+kW5pHy1TJEktZjinEJWL9U2/Hj9ciySwPykKL9VmQ84p4KIUJZHLMqb83mMkKhNpJNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNyrfuyz2nmt9x8psNd2pJF57nIQD5lh/euxT4RPmxrgfsvA5
	pJvsWuSGoU4R5xHoeVuTTmyfS2L7PzASCywwuPXxbmAsZaO6BGKRatc3AauLEreRIq9LZuS5XHC
	Q
X-Gm-Gg: ASbGncsctxV5IIVSMuI3IEib73NqA2Kn1amxAj/ttxSHU/oO3iKlmC+UjI9LvcWutiQ
	jjaFFd+OqjkPI8JLFs7wwMBp3uQLewIb+2h7gQTHU5cgyclIobV9VcYhBmNYVVfp2mdhRiuFDdH
	U9w0TiDs1k0NO4cLyGCwLL8C0doJZZtCuifdPS9x5d94k6FNTONChSxenXWO74CHz8+F9LoU5Yf
	D8NR2j68rqKSqx0Q7kxbFKZdV0M4YWo255zwzlvUR4KDzkCFLDAr9F/i0VBoxsLrHfd+1HeG1Ve
	WYyEF6zoKbdcR/vMdOOXxk06DVEQnFwThWdWqbABMypBGZLS1o1kkWprt4F/jA==
X-Google-Smtp-Source: AGHT+IG0txJrMUkch3h4xwE3V6S68H8BHmpzfqRZMXfkUbFBJk8lpVf5BrXiDWrlVfZA3krODMl4QQ==
X-Received: by 2002:a05:6e02:1747:b0:3d8:2178:5c5e with SMTP id e9e14a558f8ab-3d93040976amr1529665ab.14.1745442880994;
        Wed, 23 Apr 2025 14:14:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d9276ac9easm5458045ab.69.2025.04.23.14.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 14:14:40 -0700 (PDT)
Message-ID: <942e0d37-53bb-4d7d-accc-9cb2b5149d95@linuxfoundation.org>
Date: Wed, 23 Apr 2025 15:14:39 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/223] 6.12.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/25 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.25 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.25-rc1.gz
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

