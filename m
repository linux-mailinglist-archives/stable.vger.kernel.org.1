Return-Path: <stable+bounces-75849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50A975679
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66780B24A24
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD321AAE37;
	Wed, 11 Sep 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L5SeEiNn"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F919F102
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067307; cv=none; b=K/AxM3UF+OYqOihwCYS6I7oFbZwlPpY3qJ8b4M9ZeU2BWi1zoTL9k2s52dwOGiPtA7HBk8j3zZ1KS/YuxxZVXZlKfZN2eI5gAbVvMEaSsK4pk8s2Jfql7ISKugKkju0eCIyJNCmNfbuWRl0rMBXkFR4w2V1S6AvsqLmeweInM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067307; c=relaxed/simple;
	bh=xBgg5os0gk8trZVZg0H4rW2Gjl3RmKVNVYj5YhM0ylM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGQ5pxxtF/Edl1D8CQlFSbR6CfAU2eHJl2R/DjdIm+b69LHOZe/1hNMUHbJmhvgiR9DIhRj9eAh7Ip2MdWZU9BE9bpIuJ0JbWgr6BEMChAm7Bl4MGiqEgpm//gDNFa/x/ueHGxBWIF6jLmwGOxIpvrYawH3vSmIOjeUtEgUVFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L5SeEiNn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39f52e60a19so34404975ab.3
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726067304; x=1726672104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noal/gvZ7siOQnpRjSqJbDjWmvI+uJ1GjIEsFnwoiAs=;
        b=L5SeEiNnm2WQX8CPVJYyOTeJHmZayvIS+LD86qWXmpBbjgynymWqhUabduGMc/6DdY
         fryKqOeniwhaP3xIdrKm9w2TMDCgd8y4HTAYoOL0lJfPAYbntWx4x8qbGmtYOtqf+xEb
         BqaxIUiTpmSNRN4VMKSqK/3RGfQ8L6kmQlysc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067304; x=1726672104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noal/gvZ7siOQnpRjSqJbDjWmvI+uJ1GjIEsFnwoiAs=;
        b=K6EfCSq1EOoojSE4D/vVPVdd26B/U0qc069wZvjr2ZieV4EIMMX09Fb9J5uaomKpia
         RYXtWtkTqp7VJmLpxUQQqIE9dvuDhxwWIVzmCEMMeVWQtleLoG6poFz6aSbeNx8S3F3i
         fuGojYzKiEKhv5qA8/MjNY8pDDjwUat3rCIaNtkUoptz0nTm8ZUM/4m/ozg3K06rvmTt
         8AQjYSF1D+64bUMCERX/Hg36qgmPccyV6j2NlDIWreEMsR00AyY9OSTSDtfo90vHi2A6
         /LENU9srDXchMIMadR/n5O4WAsT96Yb+G8Twv140yTCGuTdTjCsWV/bmOAlXoD+RkgLG
         y6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmdO5erpR3HAAfdc9whvEdoCsOJJFqxsBLnhnOqNjCPWrOuhigx9WXuBPN+A6kTUYd95KK/s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+NwCrPj9goWm9V3+Zqu+MrqIGpLOqfW6R4Hftt6s0ThEpcKa
	sf51/9DU7j3QDAu1xyuKmQVPRQN4/46WuQ7NAL67sORYBK7QzIyySdKcLTXsZ7M=
X-Google-Smtp-Source: AGHT+IFEhnsGpi2hXP15HfwLXqcPm+UCgf3IMU4rdFoNpO8JwtAvbVGOANJoC8YL6NLJ+WDu4n47Yg==
X-Received: by 2002:a05:6e02:16c9:b0:39d:24de:daa0 with SMTP id e9e14a558f8ab-3a052399154mr166079565ab.20.1726067303868;
        Wed, 11 Sep 2024 08:08:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fc835asm26384145ab.9.2024.09.11.08.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 08:08:23 -0700 (PDT)
Message-ID: <6a9ec038-c00a-4a1d-85e8-adb1d257dc92@linuxfoundation.org>
Date: Wed, 11 Sep 2024 09:08:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/121] 5.4.284-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092545.737864202@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.284 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.284-rc1.gz
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

