Return-Path: <stable+bounces-110082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC19A18869
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 00:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98337A04DB
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D61F8F0C;
	Tue, 21 Jan 2025 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gv/HfLZW"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1D1F8ADC
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502556; cv=none; b=lQSWWzLZ+iCfIPNZ7Jq+hlCALAKjpC0276Uf0WCf22EFvCfxedKbbxrGc6S5nZjY90OW3UrODuHDYNVxjPVvXqFvFgoZ+Opgn5PmlnJoMbL1bHMmMxK3AfuC/2lvm79hIbOXERcwB0ow83WUKamotj41acq+S0t5M6Z8SJqkik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502556; c=relaxed/simple;
	bh=yLIXfS5H6Vk/1bNoNsDwh/JheYT6goTBep4hSob/KYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TN+TWgWuyaoApJVbg0gC7+9msoOdVrYMozvIAYwIdoM6GLuGtPnWwHnQMWXmqRiKKpDQKq94Q+Yh2lqXtlolvgN/f60g2GIRYo5ozcQ0EPq09B7T6B5ZcIfG8G7lXiVhAvJvL16ZxPLkaJCKhqr/9InSPLYxOGvEZcMqOLrxXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gv/HfLZW; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844e1020253so188474739f.3
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 15:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737502554; x=1738107354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CckOGRSHHekm/Lzdk/DPLRTj2pn0b7AArofEiAvn+6E=;
        b=Gv/HfLZWBOZK0268Oqcw/8lplrFKJY10+aTzEIOMTemt5K/f/vvXYVnJhWA9NxmcA2
         NFgZr4XeJZNckAMR5Q7UPVfdBUplKdfKrL4y/H7A8glqJvoO6F02pSqno5pw+NG3wgiV
         BiufSps9Hb4ef6vrnX2XlejCuumX5oDTdt4ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737502554; x=1738107354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CckOGRSHHekm/Lzdk/DPLRTj2pn0b7AArofEiAvn+6E=;
        b=u2Jz73kIXprRwv6WIUVMbTUms8vLrrq85kHIA9RoXNr8PTQ38LZ5Ejv4KAzYBTXJla
         B6DL8Db5+UJ9zuBZgSvBOHUgLGxGtSwXrgNg4yTcAgOAe4N4CCiZhvPd8RU1HCojAmOi
         Wc5taB8jQwHuwjXBTkBUK8X7wW2W8vGELFTiIUol5wQELa3lAjmjJiZyrTKFWjJhAOzo
         ClrUlhOoGunk9U2Mdp/Q0dokjcGMXs1DJGKmzoqkKVZaRYPcHgn86zeKPc6S5rhC9qxu
         MhoBEskqH73Iti0fQ7lsSmGjcCbhPezXJBSW6JdFKpGE1QS8PhpBps2dgGYVP9RMt2Qm
         SHew==
X-Forwarded-Encrypted: i=1; AJvYcCXyjGOmaQBDeiakxc1JhyLWMjlzE5DO7CW2hn3YRdNT/cEyD4e67oyiMAXCAhZ3nMXUUZFomZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvZUaesrDMvkLzIeEhQa9DZiEtgBN1/KAfzq1O6Kfvf19/XiA
	zu0uLU/f04PtMUv4gVsFY9dblpHctN8lek+crpBjoDKb5NprFCOAhjKXWdWCKp9I9ZkyAQVhxdE
	3
X-Gm-Gg: ASbGncugVWU9fP6UgnXtZKESRBpS+4OsZEHs3fmDpNtnX2+2aTHWuvx5mUr8pV5yiM7
	z/KrsVkGrUSEMoxeBIt2D21RD2mE4WoiKngy0opvEqPKxpaCaWvFfw2qQeLAqatnvyqw3amJl66
	eXKj737KwaAF0+7C8orDIwmXI0mYDVRkvl6cyC15EVcwAShyLRNWPjzvIO0G5ELQLcZJp5qYPiT
	6pzIJPOQPimUO+oeJ30iiaq+ZfNsS9+ML3ETFWxky24MRbGmzIxkeJRXeCFORVpD8Mqsj5KmfvS
	7db2
X-Google-Smtp-Source: AGHT+IHLk6wwEW6autFW4DpcknpzfogCoULzAAsCB/s+J24L2Cn6np8HlrwVEM0Kl8iAOgijg9GxJg==
X-Received: by 2002:a05:6602:6c19:b0:844:c750:3d9d with SMTP id ca18e2360f4ac-851b618c3bamr1900034039f.4.1737502554171;
        Tue, 21 Jan 2025 15:35:54 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-851b021161csm345552239f.25.2025.01.21.15.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 15:35:53 -0800 (PST)
Message-ID: <41f1f446-54a8-42c3-89b8-9ff5e299b788@linuxfoundation.org>
Date: Tue, 21 Jan 2025 16:35:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.127-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250121174521.568417761@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250121174521.568417761@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/25 10:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.127 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

