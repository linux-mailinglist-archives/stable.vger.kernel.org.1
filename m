Return-Path: <stable+bounces-61898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA2893D720
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC58F1C21FFC
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EC017BB1F;
	Fri, 26 Jul 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F4aeUO4u"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B863CB
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722012120; cv=none; b=fW2270xoBApa5hBCilaX2xM5IsRVk3wdT8jCVCkXiF7X0nql+Nirqu5llR3tm791/ohQnWS9ytUhpW9E/H6un6DzVqYebcnd3uYJA0eFs5+ygZeP9zbnO5LlK2f5IaC17T/6nHwgkoQOeDCTbCCTAVcr5vg4SoHIg2NHcURgRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722012120; c=relaxed/simple;
	bh=dSJkqABeuzbK/5xhttwGDS9K+8whwGr7ZPANeTmVWec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGydKv0JW2mrJ0ycPiQf7cnrYGqt+J6JMXhpqLGEXxW4vQjbpRsgpwl83BvNSrBJVMnVnh2Nfm2WxgDH3sSzpAxhb8hFekA2dnfH7KmGwI4luZfuZFCC5tWNB21XoZMWPixI1jdletss8QCgpt5PQ4BY3dOVURTQGsum+LJxzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F4aeUO4u; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81f7faff04dso10318239f.1
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722012117; x=1722616917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwYlsIb0TBL8ApmZ4UOjkmkHKXDKkw/fhwLj7jK215M=;
        b=F4aeUO4uZ3H6dsATNcJm/oIk10sbPyJcI5Kr9QZ/opYQYmVRjrV60ajWC/htCBxTai
         QQmZKUB5+9WE6sGlGcA/w31P9X/r4qEzEAjULe4zSqBf8+SOYhDvhzwAyn3fFmgnbrAE
         lLmtXDYDmuy3VW8aonMpN/wJ+XabYiLvJ55O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722012117; x=1722616917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwYlsIb0TBL8ApmZ4UOjkmkHKXDKkw/fhwLj7jK215M=;
        b=K+xQJutdvBO8g+Ow2Gk/WgrZKkvu2tC0mXyQoisceywnSDEql6CSJ5kHDLPIiXFWfI
         Hmwb/O8r+YETPaX4rFXnIxl6JZQPgWm9+x/Pq1twn7dwzzlP1uaXF1q3UwUwiULYVYPY
         ElBcIRPCsvbZGX7+pCI3QqYIo//KShRSVHYQbzf+o1UywKRI8LRDKYWpoTStQ/sdev23
         /6ChDdfqTC5qzxqGdH50SHxwagzEy1tjjlSWSsC4GDKVjC6wVHOTfHDjMcoPW4br32eU
         CbaWrhNFYqfzu8HG4PkNbOWKnDRXqHIQp5icyh6VzSHFNzePtsS+Gr84T+WVWY0Ycx4O
         IoSA==
X-Forwarded-Encrypted: i=1; AJvYcCUhcsHKud9axMtdX+Sj6VCCC3uJIgd03Bef0ElyVY2FDhQQhQFFE7KJsud9nlCxd6lI65rJArAuA7J5sCXj1lTZdVw2Xj5X
X-Gm-Message-State: AOJu0Yx95jnRLjCUgGKICfrYh3GX80cgzZQUTew/iEAt9dhA8For1Umy
	E2UQYtp0xcZJ11bOJL2Z5aYVf/NJoRj2BEHtxFkOFYP5BbXYnPrEieYGOnaxTjw=
X-Google-Smtp-Source: AGHT+IH2RQ7+hRvoU0ab3eLlqs915W7aXZ6Z3kSZzsOoboQc2T5VslhirJMEX8/vy6pHmiY/Qs2rtw==
X-Received: by 2002:a05:6e02:1feb:b0:38e:cdf9:8878 with SMTP id e9e14a558f8ab-39a22d0f3e4mr43022985ab.5.1722012117634;
        Fri, 26 Jul 2024 09:41:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a23107376sm15321465ab.87.2024.07.26.09.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:41:57 -0700 (PDT)
Message-ID: <e30b5166-a6f9-4670-9875-286cb2229c60@linuxfoundation.org>
Date: Fri, 26 Jul 2024 10:41:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/33] 4.19.319-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725142728.511303502@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725142728.511303502@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.319 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.319-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

