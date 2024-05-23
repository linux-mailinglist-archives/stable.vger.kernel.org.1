Return-Path: <stable+bounces-45994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A288CDB4F
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 22:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31AC281EF0
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C384A50;
	Thu, 23 May 2024 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIYe5b3C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE084D1D;
	Thu, 23 May 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716495707; cv=none; b=e4oJDvuYJs3KUzETUaKgPwggwoxKWA4Li8VD02OUlktM9Xq8PsIUB4WtltOO78xWS2FWOEcrW71EqpG8Ob3XBe7X+0tGxyMode/3w8foFtACvRZ+KzAtf6WUXj0dshtyaFfjrygG+onDx2cnMhepYxpG5+Ysx0tti2HXgiTM8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716495707; c=relaxed/simple;
	bh=xFPhAF+c5QEV3qf+5MftTNugrA1PKs9N2ZFb5mAFR8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be0zKfGM+ulmBGftPRx/ZuVudR/w8a+k7XbtbyWI96fcPaHYAmYy1ZwClwRLkX6B8dd3cwGdVBSkYRHcgSE9+IBbbDX/gHXiq2aN5Mksp26ZNVrFNIN3rM9KB1lyUW7EMhK3V3mw0OAV1rpTOTXMIQ0d5RqVIfdQHaSkQrzD6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIYe5b3C; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-681adefa33fso115747a12.3;
        Thu, 23 May 2024 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716495705; x=1717100505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLMUv+lcr/QWFTV4u1WTHn7mf8KnhpBd9b1FZrkGgZ0=;
        b=kIYe5b3CyktUYF/aBoMcxm+VVJt7Dxwuxog8SBPjaveGNt67Ts7iNaIUB6leXHA4z6
         mJq1ycKflQiH14uHDeUpbsa6FkTOJc/HADqr6osh0ZOsKkluloag3Bo+yrlggchCokHP
         N5Y1EW4wdabtK5WABURgQnq4ckFAyPxqBbD4mFZIHfSdrP70EYHFQjfQYzcYUhvpnOgd
         G7G2zC9+HBd05vJAYR3++L6T3tiZRkIcA+fIeWFRqBBXyJgQ1rOYzefWTaLuhKkf9mbQ
         1RBYOA9W41hFZskS2ncby0U/+f73f8nW67qyKSyZx4EhJeGi8dMFdwC5DJ2gNXPvokNy
         w0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716495705; x=1717100505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLMUv+lcr/QWFTV4u1WTHn7mf8KnhpBd9b1FZrkGgZ0=;
        b=DqaOPw7rxyfU5u/cU/ncWZEmuw52CkeH2FO0najvKbfg0pEGLTgj8DG6BMl/IUVTls
         5LxEuhJXpqpQBnkbYIjcE/U0F/s8leCBT0t0UR3WV2RaZrs/d2+BYdJGgjGVTodpvIsk
         ar+sKM3C7onb8Zr3q76AR6YQWTFBeHXqyhLrihRkUZUdn+5FQBwyzoBkzyXtdPyZBRmP
         DTB3bYSefG6XGwsxDrANkm2ZlvCfp+/DzQCdYXufNAMWU+3FhOMDEwu5XkvyMM5Buerd
         80U6xQ/WVsIwsV+jOMrxOFXa9nKvJwdagpJO5YySjtYox75WRQvE5sTHHlLCCDaZi4Wj
         87/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBoxFyUP26TggESYGH/WyZu5mGtDEs0PI51fxHt2NmgoozSvjKVDdLXLTKuXakaz9WxvqIUtfWRlpESEKcTzZTMCKB5vQHp/TH3Qx8Na8pp3SgW7KdJK3zd/e0HI7QXuWqkvaF
X-Gm-Message-State: AOJu0YyvJ/lHGxFTKZwPn0FCUt0gaKeq13NYlaZ/D0pockhbtWA3EKJe
	phNrvWS1hJYP8mgLrJit7RI87uPIqAa3nxzzxhpuCLKS8hsFiMPo
X-Google-Smtp-Source: AGHT+IEP+8/4v7Ac4RENllwAWNIDui9pwuOgSmeJ+NMPaISNVgjis+faohHNev+cfODhvoMJ+MS4yg==
X-Received: by 2002:a17:90a:c082:b0:2b4:329e:e373 with SMTP id 98e67ed59e1d1-2bf5e84a9d7mr284563a91.6.1716495705402;
        Thu, 23 May 2024 13:21:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ef2182sm1961359a91.13.2024.05.23.13.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 13:21:44 -0700 (PDT)
Message-ID: <a994f8ce-2c3f-4aa6-b345-bb443b133804@gmail.com>
Date: Thu, 23 May 2024 13:21:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/45] 6.1.92-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240523130332.496202557@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 06:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.92 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.92-rc1.gz
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


