Return-Path: <stable+bounces-180572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF39B8662D
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 20:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF31C7BDD76
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AC627B352;
	Thu, 18 Sep 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPRAHUms"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360CF2C2358
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218874; cv=none; b=Tw3Lk9xwdy4UttLYWmVnpw754rAzs9HPAP2oDm3P38+dxpsJaXi2sAERKj9ZGm8XYc1SekcvxBtpnKK3HI+z9UPXa64LMK1impkPvogNe0duQaA55CTKBLWtVMzLM58rcS2VslKcZT9OsGjwdOL7JC0WlXzID62AzzAEEerUQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218874; c=relaxed/simple;
	bh=Ihox7KjQM6+mVvo9UNxDhOw4q7HzSGfp98T4jh9xaNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkEAhAPmqz9VBl1riISER8diYLjzuhpcyEZ6hSKS4IlIJJCsSVABAUJ+kGpwEyoTJ/pL6OB5tX+GD2YPp087y1IIn+GuqnVAyfq2evVODwFEw4+8bYRSQjiXalLSrERithek5BwFRry8d1zyBNeimSvJt78EM0O6qV6kC91eR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPRAHUms; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5229007f31so968119a12.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218872; x=1758823672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDyW9VZMla/yzNH/VDc7UN9+phUtlhbd8pbrMSV+Eec=;
        b=VPRAHUmsnlXw+pPD5TYXKseWRncD4Il1wLQ/f5eShPmfbPqI3oFxfkOtPZQfNrNO/b
         KaE+VTMlhitC9wqB5ezT5PKDGsb6kptvURBGkAYqrYlDU3pwNqtMS/JwmxqmK64O79CH
         2m4CEoWBv6eqsrjK2z/4ljOHfNHE3oqCWsX8tp+APHcBI/M1yvDmqcEWueSDYM/G3Sbo
         VFyvEoX7RKLzCa0Ia07tu4668jEccVxA26zViFeEfjY9PKQDuimhmvvLePEpweN/q5Z2
         6f3rJbTljdJK0Yg4v8R2AD3mEvR6LWOtvBqHcFKV6MNg3zFM2zJ03LS4D2PgYZRZYOpc
         c9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218872; x=1758823672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDyW9VZMla/yzNH/VDc7UN9+phUtlhbd8pbrMSV+Eec=;
        b=MjAzU6AAME/IKhyybaFLE1KHx9FcX9MrBayrPVWBmM7j61Q9zC9EMy+Qa4RxBEW0Uj
         jkxY4PicTjp1Ze7NDYZYx5/6H+Yun1qPvXm8LgOoji1wa56aE1F9+2jO3Mm1I4Zckztp
         Bzdmg5xxwXC1LNd1n231sKx50DEt/pv17xGLlLSmuN9DJd77pjerh/7FuTTjpN3kwRsk
         jDqrIgYs/delIG11vmPE9/a1gdMJM5cdvooBNp/hsEMdt4AMsghJpXLepI0i7i6FhSfT
         YNKiOMHIHU5nbVTBps+Id/3UXv0r2TDsiTucqOQoK0nL4GDwuRWd1kPIVIy4QhXBA8PT
         CepQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ah3ASvXB35uDJcKJUeOeJ/JjyPD1hhKWhIIptbXICF01OGghOq0XyWRUE2M4FvriCFFeBqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZiTYd7yRvmv4rkuMYCMxicdPYoNUqKpnBHWV8LS8T3BrKm/y
	cRGoZ6vsf/mLEzMfEXI8DKxu9xGl6jSJVEjxmKL8laBIoqyyC3CefR8Y
X-Gm-Gg: ASbGncuUmluwzm+5WIY4rzLsglbyURatZLX7kre8y0yqH0gbOy1XfAXwlCitHcVkbAY
	syREnfnmDoK6BvlYQEUxGhuSt2XkNPNCuKQfjhMo85LV9SumT98n/0Hv779LrGVsaF4Mvpw5g0n
	PdutgQaTsx+sdcS6xVOPTF6e0/dTFxA1c5F0OZxxQYRs6FjJnS2hjPg28zHl7KwtJ2Vz1AE9R9T
	9mq0UMwYeMMwaaWzxTCYqulatVv5RTMJV4NmtR1vvG4fQhOa5QxL+SMh3jnIqojx/ee2WQT2OMi
	fF8XgAETFvFhJUohNQS6Q9myrO7WXoL+mSeB0njMJ6EbINHX2GjEZ0ZqKKm4qe6iGxaOlc1XJQ5
	xjV1tWgjIK/Yxy7nqiE1A5rqRzuz5czj0M6+7f7XBTWwCdUOuqnaVpihvBq3eSip3fDUGAH28Nw
	F46NPHDFM=
X-Google-Smtp-Source: AGHT+IHnYW9s9Ywm+C6BymDJxSBWvQwRe1XoOyZiFCn75JFtSI+lA2DVnxrrNWW5YZylSz+6+G1gEw==
X-Received: by 2002:a17:903:384f:b0:267:e980:da59 with SMTP id d9443c01a7336-269ba441db0mr6879635ad.20.1758218872257;
        Thu, 18 Sep 2025 11:07:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5510fd4872sm1270927a12.32.2025.09.18.11.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:07:51 -0700 (PDT)
Message-ID: <10179c40-595f-4dd1-abc1-d6ccdd0ad7fc@gmail.com>
Date: Thu, 18 Sep 2025 11:07:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250917123344.315037637@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/2025 5:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.48 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.48-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMST using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


