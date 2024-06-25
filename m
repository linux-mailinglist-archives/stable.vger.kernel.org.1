Return-Path: <stable+bounces-55810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E432B91735B
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 23:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6151C24529
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B081A149C47;
	Tue, 25 Jun 2024 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oj6T9aaG"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205743B7A8
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350714; cv=none; b=TkKIn4k0sfwozqa95CrXkXCStIwT8MvURaDk19i+fxvB2tou7AhxFK+eAmNPkidj7ws+kcbajJf+e2ts9MBMKVxxcPw5BI/qlQHv7huszIOPcVbJf9638eJ+HOetGAdQGCOPgjDgpH1kG6j8feBQ8ZI9gQttK4+0eeV8CKTYRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350714; c=relaxed/simple;
	bh=pjCnSJI5wkLaPsKKzobjyBouBvkTV06ZYTrm2KLodxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8raYHcR9pE4Ujyo3/mEfMnJ0VeiYSIKqrlfPQl9FW3sZqAqgzgs92GIKt05bl5B92NP2FjXQ/DEWaxyzfa1qCF7wl2u8mNDwF+qeVOQD5urIR8KxO85bwDzVpsf9+8IZN4ssJLRPz9FQHeekHsoK8yW50WUrmNHccy3HUrDXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oj6T9aaG; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eeecebb313so17291439f.3
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719350712; x=1719955512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EylReHJRTyvw4qnns4SQL1C+bNXZftNvK2Yg8YJEAeI=;
        b=Oj6T9aaGb5QEepBxo+wjFFnY60Eu972uy4+3AdKfY9BYk8dNocUIqKlBssGwYpIX+b
         sHz7Mqq7g3YzzvK3IXw3RgBfGHWgOrvQ9hxEsIaCrHvB9zEa5nqTsZTUeOoF5OtD+Euy
         M8aN2tQIPaP+K/8mcx7sJgWCXQWNZfkY1xLYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719350712; x=1719955512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EylReHJRTyvw4qnns4SQL1C+bNXZftNvK2Yg8YJEAeI=;
        b=GSIm3OV8wAW/38qfkIgGB4qImlWQOAyKRCPLYzq2Kioch9wReqOEwpgbxmFo/NbQMU
         XzMH4dnjgRu4GwLT7HbMYza5TNDecG5iwiJv05F9x4cOobqOnDiKSLD8qLjxhNaVkYdj
         LRXmtRrAbeN/svVT2rsUFCeMmYXlotN6RF7TlUx8Sktkb/yGA6+8/3PgxzT5d8L+aBjX
         E9tIfJEuElC+Weiqps3LrKP3A+X0keRV4LY8D24xtoyLI5odhWcHqbN5KrnFdljWsOXy
         WszXyRGNEdMhc+2JyIJ2W+yHXlSssISjN0Uj3qhSTwwP+juUlkAM2NlcoYpowCDcJCEH
         uJBg==
X-Forwarded-Encrypted: i=1; AJvYcCWcUf6nTLdiUIuzOYDn0pjCJYNycPangxyqwnSoO4CZziK+mKGdV+EoCpKLkkKvxOWXDmR0x68HB48SZYs62Vt3b5Ksx7Wt
X-Gm-Message-State: AOJu0YwJbAhTo6NfKnr+V5ItnHWaBJgaiXhcdxY48Cb3DSDN2BHc2OPP
	PNjoNcFStqZ1ojjuUSzeZ8uqMKFGV6qDUFNYlfHVc+y9pO1L6jM0ZMlDoml244k=
X-Google-Smtp-Source: AGHT+IH14wzfXEp103dUuJgZp/zY+2GhxllN2ig5sbIdAStPyKNV6CKDnd3ffI59yJ1MhhKGpGDD5Q==
X-Received: by 2002:a6b:4f0b:0:b0:7f3:cd61:32f5 with SMTP id ca18e2360f4ac-7f3cd613354mr35131239f.2.1719350712248;
        Tue, 25 Jun 2024 14:25:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ba0069879dsm1182080173.71.2024.06.25.14.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 14:25:11 -0700 (PDT)
Message-ID: <f65e8a9c-1674-4769-a11d-9a76076478d4@linuxfoundation.org>
Date: Tue, 25 Jun 2024 15:25:11 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/192] 6.6.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 03:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.36 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.36-rc1.gz
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

