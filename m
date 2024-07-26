Return-Path: <stable+bounces-61910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A7F93D795
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 19:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E041C23169
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59C11C83;
	Fri, 26 Jul 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7IWXKut"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB217C7C9;
	Fri, 26 Jul 2024 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014878; cv=none; b=fz99hHwBf5qS5kBFeyJJS/OcGS0cw+vVvXEi/twjzgxih8MhOSjBf910cXVgiB0X6LYZWm5zuVDLZzoDPgoZ6MIUgq4RzcGFFx71xjW9OS3f0KcKLvBmRTBw8+26bf4DhCTNJKvUGJXvFLeIWnLT16vDloI6ZSpHIGwp+8403ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014878; c=relaxed/simple;
	bh=RYD/owF2suu5o1Lgl86+/OAfmjGR1ZR4NG8RC5CHgac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECA+EEwIkIWEUX4ZORCSc5YGuxMpx18O1cqsg/nZLROpoqS3xuhhk6HkWyWYU7IJFZ2CK1OJc7wMo06yWdGx9DaaLYaBDbjM6hzRFy+kZ0oSBRCihUIs2SZvJDDPYmhZ9fhZF5uBtNV3UumB9tS2yszi2lIrSjWZFLIF1cQms1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7IWXKut; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b95b710e2cso5091106d6.2;
        Fri, 26 Jul 2024 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722014876; x=1722619676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r97e3GXSwTloPUuX/mhN3eyxcRY/5guMC/hNOxlJdh4=;
        b=a7IWXKut6/Th9lU8F9nOjQnO3KWbVUv04ENVGH/vZZYe05F55KewwD1/1p5Jcr3SDK
         MfoN18XsFrT8+dOkj+1oiTJCZ4Nv9fFfmDbL/eQIWmEuBJ4vKkghbtCA8qQzePp5Wq/v
         20PM0mUqdiV3pKMr1Lkplw0vsBu5Qt4RHDgZDPktPYwWUYtAi85/avT6qI2rtsdbHgka
         4Y7hpcI+HaMW2bkUzjgVVeW7rDvj+DYy/qU/iCzZpnTkaAQcGHP0QpS7xCaLVRonpmke
         m1mDXCS6gzgLNgh1sC3jVmUWzzhErq4hjx2oQHSimiShVtv562RYywqQzcKefFJFA3Mq
         6F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014876; x=1722619676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r97e3GXSwTloPUuX/mhN3eyxcRY/5guMC/hNOxlJdh4=;
        b=I7u3WB4RnL/SY5b0qkaFH0FQssQ4SOW21UKQUArUBABO1BScR/eNyCc/Q8eU2TUuek
         A5XhSpsoDgSNsM3iDyvxH7wLmd2ysRtdYeB9xpk7AFla5+Y7sVrF0cSUSUBfHo0aXJDP
         2I5KHhW0Dj2YABBQi7/2Tw1tuN8wL9fx+fcGlE8qbyuD1UEWMxG793Rp11Yet04lZoxi
         vpzf/Q1nM2XF4nfgF26sXKYzSKtMnbrHz4B8wtISmCJXnSH/tyf857VFMsUq5yk3l1qc
         euCeG+chyiPJovgjab/o3vQ9SOTmjGLHeQng3I3vCrmvi69eKXc5g/NlRDf1syldk+3c
         tKLA==
X-Forwarded-Encrypted: i=1; AJvYcCWj/L6ourArws5tuQ14F+R4zEsymc8PpZO5RRv2i3MwtkWm3DflnSQRz58tMs/w9YEiKVjbrb6YPHhJio0cyEbOonfLVkPM4OI1JkNsAqeyCTcOd6MftcwpK/tu83pxjFNkpbId
X-Gm-Message-State: AOJu0YyNx0zbjLx41JtLzsbBiEqQemG0vvm5//6T2jx5T/taEmvaV7rn
	g306PSy8udOF0FQWfp/hXFlVvb46ZFxPgccp/AD0M19EuzVABaJ+
X-Google-Smtp-Source: AGHT+IE852chFyJktcaioJZzEk32NHvwXvQIS9moHkEEfKOOvbmZFSRHXicbAYVpS0MTx0JcBRGtnw==
X-Received: by 2002:a05:6214:27e5:b0:6ae:ba6:2136 with SMTP id 6a1803df08f44-6bb55ace834mr5973436d6.36.1722014875777;
        Fri, 26 Jul 2024 10:27:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6bb3f9407c3sm18505046d6.71.2024.07.26.10.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:27:55 -0700 (PDT)
Message-ID: <a17a952f-87c7-4ac9-983f-692c61dd73cf@gmail.com>
Date: Fri, 26 Jul 2024 10:27:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/59] 5.10.223-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142733.262322603@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240725142733.262322603@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 07:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.223 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.223-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


