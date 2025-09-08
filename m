Return-Path: <stable+bounces-178842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D4BB482F1
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC52F17CCF7
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C022A21C195;
	Mon,  8 Sep 2025 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBcoY00E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378531DFE26;
	Mon,  8 Sep 2025 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757302933; cv=none; b=JBU1ssgovuLZzGkKcykjqMBmomA7w5nd6fyTBM+yhv4Lnb9mU3JWfOCMTjyi5SVwxuMjC3izw+46pbFdGaHgfKaxStxV78LX753NvVrj5BwC0ABeu0gUV95irNuoBBVDjRo582FqDyNamGbT7OGvFaiM7r4RpvTX78QiPxzVcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757302933; c=relaxed/simple;
	bh=5M+38OXF1flKK/pe3Rn3PNxUJNkR9P158X1yqECK7ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JL7jHwJ/o60studBDbTfhQQSFvzytxBPsVZhIoQ4djADsnGFAbm3FrL1nPHhn5fujzGxFjXJqREBjXxyxoe1vnMp9ZrM5iiJWhtrAtm/4YD4hgWqQ508eGsEcBe59hgb5K+v1COjof916ZWXcCS4tV4LY6Fse9/hrVx5bu9T24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBcoY00E; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-772627dd50aso5324099b3a.1;
        Sun, 07 Sep 2025 20:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757302931; x=1757907731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+1e+0HUdg61yWjXPaBCQjQfa2BpP6AkAEc+WzyDYgQ=;
        b=QBcoY00EYRge0iGdZFkmDFJE7gU/wqMaEF9gu2AuPVBXJ/YjJJjw7wAGF/BB+IH96T
         ztXPv2D7kcTRHskB/Z74QbhmYHfWC2OOTKxrDE3bTBaOlCuGLslyDsMIaBXRbf9IwMSV
         kV+TRb5CczScNGUswtar6S+fBv6hVtd+5+TNcs83M01xw4smIv+BF4K55ekp3M9RozKJ
         M0E34kiQ1CSHj66Fc88G/UA/t/9toDEXpohtKSK4ITYlBJCunyE94ehQKfmgykH9IKOv
         FIReaONC5cCZwWtwG2lNW37p49YoIqdlHxRK07C924u1FPiCt3uh3Tvk5GfMOPMH4Q4C
         L/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757302931; x=1757907731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+1e+0HUdg61yWjXPaBCQjQfa2BpP6AkAEc+WzyDYgQ=;
        b=QHtCvBOc85ZRu2stOMidbS9D8YD9vvtOZEpHWHY9/Pn/7Khg2JRrfrG9Kev+zNCuLm
         EVQ58VOIYlAMGJZaSn17IJqp9WymAWulTjbwBgoSyXNP1V78iOvku2m/7kJ/YORApjfz
         FUyj2vWKjj8GG1extCZNQlEqMpfPOIwfh6t2BHbzW5iloCVHAgf0h4bmmBHSR6N7SH4I
         jNylgwsGCitC/wCDKTG0XeZai6AdNF/brHpZudV4cB9nHxDn7RvZyM1kpwLE/PjzAt5f
         iDtWPxDdaRNac0MGvDfC0C9HPkdF3vUljQvIIGLy/ldzWWKt6TrEibTexrePZq1jELSI
         QKEA==
X-Forwarded-Encrypted: i=1; AJvYcCU93wMiQ138ZZCWnwqm+VJyB9hE5L8kDZ6lb9qhitRIrpSOfCkeZBHKVdwJL0AAnbkkAdmMMfVmOOcVn0g=@vger.kernel.org, AJvYcCXPLQa/DK4stanD8CD3Bcl3TOpx6eyI2E6U5FlVW4A4a7FD/nQbyHT27Dxl8hAQDzCJdL7qMLYf@vger.kernel.org
X-Gm-Message-State: AOJu0YyxOgvijn0Aax3RA+FLjXzAuTizRTu/zwFirYQGxROhgTIuPmyN
	1UlsKXU/WjX+UtlOqOPsI2vxQfUjblppBphcjTrReW3Iaj2eHlC8fY85
X-Gm-Gg: ASbGnctTAApHb+jjgixghBGZfQ/zuP2IgIc/tpLRn9otV2WCYq7yCXomyP9bqI1hayb
	tsM7QYaXEf67vYI1GVgoh7BVpwDaKUZuGf/cwAeg1JADE7iau76JtYKNRBRZillH1njZCwVzNEY
	wG5ht61PBNl/bW9QlYjfsuzXB28TN+Lvli2D4V+btQf4OJRQL5zjm8FK4ybADUdcGQh2v+dJfF6
	7x/7KXa3XA8WTfmr/GB8KxKgJSC1O8A5+EFrrj639i8I/1/fdOhjL7/R+JPs3axrfzXmelHdBV9
	EgtxIYVy3JaI44c4nekn2iaoaPCUVsw4Ob6ibFwq5Fpm6fAft7u45j2NpTz7MFOHDz0V7GAK8Rj
	/edRsnXKiCRwXior2+ZS2CnAMMOhl5Y+tdPcX+SDlg1cQDVwZ/xEdK8TYVCLSIsDS
X-Google-Smtp-Source: AGHT+IFym9/ZyWlFSAtj45FEcnWbuZrDZ7vdDlfKQgVCfxByEEg/FOXBUbqQlwPkP1QsceSJ5oG9xg==
X-Received: by 2002:a05:6a20:1611:b0:249:467e:ba70 with SMTP id adf61e73a8af0-2537d380c42mr9254262637.24.1757302931335;
        Sun, 07 Sep 2025 20:42:11 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb15f50d6sm11545588a12.0.2025.09.07.20.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 20:42:10 -0700 (PDT)
Message-ID: <b807385f-91cb-4fb6-a0d4-52d240ae2757@gmail.com>
Date: Sun, 7 Sep 2025 20:42:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/175] 6.12.46-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250907195614.892725141@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/2025 12:56 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.46 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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


