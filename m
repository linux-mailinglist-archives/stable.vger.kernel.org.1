Return-Path: <stable+bounces-131983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C7A82F37
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 20:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424498A2080
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8AA278148;
	Wed,  9 Apr 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GKMEDyiq"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D30276047
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224322; cv=none; b=qFwTHuIw9RNkkIG+Tkt5gek7oy8DcxKXX/gLsSGfee3pdm5LJMGDa13h5xRNSmcadEacfuS3eHP2FlHazZxO7Ep1XeNboDpjmyLBFPsu0vuobJ9ydTh3dz4Qai9q4R3lbu9q6HBewF1saKHbs/5ArXJ/A4EXMuZ6mZqH0c28VOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224322; c=relaxed/simple;
	bh=DE94AF+o8GAnUH4MVceaHQSwr76zM1gbMHM/bt4QTz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p14ftYGnIequiLi3ftkz9Q7rgOBhjWZltolced4lZVAvIklmsiOuuebrnK3XoMtxNWA200M+XYPLGRZ7EUx7T6aIrGRibjkmot/VqzOX9+tIaXQtFWp4+K0g7TKRE+ng8+dlgESzz434hhggAvV9gqsByj7XQgF8TAJ4lnOV+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GKMEDyiq; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso206585ab.1
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744224319; x=1744829119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SovPoqcq00HkS54A0arEix/uaJanWscLaN21MAd/PrQ=;
        b=GKMEDyiqddNw7n/PoowaEB/HtzAGonpt0OtZlRwnPpVFqUlzW5yLtNMjnrvTm1bwyF
         vJc1AnXMDw8aaGh3z4gv22ZJUrixQf6gmPLFU1AoQqYaDtHlVLPS8rBjCtbtROwFlfB8
         ITjPacSJPs374FSBWSeGkLOQnr0SHPdeXuQ00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224319; x=1744829119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SovPoqcq00HkS54A0arEix/uaJanWscLaN21MAd/PrQ=;
        b=HVD6kQiP23OlRRTd/O33VCpmAHfySkia7H4OoIGLcC8/fhpZF3w3Mo3zLipn2QdGIb
         keGf5LOJOv/KLKrDM9KaY9i/ByB+ER3tIdYoeGlCohg7oWCQR87gpAv1jqZNlDcu9ANa
         HvZnxRq+9eO28y7RObURurJsl3DwDQKW40/F9kDKlH/i+BWfOByeKMkIaCZsqt0I4Vmn
         UhXAGOGlM2xvz3uuN/Pt/AwCdRHqz35n1ln4peAG0d0pNz1khM596HlEq72b+wrLBD1p
         YBKi5a+Xu2LIA+8bhpoIUztKruWcfM3uRg+lGn+Qr/jhC2Up+5gAlxttp3Txqy/1KiQ4
         aS4g==
X-Forwarded-Encrypted: i=1; AJvYcCWISlagn2WDn/I7iJPGnCkkPEVh7X6XVWmh01llUO8OCCFywXfLx6FIE8tbUv7qJYWI8VCgRSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytxcDYxZ+uKyaOWThquC0TNKp0CtyFjITUNMMM3tj5UXw+lMOP
	E83AIuMXobulkuNrEbleLnHaXUXeXXHIUqcsHbUn5vzFh5Ez0B8ns6AYjQ4TO4g=
X-Gm-Gg: ASbGncswMRDs/wApGerTwsZCXYv2QfR+hEtjdeiKvIfPJq/A06gr1Sujd6L2/MzkQtI
	wqUB/ssXbh9y2fdRL3mV3vaenb0OcAtt97fB5Bh0NcfO42R7kMzp+kLvNHy6hHQM1RbGtNIs/8c
	c6moOxfre8Cw6F4cZwBpkScpB93PFPoZff7fAo+UmBOmP0abOFAh9vAy480G9MQyXIQK+Guy8kl
	shMgT62y1nai4DzHS2uFhZ3lsKozehxQXY9NFe0kY0EGjTHDtd6YN+DL7FQS4fwNtAVnjRKYLeK
	luQ6TZlyEPcNnu22eG9VM03rk2qxYYIsG+qeJgH7X+yxg5v/0Y5QTNmSlOo7qw==
X-Google-Smtp-Source: AGHT+IFt7sGM71TKjQg4Zk+NkDUv8HxSgsY1JlES7yCnZRK+kvYxcZDFPFxB0ZS7tX5AtgSmKJPbcQ==
X-Received: by 2002:a05:6e02:3c86:b0:3d4:36c3:7fe3 with SMTP id e9e14a558f8ab-3d7e46f8e7bmr1712175ab.9.1744224318764;
        Wed, 09 Apr 2025 11:45:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dc594eb2sm3769065ab.70.2025.04.09.11.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 11:45:18 -0700 (PDT)
Message-ID: <4455cd1a-cb95-4a8a-81ad-ff2cfb6c96ac@linuxfoundation.org>
Date: Wed, 9 Apr 2025 12:45:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/500] 6.13.11-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250408154123.083425991@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250408154123.083425991@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 09:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.11 release.
> There are 500 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 15:40:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.11-rc2.gz
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

