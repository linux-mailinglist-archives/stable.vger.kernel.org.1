Return-Path: <stable+bounces-116328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0755FA34E9B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 20:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEDB7A43D5
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2BD24BC0E;
	Thu, 13 Feb 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY5EuzZy"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72524BC0C;
	Thu, 13 Feb 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476032; cv=none; b=XlivwJA5t67bc733zB7s9BOLkHaH3v7IhfaH9cvIVSyyuhuScc7fFxRmWuvv4/xJUy8hBo/w8hf20nOU026O2Jc9PfFpxw/Bo/muUXO8ODgbz8D1ejYsz7qSN1lCwlLb2Ga3l5Ub1k9oSS+I2wNihrgne+183BrSV8HJuhAdLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476032; c=relaxed/simple;
	bh=puLrtcz6AIAWbE2vZFFCXVMYzIc06mHsrui5HAiPCPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZOyFh8SW3akbAC8KJVJyDwQDz+DQBvwWqok2fxMLlOR66XZHnTrfXwkV8Eiy1+JcfO0FYvKnFnovrhl2DBziUAoVmCfw8doxfm6jhl6AiRVAqJh19tfGI7rCFDCYfdbrwwyWyQftqnjKfj+PfXFTesIZave1EdNY2XR4Bm08GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY5EuzZy; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso759031fac.1;
        Thu, 13 Feb 2025 11:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739476030; x=1740080830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ejSc6IfEiSjDT7Iw01feIusRQUmaVdCjxM/l2LoismY=;
        b=CY5EuzZy0G2qCcLoFQ5sFjW3z+rqax+ZoD7skp46GPFP98vr+r5J4OMrWYF87wm288
         aQZIp+hNkCffv/Jvd1GoyJWNU2GmtNDADOQMZfTLPPGtcOZN98UDSNTFelyOmpqBUGkB
         7FI1vF8/KUkmmhkfaaqU5er6okQTclBmrjZG4iDZ5rFgjY5d8drm62WcxeF7Cblcc5ph
         i54DTR0p1lmab307i0Fq52DrGnl+xtj348MX48KWEMsh/dFOwmPBcgE4qEnxndvEKztd
         dXMAapv5p3gvCtJRAooKZJ1AKq8GHkLvkHLCW6rgAtauckVg0EzKlBeF4Hs3rEBPVVaK
         DIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739476030; x=1740080830;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejSc6IfEiSjDT7Iw01feIusRQUmaVdCjxM/l2LoismY=;
        b=mPxTRDzaVv1Tt/8Uqcb6kd9cppyaXu7jfIM6h+x714hEeOwWmHIz9YqYtpwkHgeBp/
         jith2R9o62KkJNNj3S4c7NJAEm0SFmtV65+2HvXoEGx1gAenCu/ttw+UQ2XkNJ741EBU
         vR4v6p9IlYelMsaiRcBNHb6B/zK60Nb6ay4nrRn/mOHkrhSPmlG82WKb9pWR8Bikbkui
         iipmq8eg9b2YM3w+JFUsoLtpIH0MSGKrD278UjmiLsr18ua9x0pVIugh4K0HtejUdY+O
         Vi8tUvliGT8ba0Ju2R2NZ6b1FuXV/LsITJ7p9WVs2cN5SqleV+GcaoQKlT5vOr5ktoA0
         3/kw==
X-Forwarded-Encrypted: i=1; AJvYcCV8dRMcFXaKUR8QGchW9wSsCWUyqIqCbaqYEH3d9FhDFKv9MyMCaZWn1g8anDM01yzQCawCaZsCBvcRWkc=@vger.kernel.org, AJvYcCXaoMcN2QohZ/Ohk0tQaOro8fPbuor3o/c5D9gKBCCRHbTDcE7X/SRNj9MiEh55BNjE+0Ya+z1b@vger.kernel.org
X-Gm-Message-State: AOJu0YxcruwOId1zs/8EESuKM04bDYUDrwkmw3ef5Ya+RXfxvE5uZ8R6
	czxpxLm4Nmbac/cwIovbInFuR3zAcnnzr0e8Z6lk1w5T6jAWgHXl
X-Gm-Gg: ASbGncsZoWUwDKoYNMc1Vz5/aBbutTR4UIxCEWit2u+0kdZCZeIYvZPpmFLVLtV+pSK
	0rdnopQcm3Y1DaAv1UYyt27Jdl4DcLxHT8cE/Fkx5CVQG1/k7ajMCCzWKgHAtvGH5feWzbxWrco
	2ZfMRAxT+V+alj6x8F9EyeyzqEoiudr8GL6MQO5JCH3NOrQQArJsbljK1H5VghTlylJYOInjOZ2
	f2rqrw2XriO0WXgzk7XL9X57tp6TouLNg7aq6FYVmdjtFUr4T+GYMggy+Pqlg5FWXA/rRSSk69l
	9uuvuVrkXBr0QRc6IZhc9PgXCVgY8gZIHUF+G7ITv/Y=
X-Google-Smtp-Source: AGHT+IHwRTZarXLdEKWzV9O2i3pS1uzAWAz1vppIh74WiI7c0L9xdzsJdq59YLvUZmVxAmbbveoh8Q==
X-Received: by 2002:a05:6870:6107:b0:29e:3921:b1ea with SMTP id 586e51a60fabf-2b8d67b9020mr5774131fac.30.1739476029625;
        Thu, 13 Feb 2025 11:47:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b963a100d2sm1011611fac.44.2025.02.13.11.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:47:08 -0800 (PST)
Message-ID: <0fe544d1-4d32-4b5f-a543-8fd056772db1@gmail.com>
Date: Thu, 13 Feb 2025 11:47:06 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/422] 6.12.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250213142436.408121546@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/25 06:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 422 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.14-rc1.gz
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

