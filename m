Return-Path: <stable+bounces-107916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3224A04D4A
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518361883885
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054C1E501C;
	Tue,  7 Jan 2025 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ftN1Rqy/"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E541E492C
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291744; cv=none; b=Q3+pae8kLTO9fYd+VHJUskr99gSjtMQtVHh2Pe5+Juxn+MAD33IAqgYYYFe02NFMTARwsoKbHdsdjF5Lr4EbMQmcDj8XuszwPYyj+4gNfrVuBX2bcb67uSK2Tq29ouGSdYqPhREC5bydt8WFHnBIprTNylxczpmhyNe08ULuYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291744; c=relaxed/simple;
	bh=rZ+dbjJZOGaD/3tYp/5lJJYIprZg2k1S5ZNTgUv5aYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkREbin7IlZKIYsrf7+Y6LiGe54H5iIMALmAFemzz+PX0aCJTT4GIK8b2vFGljPuQx12YpystF6Kz0I57WGgd0ka4hhvqLt1rv/Al+9tfViA6T2rtKpOujuzlq3ZeWhBY+gU2am6z7g0/WzKlbjaOJzsnJyigv9ovMXYvf0LyRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftN1Rqy/; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844d5444b3dso12608139f.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 15:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736291742; x=1736896542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOVOoOK0PrX/4VQ/PKrEjNAUqBo1PTcmPcjUND6espk=;
        b=ftN1Rqy/XKwVOq+l6Rto2N4JLLjXjgRwpq/qY2Cnww2Shv2FQEpDiI4NG7RH/np4eZ
         VMmBfjD5C7F5vpR/XUTpZSTpFajlzZH8ZA87ZCZFxzCP+fhE01nxlG6KDTeOMbx4tACa
         8YJ8+56RoD5IG0v14eJmJ2tDeCC5RAGVcedI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291742; x=1736896542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOVOoOK0PrX/4VQ/PKrEjNAUqBo1PTcmPcjUND6espk=;
        b=N1hvXLX+xGODdtqS59UtuJKmyxHfGcaieoHLVBeEWzbulfWi3CcDmx4sw1zBLMYZiM
         wTEJYX2ZSOQmKmJdbGXnDuR8l1KMBVAF+OFCiH+i5QaSLtR7VYlAIzXd6Q1KNatKl0BM
         Q8OKlASyAvvxbh99zE2E+r98wIiHfpQGPa5mCGB9pz0wVuK59thdyK3gLkIfrIG5SRTf
         sgAZKc4LKgmp99cDknbx8TxTLD8Xe2HockcETRsA2ZjQOzmz2jm5S1bvcgUZQUpCd4eF
         Qa/brzmUkcFwFBMhs3R1RaMDb1fJB/y8X8AtCeZ13bgiLk66CSjE08Q7DfE/LkX+UP91
         uVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPsjyqilHlK4pCesFqCEPXWV5DChoNky1TAp7IUVTbtGkjGk/m3jsdZE3tzl3FPMwS29vmOOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT61UaulxMb4Y/CTu0npasFQEla3wS0gwJQFO24RzGA12rtOjV
	SH3melLRvE0/tRHhJ/H20MRzwPh30/l8ILdI/SbcSn1uNEkjn1F/0HNLNvR+mYU=
X-Gm-Gg: ASbGncuVZr3cvxihaBElPqrD51z4m9SMFctukZOXDK0gPRjLUOzBl0fmQA9jGmIdeUs
	L4VlVaH97ED3wPcMlXTYbmTELuntfW1jkL6ShhfAJ/FLODLWtbKtT+f3nIorHSCAiBWStbAUjGa
	rvJH5TKQqqOba6ZWb/+S86aCHKADGaqXoig3Ty2L9gp9AHwGheBu9riL2E18fEXHINheweWCnk9
	msAIKZ2b+D0gDg57jrBp7LsSomTaw8MXy4l1csnx/6F49RYzI02fGXSoYG6wspnkADj
X-Google-Smtp-Source: AGHT+IH9Y3yDWt7oTh0Kt0furL/kOQmB4xXav1icdCWQvy60uXpUeqxXxeihohmaWGsGZoRHiDBKng==
X-Received: by 2002:a05:6602:3158:b0:83a:943d:a280 with SMTP id ca18e2360f4ac-84cd2d7b531mr364003739f.1.1736291742371;
        Tue, 07 Jan 2025 15:15:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf4f410sm9826755173.4.2025.01.07.15.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:15:41 -0800 (PST)
Message-ID: <4e821b52-b372-4a27-b8ef-a87a57ac18b6@linuxfoundation.org>
Date: Tue, 7 Jan 2025 16:15:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/222] 6.6.70-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 08:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.70 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.70-rc1.gz
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

