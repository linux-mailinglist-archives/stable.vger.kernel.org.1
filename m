Return-Path: <stable+bounces-32215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5E88B08D
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 20:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F91DB2103C
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 18:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D051420D2;
	Mon, 25 Mar 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMI33Tgx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985513B582
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389199; cv=none; b=YzRByosVMe+sF/Tb6JCiM8IgaBvnnsj4NhQKOu2CIi4QRlM/I/RySGEoWj/Vh41QFjNPvY4ExVOWhswLn2g/3WFh0fdCTeHF0nato30Fa2fGMBHRVT3+R/8QFh0w/4d46Cot82anXYCM+P+wI6NlHIVvluDSCXX3Z0o/He19d7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389199; c=relaxed/simple;
	bh=zTq/MHKLajiF60aduRxCL1na30IDBaIdseS4oSksHMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vh+uG702wsXah6Zry3yktSvkVVflABYOEvGXDauriPo3/ZFvw1on2tSK05e6Yie10pDC9cA7Xfaru9FbjiVMg0LchRfjF/OzicMPPTvWfeoABI0va6Q/NrvAVaELLit46kbyhdDqDYGSuuhTP5BPJva83d6zEQuba9i86SkEPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EMI33Tgx; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e6d063e88bso942007a34.3
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711389196; x=1711993996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtfY/exxAJ2/pA3+4ErQekLFGx+9Ne0CFNn8mAKnrOc=;
        b=EMI33TgxnJXZ8e/OsGJpTOjGNXXYfi7tG2u5jc+swsPl+SicJMd0u7EKXhL7UEJIkl
         sjF8+Y7kkA66mz0LIe/JQ+Mn8lAo8NBnfXvP5IK48j9G312LvpbWdAzW0rb2PF7uCtaV
         AxcIaKfg6Ng+7X6R0TGKKuJzIYX/2RKq84NVDeYatkz54BmuJYvvr7IwqYXA8Q1RKRdy
         IJOOF5UkXORWUl7zjMIQGSd2R2ShW5B3HrhHV+jQlCOIWpAedg4ezWEVM/bgX5IAHxlL
         0SQYu0ZDemZ+OIP4SIdFk8ZzL7b5fpHgYvt1vX+FEmHBYkGqkI0ZLSUwOXkU4vTKsKQX
         sf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389196; x=1711993996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtfY/exxAJ2/pA3+4ErQekLFGx+9Ne0CFNn8mAKnrOc=;
        b=liM/J+UgfqXFVd4o3bccPpvClqa6KQs3EqcoJtGz2KdFpzArZNl0+UcKPV5URVHHRP
         anaQ0XK/1rugCLxmghvndBjwonYWBvS3SvB4W0YUCvMrAVO29D/SCXLKqWkloJcH/oLe
         iL2w4Y3i0zYcUeQEWgf/sMzgrKF+FY8aEwGQO0NlboOh3XoEl60PEcVWp7RZyA8QuKSu
         vDneluWLFaDNsnU+zlBQrxqFXZFfRlZX+M8R8JCqqn/UBnovyEht0Pw2WsbewlhZ1TqT
         a04wiRvZEsNe/o5O+UUEmNiDmu6JDRQxaj3e2Lno6+bWnGl8x6W+qUrIxwUz/J6ijZ2N
         s94g==
X-Forwarded-Encrypted: i=1; AJvYcCW+CZWYj8ppTab8hdM/XgGRYXpVCMJwbvArLyDHO5XzXSdmQp1lx20D2flflPmvOYfsdOiQoYeRznQtr1dB+0u+YlFngEXr
X-Gm-Message-State: AOJu0YwNCaXeNsWHbyeKT/uRlLDwqMCDXBQYfNrh0giiWF3B8pxZKywe
	rlFZjFZrqcfHSAqaD2yq6TaiVhYCFzbczvikfIibGWiQVJ+e+RPV1r+8j+knx0w=
X-Google-Smtp-Source: AGHT+IEciRg0AcFQztGBCMI82mO0JDbPeHvr0yogNBgxkbwaEOvCIlWeBV3OMIljB7KfX22byhSb4Q==
X-Received: by 2002:a9d:66d3:0:b0:6e5:f65:8775 with SMTP id t19-20020a9d66d3000000b006e50f658775mr364313otm.24.1711389196635;
        Mon, 25 Mar 2024 10:53:16 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id x9-20020a056830408900b006e6ae032f5bsm1213190ott.7.2024.03.25.10.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 10:53:16 -0700 (PDT)
Message-ID: <1f06b9bc-37b4-4359-8b97-0ed08b196870@linaro.org>
Date: Mon, 25 Mar 2024 11:53:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de
References: <20240325115928.1765766-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240325115928.1765766-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/03/24 5:59 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

We see build failures with Arm (64- and 32-bits) with allmodconfig with GCC 8, GCC 12, and Clang 17:

-----8<-----
   /builds/linux/drivers/cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
   /builds/linux/drivers/cpufreq/brcmstb-avs-cpufreq.c:486:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     486 |         struct private_data *priv = policy->driver_data;
         |         ^~~~~~
   cc1: all warnings being treated as errors
   make[3]: *** [/builds/linux/scripts/Makefile.build:289: drivers/cpufreq/brcmstb-avs-cpufreq.o] Error 1
----->8-----

Reproducer:

   tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12 --kconfig allmodconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


