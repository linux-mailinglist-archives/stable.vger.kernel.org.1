Return-Path: <stable+bounces-176436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5051B37394
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 22:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF391886D53
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 20:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886F82BE04D;
	Tue, 26 Aug 2025 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdB6U0FR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4A27781E;
	Tue, 26 Aug 2025 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238688; cv=none; b=sCP46ee+39x2BXvRYfnw77R7oUFldV4WdehTWNWcaool8I1rmjhBYc3bm0luPnkvvAYyYUsIniW6G+kNPJMpSyjg7tTvsZwBgjXTRuJptjmFiqrrNYdHS/suo7xdfRMXFn4W2bIrNvmm1qv4Mjwm16AR9p1uVC5o1kQQlFjf3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238688; c=relaxed/simple;
	bh=Iz5j6+gS5cmTf3s570FP7jbA7T9DKSSLrEDiWLZhe2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwsGWVR09I2o5wqwI9xGpOi/yT689s5+iuaUuwifY7fw7u05jUWqO8OIoz+ORY95tL23pswv3eKLBhcQ8qCxh7lNvrf8KGWTxEzLSLYww8fE/SNer+tuB8SaEuJlFoQDW3yjkQeWGcmG8sc8RKfwEqu3E8wbUUf20v+x8FPGzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdB6U0FR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70a88de7d4fso52975796d6.0;
        Tue, 26 Aug 2025 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756238686; x=1756843486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/GyZ4F2+FZFGH/ZXJuJwmND0K+jQGTwQ/gHFGulFAPo=;
        b=WdB6U0FRHI8Fz4PrpIGQ9lIssNo+Bc0HjrhmdOraQSnVXgO1yBhuotAItbROpYIR+o
         7sW1UvUiQed+z726B8KI0/acM5dBqzv0HFsoblFuSa/ZF9rwKB6n0zE13Tqd6dVgGUxw
         PojYtjK010bY31/yfPJnHMbvFFGlC2NYSRSJe8iOYoMW9Fj65vqD/n5h1SKH749JBT83
         XpVanyV2fBDq2qj6urO0mIyXWyKxroe7dL4UQPe+YH0ZNutS8F7TJ7owR3rMkPlyHtSE
         mj5e+Tnsf85gwAlE2sUqqefiM2JBlENMNT8mJ4Kkxg6+6C/yw1Nfzp8waOfdbtrxBjer
         wRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756238686; x=1756843486;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GyZ4F2+FZFGH/ZXJuJwmND0K+jQGTwQ/gHFGulFAPo=;
        b=LBcwQKu86BcbqnJbb5VF2hsqER0S6LI6f1NjnR2y47Vnl1MqF49PQ7uP5mhkAuB+yt
         OLzSZGSyQo2wY+EwVeoaCGNpwecyYHnb3ybXsJ5i6eWyHfeicPEqszby8am3HZOhXT8T
         og4M7i6On/ar/0+OEl5krTHDLUuixJ1DLCJ1P/0hQAGnyG1Zr+3f4eglql5bnBWKV5o/
         JxHoaThAizbGCnUOCuqwyddfedbk0OgvBr0ZsEHz7UUiQczpdrD9R4Jvx+Pu3lAeF76K
         Ol4MM56UkVAZUwlDMEipo+EoqQpxqzCiJo/TLVa0F+GmoeVISPB5/y8GrzA2/yrpKK6c
         G+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVa8PMaIK9/2WRCDl7ix33XNZG3Ucwr4/SA5L0d1OwrYAgYRagpoKNTTKANTZgHmU66Ag9nEx74@vger.kernel.org, AJvYcCX5KsZ2vUOL1UBhS2ylAidbVr4gVWNxCXAwIbtXd15ZVXnptZOUVSN0fA5ZULhjl98wXEUGL6XPERWsFGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFayYy9y2EEVc7mg85HZJJ+2FnLEtdy7jZIzlaQCgO0YvfbrxV
	paMG/P9Wqv5ayXNreuOjlmK2Lll/9MyzZTdi4uSWnNGN5FOQozZ0aahg
X-Gm-Gg: ASbGnctFA17EnhYjfE/uOQVUYpuXvpVqBpev7PXt31doer9E19TutaHjInAWqGddE7y
	VU/fNVd2e9KdjQjILUAOAI5GpdHeGfR7lX2aC1whv8DE3N8WdFmz3wxO0kM5K53Z+TIT7W9cn7f
	/xN6x+AQZPeRLl4iqESgXWC33ZkrRoxWzLgQjVzLjswJSue6IDzXN1tMYaETXXmBL/jg75GGKMj
	kBRBr6nGXe1VQqDtaK5J1rHBqODGEE4eYAAbcmvVSf+R52ENX20GU0CxIEcqEL5iI6qCeqldqUX
	iWddS7qrB1/8WoTx3TmbjU74gWibSQs0jp2GsbKirTnTQ276CPY9/iFqExofiJPXyc1nMch6zHT
	1wbABfV0UWrFX18RbCZD7iehSDwqH7f1lC1SMW0d21iIoOevOfA==
X-Google-Smtp-Source: AGHT+IFuANQ1KkRmzYan5H66Moy0S6ewy+fARrkWJ5qhd9nMmxWZFd4/LTR7UH86P9TJi8DXbPaiDA==
X-Received: by 2002:a05:6214:2404:b0:70d:6de2:1b31 with SMTP id 6a1803df08f44-70d9723e317mr194725796d6.61.1756238685551;
        Tue, 26 Aug 2025 13:04:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70dc5649acesm34881416d6.74.2025.08.26.13.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 13:04:44 -0700 (PDT)
Message-ID: <ff481fb6-3639-4297-b226-a37632e80927@gmail.com>
Date: Tue, 26 Aug 2025 13:04:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250826110937.289866482@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 04:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

