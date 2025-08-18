Return-Path: <stable+bounces-171651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB225B2B221
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD519646C9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 20:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C6272E60;
	Mon, 18 Aug 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zp1zUkKp"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3426B2D7
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547984; cv=none; b=lUWpoJMIk8mOQXsa5g5/MEmen+VodSPpnLmvZ/an70K3QDN1nKNViZJTg4PjoCeJhdg28QAmC71ErWeF5SWXbehK74Ouvw9jB9E3Stx+I/RkQ65Y7dGiYLuH47l/VZPDRiZd1UfEtZdYz1jZnMz41N8DdhUZaXmjvXH3M+Hg6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547984; c=relaxed/simple;
	bh=VAjCSTlcEEGZlPyyXMdHvI7J32g8GhLs3Msg9ipZ2NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfvDw+kPZcEs3ZBhyfBEBSqtc3hrhUpBOarQR1tsQEdsr8hPPGDrucX9EkZ03NuXxDXiX58ewHrFMgAYqgQY6a4tM05nHwgkMJSBSsYY3GV46U+jBELtL1YbfpoaUPYiAENwC8CUSkdjErpxR6VPoeEBszXv7sQkT1KOeJBdtNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zp1zUkKp; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88432e1b264so33427839f.2
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755547981; x=1756152781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRl3ccManntYJKAwiaCT/1BaRhYkoYTuAWYVQSgG0/I=;
        b=Zp1zUkKpaljOSPyhUiyg/AxM51hf3GwX+THI43wkkwglf4eEBk5QbfOM+hPLkIiKd4
         hvEI9qP93/XvEI58Hv5r85NmvdUeuYKKv93FKURkiD+AgmyEfXV3ngYOuW+4BzFCYVuf
         wdGczBUbMRw3R5Q4rPw6KEE+EmyhlVee6cxTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755547981; x=1756152781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRl3ccManntYJKAwiaCT/1BaRhYkoYTuAWYVQSgG0/I=;
        b=xQyzF4t6CEC3mlkdyjwzfGcjDXj/797osySeAwneeo5TJNtBrF/HeBMJ9Vek/IyxxD
         725Sb2XyAYRpV9SjbYXFv1LHsd24EkBOIfhI8lJ7tPusUgyrFhqR7EeovJuy/CQyua3l
         3F/jR0vrQ1jAGJFTdWhGAu8e0VvrEislk6jta6T49b2hR8M1ZCs/34ITmXDI9GmXciFv
         OVdzYXw/P2HJ+ZRHVfY/g19sbxtABLfG8BpBNwUdtHADe0u9XtwLU/3SAEba6HBiSRNJ
         6Jr4ylC600MUMVc2L8B/cBK7o7YLMVe2kqHA8A42qrRoVJ0TZiedfm/lwqXv6vq8wVMt
         xhow==
X-Forwarded-Encrypted: i=1; AJvYcCVRvdTs0fPJWJOFN0P+ZayMjSQ8tdsoeRbrLj2nOcqJSDcodPV7fB1wMzDOPwM7JlGmXTWhaew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MndNVwJveas9f84jKRqTp1YkOmkdqqUQfkQCJkXfNHRLfwCK
	vYmVO6uHyXSZV8JqIBt7dMBzF8zwx22bH4EDTo3BnpczCrruVZ2EdMOg6v99PFqOMmI=
X-Gm-Gg: ASbGncuq9Ocd74864nQdk82Kc+9Vc+OaBWOYiHKmE4jgnpu45j2Sq1slOc5aokh45mB
	YXt0VzzZdn4iWXfaLauZA8M6CZo8eT2ZM1PuHMxw+FzuxoHvUJHqRpJfNQviXZ01ht6PPrRrths
	aMRYtvExiIULGQ4LDF4JQxUHZYPfeqkvZuLeCNfq09uy2m8jHwxuPAu+yvNQ3l8IcMWUmtROaly
	MuBh5LyBWHA+5X5xPblUCCUmRfO35UaBbDyKUzp1eTVWuYj6YMyydne836s/YIXzbKM4w5CJfoq
	bx1ht4pQvm/yKUh+Nbz/VIZLBBj45ApczCwvMnSfYLebV1t4igZ8nCeEGJbMWN8VCzMV4h4RjNU
	DTnCBk7ZYNECizBc1a42LMrumSG7BIkJrnQs=
X-Google-Smtp-Source: AGHT+IGjlhq7sguM+xWvT5IQPoezITIl1RzzNEuyUyPKDhMsTlph7rxOfo7GdwLsAfa+UZYwBXDIyQ==
X-Received: by 2002:a05:6602:2b8e:b0:86c:f3aa:8199 with SMTP id ca18e2360f4ac-88467024bf4mr102010639f.11.1755547981176;
        Mon, 18 Aug 2025 13:13:01 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f8522b7sm336762039f.13.2025.08.18.13.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:13:00 -0700 (PDT)
Message-ID: <d9476fd1-2ad1-4dca-8f97-342c9f781d3a@linuxfoundation.org>
Date: Mon, 18 Aug 2025 14:12:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/515] 6.15.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 06:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.11 release.
> There are 515 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

