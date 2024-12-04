Return-Path: <stable+bounces-98332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C8F9E4028
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4CA167599
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D3E20CCF2;
	Wed,  4 Dec 2024 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6ZkR4UC"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FD20C499
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331324; cv=none; b=mSU0S9P/BXFOum8PeBoL8LYY16HbMBN3AUjR3OuxS/xPywPck+371dazi/kMAG1UBDVbeZbPPq0UaJFpHkEg1yL5IBzMaf+jgBMEEnFX7tguKFiugRJJMPDNDh6m4qMJurDH66iop4GJssKSkiGmeQG5D1SWqfzKTdQp/q3oPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331324; c=relaxed/simple;
	bh=50xntMHu6DoF5HbqKeUR5WTuI4girmXp5E2jTq+5v/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BN1wBBtq7WOK5lp73CEGi+x3adl2oXzpw6qU1GURpYm6mBncu57xZ1P5VmUJIE2RpHdJWfUTT5KXWfy83IvDqCO7BA+o7ysymq2hsV4jH5YS+w8drJlJMADpe7ZZHepNL5TXDjKKN1ilIkfwbNFXf988IQvocEdRCxaqBAmB6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6ZkR4UC; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-84198253284so229679039f.3
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733331321; x=1733936121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9rvImidU/UNWdG1VLr1J9XNVi7IRCZUz2k0Jnz9nrQ=;
        b=N6ZkR4UC9Lgq49C/EDseGDRNLAYcxjF6gIi24ayZp3U8MU1v3YQAAxV3cChLHUcKhs
         TPMSO6bRBi7lAlORT8ZN7f8FKyuWuvMHMYf2UIZNOHoulTFrUnMj3G88PHuwCS0+ZOBm
         jmpV6KclhoDQ1hAM3Kpk9X3KYxJkodgjycsas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331321; x=1733936121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9rvImidU/UNWdG1VLr1J9XNVi7IRCZUz2k0Jnz9nrQ=;
        b=uVTLEbLGsISHVdym/Rg4je4qQhlS/aC85ml3UkhgGRoYwm8lTGA0d7X+Za4FkwnbK8
         ljgeNHjp14HhcgMtKWIOAPJmNIy8ZFams7b4G542Vi2t11y+oagVtxBAarRo4lJsOmQT
         /nnMYIDJnj4hVxiW06Zx4MWNLFg+IaROIjrqHxCP2WSXAtQ8LONwF7SKnZEKjU+5tbKH
         RBOx1Ew2tTUhEbTl0jBjbd2al4tQueb4Gbv2n1+RBDRaFLN4SwoFYx3uSasY53TlHKmQ
         thogv/iISECN87DDO/2MoeyuL3kVogsWO4mZTcRpkgOEe7Ifpugu/D87JuYW1CTHne2G
         bW9g==
X-Forwarded-Encrypted: i=1; AJvYcCU5tujL0XA656eUy3G6Vjbu5aUruUgTencM+AWpUMvQURP9HhvFiYPANkaZxqE26A6jbNsFMoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcP0EStJ+ePYeJ6KVv071qnYRhCbKNXi/iCWQW+BnA6z5LVfxT
	mShCnmMvw1C1hd0YB/2uyyowzgYbnM6tKsNtGZ7630dy82IyFXj8RxR4kMTmZwY=
X-Gm-Gg: ASbGncvwiWzR/YOIWE75sVpMXMC8M4GE/lwX3e2bxlbEP7NEFNlFf4JActBA5flcYl3
	7zMPqbG0b/3SThwe6Uk4p7OvRaPWzsub1dL/bQAfztgQSX7X2xgA9GXhtjkVTqKKXYoCeqY+FAM
	5vljaHM7k8xBRy6s+DRv1MXXV1qFZ/2GwYC4JTH/eHKh6HLcGxx7T5vJg6EsgSQ4u0oGWbNuTwW
	9PyhaAYzCCdEzA6/MJdlepR0nrumu9O3Ff2Q4IIsEgiK9V02weaZ/EBRdnr1Q==
X-Google-Smtp-Source: AGHT+IH1/7Y0wwlKffNss3OdZLCieQ6uhiHOEWOAMvcbuYpAzMo+3UlejFx+5ubYj78zQviYx9B+Wg==
X-Received: by 2002:a05:6602:2c8f:b0:841:a9d3:3b30 with SMTP id ca18e2360f4ac-8445b53e299mr913854939f.1.1733331320966;
        Wed, 04 Dec 2024 08:55:20 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84405f97db8sm322266239f.34.2024.12.04.08.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:55:20 -0800 (PST)
Message-ID: <0218c67a-20c1-44b4-bacc-d392d8163d96@linuxfoundation.org>
Date: Wed, 4 Dec 2024 09:55:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/817] 6.11.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/24 07:32, Greg Kroah-Hartman wrote:
> -----------
> Note, this is will probably be the last 6.11.y kernel to be released.
> Please move to the 6.12.y branch at this time.
> -----------
> 
> This is the start of the stable review cycle for the 6.11.11 release.
> There are 817 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Dec 2024 14:36:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

