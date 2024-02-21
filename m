Return-Path: <stable+bounces-23194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8A485E166
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDEA1C23D2F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6108062F;
	Wed, 21 Feb 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g7NkZZSa"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F080629
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529873; cv=none; b=uM6MsM8Dcphhj95cfMQ8npGYHHcLj7jKodVvU/jq856MrvwDLm1USIW8szplXKaR/rLrOQ7psoCsaOBrrkY5eGRxSx5rV6DXTC+L1FaUNqn7FJ7n038KYI3NaCC+I7Pb9VzAvcW4Xury9HDW1rCJnV5O0dz5stiJ379c/bWbmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529873; c=relaxed/simple;
	bh=GVmjKweFpkvqNGNICWL3z3UdvYBia4a0Ku2Kgy+MvZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTjcnTBl6qiM6fMX4Z3DeTfg31LiVSGNUKpmpM1EfGnyXH21o6vqBnX1kGKSt1wJzALbC6djg7yVN+b8bCCVasip6utPHc75IUNxs2dd33MqjFKndb6dNTAgGFRwgLFjUwd2GcaatBkeixeCK9uoq6ME2TAxpuO3ffKrWaWjZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g7NkZZSa; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c00a2cbcf6so50984439f.1
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 07:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708529871; x=1709134671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jgzt36BlzBXtqVbdNQbmcPDo4k/aD72MiYTSmtpMR84=;
        b=g7NkZZSaZpZsMNCfBqfjtL4OjXg0C7HaYoffOG/S/IPEmzHta6IMwbVbrsC+2spqDW
         KR9p+EsgDVfhWn5pbypNnYE79s8JNNhS0e25NaZg+0meaZFW2uYiHjia/xBLGaVZ6+y+
         TwsWawBbt/ZZrLzeq2QzwmZG9vRa7H4m5v7Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529871; x=1709134671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgzt36BlzBXtqVbdNQbmcPDo4k/aD72MiYTSmtpMR84=;
        b=iW4BVGxR3mPb5svN9OADIiDPtIm8/ezpQIHhZPmCFKyg4AiS8XMqYRdgKNrBlc3+o2
         6cn0BBOtdpRb10ZyikZaYH4MtnIl4IqYHVrhPUdcf6ykUptexNHqnknCsveNJEa8z2V+
         TrG/oQWCrL7M3SM8xg1QOYG2UtPJDzQldYiKwXrgfXmPEGLYbP56sfSGLgkGl9DFrRMj
         5ua63a9EIkJkyqA2foPb6YJ9FGQr/oLW4gZRWYsBOqcIsl/qgtT1l0Gah0UWBKpwL7BT
         v8b30cJ0Cz4nXCQMzJ+TD98sPMcI681Qzn27rNl1cFGyqqbWrjvCadAteN4akJTf3z8X
         KDVg==
X-Forwarded-Encrypted: i=1; AJvYcCWXtcMdQ48XtyeK80ILr4VY6cNqYN7hjKGWGT1eqjn3YpM9FeM3zZiy21lt/MRbTIE2DYKnHvpsXtejqmohasGqXJU+34rk
X-Gm-Message-State: AOJu0Yz5kq8RsqMZSgc+msHcd7IYwXMFYv4HoidF3I5lQT5s6lcmZpDX
	NNZ/t2nnC3YqnpJo0uMw/38pmHk9L7WeifX25ukpJ5l/wL++QHGukisNqhoBxVw=
X-Google-Smtp-Source: AGHT+IExr/IvF/UtOz3IX45Dm147dWyye0NzXPRZMjCGqlL1L00lNeoZ+bFHxdOc3K9jwHGjAud59A==
X-Received: by 2002:a05:6602:2cd6:b0:7c4:9e06:b9c8 with SMTP id j22-20020a0566022cd600b007c49e06b9c8mr17837772iow.2.1708529871177;
        Wed, 21 Feb 2024 07:37:51 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e3-20020a02a783000000b004743cd55d69sm767784jaj.163.2024.02.21.07.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:37:50 -0800 (PST)
Message-ID: <63bdded0-e625-4a80-b85f-01032656108f@linuxfoundation.org>
Date: Wed, 21 Feb 2024 08:37:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/331] 6.6.18-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 13:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Feb 2024 20:55:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.18-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

