Return-Path: <stable+bounces-150615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D055ACBA51
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 19:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58705176FDC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E372B22577E;
	Mon,  2 Jun 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1evD2iO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450151474DA;
	Mon,  2 Jun 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885391; cv=none; b=Le7MTLwsbYpUzvmFYP3vl80jasW0/cuHSKiFlqQoFAUer0zl2zpQ3WvAh6oP3HNJEbvxOmO30VvxNEtw9SzpLnsiPFbXAgPgiRk/CXAPKuHN9OAvdfDngHvxwMnuFwcc4FOA/NUVmaOtp4JQZWd3V8EbRPoUBkN1Hu0joAFRhwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885391; c=relaxed/simple;
	bh=/k52fvERoV6696ZIQjDt/Yqaag8+kqaiCAcdYh+ioxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igWS2AwVZDlR6PnGQ4JTGv4mn1JwbNubLGC5DCvGqB1umfTR99/Cii6t/VeYR9wJH/90I2qiYJsSOqwTVZsg3KHiMU0NCP5ur2Cph0T/1g9tiEb5YfKLDua9yPRAlFX7WLtnBMKYn3o+ZM+05CO39yke1w1pqaPQkv4USX69c5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1evD2iO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2353a2bc210so29019985ad.2;
        Mon, 02 Jun 2025 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748885389; x=1749490189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/uxZx90irIwx1TMKX2TekSJ6Bc0YQ9kHKHz65xqfy+Q=;
        b=S1evD2iOJjJTtTzUBcpIk+OwzpSCMFU+lzKrGVNTaIcLVdA78lgnHi7IKOCI9CiEuP
         KS+frOiNAhHJlNgmB6HXLk4uK4HoyCId+UcfJLoWERuyX4uYMUFtPCyGCUjEcfoBr+Pr
         wum8nC8M8HsASha0S+khqiZ0quwEgCmLPrXrgfnb0APNDJIgXfDglZ/7hxQfKYEebtiC
         KcB6NhhMVApI9cA9cE+0eBjwFR9wMAOT72xyCIu1FO37lhKLhpf7VpnjcE87qZd2u93Q
         yI2tlRD0DxpojCUYmH0x++nCPXsO2PrHyc/KGziV6dQwqnr0Z522EQJvRajWofV+8Gu8
         xlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748885389; x=1749490189;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uxZx90irIwx1TMKX2TekSJ6Bc0YQ9kHKHz65xqfy+Q=;
        b=Of7ybSOzY6t/0+8kW1uh3SVyhUiLecibPnf2UR3TSqikq04kJf0UjZ90sYH8Csl9St
         L96bzM2aIeVf0pUX1CbPhVx/iE14wy+TK6u6kTx57u/IQ3nGTvazphUS/Yeepq+WdMtj
         4wLw3k2lDv69PdCakTF9/fx2DJiLI3FV1Hdh81SMBXB4Q/2oa4OAQS3Redk4DjWsHP2L
         h4ewlhrsP5GB+A1hDI/UL1JhNBz/eZiMfv17zSoPa1huEq7LsV+gkXWcLtGG3u3OpZop
         4J2MLfopf+hmVdeHsHWE0Y7wQ0/E8DZO6tVosqmi75WGvf/Ngwzu+IHh5KB+NJQd0yBp
         6t+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIxzcjEJBuaA60AXmzmvtv1Pr0yYXYcg1opkQxpbU3mp/ihuNlHgP5mYTXmOY5IOVqsuGxlXFXzW0RHTI=@vger.kernel.org, AJvYcCXRoaKhvnl9G4MkR/9U1T+9Oz8oYUGmer+FJYARFm6KfpNjJvy8EdOPnTbJPwZSvyYXFVue8Htw@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPxFhwIpqc8OCZ9hueYVhBakg7//ht+pBQduQJVP/LUVM9riz
	QK2Ib+KdKCXZB2wMKHpQ1YBx2oaG+5KMX+y9NnVaZwGw+wHat24312tyHTczibhx
X-Gm-Gg: ASbGnctA0ELl1FYZq7KZZyabquYdlEIj5NGN5YNAuf0tL6wgbtURO22ZMTud5j1Ibt5
	hg+wF/KYcAe10IXE3aZWmNg06VvArVOr0Z0Y7waHKD37XGVRb30XBewiZA43IviA296Cie5Ujul
	9736kj7wWf+j6MVAkD3nXS6NTEin4u+DTVaebBDfTeD0PUc6U0Ty8AdDV/6anUvaTupFmJ+rl4Z
	U/2p4qZIpd6WiOYApky1vhVjpTvitxyHWge7bZo+TocAaWfZ+9pFHTYmI5+Mff2vYGz7Wb+H0tF
	kqXsSnum0T9X0ZxBNn3SU/OxYnLf4O2nk4O4jLBfGvXuUk8jZx9L4r2LtxFv5KqycotRP6roW8q
	sTYY=
X-Google-Smtp-Source: AGHT+IHsQwAsgpXEgFwRa0MDFr1nPaEbL7Y2wjlCeuBsa6w5UKvZTbynN+EC/rV4/tyj7X77V1aGyQ==
X-Received: by 2002:a17:903:2b0b:b0:234:d7b2:2ab4 with SMTP id d9443c01a7336-2353956657amr179906875ad.17.1748885389519;
        Mon, 02 Jun 2025 10:29:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd943csm73768645ad.85.2025.06.02.10.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 10:29:49 -0700 (PDT)
Message-ID: <8c4df7fa-e1d3-44d5-bccb-b246322b8b6f@gmail.com>
Date: Mon, 2 Jun 2025 10:29:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/444] 6.6.93-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134340.906731340@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 06:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.93 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.93-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

