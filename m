Return-Path: <stable+bounces-26837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F7A87274C
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 20:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF22A1F25BB0
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCC824A1D;
	Tue,  5 Mar 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M5uE2VcX"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1E22EF2
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665775; cv=none; b=itrHcd0lGaZ1waYskKoYO94fWnMNmKr37tNxznYNxG97ar+Hlcfk/1hcclJbHKOIGWTILKD4SQpEY5UjMFNLy4iL6xRUGooqWZzZ8ToxdWW3CN4La/eYo2v+LS0mdBi1vOGBEwlBbJ3oPIrFj75gFoDTuGVXx/HEcsHl5oJlUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665775; c=relaxed/simple;
	bh=OLtQO8+KteJEjf7/KV4xIpCdQnmltnmQvPa+hIMVVRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8HzyyR3sSNRyWF+fr8vQGbiX32qW0iddkgZsaqxa0oXRWSoH3yxiLgcmDCS/858t/Tl9gbwyRkxb9rhbPv2MjwhXKEt6RUCtVdS969cY2eyXtumi/ApYWVfKrkO5g5H9KuqIxEF36W6bCWE0BM7zpVJ5iuZtgbRHgjdn2cjFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M5uE2VcX; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3652ab8766cso1516125ab.0
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 11:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709665773; x=1710270573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJuPfjX2KomvvPn8gzvHjvJi2W9ezL1RcJ/6vVRMjo8=;
        b=M5uE2VcXM/s0L2PdW7exWooeaC2WUOcXD+JYHBUj+g/VmMRnyrSDQ7eNTjPFEZV2lY
         mYoOFXWqyZvPS6QZrAhsWuoCh3J9uRq2/MLCtGnjbLG5zUR+QoYTLvOjsILfzS3i61p4
         1aWf7ioDjunlmD3muTbhOnoDgLT3chrl6rr/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665773; x=1710270573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJuPfjX2KomvvPn8gzvHjvJi2W9ezL1RcJ/6vVRMjo8=;
        b=LP3aDnMBOn9MNlFq1XKcEOPuRqvLHwnz9pUVWfpdN2ruQ7kSq3cHKXFI/kpMasrdaH
         9wlVP3vR/jstWs0JBaiH0rmWPZBum/qGuEdEXeFYMxHI/GCNpCLiQTb1piNwYsXXhSh1
         JkFuzBqbwc3Phle/dyFv5wQBEAXko8gQGVzxEHjQKmVJ/KicvqZbwoFXg9zmav9jwUlb
         OWzol8GU6sJmUl78ffQJHi0zNOOoP+tpyf40MlNQjCGvqOkZOY3bb6ntfKnrZfPK7H7m
         p+tL0CIBWW9A5SrUsYt24PqElyy6n3D6Mtf5wgiL7AxJtvtO1tFB1AJLRsbETZeeflJr
         988w==
X-Forwarded-Encrypted: i=1; AJvYcCX0aGE2BGNsyVWXKRcQO24VhgGnUcI3EFj/nHpUXAMW2O+kwjFBE/Apo05ql6IFF7ByCsfq8uSr2Wy9cWl5SrzLxhhZ2RkN
X-Gm-Message-State: AOJu0YwRBP0KmE+fsEhHLzA8E0e+MsZT405ULybwFD8C8fo1u6zJAnJJ
	0u+XeaAj5eWZJ2PMw93sRMsjkDukNjdG7SdHJ1emdhR43HgyrY78oQdhtFJvd28=
X-Google-Smtp-Source: AGHT+IGqFvA7SmKFO2T1Afyh1LJHj/ldgmzfKenQlB1sNl7QSU6q8kGFy677aTOXGAmdzhHKp5I7AA==
X-Received: by 2002:a05:6e02:152b:b0:365:a792:3749 with SMTP id i11-20020a056e02152b00b00365a7923749mr1295968ilu.3.1709665772847;
        Tue, 05 Mar 2024 11:09:32 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m7-20020a056e020de700b00363909191b8sm3190492ilj.39.2024.03.05.11.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:09:32 -0800 (PST)
Message-ID: <1200497d-5f96-4974-b612-550f9e03d9ce@linuxfoundation.org>
Date: Tue, 5 Mar 2024 12:09:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/16] 4.19.309-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240304211534.328737119@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240304211534.328737119@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 14:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.309 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.309-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

