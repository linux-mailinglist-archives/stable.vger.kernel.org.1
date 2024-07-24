Return-Path: <stable+bounces-61297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEECA93B36D
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730931F211E3
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9D215B10B;
	Wed, 24 Jul 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TJ6JKi9i"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164115ADB1
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834010; cv=none; b=WMVG6kz3LpwojdT7z40n5mrGOT1tm1SXwzun0xfCJwUzNRxu/Q7VaocW+C+a5v1cys/m447HW1Rbj+Wv1H8oDgUFFJLQuogb7EgkWZmmJT0dubKtUZXPU6D5TBt6ckxqW1MW9Yop0wA1snKuj5DguHJXq1Vn151FXNkPYeCo0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834010; c=relaxed/simple;
	bh=PiKiMeVMpEMyORv6wqPxrhhwhf+nk3ai60FMDdvmZ1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSDBT9GRnpkk47REc0ekR6NnILcYzdofpt/OR9d2m4MjC/t5N6wmA9MnilwWZDecjhONpS26vJUbVLhPG9otufI+IKM6FeZ0Y4A1koSjLl8qjoN96NoeVskBj8oCk3QAnvpLuW63xwm/iarAnHf7sIn3W26d9IA4Dt9sbM8RBRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TJ6JKi9i; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8045e14c32bso37130639f.2
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721834008; x=1722438808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izbTRiVUnoJj8uduUMVBVNFl+ePHNjaDWB/ZfOAgS4E=;
        b=TJ6JKi9iQJVUxs0EFmjWEzM78cnzWJHZxwBzCjAX447wR6C73fptg8q8CsQ+RHvp24
         LXMZjDLc7IS5N0SBXwlFvo5KgoDPk88++JGII9tkb4+CqEd+wWYJUrkPLX/ymWJRvaMT
         tvXNeJY20E1a7WQ9m1lvN06nSekJ/htyqxafA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834008; x=1722438808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izbTRiVUnoJj8uduUMVBVNFl+ePHNjaDWB/ZfOAgS4E=;
        b=ayfeRc4HkmZ8ALsOr0+xwxMQer/DTvIc6ObIL4WOV2UvGFACC7T+KynXSLnrPrI+nx
         oBvcU7V+InvoBGPJfJBsYSOCB8qZ4TGjDJRcJZ5DuuL3MuvcasA37EAVhC96c2ooS3P1
         VLZCOBft2785JCmWCPbKcDuklvJExa5gzCXq+o0SHyXlGm0Rx0Jf6iOwHVtB5YfTc3J1
         7tc7+z3+pMvfEgv1vQO9aNWV3niG7yFBkTK9zmAEH0Y+uRzZt6v3ET1udaPYci4qPrUr
         Ebnt+sXHBy77f1MwyOVnD5NlfPCMSZmWHSF8NYsWGWSvM6JnV/dlheP++axgBiQ0PNXm
         C/WA==
X-Forwarded-Encrypted: i=1; AJvYcCUrVhr/F43HEMRl2r0lJQqIq96SJkIhjNuVhgIedZXJ4eri4mw+NfKBqMobScHRbFLgJH6fOwqFjWcpmf0wBShqVc4+mGJC
X-Gm-Message-State: AOJu0YzXY2CnU39x3790mLU1tqbQWi69eE73+FMKaegZyou/rg9c0480
	cXqgfVeszUeWj86/lZ11w+tYdSx5/JCa3FDX3dT9HNqk/VneJf90P41LTs2vqmw=
X-Google-Smtp-Source: AGHT+IEUr2/8iC/dgeBTNLSWyU1KAMScdHfHVYW03/ZVZBKEuh831Prbb8KLZ6d9w3RyRON2TbDAvQ==
X-Received: by 2002:a5d:9f5a:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-81f7bc78dfemr13570839f.0.1721834007941;
        Wed, 24 Jul 2024 08:13:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7158d724sm53731839f.1.2024.07.24.08.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:13:27 -0700 (PDT)
Message-ID: <671007f2-d57e-49b1-91af-a4e693f11ac5@linuxfoundation.org>
Date: Wed, 24 Jul 2024 09:13:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 00/11] 6.10.1-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240723122838.406690588@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240723122838.406690588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 06:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 12:28:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.1-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

