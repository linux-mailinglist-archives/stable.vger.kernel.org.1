Return-Path: <stable+bounces-207925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C23A5D0C99C
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 01:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89A8B3012AA0
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 00:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E90217C69;
	Sat, 10 Jan 2026 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aoJw7ks3"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87589E54B
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003529; cv=none; b=aepnAMQ+4zG5R1d4XCiQmVEeiyDlIY7vfiZm4thX8XAXBEnmEML2IflBLR3giar5XBz93JmkmbO9OioWVks5k7Nn/jTrk22FEJ4uDfpxZUNhR7nV8Rsb88sMr7bNp3VPca2NMN/2W9Uq+pRjoZ1y+Cw9vkhfMv3v02307INRnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003529; c=relaxed/simple;
	bh=Zkx8aKglAxv43H/X7SQikRjKI8tgqe4DmKCA9DIlbr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3Gfv06gNZG0xYdNmXS/C+kvQSrngawetR4DVkBX/XQUxfX3sI2XWK9cx1RClPAbqnXRE6dTaICa0vPopwqQLxKnZpcPvnRA3M/FPNo6l5eNT/9KR7yCcLq7wKwiQi58XNrl2PMAvzmkYoNUtd9S9O8Te6dvPG5hKaSPzFE7gsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aoJw7ks3; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3ec46e3c65bso3758933fac.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 16:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768003525; x=1768608325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAAYXdsHBcUohYb4hUuO3vkL32uUYUoNKXR24qxKhWI=;
        b=aoJw7ks36s/5eiotoxnEO6Vsk5yOdLLOJfwVVbxK5wvC6GjP2ISzHI7MILErdxocLb
         Z7sjH/lbVMXfmSB9MszKck1eeIfhT//r0j3s8vwlmTWr1VNxj7u/HQaxua/enCpTw4w2
         PDx/JuiTUE2hOKYkKvjN9ob5xlXJ1yLNmKNsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768003525; x=1768608325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAAYXdsHBcUohYb4hUuO3vkL32uUYUoNKXR24qxKhWI=;
        b=au2DCVrticO/qn5543E6KiYjqIGIbv0O98gzysw6VaFPXt4VTEjaw8OXg+45YUKpK0
         5K8P3uvut5sov0Ro+aD1+9ksKC8EKFsBegYyP+r06HwpATd/lSEQ8Z4jWK2s6tMob9cJ
         8V3Fhp+T67Uzztq1mw14oJRLNsTiu0YnkP/ZCRJEFuBDJnPFFJ6LBjHUuM404qQ2aQz/
         lLofi8y/1nuo05rhlQd/aV/RM5dm5oxl3+tpfXFIsfULqWMyp9Ymeq1DnJzGjVEBabZZ
         8dVxl59JKCc/QNCSnmdDZ4UQhWH8iF8zBlXnHx1Ur1tOtei55KdRZ94Lz56eyojXYl8J
         V7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYW7/IZRw1itD3C1REBEbByThdaPefRs7Ib/oF01Lqlz6XKFl2FqC2ElGjCnJOQzMo0XugxbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJU2Zhi32aJfEoxu0/PoeE/rH1niRMOXbuSixeMCY3xNEOQWQc
	IfCjgSoLAjTggGhoH+NenYY9YSsW6Yhx+wnS4x6LIbBLc7xLnejsYsKOKf0kid7AoHY=
X-Gm-Gg: AY/fxX695UqPOx1mwfUQQb1KDi3Sm+4pW5t/72rhkkhWO0xbVvwXpJlL2H2sRPzT5qx
	n7m/D+qOZmowt347LuVPo4QBy/0oJc5aJ03aQV0I3O4dxcnSpqmN1wSDy9aRCiMIWFRJ8rHW6UD
	e+YEtsDSoOv/0J9jI4TQBWkwdRbrEv6dYB8WWTIvIPsGDgaJ3rytjn6jkSI7wUGT8TliVvSrG1V
	rfHCw0kfIguAZbGgtTb7o6xuUtmz/aCaXbPlSByiXM2U2W9Luv2qJ68gbaIpHCnxOKAbHK+Tkp9
	qeoG7EHzH+JkrRub0js1kcSerfltJT4MFSf2bLci7+OKOjv7tUxq8T1ujcdG4Phut+OCIH1v1sI
	j5DKlTdwXeeXhDk5aZGBMaQ+cPHHrv0lc4DsvM0S721yomjASH4BiLbRPUB+LD6fg9aKqWtXBUT
	bpxUy2ZJSwGjmcbandI7O4L1E=
X-Google-Smtp-Source: AGHT+IGchok5FctDxwRe/FzfwKv+YVctWl0Umxq0cTtRxabxuoUsm6UeLDuSa6l3PGXJ+PUn7QNpTg==
X-Received: by 2002:a05:6871:7407:b0:3d4:b76:5078 with SMTP id 586e51a60fabf-3ffc0b948e7mr5457605fac.39.1768003525321;
        Fri, 09 Jan 2026 16:05:25 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4deae43sm8122639fac.1.2026.01.09.16.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 16:05:24 -0800 (PST)
Message-ID: <b93ecf1f-d655-479f-b869-7021b0681733@linuxfoundation.org>
Date: Fri, 9 Jan 2026 17:05:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/634] 6.1.160-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 04:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.160 release.
> There are 634 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.160-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

