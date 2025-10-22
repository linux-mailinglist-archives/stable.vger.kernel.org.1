Return-Path: <stable+bounces-188869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA4BF9C3C
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 04:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0297319C1AC7
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 02:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790A920E704;
	Wed, 22 Oct 2025 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJD4Uysa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D415CD7E
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101307; cv=none; b=FfxL0FcAg/AmJ9/9JJ/rDz9bmAJoew7i1pjnHP5jNOWNxiDD7TkocsCM8WUHP645GSc7X+FoP1tLnI/2oaUkb0AUEuUjo+yURgltVx8eZyB1Qfwo3vdLrTYUPXFqKld0dbHQBEO9Fylq9S2jz8cTtCFyeOpbbjHhc2DAqW518HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101307; c=relaxed/simple;
	bh=2ihbmTG7aYO6isgKBBo12eNmNVhYXXQhMaLYdKlUogE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFtUeb5FXZPVWGZUtioQgZvbJKvBSpYgIOa08/YPyWBWx8hM3K6VMEM7ivCUVszNwDCotuRwW3u7M+hOCNyNIz3bYGv4jOD4N4unr0HXfCTW+3Brri3yEo2EmYb/Vl5p7FTin/x2PD+wOD2C2xTkHI6/9ZHhNVbhDVJH2PHz9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJD4Uysa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so5034838a91.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101305; x=1761706105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fb9NiUGusZmP2HxYoohhNZQ3pvpdldxDNGCkCdvFaz8=;
        b=WJD4Uysa29+Cz+aabQp2MWGsPxogkQErHg3Wl+rF6KgQz0Fbm6hGNuOPIwEB4Uy7Zf
         1P6TFBC+p0eo3fDn2Hu8yPBzb311yhYgs1Utha0SAdL+J4TNSgjo99mNNrafkMfua8TM
         x7HocjXYb58PmWVCE1NIUySq5vsGVShIM3zGYQNAWrepMzEIGEaNfGbHlrY/LJDm3LRY
         nDt+YGl0PGCfL06FzGD/iZqNikdruxWIG18nQN9gbZOHTa4hU0No675u25ZdLmoi15pE
         euk+Y2FGYer/02LRIMdKza4ppfRgQnbe7DVrAuq6JDy557bKdN7Tm6oRnTu5GBzJkY5w
         aP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101305; x=1761706105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb9NiUGusZmP2HxYoohhNZQ3pvpdldxDNGCkCdvFaz8=;
        b=KKj2KcIJtdH50U1DohR54qeMEsZqmLxtOvCUvmXf+P9hwjsPj+oRYKsvPPXXaeM08K
         nYa8TeQD7RABmeIGrJOcLdkf2x5s6BclAVYGZnjyRX/iMbqo/QcF/5aktanCmtGoO11J
         IlzJZkfo4yokMk1n+XBW3gh9XurbuWlKp88oVoCDecS+/kWbojiyZdG9zmgGpu3A+sRi
         mATgvV5ezQ3aOOM0tgk1Gi63ml/gZ+iS+2vuTkgkNqNPUDu3/EaBby+flZCmjWFa1MUc
         7WFyLeFzuzz2dXd+sb0wHOHaDarN7jhWoKN4xq4C1rwkpoEs4ygBpzl6sErE+j+k0fs2
         SmVA==
X-Forwarded-Encrypted: i=1; AJvYcCWNV39giyNK62N2RUhUizdv0DzRYcPtM0K9pjk/rW2kuGHB0xEIYt/co2ewfDcPJdGkpyrsQxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMjSjQbAv/53WDOY0CdTZH0tepRnKUVQaZOSnqOzqDPvkgWwG
	jrqSEDd+asczX530pI49bWqHKbGn9DvwAflCci0HAkQxIk18b2tVZ8A1
X-Gm-Gg: ASbGncvAWbFRstejc9Xf7EDOdZ/5vRNYHu5z4qGPxABj0oh5F01Tz2XimBcvVV6WDEJ
	JeuRqjUX9J4x/fUoANijxHmapYOCtEwbnxVxnSunuDSOkMvLFHZY7blcx0xg5tOlTV6f+JdlbWH
	wlnA7lC1Kmqp8STxRl3M7C6aTdA3UyxDC/M06Ow7DEKXezRe8kvQr/kkRhgwsRCq4ERIJK1e3HU
	UpS04xSTt4QSVz21BdjM76R2agWwZ9/IGwMu5NSHwfVb74aFpvgr/fQ9z55rD8anPm+fmDqNx6L
	QuyU3G3J+wYCrf/M4RMkDAgXAJf8+CFsFcSPdYYj6mUSIC2gmhbzYybeLTKECLwoTczSMjGD1rT
	LR8XelGzeqOOClrvWJuYReG2p5SXdUWrwy1jM1yObz8ZtBCDz3ipD5ogKOnv7iQNJXyfZS34iam
	nNKdA+WE+cUtp+NHyX+pC3/faFGMFCyNpXkMhmq2DlnYytLa6x+f/k
X-Google-Smtp-Source: AGHT+IHUH6QgXerzHyeX4iRldiExQDI3lqMQbQ+JkPENI4w+BBTAZQF3J02Ulp34lZmp62c/SVXYMg==
X-Received: by 2002:a17:90b:510d:b0:330:797a:f4ea with SMTP id 98e67ed59e1d1-33bcf9090dcmr21211755a91.29.1761101305056;
        Tue, 21 Oct 2025 19:48:25 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e222d8652sm1010138a91.0.2025.10.21.19.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 19:48:24 -0700 (PDT)
Message-ID: <9e2eadbf-f380-443e-84e7-53590ee54f2d@gmail.com>
Date: Tue, 21 Oct 2025 19:48:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/159] 6.17.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251021195043.182511864@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251021195043.182511864@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/2025 12:49 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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


