Return-Path: <stable+bounces-80684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9708598F847
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 22:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C352D1C218CD
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 20:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CAC1AC448;
	Thu,  3 Oct 2024 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYiikWV8"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2A1AB6D8
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727988879; cv=none; b=UN+AILWP5sVkRTonthU5SP8bOQb/ebn5j+v2EJCMSkUPg9mM0AOxSGwQAlktVPbjJSMZ03byU1fjMiE84AvKMC/5VxknvVfelglMbCkcNVsb9ltt6o0qFBYKfO1MuDpd66/ZNPy27ShNswys79GWrhBlnXkfeYXgQfvAyiMeGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727988879; c=relaxed/simple;
	bh=uszalte7XO9gWoLV2ANsEdQbWY4YytMyiL0XukH+s6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mplf7QBH9T9XP1SGem72wT6tdqre3x5FRuKDnq5rb3672AVneypemDb9ruXAks1Fy80Fh5kzrjYgIQZuX493L231kAP7ngqaio+FrX+YJzbUbi6BM2vm88+F68nvOcyVSghGKuorA08DUXyCr1k7j9HxOlhI4jnXAxRujQx83Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYiikWV8; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a341cfefb9so5382725ab.3
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727988877; x=1728593677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkVnHAarrjh9pxwlEl/XGXl+U0ORYx7Z9Mfm0whWCFo=;
        b=JYiikWV8QGnAsNqliKnk2mEIMC3T9vvQ6IA7A/BV2MkqgTZBJO2EnffVy9JezoOGZ2
         vqfShCUTZcEyY8XrI6YAyF4ynhVG1AJRA4IueIR6tOfmOAyTECWKgkHe/wQuUjVAfPIR
         o66o/4PRu/HSUqnZrc+n9m4CTz0J+zsV6n7Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727988877; x=1728593677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkVnHAarrjh9pxwlEl/XGXl+U0ORYx7Z9Mfm0whWCFo=;
        b=W5LzKiTiuKssuUS1NyBdsj3Hzn+bHcPVV2Rr7g0RnXOO74Ys8GFD/nhXHpDfRhiRTO
         +OjwyTFxRi5drHeTYpWHkOddd/yWDZ8GZ0NzaX3NZicubInJMlBggCp8Gt7vSzU5MRNQ
         aNDPSZN0GVX+ygEkm2dII8QWd881j5LyPWxBfGTrDQEUfuWpMIqn7ipk0bYjxoxk+ITP
         cXNHgcRXTbLX6mjjLHxyXEfEK5NY9lqAR9eaquMO93mDPg3vuyXOXLZgSfoVWdVdR3ef
         p0apzj3HtTAls6dZGSp0CigeQDDYhkb2cqwtP+4Rr1L23PmT4BbrcoimUJO182e2nnzr
         Sx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1m9E6nvgqk5H7IwaFn7gaSGM4UZiEZBfyLNjDgfuaScnfkCplgFHeUEiUU6jGRtN+60N2cBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdvkf1CrJ8ATk7jmRGugrWXJrDjLtJWNsr5zAx0ny7b4qZIPG2
	xKyL5XJZV/yud9FXDO8StzietqGBWnTg0Scq2TKBvhDI/sCuKZ0aX/byNDKr1Zc=
X-Google-Smtp-Source: AGHT+IHcHz5/fRhV6oV+9eeZbEYQcbkgMbnmGgramQS2e2MQ5OmtxRdBopTUS/FIudr8SMUKogEV7Q==
X-Received: by 2002:a05:6e02:12e3:b0:3a3:6b5d:7011 with SMTP id e9e14a558f8ab-3a375bb4be3mr4868385ab.19.1727988877212;
        Thu, 03 Oct 2024 13:54:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37196c1dbsm3574965ab.34.2024.10.03.13.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 13:54:36 -0700 (PDT)
Message-ID: <68a440cc-ee1a-480d-8ee6-25b1e6188ebc@linuxfoundation.org>
Date: Thu, 3 Oct 2024 14:54:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241003103209.857606770@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241003103209.857606770@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 04:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Oct 2024 10:30:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc2.gz
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


