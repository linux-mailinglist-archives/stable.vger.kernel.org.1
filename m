Return-Path: <stable+bounces-69260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D595E953D35
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 00:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911B5285B11
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 22:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27898154BE3;
	Thu, 15 Aug 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsknsiLP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FBE1547C0;
	Thu, 15 Aug 2024 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760015; cv=none; b=E1Yoss9Dge1+OqkoKqF+YWTjU1uiAOtJKUu1edveHGxFrNg5soXrq4+EYuR6klOXR5i1JoEiKx+swZ/nB4JoakGoBJxlsK4fNUZ/wWnVjT76OmBmBLvr3Pu8NuIioGD+znROXfciqv1r0pImb+kZYA/LiwwhoxgsMQiiuwW81DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760015; c=relaxed/simple;
	bh=eQum6iaE+rv3Ph7bu8aJFg44H4RBuaFTZwi3t6g21xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbBKPZ/Brj/6NBDioqVvImtuSR3j+PqidUIOi2ULQUaD4Oue6wTEYi0j3vrbvYn3xV/p9m+9O3sEro/XMjACuO229GDukPmVXeFwX2b0NJTGjq7Swos9gXY3u+wHRiG+Mr+KEIo9D4qIQuf3Jg5+av3+WhWkHp4g4arq4FGyzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsknsiLP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201fba05363so6750615ad.3;
        Thu, 15 Aug 2024 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760014; x=1724364814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arrrA+WQbb0NxGhusaGob6M8x70A5QVsX7ieBI3XSRQ=;
        b=OsknsiLPdrpsXdrpmt8ENQ6ZGR7W+t6cY9B37MSW2sy4p+c/bhYdmsH3JiB+Iwlix7
         fB/jKui6OhsJkeKI0Uv4uIbxgzX3bdHge9afvBV965WkLOtwOSG4KBkXipzQMldNz4wJ
         snJFzLPKSQmxJeYTasdfnnwPVSNlTF20zRrG3J0tzCFjaBdJCE+KV45xt5rNbQbsel1D
         4mYM7dEXw+wxTeBCzxR5sA6V/uys/+deqwIKV4j+7H23QrD0r593EBXniJNliGikDiOD
         n3m1brBIcyI2CIthKJUbnucbca+F91zBFkv5E7ia6aucCob1/q8ZIn5nyGNXLQAPYE4i
         gzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760014; x=1724364814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arrrA+WQbb0NxGhusaGob6M8x70A5QVsX7ieBI3XSRQ=;
        b=IWIbhLRnPGBMxHFpiITbx4apmsWnru0JaNtr+0H0V/BMXJF2HuhfCMtWvlcYhjHEJQ
         vn06OaEFoXldzhI0Kqvb2R1DpxoazMv1dHTet3X6JSIFH3kW5rxB+TwekGP2xIl+ZFQ/
         lbZab/2gPIGx9ak/Y6PJ0yrPZdBAFsmbfa8B1gVlSeo/SJYMAsNaAnWlpxPcZ3SHSGBt
         FW+TScyL91TMtRgfJ5HE9WUZrbBPguOin43czXNUavb3zMQcxOuZHZJfJKakBhS+sDHE
         JW5PomIqVkyuRu7YEhDr7Oiqr1/BX8zjBzKL148lYMcKqGggLJRxzpvsFJHTMNMjxZVJ
         XqqA==
X-Forwarded-Encrypted: i=1; AJvYcCU++4gCAvjF7hrIufGPOwGVbi832cyjZnUnyhzuH56sINu1vEW0kQi5oMNKtJWYFI3M9+h4P07r@vger.kernel.org, AJvYcCXxj1ddcmWJV5pGxVmPgfdutVWifoHQ5YdGf0fa+kIz3HbHbM2Bf1KZjrGYEzRjU8feqAlhRrYxKXCd3G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxiyVnLXxPrewl9WVJgDWYMqzblNHDOtVPvyk1MaRiyvq+shyM
	mYHrwbNGB8haXJDfdVRmoHdWTqBc7ZI7HNg8QYrzpG+D5C4zgE5f
X-Google-Smtp-Source: AGHT+IGArETAC6OBlaLl3mPQr3yQ6rYTBhcEmS/Td5rSoxReEtC3OXKUD3v9kbcsgbBs5DTawnAeew==
X-Received: by 2002:a17:902:ce8a:b0:201:f161:7e51 with SMTP id d9443c01a7336-20203ec4f8cmr19001815ad.31.1723760013781;
        Thu, 15 Aug 2024 15:13:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm14685215ad.94.2024.08.15.15.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 15:13:33 -0700 (PDT)
Message-ID: <a368397b-3d86-4225-b18d-a65e9149a99d@gmail.com>
Date: Thu, 15 Aug 2024 15:13:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 00/22] 6.10.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131831.265729493@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240815131831.265729493@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.6 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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


