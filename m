Return-Path: <stable+bounces-91745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD5B9BFC87
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 03:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061BC283182
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 02:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7364D38DC8;
	Thu,  7 Nov 2024 02:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EbBlB+C6"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2173335B5
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946437; cv=none; b=DE0c8ZVYMxp+gOKLzJHbRZ4/1sY+AI3kx3jO1fIaXTqmnncTNsQOXS84GhNA29WiYgPwdDJPPkrE0gOHG0aqN5orD6lMg1xHQXs5ACthLLGW6M8xB6XU5vsufe86RH5bfKAHc7CJxPliXsnfnMvWhAEShqdSvoSySMZRYN7QuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946437; c=relaxed/simple;
	bh=66r6xIbtsr7gOmnkCVDORMzU1xLzP2MTzmFr5wrTId4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F56NN1FYJ3l3zwpNWx1SuBD07URNXSb9PFJkWHQpZRFxQzNrUqgBbsFStHT0pFBoyH0yYR8MV8wFcltA3yNfUyAsYizfjnp543aPHUtwIycSjGyOd13KsdFKm2u8uDN2GpEw2WXmZwVsD4wO9XJw/ulPW4aE+wwmTxbJuW4rfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EbBlB+C6; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a4e5e57678so5079035ab.1
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 18:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730946435; x=1731551235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FH1qWWHPqfjxtFSCDAPzAW+vNNLwYck5jhkRuC++H4=;
        b=EbBlB+C6mf7iHciSZRpTrepmxQbxceALYBc0Ul39MsefmAqq0ovSsUNmJe9c8DudFD
         8ubTGLqbC7ZxqFLIW+l0avl/RodIQvw+eQATbnuya+CtxxpEKOW14mHemAEro6JaB4LK
         bRk9RAgMTXWudfuFhVXkJHX1Wmx4oEMHy6j70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730946435; x=1731551235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FH1qWWHPqfjxtFSCDAPzAW+vNNLwYck5jhkRuC++H4=;
        b=qHd9Er0vPTT/4MgpyKt/OdAgZx8iPGs8oZD2ak67ZG3AYgrdCDdS55QBVT8fnf4OYv
         prMv9ilPCTHaMwqaTNOWNfWr1Z8BaohkBvNt5arncY0piDdoySgpAUvuWPrbYyZlr2xI
         yg2Sq2K3ZnQLzlDGFyMpaaa852nirrlGh2ux0ToNwrg1Jd8+ivKUIA9Oo45aNCXfW58u
         EyJAj70jozxb1ljEvCtVTUHAhFpJulS6ZvhdV/RObZ+mfauDPWS8E1bjlBXMawVO71Yn
         arw2cG2XJoJAVZNUMSts2VZxJThTf1v3BzhhWHzQk/zgC0ubmmJ2mkZKFmKJkdQZ3gRj
         Q82g==
X-Forwarded-Encrypted: i=1; AJvYcCUf7aWZPJbZcoAOiTInWUnECML0g2HYvYjXhbW1BYttCuAhlNS7mowV7vHAkGCr+Jr4DN4ShRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8vMCRlBdvRifOP/hvO7pucX5CHudrSaOQ/BLKcCVRJiZc7MJ
	2KCK8j/t3D4e5oI1PE8NTpAUpYQlQVmyFNVsorNO61waeUWZr8Py5SzQpVGEjJY=
X-Google-Smtp-Source: AGHT+IESzjzRALUubFg8iGwDGC3CrFswWkMFRdL0oHQ8Pifeb0Ths28JWJDs7h8xJNjRe6OJO4cxpg==
X-Received: by 2002:a05:6e02:1808:b0:3a1:a2b4:6665 with SMTP id e9e14a558f8ab-3a6e8964e55mr14571395ab.12.1730946434806;
        Wed, 06 Nov 2024 18:27:14 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eacaa0f5sm736305ab.29.2024.11.06.18.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:27:14 -0800 (PST)
Message-ID: <0f9b8729-67d6-43ee-a484-4f58bd08ecc0@linuxfoundation.org>
Date: Wed, 6 Nov 2024 19:27:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/151] 6.6.60-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 05:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.60 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.60-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

