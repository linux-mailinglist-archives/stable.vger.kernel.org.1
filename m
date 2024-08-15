Return-Path: <stable+bounces-69258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2F9953CD9
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 23:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFA91C2386D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 21:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8814F9D6;
	Thu, 15 Aug 2024 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBkSAekP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFCA81AC1;
	Thu, 15 Aug 2024 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758209; cv=none; b=jIUx8FcBnFY/pGpbuYUTdpMkRqNgTbisu8WUvQK+JOsBeLL+TvdFfH7jDAjdOpSajsx1xXBzvRyitjudq1bUO+Mg1VTUiyq2bByJJTN/mP/FnUzkqKM6f2xokhz3mMM2yjDMDjItg4YxnA9Rg+JOr3Dr+R4wY7IHJqmTQZGHTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758209; c=relaxed/simple;
	bh=ZS69LGaE0q+bUgF2Hiv5fj6EnU0goQe0XWcy/l6pPzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjX2hjnLjkMDU3pxcjE61QkSoI1d/PTwnDHtNhaFqMOMZkSqGm0dgNX7QQGDz/4/9jGjVo/ynfG9cNhsoW3q8qZed6OBp/nb947I/x1GL+4970F7/hfxE9I2p6cz4t+i8hjr5ZCFrcrS7duWJN+MwYILfeHuApmUpiHB6LacOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBkSAekP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201df0b2df4so12238495ad.0;
        Thu, 15 Aug 2024 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758208; x=1724363008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hoYUpO8Q7f8EZ4jJloF0Exk8C2GWNVomyUmCZIA2EWs=;
        b=lBkSAekPXlf+mPdN31Jl0vNgnNGE1vbv3Pqqb5ZZdajzuvirWU8PmaCbeViXZbds1I
         xh8/0V54tQDT2+E54dhTBRuZLLmMmfAPFSfJRKbfLEkriOJX8l3TgHYFV2LQg5uy74Um
         7eceNCde7Q0YPdIDgxg3AWGq4lwVEh2xVxRxGhCGhrN5p/IKyxjo1FywJ5PTwtKeR+PL
         380z96+NNir3AyfoFUYcCAABqQNo1t800FLh5h9tJkvvwpWQMQqEM1DeecEclhntvJjY
         lqhMZxOpZP42F8IW5G5upIg6YTRK2zH3vciCVb+2s9uT/QFiYBEIjfMLbmLZN3M43O5A
         8kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758208; x=1724363008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoYUpO8Q7f8EZ4jJloF0Exk8C2GWNVomyUmCZIA2EWs=;
        b=MuzhGI/uvz60dbXxr6msFI9evzqpYyUktu42E55GhuSlNWxmxJVGb4U+gRlUf0VYDF
         rfyV7H1LgPnfTOBEIvkMTo+7ea2DMyxyM8WVn6BH3gdWKPBPolNYQTRd3rLzaBDUj71o
         cd+tG0/Fj7wAWdK8Y9ljI0s8Nr8zveqvq2cnEOqI2J7+UmK6pHPwsZNTgOy9kADJ3l8j
         5CDXWAyiIliXqW577XRTdbrdkYkAtCVovdE+VLfn9WkcgRw6cerpoGaFP5PzA6jZ477q
         0dYuR5ILAN8aaEiocqegaeTQ+TXv2khlTVQWPsCHMQf5uxOZb3UjhBIGbqHHCUvN1y9c
         Vxpg==
X-Forwarded-Encrypted: i=1; AJvYcCXNRU1iqk+xriqQ9FWpUQe4J3Su2DOTXaq285J18zM9amAO4klMccJEjJgLWhWM3R874OeUpdMncrUAG3b2A6AYRMicQev+g7GyKqZ061TFYodX/PFNyKi7Etm2xroK6dCWqRtK
X-Gm-Message-State: AOJu0YxrftCnDJolr8cJw1eZT+QhPb0hEJ20Ri9PUegzxn8v35IuDIhP
	BFwvpo8q+swcq9AAF9fA0EVq5pShfCIVOA+jlJTr4pLMDa7idAs0
X-Google-Smtp-Source: AGHT+IFApLX8g5MgpzJHdW5JrKrg2cPzhA4XiFcv9FIbS0GNcRc0ra9mSXhT+XpnBeWtx1ZVJM+LYg==
X-Received: by 2002:a17:902:c94e:b0:1fd:664b:224 with SMTP id d9443c01a7336-20203f42320mr10458745ad.56.1723758207797;
        Thu, 15 Aug 2024 14:43:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03a34c5sm14364565ad.280.2024.08.15.14.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 14:43:27 -0700 (PDT)
Message-ID: <8b307f8a-f383-4a1b-8247-214aee428408@gmail.com>
Date: Thu, 15 Aug 2024 14:43:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/38] 6.1.106-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131832.944273699@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240815131832.944273699@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.106 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.106-rc1.gz
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


