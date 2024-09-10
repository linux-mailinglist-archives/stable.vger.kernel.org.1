Return-Path: <stable+bounces-75774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E5D97466D
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 01:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071C9288A02
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13141AC44E;
	Tue, 10 Sep 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rxbkxxnr"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D291779AE
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011029; cv=none; b=bHBqA33Xp0l8c0rL7ZQ4jw6vunzwtN45eVavXVpbIWxXw6NVix4KS0SdN0O/wbMyG43noL+DJN9jdNHN6ffSriCFxtbUNfdvtVgXn4JTgu74M7BdYaMAFL6ed46/AVZRCJGQRnHgj1jEceXQUIOZxt+m+88UqGBoDR3rgIzMGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011029; c=relaxed/simple;
	bh=4TVxpoRFLyRhTv/wGa6Zm40S7JkSsaAPbOW9P3O2zqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvLc/WCFL/6ZR8j6/wtf76oV5/hyhhYtRctlw8F1spi+fnQUaozZKYmgPtmk3qFiQB9ErljbYx1eMXi3JVZERpe6LvzR3UN2p1vmXl2nXuUHEZC5SJ26xEbAltGZOhqUsOX9B8wsnvGqxLIaNRsu0copTaUPQDy+5S2BNG7A128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rxbkxxnr; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39f52e60a19so31241035ab.3
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726011027; x=1726615827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iffj2BsuxCNv0UMNZmAM2WMYEZZUMVSrxQLbOKgNCQI=;
        b=RxbkxxnrS5PFtfriK5BHJYyoh7N4D99ammPHFGWY+I6uDj42yk1qL1A5dljoHfK96m
         YiYchXA54cRpThM9NKN//g4Yz4HqiwdqpysGqjGcTFx+GGlFjiItoJNsBRDApiQ9AstB
         VstTzpzipe0fnD9soyjmDGUsJzYjXaojIKmf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011027; x=1726615827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iffj2BsuxCNv0UMNZmAM2WMYEZZUMVSrxQLbOKgNCQI=;
        b=ozX3QUNxI5s0e1Q+sYLUJCyM1nSYPuBtmdjm+LMCifsjwkmNchil4e2p+2Nb38KcOZ
         owHLy0XrHYCTAOc8aLevkBcvIEGGCi0OG+DLCb54lfUd6dhT1Tqar6hXTH6gCkJvO4Oa
         GDAD7oa3ENx5NBgYiBEUBsmYUhlp7HpLg9OjFbLpqGjoSNGmDBg62ZAGtpWZ2Vs2TFRY
         HcuQqhW25e2NA5hBXiEy7HhmJrailawoUsVF724nu1tM5a6NLcu+JnTw+EgCxW94ChEY
         OHNN+WP4/AsyMyGAgfj7jN6VeG66FbbjVwfLTTdNGRdKFW1zKMZdPPdZhXNG56U0FXUq
         wChQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLwJVDBW54AylLt8NOqSQ5JnGUtdyGXZGXUQz5hVSSMfHiWx0pgMunbvokek8VPI+H01rvQ9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6P0Qspus2KLtOySX55bUo5GLVzujXkKRpvb+oE/8c3oX+Kay0
	VfCbm6bSJw6oal52bjEskdMmwf2b6Mdkxk1+ZPs+KA+ApsyslnsskL3aoJ33FtN3vfCr+NrBOSN
	C
X-Google-Smtp-Source: AGHT+IGbJ2XZTYauikJ4CJjr15uK3rTfbH5hnk3HNUgenOsWQ7PsaMxBzNJScp82iwzt4tQzDHQOWg==
X-Received: by 2002:a05:6e02:1a45:b0:39d:2507:6abd with SMTP id e9e14a558f8ab-3a052254035mr152504595ab.13.1726011027160;
        Tue, 10 Sep 2024 16:30:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09451dc5dsm1852226173.14.2024.09.10.16.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 16:30:26 -0700 (PDT)
Message-ID: <3a7c5032-732c-4f59-ad2c-64042daf1555@linuxfoundation.org>
Date: Tue, 10 Sep 2024 17:30:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/192] 6.1.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.110 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.110-rc1.gz
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

