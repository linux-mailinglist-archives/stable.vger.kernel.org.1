Return-Path: <stable+bounces-178988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6DB49D0F
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 00:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE217878B
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D1E2ECEB4;
	Mon,  8 Sep 2025 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vukxejg+"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255164A06
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371390; cv=none; b=bb3hVqgIrJxqiHqC/QBL1805vxQCXLmOc7iSkzkgiinqwaqPtji3QZ0ZBsv0ff4sq0l0Gl8JkMfIFJBbVu/luWrKhjTL98TGcSe0kMJ72jXYtYOF8b/exASRUhjI+HSrSjPrkTSfil/H9iyifJ1bDhZ0Qn4sy5CKUP904DAUWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371390; c=relaxed/simple;
	bh=AP6NA17UFEK4vS8khTfuPrfkV1ahMoXWguAGdqx28dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5UCHHWQxZil1GipTfWoB5oB7S+CAaV+aWSnu70R3YYNsK2z/jp/0CVONcCYtjs627EejrtduQzrLNRsVp2l5ZPmkCjWLFmpdvjQlB22mbJtsrxQWwiIPBfgNKjhe22QB+FnJqYVeUh8u1UHq7Sn1dWNvG7oEm5SC/jljvox6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vukxejg+; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8876de33c86so296347639f.3
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757371388; x=1757976188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbMGQyBboCuY5jK2F7f01ZV8qrT1w01meJgp/Y4sXz8=;
        b=Vukxejg+jKF+Ymfhut0YF14r1rlcbbrE3FIWAJvkNC23qyf5NqbG6JVtLBCFGcif9X
         bQjOToQCcSlCjUT2gtgKHZUcSbFBLSYG+LAiOXTGV5+zhAzppQXebLHM9IoAvby1KVsh
         dStOy2o/tC1wX5kmpTEkMjgJz0grRO5dINy1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371388; x=1757976188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbMGQyBboCuY5jK2F7f01ZV8qrT1w01meJgp/Y4sXz8=;
        b=rRhhbhRngNEjZxgjsiQsrzr/7KRZegDSqndT/2PJNHlEFHa7fsr+lOQJZPOzh09mMV
         sbY6Q0hvJhBq1MBfzxfccd5axXrw93tP/vi7H3tRjYIDVk4uHcCNqe/KiKZ9jZP6xg05
         z4LlEiMha3CIWpeLcC6MoBe3NJ4zioFLiW0Ylpl3H4KqMkgS+JBQizzSjwKfptNdVzQI
         jw8onp6UHUZto3OgSVdqCYpNHea8o2zE5V2hL+8hMAkJxYJp9VrW68H3i2CpR2CfXwdm
         Lrc/3FKcZvkXdcGcUOKmFM+PrRpTzDeIPmWAQFcjCGiY/YHB1LiQ2djFg1tIqzfLW6ly
         5UFw==
X-Forwarded-Encrypted: i=1; AJvYcCWlSuAXZxp4HeGUyPZFERv2YFCUCmFs5wDqU7JViDiJ4ynNvtCloQMXbIGRt3glHHZZhzp0y8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdb9RZKCYKEh1mqu6VcWnLTpDGpCMkPaIyHwDay2sjPKoAVHx+
	0SsqoJWH/7Iy6B3Xk/M94loao4CwfwvBgnYHEk1ovbJ5ON+3J0tWBlxOFpvkvPtRx/g=
X-Gm-Gg: ASbGncuOtNkdo/vRA3RZIfNWl35hDL+DwFXheVjzL8DWYFNxVasLee0LdO8L9w5b8DE
	r1jRf1pg9Aglhw11G7g1+Fw+lHoyTF/NHXdWEh8HLmq51V1kyRB+GiBYA0FEf6yKDwOAnJpUkF0
	yuCaKG1qokFJUpzo7RLvzNUAKB6+ggp+CPLXXuoyU1TUMlWuuqHHRf1iGGPx+Eoav3PpHWuheu3
	jv8Qi3bt5O3Yaea4KyqCDa9IHq8HPQL6D88NrgIPc1Q9sgYnMYD+n2rvbDl+RI03KY8BLBkI5L/
	+KI6P8ibW66yBvSovyYchh3PGxDx8NI63WZPd6bRjfHVeonb2omlMoVZWMFV4B6/HlVZ+1R0IVq
	BxNEy+CPamMAHIzyAx+NwkYd1Vx6ibeVlxVMjF9A9LBNOPQ==
X-Google-Smtp-Source: AGHT+IG1BYp9Gge7NGDgi1L3gZTM5bfgvO7yzZ7+WLI8pWF6z3lCfVf2BGettYKpVA4ktS0Of3Te7g==
X-Received: by 2002:a05:6602:2c95:b0:883:fb4c:973f with SMTP id ca18e2360f4ac-887774dbf89mr1524260839f.2.1757371388285;
        Mon, 08 Sep 2025 15:43:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8871e2eb0edsm864803239f.2.2025.09.08.15.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:43:07 -0700 (PDT)
Message-ID: <9aa01cd5-a736-41a9-ba24-0f0c2001e878@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:43:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/104] 6.1.151-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195607.664912704@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195607.664912704@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.151 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.151-rc1.gz
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

