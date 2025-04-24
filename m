Return-Path: <stable+bounces-136588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18230A9AEF7
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B0E9A1DC2
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7627D79B;
	Thu, 24 Apr 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGHrcidl"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14C27E1A7;
	Thu, 24 Apr 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501305; cv=none; b=rzHSU0eArTEcrmlJ1geV5vSeEaE/I+jm/NTnfdrRH7Cd//gqSFgymTmEBpc0g32whwx0byPhKGnyunttl4vQ4vU6XA9dk4nM7ufAZlasqiMO/a/OiePQpdCXybCtAjA8xN6n/tL18/gCTGRKaXUJ07ucaLcKEUO0sOcw0qUkYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501305; c=relaxed/simple;
	bh=hEv2L8WUZLGR5AsQAv4iJVbo3cQYFeM0ZIG7ijuV7lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpzJ3Nz3h6T7nI8wxQNEvlmQBULwicQFf7on4rvhbOZCXEsxx8z6+3aSNK32LxlWhsy9tSzPoUxaa1RtZ5p1881sJqBjZ7bGxulmkIcla2Ne98tBAUusmA3ru/yQmjci5jt6lWS8vgcY3OEpOP0+YQRomG+yamYwha7gKtlWDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGHrcidl; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c2ada8264aso452757fac.2;
        Thu, 24 Apr 2025 06:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745501303; x=1746106103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GyhDDG5/LAN/FZE/ta/3vKP49zmJZjSSbjzTSUkiCgo=;
        b=MGHrcidlH9ySEn6YakWcFlDNs19BCjWCCY841UVvAk7GhYbywiWNljPyTpVxh1G1Kh
         BqzeBqPhpJccD6eHBqbpWo9Xn91t/9B7bk317sT+UpEUoJUyZ6C6TUIAPBg23BXCE1h7
         5QbCExg/IOzLLCFbvd53+khPCrO/2TDLMIJJ9NHB4/FGX/tSjLYfKGQVxV4soXDTUGWC
         OfdXdzTAvgz/C6iZyYRfC/NmSL0zVOFzL8UekznAjphDcFechgMpiSYLSxRJ1MIbkpDx
         X95HRy5HRyUxCAHYBGYcSF88ihM5+p9mgQW3louQiDh7EABachY2bzbtCTxn2w80eNyH
         Y7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745501303; x=1746106103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyhDDG5/LAN/FZE/ta/3vKP49zmJZjSSbjzTSUkiCgo=;
        b=mDN5VRxokx6Fw9iTr1tmjy9AJ3Kzt57ZK6N8N0nvF2fMQUvzBnjZ2Ke6+dAiGrnpZ0
         bWTKbIkacY+7jQvP7kbfsoRtV6LkKWRM4MbKlf5GUoboGpkFPuRLMu3kDcwUYX9/rxPY
         IUi+6xBlB26Vxr/oHzLmM7K7ip69qauOq5R+8OMAo68va84hJvKkR7Ko9JTwxT0E7vOu
         gtGpsJ5o3+cqRKgDQwkU8ZogBVcq/wIvYEDks03JD84c0iyhub6ddcDxRa2RKfiavch+
         7H1o+tqw4flQ60LKn0xB2bvz0WvcxtoYyibHgs0qYT3vBIh9uzv2orY+I+xpaodR7+/3
         3K0A==
X-Forwarded-Encrypted: i=1; AJvYcCUGcwDqj3d1/AjmPcCf5SwM2Drn0ulpD2n0vQmrtwZ4Jsz0cy9fe1Sn6j0WGc727dHs4pf4EMcL@vger.kernel.org, AJvYcCUYGYy/WcQel65eXh+/Io2Y2LjGspuTQk4ZJkzbWOHjNIoZD+q5/H8ItPH1UuxQbA/Sn9VHbwUtoqFrXg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhInlqsIBV52DNo9bbP9GEM2Hdoj2mNUMtkKI3SELiqLt9UA5s
	t7D+DUDPKghr8bPyi5ITyvzsrxEn+nEpm0RQP+kZ9FgvWUR8hb4p
X-Gm-Gg: ASbGnctQY/LEyG7BZ0jGilG/b/anFnTJ2b17ZsCvA7/BtrBvfR0We3XYicZkKZZP8Yd
	dLEE6ANZh7/vy0/28OTX4pN/rZ1Bl2sEIoGV2IUMOTWtguQAK4Szg9jz6ipW8L6f7ftKtv/SyLn
	8WtEBHe28uDy/NN8Ouk5okcUMIOmrkzuVpcvr8cavHtThXZeWwRtyrP0sC42NUEE3QL9PzK1WdE
	GZZCju6MTN9/8SphFgRnMmew6wn0r2fsv8qKQV6VEg7oXs422JtRNHi9sjR2g+elvxlfyAsC/rR
	dsbzGJvAjR0I+qYKK5sBf/4MzjVa60ouhIyIqktl9WivGPXrAMi7FGkGspELZgk=
X-Google-Smtp-Source: AGHT+IG3vs65HmmDqfATZp6U0Jf+jYSXSZoSCRio8I9iWqqJyME0lxNMmgA9lC3oirNeOjLGkb4F6w==
X-Received: by 2002:a05:6870:30e:b0:2d6:667c:511f with SMTP id 586e51a60fabf-2d96e334f06mr1585765fac.9.1745501302727;
        Thu, 24 Apr 2025 06:28:22 -0700 (PDT)
Received: from [10.54.6.12] ([89.207.171.92])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d973b7ea7fsm286170fac.32.2025.04.24.06.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 06:28:21 -0700 (PDT)
Message-ID: <37e3bcdd-6410-4ecc-a168-66f3afe96f11@gmail.com>
Date: Thu, 24 Apr 2025 15:28:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/241] 6.14.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250423142620.525425242@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit





On 4/23/2025 4:41 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.4 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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


