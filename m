Return-Path: <stable+bounces-57991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C56926C3F
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 01:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F25DB21D3E
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 23:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144431946DD;
	Wed,  3 Jul 2024 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ab/w6AWR"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE019005B
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047889; cv=none; b=ea7zcp6Hd4qkjVzLlbSuw3ujjN5kxU9cBSMEChP8oTIzzGMFcnzDlOI8yv+x37mPlyhUrgFMgbUuujjDR6Lag7ToV/7Dt43sm1BaNjehQjXKmbbP4rP7Uk21ifUtlxFR+MPsMatLSCBJZhNQhu97GMVP6ofzH0mSlPT8erbEhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047889; c=relaxed/simple;
	bh=XAbTDSCiuix+leu4nt20ZGL6CGC5tq+OVyQUmfdwLc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u93IP/rlMQQZtNNCFFdcf/M/r0FnCuc+xCNcI78kcoc3gjkxgwMUd0lV4hkvGSIKEKNsCK8ISN5qCXXNBFdg3jgYAOKzXYbQF6jyc2hi5KcKcBvPpWX1rDsVfdKGiClvrt/ul4LBXYndmksTWQ0al1ze9KsonqDhEkOlZRMp6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ab/w6AWR; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-380cdc44559so40865ab.0
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720047887; x=1720652687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1Gw0ZjNIkvjLQEAJl32qrbP+mBtuKKDlcaDQhvoYrY=;
        b=ab/w6AWRETOw5I0eBH0tEUfrBOvsTjXko/GRjDB6kIDA5RlnSRbt3TX10+UAaMPZ3o
         OdA9hdw5ZkkDjnVO2wDYnkveUIjfnS7ERl3W6dH8UsUSOzOqULjC5/YQVLJt7A2mNKhD
         xWbKeWs4TGRSJI4jPtA43JbHtvhT+PZLayQC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047887; x=1720652687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1Gw0ZjNIkvjLQEAJl32qrbP+mBtuKKDlcaDQhvoYrY=;
        b=odEFGsYQK1PxV7PJDcGpdWsvdLHzNZL9zH96k9E6vR5rmH7aieWc6X98WG0SwtXz3K
         zfswteIdWC8z5pXS7/oO+oO9czMbeV1wK+XgOchBjoSXxuvLh2sqz4rzPmz2Yee2DCsa
         q3XA9j3RmqjHbAPrl4xiK4OY+bzBaBAdhANfSOYTTRCedc3p627cBmwda3Fbe/12B5jY
         7bLY/ex5wIekbaxI8Z4ih3eP9JqmgiSEneRTs1E4AX+gvVXR8G+IJqDUVvx0Edwcn+/D
         w/pgfCTTxdHoeH77OCiFqfE+BOvohuO0DXu93ZZGIJLFKrpfIGOjHrBVGllPyh+Zu7A6
         sU2g==
X-Forwarded-Encrypted: i=1; AJvYcCWewvdTxR3NNCER41V6ZNSC/JhMM6zRPdPbl4C4fCfUeOClZ7LY8zmDh1MfXVVGkylvoF/RDvgLHCvl5x92yNeZuhSKCkKn
X-Gm-Message-State: AOJu0YwUW54YHzbR3Y2J9UWSYM+0HSu6XnXcZ4cD6ZaaZMbrch1L1q2F
	uEGqGTFqmACGMZwbEPibycipPKCZdOKsuQDnNIEvKCABVJbYWTvp/wWs5aYajsQ=
X-Google-Smtp-Source: AGHT+IFDVsmppcbGL+gnyzISDited4s3wOkjFHvBfz84LQnxxLISKA0y1gljgdxrjb0h8+8a01JC5Q==
X-Received: by 2002:a92:c144:0:b0:383:17f9:6223 with SMTP id e9e14a558f8ab-3839a0339b7mr882935ab.2.1720047887367;
        Wed, 03 Jul 2024 16:04:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3838f132c29sm342175ab.5.2024.07.03.16.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 16:04:46 -0700 (PDT)
Message-ID: <c8721a72-17c5-4619-9128-9260214ad0d5@linuxfoundation.org>
Date: Wed, 3 Jul 2024 17:04:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/189] 5.4.279-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 04:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.279 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jul 2024 10:28:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.279-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

