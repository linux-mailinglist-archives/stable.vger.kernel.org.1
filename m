Return-Path: <stable+bounces-26835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD32872748
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 20:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2EFAB29B21
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF115C5FB;
	Tue,  5 Mar 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FtAvrqdz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9F5A796
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665518; cv=none; b=rD3eWr1or0uD+jzJ4UMYWJyhFZxOUGz/A3jSxwVohrAPd+Rkv+ywTnIYHPCGbpNjFQa0AGOOJxCfuM66T8885OhDT+go38nD5LmwPw4t1Ec39M3q/UWLhZRzcwL1V11CzcuHRO2d6KMNkZKy4LNzCcEucaTf+nkbfIrtAKXg7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665518; c=relaxed/simple;
	bh=pLKs2o9mN+L/TVn40Qf5nbTSPRtRFjwhZXU/y/3HgyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgzLNFDEthDz6dHQ9JEEWDRDQcRA5nowBMK19RJgcRf2UEc7nNCYlqoNptfDHG8nv9ZjHYHuA6wz+kheh9mvwCECf4ZAP3sdWbGke9XELegJMTOSj/kOSGeUgi05bVYjZPS1OhfLmUxrAvkf2IBQs8JI/VicVri23Cvv8IwJTwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FtAvrqdz; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e4ee3dbc4fso525647a34.1
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709665515; x=1710270315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Bv6g4mYuzY5a2DeNIRGo0Wt9Avb45ARXee/OX48tck=;
        b=FtAvrqdzP9kVdo1hLyMXaq8VfRgeA3glKW/Y3qy8Dn8P37IrI9rxxKmqU1BPMR3O+M
         g+iZynyP+1m6deccAa+5xz20Y6woAf7x2QT0jsTmqwUEUivAnKT6FYGU6iPZSRQX0YSM
         nwi07i3LP7NQAgnaN3lW6hmAcHbj+WKg+JZ+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665515; x=1710270315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Bv6g4mYuzY5a2DeNIRGo0Wt9Avb45ARXee/OX48tck=;
        b=FYWwTNw3JY7+rNGfzlJmmiMli1nZVzIxK7XIUdDy0j1iW1XT877B6bbZCOPtZTg3pY
         0jK3f851PcYR6pdmExKBXDL4dhTcfsjB1eFasXvOzOKQRAKhzGyh22nmlEoXfHxHOsEX
         SD1rpV4LKYppP2m8bzwGSPHt8/xdpiRdH1Lj0bp6ATan1eHmmuBdUssVyD42nBANgemV
         /6gQluWZUdZLfji41A6fAwLKG0ZSo7UMtbpPAA84NY2FrccVIheTlar1BVphHYUAq2cz
         jhSEvxRKePI5Ic+s5Hl5ihrK/SrREzcTbHEjxlRjJHWUWKfXlvtQ1/lykn02Pw+XOpZ5
         Ee+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUZWPBCeHRbrIZINvL4MftijBaT8/r94jaagGpkrQJCa7/tSDc/bDrTLKQmTY3eUMSQsdTWFsrS0fGaz7JiwyN5kHIkHB+
X-Gm-Message-State: AOJu0YzeH+c/F11rddJOhALEgalPAf+Ezoq3DVY9/nfjbfQbCTs4IHBi
	c58NbySUipEbxcTGJwzqLXxft/2//wtwX7LvcKU0Ae4j6MxmoutbInTEDW378Mc=
X-Google-Smtp-Source: AGHT+IHwdrcOWBop+MehQAntWBGU3qhsJDffTHndvFcz3FuvKd2Tgbqpv0qQA4VKJ+ctmFsK1hWS1g==
X-Received: by 2002:a9d:4710:0:b0:6e4:e0e3:55d9 with SMTP id a16-20020a9d4710000000b006e4e0e355d9mr1456409otf.2.1709665514706;
        Tue, 05 Mar 2024 11:05:14 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e3-20020a05683013c300b006e4b446439dsm720336otq.70.2024.03.05.11.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:05:14 -0800 (PST)
Message-ID: <51239853-ee9a-408e-8328-7e74748e8b13@linuxfoundation.org>
Date: Tue, 5 Mar 2024 12:05:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/84] 5.15.151-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240304211542.332206551@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 14:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.151 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

