Return-Path: <stable+bounces-185714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB4DBDADA3
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 19:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2774E580059
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFFB3074BE;
	Tue, 14 Oct 2025 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNwgBZ25"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBF308F1D
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464367; cv=none; b=fahUa1u3/AHSvCO12jMqd+YYabaBRtx9sIM0dPSlq9pCW/WEh7Bdcd6z0fI6iyzEnaWT15kqq0jqssZXO/wjeHZETTi2nYNGtBM8BkNZveUgEI9xB3SQxzDkhmshquE0lD1HmchpIYh11bEG6QRpEv5SyU+lAKWeh/Kb0y7N3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464367; c=relaxed/simple;
	bh=Vk8hTPSpCZlav1c+s4Whx35A6sxLw90BVbohmPvOMCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlG22hjiSkNyAWgiShNpoHeOgvpJpoUSHVNDi3NTLRQ2xz3NHLI2BgInnbrg0qsZhNMkTNXbRPwHzFly2B0+AWlCAV4MTIxbJnWg0OF6IXgH3n6D8alB9WGr6k3u7d+qs/OrTDzlckK4c4ec044ogEzd+UI6C86lD9wHoFDNRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNwgBZ25; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9298eba27c2so245550939f.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760464363; x=1761069163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGxq/8VkxT40k9wgER3vpLBqBiF/8xTWMryj+EkLgt4=;
        b=DNwgBZ25P39+PSjhMW1xeeESU+UlIXe5mtsZBHJcGVvMJVxNmk8MeVNM1ItNhXafF3
         PKn6V8v1QDfvpPRSmbSw24b3BxX7ENuGFwctvOk6XS7+nm9BgzK6hOrbyQxprWPk4y1K
         RvtjY9AAcVATGm0vPz0H7JLaEX2gfYm1iE9rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760464363; x=1761069163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGxq/8VkxT40k9wgER3vpLBqBiF/8xTWMryj+EkLgt4=;
        b=QFfDziD6pwYRgmHdQWIEe7FiBxD5/rWWlF6MCby+dj3zalB9o73cRAJno91EmTWYHr
         kwfPS/AnUGyTA6cCiOPxDDAhH6zRpMExdKp9szUtry+S36iGkr6GNAXLKHiY6/f9QS8v
         M3+lR7/U7B771uCsr8m0s3bzdN/Omwe7iR1PJNP9E1/yV8rxtZAlfi38Jb9Jj93iRL4c
         Ny387+n31Uqx9qnyHGpI22jS/D0ly1BSXxt5bUSTTKLICrlYFrtPYm8wTno8pmbDtaMP
         AiG54nVDDBy51JhoMgaw71270OnrQ+UVvmyhTXi+5sZM7ecnLODYjBtMrVJQ3qo+rXUy
         5mWw==
X-Forwarded-Encrypted: i=1; AJvYcCUGS9I6Vq1Ow5AUOXUisHDH0iomlgDc2K+aiuQJrZhOVz0PlMASXaZXpxqdWLnAfX53ZjADRWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/XsTZC+phrY3AC/zhaOetLK//6QiNAC1PjWeLIe+MfIrOAIhy
	o6RWgg2WQFURygsKb2YlDRlKiU0KbcrGj0w3Gids38SozFkMA5UAWN0lFaNXXJTf+XY=
X-Gm-Gg: ASbGncuheFjQr9cwttP0B8gnWnCJcRIu5FvU7pjhnwzO3WiaDIPpoR7Vu1+o+icsAPX
	oVnMgH38oZF3/f1AHbMu/fa73G2mUZ4onbayzixdoIxUguj8t4dJIQ5HtWxsmd1cTpStjLNODiW
	dt3H6qObwfaMYMSloavpCINsbsKNfsxtS1uDVujdOa3WH8lpbzoU47WqXi4T38j+pfN2tDnm/qf
	Hz6YpD8LRmhW348S81+JoPCq0f8IbSXXvbo0ZT8nIYTZv+C5Ii+ce0jgIyR7A4Iqp/qifBYZaqa
	x93IIB8dr+cdn6J7uT9xpVtYr09Ald5pwb+NI56u5+esjQXKzMS5hjWCaUoVudMfpQV9O2wEgkj
	BGOa2g2I3777voyWcJp/ZYN223p0Tas/zIarqHdm4ColgAe8lXCZsTuLWuiwlKjl3
X-Google-Smtp-Source: AGHT+IED4NsTeiB2tjQZ1qN+qgCtT8LJzFvJwI544fSE/j1qtAtUcoMqpbm1m3kTi+yIqsP0iV05WQ==
X-Received: by 2002:a05:6e02:1fe3:b0:42f:95a1:2e8 with SMTP id e9e14a558f8ab-42f95a104bfmr177063845ab.24.1760464363522;
        Tue, 14 Oct 2025 10:52:43 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430a7c45b1csm4645205ab.40.2025.10.14.10.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 10:52:43 -0700 (PDT)
Message-ID: <6e9ba617-8731-4a78-bb56-eeecc6a25897@linuxfoundation.org>
Date: Tue, 14 Oct 2025 11:52:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 08:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.53 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.53-rc1.gz
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

