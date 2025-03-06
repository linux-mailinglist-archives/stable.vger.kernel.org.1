Return-Path: <stable+bounces-121269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD438A54FB0
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E17B162009
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A4C20FA86;
	Thu,  6 Mar 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z5Xnn6Bn"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FA38DE0
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276433; cv=none; b=TlBkMitnr51tKP2aMxX8Lkm0tRixwdpzWaEIB8samtlRsB9Jva+MYkhFfc7qoEiKuIKjQfJxp78x4fTKGLp/0XniyBldlSVVM89vU45Xor+TZifQlsAeszzUiVYhdWmuOjHKYwf+MQ/PYAlDqW/bWzZnZYyj6FU6HWeSkbhDKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276433; c=relaxed/simple;
	bh=9xApzznU9zToGpRvOyi0B+B9DLKySsAQzusSYJseRe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtUufPcAwOODKJRKUq0ofhQ1ElY3X4wCV+a2knrfYJiyI7cTx6Ws3RylqZ5PKTMRYq3HBL4tZq+uYTotzowNhetJ86E/SxT5Zv9Q7YO5YpUiMQHbjSulTUGqEQ6dE/mV6b/tesEtxpybvSG59jWkNmKanu7bgCcK+iCWTUix7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z5Xnn6Bn; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso61760839f.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 07:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741276429; x=1741881229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGVbwjHGlVQWxl/m59u6FqTt/mVrEMBYDWttRsZVfrg=;
        b=Z5Xnn6BnI85L8JouaY73Qe9pU/dTgAaaAvEgTGyJitZNvK0ciuyChxcpQYmb16TQFA
         SffLqlJ0DCbcCzHNnvFEOn1BI5R+1x52L/tKzo4jFFwVb8bSvh4fgpRyFZt2mcaHfrVp
         ztgVCXv6Icqawfc2nIVwjiQOTt1D/04B2smTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276429; x=1741881229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGVbwjHGlVQWxl/m59u6FqTt/mVrEMBYDWttRsZVfrg=;
        b=hYUhRP2daaudldPzoT01FV0rU/GVDLKnKwazQA/qpMY8UJiIgZINPYrmdHIJvFl95P
         rnmKNzSyxysixxOLHMbFHWSL6Os3/+a9quVTroK+QenDRsv8Ws7BkPpbhM7QDDKuOfaT
         wldyoD8NJnkxlCzZSMOMfwlcU6Vd6ja8oHKAJbkqY+m052QA8vkgdgsX2hEsxTyXXA+G
         n1mx4+zyPItPD3mq5fnoiwCvfVv5VG7V9KA7/pNFpVrwt+a1Hu4/eFgj8f5H+60HgZZY
         7Etle3uOyBbRp6YVzzsmqFbSXBTkJGoPxfdbOot4aZLnTSuBiAC0RGKFlyo7fGDLk/MI
         LA8A==
X-Forwarded-Encrypted: i=1; AJvYcCWfFKextf8KrO+QIlWbnqvWlpNnCb4U4nvU7JN8oVZs6trgpkNtVBFJtTUsq8pSW4eyPlSu9aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjNfbee0UPeIhGFoj6j9Jjs14Q3scZ2ZLl/iui5vwFIGAJQmK
	z0aouvMR9IaSP79SBXZwW1V5NOWW2+PigH3EaCYoTU7rtj0Sm2p1e0XroaXh1mo=
X-Gm-Gg: ASbGnct/WjfL1P1fNYSGaqqFVwd7KkNnRaaJTIRrncbdkFgJHJV2n4eZCcfN0M1ieAv
	Gs8hz/78iNTuZ3GeXlDgetcAcxmiVMWBhbfybUnxelYHBn8kBcBd+ZrTZ8VJCqLPcdd+vdXWd9N
	LcdjeNmJlCp2NKVSH0CMxz5/DeU+J3GzyA/+ZDraoX5pmmbcWcE4WLsm8AxHbRtLM1SZFMEWtr9
	zh6JcIHsmWu0CdtyQeaBg32SI/a9J3+npUH9fntoBuU26ZPb9n6vxpW/mTneYzufu5XB2broMY9
	TH4JQK1I8WGHrzGqIpI4+WqBZfCtpabDbsAoLokHiB7TQw33pkaUnEE=
X-Google-Smtp-Source: AGHT+IGNfRM6WfvPSmrxwPJSCIIkYyc3wCyGQxjF8B+uwVak9ijJZWpq0YOE6Njzt4Xig2A+t7QPUQ==
X-Received: by 2002:a05:6602:750d:b0:855:2bc8:69df with SMTP id ca18e2360f4ac-85affb86847mr1088552639f.14.1741276429490;
        Thu, 06 Mar 2025 07:53:49 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209e1569dsm400620173.30.2025.03.06.07.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 07:53:49 -0800 (PST)
Message-ID: <0c017b9f-0bc7-4826-89bc-70b9b9d38d4f@linuxfoundation.org>
Date: Thu, 6 Mar 2025 08:53:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/157] 6.13.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 10:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

