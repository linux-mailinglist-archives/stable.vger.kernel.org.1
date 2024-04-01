Return-Path: <stable+bounces-35519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2A28947D6
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 01:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FE51F2293C
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D14757880;
	Mon,  1 Apr 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DhoMaQJj"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F357318
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014817; cv=none; b=XurmYY+TIy8kmH8ss0Ro/p/0Ud1DP4EHIs87noywvwyqeaCtLnKhEVPKEV+/yvUmzN0Dtp6wXpf1OJnMt12BfUj53E6Y70GUkJPt1YNslMMrBtyXn5CNWDiLldfxqttvzodV3+vL0hwm8YxgDmx8ZV86pFbsY8hLmuWK7f10tUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014817; c=relaxed/simple;
	bh=ZANE8iSaaHTuiCj1Edk/R46hIcM40ALkebRemnzrjm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6RYJgvwHVcVqtHtCEu0zoNoSdGt8AY+Dtp0ToXld+71MALuHb8k3yBhuCJvU+DNaW9WaPvW7v5IX9Q/4LopkETnZTKDiGcH+reC0J7LLZIw4/+i2y8lHTjkPZNnGx+1MqcChCjzDGfXT5Y/sKRK6tBeeTKDkA0Puuwz9JMHLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DhoMaQJj; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a7d9d2c75fso29640eaf.1
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 16:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712014814; x=1712619614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jl/3ugUzIx8xqjqXwcOaRMc2nOK0CyZ8ADAA4iIyIY=;
        b=DhoMaQJj+hcico3ZhV7sEEm0QzZkyhPwfixbDOR7oIA8wLURRC9T+/hVMawZsjuiNV
         7Zewup6k4NJzG5Yb/HoxISjFziJ7PnlqhIFALsRcmyZGmUCPDoh0iDdrW2YoerZD2hKz
         /cEnj5zWxT0Bs3oDh4K/P1PL/xw6h9COYXLA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712014814; x=1712619614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jl/3ugUzIx8xqjqXwcOaRMc2nOK0CyZ8ADAA4iIyIY=;
        b=M6dNxFeybuyrNDK3v04ib+dikuiWDAIDeeLtbVYAVh2WC01ZX3OxsLpRL3X/1+Q5dy
         KDlJfLN4VDkJtmKZRo9/QdnGjWp/RCE8zk+5M49QTLOlR/aYoIP2cbQgPBGvGJLAIPYz
         /Iec2vMD+4lMb28kCkZQ5Avbqa5FqlD2dKp00wSog7mjSfxoB3wXvTQMfqvsz3gzELqI
         xa6YsGTc7zC7BwuZ93fVA+ynl/QygUB+CX89g6pn854iH5jRVQUhBgGQxzLx8yU1RT4E
         CN4cUumBWUPhaMz906kQyciIC0emsCLcMrFAWmHFz/M0tKIoqgz1dQGrHi2sN8y0f4eX
         Nvdw==
X-Forwarded-Encrypted: i=1; AJvYcCXV1Dp1VlMHsSk59uyzJY9/3L2flS3ohn3tfCd2cYfIpFb03NsJlH6vC1wqZeCdd3f2l5Hc2NK+h1io3mMG4GUEhIzHaAvO
X-Gm-Message-State: AOJu0YxXoYaAK4zWmB+9snwURzSFlQAkzlutg2sbTCqK78oi8wvDe0GY
	Z0eEz9hKoCBm8wHgQwgoc1vRlD5eD5fhu6Q3CnC+UPz8uhP0nIG/9hF4fvKvBSs=
X-Google-Smtp-Source: AGHT+IGnhHZrR/gWiM2r8q0KacGseXDqszQ4vZbPvMDgaZ3DeIBfjuJgHJB4VqqNj0DRkKeo4sY/fg==
X-Received: by 2002:a05:6830:1659:b0:6e8:8d89:ed55 with SMTP id h25-20020a056830165900b006e88d89ed55mr7343253otr.2.1712014814667;
        Mon, 01 Apr 2024 16:40:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g8-20020a056830308800b006e67fcd0ff1sm2096704ots.10.2024.04.01.16.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 16:40:14 -0700 (PDT)
Message-ID: <bf6598de-545d-43b0-808f-aca2d5ce0e08@linuxfoundation.org>
Date: Mon, 1 Apr 2024 17:40:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 09:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.24-rc1.gz
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

