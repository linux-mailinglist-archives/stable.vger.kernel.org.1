Return-Path: <stable+bounces-207909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FBFD0C164
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2FBE3061B15
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 19:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACCF28313D;
	Fri,  9 Jan 2026 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgp0vRU7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AD2E0405
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767987322; cv=none; b=Tf9PJcmjsbfXvaq4Uiio3C1k22D3hbtCb/26NQ+emnMp2csS6sH2nheXZgH6xJNT0IdIxKu/esrpk538VJ8ZVomDFqjdOv6iNkKvtHGBUcs3p/BZbf42LmyP1TflHL9z+e5D+IwzKaq2HWVAybQYyl/kLgo/4K4sWKq8OMNz17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767987322; c=relaxed/simple;
	bh=FoexX/zNtllKIA93si6dgUTvX1J2v7VkMvTvZgDZPlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uisH7BHU91adayEcztgdf32cMzcP0WI6ddxAq/j7WUlO8ULG9nknY04wcKs6EOdV9EsNbZF7atNatz4QScpZze7wyC/kauLSlMOWfxp9lZA4Yvn5KwHrKrl6KAXcXVGdf0t9rsDoU/aVweK2dIz6nyzSbId4i5deVFQK39s6qLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgp0vRU7; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8bb6a27d407so433325985a.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 11:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767987319; x=1768592119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rngID4frIYo+TaZBYopWqUq/ulJvr7+5m9Jxnfzzftw=;
        b=Lgp0vRU7d+w3NUOh/P0EXgDOKsyp/I7kWOZJGXcEu33KPLnVfR0AJfcsQEUmzuh56s
         TcXJrQhdbQ8ZgNZJ5uP57MJjnb7VI8ycGeVJDx8PkZPJ2NQpP5uWMS13u1tBK1U9X+KL
         rN1lL+Ji3hfP7HVqzIxJYz6Bhppb7y+C/+dNDZ8365ZRJvH+QuvPDb4FzvbPkC6GMkpx
         +LF8+ES+bt3a8WtINpVdllcnTqRUUDKPDN2GgY+5OJbBR4jxzlbqxx+4f1Ga4SmYldFD
         KuHOTC6lWNq8QP7muNxYNxXaXV/69xO+uajf4WYQ+UugPIQwQVpYk5vFT5ybQMRJ51Gq
         mPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767987319; x=1768592119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rngID4frIYo+TaZBYopWqUq/ulJvr7+5m9Jxnfzzftw=;
        b=rEeiBnpaGdcsVkV7XaHFa3DR3mUVis0+U6B2caOYJXZ3+dv19H8KpPF6FZUr+YFdEd
         bSJc07/14KapsmmkzdTpqW6Nx1Th40DaIY2613dldBTeRQHJ7jfzscFFDdMvQhJCwGCa
         OzDbFu6acflbo+9N/FVqLs3mWHowgVmUkzVv0GEJX1sFON9dufLbpxe3rLcWDnPOlEuc
         mG6arAhmGUzZwf5k97Q2+KVOj3twAYc1YiPckduDLa2a6zAOrlkfcOFvBAb9+QZtqPVf
         HcSnR6tjSI/6yuuBsq/JKhKH7TWzbsjt1aHIaFcuapruv/jV4Q7QIXVMCN+3iPJUx/E+
         yT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXe7sGv1tqq1QdnTbQ0m/OJChY7tHGDJ6G/9MpjD2B4Hxk9WBsL3dkv8WEUI4K+ICitv+Bl8Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ALcIVO8/Q2QfAW823UKl5sbgxoHgefIS9awB7VvQZicr/8wA
	4F0rmj+CFuaDrzQaEgvlFeRujbfLiXn7YDUJkTampB58Thn0XWrBLx8r
X-Gm-Gg: AY/fxX4o92Xm7neSX/K0eqc5f42S0TiYPeVcOt7IZ+5Mx/ybmoQ9AbjI2d3h1e7/Pgw
	bhlF/caXahMzXj1JEbQnwVc+RGhPP1/X44p3PIvITplFbSRSQ1eR/Z6wYpCTjWHgqhLwP323QeH
	6cqQqdrrotcc7jb1+5rElLyHrI/u2PpKDwVZ7F9LgDAunetaayfUJkAmg0j9UDUZJTRzcuGk9ar
	iMItCLsRv3VRId5P2RbQjkf9heueUql7i4YELlrOFe1zMIvTgTkoEWck91nANRQmbAYvkaSN57c
	BijUnyxttPMFaexYwgJzzaPkUxoFB6I32oOn3LUGSTfpDMahASB6LMhLAhZCcV1HxcX7PMgK+0w
	SjVPJJgPm/JCrQCfvFaQqeeXK71YXD9jRic3VoHbU1tphID57KjvIOvlwWB4ceOhoNSYmAsu5ZD
	Q9E4IB2Ndd1X4b3f3Ays5pOnVV8Rk7lmCowg6/og==
X-Google-Smtp-Source: AGHT+IGtlnhX+CYEaNovAoiK0mCDNf2F8U3QIJfiXIenC6fNEq7XFFbLlEe7OIs9mF9PA9LZOgiZGA==
X-Received: by 2002:a05:620a:2587:b0:8b2:db27:425e with SMTP id af79cd13be357-8c3893dcab2mr1377614485a.50.1767987319241;
        Fri, 09 Jan 2026 11:35:19 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a9a19sm890780085a.1.2026.01.09.11.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 11:35:18 -0800 (PST)
Message-ID: <62560a47-9e64-4c71-bb73-bc86ef6e9711@gmail.com>
Date: Fri, 9 Jan 2026 11:35:14 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/737] 6.6.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260109112133.973195406@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 03:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.120 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.120-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

