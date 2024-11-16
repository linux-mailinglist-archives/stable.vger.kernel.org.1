Return-Path: <stable+bounces-93667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA849D00EC
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 22:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1544428458E
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 21:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725981ABEBA;
	Sat, 16 Nov 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FbMoKkH/"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFF194A63
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791795; cv=none; b=hB8Gc+QPpmaotFoBzyqTnEWcN/JN/0t+wzG2Lyz6jzr/57tY44IWPAEIAlaGs+YTaKk/8Rx0BrlDB3Ccxw31gIkDXSYD2etccJr9vIGoN6/N2eb96wh50QCr2J8eq7dIrvitojX1B/v2fZHEE2r+4NBAejnBsybVMiO4CGrE/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791795; c=relaxed/simple;
	bh=7PMrz2Zm2mvfKq4nmNSmKHiyobn8/8ri+IZxkljJbyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWk8hiT4Uqq0W9UtuTlmc0ABjWjGenII7YNaPW4p50PL1oVscQPYWRrhS7YlHZ2mlbV4F1KoUuUKAumfsUokcjGjZe/8VghWfmG16lUnSqEzkLjmGfxsQZW78c3L4fLjY/ww5oagpJMl0MjNQV8azgTWBRhu2vgkvxidddJwvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FbMoKkH/; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83e190085d7so106300139f.2
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 13:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731791792; x=1732396592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThohtjZ3n9Q8TJFQ3v76IV9uxQamdVqCdT9v1KevZbM=;
        b=FbMoKkH/a9aRxfcuaN0ievBSFgDiaFqZ8zrEv9t62KFof+lI/PaaAA76u4qM5H4h6P
         ELnpEXP8hwKDLL1EIWjNnkalaqakriz2F7/s09t84R/t/kHJjhPnX0hpyOh1RfgY0wIZ
         Ui5z/pfWuT7fLq6B0rNuk6hpzmo2/FL2FnRhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791792; x=1732396592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThohtjZ3n9Q8TJFQ3v76IV9uxQamdVqCdT9v1KevZbM=;
        b=WtAodshCbksLgiP6hZjIECcJkU9wMjs/mFZd902nrRgltpUuezXtXlu4Qzl47/Ewi1
         2tI4WYKFp0m2tso/6dSwpyHdyjN6nso+Csa7/3F8bBT+UwkluiQNwOEi2XsiuRIzzLNE
         S7FS/59q2O7kcoA0oMmJmoAfjB7z7bJyCRg4WDrlTAVj7GYjX0lwogbrB1B3etQV6joM
         NaEVmQvsL4WMTD7IlTmjBm67RxG2byJ82Ez5TQlAL8gCoSiiXADTwg8iAUbMqlnGVNJ0
         qm91WqguzH8jND3KJTUyVZOk8pRSRXiZ8HqJHf0K7sxYMpN3RKjBLZD4s1cyzH+Ko186
         jtdA==
X-Forwarded-Encrypted: i=1; AJvYcCVyA4FD2Dqrp/hFtoG3FpdpBt16ak6oRnQ9JEvmSFqUyhQKAwEL8dclDN8euAmVid9/+x3NVzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6ovzJzUpY39fO7in7btrsi7Wi0Ljg50jbbH0avm9UkkKuhwB
	h9wj6Lok0s65xoJ35yRDTTXQ42XSn4OxgbsNxwvGJ6c3AUwJERI4IZ1+uu/pO14=
X-Google-Smtp-Source: AGHT+IELWGMLxig5RgGYIn+TwWmLLm0INc8xcQs14z602A4podqiHLfXde+yVDHHN+PzMatqyRdC6Q==
X-Received: by 2002:a05:6602:6c08:b0:82d:9b0:ecb7 with SMTP id ca18e2360f4ac-83e6c299f59mr878007339f.3.1731791790626;
        Sat, 16 Nov 2024 13:16:30 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6eacebsm1260708173.25.2024.11.16.13.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 13:16:30 -0800 (PST)
Message-ID: <e143fb80-e6d4-43bd-84f0-14a1bac08df3@linuxfoundation.org>
Date: Sat, 16 Nov 2024 14:16:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/67] 5.4.286-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115120451.517948500@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115120451.517948500@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 05:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.286 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 12:04:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.286-rc2.gz
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

