Return-Path: <stable+bounces-154235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF069ADD9FD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CAB5A18C4
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4733B2E54A4;
	Tue, 17 Jun 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM3yoCnI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05582DFF22;
	Tue, 17 Jun 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178538; cv=none; b=RXGGxLmtVLLAxbRfsX/3qyB0KcfwJDxe3qvp/tnlsPscl6cel+KL7fbiMtbc0UuahhVESS0xhZRYB3AVZ+nCzbvzStMG4ODLRGcq6SqQJkeKTFQyGQO+RlU4762NA8GSrAW6wRCIs2W57CGyy9tgztk7yjlWeDSPvCzRw7SMVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178538; c=relaxed/simple;
	bh=6LKUcqnfxeqdiEdGbuyyfPQbUmMmvb9HOTZrRiG4ZKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzJMdNecgsdL9rRnwdNAge1fWeIklBjaxXUV/QuQeNXBKJXnb3G95/sJx62JRZW8dNTRpYO1XsV5sCnumCUGSn9VzNnvG5c5Tijqwvef0RfOB+P6WqrvE3a3TB+/ilLt6RDoR5l3E1c1wS/u8TjXHFUgUTJVjcm2m+ixQ81yiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM3yoCnI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3192eab3c9so4000590a12.3;
        Tue, 17 Jun 2025 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750178536; x=1750783336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rzIr7BVtoGiV4ICDQDCaTXyipt4u1RSoJMsHT3Dzh+o=;
        b=jM3yoCnIP8RUoHgbaeG5+CNYKl8MMdA4DF+1VSwk+e2fT7x3fqsTz+pdpgaKobT5M+
         HyZbIoHRv6v1+CPDMitb3RXzV4Ivxpbt3ChU9+5Hpbxh7D/cH26tRJC3tr1igx1eWV0N
         4s42Hj8N4EAiW4hCVPTuke1aPxVXxn/2yVY6LNfw4yFlq/34K8qEdojZw+X3kzIgL/A3
         LIkLaPA1PdH0/1OuCs+5FqYaL5HF3bX47zTSshkKUp2RbfCuT08stG4NU8WJCihNYFkc
         gDSg/sbzq6HEjawhtRIWhtloognOR8LyB7cVIz0/wWiOmoNYsGSTK7Iwb4AZJ9My6toE
         a6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750178536; x=1750783336;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzIr7BVtoGiV4ICDQDCaTXyipt4u1RSoJMsHT3Dzh+o=;
        b=SNtjFhOAn+e59Gw2fcSy8BClYF25teA+2/tF13o9Jv+TpN/S/PuJ9RypeGSZ3g4HoI
         X3/fmKgh9h+yH+QwpOUrF72EKWc1iLEjr5S4pLpQpvl0LrpHV+b7YoD04F2jUBs/xFm6
         IAAfSOuCD3C4vFDMPNsTziiuqXKGe3BFLUHk62rlnWyW4ndov01JAyIaltnVNLe0abw1
         +xjlmnSKsVWqZBz2u3Ac/sc3LgpqZM2B6KhAwTlwwpGIX7diRVZRAzwgJzE5DFmQwpGK
         1K2zoqPUbUmTsQp/Jp8hB3zT8hkkDOfHW76nokg2bx+AMjgZHJz9Cqt9uuWVfEfDqanD
         zgUw==
X-Forwarded-Encrypted: i=1; AJvYcCV/j06YNQXD8B5AclCUOrW/KXOFoOZ1ba7h5gEofUJChMK1pz/JhJzhT11cCWoz22Yn4il9Potq@vger.kernel.org, AJvYcCVps1sJaDfsYJkdGbfaI1NRdkM06M7S8Xg+utWNdR3rHrN/HiHIP8Th6jOSyQxUNArqbAHCY1DDI4JW7L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1L5KWuhxt78FWuUFu3Z6eGzbkXes6fmh9vEafj63e/EDBEoeX
	Qlw4BCsOnElc5sc49mNLpB0ozT8IBJRxW/UYW8GSrDvsJSqpYk0c7w3u
X-Gm-Gg: ASbGncvs3UqpyOGlb8b5of+2xMx2g+meOsx3sNhcYG2GqlEqz6OPGOZITWUaYzrM9vz
	gixUTXlcrl+cSrhPLthNJ3Wii5/16qCkgXOokXG5kIHC+dxCNF3LreKbaTf3T5PnDEtbx5/nTUl
	8pWIJ0zWECdRRaI1nc/BN2aAyTIoLUq15tfxYKlqIavkt9MkMrJuVWNJWY75vATnLz94gq/7ciy
	j1wIAoU5HXQz1GinZyeC5eoGB+LlWrNp0Y+7xyrP0QYDrb+1aQ0wRwumE3om8rSeIsxJmGjG3GL
	pEPqH4TWr8yL90dvInnHoevpH6lw+PYoF7zzfS7Nzg5zHhwC9wxkQ0+MJbyhdR1X4EFZ5WO5bi6
	LsoBQXys6XQLwXcTjmOKroEwS
X-Google-Smtp-Source: AGHT+IE2DmbJ7Im7JhcRZgi0/LOiucF2cGq00KyrSPkLTmUfZKiWMHrA4gNpzPXjuaEi13PvUV0pCw==
X-Received: by 2002:a05:6a21:9006:b0:21f:4ecc:11b7 with SMTP id adf61e73a8af0-21fbd57fbf7mr22136222637.36.1750178535804;
        Tue, 17 Jun 2025 09:42:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31886377a6sm6970488a12.71.2025.06.17.09.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 09:42:14 -0700 (PDT)
Message-ID: <a8938507-3708-4dfc-8407-845cdd0480aa@gmail.com>
Date: Tue, 17 Jun 2025 09:42:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/512] 6.12.34-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250617152419.512865572@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 08:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.34 release.
> There are 512 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Jun 2025 15:22:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.34-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMTB using 32-bit and 64-bit kernels, build on BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

