Return-Path: <stable+bounces-183378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B6BB9069
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 18:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD760346ADA
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D3B27AC28;
	Sat,  4 Oct 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0zZL383"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72998280A5B
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759597114; cv=none; b=sHyiEptG7LzdeVuNKIOb467tGKRH39e0xcbW1/xW++4aPacuJFwuRzHHQxZTj3ps0sUgaw41VN2SbUH2cE0NGryRLvewDw0QtjHfPJyYP25D3EIN3m2v4tInqs1vD/NVAzr1J+h9nGFfeqpYwuaHbMs0NPnVotlrgkC4XqnNhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759597114; c=relaxed/simple;
	bh=K9vC458WseZ+t5Qy5yDU9N4O2xS+IAk6v0rfKcmkCkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoTkdpAvRa0g56XvNoVSWW6ka6Jl7geRjMIlDB/ZMap6PBxkFVLws7hsssIWiNOGr/ELgFV39TCTDEP0m9AquEH3+M4npmXgRRCZPouK6pYyR7Huq/q7ei5XRcfI7c2sJFOEnzoesqQQlndqTZoXSBRZYRaiO2hU36G5oixPHCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0zZL383; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4248746aabfso13407265ab.2
        for <stable@vger.kernel.org>; Sat, 04 Oct 2025 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759597111; x=1760201911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKCXGIJ/5BK0XkF8KRZhRh28Rfy6IWFA9g8zjTx/OE8=;
        b=A0zZL383y+HkitdZnP3b+bXSrq/QPBkAm53YTqd44BHkPLA7KXCxqF5tLwskOd3fqG
         MJyR2aOVONSZOpX17j+rBxmF4MuRO4Bdnsb2UrJwyv8nZa4VZRvdLYI0SlX4ooTtW0ch
         QJFx/JDu2X73CtMAYhdQofEBo9ZyOaLya5KG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759597111; x=1760201911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKCXGIJ/5BK0XkF8KRZhRh28Rfy6IWFA9g8zjTx/OE8=;
        b=iqG78XH8PLec96CjarWW9aRwalmpAK9+wcihgMqhZM/gAUXnKGvz/aSB6MuGiljNGg
         1J7KeFIIShr/jMAEgsIQYbpOpXhCXNBq0PnG7F5ZMhol65f4HDVzQHyqVXWoCTThp+rK
         E8u9V2lHMFm5SYrSWUf3fajgq5t+mmiW68EM2yJs77KPoIg7PRaE2o4fj4WwFJ7SQPNe
         HVb6yxr4PF8m+2lRFliz6cpPmRxZJT1Rhi0KaWrFI9yi8tE+btMWXxVq3iLoF0vjmpJN
         XbJGgTxTpY8eWz88yB+04DuQtTMUHzuOrnhtX2tmb7eldlbQ8ikQZh9XhXIdKbGTvFXA
         5LMw==
X-Forwarded-Encrypted: i=1; AJvYcCU+ETu5O7BSLaf8e34m4MADHEdCYBhKRO0COOEjIwsspJEWbq4b8S6fj72ZeytoFL1CuCDp5JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCKRSBmZn3pXsvDBVEL5D3EJH8BQ+mh7PAfZ9SaYqEO+IaHUG7
	ThKHIwBoLdkmX+u8lktA5ONV7TUHhCKwYF1Tna/R19tfVwqSWA2rNmkdFPHW7iD1l/8=
X-Gm-Gg: ASbGncsgnJ9oQRECmMIMPOLl0ldihoRs+dQzSqCjDpXjzQFgU/WLcqLdKy9/TzXLspZ
	X1EqxABYbvTErehKWAAk1YfVP52wdOZ9r4U/8Z5tUZjuGLcSsy18b9hkGgEd9XcUmcNc1fQHjIA
	uEV5ofWP9KzJqNwpwlSFHbrxwN0g/HtAEFeswqNjAo2h49GJeigX128Ky2inI6WbbnBeXC0l4mv
	cPepUKGAJEQar9KkzoAKnMTvVUBnMeygZ+K8ghwYCyi5MTFCLLOzw+PPZSTaEG9jUPQLOUiO5WS
	vwsfeuEfXcjyKNs9XGKTDZNYqUtf+iiqTNKw8irEL69W2azfma1iw7jf359E/CPbtskg3clbWyX
	KlLWUeDe2iNKOU9gPXZeJIq7QSPVoat5U9XYHW9DZKVv0C+fHYkXLaKglgKHdhpkZlopTRg==
X-Google-Smtp-Source: AGHT+IGBk0KCUm6TNrRRCC/kGTGBW3hhMrS42dCtvvENIAVPXJcG7xcFtOUNCLRzrIFUnqtmgp2/IQ==
X-Received: by 2002:a05:6e02:16c9:b0:424:b860:7d84 with SMTP id e9e14a558f8ab-42e7adaa636mr84992425ab.27.1759597111493;
        Sat, 04 Oct 2025 09:58:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f37edsm34479515ab.5.2025.10.04.09.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 09:58:31 -0700 (PDT)
Message-ID: <df2f8664-cb83-41b3-9094-ab2cd17fe531@linuxfoundation.org>
Date: Sat, 4 Oct 2025 10:58:29 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0/7] 6.6.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251003160331.487313415@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251003160331.487313415@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 10:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.110 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.110-rc1.gz
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

