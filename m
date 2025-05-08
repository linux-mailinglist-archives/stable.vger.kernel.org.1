Return-Path: <stable+bounces-142874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AD3AAFE19
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 17:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637C64E1D32
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730661A239F;
	Thu,  8 May 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XU7Akxis"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9651ACEC8
	for <stable@vger.kernel.org>; Thu,  8 May 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716451; cv=none; b=q1UYmFEiiN9o94VkiypYZ+cOLIaM5NX8lZpm7gZM+1ESqGFCS0b+1Tvzjs7h2244I+G5yqoIZH4c7LEpPd1nXIh7y3Tsg1YSLkIOTCnEcxX7BNa9HNYA6o+TdNr+QD5wpeUo5qkMirN+KW3KPbfPEASwxj8z/E/Gwz1cuH2TOjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716451; c=relaxed/simple;
	bh=bE/GlSLGGPFXT36aFU4gchBsyjqq28AacvXawkAxJyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kP/+lk5OhI9AjZ/wuGlOmUhTECsg2tkHc3kDKY8UIVjC2uNbumh95MfsVXeX+gdrX4TlLPQ1GDhpa5Ng9XI8rDBbBv2mK0i9TLJcrCJBvdm2VicJtQeTaglbDQdsQRY+R26f3uMzbAzZ0Mq0CBm4LHdtJE4ngcgT6/8cc0WFDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XU7Akxis; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d80bbf3aefso4124105ab.1
        for <stable@vger.kernel.org>; Thu, 08 May 2025 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746716448; x=1747321248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CaDQuSmU6yJ5IUs4m+YlbKlu2TNPWtfrQAZlJGyILvk=;
        b=XU7AkxisVBjGZZho99hmhk3vt17JTGWS+zcqzyysYSZjHukpu+b3vNHlH8NQsBrLQ6
         sBezNvFuqq2vkZzhpsDrC7zlMzn5+9OWvKYQCjoY80iSmHgrA/RothEe3zbfkI41MUXb
         im5yUG+UpC5wxT0sw2yI3FRe71quTDIlFQpzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716448; x=1747321248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaDQuSmU6yJ5IUs4m+YlbKlu2TNPWtfrQAZlJGyILvk=;
        b=Du18oHUkseuL5WrldN3oV0D7psZu6UT93bek/boIzfRgsp4LKHBPSQmZQbEsFGQehl
         RdiOLhOAH2YtmoU3CC4HtJWx+0csxZ070+ryELmql586847D/byCr8ZiwT/4ZDKjo0na
         sKnY1zN2sdxHh+r8scl0KONuJnbH/YyCz9E0rX9TEHGc/QP+mMxAoDQ7sRLvcm6joARF
         L5oMXPi93lP/0Spfr00PNLuC1gPymUteeGAvVdV+Pmpk1jphi0+ltX8hacV8X2mdFzQb
         qjLGiRFBzemU4lJ1vTtogqydIP3xjdyqEBDsqzr4uq/1cihznRcRSMfYakoAo4E/PAT7
         vnVg==
X-Forwarded-Encrypted: i=1; AJvYcCVL6tOtur4MXXg0Tx9frBB1xE/mOaqUmljKQnNMSEngymBQraxrO9i0V79NKP/h/P0oUftECwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOCwDZWGpZJ6HukHnMS1lUHrjXsq5sZV2quJStDtNnpa2R2zh
	r5Jkw6Xl1KbBc3hwglaJFNL+RneHHwUWg/rPLR0PyJngGbaQktMh1ZpneqFeYy0=
X-Gm-Gg: ASbGncvFqUipsx2p9W3TSREHuE/Q7UA4oLjDQLUFmIrQmAkVIMdffudB0g4M0WeMJM9
	8WdR+nhhZPZ0SG0aYN4ETFLe4K3PbKAxihQwVBj4/b+Nh9SOcr1rhz13fDPFzL6MTZRDiFEKcyC
	hAWWDwY8YwZQspGL5WyfFJFRM+Kaz1BKpEjoD3E1jDMrEK8WGxxAu1ORAcJnxJK8/2KxRSpu/AC
	oHVRD/xEhqo1JK09V5oSCcVg7R7nosQCuH8Ki1vucYVENe9X5CCa+1zcV6K7oWDeal+ry3A7qbq
	UW0shGyq5A0XVZf8lt5yum8GE1tTGisWZP5Oe99hjADZ7EtflWg=
X-Google-Smtp-Source: AGHT+IE/XgtNYN0EtpMRL67XznMJq44ZZbXSNS4qg3wRIrU5gb+loCCKNTbLb3TOZ1VVWtQF37EIyg==
X-Received: by 2002:a05:6e02:3c87:b0:3d8:1a87:89ce with SMTP id e9e14a558f8ab-3da7854d5b7mr52089525ab.3.1746716444166;
        Thu, 08 May 2025 08:00:44 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da721e7e92sm11526345ab.60.2025.05.08.08.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:00:43 -0700 (PDT)
Message-ID: <2f15967d-0bc8-4f91-9924-6312caa63036@linuxfoundation.org>
Date: Thu, 8 May 2025 09:00:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/97] 6.1.138-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250507183806.987408728@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250507183806.987408728@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 12:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.138 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.138-rc1.gz
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

