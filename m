Return-Path: <stable+bounces-75891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C5975958
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1FC1F27389
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6ED1B5312;
	Wed, 11 Sep 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YT2+92VT"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F261B3734
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075588; cv=none; b=tDH4MV7SyE3C0Z3ajMRwJj0i0MqJbyDzV3ijG0Sk2x2lzJzCPPTmqgm3F8fz70Ia/yo4q4iIJ2/O+bdNcysFTEfBf6eTi/xLz81gpYN+aUZso6/ahaxRpIApVNvkK8bbDHEYH1iwK0J9MiO2YJZF/5tI8OhVBRa8hxQPHLIWUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075588; c=relaxed/simple;
	bh=9//KDvyuxplwL9Zi1v0mRliwQlC7afyYXuWA9OrtvW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9tRzALKIUwi9BGx0o8L4u18IIUEI2sGU6rTZSPMO8NRVnLFWN6DrX+piT9aoXlfjEhscpYWCfuX4mO9n+hngfR1eXF7YN19Y6bmsv+ZMqmzGglo0HJytt/lphcmcEW+01+Nz1pAjZrnvHcVH03Hg3eCl/3DHACqXSjHZ+yw/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YT2+92VT; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82aa3f65864so1584139f.2
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726075586; x=1726680386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2estjfu4vr9z4sdfFnffmLrkqEpyju416gUzpXqiGYE=;
        b=YT2+92VTcCCf75PSnOaeR4AZrfFAD+a+m5xiJ2utY3SD7J1HY1Z2HlnGX2hULSSpAH
         f3c4LQ4r7d97eK8fE323VgcoNU5gdoN6G8NgQeMfEbTtV/qIyF6AVm2SiLWKB0QFC47U
         5ljEA8kRzecAov6AnmLjH/E9ZsDUH1fmDGKLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075586; x=1726680386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2estjfu4vr9z4sdfFnffmLrkqEpyju416gUzpXqiGYE=;
        b=rf7uvPpQDFvtXkJP9dkrahWIht68tIyqHtfi9WYcZt/QUb+D2g2akw3/lpifJWAuUJ
         nv5ZagIf8zVcYLXLkC8KJxy6LLgePQPtXgwZzPKKb3kFWi+nonR7kcfv6aD8eA8Zjle+
         HGhrnPu8VoigLapyC7kWB6lTDS9fGhh8fvOtQB6lfQOvwTBQN2FSlUicLiv6SEwn7qwP
         gJ2MShKNqEgC1TNlAc1lvdEatWqkYyJecJs4le6cwaF9Sqs+Ri/DLKHZ0alVH3ObfJNW
         R37VE1bgCzt+RU9n+mEUdjZuZ9ScpxKglREYFEUEWjN58ojthJhuLzS+o0CBo2DXtqxh
         W6JA==
X-Forwarded-Encrypted: i=1; AJvYcCXKBF8GakSp8ygZ4+Z5DBajomTS0CCM+dN4CQr+WQy8W6JN6FM9yvSixsdAHBP3ZASuOJSfJuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDOAyCaBDlx+vMhxyCe7ju1oBhL8NrWgZ1FlP5v/mpuSX2zcd
	rR3S82HKFf//isHj0B6AEzsyNhUJxQR8bIq5JoZpefCOt5x0DTAvDRn6etdJPAk=
X-Google-Smtp-Source: AGHT+IHht8VaGNScxJ6V1eZ0F9zhycM4mZpeGgCpP59HyZkJsYU+EMu7GQCOHk5/26BckyfsFLyfYw==
X-Received: by 2002:a05:6602:6d8b:b0:82a:a4e7:5544 with SMTP id ca18e2360f4ac-82d1f8e18c6mr33726239f.9.1726075586482;
        Wed, 11 Sep 2024 10:26:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f56a21csm96914173.37.2024.09.11.10.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 10:26:26 -0700 (PDT)
Message-ID: <4de97bb9-0791-42ea-8cb2-7fb5a24be832@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:26:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/185] 5.10.226-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240911130529.320360981@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240911130529.320360981@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 07:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.226 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Sep 2024 13:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.226-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

All good without the iio/adc/ad7606 commit

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



