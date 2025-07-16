Return-Path: <stable+bounces-163158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D92B078AB
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B5A3BB54A
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED927280D;
	Wed, 16 Jul 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWQbTIqm"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4526529B
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677603; cv=none; b=WLFaRD8QOhOwfYJd1a4TmD0YQPxwyN72DbcfiYl6BtvOocZVlhntznAJaH7MhJEeLRfRCTrV9JKfufZiUdwI6rc2nGsAFPyE5PnqvbhaDpHG/Uzdk/8ynvYA9tHvhHQGrsTJMExIeKa2eMkPdzPvfzGPK4ZbZnzhlkeGy6iGmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677603; c=relaxed/simple;
	bh=aObTEVOu65cgXJJYv/X83Rx9FuUZIVPF7FW9+xhRJKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEJIjPG6GBScQy1V0fH7KLZiuquJVH7+Uci28it15ksVuneSRRxehSE7g2WCbAFjkhDs/2o/mAG45gh/EGz4kiOzzS/Cl0S/vm4X8QiFd3VlNqKbtu6uLBVkGC+PUkfuobmY8Z7MlUIgjUfeUihkcykhlfDmVWcffa/fAlp2xOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWQbTIqm; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e059b14cb1so4597545ab.0
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752677600; x=1753282400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70hqscYKUMhS36bD6H7W3bD6jK3TRd5Z4bT4xaOOeio=;
        b=MWQbTIqmiIrD4hLKtEaQU63+mAKpRij0KAy12dNmUM6KGSXpdIbhgTZt+5V2O0O4NG
         zYXF/UNaqweZ9Tz1ziDJcUDeoi2xiR4v5Xij6pUDdR/RPM5qNjFh2dPkjbeslpaNDf78
         YqFGaq1SV82kHzNpIPduGBU9zdpPEyTCsxpNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677600; x=1753282400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70hqscYKUMhS36bD6H7W3bD6jK3TRd5Z4bT4xaOOeio=;
        b=qt45+ZtPnB4BcW2MqLDz1WeAo9c8Hu2GTp4i4+GWZFgerED7IJs9HrrvMzXF6OdSMs
         mwoc3FvNJZ0ZXEB12fLFwj2lQsMC855L9Mi5/CnqLU2vQemUgRyPRnCX8f0hIlDvEulA
         6z1oS+aHU0E1V7EaiEUPs8SzOxgXT3oJH4IiUEGZyKNeLcrTN3cGmgIahsWTLZmK3hQs
         UB3vH7Z1W7+3P2vwcon2+4Mmg3GeVEZj0/ubwDWdtK67OlFigKEWw8bYOTXOTiLbQCg5
         Czch2teIyhGbFfOxSwG59MZAvd75ob8ycR3jU6w1WlcIEXsWHpdDKzz/Vs/1iMPqtpms
         Jfuw==
X-Forwarded-Encrypted: i=1; AJvYcCXRCDzg6rHmn2vb7PzbC4/psrpgorx8BoiRhkLazoIQnS1BC/3w+4oAp7RZEwQdMKerH9QjehY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIoSiVOoIDifKlF1Ce+gZDDsu+xdoi3dG3bNjDsTeVtuxopgRA
	cVQJzhfwPrhV0x5Ri5PO/EwbDAqXyM45aPQIKWpN9GVWK0jBRKHL9pfLdGE00d3UbZ8=
X-Gm-Gg: ASbGncuqus7hJsXjDpwFAHJJrLNJXmE+xNjJuDs6pwAyH4bgcIWXK8HJgcD6FZgOmFe
	497/VuIoBMBu0jyIOhWxMg/FgpUkqGu/scnkHEKgnJ9/oN7Skl8pQtAdfBU2PmZTpj0ccTgGgWg
	tTh5v7QQlyV/s3IViZDqVhoaPgCL29UB8nP2/lfCBgbi9HNlKc8IEOX0G8NLhWcnoAi6plePTYS
	8BEypu3ATR0UXpyFFs3FrmvNpkG7+3A5t9nNd9RJ+eZ5ZVO1mRNsMx4t21YLgpWffPxsTiJ+tAL
	dF8+cWMlCTNudcoc15mbRzGlum7LwbcLz7oQ94zT8DyV+f2700lDMqMmdQKCTQVaimWFWfkj67a
	01NDPCXIiobI1rpH4aXGFzxPlPf9fYZL6Dg==
X-Google-Smtp-Source: AGHT+IG0GNVprRljye1iFIt81jTPpLRCL9X5k/6lyQr0UNEP/58Gv2FGcMU9mg9LCJMzEMaDolb+wA==
X-Received: by 2002:a92:d64b:0:b0:3dc:879b:be95 with SMTP id e9e14a558f8ab-3e277c6ac35mr57796965ab.5.1752677600268;
        Wed, 16 Jul 2025 07:53:20 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556535f2asm3080620173.1.2025.07.16.07.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:53:19 -0700 (PDT)
Message-ID: <631a6946-0a8a-4f6e-ab5d-f9b2d0585817@linuxfoundation.org>
Date: Wed, 16 Jul 2025 08:53:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/109] 6.6.99-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130758.864940641@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130758.864940641@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.99 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.99-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

