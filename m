Return-Path: <stable+bounces-60347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E69330C3
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B021C22D33
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC1A19E7F7;
	Tue, 16 Jul 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAm7CrZ7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B191643A;
	Tue, 16 Jul 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156134; cv=none; b=H16ZOWvZ8UeFiZopq1lkAYcD68iLVwMQ1z9K/a61UnPgCR4ca0DxygSObps0gA4mPscl0qJCOnkEFUJUqkBeqJko8pc664LFVnZosJaJPdB5b4TMhuGqTWg+qts11MCpNCt9j4DipPf8wZmOne2lmtAAYytC3hd/T22DSGmyc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156134; c=relaxed/simple;
	bh=LErKYFC2hR7Vmj8YbOE9TRx2x0fegmkk1AQHDXh0PLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7AyEMqye2tB1I23Mo3/HbWz3so7sgfWmpwWUEWtKHzHtI2k5ZMSW7msJs7Y7p4NzRCfTi5lpXD+KYxB4ydnFiowCQbBWkVsX1kdqU5cyqXzjl1gh3XELhJRCFX/HimECayb7D4OX7hyuHk80uw9sTtybwpcXWahy9E7BaBUcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAm7CrZ7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb4a807708so52662115ad.2;
        Tue, 16 Jul 2024 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156132; x=1721760932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3Xxw7BDEuKyJmTDIMc9lI8Wfvk7nIJjN6wyfUy+yy0=;
        b=UAm7CrZ7zZBTMO9dNLVHu5DIi/2dOsZiehf+ILVTM5g/UJ/lUpf37Q28B9rPCJSbdd
         otWKqRHlTL8bRHEowjGFMw8l3Z4K6U9AXIyQqFYzviDD3wA6cugjdDOq0W/OFDUlrGD/
         RPtxP5HRNS7hVCxl6xR+Dj4HtSUbJbmKPo9x6bfLOr579+rNc8M/si20GDZ9O0bEL4NN
         yZ4kJFGn2X8svkWQRKsK1xmSilNij5vRaJF5Vd6yHiyeorqKfzn+AG8FbpfaCPGTVk4U
         3HU1qrJx8YhphtSIx7ENAjxvza/esYf3PWyRUUp/ACymZYLmVOGrH6kr7J+64oE2PnfM
         VtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156132; x=1721760932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3Xxw7BDEuKyJmTDIMc9lI8Wfvk7nIJjN6wyfUy+yy0=;
        b=OFA98WWFdXpOiSKJwks2p5Wx8skIj7mQGTpt9GJAvkYOsBCDyUzWlqOg4HCMYxG2fp
         GQ7odPXl4TXA6iif+rtYet8Cy9G19zgPc2ivn5l9eyb9Cebf51Hk+w43V+Leo7yKoqES
         pB/LHZiVWHt+Q6K5AVi8FIbb2EjdeOhRqBT/KoLmLYCdNg6m4FKm2nRw637URKUcJgim
         Dh5ZJ2JrWPFLLXIfgpiDHXIuPAjxQ3QasCjw7B5z9QUNMpHLF9LgNApoX/xUV5vHso3h
         Li7pgZSuPN/+W/dfgDZRslxOsFWgPNnz6x5tggoBR6Ke9ll3dotu2e/GQzNXoM5pZG9G
         Et8w==
X-Forwarded-Encrypted: i=1; AJvYcCWEFYnExez2dFTmCcwJ3xPCP/w/GeRQ3jUd8vkjxRChGf47TIOSGZpzDhByl4zgvw9+tzN9Cd16t2cs+59q6kkivKG1ofYhZ+g/5jkkZGAECVeTgViZALZuerDtTEJVhrrg+M9n
X-Gm-Message-State: AOJu0Ywa8RJmr+TsjY7XTWF1RE68lD0AiDDYSSrFq8okCn8LuDDHZA/x
	rD1XikrEdAfxWhfvb6E3apWwtaoKRA1GaDxDcqyleDoJkU2hkwh8
X-Google-Smtp-Source: AGHT+IFnjnaa0UTdqD4xiKsAh4o5FvvGWp4g3Zm+rHPDutZFCM82EBdc1F0virkcSrS/hgz2K5/Yiw==
X-Received: by 2002:a17:90a:46cf:b0:2ca:8577:bc87 with SMTP id 98e67ed59e1d1-2cb374921afmr2361057a91.34.1721156132037;
        Tue, 16 Jul 2024 11:55:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2caedc92c3esm6643327a91.42.2024.07.16.11.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 11:55:31 -0700 (PDT)
Message-ID: <caaf5079-11e9-4dcc-a62b-132acbc2c6ec@gmail.com>
Date: Tue, 16 Jul 2024 11:55:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.41-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240716152751.312512071@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 08:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.41-rc1.gz
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


