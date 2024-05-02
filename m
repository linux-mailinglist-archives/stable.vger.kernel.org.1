Return-Path: <stable+bounces-42938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECC18B939A
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 05:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6E32836B3
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 03:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C414292;
	Thu,  2 May 2024 03:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q4kVUNAe"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA51862F
	for <stable@vger.kernel.org>; Thu,  2 May 2024 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619517; cv=none; b=k6UZI8RZZbkc45zmPHq/65JXjzhIMy/InSKP8KMhZgYHHL3bgDOLznM7pJfajJuRm4I7SnDV9eSWEI9fToaKjTycP6gblS7GDIguwXHImXDOc+aZfl6dsoERcBBleOm7i2JaUMJK62eqb4SWLqdnTtmK/gc4toyYBO+3ovxfEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619517; c=relaxed/simple;
	bh=LkPS53ybZzjbrrcSV95WOf2sCq9FOuYSYrMbGWNBNhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9ToF3H5OLUDlp65Q92lHcltHCfDYC33MZ2ylSaoY5U7L4moHf+GGlQx+sWDpdol4FbSc6VULzaaDBD6dq9dcovuvDtw40pksdtdu17/YJ8iMxYZsLZZmYQe0y+bq4kfNy5u3RL4vvPyRZrqO3Jvc1ujt+8FVsABszC4D7YSvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q4kVUNAe; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7dee034225eso21197639f.2
        for <stable@vger.kernel.org>; Wed, 01 May 2024 20:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714619515; x=1715224315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfgGwtM/EQFerGNalxKwgDbwkkiHPGr3KDqQ/V1rOX8=;
        b=Q4kVUNAequRuNzB/uIOK7jvIEjqLH/uTOP/+tCE7laHJr3kyKRJucA0LQwCuPta6LN
         0Zz4YGTGxdxzYba+NP1VmSGCLCKZIzRGpcddAlbMnE2p8x/Ww//aOBgOPR5udrLV/7RG
         40T3shp5d9isU6gHnyfGRldET1qSbjjvy5yRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714619515; x=1715224315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfgGwtM/EQFerGNalxKwgDbwkkiHPGr3KDqQ/V1rOX8=;
        b=Jnrmy/pCh8qUwKXpjSQp2ekt0DVaKlhi0lJSHSsqbRO5uny6NFhg58jYTyFGxUU3s4
         40jyNeTsHwTJznepfhZEAzqgLbKburTKaoxkx8vDnDpy8dwWGXX5QbdkEGR7tZz4ScI0
         S6/ZruHgd5TE1zQEsbiAwAC0XVk2rfNsTVGlCK/YJfq/+qWmcko/zDQLh6OJrmOI/Urj
         NAZrqjMCxh5hdCvpHufSKV4R1fUB2op3OxYyBmTjPZDuHVFpkbjQtwwRKWH9e3Y5nYNr
         kW3S6GwcB6HZY2nI9yRGI6VDoAlHhHo1sjs/WvpwZWL6cmsLsU8O8IVMuSTqht+GB8Nu
         fUHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhB4EtnA63TghIYzIKOwzky5r4mcJ6pGAlWVUmfe+CqfVuUKkBPTigc9ZHaR1xg9RBgI24BWgJUXfqemHZ2Lk7LaUAGzZM
X-Gm-Message-State: AOJu0Yxpnh1b5QtMcduLILlLs5hKxz1rr78nV1wd6KmBHqtzhQFnhnal
	qxTy29l/bLWPCGKUEk9hSwv4hb8L0gJVcqtlt1FjzBFGwpKBgSwGeNlAuuKI4BE=
X-Google-Smtp-Source: AGHT+IHq7TbLyMMAGqvlOjDGbNlw43dcSHaF6SIWFiIu8ZSJIuh0KT9bmLi2rwjikxYodZZ7VWyEYg==
X-Received: by 2002:a6b:6604:0:b0:7de:b279:fb3e with SMTP id a4-20020a6b6604000000b007deb279fb3emr4960746ioc.1.1714619515011;
        Wed, 01 May 2024 20:11:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id s4-20020a056638218400b0048746404167sm5437jaj.17.2024.05.01.20.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 20:11:54 -0700 (PDT)
Message-ID: <929c53e5-257b-4ec0-9af9-9a260ad9d0ad@linuxfoundation.org>
Date: Wed, 1 May 2024 21:11:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/107] 5.4.275-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430103044.655968143@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430103044.655968143@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.275 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.275-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

