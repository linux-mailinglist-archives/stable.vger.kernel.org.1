Return-Path: <stable+bounces-61927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E210793D9D7
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 22:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981B51F2464B
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837813B5A0;
	Fri, 26 Jul 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG7OQNdK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200EA1428E5;
	Fri, 26 Jul 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026250; cv=none; b=WQJhZviH5cti0593jXzl6/zJIvgePa67kx1f4HKUtSpa6YH5nDA0WA6wmfjMhUnYfyUhr1/YOHQEaTGRcjUf5eHcYn7VZMVt0HnSKi16iupWNO1ZqAW+We8vysOqtLvzejf+Dd8+OYaO+tZTFuQ7xV57cOqK9IWS3K9zBfi18h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026250; c=relaxed/simple;
	bh=uWBUHLN++fFLVc8VGhHcKdEKbNwcnzqj1Ef+6lusonk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOYQV2eOcPwYG3Zf9+9TJV6pCAerzOQtfDHCxN7as8zWLgfRu+aepvqc1FGgPHx/LCAKhl84JuDwGfzY4IC7mJcCbkMdtEcNWnhN6MDwQgBc/cWsuh+z8/mM+8PHF4tjILTeItDd+rbu0U8UwwyIrJZFwWL1bxK6YauLgF4Ya34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG7OQNdK; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0885b4f1d5so98466276.1;
        Fri, 26 Jul 2024 13:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722026248; x=1722631048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kWEZ6NgVlVpoQaTTvdw2+TWHYVF29fS2zjyGtUPgyo=;
        b=bG7OQNdKgmj/85amsoshdM1q+wCbrWQDgdF+2rpWdspScP5n0aI7sFVZU8+/QHZtbb
         GcjS+ervJ1jDoO7evpwZvYbiCYc9D/UryfTdzZ42FZoMEDbwnK0Za96kP9HqClryGRV4
         AgAFMmK6vdq717LhlITgorJjHCDV5EXzjzUqT/1rdAVbrq9z9vZ9EinsGUdWke04B9lW
         gZ63WSoYb1oo7CzB9iaNe5VnAZGDT/C9uzYBchXe4X/G1kUrNXLe1sIo7HR0OwsgeFLL
         PxdmSz8q3WBPndWjNCHNjnPpdZNPgzd37H+fw0yzKx0w+NBOB2DU7uMdrQcIasAUefPY
         6Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722026248; x=1722631048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kWEZ6NgVlVpoQaTTvdw2+TWHYVF29fS2zjyGtUPgyo=;
        b=B37ma9fniIV+vxM+fgxfuiGoEpxSccQXkCwhU3npYEwSn54kXBg25hJP7og22jio4V
         7+eMNxhQdLHnsnuUnD+AGuKvMgDrMmz2+DElxzelwwAA1pU9Ue9nrOj1eIYXfTYQMN+m
         U9zEYlsNXCT4AcXqBB6vVC20rX3XEhoo+3XPb8PUWGguPjFczqIS4YvZ1N1s7IyMk7uX
         mOTNXMc0EcPuFro4OSsFhrMqzF8MpgDg8e3FLg79oO1XJOVYnI/CP4JDqlcCmcfsSNV/
         o82B+gE6xfthaa5R3J4Jk/z4dr2f5RCjegTU+iFvB6Q7UfMoH6eo2XMGyeyOZvvjKV9k
         onAg==
X-Forwarded-Encrypted: i=1; AJvYcCXWp9zkz9QQFmEL8jkJ3NE9laLzz0cPHKBiL5WxE+RbrCAgPnVJHTwgRWffDPpGE803+kQ0n/B3+D2CfCH0uglrE2FeCmLV+fkFFciBMrkbLK8SUAT06nfJ+hKQgHUMo8wYpn/t
X-Gm-Message-State: AOJu0YwMYmv73MUXMJkNolctY2ORa1lu6z1sZ78QprCkiV6xvQEiYr5J
	srdgH7T8iis1565e/Sjz+qHHEinVQqoY+cU3XPwPuINmVc+Guuhe
X-Google-Smtp-Source: AGHT+IFNhaodW351fInS0gTk9F/KiQFTbb1U/E7OYRCsIfxlD9sQtsc+29bcqRAo49m8kr1HhU3rbg==
X-Received: by 2002:a05:6902:1029:b0:e08:7950:5d2c with SMTP id 3f1490d57ef6-e0b545e3cb5mr1178338276.49.1722026247972;
        Fri, 26 Jul 2024 13:37:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a1d73b2036sm210087885a.38.2024.07.26.13.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 13:37:26 -0700 (PDT)
Message-ID: <29df5bc5-6515-4fe2-a248-1f3d66a6581a@gmail.com>
Date: Fri, 26 Jul 2024 13:37:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 00/29] 6.10.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142731.814288796@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240725142731.814288796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 07:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.2 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


