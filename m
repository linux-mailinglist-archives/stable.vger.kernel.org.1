Return-Path: <stable+bounces-185703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A90BDAB8E
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 18:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DD7402D2E
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B1A304BB2;
	Tue, 14 Oct 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pz016Vad"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33022877E3
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461111; cv=none; b=vFIZ/mWhJ39FDMcgn/b3r9R0ml0zWb4rjl5OJGVJnm2Kio0FsYtY3xz09ZHHjlIqPDG0dvmxt/dFOPzR12GDV2Wy80sWv946IZ/Db2YHMK5LGR9MQDjFMKxzqk/CVcmtF3y/DSFm2Rwcgqakq069wBSFfg87ZatETsDABYwUMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461111; c=relaxed/simple;
	bh=YsyUZHgi1wpE/vvikQRglq+UzixFkapYZ/q1X/Cvgvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrDoKMuj674RJL5GWsV9lWVFVZRqNMzeWLbce8Uh8Wm7kxCy4YB+0rHntCdFjPrTULov21nK2aUFAizU9Z9XvCtxTxuxD3HipASi2jScn5Ht+ArdzI9pB3n7MHO5cbhsVustRE36VtYudwIyPCX4IsIgxbly4PwjlGupftWKdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pz016Vad; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-90a0b3ddebeso228357039f.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760461109; x=1761065909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uv1jmh2eVmOSopdUqtY+w8Wv8v5i6enZZ9ZLD535XmM=;
        b=Pz016VadKeqX6h0q61li9LvHotGJ5c8iwMK0L7/J7LkMBtb5OgWmJBNDaOiRJDhJz9
         BVFaJ5euH7T1cEWcASANOmCLQamYIOgZSAHVxBWmuw/x3gzdh8nktjdjOb2DiOqTYkNg
         puoCRzlTrMsc0TWaZThOQwHdFIMiUWb3KGqvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760461109; x=1761065909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv1jmh2eVmOSopdUqtY+w8Wv8v5i6enZZ9ZLD535XmM=;
        b=Cf2W+jfqxg3yP+PC9pSu4Zd6FE4H3+4aw9oOm/8aZ2YMqBZMDK17/QVuseziiRZBQJ
         FNdYLCvtBurCTo+plfVCq4R+X7RHToovnf+iKun9BxN7uf20XaZO0uyFavMlnNHEQUqn
         y+i+YQVlT9a3N2YmRCuaYKRq+6N2uJMce7qHsWzjwVn9kXpf2v7MyyMi1v8wrRpXUzjH
         VBE7DYzdvBKirnSTTpFUcaqQmNAUl7Rvl8OcwRX1njTgePTGpRg7+MIupJ4Wb7LggGCt
         jWNzUfdyF4ER6UmAz+GzmYEwctfOHTN3r4XLeJm0uzOTaZp/Ct6mM1RwYmQKcMkIAuDj
         8Mig==
X-Forwarded-Encrypted: i=1; AJvYcCVmy4mOp0sXqIRGAYBxZScC/dIrmebA+d6Uue86JL/Cl65Pbr7z5YiXqbQxUGvnuIEbtnA7n5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrvkFyOhf3fpUN6UisRwFvwbS9ztsa5bCySav0FzbPUyhjNeJ
	tFHy6/1t7i4eusU28BzIr/AsRnOHYGk5i2/TiiXtpLFvtCs/yarZqtfaGLVSNazQ+4Q=
X-Gm-Gg: ASbGncsP7DmRj3lP+sSGhjIUufFuOpjsn60r75Yz2J9JzHPAfHV4H1lFGwzUAxu6cBu
	JZqzELNqwNONE1jmLcLJ/STcZtG8l7DScKvzQbQ1/9k3ATE5HC5pOod7PBenXWiTPggE/BdoWR7
	K7ovf63jaX7lxE2xVKzLm+661r8EHTp2UtneCz5QGq1ZXCKameKXUMJKqQ4D792WUyiHMFImPL7
	pb/UoJ+Ys/9v5j2gjSLQMxY7bPrnn2SUE15QDvfeK2WP9/EHFzo7FwmUi3pUvbrfkzd/Bh9m1gT
	LLowOGGCm386zCG5D6kNEx2z+y9yQbPvWhDc/UHzLNMEo9Aje7JEQb+y7UZfjURUNf0GmJCKVwJ
	w8ssGbGIph4gVjieCfF7ciFqHxlSbHqMBaZb1Gl5yEjbHdBjDp7/ypEfzrdTVdyt9Ob8swyRRvj
	k=
X-Google-Smtp-Source: AGHT+IEpt/iipPZMrqhw1wAspnajPgF214RYw1OdoUghqLh/7sXAtLGEGZrEJbe94Pt4al96RJkdQg==
X-Received: by 2002:a05:6602:29d2:b0:8a6:e722:a9e8 with SMTP id ca18e2360f4ac-93bd189ad24mr3241436639f.6.1760461108974;
        Tue, 14 Oct 2025 09:58:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e25a63c81sm487119339f.18.2025.10.14.09.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:58:28 -0700 (PDT)
Message-ID: <1263d6cd-f9a8-4558-9c59-57f9b5503473@linuxfoundation.org>
Date: Tue, 14 Oct 2025 10:58:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 08:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

