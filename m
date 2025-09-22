Return-Path: <stable+bounces-181417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E0B93872
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 01:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57541897CE8
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FAD27B34C;
	Mon, 22 Sep 2025 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJCBA03D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AA242917
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582071; cv=none; b=cT7EIUPIvj/rAlJZLNvbwcNtS1w/5FGaGqrRMFd7uoIiMaDyFi9SyLKJ3ldsRm4aql5HMWUBnp8SSkXa160tRk5U9AR2hX1qcy1S9kQq53b2txsveXh+0ButKvME6VTt6HkW503ZYmgWqZohKXCtXqWYn8uaNgkuXKbo2rPdyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582071; c=relaxed/simple;
	bh=Ip4IJ9YcCjAcNS7SeyBSugqXLgQYC1klaEHI+7Slqio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9V8yUDDf93yJ7Jh3NrO1GYwfyNU2gYVl8nC2Plz40Me0G0DNkLo/bE4nZd4W+nEDZ+w23CxgRMyqudkf4SSBpHbmwtqiqxzOJGbXQ8PAcLSr8k8uaEjKffkf+uMSu6FXHHHNxGSFATUH7P2WJ4AoQ1QO40EGoW4EbN4tfArI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJCBA03D; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f0efd84abso2314491b3a.3
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 16:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758582070; x=1759186870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIRmuzDxZZ6U1ppyV2zSqCOvJ0mDBr9fz+vZ74M3vS0=;
        b=FJCBA03DB9Nxg/HLx+YfD6NE9VS86kBiSD0Ua5mEjc54eTmdOl13f20AXQBYCcm6nu
         +ZQKM7b4YPSRqjHA8QB/jVDbuY2+avIqzCdRjyJVEypLl14vmx5p0sEAXrOBraaN8VmL
         4Uz7OHHZ737X8ztVhlX46oAMnOmWLjt8VGtfoeG/V5lBD6ilS0ri9wu/mw+EhDOGyikH
         2TzGIKGEcZjVHfzvI0Gfy69JOHuozi2gJX9hEtCXFbQJXpvXPRLfa8OYwCMW0/f67uxX
         du2vyMROWkMzwEYRGGHuTauRv2dPFSl+kw6w5XOXy4gnWOQiXysdLBVxG8npu/fM4Rjl
         Z8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758582070; x=1759186870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIRmuzDxZZ6U1ppyV2zSqCOvJ0mDBr9fz+vZ74M3vS0=;
        b=Fy96S41tihqINnHLgabTYE2BSPyTHV5GFz3RRKQeTlT1sjlot9P4umBlKgRVA703sa
         dMNyd0K6Azujr3qOppUD0QweiutxMlc3ZngjjgWMrr3OfRTXik75BubbGijRBPgqeZZ9
         mSzKwY8DjEyfVFK7KhsZfHWDFiL6YlRyMFPnm2T+GvowMcKq3CNUfMDSOkQMV5wnDa+G
         8N0fYZ/XGZ1s8+GFhcW/jHOApWz2CeW8Pgh98H4ZsacIP8oonMz2eTTmPik8QphJCcYs
         6H6EQvTsKGka7XjsXBRFP0Y3rZxvruHgd1pICbZ4owrFQxEiAKJhlIpQUG5BTvrc1iG+
         +Zlg==
X-Forwarded-Encrypted: i=1; AJvYcCVtSaUviaGANZ1BghX+D2eq0vDFd5fiuBYSRKhPW1cdejLPKCxobaFfBMnu+kccb1uQyMFlSvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGb8WyRDTXfXDiOnikD4AZJhaDcY9hRaeCQMq4JuK5Ua+HosM
	SpRCl/pkhyk287dB4alh79Va1HH73xYiLEMaGVmtrN6VTl7/0KHXaPll
X-Gm-Gg: ASbGncszPo+2IjVqQfkCDGWZ2eSK0KbC/VPQoyINUnKne5KmxVVvZaej43O7BGQS/h+
	EGIOp9uIyeqCzwhi9mA/EZYlVomu+avccm+BMgfGOcNc2qOswhD1yuw2fV266VJe6bKNNvHI8aw
	sTuAYUWRfg4cS4Vo/sDeQT/bVBTgqp+C7LyP6/aFNfh3A7sXvQGaaf8xK0mPGqKDGcjcVjyOD5G
	NEv5Ohohc0DqqPTs2eckAdXM5K8M8QTH7V9t/2kj2gDDMZUmfXyeV1dz8yKClGgVW8dtq+JAaqf
	FBb0Az9oO8ro2qcl2UtVogHAOWARZqSk/eswg/nV5MEBbWV68Gl86myWwF9Bv0hP/iuTVpxYgd4
	6xeSv2zuuumdpFEBc+inIqDnfYcUsZtZAc5XOYk65GxUy6DJjrXS9ym2CjyaJM8RTSZdVwAXhxx
	uDrkc6uxqn
X-Google-Smtp-Source: AGHT+IEWsdn/BYQUoAQIfQeX+2S0J+Xjds0yc/56BhxRARTZuUx0AR6Bk4YM/v7fMbIc94nL6KpfHw==
X-Received: by 2002:a17:903:2f85:b0:266:f01a:98d5 with SMTP id d9443c01a7336-27cc79c350amr6680795ad.57.1758582069506;
        Mon, 22 Sep 2025 16:01:09 -0700 (PDT)
Received: from [10.255.83.133] (2.newark-18rh15rt.nj.dial-access.att.net. [12.75.221.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-271353b8792sm80534825ad.123.2025.09.22.16.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 16:01:08 -0700 (PDT)
Message-ID: <5326f2f5-e2cc-4733-a44a-db08dd8d19e7@gmail.com>
Date: Mon, 22 Sep 2025 16:01:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192412.885919229@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2025 12:28 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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


