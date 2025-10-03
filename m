Return-Path: <stable+bounces-183304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ED9BB7C2C
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 19:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B96219C6AC4
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663D2DECAA;
	Fri,  3 Oct 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be9g4sgw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142922DE1FE
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512774; cv=none; b=AriHk+Sw/ayDZB0DW4ezAoaJgfbABYUqlLyBnN4jSFNeOv66TzEBKJ4CHj7lvTVbPHTSW+7B9TkqsiDPFJtlT5Jm8XgVRhxjNonqzfwHmkjeE6O0dtfsu629EaHQfAfu4ADSlU4qseK6gDcF8pTZyN78SzLU9i3GYAu6OOClzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512774; c=relaxed/simple;
	bh=/zWwxR7jnhgT3e053y0mBHqlR28r1nG7om/4xdmHk2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHqHA7bxgNe6JE4TEnOdfALZNq+0q7PkNqY82IChffzctI9eO3K62YiOuvhL5xOUo3cTwuyE3R0MMii4XNeg/905o3CIy+05+dDFMEVE2Zs3NOQ7BIKDXBI3bDm/F5mvKNAw7IHe4XiHahOHm9UwVsZ7FVAC4L85AhDEFM1mfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=be9g4sgw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27c369f898fso28292465ad.3
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759512772; x=1760117572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3q3kNPw0ApKhnK7U/kRjsM4J9QuxzhyjRkD8O9PFXs=;
        b=be9g4sgw3LwzALk+si0aeSPaAXK4PW9AbVh0TS/6VhjC5ckcPzOSIhxYlQXKLR4bdy
         AbEukLjWa/LWxFE6JDcwYlDIeXDexr7gXaOyfR/eP3YukZPJbQuLnM/QxaGMTplghryc
         JBZyFgOjz2QAqYDOFHwexHlKDJDQOzd0p2XENTC6XoW6GqswgW0iEfLwXMdx4SN9fZQT
         zKX6l9sZtnGe5JEAqBzYg3VIzTjasdpELGZ2+x1O8M3kdofqWRxms7ndSdHNraI9j1KR
         c3yJ7wyex6cNqNF/6MCdAL4GMwjKnVvisNOtHWbNteONOMREA7zDplCf/Q6SxM+7g9rq
         1rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512772; x=1760117572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3q3kNPw0ApKhnK7U/kRjsM4J9QuxzhyjRkD8O9PFXs=;
        b=NMdSgl7pp9Owaqn34+WkGbqrU+YBEMvfpmFbCWYpuceqDRQjtCIVsfJwFahyWh9uAM
         XEk+KVkdKYt48QxSaCU8VId2bBtss0z0jEwsTlVNdtIxxbp/yPr/QfARIWrIpVcoJ/2l
         A0Wuzby7flLzkqMm7TsDu5BLTix1dyB2zb/WLF/Cfm+XdpLx7A7GRnA9rJ4N72vlvmO9
         dmTmIS1KR7KR6uNGXFLhzWC6wWipTIAF+azguow6/kufjrSFQXn7QGr06I4uXCIJ+wiu
         pkOLIS0S3L+tBCQ3ogAo03rQTW4qFJXiLZkZP8IbmbifaRqlu+LojqPhhfJ7Gc8/6nIg
         aDMw==
X-Forwarded-Encrypted: i=1; AJvYcCVMnTRLW3bvQAlxiX3kYzqg0L0ADO7Bv9j7JGBKeDHoT0Tcd2BVEMYK/lz+YeK1DcHCI5h5s3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo39VPa2kVb3JP1XMnVr/2Kvxyfp3qEnUFFYFTA2WwvC0+vJuL
	ze4lNeDFjBQSFhAWbH8ss1tPecZyg9nTWNiCpLY1fO6JzIKNt/W9cMj+
X-Gm-Gg: ASbGncs3AE9l/Mm6y9v29GtvbbX6zrS8lqh2NXMvlLumokpOlBueIYZVGfE0bKhiWPB
	NtfUHq7yLvip88rxADz9CQ+AnM58zHxhSsgI18BFq+4MqlpxF2WLzEzYYMfLwqCBmk2sdpeUmJE
	7A/1tQEtBda6/UT2e73k2U+w5NPslmM1xQ/YqjtU0B+A3FKzw5BqWZ9koc9JSyZQrBX/iu2+efe
	21mab2QWmX8T+C5DjF1TW7QakjSU3VMUIaCY/M4hRey0gBLOUfkL0ansSwCtEyQ2PutsZd6+TN6
	ZjQl671fo5jzwCNbG7vaiBdtgEHVBL8yLv8iIZ85WRQxMF1zA+pAV/a3Jz0Cu9CfK/QS89QbIOF
	sYpLz8uQ+mk0PLWtmEEd00q8pWhkpp3pPEFS+0shOsf8diU+ZJfadmg2x4QicEnEJrenOfuD35D
	g+U3jFUWbXEuu3xvd1wbIxlYc=
X-Google-Smtp-Source: AGHT+IEhIeNN62AWq5uTx46AyDu8Fa0z9Vfz2iBvkwTa/pyPi6SOUcGwfQS72vWfZG0oq9oJ2p0Edg==
X-Received: by 2002:a17:903:120d:b0:27e:f201:ec90 with SMTP id d9443c01a7336-28e9a5ba9afmr46890745ad.25.1759512772366;
        Fri, 03 Oct 2025 10:32:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a34f40sm2756054a91.17.2025.10.03.10.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:32:51 -0700 (PDT)
Message-ID: <08e96c76-f4ef-4504-b80a-9d474035b45d@gmail.com>
Date: Fri, 3 Oct 2025 10:32:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 00/14] 6.16.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160352.713189598@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/2025 9:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.11 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.11-rc1.gz
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


