Return-Path: <stable+bounces-73685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB8C96E6B6
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 02:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72899286C99
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 00:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C354610D;
	Fri,  6 Sep 2024 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GeRzsSGl"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5717BA3
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581849; cv=none; b=E7k/UZLTMRktIVvJzNaxN42wj1T2xvKU49PaQRU3D6nBcZKPLysx1enuchslMBJhALkQWT8x8aSKM5t4oiHLYgW/hPNIuDieOdSWTQkRa5S9CH1wgb4IVyzWN2+RfnCkD72YirSzJumIvRYQbE8aQaWKlYfuDKX8RZxUCR7z4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581849; c=relaxed/simple;
	bh=OwpzBiS5Rmhz+J+NmaXY/hNNGB2eyD7rp4WviQc0kwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYIxRAZ2F3HRNhUm9V+7A2+sikEiMsHekBH7GJG/my4yEhZGTKuKkuyXyW6t2jHfnivj1OySEGeItbDin2eOjToVplkzecIeZzZ37/TGLHDP/AJoysaM0/YgaDmVHUmJ7Jz9whnfPOd7Nu8vZ7oz+299osn3GzfsnB0aIWaVxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GeRzsSGl; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a1dadc2d2so62030539f.1
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 17:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725581847; x=1726186647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJk6oTxSmxqwstN1cixMUi88869s8uO6pmgB1F/UNZI=;
        b=GeRzsSGldEguin5THKeroY8QLzU0CVajzB5mHSiWYW+1tQlH3GjbKegvkaYpecjQrS
         ELpR5eD3rgQw0qrpZDIG6NHm2OuSwbSIfEeahSgqFKHCYlYZHEWm8vSNls2ZKg/Eoxom
         DNaRNIamM/VS7qlu1EQ8UjpPM/z0yszZOHWJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725581847; x=1726186647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJk6oTxSmxqwstN1cixMUi88869s8uO6pmgB1F/UNZI=;
        b=beeWD8BX1XkOvMf8pgjjfGP3L61m6jOgFiz+u/+T6k1bIFYRjs6GPDAbyZOpJsPDs+
         Iho2G45SHxTK5V9V+VNHNN9W7qP3jQSwtPnBduDI1SRjZAuNSfGqnbwgdIovuxdVMBuW
         4Oci74m8qRRCOxVsdinDW/pJybjDms1HW8tDxGVgLfYiZRYlSCVJkeof61A0G0BC5FrH
         K6zN7RHV7+YSAiUdTo68hAO1YSI//FZgDl58R4InerOgijuK73j6wWpe81JwBzCRKkSV
         PiZ+ZvW/WbHyS0VBrJO9zagaofNJISP5B0sGl1WccpdQxpSuPtvFc5RougVWF4vLBOqq
         OhOA==
X-Forwarded-Encrypted: i=1; AJvYcCXcbm67lg52TjO6AmwWmH9hy3MD59DLc6QEh2kXDaZxjzdENAGXlMFnHVQ23uLoRJrw8ldkey8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVW2XYLlC3EE5HSLnaxiJm5VhWD7QCzSjtTn0DbHtVx6QSsir
	amHCnIPHIlthYxbYCpDeEOKZhIPn/dBnMJ5CZ9SJmB0oRmSeRh4sd4XvQClqs3c=
X-Google-Smtp-Source: AGHT+IEXq8EGlVXVAtKtQBZ7pubAV4csPUqD77cw2zVgWsBW729E+ZBWLC7j0DysrCw72mbjJsdPlw==
X-Received: by 2002:a05:6602:26cc:b0:82a:173a:3cd0 with SMTP id ca18e2360f4ac-82a962494b2mr85462339f.16.1725581846670;
        Thu, 05 Sep 2024 17:17:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d07b01fbb5sm376826173.123.2024.09.05.17.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 17:17:26 -0700 (PDT)
Message-ID: <c808dd82-248f-46c6-a902-02d3527879f0@linuxfoundation.org>
Date: Thu, 5 Sep 2024 18:17:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/184] 6.10.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 03:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.9 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

