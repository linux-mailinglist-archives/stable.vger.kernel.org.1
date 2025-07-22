Return-Path: <stable+bounces-164295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79068B0E55E
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590AA3ABB06
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99A28640E;
	Tue, 22 Jul 2025 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UPv4UZak"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4522286409
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219332; cv=none; b=uW5B8sqaBYWhl9iEf7DNbA/pH4KJMFp1j9dpoYkGBD6HgBtRXdfsGXn/fg5ZGZUMhIvf2Bgum0JKO/OZuALv5VZjgdUVpqhwzW2UYx73SRo1psmnDly+U55qsBrJ4K7iZoktGFcOwVTmp2rZnWfMMPW09eNaX9nB5jyNjWb8zNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219332; c=relaxed/simple;
	bh=kRmeUWYh6EGVUzw8lu1fepCuY34yWYJEXR7sLZcqSFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7q5F3YKvg7empmAhGg+XNi0NlPqlCcgkPdK4vOtdRkG40o7f0p6IYqC9vu2CiX9lfDfOcIAgN8ohTH9FViwN79SU6h0b+GgWGqaQaQawswYHq8Fz0FiQ+S9Pn9gRxaXjv/SWQizT68Ju66KmBjPPxPu/LCgnhWaiKcsoqi3kjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UPv4UZak; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-87653e3adc6so234973839f.3
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753219330; x=1753824130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23EjP8BqsKxCkxGPOHLawUuEVZik+m90LNaYybWi94Q=;
        b=UPv4UZakm5ODu4igEQoGhFBWK+IEkerJnsz0YSlco7+R4/tfTAhGvOFkB3YHk5h5Xt
         nyO3TTkWuMyryGUjnz8FfcrY3f73Nr6Sz5yg8dZdvXEq1yBf9V6HX94+I0Hr1Vi1aebm
         SG8rp1eWRzG5GIFNyBRTAMSlu69+UrUgN6E5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219330; x=1753824130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23EjP8BqsKxCkxGPOHLawUuEVZik+m90LNaYybWi94Q=;
        b=QNQL376JSMKdfZii4ImfRz56PEKb06FbyS9LoS33adWozduXF38GjhZ/KeaA1J6Chd
         V+lpm5jPjpEGL7lOqy3WFNHHJcfa/mM7v2ZzeQxk2tku4q9XBQffNqzfKNXRcHQLP0BT
         KzVG/esu5TV6WNiXIJt2m+SvSBYlc91GdCaMN7gUR2J/BvpThXehxdz9Qx8QJo/RQbDn
         n0N2xLWgHSl2JrVLWJB6Mz89aSWFXlTbakksWH+q5M59ksMO6JtVfqI2kSmVgK+lPvoo
         c/VY/Oxm3BJpPt94dVPPfQv4/32Sh7Y7KcDsXvxiMkh+pncpXkGv5vXGwkqm/CYe6qTk
         5pQw==
X-Forwarded-Encrypted: i=1; AJvYcCXIS+pn+kMSXZ+8bzKzA87V7OViNAlEAO31rbeUwVRbzFU/a/okyGiLx8V/kmgSBQTw5T5+CBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02SGDmezwFEebd1AnH1CPjFoI7eTesx5p1mPuN56uswYOPt5W
	29cc5h4O6dwd3jhHVi44HCDcYae8tGYi8gDqIOsTBR9Dwfx7g2FHeMY5nlZ/joh0vnI=
X-Gm-Gg: ASbGncuNTNo0E1Z+36C9ikVvxZP5wORlhz7qnnb2PLokElg1ah3RoNVo+THrGoDbBbh
	9x3XM4yYF/j8VH2+3nI2IiRnU5X8sA5BHJk+xdRNsRYY2sPzXNqAvhfLEoHpFX2N01+BMazk+mP
	4kcraloS4y3mejKSozKfvrYL46Ko6RZN6kJifZqEDYCgOBmcENI8qYwy8/D0PnCGqsL+wuP4RYI
	AXquNXBXdtRSL/S/Z+VBoeMulLfcQcWjcS7bC1oOVPGlZ0yuTDjlCBCA4sCD2LwLhCb2HEe452l
	5PptKORUzL3jrs+4RfQNLnT0nO4lJkEsbe5gC2b5D92au3bM/Qi+g7AwdWrdzOVcw5DOYumGnzE
	SdVpJrz+wo7o06ardVVvmCJnXJ/z2872mXg==
X-Google-Smtp-Source: AGHT+IHksoSUIDYhxq/5D669iNhvWPBnTdjsS7dJioKuBS1uJBE8Dnogw1moyMiqkJxW15JCNVn5hQ==
X-Received: by 2002:a05:6602:3a0d:b0:875:ba1e:4d7e with SMTP id ca18e2360f4ac-87c64fbb367mr137690039f.6.1753219329825;
        Tue, 22 Jul 2025 14:22:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87c0e1b2929sm322754539f.0.2025.07.22.14.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:22:09 -0700 (PDT)
Message-ID: <90113087-cf90-4c95-ad6a-168ec1563031@linuxfoundation.org>
Date: Tue, 22 Jul 2025 15:22:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/158] 6.12.40-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 07:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.40 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.40-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

