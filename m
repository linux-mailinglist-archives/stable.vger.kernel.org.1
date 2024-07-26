Return-Path: <stable+bounces-61893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7AD93D6F3
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753911F247DA
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37E717C232;
	Fri, 26 Jul 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UlUawq5f"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C392E64A
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011747; cv=none; b=hN/4WeM9CALjKh1lLSRvMmzx8NPnbkiqWwBUWlIizaOcECmIC55YfXssECGZ1in8Rvqi2ePDyH8eT1XQY9qdaNSG/EvZ4v6PfhnLxSzeGDnvKex5GfMRvJuGeFyhV/bcevHJCrqQCKrGKcN1YVhuuUy/tWstzQkyAnfRTIK047o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011747; c=relaxed/simple;
	bh=XY7HymytUjgM+8NWLDU54wb/4FH5oqVN7Nv9uROTHfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSHCCmDhYFJX8ofHlzGJAnPAuC4kkagVdDSsxJ2fOOZhT66jCf7bgCn/jQiKufFaLUaQeZK4R6Rvv1PhQcLkvbWDe4G5ePW7Yck6Bhf3eCOJ9xWweaoJBZZVsc96E0kV8hJO+Fz3FTZQPaGO/1ePRgQSp7w1WfrXz0U0HNSXRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UlUawq5f; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f8bc5af74so7038539f.3
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722011744; x=1722616544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRqdg9zdgOn42cgCu3J2giuAnSl1Epr3+bFdL3aeFPc=;
        b=UlUawq5fSMJbDGnyKBxDlejZwWUNxu6T9uMZ/8g6YRZnbgb9VPlZc46jYRM33m5YVc
         AotmLSYBaBIBTJmIPXXfYBQXpWTQFkW4BlRJZ/qWTHjigDeojVzotbhyy3Xgd8ryIiji
         VzxDnMlZVDF8Ic/pKr3BwpkqABZMsH0wYzJ8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011744; x=1722616544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRqdg9zdgOn42cgCu3J2giuAnSl1Epr3+bFdL3aeFPc=;
        b=NHHDPZbSEbiGia8rMFOzZxNAssmdbLoTUfNfDz9iSHvcidEbflRL0bj6OrKP3lWl3D
         AKxzapruZYp0ip9+OdXOK/o4mn4W/0UoMMoZPKhtwy/IEyG7SpZh4/ugL//bKS3i5F4w
         mOYU5FjlynkEwE2xkwjhesuOCti6x7CG1QiAbroIhfu0sdH3aEZ0wrs4iXWDSGfvLoAJ
         0jtcnsIef4AYD4vXoexATPW/y1g0P5DELipFNa8Au9B9p9uG+duWNSfxKeAw4hj+2czr
         vb4sDHu/dm51UNcGQkkv2BT0opHhoDRrUOrrETrKfIT7VG6zWOH7C268VrLQ0K51dI5h
         srpg==
X-Forwarded-Encrypted: i=1; AJvYcCV5esFwwbiocpkVGmtlxzLxCTkrPO0nSb7iRlmhz3nK35iV7i23lg1wT5TRio7+yqJXoE4f77qo4Kak8mz4qL3WrpvYKUPp
X-Gm-Message-State: AOJu0YzzZ8XPxmCiH/kNzRCjJkF21FX+3L4m1XeAEg987VY19Pq0mh5k
	1DdEU1DhOtnmxF3nJ/YpN2BtdDiYbuZDPyGM6WqbVKdmsf/tbharSvP+q9TD3sDEMc1QKcmWoI5
	z
X-Google-Smtp-Source: AGHT+IFeoDN0Drm6gcoPOSZye7+XsJes/VmkzbaVf1yHuzlZYvG68vGemgBrOcVeA30R2sMZKfn+uA==
X-Received: by 2002:a5e:c70c:0:b0:81f:8cd4:2015 with SMTP id ca18e2360f4ac-81f8cd421e5mr185814939f.2.1722011744093;
        Fri, 26 Jul 2024 09:35:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa3e10esm936807173.10.2024.07.26.09.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:35:43 -0700 (PDT)
Message-ID: <bcffbe4c-3eb3-4c36-8d79-a46ffd6a58f3@linuxfoundation.org>
Date: Fri, 26 Jul 2024 10:35:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/13] 6.1.102-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725142728.029052310@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725142728.029052310@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.102 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.102-rc1.gz
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

