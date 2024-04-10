Return-Path: <stable+bounces-37916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8D989E6E2
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 02:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2D11C20D2E
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 00:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60237C;
	Wed, 10 Apr 2024 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JaL6oEGI"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912D1C2E
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709137; cv=none; b=b6hi+KPEkzV3dSTm9F8Tr65qzsLuX98upgq4pcgLdyoXi12Re8OJd815xo1tIEWDIvgaJ9vSAI4BS8XPVXetbkldVIErngMF1EDmi9ZGflxzTRbutg7fz6t9ZG5wz/eQuCwv1bzer5JUSfEED7+VzE3cuXBpnR9ekEST79bh+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709137; c=relaxed/simple;
	bh=1Exgi+JLL+QO+d2hti+19dm0FiYFViJaiPvbpGc8XJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cl3oxDjTIqp/1fmy76YXM5k6htOlalIsTDQ8WIQYAGTKEPA4BQ9Zt3GWMTEztxICY0s4bjqXwhMntRS6LPi6TxKH9UOOoc5Ni/19swV4fM7FSdf7JkrdjgldOPe/zy7EarMn0M/dYxqCX0NEAJomURVfx/t6FemV8oATKnWRtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JaL6oEGI; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso64065639f.1
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 17:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712709134; x=1713313934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fH2gqC5dLvzkZJc67eDj37ebZ1ZnAJYQHjhTciwIjkU=;
        b=JaL6oEGIfkgOCcxqe1xkRRenn6oCPvhberFzYRXylZdIotELj8VBlHEECfbumTB9e0
         4qPCvrP2mv/0OH2UY3CQLV7g/KWti/4ER9gXiAMFNjzmu/Otisr09nXdvC6nTSQAOlYQ
         2Z5fV+OiERK2A0dL73Qi25ItCQqy61ko5wKG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709134; x=1713313934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fH2gqC5dLvzkZJc67eDj37ebZ1ZnAJYQHjhTciwIjkU=;
        b=tbKuwgHq7jTvYoqKET0qxGVQlVZAY7MWT3PtzviQXnuNdkbZ0nX4t5lAPJc5kqN0Ah
         y5FQaJPEAV8dipadm4eVM52PFwTn+h3MmXSSOMLSw45JbkU2N4j6OgHacDkSQu6AeTHq
         ND9xKGsRWUlNaAmOMzK6YlZCDNGIOpDvcKgJ8Hf56ilGsR3Cw1QvtJ7OIQOlEPvUSVmV
         DD4ia4mB8LcNsnv77UbYFgOCxiojYJVhGMJi3DKV9hKVkrvhNuE8lW2b4RzuF8Kuu3qz
         2kqta0obgMIKEWzDnpxRHlbTPG6MYx/0uCi4P5wLtnfXBL9Of3b44wUcs93DjyxrrlCF
         aYhg==
X-Forwarded-Encrypted: i=1; AJvYcCVxJgBuEAS3GWuKX9BMOcunhGmrzM6Ggrs0H950aKxlx84Yr4CVxWZuCMSCUhGq8Pzw4VVH0X5lEbIq4lgwzJcyZF1Mq0gB
X-Gm-Message-State: AOJu0YwDsNQQC66utwa5ELvPRYrgSncCDh3gGHAkEu9wXYzpAd6yxQKj
	YV3G1/sp4yZqkOowAWKqJEavaroWsT8OYv8fWDeYst5lKVjqBWADaBwcYY/RujY=
X-Google-Smtp-Source: AGHT+IH7BSYmyscHz7vHJtvD9eJkudLF4tWaNfGG1dnEvB6mShpdylQuwZUbV8Oy3sTctHyrzW6kVg==
X-Received: by 2002:a05:6e02:1d99:b0:36a:38bf:5fb2 with SMTP id h25-20020a056e021d9900b0036a38bf5fb2mr1612736ila.2.1712709134686;
        Tue, 09 Apr 2024 17:32:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id p5-20020a92da45000000b003686160b165sm2843156ilq.75.2024.04.09.17.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:32:14 -0700 (PDT)
Message-ID: <99cc80f1-9ea6-4acc-a320-2cac6f7035df@linuxfoundation.org>
Date: Tue, 9 Apr 2024 18:32:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/690] 5.15.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 06:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.154 release.
> There are 690 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc1.gz
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

