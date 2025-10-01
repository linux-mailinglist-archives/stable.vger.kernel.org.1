Return-Path: <stable+bounces-182966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 273B0BB1338
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF39D1946F7F
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3A5284896;
	Wed,  1 Oct 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E0R/kTgH"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807748C1F
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334581; cv=none; b=cvWkiZwzPoPnn3RY36fM1OjE6BRHA7S0qCEQvZo1w2FMLJkxClWVtW8Z3yuqJfAeK0giF4L+WCWNAHf7I7slnnVPw9Otf0c+EKg+v0hwe1+HSioOFU9Ec5NX82CTD6gapyx52Kk/ZZbjuXNNOUFz0/yLX1SGom1191Zj7dkmhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334581; c=relaxed/simple;
	bh=TN08qxdXNdkLvHt7/wPIeKRCTg39xHBh9iRLNP8f/0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsJpiXnJTU5akZYVlAyALdmLDyu/ZnlUuQFjYpWQu35FfJScwe2PICOTBDBeZuJbNwEU5XBPArzN2VWMV/bgsn06lR42bu9eidUFvjvPSsNpy00ZoZNIBfAikRYM7Dwq0mKDBIJPVTFpwfl+JpPbKC0rDT8dTpi1slC+VR8lMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E0R/kTgH; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-90a0b3ddebeso268425039f.0
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759334578; x=1759939378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mR7FRFOp6wmlPMEQNaFmkailzNE5Cfn80QOSCcb0KCo=;
        b=E0R/kTgHxpLkyrt4yUSiAeFWWyXWZtmj9ZIf+HZj3yDe1ajLIEe5K2SxWAMrYqALzW
         1QaHyQhhIINflIce957p9hW76GhH1IfkWZ2f/D/VXTRvUMgRGvEXzhGp+Cy5yATVhgTz
         6HVqCynY1ug9VEBnixyo891fhHyLGU2JXo9j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334578; x=1759939378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mR7FRFOp6wmlPMEQNaFmkailzNE5Cfn80QOSCcb0KCo=;
        b=MoawPw5TZS6JXEuGf3fDlqpUYVeyl9Wz2oykPx1+ncUu4LiAe/iAO81ScuMrZXwrK3
         EU3UNE0LBrfC57f46DYSNiSnrLz9YvY6YOu0K/Nh1A6cM18pFfG9BJiZe+mtp3Y4SkH3
         FXBA/abJT+M98FA+5nG9yFWzwHdlaXgdM5PKFmv7+dPCCpdzJ1f4XyP0HJ1Fo05TmMCF
         Iiws0r6+rzAO6Uzo3sXEIEcOEtp2/+z8zHbm/Ye8laZiMq7y2a32MQNVyRY37uTFNyxB
         aigJd+Glv9fM8ry/6TjyAHUAgn+JBuk/aVhWBVZ4KKuH1iOfGKPdKevXvwIwX/MQAihU
         UoLg==
X-Forwarded-Encrypted: i=1; AJvYcCUnNfMy9l5vRRKJAt1zw2gzRYLoF8uDu5pW7WwafSlm7Ib1Mzc792CsTJ5k4MjrY53n3VaEsD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy48vDQv//OwGAl8doeH/qFcYkJCBSzUDih9MeHHwPpS8pkp3J8
	TqIE3Q7+0h62B2huAyDobdgUW34LUmoIp3TV+rgfs6O9sC2eSRKJkIdGeyXV1ydhe8Q=
X-Gm-Gg: ASbGnct+1Wamxt+QxL0yNVPdxsZLIRGU1F+sRAQAZGxtF9ctCE4YEtsxVlzCQnlOdfG
	tMjrFGr09lpqj6y8ZAg1h9KPwORwn0yZ2BmbZmWBbI5hT/SjzPxxjpLaGRuzfEz2/wsT7SBaqHX
	79NJOYE7dTWrTt61ZYTD3AASrkkwaR1Vy3p4/Cx+hnSSs0TZtKCtdI0lZ9sVoiKn1AInPkM6B12
	KcP7LRMFIpN1EFAZIVPxW9lFr6UPmpRUEaWKihQX8+CQh+PRbt4YMWnx5OYamW+3kgEOc+wJF9f
	LTR88x5KKANRb6qa1tuRLRW5OgOHE78OxBRy9z2r+QhPLbZsLKq6zf2CTiDBCQOey6pFqGp+NoR
	ZvfT48SZDacnvGtJIv1aM4mTjJEtqhel83+LA6ZV45YfKp5Iyrzc7EGoXH/c=
X-Google-Smtp-Source: AGHT+IHgdySDqIv8Jt6z7mJDygOJ39o7HwA2I1QtCXMXZ8x1/OJj6ga6XsCXSQpUzQE8TPPwtX9h9A==
X-Received: by 2002:a05:6602:26c7:b0:92a:4e19:197d with SMTP id ca18e2360f4ac-937a70f0ef2mr638019939f.4.1759334575525;
        Wed, 01 Oct 2025 09:02:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5764f341b2esm2373807173.0.2025.10.01.09.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:02:54 -0700 (PDT)
Message-ID: <111e47e1-b03f-4d24-a234-0d64c2792447@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:02:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

