Return-Path: <stable+bounces-42939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04BD8B93A0
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 05:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF1C283A14
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 03:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF8C1AAD7;
	Thu,  2 May 2024 03:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yccow8Dx"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCBF18054
	for <stable@vger.kernel.org>; Thu,  2 May 2024 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619618; cv=none; b=t1IhNbYXUihAenGZno+ULxpqW9CT689nlIyQ18+BgXLRn/tUpcGFA472cdKZF1sp/qXQ4/NzT8xTB0YZm9ZZy/A0aEVT5xp2Y8pX5dOgy+086pold9L/9lX7Dzay4vj4boRxXvZSSeC40DNm7vBEwzQNksw5YOjSe0Hcoksk+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619618; c=relaxed/simple;
	bh=5XTfPr4IRbJ7mVGRcfndFaOJC4COJuxR/NwIjpIlx2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4KieHErs9Lz/AuRs8TuofNCqfRK8l4DVc2NoU7OWQYrDFfgnYim2T/v4AbuFbCGSOOPjiztxHXXfYUyP5OKUbuCSpARsZ+tJ6DI+AamIoPel5UGT5RCI5HA6amVYbTJlL6pGetLkF6YfcFsnXsraT5xaLNo2Iwx5oddNQmrWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yccow8Dx; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d9ef422859so57088439f.0
        for <stable@vger.kernel.org>; Wed, 01 May 2024 20:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714619615; x=1715224415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWSztiZ0J905gZ/ofKM8FZjwM5J8mddj2PYT/nPR83k=;
        b=Yccow8DxMX1tcgsAeDQ2ZznLzIIeBabatEjJ4Fu7/EmPMiot6ShZDlgKRjHiXUeXNx
         WJdefOGqd7eFp2dPQ+3VsJDtJ72aj03LUPPILDxU9ooh1+ZGVIjYwzJPKUS/1mCWgwUr
         AotlrexwYrPCtfBFHrgiQYONbbJOTmV4w79Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714619615; x=1715224415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWSztiZ0J905gZ/ofKM8FZjwM5J8mddj2PYT/nPR83k=;
        b=dJ6LLy7WmX8ahk06lSWrGsJBlZZXAWvbP9FPIOomZ9Zqg2auh2g+eCPOPI5fahQFiw
         bf/F++qgkYvV5gawtpc9M6YY0WC1K9DFaGSAl4I19q4qs1V0mdQSgSMOSTY52SnaWaM6
         T0EsgHBDqZBV5t1EpzFdA0hw8uKignz+XWnBU0G5wFHfeuea1YNpYSXWFVSQRD6IV2Ig
         AiecOrANMkyypHUnOm6l9klh9PsZ6GkqhG89WzpjKm8KvhDxusdZE3TxnATZavu2X76n
         tYaGfPZ/g/Xkim1PygOUnY8UyPMxS9OK2m4rHIw3tpPTkua97/nK5MidhAAW4rgS+g2Q
         HnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7HX9iNqo9OwaMdvXYpTZs56y95FjrtcmDbscUBHXl/9K/ykkz00I9VxoKNwk/qq2lT0w72IW5DlGYGkZujwtKyFS3mFuh
X-Gm-Message-State: AOJu0Yz3EumRU/skUqliWpEuI28HVIguPMMuu9O+KZC/hPxi99reJIgC
	whwfPSqiBOJL8GJrVgeQ/THQDVsePn/EaIZqa4A4AkVJDVA8+O124c9dMrgpm+4vaw0zWTJyy7Q
	JU+8=
X-Google-Smtp-Source: AGHT+IGflx79ER+Vhq1h7akcsKhdeZmwayTvTxHYAuKOu0N6/C9SX0Nukp7IpIEJP73j4ChlCLBcFg==
X-Received: by 2002:a05:6e02:13a5:b0:368:974b:f7c7 with SMTP id h5-20020a056e0213a500b00368974bf7c7mr5573879ilo.0.1714619614970;
        Wed, 01 May 2024 20:13:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m3-20020a056e02158300b0036c6bb70d9csm15814ilu.10.2024.05.01.20.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 20:13:34 -0700 (PDT)
Message-ID: <e1b6cabd-adef-44f3-a4e8-739629037632@linuxfoundation.org>
Date: Wed, 1 May 2024 21:13:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/77] 4.19.313-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430103041.111219002@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.313 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.313-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

