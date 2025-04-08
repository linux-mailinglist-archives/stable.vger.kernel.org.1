Return-Path: <stable+bounces-131859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A691A81847
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 00:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A481BA36AD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFD61DF99C;
	Tue,  8 Apr 2025 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpIbJplZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD692185BC;
	Tue,  8 Apr 2025 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744149920; cv=none; b=Cs5lviTqblkUlqeBpCKmlbTE5eE74+h7mIsxAwp7Kia6ferkEmj1RluboNy5Fu14VQx6kr3wkegDzr8sDra9r4YE0iWhj8rqMSAo1CmfnewYbX0f7THXkAEp7zk1gJ9pjghaSvkKQOQSqyrUk1ItMVL2AEi0UoERAJspVRx6Rcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744149920; c=relaxed/simple;
	bh=PhBczZJ8hsG0pnUBRsJWHROfM68lA7GD5Xh33hyqQ6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqcC1ffoVy7Cyeu+nBWjvEMlGXpuWGv45VvKLKibDuYMRp/XJA2tKTSNk9uYDYNdIUlVwLzurR3IpKD4bWXAyWh0768UepNG4s9JEWGByEhLMWbKZeWll2pDUPrjD03TpvymSPS8sRquzMa44pNflSxBMlUTFEF39/VMpQpeygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpIbJplZ; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c6ed7ec0a5so2111067fac.1;
        Tue, 08 Apr 2025 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744149918; x=1744754718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UUwi7AgniJGPUbtu8jHbN3YuZzZjaK7SIDC37luIQ8A=;
        b=hpIbJplZ/NNFu2UxIQij+oYhsD4qIhtn102h8td7POlyt5je5ispZv653uqtWisAWR
         tmA1qpCoQ0225twhvbHAwNtIkBTnqGJwz9eHESILSfFc/jw7/m/x2cYyTisOq3PMvm1N
         yQkt5qG1rVHRmrc9cprAznrznjpbLWgtx7FlJowMGXt6MMux6Cj4OniMrX5PlZBkCt6I
         MgC2jHNsT0w39ZPlIlOts77O+toD6yYchA6pB6WjMY0hBY3s+Snlh/QXUkaaAPTq+edO
         55gfoCODF7w2T0NXMEgKufhUn6CdeOOD59l1mYHvWcMVMRlwZvE6hWGELXPQfSualGI0
         BQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744149918; x=1744754718;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUwi7AgniJGPUbtu8jHbN3YuZzZjaK7SIDC37luIQ8A=;
        b=oYHR3qWoqBetBAXiIXg9rDmgEvPUPwovGAfkT70Dw4w3T2mhwM/a7G9goo5EIS57US
         KXWZMZc+FSdAeIzkHlzNkWGSG/xWIVt6EF5ujOLogKv+aCMINqfXOcg0AVzOHe2ZOlU6
         s0bg4js3qXsJk8Zd4/HhNcd0MS3w/3zQC2jmyBnuR/Xzn+ayFGub5jSPEFpaWdP3UYFa
         5ykHn6Q0M9AVmeFXPOJXFC7mYswJI+ZhEAES/GPyxsL+HUvEPmYc/QsSkuIGbUQPxI/D
         WB7wiTe7WeB4UpVXnTl3YtRkI56Z7+HAyWK/CazoN2DHWE4+StpcaeDcuCC2ogUiOqPU
         +xNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfUgh7d5MmBVeGJV/JLX+OUuCLYSCoTBD9XhdGH4QkxZ5p3Jzu+j5sPRaf+xkhSC9pBwx+8jKd@vger.kernel.org, AJvYcCW4k272pDfmczmCldHNdax7o8k2mmMYpZe9/yQfWz6EPFBlS6emSTJA2X5F6kK02d331VSBQVZ4qQEdBdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4iVATLcMdkOHQIZVlUp9u2OOoIAf2HFJXqk60Sdn9jVQa/lir
	Gh0C5ZQsFrany38/FOTw852xQ6zQBR15Ks4FoWklLtYKmlUwzhGQ
X-Gm-Gg: ASbGnctwSE6+OZXOG3tcOkPsfOkhUhK29kl7SSALeIfkllgBVvGWvgTjh4DW+qHm6AF
	oFwMeGyy7F3weq8uiC9CEj2Ses4Kg2rkvZL35CxFaDICcJOlzdormd9cd3V8pN90dcQEO2Jg6GA
	eAcmr3kGxwbO9w1iKr2YcLwJVpNuYuPmybPfRDcDqK+no2OF/nhK5qJghU5zYciPDKoeECAJoH4
	chpdvk/tjM6AbIfDgQ8+P0wY8SB/T2XLGy0/QwAYawlpEhER5S1nU0aMl+8aeDxNR3v4iti9P0c
	ALY5dpG5Q1opZnZY/DWTipou53eooxxTWh97PoGAIfU5z76oFyOFYjwIKZDQp/ygdX81r54B
X-Google-Smtp-Source: AGHT+IH5Q5WDCvGV51bJXtpInSnx2BroalxSxCQ7vk6Dfhz5SkD8g0if4xsv/JZ19NpXNfWWBDndnA==
X-Received: by 2002:a05:6870:cd94:b0:29e:27b6:bea5 with SMTP id 586e51a60fabf-2d091b02393mr110384fac.25.1744149918016;
        Tue, 08 Apr 2025 15:05:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d093403f98sm2465fac.32.2025.04.08.15.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 15:05:17 -0700 (PDT)
Message-ID: <9b85acce-5f37-433a-a5b9-c39125eed8cd@gmail.com>
Date: Tue, 8 Apr 2025 15:05:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/204] 6.1.134-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408104820.266892317@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 03:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.134 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

