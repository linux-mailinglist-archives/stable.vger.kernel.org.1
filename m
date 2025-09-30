Return-Path: <stable+bounces-182844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6187DBAE20F
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D113B1643
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4136E30ACE1;
	Tue, 30 Sep 2025 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAFfFga9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4C30AACE
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251972; cv=none; b=NIbgrzpmJEH5V+DhKfuI4FIT+heW2WyE86ExMtracbAn8jG43XOZRJDF5XznhytMw2v5GJT1UZeA4NjxV8Bg+LvqjF/gSPhUjTrjgBCOGnopbMrdhDnTsAUjx7i3djKS0poU8prHV8FDGUOSSsytXiy1+8kHW1L+haFThIel5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251972; c=relaxed/simple;
	bh=z0OeE8KKG8p4YUEXLYKNB265pXE5/l7+L7QRs6INbAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yvcs5aC2TIAMdLvE6Iv26Q5zPa0AOm6ABhsPuBUDZ/4M2ReC2H/oBDFpWwmChgBFrcW10hLEecNWKnE+lvrRpDJAI5ngq8Ic6CQg2g0qNDC55Wb8bgIL/btCnFzPVBC6DUw1ZfCyfO06/HLHymqVmhBDnoPQacwWqnQNjucnbxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAFfFga9; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7ea50f94045so980816d6.1
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759251969; x=1759856769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYca6WxwMn8N7DVnp/rlZBC4kI148ITA0or7jK+Xv0Q=;
        b=nAFfFga9+QFeev9Asg6weKzvt7V6n+StM2zKnIDFPKsI5fjLNGEzTnTN/Tkgqr8iRy
         z+Z6F1a9L2MRLH69j4v8YeMSG6T4jiYRf+Xk1w7pSKOFIk18+hag+THqBa4O35Mo925H
         U2KK4oasGNw5QZkYBYJ2aegkrcd48lgdPCCvT7o78g/lfmd6bMANR8U5v4e3tCuLlwdh
         ETk9/IqSrO4BpTh4wtbujcCqZbHZ3pM4FHcAIO0HtFRL62INiUUZK+6ilg46NN/LFn/g
         Bh/9lchFzYgoL/7GlcVa+MwgfiiaXVh08NabltizqyuglmrXQjrAB2ROCmQ+wtgoxTzr
         fPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251969; x=1759856769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYca6WxwMn8N7DVnp/rlZBC4kI148ITA0or7jK+Xv0Q=;
        b=EkvVQfYqHObs+zUbkBq8pLG+xTA4RaY6KvdaEdr3h+c1OrEvq1qHIYMT9Dd0/P2/kW
         K/63Bzq4bFtdfsfI4qTb22VpVJ9oow56VjJ6tmM5Hq+3viUuFQFCvRGtMTDRF9fQO/sP
         6X0hJwjqaxUHfCnkanG8O/cS+aSw18n3XYDxoAUUHyMv0wgbJMXQE9qnHqBvEbRehIWy
         DJoOVWbdrFI8NLBv5vPnodGVDuO7bUI69tqAqUmHHPpEG6Eb+kwMuyS/SNfSDnySDnlT
         8cBOut1b7Y1C5boYGSGmJ2A/iVbD00zNFdN4n66DFv6bBwF7dwQzhoWaihBhWHbTxv/Q
         Ot8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU43TPxZo9PYcSE2+jvilmg69vI+4eHbli/nVDs4lNvXwRGq1hLa7NoCcAkQOCnvq3SmIF9qQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysB4RVtF5E6RbwaE2VwHSW4oTE2eWCzkEywsd7e4wRpTwWwDze
	EIAV1xgn+uzYesan1+3vjNq8KVlaPab+6vPm5CCOQ/89gt0BhuQY3Wy2Sj3Cl4Jx
X-Gm-Gg: ASbGncuF9z5t2qa5/Y3drlvJfs/9y8gtTtjMwWIhFUZ3Au/M5qYJP9FxrVgCp+Y51tu
	xxN4j1fwNgBMbT2gVQ/41o5uwnT33AOp/BWo5hUEsAXWE1XVTSSdCK4Z1ljeB7jxc1UuyTfuchF
	5biatjXS827yODrZ1OyIZdtRTKDuUls3K7r6tYwbNihJxmiyp7wyMkjyxS+8stPycWmpgb0lwJJ
	j/doEswg0DYwzUWAvOEsiZ6/rlLFZYc8lFiod3pp+LojbiPtx37OMi7i4elwD+Cil2ABwqbLald
	cZdTvSzrpu3f/1kdKbPTDgaAylsw6DKklCVhldxRZMNSVKBn+G/EqXkmH89C8pbhGh9oU+62HwL
	bxkVbIOHZ1UDebDUMdmeOh2cni8agxRrMTBNRF5RC7thL6jMFtISHVg7/+b8zXeUdNc/bEGHol5
	lB0XDjvMWl
X-Google-Smtp-Source: AGHT+IF4D6Nsl38GnCXyOtksgIhWMh1L+lM9odVVJFrjIv/5VTtQCbZa7dmUDr1LBiNm7pc7h/TPoQ==
X-Received: by 2002:a05:6214:cac:b0:70d:ba79:251e with SMTP id 6a1803df08f44-86997d2ada7mr64406166d6.13.1759251968994;
        Tue, 30 Sep 2025 10:06:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135b54636sm98871316d6.6.2025.09.30.10.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 10:06:07 -0700 (PDT)
Message-ID: <b1e7efb7-ff4c-486e-9f27-1e5b26d4b044@gmail.com>
Date: Tue, 30 Sep 2025 10:06:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/81] 5.4.300-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143819.654157320@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.300 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.300-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

