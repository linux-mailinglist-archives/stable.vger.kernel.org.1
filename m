Return-Path: <stable+bounces-75875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58697589C
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD90C1C22CA5
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272C71AC8B7;
	Wed, 11 Sep 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLDELWl2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DACF19AA4E;
	Wed, 11 Sep 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072646; cv=none; b=JOJhCsFab8ljJSPyUyiY4jSCHzdygFGm+ufjQzs4LXnOAEyqNO87+pm6HWJapy1IBbqN/Ir6gokdd7RTjLOnKyRgvAld41gUqSFUWbmR6X6J+EQI95hy7mSPa7gcJrBScruChMXitnLXuXrRJpsQgir0jLF4gUF05HEzIDv4hy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072646; c=relaxed/simple;
	bh=9eK0yHEDauIWsVSgY9SqhfVJCOquv7paPpwYwu69AA4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m7fxMqcT7MH8pzTr4zQVa7NUkC7BS8slU6GB12jH2NThLTQM8QcrlZ5URhG7bSyFI+Zii2Z6ff06nvjUrDpczjmvjd9RCmEds76fU1+s7bre5VeHNnJ0yaoujv5eT3OR6ULo0SXdPT6qy0fymMVN6tng7jnN7pthH11gexYdbRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLDELWl2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2057835395aso586545ad.3;
        Wed, 11 Sep 2024 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726072645; x=1726677445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=90TMb1/MbVS5WiGMgu7GUWPEif7p2vMbBbdE9JcSnoA=;
        b=BLDELWl2W9vVu6LNK/qnuJo8gYpBUPNtz3RXp2w+K6xtwv5DAahHPQHaTxWI6bx3BQ
         it9658F+BsaumFwDilnU8+CsXefvEza8n64GmhauBTXFn1HrDzqih67DJAJMKvnCAje+
         KqUuB9oCusKjeVjKh1NHTChl8r9lhJQgpMIB9l9C4YZu8u96797pR7cRgpc3yVbj7jnE
         5xqEFqx3bgttSmzcNbTTQpkA7agkpYmtfAUnxISi/dt4EP0vJSSRAVz33nNwBGVN2hI8
         qMPNK6JWYjM/4b5ZCcWT2BxEjjNjtKPbXTCqK9ufuS683Eenla2s6T39KmgfpLh35Lrg
         zwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726072645; x=1726677445;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90TMb1/MbVS5WiGMgu7GUWPEif7p2vMbBbdE9JcSnoA=;
        b=ZcX2e9kfF/GmIX29avehQDfx0ETyPIYw+ZOnhQ3jD9Cl099hqeF9xfcqucLS1Kb1Jg
         qWhtDtmGUiZIWkIp0p3MAiBImdy50hUiFqNDT4DAMZdjQujws5ZSTJAjS5kGdSulQv5o
         N47fRgoYZ++0fJQyM0GzTulxa9sZOVhLXBUksSz5ktfUz2hTM7yHPh1W9zE120+zCzIo
         Xqbtd+Si62KoWEP67K78cUtVI+DRg1W/dXifHXqxXWL7gB8TEIN960g2BPZRLzR+90zW
         AXnaa1hImz01mM1lei5GZD0uB1V8JBpuUTwKcKTo0rnoJ2pWFb7sQCYPZCzQdvp7r+F/
         8svQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6rpBMZh9oaBjVol3KZFgRvEuKBnF4K6T5GdZFqj1TNN64VdGahAge1war2wmu79sfeVP+g8fiYk8nEg4=@vger.kernel.org, AJvYcCXcmnRHks51XNcht/O1CPLJs6nS2LUU3iDF9tsfDwzLPixeJG8IQqXlPl2q46qamt08zHtwP4wN@vger.kernel.org
X-Gm-Message-State: AOJu0YyPWDDTTcbvSAXT1cwV9QHXNMwh6tzs2Zidgs8CL3RpBfeKuQUM
	+8v+g973i5hjjMQsy8G8QTKkG4zCaasVmDU2M7cBHKdjTjb8QojA
X-Google-Smtp-Source: AGHT+IFRWs5tDpCZz4ebtck/HzGJhZ2Sstm9Pf2WqLdLZ9Lh6Mhx5HhRBLNVUk+FbghPJ9dfL6+I4Q==
X-Received: by 2002:a17:902:ecca:b0:207:14d1:8270 with SMTP id d9443c01a7336-20752195bd6mr57744205ad.16.1726072644731;
        Wed, 11 Sep 2024 09:37:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdd86csm1598095ad.131.2024.09.11.09.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:37:24 -0700 (PDT)
Message-ID: <52f297b2-62c4-4e53-8b82-a87f29394d6a@gmail.com>
Date: Wed, 11 Sep 2024 09:37:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.4 000/121] 5.4.284-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240911130518.626277627@linuxfoundation.org>
Content-Language: en-US
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240911130518.626277627@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/2024 6:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.284 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Sep 2024 13:05:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.284-rc2.gz
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



