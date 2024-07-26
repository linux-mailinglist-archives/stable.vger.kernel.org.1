Return-Path: <stable+bounces-61922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69993D847
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 20:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC09B1C229C7
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23CA38FA8;
	Fri, 26 Jul 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tjk/KlRO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537B43AB0;
	Fri, 26 Jul 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018194; cv=none; b=lPkP69iYjzTcYWQ4KyOHUkQA69sB4NMHYxRHQaa0qYNYrOA0RBur3fbkr+yrpIvV9IY4DAjjg2jtHBiD/SGfi4SUB871jKsg0gsPn5ny9CUXRfDw9zQhRXb6aeQT28jT9KMrTd8tCMM2+K3sSBJ3wNeG0xJqCzQ+SNMQzib8D8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018194; c=relaxed/simple;
	bh=8ZbgTM4bv8/Dutf4flCW2Qj8W47CiAr2L1IPtzMfwDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FumiSSVBxCGlUiByDXqirgXwkEyJ/EZJM2Vm9AalJv9VDe9OjGYMSeHXkljtYbXkI4lyWMP9R8yQtaBkX8wZgk2YqEBp3hE10L1xmlEOqrO/ebQvxav5zzohkVp1C83CmIp/iNJL7XwCR2loPEkLt0ORYk85BWSsQ0cmlj0NTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tjk/KlRO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb4b6ecb3dso902929a91.3;
        Fri, 26 Jul 2024 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722018192; x=1722622992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIJ5Vdb86u9FSPZw1NlhK84OzeGR0ySDutwUA1pkvxE=;
        b=Tjk/KlRODM2sm3f7mwtGE0tXKWIEK1N6ZKuMdtvOvQB4zqIaJG0LPtOqFlr1hE0CtX
         mrYpZkYJU4HH0mj0VzfLf8sTxWWrhxtVW+PlSvK0glhBFHECbOD4i5VbesujJ8OoqrEd
         TI1K+NZb8pgT/QeaooDSkuxcnsSsueW8YCqhM4mT0XFy4cGPIMjz7dS+Gjeh/U4fDKel
         Af2boS31814YaLHzG7OD4Bt4BFuNVdzVip+/cmHeCmlQEb7rY6hK335jBPM2zCV8ki2n
         K4zW5jSLbnmfEgzNhBuk1j+XQBVjK+6+IzU7TS5hlZFwFsa2FlrfwK+QqFHsyKT8qZ8p
         8wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018192; x=1722622992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIJ5Vdb86u9FSPZw1NlhK84OzeGR0ySDutwUA1pkvxE=;
        b=ZDMYpE3XoLMg9eL6FK3SfiA0cdgKZdla4Gi+62SuhGLD0SN+AhJJOQUuL86nSOBGfp
         Ag84W5Po4VPlrqurFVKgSjt5NlRuz0MGhNB1WZZn7N/lvGSgAp44B9tS50JKGZhq5YfR
         w3Dhbb/6OydKSr63S8ghhBIdeK/4TNKlXStbP6ancvUOqmelzKKRFGaktGlVLckhYFGl
         EWs7WkgHPuwoSOxnvTZNw3dQ/emMLKyMNjl2xlH0fymxiIaU4gJvQNn3cFj0zXIugEjd
         Jefr6h+XEnSGR1qokgJTRGkH8dqtV9D9hJ6Abk+TA3d6HVfHykvnT3TWnhEmShtz+KmU
         OePw==
X-Forwarded-Encrypted: i=1; AJvYcCX2pvBi0ZN4HsWFYkVXFrg8Kc8YFPh2+SrdcUqpIlSgCmelJUnBB//DOd9NXUCPOFjWETqtbF1aaVM1RxS8Qz6Q1A/KWSXMr/QT6wBRrdfsPoJgBw1PhrxWl91A1iV2wXykmAb7
X-Gm-Message-State: AOJu0YzfxStsZ8m6aPltfkxElDwYNRgneumeXt9T8HTGsM25Z558R3LZ
	q66bbXkEqtgPpsfQYis0VUZCa4ha2dlTUcD3HJL9PURpF7i0Eddw
X-Google-Smtp-Source: AGHT+IHWZvLD2KSc9UvLW/4dy4SoS0vzj/rrNm/Vr8V+kM/iz0DSnCcVxsNazp8DmgfomClKo2PPlA==
X-Received: by 2002:a17:90b:2647:b0:2ca:7e87:15e6 with SMTP id 98e67ed59e1d1-2cf7e72bf48mr350073a91.38.1722018192312;
        Fri, 26 Jul 2024 11:23:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cdb7600054sm5813739a91.47.2024.07.26.11.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 11:23:06 -0700 (PDT)
Message-ID: <f185d728-8545-4962-b667-e761acf0fde6@gmail.com>
Date: Fri, 26 Jul 2024 11:22:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/16] 6.6.43-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142728.905379352@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240725142728.905379352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 07:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.43 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.43-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


