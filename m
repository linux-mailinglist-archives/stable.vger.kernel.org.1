Return-Path: <stable+bounces-139203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BFBAA5102
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74527A48A2
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D262609F4;
	Wed, 30 Apr 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CRYBIXXK"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852222609E7
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028763; cv=none; b=GJaTHHf3a/GYbH1gRuvdSEMdhK+yBZSMt2il3tNE/0/aym759mCNqzxEhckLsLD7DG3M1idR4v4yvt3CDIMwm+GpEI+OqkGl60cga6v/TFSWtZb+felxgN3RSj/ORoFaieO2PVylgD2Vf5jXix4Cm52gnaagjlLA75BMvPHLzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028763; c=relaxed/simple;
	bh=T+jWp7m5MmJAhHAncr831UxJIfIxqvS8QZ0MeuyejaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSjczTrEEKqcCkhVuqAlaJOQDA1l8G7Dkqn7kBsgSTEPoOfbR0P/2mhXgGzrw0YVllN/TwzgPBVy7Q5uIECWIJ0yfQwyjVjw4Yl+Fg437i9gEgppl9Lwg2MqY7ZuMBb1WP3u/AMZu3o1IfCJEBrNk1U6NVrHBFmtVdetrfY16tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CRYBIXXK; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85d9a87660fso710901039f.1
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746028760; x=1746633560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHfH8/RuvOHiVMcKgXPSO7Ua/1QwmE/VSmmffsLEhDI=;
        b=CRYBIXXKfp4ppam+UqM+P81a6KfT+OlVZkWSP2pn0PYmB3X0/ucoulpbd2POlsgh7i
         DK4ChL9KmfgQwXcZXsjILw6lkrX3uS0RoRH1cmwG7HKDafNrEW+UqSE76mFZHsgAqbfV
         iZuD7+/t5+nhjXZYQY1tLHQJSXbCgFvzrYBMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746028760; x=1746633560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHfH8/RuvOHiVMcKgXPSO7Ua/1QwmE/VSmmffsLEhDI=;
        b=FvvbiwBMQ0cSJia2aX5fO4aqumly6hDPIc6SaDr0lknyobCvbkOWP7LijlMG3v3qZh
         vi5lkTbNo7r2P4tpWTYmd21vufWj/tfhGVTikyBMtCY/MngAW6KQ+AHIHJuCePnseB0v
         2p5i+miY5/XX5Df76oUrIAUmOIl00V1wx7l7PjbjhSgeWdfepF0krtQvZ6FMUehsIeZI
         IkBa+8i7YHbWnxa24+a5IsDkxEXlhIP9axbVBnoSQEUsl6pfM8Gs2ntp9SLwOmy2cieu
         GY34z/uSn/R8FSUuf+0yAtu7dUfwqIkko8yT9DXELNrekqr2zYq931Xy9n+jBLFES17u
         zTIA==
X-Forwarded-Encrypted: i=1; AJvYcCVTyNmpP1TQqlOulit0kU6qIY8xwuFqlcMBsZS2rzfouF97fkTjQeKaP0/pxM0p8PWErtgjTuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOHrDqz5CKIC22W6UajgaVh29KDJWZ/BtC8VP8H6GzB9ih+S/4
	olvmi/HiypptucyzpBBc0fUEFLOy2ruQPHWr9jLq7ve1oPunlYVWVqQ9aSmZVKA=
X-Gm-Gg: ASbGncvEkGkAygkS7winjHkx/+17ZAHbyW9DOefOrLl8+dZCzhJ3TbmiZMhoLomrg2m
	D7c3gjhbI2pb1OGgS21EtBQQmTV5qAvv1S1SayYFrM3te73/98vYh9NY0C/I3El824L+YNGTh8T
	/vsoouYv9fIZtj2WUY2t+cLv0lqPmq2J5XduDKLv7DSYAcL+T5cdXusB4b3VXlk3P+eV409aMdI
	Yl7/HPqVk9Fg5wEaB3wKcmFhM8aUE06SPBy8mrkga5DSEFEG/W28JGiXlZJMXT9DfsNw5pkcQ2D
	S9T6lVJ91v8NAFLenmFoH0OB22wdE/3L88d1ZfcYzMNV0kAHR4M=
X-Google-Smtp-Source: AGHT+IEiAIs8OYji6l+Z+0g6CqLLwH1qcgR8c8xPWDGgB+PEAq1VbP+QvofEs/k8l//Tlnpao+jlRQ==
X-Received: by 2002:a05:6602:4749:b0:861:c4cf:cae8 with SMTP id ca18e2360f4ac-86497f4455emr318828139f.2.1746028760602;
        Wed, 30 Apr 2025 08:59:20 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f862b5d6d7sm864389173.0.2025.04.30.08.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 08:59:19 -0700 (PDT)
Message-ID: <4d1ff5ab-23b1-410e-850a-b0e38d7b743b@linuxfoundation.org>
Date: Wed, 30 Apr 2025 09:59:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/167] 6.1.136-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 10:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.136 release.
> There are 167 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.136-rc1.gz
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

