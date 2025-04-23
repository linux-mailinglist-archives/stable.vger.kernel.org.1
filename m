Return-Path: <stable+bounces-136485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8D4A99A97
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 23:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB18C4618DD
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497471C3BEB;
	Wed, 23 Apr 2025 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T407grr8"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536F242D79
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442931; cv=none; b=DK0M+ax8CZ66MPhKc7XSBLHH11PrSi64ZwTGdLC8yzYlP3+dY76Wg6prXPvcecmVcTkVYdtTALrGBVkuMP1KVo45YfAAOa7AwGu8y6SV66JWudaVDAAtm36M5irL1zDLqe8YfP3algyxdalvbvxWtIMKgr5lF1S6Ealw6qAsnw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442931; c=relaxed/simple;
	bh=3wg5ZZBKnTg2ncyGfVaRhOLARfZpulIN3duBvh+GAG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGro6PeHM6zB9MYeKH2302C0ZZdgb7Hh6lot+PaZbZzMsc33fmO33Ha5OQOorjXszzwti5+efgC5Yg7l3xpODOsWL79/YUdLIn65hL1d+v0eETNs1ZsNtCuAavuU8SlDFMPvRiTSoaJiMFLaIUaNZbkITCPHNje6GiYi1Cw8M0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T407grr8; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d450154245so2698655ab.2
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745442928; x=1746047728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9b74JLWsSCMyjNH83DE/ETA732OO42vrMEekT3J9SKg=;
        b=T407grr8ZE6KuuGnnPCMtmSaMJVSGlHMgCu2xyw+Cp0zYHDDPN+zjwH2vQpl0BnK03
         jlroBOT4KGuHO8HaC+6qn2TwgS93kV1ZfoblTw/owd0Jol9UDWmdFBPxE4M34dRsdYTz
         KR79Egq1GyCpp+OKbuKPWzwnYJACW3KrfsNr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745442928; x=1746047728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9b74JLWsSCMyjNH83DE/ETA732OO42vrMEekT3J9SKg=;
        b=GMD/mssHNLpsgzCzpStorPUBfrvP9IgUCMtxb0xpXjCc6Wi+BQpy5djZAcgnSQFjpJ
         hrb1K0Jd3fIkU0P47qYBU2m1HM8cxKnCFrE8nbKpt3NUa9I9K2qD3HATtI4k34x23s8t
         LTKCAkMg1gQUrzoXuP/xWejv2KQwBkTNqEfUltUuzrvkzm+TjYk6MwRisqlRA/i/Olxx
         5D39UfXpNwjn/5RAzr1dV333wcQBZhB8sg2GHjy022yQ1phrdvTWGk5l1DW+L4ga0zE4
         icRuBfP0l6t4UFfdguWSD4VTEokj5cErpfEvIYXs+Cl2qfCJwU/b65IzURi0ma8BS2mI
         M6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1GqFoay0dwdGNtlavXI8APHnI2Uvc2ejZQQsUYSR3oZPlucf8PPcKNX9IGQ13swC5qv0CvqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDk6SdA8GlaUkm4mdGxky08/8Xt0X7v8BOnML7ceNsKS9TnQN0
	StGNYCKy1lP6X9FN53RnOgH/PQSwyRW/D302rsY2gi9PoG2quGbHqwB1bwtvssc=
X-Gm-Gg: ASbGncsGgP5eLebuleB6mJ3v222zeyNPJ5aGJSkCw7CQaBQ7xKIK8OtESDc7hSGtmZm
	ngIIk2St3+GSWZm3x3UGod4bHF9vga0Z9O0U0hkMV+WA3l2qcY+wBpOBL0DCWSAFMNlhiFbL7Ip
	2BdC2wxEv4/J2Wm2dog9jcslU8ry8NlcDECOF0eRWfTfq4r62FmsnPv8tuY1fnb5MG01wIlymgj
	AWnBQx1DuXkKj3W6SrqRAOt5hoIl/6vNm/MK2qsjdRIn361KDFtWTNBUh/AWkl7qJeDKiCw09oE
	8Hz6v3gqS/H1F+n5gO9ZxAnHSEP3YyjG0E2bNMysS3/4+zyHBn8=
X-Google-Smtp-Source: AGHT+IFDN0xZmCbclTEpZ4bYvv9YC8mSFQM8qjVUhB6DvAy9T+2/8p/39df5wnTMEJTBducPcLAdJw==
X-Received: by 2002:a05:6e02:3c87:b0:3d8:1e96:1f0 with SMTP id e9e14a558f8ab-3d930422374mr1767695ab.20.1745442928314;
        Wed, 23 Apr 2025 14:15:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3955530sm2920111173.106.2025.04.23.14.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 14:15:27 -0700 (PDT)
Message-ID: <f26e49f8-1b0a-4aed-b322-4243c4687e5a@linuxfoundation.org>
Date: Wed, 23 Apr 2025 15:15:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/393] 6.6.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/25 08:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.88 release.
> There are 393 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.88-rc1.gz
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

