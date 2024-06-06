Return-Path: <stable+bounces-49934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C155B8FF70C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 23:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD0F1F2348F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 21:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB816F06E;
	Thu,  6 Jun 2024 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MfXW3Keo"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0961FE3
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710732; cv=none; b=V8pvZTClEKGzgNnTQKeg++aJJapR/u28DecxRuVCCqdrRqN0nBQre2RGD1cbroIhH5MzN4aNRE8wMSmlvLxxL+pVwrdG6GTRzFz+5jfxIPwOZUMEX/yGWIlsGNu9TDe/c4jSHn3TSq5qmss+wNde2EDwFIJj5yZwtQv1Dmanyn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710732; c=relaxed/simple;
	bh=1wzuCCFG6zJQG4/yIoPNBCKWEOwr1cjoHnLTYAP3xpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cL//8OdwMG/ojKCnc5Tyhg1kG5K4xC4/1es47L/GPRnbmHFasBsN+PH6wDlL0+JFsDMMole92N2DgleW+9e5J9K+GCEfh0YYmbBN9Q1xqxLxGlpGVmgQ8078zYS3vpFqALXtdn8qNJmO4eTKivvhduQ6GF0bfr/OBm3Tf1ZzMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MfXW3Keo; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36da87c973cso792745ab.0
        for <stable@vger.kernel.org>; Thu, 06 Jun 2024 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717710730; x=1718315530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KDsYqliGZduGqwNg2P/Pec7wrzaXiUOB9FmAhmIDXY=;
        b=MfXW3Keo4CEV8PGH8krrPFdZaRx8Btrb0YtOhnHYlREpfwOwxUkSCf5jxFapqU/I5j
         5kltEWD0/rDnBF6pn2W+f4I+1NL8bBzsfiK4JYCX/54jCtVdb0FmBT0QNCbvj2iMQRri
         oefBrURikHeGOhLYHQgZZYM5wSeELnUnuIh2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710730; x=1718315530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KDsYqliGZduGqwNg2P/Pec7wrzaXiUOB9FmAhmIDXY=;
        b=njab5hny3JXE57Q+5qlNo1Wi5U3rwO6aQ2bbj/bl5jfsMCLynCe9/EyMA5FuDsyN/W
         LUQjNstONDII5XfgSnNAlvIP4Sc0I0LkNl551e0kyxEkPNjP0xSs70iQlo5bSQwQ/5ka
         e7hUpAlZF0d5B3Tz/9/YCvBFTEfm8tyDn835U4VdAuH0ROYw2iKkUFzM6EKXKuwk+oyx
         hnkZ60z2GvuggVHoASA6ov87G3cAqchKhz5HERbZWtT0AJJ5bHmV0xTn9MH8XghSTQ+O
         7ID/JpqCiaVS6N6xyWndxiTl1aSOzqYMu6mz+qF9oUwtGxk0kb9eF1S0CXttmOnvT5RS
         QDxw==
X-Forwarded-Encrypted: i=1; AJvYcCUUaQDlVe7jXFUXQYx08vVFyHEaJ45jNkIRIlSpT3cYT1qu+mdSOLpe/1mJV+vbU+O0yZNBRaaoiN5D9KJV3tNcZ1hsDrj0
X-Gm-Message-State: AOJu0YwvxnoNVXg642v5u3/vAs73SFQoKMLWKglhdddBJ7c1890SqCql
	p+gK+/3bKjFzAImHOaFDrE2Vi6HMjaOJfeTPwGEqMP2hCnhbxUX7rdDZV/bmfsc=
X-Google-Smtp-Source: AGHT+IHFAu/m5GExcl5dKYmmFZVcJ+UraGl6QR4X2bxMouTEWbj98AEA6rlHA2Jcl97lTwB90wbSoA==
X-Received: by 2002:a05:6e02:20c5:b0:374:a102:2948 with SMTP id e9e14a558f8ab-37580391276mr10011895ab.3.1717710729892;
        Thu, 06 Jun 2024 14:52:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-374bc15dc9asm4891715ab.45.2024.06.06.14.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 14:52:09 -0700 (PDT)
Message-ID: <cffcd021-7a8c-4a33-b07d-f0ab21af3983@linuxfoundation.org>
Date: Thu, 6 Jun 2024 15:52:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/24 07:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

