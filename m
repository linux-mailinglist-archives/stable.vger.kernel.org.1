Return-Path: <stable+bounces-169417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5917B24CF5
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A04C3B4C63
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F582F83DA;
	Wed, 13 Aug 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N161Xgcq"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794652F83B9
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097640; cv=none; b=ZctvcKPwzjnnSCu7Chpnsynd3pCYLeRzumaS9/EIVWHBT6KNBKKiDrAwF2t6pXKuGr44HQjY1pLOZnaXk19KGJEByQOlctDwbQxiAEyCbWI339+s0DCii/GaGNw4VwjFKJ+TBXYUaoHyNg7VG7Krn/j8jTMS4p3h9pFUOl8zA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097640; c=relaxed/simple;
	bh=8r03NX+r9x2k65wyMt7AIvp8WP7OUAczYufIB8H2A3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sk3jqUHTaXclsto/knE4brYPY6rJm7Y+nEL6EV1smcSnw72e18wFVjlO2wVay60Iub0j3y2cPNB8NkzbrUFln5VpNby1EwDpDmROuFL56sVDXu4Bbp7140csh8kIBNp78zGNsyHOQmq9VOuJOkIxFEVmN+HJOXP4PiKlZOTVzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N161Xgcq; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e5477e8effso17072325ab.1
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755097637; x=1755702437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BES+tZqo2SQDVT+JlFy01sjWICy7VQC+Fxe6pE/Yt90=;
        b=N161XgcqDvyv2hYx2Brw5L/qQPRuICvPICItsxpLXZZI4knufLANcsx3d3faZoOcfU
         HIYJwMYov2vbnZco88zMlcf51y1bj9btk+gsc9l58Ca8aZ5JxQ1NlTfmJDMHSTBnRrGD
         C2kn94NVl/QgHb6a7s6yLcejOHZfPMnRFIW1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097637; x=1755702437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BES+tZqo2SQDVT+JlFy01sjWICy7VQC+Fxe6pE/Yt90=;
        b=dHiVYB99mwXtu6Du/4rLijVWT4QL5w+9KtWucr+P9hNrPv1GoL6Ecw+9l9LYZnAAjS
         nqPrT+ZQ/Y64IplVCbWpZWuCiGYcmiOj0ppbdXWWcl8iIo4V+5SgYzC0fueEafdfastj
         cyEeHp/D4l761S1UA8hNx69XkhTUOuIyr7i3Xtpbo4Kza54UHeoFPva/nHqGWhpytb6i
         AQCQgtllTsUll7Z0EMF1ciwvXBtW0+1UKqsYUOFLpOiumRKjTYOmIZ1vwrP5pXAtlp3K
         O6brsuU/d1S2hHeYsvk/19B4IkbGiXJgvkB4Y7cIOIEiZyGB/WA+N54XeiY/KOH5a4wG
         V90w==
X-Forwarded-Encrypted: i=1; AJvYcCX0HfCXEXHcGpMl4dChhbPhNzOTz5XSnAGKC5LeIXFWaIrivwxW2PcSlzOYRZH47bBvR4JzJ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxptvWuFmv6ZBQdfd5itdc/9Bydutf7zD8O2TMh8O5f067ha7HF
	DI4oBqUG03VdBsKig9PEVXDMj7sgLwx9hvCPxQZa72G3SybT+3OdS++6Cd8aKHHyIlI=
X-Gm-Gg: ASbGncvHyKkiYhLNELMnKuSbLugElLuKCjPJ6CBTVnqGuwT3+/XDQnhoiqGdzCsQovf
	9w/MgLWVwcteMyAeQ4qGf8QFlDFcL5fpqu4M9TkbNf1gs8UaRpZZ6m+A6WooBigm9wJ5GsZeINu
	ds2SnWaI6uvl0XerucrlZVkL/Jp9bzpQYV7ANDb6cOMcNfc0Z67yAxPMTGbiK7MK8jDgwxXjdAI
	eFJVYU0n/3fhbVowyGsozb/vClCbkxSakNo3drzDmXFaCYHWXzw4CH/0f0y1Tcs5xZBgQFi+3hM
	3wuTEtVEmHSDFmr4f2xorfGN5gWxiWfpBwBweF30aVg0aUFWLejIbJRvthcT8YZEAxDVQekbGbH
	nvW2/CignRTmIc6rmr+0TIOJ+EtW6IDYICw==
X-Google-Smtp-Source: AGHT+IHnp8n/7OAU4jNs9ZCJvpQIeiaA6sLSad2OkT1KrPCLwJcVRh9VXs+acczXHfHfywLoggsTbQ==
X-Received: by 2002:a92:c262:0:b0:3e5:3d13:5d8b with SMTP id e9e14a558f8ab-3e56738ad42mr59701575ab.7.1755097636513;
        Wed, 13 Aug 2025 08:07:16 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e542eee208sm42577175ab.9.2025.08.13.08.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:07:16 -0700 (PDT)
Message-ID: <020677f5-bd18-4801-8b41-ad294a14ca66@linuxfoundation.org>
Date: Wed, 13 Aug 2025 09:07:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/480] 6.15.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.10 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

