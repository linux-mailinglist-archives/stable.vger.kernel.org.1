Return-Path: <stable+bounces-60453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10128933FDC
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 17:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C006F282EDA
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC87181CE0;
	Wed, 17 Jul 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W7fer3mC"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0A181BBA
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231038; cv=none; b=OzmC7NA3EWUzPmRIbfAjoXAWKkhbIcYo77j6Xl/wC3/f5GIkjjj9MHpex41iHzFnW5jsBVoa2yOZ/OLs9kLTtFxrntuKEPrPOeo4Tb2rCDUjJxWjYkDX2h55YLoeHv3SS1UIUQzZI71xtn/9iwUlRyT8dPyAyYohcKzxxImM9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231038; c=relaxed/simple;
	bh=wb1LYv4A0acrrEtIIC/SAaWQ8u2gOiMpH/PnqcW8a6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaG7nJLHd6C7MI1xtG4mNPubYUYJfzd0ddSiiObLn3JWPjOPNTj4+Ckb2LzH6Fy6/0vKDQP2xu5GxvMmT6DPNMuG9dNc7063/B0pIzguoB25JhRw3tDaSWKFmTd/k9q46JrbK7GlkAavy7o/AP329yaAK4WSgnww9zzSMa9EVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W7fer3mC; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7f906800b4cso4524439f.3
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721231036; x=1721835836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhC5AUh0nXY2Z/jAhnsZPgn+TyMTEjILQNMnkrHVTOg=;
        b=W7fer3mCYnFwJLWVm5x0l6nS3QdyVyK/6U2yH0K+IjpAJXtRhKwqaCjN9MrKaBuFsl
         7hLAzQlfSICcm38X/zKxLzRbjB7nzxumvK4GRfcpQFxLnCKMYhHzC+VeCmmEm1f6sgIy
         NxnYqrWpqFDfuHuV0nFKjCBfMKPJzenHJifuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231036; x=1721835836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhC5AUh0nXY2Z/jAhnsZPgn+TyMTEjILQNMnkrHVTOg=;
        b=clUYR08TK3QfUhNJhbkfujz3fyFxewFTSAVBq+2OBvtXg9hW+Fqa7H0pGS39iLsvrT
         v8w5hE3uqGpGkapfUrd/4Xw9ArmA5UkXAemBrX1SGxUt9Vh0xKy+mrQZu7YmD3M9u5kK
         1hceY6FLOvM1+ImU3QT/UG3RhkNBU6Lf7/Dcbk2nhKNsAabdkXOmaL9Jx6CrSsckg7wg
         NUI4Kzhs+dy5Y+OpieGTbagfmkGVMj/6yIXge/GkD2/KTgl6Yspmps1cpkczYCwOrT5o
         XpcyIZ8SZMEVIELZcZBeEAlEggIIN8LTo1gw1+ysnX1mCQqzG3b5GvuAeUTsaxNQ/0DJ
         4ybA==
X-Forwarded-Encrypted: i=1; AJvYcCVkbAyKFncdHiqs1zV/M5HckJYf/Bu4TeC6O1pCGzfokAXym13+ez41lxL7J6WPKI9An5dGSFuOtCfl3P/9OphvTTbQv3Ux
X-Gm-Message-State: AOJu0YxYYM8JcnwlofUMj2F6f8i+sxLziti2iONhNUs5DDOSq7lX0YDt
	yLjgOP27T0ZIITXjvaguHPI7Z4VMiNtfsOLIDCD4yvLRQBmccfkITVWPZXhfAYI=
X-Google-Smtp-Source: AGHT+IHZXl0hg8iG9vIuc9XxlrCQtDPuT6ZziCdBXxjOkrQv2c9JNy1ocmAplgM+FJOKVBGMYPOa/A==
X-Received: by 2002:a6b:ed13:0:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-81711e195e9mr149045339f.2.1721231036378;
        Wed, 17 Jul 2024 08:43:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-816c17c4e40sm69814039f.12.2024.07.17.08.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:43:56 -0700 (PDT)
Message-ID: <a00b55c7-9491-4e63-add7-7f0f8649ae3d@linuxfoundation.org>
Date: Wed, 17 Jul 2024 09:43:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.41-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.41-rc1.gz
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

