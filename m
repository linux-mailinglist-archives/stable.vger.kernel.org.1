Return-Path: <stable+bounces-131987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC1A82F49
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD927AAE44
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871E527817E;
	Wed,  9 Apr 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OC09pHcc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41D278171
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224761; cv=none; b=tDDdnWRYKC5hK0mI17nr9WkldZsPAOxtUxxY9i+xHymR8lyDk2fNLlUcNAE3iyB5h0I42saJLkim4pfgJcNYJlAcJFoclwSYABHta4gHZ9i36xh70TDtxuBkXZQyj/To2Co0bGihSJbhq64xC4Ty7ujcaNCb/iUXJ5hx/Elczu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224761; c=relaxed/simple;
	bh=pLt7GiueBlfEk7bEqYSj6/150Oe2cspFuNbigDQxZMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLS8qSKjLZ292cJXO/bL5pcGx8ATrxAOEzgo8oAyyYj19mvxZVcQdsMgecE3SoRLaJTGdoGtJTKDs1/8q5bGSeIG6Xx1A7lwYnJNxK9lcyVLxKt81jjxJpzf9POcYVjzyuL06qbOYL0DE0Lqc9e1k27GrdE2bNlQqXcfjMr3XuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OC09pHcc; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c47631b4cso14492a34.1
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744224757; x=1744829557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08HrC4TNhMaF2kgAGKOzCB9x+b2Lv0SOP0JhsgwzY5s=;
        b=OC09pHccqol73I4WIRGW0GAWmDlEWCDdiMkllOiHZMN1f0af8dg91uwoathD+YcjmL
         Otl0NUI23X4sA7Vm5XR/57fT4sgXZ4G31D4Jo4PT/x2xBQl+RNie9W2oPP2S/IIfrvJc
         0Qt4HzIzbcvCYK2c8+S1A/we/13rVUKNFDDrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224757; x=1744829557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08HrC4TNhMaF2kgAGKOzCB9x+b2Lv0SOP0JhsgwzY5s=;
        b=NUe0W+/6UoZSLXgLwDbrCBjLIEejB8+muvcn7kEEwdS4TnnN/5eaZVQGu2ISnSxdMV
         ggIXsBG0EBZsYAXmGkmW5Gg0i5wgap9OpaoIGqGirTUgzTBdBzKQ0nLh7T+IqvScULou
         +o/Inhje02386PKyKSHMpAThKooRmbE9J7bk82kk2aNc5mK2YhCZrPZFD1OT8Ze+1yVB
         2ldlKiHVzE+vEeIXviPA8pcNBi9ZGgUC4sI8HV3X6mukfygoCrXfL19Wd+6Vy1eeuBUG
         XycrQ9eB7f88uDkjM8eT9MLRHr/+cfmdP87ahFdLcbMA3SBSamBrgPDUhqL3Q6QtcsQn
         c8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcWEuMNG05tI7VOH1K7ESnwnF1JXzN0X7udZNYZaiUp60lY4JYzXxJswnHGHim7YHrgjqHQ74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XTXa0rxZQrO1xjtz7Dxd28l/xmXya09TupvrJmmDLdBH3swU
	J2Ue1jlxeN9DxoeONkzIpaPZoMskH7S2D6RKxB4VMGV81Q3zzfUcwxPZkHGxx+I=
X-Gm-Gg: ASbGncvo/YjkG444oDVxgpwh+tvFlsCMrvVeLQldKZoeor6hmR4SHIAF1946YEOKiVq
	hftJQAYAN87Uovb2uc5LANcDVgd2uKjkMIJe3QPUVSMWH/5C4irHpmdwQie7hIr1z4iggiR3DQv
	dOotlN9Lwcoq/P/D/5zXqZ/6AMPZ2J2kGrpWXvAOzF1dns7fKbHPSJX6H3/l7ajQIat5dMUeXyk
	eDWnMTcY3YVGcd1ppMFTnf2E0OjF8uf3CZ6mgvLLSLia+9/P2GPMWaWN7MF+PBP/xBpQu2et3UI
	7JFPFAd0qnYBf8t6fYnSJvUmNQ1J7OCECwisZq1XzVrYon4V0XA=
X-Google-Smtp-Source: AGHT+IFE4WLk96sOEuDaUbLNglaG8LWOuDvoLplefjWi18rbkgHxYdcBhfLP+c4HletU/vfeakO66Q==
X-Received: by 2002:a05:6830:6304:b0:72b:9fb2:2abd with SMTP id 46e09a7af769-72e7bb2c8a0mr19492a34.20.1744224757172;
        Wed, 09 Apr 2025 11:52:37 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d8d90bsm280459a34.34.2025.04.09.11.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 11:52:36 -0700 (PDT)
Message-ID: <52fb54ef-4f30-4585-b5ff-6e52310ac43e@linuxfoundation.org>
Date: Wed, 9 Apr 2025 12:52:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/205] 6.1.134-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250409115832.610030955@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250409115832.610030955@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 06:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.134 release.
> There are 205 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Apr 2025 11:58:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.134-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

