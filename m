Return-Path: <stable+bounces-114450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FFDA2DEBE
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5851B1885175
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4920616ABC6;
	Sun,  9 Feb 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrYMe44G"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3E1CAA96;
	Sun,  9 Feb 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739114379; cv=none; b=CVNSev4+ses+92leWLdvtl0CrPABc8Dss9I2zd0QQCn7xQGW2Fe2WQkYApsiDliqxXmGHNpSCRedtet0K0OfYMdsnWj0Qe7TVULLa5gjv0pds+hR4oYIQB21djVfzk6IQyZdY0P4R0bJRz77nel8YKcK0uYyLovqgTu0aH6wnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739114379; c=relaxed/simple;
	bh=d6Yc9vG06MVzaqFIsQcnOkwaNftqHxdlr+Byi/9WRkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrJAGRq7I6J3uR+XdpHC7zjRb76KdgR4tj8Qc8iqMC729dEmu21VTTzlkYB4cNd4yXZeEB18+DEHAtlynsDtwaTNk3LqKRtjBEHg6M7/65KdrYpOmdpKg4aRlNgej7jC1+DmFkKDhMCM3HUne7bGF7DjXDz4l7ROrCwF6aWF5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrYMe44G; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa286ea7e8so3100750a91.2;
        Sun, 09 Feb 2025 07:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739114377; x=1739719177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H0kFB/AM6nrvBijHVHA2RNVeDvzzsMFygDBwgZ89k28=;
        b=LrYMe44GVAjXoBLdTLDTrwlH1LxuI3f7eL0kyIYjpCkzcHF6nn4EbiSvz9rQ1gZ99N
         GKtpqL1l1DofosHusU0ZN7MhHA7R5PcfnWHQDQUIqrOtCO5S3fPwmVScoEicqdAUc/0l
         vsIPiLvlK63rDP1DQw/qlc2dRGMWA80G3QCyhATOTggi1ETCTt9knzd87/wqnN2u/Rb9
         wbPhkAAgy2BI4EDIdoDy5qaesre5F0IezNIcXb+CNp/AuKw7n3Kjqxn6uW6bYDK/V72n
         qf4M3u4qAHMVJ5iI5QCd43l6yrlHAexX9xN+qiAg7Fo+D27HstwG9QRzDOaEnPE6dC94
         LtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739114377; x=1739719177;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0kFB/AM6nrvBijHVHA2RNVeDvzzsMFygDBwgZ89k28=;
        b=JWwxIrgmGOoLneS2/BpEiIQoHmyWRFB+Dx8yYz0q8TwLojBduvaIss2TzdfK9CaVKd
         Jciw0bNF9GDYhQT6Z8z6Rg6iEN5Un8LIoVxQnT/APiV1DeYue6mahU96AphXG+X5mrQ5
         OBcDArqAD8bGHQDqK+FiaEGaLaFZvnQ63H5831Bpy9ayT4kn9gdRZaaI7fmH/yJXJVNG
         ZQfV1JJoQieK2H46Zp7rPMPbkKI3uYyYIrt9m8XC3zVHI+2TymI7+iwZoWN1t4ChiXWB
         NU3TzmVIZf9fACOfdThjRx1l7LrjymfAzWrlkq138iRaszmF9+3yW9MF1V93/jaNaXzk
         2Ejg==
X-Forwarded-Encrypted: i=1; AJvYcCUNHfytd9iQq/BYRVW5I7If7/jhw33o8WrFtP5TC+5xUlYgC5qQErt8mHcTAHKTx5cbKd1HhwgCErs1uuM=@vger.kernel.org, AJvYcCVDZKZd6hhT/fTtdEeIsea87BXsqXTjZshHgAj8tLIMbFc06YPdzGHfMJviVqPXSUvVxImpqm4z@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJM/O8bTUtjn3O6KkxI9pRPJsDFGh8o4mwVOJBAxksZYdp77D
	O6uaFHjawMMVv0X8yW1CFycgtowxa9TiMlOF0SRvdclJxj4g45pH
X-Gm-Gg: ASbGnculJ7FRLxxaKyQRP4Tj69swNoQdeMFHi5Wek2B9wRrKKmq3CsGWscPtyrq5bWy
	TPjMRsKNYx5xcWIV6WxG2A/rVMRyfSUffn7W1XlO/1r2TgBzuexV1KkHAJwhF9upgpecdhwWAFG
	RmTb2H/3EyYd8MUAd2n9aEQibGfDKehRBql/NpePxgTjItvBKVdaeHF1dHuQXaDFez8fqUQc/g1
	cq2f/E5lgGPLABdeRsdJYaufQJ2G3GPcNMh9R0STZq2I27e5zT9LhvkerR8Kd/YymkuJWPxipuo
	zzBlOjxWmu028Kf90hfLxzlmyH75K3FmNmU93lrLWrz7Ueu8c8+TpQcWF0HRs/EJ
X-Google-Smtp-Source: AGHT+IE3rcJTBfe0mDzdErfEWiAbrAvsjk7fjG417Oc03icXEeES8DkN3PHOs5uoCckxKo7L3TRKww==
X-Received: by 2002:a17:90a:d40d:b0:2ee:e158:125b with SMTP id 98e67ed59e1d1-2fa242d93f4mr12975106a91.26.1739114376595;
        Sun, 09 Feb 2025 07:19:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368797c8sm61314945ad.159.2025.02.09.07.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 07:19:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cd10a924-ae65-4b02-aea2-e629947ca7a3@roeck-us.net>
Date: Sun, 9 Feb 2025 07:19:33 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
References: <20250206155234.095034647@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250206155234.095034647@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/25 08:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.76 release.
> There are 389 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Feb 2025 15:51:12 +0000.
> Anything received after that time might be too late.
> 
[ ... ]

> Hongbo Li <lihongbo22@huawei.com>
>      hostfs: fix the host directory parse when mounting.

This patch results in:

Building um:defconfig ... failed
--------------
Error log:
fs/hostfs/hostfs_kern.c:972:9: error: implicit declaration of function 'fsparam_string_empty'; did you mean 'fsparam_string'? [-Werror=implicit-function-declaration]
   972 |         fsparam_string_empty("hostfs",          Opt_hostfs),

because fsparam_string_empty() is not declared globally in v6.6.y.

The patch declaring it is 7b30851a70645 ("fs_parser: move fsparam_string_empty()
helper into header"). Applying that patch on top of 6.6.76 fixes the problem.

The problem only affects "um" builds since hostfs (CONFIG_HOSTFS) is only available
and used there. Oddly enough, the patch breaks the build of this file instead of
fixing the problem it claims to fix, and it looks like no one noticed.
On top of that, "hostfs: convert hostfs to use the new mount API" was obviously
not tested. It looks like a substantial change which would definitely warrant
testing when backported.

That makes me wonder: Should I stop build testing "um" images in older kernels ?

Thanks,
Guenter


