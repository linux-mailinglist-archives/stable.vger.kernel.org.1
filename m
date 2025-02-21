Return-Path: <stable+bounces-118625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA22A3FDC7
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 18:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4F2707C5A
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9C52512D5;
	Fri, 21 Feb 2025 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQI7Ubli"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074EE2512D9;
	Fri, 21 Feb 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159921; cv=none; b=POgUtPhLXdM26ZupTFqXdxbeRiNQIci8YYbHl3VGo5dCToamLWd3+zGT+q8fHylcORzPl+9pKzxH7k+qyWvfHIfQL2UirriHNXqTvcz9X44ZwQZDTZdC5BJQFi/T016/ATLMX+6umP8nsGMExp081+LB44QkzcH+aTcgCd6RLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159921; c=relaxed/simple;
	bh=GFvevuojm8nmEGJCk+AwbjlI5Rxke+wfljwnv/Qmc+E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bqEN3r4fQEOaAN4Bv7i5ugYEtkr83LoWron6h7wBu9wuWrBM0JFs5gNk6j8ccz53uuoUddMn0Dyg9UcZmu1zrbLyAiICg4gTGndlIOB37AvIq0zXPueMOxu9DggDTn23mVkJQ8uQ+nJrFvM+VA/lAFY8CsO+ufbxhpIaQrTq0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQI7Ubli; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fa8fa48ee5so641591eaf.2;
        Fri, 21 Feb 2025 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740159919; x=1740764719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ykYjQfgMTS1zwgYyT7OdYz6h4Drc/oBeOO4qIvtkNdQ=;
        b=BQI7UbliHAcQlge28U3aBvzleZItWc/JOdfPnvk+PWrlIBqLOYsP0+8Ym+Jkl5j0Rk
         pYa/JyHPXkllYMdgSvXP5iEwEyD2LSsIYm9FNev1kj4o51AAAZMFD5EJrnG0JZtwhlXP
         HqWmy8d8rtRnxYJFTXF9JiY2easHzmNRSvztEMpil8EAJ6W/7aT+JdpCjG1hwshMmoQd
         kAuvxA5YIdw7QIZgcTAXLyl2vSyVOR4eemKyo0j8VkeS7N9zwDxOJJ/lTWjkPyD0SqIw
         jcKYUl1MNd4TZjPkuCDI2vKmaGM8XiKawxwpcWXjG0HJTPSgCD3XFsPw5ljvH3cfB+BY
         b+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159919; x=1740764719;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykYjQfgMTS1zwgYyT7OdYz6h4Drc/oBeOO4qIvtkNdQ=;
        b=MR7lbN6aR9uPDZn2xNVYrolYk48nQRaMRFtcyoTxyCHcekLCrx2Qovqf7hOguWO3ux
         yhqGobRwbQbxItn5J16NVDMSCzLpr5oNAuJOOgRNG+2S0fuFuKdE+mhYeP0uGPN9O0Tj
         bG9EvSDu9EWSMT3Z5EPcfxc+q7jz/FGY5+4hkFktZXOWK+URV/6kE9yKHYOlPbjdgrIw
         8c/PPY2yqluO8XtJSLc/MGT9BX0abITbO/RBwJIrA4CpgV8cJlJLZHtWpZ1VH0eZPLuN
         VwvIEIIOju2fTdVSA/JuXzmFTdqFAoGpFwWaqFtPnRusk0yi28uXabDVXiBAlXNLXuzk
         P0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW940pwe7Wqj+vBjZZCtKHItu9ttTC7Jkm4Rx3i9A+rj0xj7iDEZpbV2CdIMrnwUSstDvEYxT/W/Hb01UI=@vger.kernel.org, AJvYcCWjfj0FLb9IyDdnOPi7RObCUcRBBifVFtu2zIGxLPit1CmA6R87dcBhiVBnqc2x85IbsHKsruFY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+08Rj99aeNYSFfMGKVPIyx41rLrXPTb9vOyTt+fS3gim/yO0
	SopRj8ZGvGxcpBU5ga51phN68SpgYbGTZywq3TAuST2H+CkqKOY+
X-Gm-Gg: ASbGncskPUt2aILNn6hdgNuYttZdt2UzwhDlqP+Cg4OWJJ4sVU4wqjrHq1HJRvvV4h7
	eS2eooGxM+wmv/stKgeYGutx1NyPM9WruanE4tZeqzR7+xr3OvfLM/dLkDV/YrOFLrIaYcrYz1q
	EfKeZN+z+S5g8Opy4CrMx/J3wN86Viaugk/m0BuQgT9knigO2ufd4wrTok4SrRnljv8WjDPuky9
	Kl0g7+78fM1+n/oG59QoMMilFE4rFecGSZi2dIa8FhtDZeSptO8fC5TJC9jniMuYqNP2tm3GrVb
	zcmv/OqY0M2cTw1aKlNQTnQd631sVdWvgtJEsTj/lO15+W388dBmuQ==
X-Google-Smtp-Source: AGHT+IE2CQIYqYrNwIvVabWIxF3lY+Jx6qRzw4kd5pKccwi/CXyF6fk/NvtnB9rYM3hCyM5QpAwUCg==
X-Received: by 2002:a05:6808:1a08:b0:3f4:218:5c8f with SMTP id 5614622812f47-3f4246d7f2fmr3262943b6e.20.1740159918778;
        Fri, 21 Feb 2025 09:45:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fce7eedd67sm2298962eaf.30.2025.02.21.09.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 09:45:17 -0800 (PST)
Message-ID: <80ab673f-aa94-43e2-899a-0c5a22f3f1e0@gmail.com>
Date: Fri, 21 Feb 2025 09:45:15 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/569] 6.1.129-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250220104545.805660879@linuxfoundation.org>
Content-Language: en-US
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250220104545.805660879@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/20/2025 2:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 569 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.

And yet there was a v6.1.29 tag created already?

> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.129-rc2.gz
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



