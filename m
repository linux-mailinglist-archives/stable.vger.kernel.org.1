Return-Path: <stable+bounces-65968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77D494B241
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 23:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C925D1C21086
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 21:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C0B1487C5;
	Wed,  7 Aug 2024 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQzAGibC"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB084D25
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066802; cv=none; b=tzlj1kw/biO4SFqhkKU4W3Sl2CHO/oEd9Ar05AJVYS4uBw1hk1aByiEVJZXwh1XFZwTFszrpMDN9D+Vte5dLNY0yF0p0EVGsKzrHZBx7C2TT0LTyz08lSvgBH6j9yD3xrdfo2QM7QTl2UN0AWqFCWumCnmgGcizBWkV/1lYMCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066802; c=relaxed/simple;
	bh=GDAclEoOcEOWqSuGrmy+DM2Tp6zu1/nfi5udLfWAGYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byaURkgS7XxJOKEZndG2rnFUEKgt9JtScsTiDsHNMV+M+b1pjuiF6NUlHxu5yMU2PukLm+x/zEx5bNUjchvERnBKc2ZUhDUU9Hg/AM/iGd8vorM8BOUKmgA7BsxGSMJq1b4DaxRhI2JMsu3qyksAwo3Qy2QBbCUXzla++tac1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQzAGibC; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81f8bc5af74so433239f.3
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723066800; x=1723671600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+yt4eOqI9n8STlMoFI1L5lm8J44U6xP2uia/Ec695s=;
        b=cQzAGibCu3mCX2QUVDGg5srFbuFi9WrN0edq978u2qi1zZze9RWgkhMNd95HjmEyCb
         G+9UtkRzP8NyeAMx1FboOxGKlX8kQIcBEuY3hsFkE0OiLMvg64BTyeVZdwbppKojO2/j
         BC41Cw0dbZbO91hgYF2saQmqBBIBfgzmKX7uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066800; x=1723671600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+yt4eOqI9n8STlMoFI1L5lm8J44U6xP2uia/Ec695s=;
        b=l70wbQaITkJ8MWcmqMZGdxpJfVEyzb+0zHjpbL9e/9c0+anSzuNjChWAs8iIWmgz1P
         C3FNaX2f4cbV1z2pjF2ViA4e3KzZGVm3ZvO20xY7ySgZcl3dUMDAgGQyLhQJ5AEuFq11
         aaSanR1k2WTv6HDAnkXxFHHxLRrSYmZmMmmKWVlQcs5ZjLsHN3eKsK6gYS65NnGt0Rkl
         hGIsGy8z2wfCMaiyJDxqWgRdSIYRDGwEoUUh/m4JxCfuKSQTjXm9W4G6hcgqrbq9aPQd
         j/rwvraW+d1UuIpmkjvJQpQ6j/FumBwhEYsmcJE/s+uSiJn6C3UCxGYAhd1qr5/3gFf8
         Y17w==
X-Forwarded-Encrypted: i=1; AJvYcCWeyqJDYtTGCAY4TFlkaRk13czkyVJ+n/aKWh4lge4PQraF2vQR0BgeBsx8PzQ6zqupNjMhHLAYG+c39FF3mIFMdn6hQ523
X-Gm-Message-State: AOJu0YyOq7HVifL1gEnsOB2VcJ4PLxs4goSu5uUGKkALmKIGrKOetABq
	VS7j0Al/hq9jXJ0Lg+xWPZNWG8gtutQRRyui4p2ABTvlPxSyqcI/IGNE5WGf9Y8=
X-Google-Smtp-Source: AGHT+IFVLcmbz9Srv9EE1tgNm9JYUFhDPEqrp8BTfDtkNgf7sBQXucPNQavpPInt+I5wDtcoPYzQqw==
X-Received: by 2002:a5d:8559:0:b0:81f:8cd4:2015 with SMTP id ca18e2360f4ac-82253826ac3mr5374039f.2.1723066799915;
        Wed, 07 Aug 2024 14:39:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d69a6ea8sm2984779173.54.2024.08.07.14.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:39:59 -0700 (PDT)
Message-ID: <6ebacbf5-2f86-4861-bd15-478e156c9948@linuxfoundation.org>
Date: Wed, 7 Aug 2024 15:39:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240807150039.247123516@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807150039.247123516@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 08:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.104 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 15:00:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.104-rc1.gz
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

