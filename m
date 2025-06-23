Return-Path: <stable+bounces-158016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725ECAE56A0
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7614C833D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2E22370A;
	Mon, 23 Jun 2025 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxge1LYl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1C2192EC;
	Mon, 23 Jun 2025 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717278; cv=none; b=YaF3tXFvW+TyMBT6D19Rs93maWLqUKkqnL5Q8phYmD02HCTj/76uJfPWGSRkJh3boXn14EQmVIvNytkh3rxLE26MFqJ9ES9Wdppg1lNnD+hbK9W+0xRrjGJzALWTePasOfm1HYALBmU5oq8ZOI8yNxTcVHkeFRXdRuUhJKVu3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717278; c=relaxed/simple;
	bh=yIlAvRsgijXTH3oVxeZJ0I9VIfkkLUzhzk6JrA+Phs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUiv3zZdwd+R4d1W3NSpgbDH3z91GBs0ZfGEWOfeO0iDqK22vTzUK4eyLRcswvPF/mZLkIDNx+5kjiDx5h+yEHcc1ql1UBFw2CuxaFzdM+NDrzlwXv+sQQOFKiMx8t6YfiSs6Izl6coPOyUsJCFzBr/kk+2y/KzX6eV2Z5BLQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jxge1LYl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2363497cc4dso42749645ad.1;
        Mon, 23 Jun 2025 15:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750717276; x=1751322076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XiS6dENs8Ta5fbquyxweL8AOiocCYE0d6u4W3pkICBc=;
        b=Jxge1LYlphwpeOU867fT9UVp80TzkB/5kdJvkTN7pakn2YDf+8H8LDsqrxf+ke8RZN
         Fvon/QwFvPldSwVPqbl8FfswxNYfZ5FtBtZAIgIbS3l5fZs6mZptB5Sc3/F1nVlBq2Ku
         NEJB28VKtISChEsN3ns/8Jh6pnFFLpMcn33/r5M8AE+uiTvfuwm3KtMS7/xL1qkcMykJ
         wiZrD1QEK5I12ue3agJlf+5VJdYINQIN8mmbIO0Dw8ZwjHrp6UifZcHh0No8375XPqSb
         elyEI7wgfY0l9gYsgItTmfuc7sJGrFnDbz2F37cQhrIi0ulYqniLpDyV3iZP/YDiutu1
         sqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717276; x=1751322076;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiS6dENs8Ta5fbquyxweL8AOiocCYE0d6u4W3pkICBc=;
        b=Kw1/T4LjF9rlx5CoWDFOCRUBxMa6QS+B1mhkUmYh0Bazw8Z+iMEepWXDGOgu8zII5f
         rSKOjMS+KqdMglZwnCnDMwSmXt/4bwYXIFidI/+QQfE6oONNsSAJ4aK+7f9hA8gvWQXs
         /gksLc3jiSEHl8lBi6z3MAetP6BA5cxFtSB1V1sQTi58EWZVP0PTEU1onpRku+r4RFru
         msn5EFOFZ+yIhLHSwcaemQCjT0QIcHbq/091x0KDl0PiHJriPSPVorstplZSGvlQwXQQ
         aSQMk+IyDX1bM0JXq3HpC9isUHm2p69M9e9qBd13AWVwIo3459g+dcQclP3SJFvkxhB6
         K42g==
X-Forwarded-Encrypted: i=1; AJvYcCUvLOfgzYytQQ75SCiYrf9Bbgwg/za73Vhqrp+HWqv1sxJu00r++md6TVtYjN8bacq1VtMgrnulz/CEDF4=@vger.kernel.org, AJvYcCXICEFVoJsueODqQ7qpQ0GCVYJw69iioOyKMJOoac+Vax5vor0fKmMbZnV9jFu8YrHSRObl2DAz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/IiZpx9kDAEr23KnUIwy+t7BfTDmPd0B8v01MpKBVMLJ0YADs
	A1PxC7Ox1SSiXLfSP2Yf1eVwQrSoXPd4s/nw8Y/rpo5M5ZRwTK75L12p
X-Gm-Gg: ASbGncvPD/9VWeLrANlxzN8uSEb3ibl+lNGDVK80+lM0zqxEcI6w5ZCcBnfHHIrlD9Z
	uD03AnSs2E1EC2+pSsC3V7N0BZZxQBRMw+E+MqZ5YCwy3q74+OcjsAomakGL9ARVHEZXDm4+HVU
	VTg7XUoWFttpOpzwZhkSHvX1VATDhL9+1Qrg55xf0FOCG8tdfzgvnBUPdwl0q0XdyldkOI6gFYw
	6h6DSrRpTxiJqJVPSqyhYmXVyCLVZ1bgaXM4D8LMRh7gp00imPWNvK3FejTcwZsjyUocAZB3l72
	5va0qi4wB6S1njz/T9dESeYuKIsN2nR4x/MhCPGeIF6iqKcG+wBgqXQZj9VRX37DHKMwKrIcrHS
	+BT+6s/dbjYFq5w+CirxtVJku
X-Google-Smtp-Source: AGHT+IGr2AcmdyY2sfeGodl5CTvBNL0fJLMbZp0mo00ae2s6ff+c4zwxl6fyTs+rSOHIraRfHmozMw==
X-Received: by 2002:a17:902:ce0b:b0:236:6f7b:bf33 with SMTP id d9443c01a7336-237d99984e3mr269189725ad.24.1750717276533;
        Mon, 23 Jun 2025 15:21:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86633cesm90570795ad.154.2025.06.23.15.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 15:21:15 -0700 (PDT)
Message-ID: <2161be3b-1223-40bb-93fd-5cf3a2f86f89@gmail.com>
Date: Mon, 23 Jun 2025 15:21:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/290] 6.6.95-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130626.910356556@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 06:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.95 release.
> There are 290 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jun 2025 13:05:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.95-rc1.gz
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

