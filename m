Return-Path: <stable+bounces-113950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD70A29753
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 18:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B9F3A184C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5277B1FAC52;
	Wed,  5 Feb 2025 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKiCWz4l"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B071DDA32;
	Wed,  5 Feb 2025 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776357; cv=none; b=iSEej1/kqYoW+orgbi3PuHtbbBgcOiQgdhmsh2rxZDudSLdfjO79NWzfaHxLbF+mnPutmvLmTQkRZiLeDUnP7MBzsemgq0RwUTonMn7P0L963fxrN/RqRYtRAh/1kHcmsCviDs5DizxrJTDSg8+ntA917/6US4vwlIPOwHSmPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776357; c=relaxed/simple;
	bh=4fZ2waS4Le6CZjqkUYNRfumY2c2UMR6bpbsXUZLjIQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0mNLSs97b+/km9512Wj6gpHVvxp5kznO9GAprPGneRmxd5G811GEWe8UkZVdsk50X1uTopHE81svbHqkqOXBDneWy4DA5nQcFUsfFQHbactaX1AnyPkFhOIwaOpHukEnPqzED2WmKpLN/AYJm9bsNYgVpwFDQ4s3QYeciB7Lvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKiCWz4l; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ebc678b5c9so9553b6e.3;
        Wed, 05 Feb 2025 09:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738776354; x=1739381154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/ljvoAbrblzPWSlWGaI+of7Rx9z5FMvqfx035HSCoM=;
        b=jKiCWz4lYzsHtULvYhKPxF/BlCcFhpuPRUvhbKtsiKH9JmRYXxHDKQXjUrhQw62srj
         2c5FxFt+FTPNO6nULpS/tsKubXkM8olmo9Rm5DKLAvt+W77MQwhCMy2SgS6iH42h/0tM
         ji8PvTvDHLUqz47GGZF0KMVZhmznGezdEGdr9UGuiRCGFh0E4dHDdSl1h7BH6jLiIXKm
         26D21PEkurVtL9IC82za3Sxi9QHGjowtaSX7guK/Z1V4kB/htnL4lWu9uUQo8Y9iH9kW
         Sf6u7UF039n/5YoRP2/6QuZH+LgKV9wvNfryGvHE3gphjiGuJPCA7xzogz6Mqc6gDcvH
         E+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738776354; x=1739381154;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/ljvoAbrblzPWSlWGaI+of7Rx9z5FMvqfx035HSCoM=;
        b=TNCFrKS7Q3fHn3ZNhfE7qWFlyw/ftY6XYY7iS6khLCJxf7bu18C8eLGaii13CcAXOE
         smv5rEsDLXiE5u+vc2upyeIPgc4+HEq59bcDkRT98bkxO0MmqxqD/fGKqRPtsW+nH3Uq
         pjxI7hsIE+7g+99BW2eLPPN5pBcjJ3Wvxb366R4JdoTF/0hGsrdphaNZl0LRi/cC1gvP
         gPfrr0h5+JRRt0rcjTRUka4EwTZBtzkzhWufMnoC8Rb6amuZZq9qIHqQMJnp2nZzjKAn
         q2qoEvUhS8JgB5P6vpbFcuYNyVdd1BZmUFvdNpDMrfPx6ne9q5/inYb2wPwm61FhO/2Z
         f2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCW14WqAUL3OkBI10pJa2m5Ma5FP8RNcLhu3mVuo6oB/WjIymgizt0k6X2Eu++UF40jXEdg3tw/CTYh0VDQ=@vger.kernel.org, AJvYcCW6+d/wp8JJdb7ENitjdSIvvn/ZUG9gpLaiUKhp156Yoj2pRlkT5lQz9vViuCDs3FCsSoNwXt7a@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWMgU2YOR0u97S+0coEofSmJdxetPlpFkFz/Sn9t6TFxOcDYm
	yqvnjwVx55/IXPJXvRETzVYAMaDGifOFtklPPvD4Z92K0hdqLCH5
X-Gm-Gg: ASbGncvw+cjcoebeMqM8lNJJm7XtjsmtuH9RfeyGSr4nBk9KaIgQ19T0vUthQQ/wvYY
	e9T7eMLCGk0GjePBq1UwfxLqUafxla+j5Q8uiDT5dGDFZibybORj2t8C/RsS9+dag73EgqiySr5
	83UDHKx9yGWgRGWE6t1erx3Rt0h/gB35drUv3a0EkY9171yYAOX0c5jiHd3+dgIVu8QsOfFDjiI
	lQtPm9CSPhuTmAeiuNLzQsI4xddz3wOvPrN3VyLpKXT2Z/5xl5GLpkEzMVkrlK2e6c1bafErM2I
	icEy7prw/iw9fH0d++c08NoVj2oPjtdAHLO2uDIO5Yc=
X-Google-Smtp-Source: AGHT+IElJOEwGJXcpxepx+lPh9mZuSv1BA33+xNsWiHFiM16bUf+mtRCpLAXHEId4Tc49SoAgkWDLQ==
X-Received: by 2002:a05:6808:13c4:b0:3ea:6533:f19d with SMTP id 5614622812f47-3f37c178fd3mr2824741b6e.30.1738776354479;
        Wed, 05 Feb 2025 09:25:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f333523f8asm3614380b6e.6.2025.02.05.09.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 09:25:53 -0800 (PST)
Message-ID: <ea7aaade-b942-47a1-85f1-1a222efbf545@gmail.com>
Date: Wed, 5 Feb 2025 09:25:51 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/393] 6.6.76-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250205134420.279368572@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/25 05:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.76 release.
> There are 393 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Feb 2025 13:43:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.76-rc1.gz
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

