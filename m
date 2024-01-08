Return-Path: <stable+bounces-10344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F88279BD
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 21:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B01F23F4D
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 20:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D7F537EE;
	Mon,  8 Jan 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqT2sUwS"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E855E52
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so30654239f.0
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 12:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704747387; x=1705352187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4yKz/JhLgLi3Knd2rZ68xKQhkuYKcUZwbsJ6WBXa8vM=;
        b=WqT2sUwSwchVSLp03jZtpVxJl1n6zo53kV5FMZV3s7h5Uho2Y6vliCkZ8USWp5J+5p
         WjSVQambxv1MLdVEII3oIx3BJYO2J2ooMCL4ebLB73QKcbmt3U1+4LJGilK0UXQFs5Yc
         fGsJoZ/xh/GrzLFrRCyvOypaa38GGb3aqr6MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747387; x=1705352187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yKz/JhLgLi3Knd2rZ68xKQhkuYKcUZwbsJ6WBXa8vM=;
        b=uJQvXjT0C0RG81qtMyPG4hyrtH4NU3aYzPvu5WDe5F4pZKZi6J3Qr7jedFGN49mzoI
         /Xpbllg7izmcvN8Kz6az791DPIuQpVpZfa3V4nwvdDu9/asx84Sod90tSX8kr6viKgen
         iY0slfMSUbTtIl2ZtVKnpERgbpmAH83or/x/uZHbN5EJRSV9TmxeU6kF1+PMeOh4NNIO
         PQGuoLM0ysvQl7IfifFikAnqLIQ25CqeXFaR25UQOczJ+fMwJpar8QllcBzy6ugAH7oc
         pJmRgHFOVw2fSnA8oLrd/hEVpMvzJHLiuSpXQ+muMV/jnjO1C0zpv4+BFVY5sBQvluPv
         JFuQ==
X-Gm-Message-State: AOJu0YyuX78xs0eqOsAEW5YDgs0+NpVj35cbe6XMTKbTTp8WIpyHPiav
	YivQr7fk3C2agFbLJfagZPpivlNQ9+ikPA==
X-Google-Smtp-Source: AGHT+IEld0xwQpq/z14M65PGxwFKKk+CnC8nGtMUq+y1wj6a1+o7cRe7a3fvyIpqmX+FnXSzk6mKvA==
X-Received: by 2002:a6b:c8d0:0:b0:7bc:32b0:d414 with SMTP id y199-20020a6bc8d0000000b007bc32b0d414mr6679067iof.1.1704747386938;
        Mon, 08 Jan 2024 12:56:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y11-20020a5ec80b000000b007bc102fb67asm122482iol.10.2024.01.08.12.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 12:56:26 -0800 (PST)
Message-ID: <41e45eed-13ed-486f-b571-919798335900@linuxfoundation.org>
Date: Mon, 8 Jan 2024 13:56:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/150] 6.1.72-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/24 08:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.72 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Jan 2024 15:34:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.72-rc1.gz
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

