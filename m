Return-Path: <stable+bounces-111749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5FCA236E9
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 22:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598D916489D
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1038E1F1526;
	Thu, 30 Jan 2025 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGHElZ0x"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A6C1EF091;
	Thu, 30 Jan 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738273484; cv=none; b=CHSU20h2p0ZrnubEsKXhxoHcIskHhYIVYy5aEBmwTQeb2GSo/mu4XRzGNUE0MqWBnDk0AdHr0zXoXFiswBFghqkt/htXvAb1eYSN2xKZHIM0AcGuAMrrwuJWOWRAVq3nxozRayPId8yEDdPi6r9pQPpw6D+BBe/hqd0pOByc0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738273484; c=relaxed/simple;
	bh=/QICPH6BgmiYEj7MCvCw8Foqj64THsrbeu8JIvM1eL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nn7lzlwG2DYzXP6FwCmIQKOvyGSlht5AFdqd3s32tweP18Nni/loy0H7kLGh3Hh6MPWJz/SAurZXC1Wdj3F0QDkelkBDdVD2KPUnB4TleZGso5XanXGzaLINz5hc+v1gTT2MDP4n+PpNBB8YyfJxnkcyzMQgZ0snQnkEioVpKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGHElZ0x; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29f88004a92so661947fac.1;
        Thu, 30 Jan 2025 13:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738273482; x=1738878282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yRLNIowjOD9kJO3oKSkgYj7jQiV+n8mJQ1YU1OEKjdo=;
        b=KGHElZ0xQLsFDzonHMq+kiHd4btn4X0aZkkTIKV5KqnZW1+UcXQiiiFWcArH7BoDGi
         pQPUZE1xoGO01t9bJhmnGjUOI3GvLPfy4J2AcJV8VBoxMdTwVK2+bYclF7tsmZmd5QLb
         9nq/ZlEYe6NsUqFxc61QyKG7/ZhfeT3xpIlP7qk2j80uXYA+XNZ4Kc/+5v6nePo8dj17
         4lrD0mTVeuDEn0sfXsBrfrKebMEyNh/EldEcy9JLcZMNbc5xShhwTcnnFkMyvWRXVyzP
         JB9wJIAl0gv/0PtY/Ox0TAn581PfYdciyAz3JtZoyM3Qzwz+uur4m+JrRcVt1xlhkfKA
         47Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738273482; x=1738878282;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRLNIowjOD9kJO3oKSkgYj7jQiV+n8mJQ1YU1OEKjdo=;
        b=CKLAb/VSr9nRuMNYHlUu8sWM3kbIpeV7hDB6YIESTkKV5Hmm5oeC6w4f3588ZrW4wq
         Lzp2C5rlXRKBebw55USit9b+48xtsr9rB1HTZiZ4SkZnDVsyGMdoitGF0GZ48DkVVjs1
         iyqsvE4fslGCjolE6v9//xj7lEvWhVogYkHv4PK0sf1A7cRu9JB9kXT0zg42PU3LWh5o
         SpToPppMAMuBHOWmCIgmbak1rZ4cAxkR42ozEsBKGNgstiljWBHn9ELkgaJgyoPQeaqM
         WSp5g7hDneGFno3qiOPhr5k2Zz0aWEeMu3t6INd7pj9TjNwWp0rlMrEFA6+37X8QhnTF
         9FQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwNV74TF5JXegixQl1LONsi4/9+5D54GMrxlcuAWj8JVeI0KVCBKmA2NDXr8hPelyoaJeb5zXn@vger.kernel.org, AJvYcCX+xwqpfF2QTyUChzefrjoPtBlN+ZnCVzEYfJA2sdAOfIrxxhm7BzXAIRC/1YT/eMffaCewmp1F3mHBSBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhAJBN/VsB50m5ArgKniC4rCr7R2NMHwXTpdi9LCJ39Qx1b5pZ
	Qzc827BqSRiPD54iWC5xZKd7W94eHgwLVgfNHE17HIz2DSE907Kt
X-Gm-Gg: ASbGnctMOEJdONyC4KvKm2CammxNHy1qflqOV7llzakHACVUKzkTDRlJ/FUZvAr4fug
	l9ND61HbO8Ma9Myky+/BKwwXETxTD80R1BVGzrGKpaVXEj6ziU2Kz3AToYf+XHL1X6wiAUjmP5x
	hQBTyR6ppx2WFRziJORPoJPcc2JqFmsO1HQSE1uaIafBswPv4rMw+XosNVwI03fTjeBk7jcDVpS
	2xL1OAaGTshK2AQ0NHgup1EGrh5FhCXsdbt9mQiRSYts2ZLkq8JmPhr2vjMAbrd60ZMqnTcZ9ei
	4h6tOhc7Jk4a9Tr/Puv9iPcmsNBOUQEZzMyGYGRFr98=
X-Google-Smtp-Source: AGHT+IHmLmiE+aKzMAVjv8lbOFVS/EQI3uhjVnUZVz6u7fBHmxSU3rvWL74WRNbAYB5PQmyZA8HdjA==
X-Received: by 2002:a05:6870:2c89:b0:296:e10f:af14 with SMTP id 586e51a60fabf-2b32f324d48mr5854995fac.39.1738273482328;
        Thu, 30 Jan 2025 13:44:42 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b3562e42f3sm647048fac.29.2025.01.30.13.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 13:44:41 -0800 (PST)
Message-ID: <04c6c04f-f85f-4849-9ad7-61d20884404a@gmail.com>
Date: Thu, 30 Jan 2025 13:44:39 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/43] 6.6.75-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130133458.903274626@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250130133458.903274626@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 05:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.75 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.75-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

