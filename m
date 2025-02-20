Return-Path: <stable+bounces-118472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB6A3E046
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00ABF188C730
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0048B212D68;
	Thu, 20 Feb 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DFr5QnQX"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84A211A2B
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068147; cv=none; b=HatltqMvcB++pjuKxVZhQuhwFqRrnFQpCaAK1tjC4aP8/EwxGd4WEx5L1Gs3cbJlalwqMr2JOyAfj7tk/2ozF8/J/hATWuE0YiVvshDtTPSqwAPWSiGOWkTx7e/2jR6Hu3d08ecxgQJ11QIdmkyRSsfX4ZeTItKDyOIQqoB7+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068147; c=relaxed/simple;
	bh=TP0WVW5YkfkBapgEr2KnnnXFYymHavrXUZsKj8G43Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHU+Fa78U3YL8MXggnn1VaJ6ayKREfuZEnpRIdErycm61DNxEzIaRY+sbib4kbw9nSgA2Trj+mlPNibGzpHGoa8gn60QxK8UCBHmwSXOsmFCms7GbKb5OwRMU5O9VEUOifQTuehP7oRP1yzM4hyr/ZBnlZda31yeWAs5mVhp83A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DFr5QnQX; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-855b77783e9so30742739f.3
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740068144; x=1740672944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUWqvaHVKogMOF/6atNtzte45Y3jauGYwzzDI4g/w8k=;
        b=DFr5QnQXyYEPd/P77oAQwDRn1e/ZQJQKJinVIUPhD5MxOPM8vSDcY0GnpkSeok9HJ7
         WWJdjerSoYvzWtWwdKPXcIE2sZK65ntF2Dqf80F+GcVso2bOsxB4iG8ueiYLcPLG8NyX
         SMFuGCdU7U4k7eO1X6T39pOh9BhdWDl8zj4Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068144; x=1740672944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUWqvaHVKogMOF/6atNtzte45Y3jauGYwzzDI4g/w8k=;
        b=mJPxCEX5J3Hb9PBsVZ76Hs7PAaQF10Q8jX0rLRBWERYck/i4Si81pLG3pgPRNmmBPD
         ShMfOdWKR3v0pLPHaNJK3MTfHpszHfu7I5oYW4aoxbsyXiiLItg/9gtsMCDD4a+WJSZi
         pTq6ppQwN/+lWb06eLk+BZKNfMTBVoWZ2uyJq2wMK9fM2b/glKUxTqtFBsCaMWtk0CzT
         6nwnL+mreYSYty440y8AVQNENHsCPlDuaNWF5NHFEQ60dtJWwIVt7bRKZ/UUGPb1bwjP
         +JrTq1oFZqlbcSiZCL9PbhMKDqTmxMt3k7a/nhJN9a57lXdFqUwVcNsO0KFU9YQloCjW
         g00Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfRNpjhSLRF5/U3W8xEeRCJCfnDrBPw0FCE3vNwmZpF8zmdrQiX3v+GHh+cTCQdJkpSVXstvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3LkMAI3iw9TIYaZeo2R6RCqsa/wOdq+IFsnXuNFi5U37x5TrB
	Pbve10XVoE3Fe8Q4JAS6Zj8yaM3sm+sYsBhbVujEHm5nhYwgNwQh+87BS1Ywf2o=
X-Gm-Gg: ASbGncsXZHrr3/93qQctDdSV9c2wxusp+BexXGe+DloKBUVXTSyG60iYH+KrjageRVn
	ZBfbW1UpjAh1dng3RHqClGfDwycvpiZV+PaXtxxAPIaxro9A0tjSJgu8OYs6DhP2O58gFPC0Bx7
	t3GfbZh7m3rkgsJSNW9TYhHmAJ4WRiq5G4s3wVJDOcgNQ3IPFO4a+iurGIGCkU3nQxI6AA5T9iz
	PhtT/0CQ7FTx4aArKFKuxGbTYnky0bjy+RxSdtFIzszCIEJol+DKOsNSZP4q2MQXbI/iJythG3+
	KjvjnuQX0qSmuip88aFZI0FOPw==
X-Google-Smtp-Source: AGHT+IGQfgp9kEAPuFuJ3dTKK7tSi6LyAWjjoabJeKiSVbuCLsWQ1N+U8jlefoqgkObX2pN2M+3XKQ==
X-Received: by 2002:a05:6602:608e:b0:855:ab63:1b89 with SMTP id ca18e2360f4ac-855ab631f4bmr913625339f.11.1740068143751;
        Thu, 20 Feb 2025 08:15:43 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee9c71d225sm1983789173.122.2025.02.20.08.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:15:43 -0800 (PST)
Message-ID: <73312b28-c050-4cc6-8155-c5fbb5f285cf@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:15:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/578] 6.1.129-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 01:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 578 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.129-rc1.gz
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

