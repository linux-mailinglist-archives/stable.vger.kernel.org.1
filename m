Return-Path: <stable+bounces-69257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811C9953C31
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 22:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A865B1C21BC5
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3EA38DC7;
	Thu, 15 Aug 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbXp9qQz"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3A74059;
	Thu, 15 Aug 2024 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755319; cv=none; b=RgHI1XI04fky8pgR53mGj/3dt6mk0AnWvi4UCdfZ/ovquyPUErbEA2JdCD3XQn7SahlurKe6O63Ufp3gOgzlv4TGorNPNqHAk8XT15vOQTZQPr3q01OfLC6BYeTSvN0WTaQiMHVkTi22I9+3y8rdk8FfUsHudHidDwqXsuX1f3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755319; c=relaxed/simple;
	bh=0moN1tPFvqCGBgZIbg82318xYYl0/TVwueRuoMVIwvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUWGbF7hkwmDTr/Bzq+3R58CYf+TpBIbxmmrCz9Y68V1XgmP1GAzanmn+SUyeg4CCm4w4O2nKsiKDXLh1J+IOG1hw7fjKDuu7xACn6DLMyZgC0IXRyDpYFpyhUEHvCadz/0uxCSpt80cNJgQHT7bhfOzalykX3AD3PZX8dP4XNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbXp9qQz; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0bf9b821e8so1410662276.3;
        Thu, 15 Aug 2024 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723755317; x=1724360117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TdgbOJ3tNh3Wtc7PoiW9Xdlmt6LlXWIUz7LAP11/qk=;
        b=hbXp9qQz7JkQvlK0nJwAFzFcc+0GRZ5q43UIsividqZDxbRHoUacEi3/E/EfP087gq
         T+IzLwcFv4Wmon+jb/MJR6jocudyu3MPE01E6HJ4kHf2Yl7r0RFTp/Xv7cq+Cc4dyZUI
         mnzWiuQv5YQsZGns0LvoUwLQLUwHgrUhWGZwMIVeBMDSs7Vg7mKEcGHpkIYTq+lgJ2t0
         uMmNkNmUQj9Mz+S7ugkNcwKv8ysIfm/2kj5Q2jT0ZgYtHAPi7oOBHX6rnQFvtqP0URDP
         jrKkmTAh+zhxCe5mjy9v3JO+Zai4SMOxgnih9N4eSSIp6fmfeULPr3qnCA+uPUuMq/Kl
         3Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755317; x=1724360117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TdgbOJ3tNh3Wtc7PoiW9Xdlmt6LlXWIUz7LAP11/qk=;
        b=vSIN5mxHpjNR0psRpQmXkvaNMla4EUnuRlIUnog1cN+Vk/dm84P/x/RwYodxtBM9om
         TRYOTm74qmMuhdohTQHC7NH7/lCh3Od2cX5f9PL93YgZ1tFQxhYCga1nanfq8uXZuff0
         obRBDY4Gd9uZjlQNS+s6te0FBrGuchtCV0Kl1ZbNL34DrjmJUZn64XEzgzsqufX/hP2M
         Sc9Pz3wzYaZZx7UpSkL4yBrfcXYGhkrQWadG0vY1xMHpMvPw9KKddkuSiU8e2SuK8VCL
         CnMT/e0HdBck9wl64j8HlIVZ4pT4Cehj77mGPWQ4JdSVZ0NckmiNDcMXqKCgAr6qhzEq
         RyDg==
X-Forwarded-Encrypted: i=1; AJvYcCXW5z+naYPyYPW0k0LjZ1SeeP1fUE+HwgW9UMmurxUQAOnrZyAf090eRny98pQZwZbhzJR3sst+CUjGPZ8BP9gEMlxLPccZq84knkVSvPtCvBYy0x4auaYlMM327jurttTdD/Qj
X-Gm-Message-State: AOJu0YwXyc37kqUdAia0Um5QWdf+i/dJNeKn62fQVUrvhkt7JsIAIUyv
	K1rHwv8Xn6bCnx/A+6/igdUiap1eeqCr9l8+a+A1ZmCg6NRKFrcZ
X-Google-Smtp-Source: AGHT+IHd4jF0LOmA2CXbpWINyM7i5PyACnA0Q6zj223/lMx9inDRqQo4i7JArkLMHxoDVuB4mtnTRg==
X-Received: by 2002:a05:6902:1547:b0:e0b:c822:49b3 with SMTP id 3f1490d57ef6-e1180eee6dbmr1147733276.26.1723755316924;
        Thu, 15 Aug 2024 13:55:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-45369ff5460sm9368681cf.35.2024.08.15.13.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 13:55:16 -0700 (PDT)
Message-ID: <9cf8045e-7930-4e51-aed9-a02c8e009aad@gmail.com>
Date: Thu, 15 Aug 2024 13:55:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/484] 5.15.165-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131941.255804951@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 06:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.165 release.
> There are 484 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.165-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


