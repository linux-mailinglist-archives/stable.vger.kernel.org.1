Return-Path: <stable+bounces-56904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB892924C33
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 01:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CA1B229BE
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B64415B0FA;
	Tue,  2 Jul 2024 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guAjtI8T"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E417A59C
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963636; cv=none; b=tiC5v3ycv4U2cViO4EdUDc+zwH2Wx/9/8IurNO6h7WOprNNfsL95HVsdFywGkASX/+EbQNy4IGQkDVz3tQf+E1uq7GxbkPz2VDlZdjduGrU0KkU1Gkyi4vlmH7U9+seYSH6gWH6puDw6HeUIL9XQqW8UfHzcxDTFqk8OF8VclJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963636; c=relaxed/simple;
	bh=q/Q++bZUqwx4rHkgKvz/qr06d8ZoEgwD8AdUokHeVi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFOVfIAVMFR/HxKmp6Ko0F1Lhyrt00NnxAwCX5hR67gi+LiW/13SmW/lr60cjNh4MQffchEEX2AICqMMlvUsjHX6YZWBef6W0nDQXXm8Ro6tyzFeLw3DNcIwo0M5Tm0CQOqk8nrP6Mv54sxJTERQnXSjovGHzU492D+ZpQlrLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guAjtI8T; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3745eb24ffaso2707125ab.1
        for <stable@vger.kernel.org>; Tue, 02 Jul 2024 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719963634; x=1720568434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1GBiR2qP3dwXuNbCIfCAYqEpvO2cT6fV21GvANeJLs=;
        b=guAjtI8Txfx+2xC7+ga5NwFLyyXBX2x2RwRhWK1UMY14rP9igHRn5JHcfp3sqTywxw
         g93wQRvxbEre98ziohlTCwQ/ZG44ut7yRvMto6wJLeow3XVNJcUsWox8R4YrqB0U67Xq
         VtS2ei8EkfwagPyICYJynqcDn5tn4u/FH4Tkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719963634; x=1720568434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1GBiR2qP3dwXuNbCIfCAYqEpvO2cT6fV21GvANeJLs=;
        b=rkbbhU89h89YBMdjR1pBYJapMYptrfmnmh1D/h6de1qOm/eqMHhBhJqFvUkf8OfnwY
         ARWAjXGYpgHej2B8PHpbopS40u0Bgp0M6VEEvwTXwZUvjuXQtseXMl3sH/dQbUzfUq2V
         fYSHm4JaAXApI/Er/MqFGyRClcA3yOQOIZpcRClsBuWcPLvQJ4HxIZVkHqwsAXAWYUD7
         EGkDUN7eQhQX0upZI2TCAWzGRIRJUbWF/gYZLUU43VkOq2bEyO7bzq0aLZwvyoYGapiS
         VoJwqROQOHDuUTBJRCg4lkES0jjZDxcBKAuD59XyunGMeqhwFM+RBixRd2HAehq0O8Oz
         Erew==
X-Forwarded-Encrypted: i=1; AJvYcCUp89ACQ7Tnr4XD/Mx06yLzG6UiaGEbwNtBW8BAyk6pHZct8JBuLKWC15+2xpORBRDPvHE1YPD7br/gANnttdzdiPfRP2t/
X-Gm-Message-State: AOJu0Yw9ZgQjoDfffyLswg9aJbOMPc0tphaEpBJXWw5+fsFalrfoQEti
	FipJMrO7CclXd7NkUqkgbRkdpVmHoMwS7BUeZYTyfSautuDyuTtrllCHc46e+tM=
X-Google-Smtp-Source: AGHT+IEROh2kDmfI0/vSuk2WwbomsNqHiQ8Mhs6Xsy7UzYSACQgA31qwiBNSiGoU/iCVvVcaUQXN4A==
X-Received: by 2002:a92:c54d:0:b0:376:3907:4912 with SMTP id e9e14a558f8ab-37cd1b799ecmr112365645ab.1.1719963633925;
        Tue, 02 Jul 2024 16:40:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad22cb662sm25750825ab.7.2024.07.02.16.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 16:40:33 -0700 (PDT)
Message-ID: <857aae90-6251-4532-a8d4-6d2fb8d29114@linuxfoundation.org>
Date: Tue, 2 Jul 2024 17:40:32 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 11:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.8 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

