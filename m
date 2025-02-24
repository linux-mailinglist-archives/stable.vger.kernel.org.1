Return-Path: <stable+bounces-119423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D397A430DF
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 00:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB621898EB4
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 23:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2643B20CCCC;
	Mon, 24 Feb 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KgOHKKGt"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24820C481
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439797; cv=none; b=ufAI8Gerkn8elxC19jQ5LnEg5ZKVzIXwTCAZFLK4zqy9kS/4LJFkuHy2oAug8dIGebcUrhf6kBCrWiMbu0xRhfQK2LrYXXDdUpRXmmaHUsJPgsEeLbiYUrml6uJkAp8ulTB5EaSvvUdes5OcMgvvgXNuoER99QS28YOG5AD1qKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439797; c=relaxed/simple;
	bh=IXdCBDzCBUbkFfthm9/aQaa+v1dqrKyH+wUiO54d3RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6CMQV//RaxNA15retG1694ry0nXy+pzPsMJ/McWfqN+qOq/HnaNXXSZNxA4m7DhJL8olwYPoyXFciQY8zzj/+o6Dg3CNpDiYJsNKsBP6Q2bYJV6onkBmFRNNvKutXfmU2qbGAhRdPHSCtL32eZNSCzgUUs7pwOapIKfIP4PxS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KgOHKKGt; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso501332739f.0
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 15:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740439795; x=1741044595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIkbRf4FMel4QDOvKceYfh/yaQ7I5vhGFgantHaE9ig=;
        b=KgOHKKGt3A2yiRJan9ep8yumcQzUygd3IbSBerqaIVNwrRSSlFSjQf0YZ4mEDSM7Ha
         veF+voiy5pSLejrpqP83yqoA19iQaEDTQMo6eulWQIHBlKDF1tivSiwQcze2xtXc57uv
         GzFqiA8HS2hetCUnK6OaljpGGid/M2ps2DSL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439795; x=1741044595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIkbRf4FMel4QDOvKceYfh/yaQ7I5vhGFgantHaE9ig=;
        b=JZka5knZxg1C5UuEgZ75qY0KYxrIElCCqi8j25KuhVk1r08edVUVZC90/Ql3EeraU6
         FA3GB7qBSRgoscFouTF7skcyJ/UUxGUGoB7EMCfUJl+8N63szXFdnzfodS0NtCyZq+B2
         /V1dnRIzQEwMXE4LqVzIK+pOkfNuR6NPy0FGkSs6gJEjDiWl0bM8nK6+daNXaBeRY+9U
         m7kvpuMc89jwoDHdbIt2Q60Raz7aN271X4C+V1B6W/ntpDCnf5e+SPAksI7EiivXrLi7
         Le2xoh4P4pu2giUVz+1rufIEQltRNgvjPObTxPNbqoz9GKrHr95MAJ/wX2m+lVh7Ihj+
         Di4g==
X-Forwarded-Encrypted: i=1; AJvYcCXr0IKn0IRk/JDi1tyDSOQIcS4pxKlGkdZu690TOvl3Ldz73yZHdzqVFw4RdVSt3m6zjejXUUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+jkb7NhnSKFV0tjC8UidAS2xw8oIJNuPAwGNUKCCMUs3pso3
	ySPGQkIFjBZa/0BlRxuo1+wkaTGOhE5cPcdHDeIOBVHPjBipHrgY5DOJ7L51jRQ=
X-Gm-Gg: ASbGncusP9V5jpsQAntBAb+1FDxrPkwCz0x4gWAAu/emMCigB6yRdjcRFVsvK0u7KOl
	2iR4xzDnI1to0q5p8ExLudjC+mRMtNGOpHnIT0ttTcoLQSaAs/IWxBXNe8e74MhZWdez0huYdri
	pOq96JhSfAH7/2O63MuduQkeXANfCBX5StP0XFU5uSW2nXfRwmhMG7W7rEQVK4USD8AHcG1Y06Z
	+s6p9qyuHEBLz87Hn91Bxcw7Ysi9eSaNCARzaWbnS4Xr2xOICt2m5/+sX2lRbdMZ2UPQx8240Ar
	m6BKVzY+pU5Q5l7+N5sCYefrVEEMLJ20scCw
X-Google-Smtp-Source: AGHT+IFHeukUOsy+wlnIGOaJm7Qp4XcZ0fW2Qyx12XDKe2CQzjzBgXCGHcleQ9ZvF+aWz4koZdKKyw==
X-Received: by 2002:a05:6e02:3d83:b0:3d2:b930:ab5b with SMTP id e9e14a558f8ab-3d2cb473053mr135338755ab.10.1740439794863;
        Mon, 24 Feb 2025 15:29:54 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f047530b0fsm126453173.128.2025.02.24.15.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 15:29:54 -0800 (PST)
Message-ID: <23ee8dd6-a4c9-4369-970d-07e5f142c96a@linuxfoundation.org>
Date: Mon, 24 Feb 2025 16:29:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/138] 6.13.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

