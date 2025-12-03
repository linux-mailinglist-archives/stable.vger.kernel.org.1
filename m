Return-Path: <stable+bounces-199900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5F7CA108C
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC0B53007685
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B456433033B;
	Wed,  3 Dec 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxE5DAXT"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E230216E
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784891; cv=none; b=MJTVsuHUW30Fiv4s1UTpNqrRZ9O7QgXSc/wNVCc5f/b5v1zOxOuSWVIs8l1x5Yd6I5RY6kf54OZgpspuDohqPu45m9J9Z+56wF71mXFJcPBoS5hahMXji6H2nVVS/tiq+xnqd8MmSU3V+7sJsV0Q4cGFjvrkuVz/gTjFb7OUnW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784891; c=relaxed/simple;
	bh=ntjvGlLrcZ1G+Asp9gS15qgv2pa54burYuU122Y5eTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHlgon9D0hKQf+cdDJsk0ivJhiga6VfA+/TUVpsq0u4WGEnXvmpcRD/4yPfCSMJGpKWixiSH7qDXmgmhnQ8N7qfhBi5kqCVHLpVwSKnWGSnhinvo+J3OtOaIqGDfj/e09iAUA1ZWEJ+Hi8iM8wkxuaGCYpelxYiuYoc7I0s3GHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxE5DAXT; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dfd4a02638so29711137.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 10:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764784889; x=1765389689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncJT/IoSu+YIHBxG6RjDXHdYgwMwWxBQA7x2oh8P8cU=;
        b=FxE5DAXTEtju4Pedp2skadoikoB6jplpep8QJ0Cc4115Z2CD6ZlORYaIJptQZRF/mC
         sOrJ/fKZzGifc91z+4zkgUsfkD8BjYb8Tk9nd7/lq8NfKEsrf0ypvWvdCIIn55Rq+XDg
         0FJ/apNDUw+Q9egqNUBO2D8MwWtPLlcSKBXw+ynhiu0Vmz0FQei/ky61Db4pJg1b7CW2
         BhaXmy1p5wLnjCdPBI///YOrH8VrbSks6MpYPq9rvwhnBBaQro15xpBbi8TtAYUt/Ean
         fJp5SzWg8rT7c+ESSu4LM0b3VfeKZ5y3PnNm6xT49VJ/Gje71XvxQVWH1jbe0Y2ERg4n
         ggUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764784889; x=1765389689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncJT/IoSu+YIHBxG6RjDXHdYgwMwWxBQA7x2oh8P8cU=;
        b=Zw3jMjf6I2rcJ71+kkRIVc0oB356WI5WGDGjh0cvL7UapbEIrEsIMXZxaivNBRbcU3
         jiuEURSWSvhZISoM9mmqBL4zYxHlM/DCMQTzSEwDkssNJRh3N82DrgfybYHJWmm4b7gJ
         sZxcTAOZWGKwLMNdE61OWjppeGrTB3TFTF6H0b3ZOyZABMFBcccQNnPZbMn/Z8B5Qv3G
         yWE3MxcAvZLxdwjmXsf/fUilvzBLk/oOG7+IAAC1oZHxubIJAlKaZep2EYRDhsSe+JLY
         RBLVEPuly5ZuHIS7DOlbWgSHBijoPtsTX6VQdirWxiJN7G7T5JVp2IE6qB4XHfvFvVcq
         k+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnN+BU0XElTlHRJz/pdiKco6RTWeKLJvAGMu1Jbi1y+A+IBdgZd8z8I9thoSZqwieNge6+x/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmRyizAfLl+vgpItYVvY+oNrMESorQiHUr8NHAp0mjdV7fSDZ
	vcsjmi7WwjCxWmy5yfi+tXvItWbppqem4PMSDlzzLDuLFT/XK0g9iyVn
X-Gm-Gg: ASbGncviya04Y5mWcpamNPIYiqLv2plHfmiEudmsCassFyZ94nJ5FSyYHMZqsqr+tV0
	zBoJqdA4H6t2erwCLe1Ug94tW88XXMcLtFU+l5nG9xkcsMos57yQL3nl+18uwBSuUcLeIV3PVxB
	WxlRIR7vUDm1UQziJeQpIMXa9l51QdF1ltfreemtihh83B8PLv+1MKQP2zO6yT+CZIwFg1bvs9+
	vFx47pl+Z/IxoSTQjc1roCd3LKO8CD5MAdZWBpHf/TVQW7GSIK3MRqHmzDGF4V8r7oJ6cHHAYas
	TXByJ9MQ5wUkv04UIunq0jHzSggDcaZx9NDBxxykDDWOEX/jjaY+QFBdnZ7fFL/i2QZCoQUjK6W
	NEWXxMk3P8LwbRLy701L7cSsrI9wecfHgo1sO5tCAW+xxWfj9CErtt6Lb0VtaRV0gKftxPYiXTM
	FBc27AoYrsjsI/KtNDtoNvLOA5peP89VUxW6gnjQ==
X-Google-Smtp-Source: AGHT+IH1Sfhwt2TEXAHKsmKFd0ZdFGeqvK0X2GluPHEpvL+AZPyVG2NwehyogNSX40XuOfjRPey7yA==
X-Received: by 2002:a05:6102:cc6:b0:5df:c33d:6e57 with SMTP id ada2fe7eead31-5e48e369cc5mr968565137.26.1764784883974;
        Wed, 03 Dec 2025 10:01:23 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b8fcbesm131573066d6.54.2025.12.03.10.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 10:01:23 -0800 (PST)
Message-ID: <a8e4cfdf-ce51-40c6-a3c2-3a6e3d416c59@gmail.com>
Date: Wed, 3 Dec 2025 10:01:19 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/568] 6.1.159-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251203152440.645416925@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.159 release.
> There are 568 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.159-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

