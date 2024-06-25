Return-Path: <stable+bounces-55811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC733917373
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 23:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28391F22286
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239B17DE32;
	Tue, 25 Jun 2024 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h4EGsqg0"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A400145FEB
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350947; cv=none; b=Khlijo1VzCTuPfnYSEEpU6gcWnKbpG+oNZ+iCZ0HGIZVuYWR2cAbxNj2gD9XJgMndP9KwExFtC+0Vkdy5iCDDWGgZuLrq54fNomZ44OXqdNGAaelG83/4Q0nbuLTDD65BSXdxFjvqdw0gVMXEOGftuJpXhBQEUd2POD+LYYKAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350947; c=relaxed/simple;
	bh=jo7jJ49egeKEwb3oq8bBy+Z+1fNQqN/U1oIXzUm5r1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJ9gAySY+hhmpAyjPlx1kHBfgAdebjfRsjScpXTdsG9N3Y41eNnt0egFNWTm3nXCMUA7sXdvFQzWWP5zWmfsfVUaawpKIUqOfU2SOwQH+ZXnJmiRuCSLbzeMCzOPd1kwiIinaej2bNs9EUpScV8APxGJWCeugu976NagCiGfKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h4EGsqg0; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3748ec0cae2so2834585ab.3
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719350945; x=1719955745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fjB6d8DPFz3YLiI7wqupsxFA7umSyU9rD25cxR0gLg=;
        b=h4EGsqg0qN3vOyyt5SAjE1quMG97bPp93cejn7S4J5xvFlEClaLfTiPiNw+XJQgefT
         Bu3E8OwNnBgFHLodD8QMVbJJUW7JTtSXjNCCAEtaEzjZ1U7YFe9g+YaAo5hf0xFNDBC9
         IgXAbpkOsJcyKxAh6nK7tHTSkL1NVpTNFYbV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719350945; x=1719955745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fjB6d8DPFz3YLiI7wqupsxFA7umSyU9rD25cxR0gLg=;
        b=ARuRgRCF5OOsrANeGiH7Tmwvso9w2ufcS0Ze593vuXbb4m5K0tr50KBE46R3ulCUa7
         hsjsjUVjtc/a0AyYz+D1z8t8Ijl4yeZj/d0ESZIvfu4dy5qBC9Sbeup85u2E7ZOQa8Cm
         LeGdyoPruWXRaBeXyFsN5yCaHN+3VgDxxUpG+YmINppUC2NAurA71vkSZoi8sLx4u8og
         077/J3+JYTnmrNH+8vCJ55VDbZdE5hRXpDyEBJXSP96D8SAsmLSg8CqimcoYzzCOQB1L
         o/LdWFNQlGdonpnUBFac9EhUEBPlBsMNY8NUYnm3/RZYV5V4pfw0SebRiADjQKHgIBGB
         chZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc8CjgZl6/VBy8LiHJStFKmgs77DuO6Boeu5/4T3uDgnf6Pl1rtZv1aCGBgrwvyAobrzvlPv/8d/vXYIbKcrd1hhiLnAv6
X-Gm-Message-State: AOJu0Yw0ojwFkRsoLWljHNggEkT5hl4Xm5fchz2krkJkNuvddZy8J04U
	WoJBKhCxM8gTMd3SeG4tb0ngKOs7JDC48hRg+evris8F1PMEl0dI7oHCUIj6bjc=
X-Google-Smtp-Source: AGHT+IFw8YkcVlThTre7WcW0vXEnonmEPs5gY74qQV7xHiIQ1kebkjQ2oXVGTmaIg5oejXENkkQYtg==
X-Received: by 2002:a05:6602:2d88:b0:7f3:9cda:fe62 with SMTP id ca18e2360f4ac-7f39cdb0084mr1219830039f.1.1719350944712;
        Tue, 25 Jun 2024 14:29:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d2125a07sm2783018173.146.2024.06.25.14.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 14:29:04 -0700 (PDT)
Message-ID: <839bc86e-d4a7-4022-8a2d-d9b4f91bc040@linuxfoundation.org>
Date: Tue, 25 Jun 2024 15:29:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/131] 6.1.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240625085525.931079317@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 03:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.96 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.96-rc1.gz
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


