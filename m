Return-Path: <stable+bounces-28082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4650F87B1C4
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780231C29871
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 19:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1BA42075;
	Wed, 13 Mar 2024 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RyU4OZqh"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560FB5A0F5
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357686; cv=none; b=GntGY1G16zH1PuLNaSLieuXo6p/LDeukWI/wl5pWMtgnA9VWbCJzTeu+DChnYEkEKdvlRCCYWhcSWVBNORHHhBtcYnu9fs9eHLXT7MkuelhuTgdzebZn7E2uSOGN3Kghr+rRnqaD4uPI89ley87SidT3W+wnzHTfV70hkf3rmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357686; c=relaxed/simple;
	bh=iZYmwsM238XNM8Ka0wxu6uYfCPdbHZABFgW2AEZ2A5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pShMqKYCnwLMaBcwJlVcoi7sBJvbni9yEvaAbRExDY5tFHLYZQql/v2a0ihCGzBTljGdkbOSBLbByDWw5pJP75W4EdBkSI3Sr/OeMgSiKUYlqMGk4IiW1HPiqydVkAt4H+r33X9K4WKLPcgX6x1ITudgfo0t6Z8ITdYcRsFnnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RyU4OZqh; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22195b3a8fbso214341fac.3
        for <stable@vger.kernel.org>; Wed, 13 Mar 2024 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710357684; x=1710962484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nX9WeXEjo5PIfyS44ffFidwlQU53WgsdSl+O4sm0lo=;
        b=RyU4OZqhbaquR1sr2ajJpKrbFz+23Nk48Eq+U4r+jm9lOt0t2ai/D3MVC22VcBZAVO
         6BQopXT1cnK/cm009vnw8wMhDAMdHBV6yQKnpbhNKW/QZuxCQdUwlWR3tHRHWSz6O0tU
         C3wF7k22b4p0mLCrDEHZhlA1Ig84BaOgdpHAyAGXqzU4AHw+z07Zcc1rguxcNEWorVMW
         sWGoWrjlWUXy+03lc77tWTpRYpCyySUL8H2PK1/PK3u2XSR7PKqv3MWwehxoAWVe+UNS
         ac8gIHqpd2U67Z9cD8MoOq4AllGAv1VQ0//Ro5mts2GL9wj0SsmJI7uDtpeSGK9poksX
         1i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710357684; x=1710962484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nX9WeXEjo5PIfyS44ffFidwlQU53WgsdSl+O4sm0lo=;
        b=GL4SmMJGLoY/pg3vJM9sy7jAgpv4rq8scQaqdzYVJa40dfkz+XBE8hQP8kh85LBi1P
         uplSCCishiIQh9mxt/jtdA/bBjxUzjA//D1vFKCG2w9HRrPU11n3TGhUcvB7udvpgHA1
         8IYN/2qnnxTupxYuKDuAp+yFjEwN+AV42PvsLEwEu2BUSUM1C4dZ10UAvbInSMHtEXaH
         FrH2OY1o9YknNFOAzpSO0jXjmozMWxbIuvILrIwM8mpAK2US4NEpWaofbglsODhucYDa
         0Rw/FHpOjqWB/Y1ORyNzZDNFCBP/ZHeHj2RWscyyczOCXPZgXvtjofFiV6lVg9O5gMk4
         e3pw==
X-Forwarded-Encrypted: i=1; AJvYcCVDzjKAgJS9eaC535rXjPyczn41YL/ptjN+GgZkHNxLnKeWlxkYXDk9fCuhubLQe5mdKyBrCrV5QmRj1EIOFd0Z8PWIWeYy
X-Gm-Message-State: AOJu0Yxh3NNGV4rnSg1qpbHGNfOrthFSialp+JOjZuFDMy0Hw5bjWQQh
	AH7c/LBbveCyjbXTnk/Qlw3HectDCTFyQgQpY6ZFe9b4BBiR9xco92ZLnSli/dU=
X-Google-Smtp-Source: AGHT+IEtnW1J7GXHGOqaIzmbtOjHec4OFcEwDYVWwXFNvZ5VPNlUHz9si/ANbbnG1Y+dvgioohgMcg==
X-Received: by 2002:a05:6870:210f:b0:21e:fc35:73ef with SMTP id f15-20020a056870210f00b0021efc3573efmr8191998oae.38.1710357684512;
        Wed, 13 Mar 2024 12:21:24 -0700 (PDT)
Received: from [192.168.17.16] ([149.19.169.183])
        by smtp.gmail.com with ESMTPSA id gk17-20020a0568703c1100b00221b5fb8a3csm2874235oab.27.2024.03.13.12.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 12:21:24 -0700 (PDT)
Message-ID: <2f15e804-a2d7-4ad0-9b84-02db8c89985d@linaro.org>
Date: Wed, 13 Mar 2024 13:21:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/76] 5.15.152-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, nathan@kernel.org
References: <20240313164223.615640-1-sashal@kernel.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 13/03/24 10:41 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 5.15.152 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:42:22 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.151
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

We see new warnings everywhere:

-----8<-----
   /builds/linux/scripts/mod/modpost.c:1123:44: warning: excess elements in array initializer
    1123 |         .good_tosec = {ALL_TEXT_SECTIONS , NULL},
         |                                            ^~~~
----->8-----

Bisection points to:

   commit 4060bae9dab232eb15bc7ddaaeb278b39456adf9
   Author: Nathan Chancellor <nathan@kernel.org>
   Date:   Tue Jan 23 15:59:55 2024 -0700

       modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS
       
       [ Upstream commit 397586506c3da005b9333ce5947ad01e8018a3be ]

Reverting that commits makes the warning go away.

One reproducer:

   tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12 --kconfig tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


