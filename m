Return-Path: <stable+bounces-163150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 306EFB077B5
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0D15845C0
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E5224B0E;
	Wed, 16 Jul 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TclcVioV"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72221223DE9
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675193; cv=none; b=RT1DzBuaQOZ2XRRuT93xlIHE2LmCkLk1erIdwKT4R31kpRnVWllYZJCj0F/RlYHcpmM1/8cLJNGNHRgrTkhTPYXyWlU2fE2rDV1a+AWjYGPe/M5Kx0PBhb/tmsXe1mV+1vhe0m1hNurvFHe+pW1uzlvId1hay3Hhu5m/fLFuAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675193; c=relaxed/simple;
	bh=9KP0i5+cSVpJWMEJF5cFZAgK0HCmNuvp123htV7QtDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHR2X9SWMWdFjNgZ8QK6RdvNxNVFiDU3qowkxNYqEjGE+6PVZ7+46lsqx/6h7B02w2jiCxaV9oJuidtWvpqeBKrZMV6EB4JgB3C+uaNLrH7Mw8zZsJ87Jfx9z9d/GirXjac3T81w+CDW8qptUV9ciTAEwvE9j0TPRkSf7XitQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TclcVioV; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-87a5603a8bdso4550139f.3
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752675190; x=1753279990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cun1QCF/ovodSSiSCrQbvW5XijyHxrC79EnA8g2Zp1s=;
        b=TclcVioVkC1TpjeqndyPAhPcxi4sSYMVv5mt/pbwm85+p0FCTHjyt/CHBodSXpM2on
         IvWOgYcME+kT243dtm6UWq1GjGmiJs7+ZVTSRQGcZmvhy6vDv7ApBtamkwjOqvX7CRn0
         45Fo8mZzAYjN8er1oduAyNWzDXyRy1nOEPdBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675190; x=1753279990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cun1QCF/ovodSSiSCrQbvW5XijyHxrC79EnA8g2Zp1s=;
        b=EtDpD1VHp1zHGWS+A528iLSLt39Emfz8r5rzNgRAVBhoM1FUSGQ03t00ALVjlFn0zh
         fCcJg8lshLjeMgops0IoWKeXvd19Bfwht1H6FpF/ZQpX8QBaTjjOXWOJkA350V5OlQRW
         ghugul0emB0syt31iAuOIvkHobe/7BWHdN/zVJiiVGhj+/VmZF9UrFUZ8s5NJzvxRnVf
         7o54HGGMGPZcFXwtaEGrJXcZY5SMXAAdH28OQRFlBD/ZQxukMfBDj1oJldAHBEiE/V48
         CwFru7DgEFEm50FhWvQN8Jac0snncMfQl63Q8ichMHRDjBalGcP+p7HqWOLd9WTuM1F+
         qfNw==
X-Forwarded-Encrypted: i=1; AJvYcCWkb0vrAR/uIUCherWitmtxTWm1DZJDjjfMXIX4btjRbJONvBKBrTzZj2aJXJ3B07TrTlLemnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGHI+EMO333fi2pyQ7Kb8PzA1HHleLvLMketadAi0BbLfiM64
	7edySC6hSFBA5dg5ZXqgjSiGOIuZmVWMkermTyqpXCJx2JKEbtRKhg2UIDpF9ISdJyE=
X-Gm-Gg: ASbGncugtcgrVWvp6MXgDjq0Kss6O3r0F0E/DVkkEHCamZdB3y7WSUUVZhFJwYDDLvO
	bLnqpsjHbpqtDhTx8AdOaUTUl4BRsB3mo2QCvJk4ctrU500Pe8J4sfLJdGsYEptr55sK/9Jor3X
	TX5Yy9SSbHCE9OoD1cQPOP8AQsImkDyd2NRQF8Njl0HQuLH6/Fse6CGWzsU+RKRPfsd/AtlDVQ5
	T9xT124Xfn01VvM1qXmTlLbBaIZJ2wIwUFtDib+8lf7wgeZmpxFE8K29jRiyrZNiuhFvWn+xIpR
	/VvDGQtneXEzyZ6t5miuHurnZgyIPOBTTHlyINZVpSATEcdDmETxjNBNukfG3ha5JCrMazUaRid
	0BClQs/U80QhPp1PXDNu2buhD5CINhxrYSw==
X-Google-Smtp-Source: AGHT+IHpKFuCwjn3ngh9585q+QxCCdOLt8vZn2f2O2xTlcTneZ9nwwto9RRUsv4jwjnpkK+gfLiGFA==
X-Received: by 2002:a05:6602:a019:b0:86d:5b7:5a42 with SMTP id ca18e2360f4ac-879c08a606emr438776939f.4.1752675190609;
        Wed, 16 Jul 2025 07:13:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556595731sm3062897173.42.2025.07.16.07.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:13:10 -0700 (PDT)
Message-ID: <481a8e7a-19d8-48f8-84bb-5a2a78b0e815@linuxfoundation.org>
Date: Wed, 16 Jul 2025 08:13:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.7-rc1.gz
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

