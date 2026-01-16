Return-Path: <stable+bounces-210097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DFD385DA
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 20:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43D1D305F3A1
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2139A819;
	Fri, 16 Jan 2026 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YciFmD56"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8322F6179
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591712; cv=none; b=AXuC2Az5jOksRpK+NrzAggH92diDi0WJGVHydtNZx7KGsJ83zMZSBNBowljA/njRX4Gc+Ky9yybH4lsiunizY7Th4wrPrO62sfbIBqWJLjjzqyrOwvEoYejwyMdZGvRFXp8JVDHO0YxMb6v3FNhXwmx52lz+R2HC3dr+6ObtqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591712; c=relaxed/simple;
	bh=02EfObqEwDi8fljYxxb5V0jKbMzSmLMJrn6FfRXL984=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9wlAAz6xZBDYyxnoNM0tl+vP7rRfKneZSO6t2HJez48+nIeKCRgOTo1ir5kkHPwj6z6Hm1BNuhLoo7vbobl6f9coDJbqQEnucaFOWM8RA4VTjqgEY6vKP3K/CRH45ehCYojsRt5pOxPYzuuRWlor3fiayh/WxNCYpLOLxe226I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YciFmD56; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c9c505fe8so533640b6e.0
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768591708; x=1769196508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdkD30yEkr+VNwdq98p4fkHFAO63J+ygD3HFB/agENA=;
        b=YciFmD56JoiykOQvyEPP3PCBtH40bHuUXVdlMMksetJ8NZieYm2phzODHrtgCEJOMi
         lkTvWVyeEhI3yl0NRFxN4xi7nIHoCVkj2v8X3p75A5ZxqaU8n6hxm7ZfcY6LUC+ikcZB
         mvr3WnE1ZtOiXsYDbHZ+v/SaFCaTU3p2Gk5DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768591708; x=1769196508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdkD30yEkr+VNwdq98p4fkHFAO63J+ygD3HFB/agENA=;
        b=vmkQAt26kGQv3HwZ8wb7vvCH7Qmfg0uIpJ/LWnVbFlO8q7fOhEt2N7a296jMr9Y2c+
         jBjzo6ODX3NOpF6qBs11E1ooxgrV3YBOoETsbITOtDVGuVdRhnloZbEjpiJITKThNGhO
         HXrVTsS0biU5APSMJjH69eZyalPf+Wnw280llr4rVgB7N9zaxDa0WCwdJT2F61NcJYMb
         f6a/GWZvP6EY12V1M33EzehU5MilSJQ3mcLAN1hLTJLQWoHaSkJg2W3kIUliu9mRJzi6
         Dkq3TJtnTmWdaB44tSf+MynfjUycVUByQSF9W0n1pSbCYQblpI12gpif6H/H/Zu5ZGET
         zleg==
X-Forwarded-Encrypted: i=1; AJvYcCWmQ1lpOAYXvRu5ZgED8o/NHdiCieInTuH2SiiNygFmdi0giQhNiNtrQO9RjDa0Hrys7Yg/fRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJWzBRhb8TWt5L0U15AWQK6NgAN66L4z/ZAMVqDT2+gWyUBFnv
	2GJqqusRP6gO+DM3cyFqGYpB5rE7Jnkqeo2vXg5+lX/Go7P5FnxWLYKdGF+DabZMEuk=
X-Gm-Gg: AY/fxX5SGt88No8N1SburDZNhuviOcgQ+6u7HKwTdZ+y+jg/jT3qQj9SJ6qAIRwxDx5
	x3u0oscTkqfKfhrq/WPfGuyYZ9Qs1zOHqyfu1HbfoXfA+9SV5osSnklatw6kRwDgfDHkU+SLF3F
	ukJgSsIgkcnpoA+BCdupVOdAHrHeTEJ5YGJ9bD2sM8csoypbiOluHbFIUCM3RE6DBUB7bQNQeeG
	5WwLaJvj9NaLG2ZOExXYGQmWKapAU9E7GNS7pJ3WCzgdgL2vxDxl58X10hhbtu1+e7RbfWbkTT/
	Fr3jqYERzgeNQ6coY2154znt2Bpf6qNaMiMxGZLk+tc9zoD0RkpmacLvsgansmSIoULOTLvGuq3
	6JLDnNPTog96C1af2DGB+L6D/t7lv3X3LXzoEbQwnryIBy1hjWp0hv4mOx6wLaAyM8+rHIYQRwT
	9CnbuPAM6Hf1amb/hXJT3H4A0=
X-Received: by 2002:a05:6808:1506:b0:45c:71ff:1f5e with SMTP id 5614622812f47-45c9d734c5amr1786382b6e.21.1768591708367;
        Fri, 16 Jan 2026 11:28:28 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9dec3567sm1664286b6e.1.2026.01.16.11.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 11:28:27 -0800 (PST)
Message-ID: <114e9805-c353-4592-96a6-e3b523796960@linuxfoundation.org>
Date: Fri, 16 Jan 2026 12:28:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/72] 6.1.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260115164143.482647486@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260115164143.482647486@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 09:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.161 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.161-rc1.gz
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

