Return-Path: <stable+bounces-105078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156DC9F5A1B
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 00:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2184916A4B8
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 23:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34A1F9415;
	Tue, 17 Dec 2024 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QwwCpPxr"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629EA1F8ACD
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476805; cv=none; b=XySt2A5bnrX4/F5XyVNBxxrH6d1JNRU0Lke+tIRn/5zFdXrA1YFJ6wW+zwa17DIxQ9EF3qtFZtY00Q7Ux6s5IvucvtDmLPzQsB1dvnjBvKBucsw8zEuHiztTNoT4lrMFfbxQ9XPrKO1brPp8U2MCXVIl91oy7EmTziQ+7si3vEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476805; c=relaxed/simple;
	bh=cR99iEt2Ag614J04071UramutW5hM1LKb9eLRFtmkOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5fs8ZAL198XAEKQEPwGR28nNjBGfEDWjyMmYSfVWq0+8IMD4NKqswd3BCAHffbsNbZKlukqxtAUUeKO1fvMcgtUphXw3XGdXRCM6U9KvbcSBhXSjZ0ll2T6cPht5+C26Mwi//+f4WpBx7aEVS9qTSiBIIZ01RZwMolM7D7JJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QwwCpPxr; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844d5444b3dso8731739f.1
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 15:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734476802; x=1735081602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXfHXyPVex2Nr1hfyjAUCuTtuBcvIXAg/0lIIloW4A4=;
        b=QwwCpPxr+4gyl083rU6OoLHVvhuqMw7SbIl1nofJeywsAwkP50hEKS5FHLFVFdp2ZT
         SC0I7kL+PybGAEFioe8GhoZoia3aA5c2zTXLkCC3ppUE4iEvgDhYsaTv5kT54h+LxCqP
         BhkY4qRVpq2FCtAx3QYdcUoKgDkchnh5lTsvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476802; x=1735081602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXfHXyPVex2Nr1hfyjAUCuTtuBcvIXAg/0lIIloW4A4=;
        b=eWf+mHR1vpoLa9+3YOeTwSRbXRfNro6yLk0UcA5v3u/fZj+QlQr7FpVi62pJ++O3As
         LzTqQ3YppoSpF2UiKfhmqFfKg/IRU/3Eb2Z3LuhyQQrq0/LrkUDZRGd26j/9Td2KY/ar
         SHqbVGmE2xPqtlB32bG2kC8hReUv7ECb1SioPOB4YGFu1K4zbAJwzBixCv28eSs8md1Z
         94AexpfzRD+kcp0cPjeTP/E2IIwfkvXYA/H/Q2xZYeGH+cUmlnvCsyOLhfOjA4DKXY3l
         Sm9ymdvLrG9v80cIIH/fXezdGT91VhosH151KrvEoxS+63Hms0HYrYilfsZ0W+p5b1Fw
         T1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVaAdENmEIdxSXjG9w6j0huYfPMs/S8J2Ar79M2+dcmxh3h0qeYT+YSG0B38ZhkSfOlwCadHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymk39QFzjOR8AJtqhv5dAImNLyjS0b4lRrFE0X+rrxnLlSryre
	R5NaUwbbhaHWPOiyU5rWC3SZGTZooaj9KKDDCCNyeefn6CajYIghLDj31BYbdeU=
X-Gm-Gg: ASbGncsnGAEWRa9QBo/F8smRh0ptctHfhEIOrX6RrnrPJk7H/Vk6gvd9Xw53UlS88qS
	DJTFXsyuzoagYB3JI+mPEQ1lUqNOO3I3woja5d/gVy8/F2gCwQWI+IwFRGmFC6ZccouNnsvO+5t
	sr2oktNxgTXHdgygt1Jbjs1YSOJg4IwyAuryed48J/NadbDjI1W3u5xEq7oMJDBfnkBfHwdYRnp
	EGYaawf50nF3fO0UOv/6zlJGBYC8ehIgs2R/Z6N+wkLgYV6vn2cQp2SrqyUiIIYTsVM
X-Google-Smtp-Source: AGHT+IFyxmU7yFCGp/RCq0l8NrfmfKgDtm6oDQd4bDB4w1nxhIj0cu9yqlIx/+d/pL4cpNwTFaiSzw==
X-Received: by 2002:a5d:93cc:0:b0:82c:ec0f:a081 with SMTP id ca18e2360f4ac-84747e081c2mr438079339f.4.1734476802401;
        Tue, 17 Dec 2024 15:06:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f6239971sm188469139f.10.2024.12.17.15.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 15:06:41 -0800 (PST)
Message-ID: <644fc4d1-9438-4f0a-92ba-d1e4f60e6b84@linuxfoundation.org>
Date: Tue, 17 Dec 2024 16:06:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/51] 5.15.175-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241217170520.301972474@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241217170520.301972474@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.175 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.175-rc1.gz
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

