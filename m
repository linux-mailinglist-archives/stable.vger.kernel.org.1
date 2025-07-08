Return-Path: <stable+bounces-161345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A4EAFD6D2
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 21:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03D34E00BB
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EF2E5B2C;
	Tue,  8 Jul 2025 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/l8CanO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3117C21E;
	Tue,  8 Jul 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001544; cv=none; b=qgVgnw7cLfNVsyS43KttM8K+9WkykWaibvcmmYwJ2vjVUBylgL2E9KgFpgLt6gYw1jDOKYyXlrTKZBXsMS+TYhfGoyluIl5PtyNah3KT/STxfQiRFVAZ2D1NY7DJJy/8kS4D12tcD9uFuiSrrEJdfwti4kIGTsA4/PH31SDfp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001544; c=relaxed/simple;
	bh=UGQASGraoS4RJgSapElWkV0mXbfAG/bdLWBihBVlcb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVpPR4iJUCfStBSXn8+OrS7jnLgQ3lmNh8hN0cXgRJuxK/Xhz+b8uySOdI5AAExUiI97IcbRBzpoqRXZAGMce0TJdunYIBjPHyf3qkt7EVgAoRxw8V4xTafK6VXplXnGxBIQ/pLTw1hKv+hah0v6LrwvkAMPQRdAiUwHDN/6vMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/l8CanO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so4883980a91.2;
        Tue, 08 Jul 2025 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752001542; x=1752606342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yYgFtTx+hdhSK7R2K55RqajEkH2fZ0dRxSKeY9x9obE=;
        b=E/l8CanOTYoXkdZGuxKQWYEaew3fDwLb589WRmw9U3CcShErY3KcmLDvSZJp5GtT9X
         P8+/n6/S0x04Dc2yi5QQkBlj7E80goe6rbDPK24/CNFaGFCrk2rOHm0UFb7NOpB3sW93
         dJgbFj/uFfxQwDhHn+gYf3dLasIRLWv4xwQ/vqifE7rumstb1Gir0a02PcXwmnOCbjrv
         rzjt4XE3+JR6/iN2axkOHbW3DTJNC+34tmE9fGTTvwzkXd5joxJtttrfYvvKujnJ8VAX
         //TR5+6UU7WrUCK4EInw0n77UKZV+8GRHDulL1qitUro7Fh86jYXwlOkWFFjcxBRByM3
         iggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752001542; x=1752606342;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYgFtTx+hdhSK7R2K55RqajEkH2fZ0dRxSKeY9x9obE=;
        b=SEGzh01IpIYSX53rTWaOVwLkaesZCdw3leBVtWSWT3wD6ItfakYYP5wCqCZuwOutWB
         WnN4xNuKI6Hn+p4P6eB3uL9R+njmRuQZP9lurm6sJgKR1o8mUJu766q1bNmTzHd6IThy
         17CzMXyVVKeVhxf020VyLCPuzWRagmkPvVEHQItJhs0S3iSec+H1vRdivUrlafGfscQK
         We2QDvR0/VgZPCbuP04LtQWjFzPZIUuZwOYth1jC6tIVz5HQD5S4Xf+KY+oZziCLWME0
         nCfVVg53qBJUEi9o9b+XKy7y2YFNfMMxPRCp67urozaKom1Vz5p8+H3MpGZI4gwKOyf/
         MchA==
X-Forwarded-Encrypted: i=1; AJvYcCVcWoB31la3SKtrArSkRfeYAIO+ZrZiVNCK/h8raeyJVIFLFgbrhNvnLbUflEifYxYpzI1Vd6VDSx2UrxM=@vger.kernel.org, AJvYcCWvnx8EY+o3TpidxlR+brNGyM++emklkRAGsWqRF5782stkizjnonTf5QcVQOk4OU4J2Vsdaau9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+NSF5oDVD7oQ6//WxRu0PNgphsbac7oYZi/h+N89Uxig4NBi
	9hQ7HoScTkt84Vsl6q3Pfsc5jXdpL06RerlRoo7AQXFtN/F1mKr5vBRT
X-Gm-Gg: ASbGnctWTV+j60btiHd5mw172QI+Y1Ejo5fYn6TxvGQEKNhehAsToGIeKAX7KHtQ8UX
	Z8BYfi7AMm3F6hr0OMWJA/lLE2LgT5jz2LIoLtVS+cD5fWeB1+kORNgJCOvHcdRpqxzPucVLRqW
	SK071hIejQsqZIWSjhkmGGorclja1Mt8LKjrm7tXzWvQLooeKY4+kY2sbes4/n9jXWSYG8r/VgW
	p5yMyCWRupEUtjGHlFdrw33UQtRdRvuil0ey6ToY6KORI6JbOt9KX6+sEwvEp899rgSvjrFcmpV
	TRyqcVgoCMve+4sMxYCgc/d2zf9HEvy8zWCXW1D5Vz1v0Lzau7athA/wxkgswyZQVL0KiXfPTpI
	lgesTCw==
X-Google-Smtp-Source: AGHT+IF99FEmd4+HnT48VQVFxt8qSAjbLNuz32CzzcVxyXVFq4UqEBgPPDrLMMIibllTXmE4pPhWUQ==
X-Received: by 2002:a17:90a:d40b:b0:311:f2f6:44ff with SMTP id 98e67ed59e1d1-31aadd9cf3bmr32562144a91.17.1752001542023;
        Tue, 08 Jul 2025 12:05:42 -0700 (PDT)
Received: from [10.230.3.249] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c220bc5basm2982376a91.42.2025.07.08.12.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 12:05:41 -0700 (PDT)
Message-ID: <68de77d6-1518-4b19-ace5-70cdffef61ae@gmail.com>
Date: Tue, 8 Jul 2025 12:05:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/81] 6.1.144-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250708180901.558453595@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250708180901.558453595@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/8/2025 11:10 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.144 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 18:08:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.144-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>--
Florian


