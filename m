Return-Path: <stable+bounces-46086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94758CE89E
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 18:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3A61C20AE3
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14312EBE1;
	Fri, 24 May 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CCSqmaIG"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CC12E1FF
	for <stable@vger.kernel.org>; Fri, 24 May 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567975; cv=none; b=dDg6GtSGHtW2DwbQ94IHZUwhPOvh/zLzgX5Zmf0g9lu8GdmgQe+yjKUWEUP4G44vuxVrhMAGZY2Qm1rAgygBHsVjc1MzIe6tWbaXqAc0PWLAp1/JBsYqXoN3dW+xMZhhR7LW6gVaIeUKOEzH46GJaE65GJM8nljCBcG+6RuF5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567975; c=relaxed/simple;
	bh=NTY/Z9vtY53/yxL38hWX8wJpC/fbWUZ8djdpBxujX6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgjYoNVVsVSdue5BAksRkT+MUnqJQXjPK+FuHRnVYe1Djl3LXsOl4mvMxMUKWbuoL3b9aPE/Wyg7a51QIBFyOxqywUFLK4x1MypIatRxTRi3MXMbuaZyb4dfShejMS+rnv+Uyp0hhpKmut+1napSK+ce2272HERlY1/fc/mXAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CCSqmaIG; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e22af6fed5so8576439f.2
        for <stable@vger.kernel.org>; Fri, 24 May 2024 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716567971; x=1717172771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kwdb8YgsPUZNPJAKz/pu745pRsXy/bayXVNZ9hxFw1E=;
        b=CCSqmaIGBzq6iK8J+qL89nRabyhdLb/57c4lxMAkA4tmVolSoqi8QbqKzOWqWhdzFL
         LB3EXSKvbJv/POLDeA0ZY7CrH1U42bBg2BZ5mSQx+GQQtDoWUfki8mGSIwo5yhlwYgg9
         Q6r0l2/1BXOscxdWEsgriVnkKZn6babwHirDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716567971; x=1717172771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwdb8YgsPUZNPJAKz/pu745pRsXy/bayXVNZ9hxFw1E=;
        b=OAIqlDwGg9WSdjUNW5fVGUD6NHKRuju1W1HZwDPMAAgFZONS7wqYLaUEjBJksDkoby
         FUobahkVFjSdAdTqpvZU0QgozLLpNz190uixF60o9M2FGXqQtzeAPKvLJcXtSewBnEku
         Ab5t8IUJqWl7IBTTWPLBwIUxUeuSRiOtYNhWGEqM5Hubu5zop0QpE4TQsHUGXBaqQRga
         0FMs9GSylc1HWITLbAR1v2/iJ2ZylFCTnb/wXh55E1iB5HK9Ofd2YctGKQw+A1WYlmmU
         pepFDVDor99M4V1AIMfVZaEloq6csGwN3K0sk+TYiC5cObP0iniE9XPVawmdIMCdArxh
         m1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVOS1x9Z9X+0L6ckA6RMP1xrHtTaQ77Jg62FCi6LXthjT0TpimsamKndyqVZ60dckTzHa4coYERJYdOyRQYP5zSHUn3qvX/
X-Gm-Message-State: AOJu0YyIhOj38JxVXRyZIRLd4/qVLSDcY1uG0xj4LCXE3qYGGmroaM0R
	i6PbLua/ArEmEzxOO2XQIv50wfcMWvhtFayZ9Kurf5Qank/QrWWgNf3usBmbNlg=
X-Google-Smtp-Source: AGHT+IE89eceySKyxxGYhU1vsQz02+tAJU6zkx7ZB41UqW+BW6pwkqXmIYaexWDDo2VjVpg/htC1sQ==
X-Received: by 2002:a6b:fb09:0:b0:7de:b4dc:9b8f with SMTP id ca18e2360f4ac-7e8c607ad49mr320125639f.2.1716567971449;
        Fri, 24 May 2024 09:26:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03e94c6f2sm454828173.44.2024.05.24.09.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 09:26:11 -0700 (PDT)
Message-ID: <d27fddbb-bb75-4894-b164-ac9c77bc2061@linuxfoundation.org>
Date: Fri, 24 May 2024 10:26:10 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/16] 5.4.277-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523130325.743454852@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240523130325.743454852@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.277 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.277-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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



