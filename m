Return-Path: <stable+bounces-52256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BBC909594
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 04:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E2D1C212C3
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 02:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FC18825;
	Sat, 15 Jun 2024 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+PuG0Ni"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBC79F0
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417459; cv=none; b=m+XFGO1jph0DkQ3XIsCHPiNhFLKYbN8xfqlsYQd7AxdrN7+tn6TiCl2NqdceB6pxQCw7m3QJi/k4EwUn520yOzfupARAxXsLR0GsYXNyuVQHbnqAmzu4wIP8PACEYSmYl6DKvikdadP8aD8UNfe+kcOlmHPDXaZmw6tGELHXWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417459; c=relaxed/simple;
	bh=DXmInziqCWKjxJpwpBGulsCPWOKNAr5TIjnc5FqxXlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/rCPQe3VZwXg//J4nHZiczIasvfVzWUHLi6c1bfnb6po0tHukXfE5rydBoN6c41J5sBL0lbsMXCljluBTJ3MQdubbEq/JRfbhXfv408J9oufezN4d8WYK9ICCrYO8XsEWC6gScF4zaJWw40CeLCmrpzIdw/gtNsyga/VAXKA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+PuG0Ni; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7eb721a19c9so12131339f.2
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 19:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417457; x=1719022257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3nS2v4qoTZtVNGX3X2MEYA2M4BO3FR1NxPvnOGys6s=;
        b=C+PuG0Ni5W/dS6RX3ATdjZ6v/rBu4eCnGWz/29IPPfKEWeCf6oJDHYq+MYmr5mG7Pr
         vX6gOUJM/dVDAZ5jNAN5r5MJLzT7pQCUFUYSCpgEye7f+UMpyrpIoUNMVa9JeXyivUoe
         fHn/z5nalqCpj730f0IOYO6Ss7P3voUAeJNmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417457; x=1719022257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3nS2v4qoTZtVNGX3X2MEYA2M4BO3FR1NxPvnOGys6s=;
        b=hMIAAh07E1fxFJ2UQMGzbQ4Yz6fdefRFQ9ZPEaRJCJ6YDfvp8ZEtRk+iHKaOImHc6V
         AGAdSLTPAjW8g8panmplpeEXi6oXSZYEiOxM8L2fh4RVKwGoj+O8bUIstvtqDuev9qxb
         yC6TFqsG8l9idxyDUEzZ3HOLZN0sXFpBuWBDmDVtB7b1Zn1Lku5a3fVhNjxX62zVz97x
         j84OCu2CkGYkmNeVJcCc/v9KVXf80fPvwNP7qCDZITDBRl9hFy+PDYwAV/mmDkr0oNCo
         3vCXhCyLIoJcCnm1bx5ZfJeeM2Z5272AdFPAxuMk+KMvzQvIHeY6THGrvR6ILNVXak4W
         6c3w==
X-Forwarded-Encrypted: i=1; AJvYcCV/m+IkIh4RSvnp8139O62u5s+vxnUqHESwKq/cFEPpajLJIh0Va+pYOittYn3xHLhY3dZAgjKr9WRAIdKJybN3HUB7l0Rn
X-Gm-Message-State: AOJu0YyQBDpMqS00yUhk3B00byNZvtrmrn2FNbxqC6ki5HgpPCjMhDZc
	BJALPkenBEupbkkHH/8WF6vAuHvVzE+R7TBBVew9corPh/zXDOFZvll+I5MVLRQ=
X-Google-Smtp-Source: AGHT+IEkZI+trr+spMpD5Uhm6wzSPYBWWnpmmtC5NW5c990CTvY6qKgFjfD2kSBCOb6xgmfk0p/i7Q==
X-Received: by 2002:a6b:6b16:0:b0:7eb:730b:f0c2 with SMTP id ca18e2360f4ac-7ebeaef9959mr402719139f.0.1718417456900;
        Fri, 14 Jun 2024 19:10:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9569ef5f1sm1199962173.114.2024.06.14.19.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:10:56 -0700 (PDT)
Message-ID: <0aec1473-b16b-455f-a8f6-495c424d94ad@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:10:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/402] 5.15.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.161 release.
> There are 402 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.161-rc1.gz
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

