Return-Path: <stable+bounces-92873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8169C665D
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 01:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9CBB2E887
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC99B665;
	Wed, 13 Nov 2024 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv/fShSA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236EDC147;
	Wed, 13 Nov 2024 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459368; cv=none; b=g0k0jRyNPIb+UlH9C7gwZTR4SiR+mrPeWakik035nw434CluF8l9WZdeUjITgHGqR4rEH/QvmWYfk//Xyhq+yQcwZjLtzqCOA0/GduIADhX7RhzpjNru5xZ+k+vXxMarSOSYHIb0RDAlQkmIwVyZaNoE2ARgOg0GVgVfG6HuvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459368; c=relaxed/simple;
	bh=tu2QUsS93zZGCMD2+eL17Dai8uTRj7X5W1bf9i5ggnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rbj9KyKDgHB/CIprWyhIuBBMFU93BwkHRbz4aYN4Kn7vDmCtipx65Dj/VUyWYyieTmWk+4U+SNHzPS1TV+S/iMRkF/LIhj8Wxcxgs2dgVG1es+t1mZZ/N6xG85gxbpTHf+Lp3c501DAt6LRwwq/9vkVsGXbn4R02qjmygebGz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv/fShSA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso5058731a91.3;
        Tue, 12 Nov 2024 16:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731459366; x=1732064166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VSVWLrKSqwhFtPgf2tHeAvLe7Jm7DcjSOJdVi3kidJw=;
        b=Hv/fShSA+AbUp2tEd0Us1Im7ow65ZHMFW9V7q1DaevpkHuW88G1+9oTsaB4BlFKVJQ
         7sWeqw44HC63N/1sAkFWSc4RKIufvbXU5PipkrRE5ckm/VIMoUxNjJSpvUYu7he2r1sq
         S6dNQpC4OEa/1RYpamgUToR7vs01ay42X2dWyXyZuDX/w7hZJ2t+Hs/VaPoR2sK68TXC
         hYKoBUV4gU7Zuozb57dIp4ylwPz7xRuteCcF8DiEjpvZ4aeIMuGgBmnXP8PxU36hsUS+
         AzKMbY05x/FtQYIRv1S3yOiLHqHoasOSzJJG+nezRD2PLDOXi1qQzBCgY0kB9YvybYkZ
         lEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459366; x=1732064166;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSVWLrKSqwhFtPgf2tHeAvLe7Jm7DcjSOJdVi3kidJw=;
        b=we3e5OGS5SOHLKsl3VxDEpx2g+CAkP7T2XrOHOX+C+HmygYj2TiguOQqBAbjIvBupS
         OLuyKNHkYao0pjPwV74F7Djx/kU7HEEMDmP6FHHd8uGvT63YL349JoiA4bMqAf2Qf6T/
         reS5P08YX1daFLec548d+bSm7NzKP/7OYKc9bJ8kaiJvXlMutxKtHMCeKlPffY8uPHwp
         D9Cw8kq+srW1aqICu0jKW5tBMaE+RZ0FTmsBa38X+o6jlXF1hF37Y6HPV5PsFGrDluDm
         4sT9jT4IDlNg8wPuo7f7E55QXpXcDbVB8SEPlXNBX4WNghzTln9c2wrw3+TvNFKAKUYc
         i8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+19VF/difCUwKT1fiPsVoBsSB7oR6WbnnpX29iVkJXYzYS6W4k8+BqzD+dyBu5QAv3LyghNrT@vger.kernel.org, AJvYcCW8e6tdTcKnqiT4o00jkM7K7VCYseJHxePLKlR8AFHf11z9vfjTG1KvsI3twTrICaIX4cSrp9b241pC+vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWZPUmxTUTMm8IU4/Tvyp7+AsrB18I1ROp65IIxbUtZII27Dk
	64U9JzMsySthjSDd8Me1YFbDqzmL3x0Vc3YYZ4mwteTBtL7H3aidFFJDMg==
X-Google-Smtp-Source: AGHT+IE1zn8+diw1vdZ0V9SYrk5CPYYLAI2vo4HL7IazXgCK4BcVv7dDSWqAtJPdttrv7DXE4LB2nQ==
X-Received: by 2002:a17:90b:2ece:b0:2e2:d33b:cc with SMTP id 98e67ed59e1d1-2e9b172e0bemr24217503a91.21.1731459366380;
        Tue, 12 Nov 2024 16:56:06 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3fb5e31sm193190a91.53.2024.11.12.16.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 16:56:05 -0800 (PST)
Message-ID: <e2eda595-966b-498d-8694-c2694c0bf136@gmail.com>
Date: Tue, 12 Nov 2024 16:56:04 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/76] 5.15.172-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241112101839.777512218@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 02:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.172 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.172-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

