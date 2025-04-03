Return-Path: <stable+bounces-128160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35264A7B272
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 01:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C481898BD3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 23:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202A1AA1E8;
	Thu,  3 Apr 2025 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/+qSUb8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600551DF962;
	Thu,  3 Apr 2025 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743723745; cv=none; b=hiPSmG01UB60QE18YVKoOdx5OW6rBTKLhvMiL1l3lqQaAbroYQzkkjP7HD4x11LU/EsP/+MZNI1//OBO3WRSh6KhH9fZCoXMt8lbl9L/7s1XSC4ZtJB2eOrnj6uw8wsr31iLaAeorx5FLrv9qqV2yn+Yh4kvpzSjuJ+FoyGGHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743723745; c=relaxed/simple;
	bh=yh/q+rNbuMY+pjqhXUQxsMEdyj2/yn+4i7kWgkoPIHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlQGpkkmhWWraeD5r4snC7gqMaYoz9C82OISoSRYyI31sWKi/gE1A/FYPrpA++P9or7jD7RLXPqwkzax5SpyYOeHs05U/UrGXeg0mg0bLmcBEBZv80mBdzf45OQjtc3FoLzE7yIa8Jdn+o42u8rEnOwkNV/+b7aPPfbWEGB5NLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/+qSUb8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso9164355e9.0;
        Thu, 03 Apr 2025 16:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743723740; x=1744328540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wkvfKktpe28S/f4k8PkmwPjxQPAqeXSFXCgD7zEYhGs=;
        b=b/+qSUb862pNMtfxlnLogdByXGtI1huCsSqWIbZIQCFRttuVLN0aBMUYfYsMVxQQse
         iPOZsGX0t/kUw/iN983KeFUD5qi+FQDLOhE9573LuorrH11SCgmHSm5UQCCUK1h1Xw1V
         uDx0E1tQvTXmu29/+azctG0FAGJgTGOOF9WEVrEWWaZtadg18iG5PzNpRwxywHBIsm8/
         BNm4DcsDcfBpdDlsf8EVkVE8Z3o9UBQg9kIiX8b0q79KkEVNcE947hKSCEK+QREQQ9v3
         77nu5T5CpzUODAYDXRDc3ZM4WVJveS8Td8Xnt3ZxXeLNt42WrNnnxxz9H+ZaLqh6QnZj
         UhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743723740; x=1744328540;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkvfKktpe28S/f4k8PkmwPjxQPAqeXSFXCgD7zEYhGs=;
        b=aHEUJa3qw0YvPLWisegdS3PjzLEUPRAnnNkurF0ddKlItwDaQGHJM7F7VjkT/A3uJD
         EhXVkVKL77ctNFXjnyl2yU1tOJZIQOl1RH1w9aPYTQwP6SBuv6d8mBTtXpM5q7DSgecH
         oIhul2ELwK5Rk2NUJi1MHjnLOcmK42l1LNkG6xsI6106Erl51eeRQ3ZNgFVapAg0Tgj4
         FOSiSmhddag+si0ONc5EhQW5S9UopQn65AtSZ3qf6OYq2TurbLpmyAbUvzzOWlaQkRUw
         xBRdTX2L/fcbt9s4MSZwqWB82+nZUw0jwPRolAiNZfA0QY+IF/C7oSp+L7flUD1v3pUV
         yJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP/Kngq3gnx2eQqoAIc746nkn9KscX1pQ7n65fo1Pf6SW1kMzbAJKp0l1HX1WJnM3QdIxFf0V72Ygkfes=@vger.kernel.org, AJvYcCXJ17LQtiXRtIsqJhMCLFx5hsXl8SN3ostBgOhwjEk2V775JHiD8P5GLFFw3nAXasnR1Sy7f98d@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyQZqvc/RSntLklI1cyJyMWA0pG5b5/dOOg5lCWKtegKY2QiB
	FtGLwayIvtjl9AA5dSMx846YNnu5R30fAr+KqPSL9S8wOAD5Fqxo
X-Gm-Gg: ASbGnctU5zlwjet8vh4Yz6B+qzPu46XunESfbp8N5syMTtmjftyZ2QW2mf9PSA0bOei
	CuSO0RhVEJROCfkR/3NvUwj/jSsukoV6tLDO5FkOt5862hoiDWGh++6ISRrLsfKpEeGjo4Br4GL
	Vuf/LAieB7zwe5CJrhN0Icjd4ZMY6T2kclx4P3Qq/poCLw0+0sgelXaiI4bddUXp5tyRSwccKNj
	5fESK5mP9RZV8nW15F2AhBsDqGcnz+iUdJB7u8p3hmKWixen/+1RbcspsqERv0a/oPsuZXw3HzC
	Ooxc3dwhyQlZRykguzEAuHvwj2e04DIrnkyETmD4+jyJVMQ8Snm8mRPOvJE/OK+H6Eo04SkYaz3
	Yn/Uzc18=
X-Google-Smtp-Source: AGHT+IFiA2pBAmTCtik7KuYJ2FF48uRh3hnYs8IZzxfcylrhIqbygWG/yLUzCXuPw+peMrPhT3PzCg==
X-Received: by 2002:a05:600c:3b14:b0:43d:2313:7b4a with SMTP id 5b1f17b1804b1-43ed0b483e5mr5635875e9.3.1743723740455;
        Thu, 03 Apr 2025 16:42:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3009674bsm2949655f8f.3.2025.04.03.16.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 16:42:18 -0700 (PDT)
Message-ID: <8af84aa7-4353-4c33-b51d-1b4867742c05@gmail.com>
Date: Thu, 3 Apr 2025 16:42:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/22] 6.1.133-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250403151620.960551909@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250403151620.960551909@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 08:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.133 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.133-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

