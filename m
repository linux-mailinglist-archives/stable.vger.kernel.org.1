Return-Path: <stable+bounces-191518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04717C15FBA
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0128B356051
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C176F33DEE8;
	Tue, 28 Oct 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7AiJ2Vm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB243396FD
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670600; cv=none; b=EL3iMaYqFMKJXyxDw8Dm7fY6WDAhbJ/Y/KDX7Z6S8H6xCILQ6Ti9Du3zPS5LfB7qcer+WmXdPQlrx3c0+XKAp0wn4YeJ2/4+6H6BRTehzx63DU2iUpcjihI9/SfJ3EJcA/iECBZHx1G8RWcylxGZhxts8NlPwr7bZ5nBLE2etVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670600; c=relaxed/simple;
	bh=p6RyFVKNQkIaQ4ZcnL2+jkSmewms8zqCNQv3TST4Jn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiUlEUd2HgFZJbkH3elhHYBhhs5hyYCfSdLneGrkaEJ6uXbrR4RgT+78+Xk5g/SU9SvsTxDU9n0nMsuKlWCXiKYZZN2YCQ1/GI8vxzdvMoAheEjEzZzMnB9ge/lRlGLtuQeVHSBX81myb6CgDUEboNl5Xbgyo4Jj5YP/p2WTGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7AiJ2Vm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47114a40161so70123905e9.3
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670596; x=1762275396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWB3SgEBP2sW+IMp9VjTcvHlAHIvY8hohrCBcP8MjQI=;
        b=j7AiJ2VmQ5qcCj2/XwGuPPWrQWk8EeOVeRKM5Vpm1kcqj+fJ82nfhNPNCZvEb+gwW4
         YDyrhbNUIySdvb1NnTsxn0v4BLGJ0ej2Vh26Y/HCz+qTno9HlAVquHD+kN+P+qV9dHRQ
         4//C9L8JdnWS2yYN/oQgIXTR3MQUafRdwvk+Pi7NbZl12egs5OI4VAgOQEYmxBBtIWsn
         ub01fHBF81cpM537/I8m1etOTD5tE6AuGi4fmBG+vuoMYjAWNijB7dWkQ/t6E1OHsw7h
         lO7PErcsIPe+SckMfqpYpuzqlg1p2667beolctEXPJjqwfHHyHiEV8N29qaSZTi6KoJ6
         B2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670596; x=1762275396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWB3SgEBP2sW+IMp9VjTcvHlAHIvY8hohrCBcP8MjQI=;
        b=lbFS5mOCYWLsuh2y7oV8XPa5mjU0qcYv5q3KqAQpGShYDYiVlzKPvx/9Ze19Xf0OmC
         6yqXdLw9uT60lPZDOy0anj+fx4FcYTbNQJjBQilBndrbdyR3Q5BPpxRmjlQzwMDw+2B2
         2+mWHkroDlN/x2Y4udp+viV1a1oo0RmO/RyxXUBnAUMqs+0bLdrbOHkhM8WPgo64+ga/
         I70y+Toa3+tTkgjCGPutret2NHH4cIm7RVAfFpzZnvf1ehGyP2cnc4SJcv6gfJTnCgV2
         SYhwW7/M89lXHU3cFqt3arJ5Km3jN3yfr6lGeJtHL7ksnL3bFoUy0g0p+J2LUge0iFN6
         PHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt/1MGr2JHIeq2b4yaXZ0FRHF/pkmDsRSUnLFpsiUXzTPnqps8Ot4ZRUhlcVDX2ewpgu8bFq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/ZcNWMSJF0sJxfPorbKj/MFhbtxB4mE3T4AsGW8id7bQ45ZX
	crL/GhQFmqbidGE4ckwH+T8G+LJQ2hGECkxQYFeFvDZXRjTdzGVhvQES
X-Gm-Gg: ASbGncsoEcdL5qehzsrrpDIuHXBBIaUd2whC2rF8RjVIu7tcsYCtRTdW+Rc+3QGTiB0
	wV2HgJ/YDibIfkKwSE8NZ7oXBk840MfOf57D5nOAyEYKUn/jkjz6u2uUx9kUEuJ6JxIYbCaDY+8
	bfqTLkZBYLi4vumzgVhvDY74O9MPMOl00E0THDm+WU68OXGL3vZ7vj2+RBeHJqR2Gkbd7Dte/0/
	DHM6lCoSgBsdbw6xmwVbAT+1rA3FPUx0PUxEUzHwp0njVWa13SKS7T1axQ0l40pz3XwrXUfllJm
	E2DKzhGe5uz0Bi857PD0JrvDlolJrS/oS2btZwV7AJ5o7YV5m5OR044qVZQsulL+PwBI9IKw2bo
	BOQIaJmUpkWLpR34jwB4Fdkz7oVoHaZ2OpfF3jopkuT0E11McsbaN6XLZP7VMvNrz1aWLtBclsD
	hprD4pgodjbzfbUxKimu7vE5M7CKg=
X-Google-Smtp-Source: AGHT+IGzGR4B0wLNVXJkWpJi+gf0J9ZLmHxgn1i3xJss3GSWwRHMfKatObo/0+gt1zOBw+J/Okn6YQ==
X-Received: by 2002:a05:600d:435c:b0:46f:b42e:e39e with SMTP id 5b1f17b1804b1-4771e3cb792mr378315e9.39.1761670595796;
        Tue, 28 Oct 2025 09:56:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df473sm21333826f8f.42.2025.10.28.09.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 09:56:35 -0700 (PDT)
Message-ID: <3c1dfe1c-a1bc-4873-9c5c-4f9904888194@gmail.com>
Date: Tue, 28 Oct 2025 09:56:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/117] 5.15.196-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251028092823.507383588@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251028092823.507383588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 02:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Oct 2025 09:28:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.196-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

