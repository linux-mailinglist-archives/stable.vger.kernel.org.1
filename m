Return-Path: <stable+bounces-147889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D761BAC5CD0
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 00:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727FD9E530E
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 22:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7041F4727;
	Tue, 27 May 2025 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D4Eg4CZP"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BD1139D0A
	for <stable@vger.kernel.org>; Tue, 27 May 2025 22:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384162; cv=none; b=XZPnQhr7ysDMZCRdCoDOC2NVu6r5dcBp+sksua+xdYruHuMOc5/gy9Oc9nRSMpeGttTDBsZHjpAgnAuH8sGMiGh8AoBkPSIPsb6FvsnueeGCPKedGKbbHaYhfRtYGTF0Z+5yU4/4DY6BrFpJT40e2kFbpGpC1pJrLo3H+ffjiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384162; c=relaxed/simple;
	bh=LwspOpz/q8M8FYndGmv1U/jrdz9q+/K4Pl8pt+T3NVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enkf4ww/o2xBoq7LHkNA8ljcrkcGneCaO4xGzTOc2s7v+ULKp0LbXZIVLZPap3zGdsNpJyOfO1C2iNMlFBXniYY+VXuDi3Qt3C4tI6JIfujnPLS2WlPHN8H5Ahm67R+sjYxVLJno+Fq/5jTXegZ+Df9RRZXMQyGYmaqSF3ZT9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D4Eg4CZP; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3dd81f9ce2eso1120865ab.1
        for <stable@vger.kernel.org>; Tue, 27 May 2025 15:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748384159; x=1748988959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wuJpTcAx5O0GZhvVZEyTNMJ0cZvEH7zszqLSKSVXyo=;
        b=D4Eg4CZPKpl7HE4BvgxJxOv4v9/6tYTI21EdCnMVvDyCTC/ZuJwNlxzaIO1y2OSCFj
         vbYET5kn7MR4/W6GMLQQiFSKNiXtZ4u0m2Y5eNN4wiQA/oevsfq9Q3iTP9UK8mCOn+FT
         skGPV+LgYC9wuSgL7znYp1KHCcBIEDUn9sEgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748384159; x=1748988959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wuJpTcAx5O0GZhvVZEyTNMJ0cZvEH7zszqLSKSVXyo=;
        b=NptzdBWY9SNL+V8an4N+/V1aJR1yekj7mUjRCE/ZCNKBumInR215gAeXVlqYwEkDkL
         2wd6Gzz+Lt/j98i1QkxzbVHIAmfhOaTLA4EqfLymgeVaI15INDzjJwgeIjf5X4NMjTRz
         NRoadjaINTAVF744X/Qn8SqZBKo1X5GmPbX/nb1Cm3BwaqC+fTyUsOVMzrcJ2XotCDtU
         Fgm90HjCmiIVKUSg4CA9bVcc7dZGrTMPD7SddcDVlCj7JbDt8UyGL6mwMWnHq3AcPUje
         agrJTR5j8tQyoRuJalzZUssdqCXZTTN+VHj9E7OzqmbRwyUCTWl7ucagmEKmh6Z1LmNE
         MJNw==
X-Forwarded-Encrypted: i=1; AJvYcCULuCvmEYhGsG60BN/t4XFFp6VSD+qAVwKwoeuwGiWGY1raF9JPyKSZxfPkPVRRHpPBSFfiAiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmHi95F4E3bBtkM3zaUgOYDrsVser9VDoVoDNcsIXXUZeAC6Q
	bSE5JNazxr7ZYfS990gk5MuB1+5TwY7TiIBWMYlP1yZ44w+7w+i5UomgLtjpY/IaszY=
X-Gm-Gg: ASbGncty5cJmBjY/T01iZZGRfUnqbB1z7ubhEVOgNWHdwOKHWCcJpWwedg/eR/smwUG
	Ns9NI433FilVSKzccbwB9wrDNXDEAVTYhBTWuQ97vA8jRzZ0z/SVikTxxhxuhaiVFiYky5Ejbbt
	0D8XplNM2ml4x8WWwnvCOu9u0uNKhFuxAHCaBAcPtBIUhJn0LhpWXSDvASngebFjvK0qhjKq5iV
	QKQPO9izhTbJoEwKrNfAOyfhzA0soGDJuEqngMCG+K/Zyaan+bdhXXAgHqC+wwVo2Q6nJyHaZ/Q
	UcY/R8IAqDD729TWA4qOWJSgWNj1fk9jDfc2Bq5Eu69RStsdd8OFs8UKVIaGjA==
X-Google-Smtp-Source: AGHT+IHbTz9EFncYF8rjj/KzAc3qGEa/ILP+C+ivpNQ25TSNUWFF1L/0Lxejv1TK90rByVWMwd61rg==
X-Received: by 2002:a92:cb50:0:b0:3dc:9b89:6a3b with SMTP id e9e14a558f8ab-3dd8767decbmr21819055ab.8.1748384159428;
        Tue, 27 May 2025 15:15:59 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdba6ac283sm64592173.129.2025.05.27.15.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 15:15:58 -0700 (PDT)
Message-ID: <85e05d82-08ff-4c69-a6bf-e8d697c73faa@linuxfoundation.org>
Date: Tue, 27 May 2025 16:15:57 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/626] 6.12.31-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 10:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.31 release.
> There are 626 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.31-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

