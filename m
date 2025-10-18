Return-Path: <stable+bounces-187812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BED52BEC693
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 05:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BDC54E99BF
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9771D2848A0;
	Sat, 18 Oct 2025 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImHy/FIX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D827C842
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760759117; cv=none; b=npn6jnnrZq7XftYdcHkCjzl/yNCE7Rmh+gc0+5Jopx4AACJkFbNWRrwQLHaZYI+/t2To0nE3c9NfTq4svM4wZSN1GqDUXhJvvTP27Oi8aUT/6UZjFomaReHqRPmlwpEX7PxW8pbr7ZdqJ7qYhzacTe43KaBgXQfH5jtN1F6+zoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760759117; c=relaxed/simple;
	bh=u6/9jHkj7qO+NmSlMp88vtxuMBrWpXS2X966ZRiL2UU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sRVw4Q1+tHkfKWlx+Qsz0nE9FWMKp/6pRdAeGbAmJCYKNUUZvWtlLC7TY/cxT/yhflacNp8lbb6mhmAjkej7dllG+Q9E06hhCk1O/eLddshNOvN/fdkXbl0XsQdUsuBLZ1dQm52fvfKb1XmC9KHkQ9sP+Z+/Gyl8BF0rgvfJT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImHy/FIX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2144925a12.3
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 20:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760759115; x=1761363915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZPiTXv5/P/VJj9LA8tqWCZHZQ3/DrJlaMULKUBY16Y=;
        b=ImHy/FIXSu9VQjAil+TJVYSzfwGKWHKil/KZ4RJigx2n1uDX73wy1axttCEHNfX3Fi
         RFy74sPGGAZ6mwAscXG2NPmOHlNA7LubQaPaas8NFCAdvuPDE2gW9IgAGcCnhS4RmBha
         tUlXYTOxuaP1IUkyd3dhr7V00QCs/ufce6X4SGbAPvySEqAKcmbWf6/emJWERDOEo8ol
         5t553UO/yS9/AbDbQOq2PQo1cAziY5eKThywGAJ5ezCwzX3HH9A6B3m13h+2SL1WKcXg
         U0OZmBzIKtmB3gWnpQVK0ZqUcDycmPeE9H2CMNYL3Dt3o6xwnHhC3wiWfr3sehd0cAOL
         QaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760759115; x=1761363915;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZPiTXv5/P/VJj9LA8tqWCZHZQ3/DrJlaMULKUBY16Y=;
        b=paoYsoBB/ireWJT55i2EC46y5I40hlKPYbCKylhmT/UtYbf++6dSodiAWQJY3TsNA/
         atsvny/nBK+tGzHfqQrkcH+8Rjmvxe6lnSQ3b0VcPBaX0MnzEQ3naPMlsvXs1baSAkKW
         TSTr43onqVdiJRC4BmW2D2YbH3Z+K3wdlSy/OMKWpKjuaVYSldf3I/9z2B6qgjaVBaU/
         7c5cFGg38fmqbrXx8WlqVECkl8pN2s//Z/mCE0GIm2zuMN9tt+mghMrE3uLYohbeNB6L
         dfWCL6eet9o9xaa2H4RrS28U5QXFA/wOko8qk+s/lZ6dO3t1UnYSNJsHq8asJWcNeYSV
         g/1w==
X-Forwarded-Encrypted: i=1; AJvYcCU1NPEb6q0xfXukgLSsSS2vJjmHDxmUvOhc/Ft2yaAgqnmT4hL07F5T7JexScoN+qTHzVjfFt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsl0WvzgAUDfVz95fPzjvZiY40qhWUNJB7sUbBFF2wlejABb4p
	srYkldSKNSdJ9WV+KXDJ6ml9GgOQ5CS5UCVfrpZDf46hk3dVMD3GSVlA
X-Gm-Gg: ASbGnctZYzIhRLmHWpX1+54YA5E844RQ4YeRKt+JctI4ZN+0ExhBRFCSLK3HqymnLK3
	0XGFS/oRYzobL+nRSpzunm+wBdkYNgcPjUnU9DrNIYXNc90jFD9h/XwPnO1MsDywcRbv/hI3s2U
	2k5kbpwwMLSQ3I4c49Z6KHOpyQSvyTEzw/Q0g3H6iEVx7qWjD9LgxvPtKrm/ZbtaFWaEm0Dw7e6
	hRspwJJM/S8UNeD2+ONBBUPfEuxaimrOhHPmQBrXUp4baCsO2csjEymX8/gLpWpB2oN/AeoQudg
	Yf3bj5esqOvpS/FcObRtNzH1fP7paFObLdLxQ2Hg2eo8UxF97aaRmVMnIA7tQNdzTB0XtIUGF6O
	tmBk1yj5B7ppKT+fp56NdWtomJgSbFK2PylvxMaK+jH3YQVjkfciS15W3FjrXX14pbbf5ayigTR
	RyCarbnh5xnDunT+/g6x3p5lKL0zI4jy3WfWdLicmkIW+VXpO1DhLu
X-Google-Smtp-Source: AGHT+IEyPGDCrhJn7n3YskwxHujg7B2Q58Qq2Bz6HIvRczxy68f7zbwPSgq9Di41T7mu4GcH60pupw==
X-Received: by 2002:a05:6a20:939d:b0:334:97a6:17f2 with SMTP id adf61e73a8af0-334a85640efmr8177662637.14.1760759115108;
        Fri, 17 Oct 2025 20:45:15 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de0c06dsm1035981a91.8.2025.10.17.20.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 20:45:14 -0700 (PDT)
Message-ID: <2d9f4775-7f31-4088-930a-f8b977f4ec22@gmail.com>
Date: Fri, 17 Oct 2025 20:45:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145201.780251198@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 07:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.4 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

