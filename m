Return-Path: <stable+bounces-142875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD86AAFE22
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 17:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1BAB275B9
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B3279784;
	Thu,  8 May 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ItugGacY"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39B278E71
	for <stable@vger.kernel.org>; Thu,  8 May 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716509; cv=none; b=NReLx5u9oroS5HdC2Mms2RwcT5SaJN6Q208Yazu0HswAyMU5fD2ldQzf6shWqnKLzW51xOA8fApG2QofzVaaWDGviieitnrkcDGoVi+es0a1UKilHeql8cz25AD5DIMdg+05kuCD3Wo7o40TuJe7UGQXVkFCWtCFkJFXb3Pnl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716509; c=relaxed/simple;
	bh=JqqemTbAWfFy3G2dBsz3H7ba/gEl9MKRPBZd0Jm+alI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrYo5JU80y+NoJGR4TrI84AUZazE5/XJ2qWqvWR7gsJ1hU6CN3QT72cdkUufj/XFU0AIHBwJozID/TbWO7iEQB/jZOZIWb/ZEwlFKQD7WZs6/3lM29L0WTQ2wkY2FJBKJwyj+uT/9hTn3m74kPz/ibekZL5oyrBzpTquTlUNXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ItugGacY; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d817bc6eb0so5270915ab.1
        for <stable@vger.kernel.org>; Thu, 08 May 2025 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746716507; x=1747321307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mDu99DgpRCVho8Q8v6dvmbfmspAGucRRs+7nWo0w14=;
        b=ItugGacYx3OrjYjbQgjQejjGAune0Rb+0/LoMEIk/hH9qtaUlUvhvf0ANMW0lbShGZ
         Tw2NEvexL3BHKu97dyMKq4ymVMKtgEw4ljBW96xKfLuTyNCDJQTj1WXUUHpTfREgaIlz
         hVl30on3JDI9le27xOatR/FTT3K0g/M2KOJy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716507; x=1747321307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mDu99DgpRCVho8Q8v6dvmbfmspAGucRRs+7nWo0w14=;
        b=SIi8Aa3+ePV9boromHTzKlEArMeuARAK4nPa5V3v33G+S2N7TYmbsvmNKo+j2AuQFj
         TCbWctkXgqS0mmDIWPMQEInYaznN7TYvuPdgXls1LGgMfathcjzqGC0nKktIqJH7cq+P
         0W8yVQw8QddKyoCSlqWA8svqn16liNilO8TGnmmmULhGItB1JozOendR/eifx9ezqsgp
         spQAU5+kl1d9LrI9xHd7w82rJy663mbJTyuVHGHHxQISQTJPu9eUNUkXSJl014wnIgj6
         9AFnFo2DR1rFMC1XkMfyJCES+2WvBnCjpsuBHN67xwAqXCAES6b81MhZ9YbD0CRoGGcq
         bHSw==
X-Forwarded-Encrypted: i=1; AJvYcCWjeq6DS3x0BrcyRmp4nkvh8X3EpxWtHRX1RmmKt3azX4g1mqGOEhIi8s0hiaKAD+puvF7TV0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqfffe2e5LreDxi1zTARGlCJB+JvB/scFP2NbeY+TAvB9uUY7
	T13vsMWjOITeHtYvBHeXu07OBJro/GhIdbUpUvWBMU+U6v/KT2Kl7p5pRR8t9Aw=
X-Gm-Gg: ASbGncvN1AEulEjwXTaRgs/e6cEQNd9tBgCzphPR2KLlrGTsyvyGLiBqxehtTw101zv
	j4S+rgR7TuM8XjX3UmVmBvhvwvUPIMDj6+UnPTlp5Wz4TJYawsClqHx68A5cbkhloLW02kp8MVF
	Lcpis/iS702GUtEV7QJG6QzYVOw2nDPG4oIZQXb84gSE9ikGr8/UQW+nQJCQ/ObxdxJHr6YbSI1
	1n3znV/lxSYR9+22I/BkrFCSzAt5KdPGognRR1vD114i26r5gt2ym6yyqBtUDN2U8f5aeeTT4Ye
	w3eEwS0SBVBQ4M/uCBc0w/SotgkFVpGi7UlaW/ebaztnVBL69U4=
X-Google-Smtp-Source: AGHT+IEjElot/pRkGn8TyU+I4k+4o5FHfUYNKSw5kW2R7zgt8vtADtTFXrdJYKCaroVX1HTvdtiKdg==
X-Received: by 2002:a05:6e02:b2f:b0:3d9:36bd:8c5f with SMTP id e9e14a558f8ab-3da739082a0mr87711895ab.11.1746716506710;
        Thu, 08 May 2025 08:01:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a8cfb51sm3211127173.3.2025.05.08.08.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:01:46 -0700 (PDT)
Message-ID: <33b5edff-4842-4145-9ac8-805e62c40bf7@linuxfoundation.org>
Date: Thu, 8 May 2025 09:01:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/55] 5.15.182-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250507183759.048732653@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250507183759.048732653@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 12:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.182 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.182-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

