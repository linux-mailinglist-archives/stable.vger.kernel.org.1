Return-Path: <stable+bounces-139202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B74AA50FF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A95B188A21A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6AF25B1E3;
	Wed, 30 Apr 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Drj/PTs3"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E3288DA
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028738; cv=none; b=TnhXAPAMJOr3D02k/3ReVTbJzOGeA9KJi1dH1X0KmAQqBNSEDoVaQ0Ds1wx7AHDNZAFwoiuYhEAUXqLOr02M6dUimkcl2FsREoozYG7atUk/xVC0Wph5j7hUZyQaH081Hw8z3DmYoiwkDzyl3EL6jTrjW28gcDl+prkC23VsZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028738; c=relaxed/simple;
	bh=vsv5PKy7raDqzHvOX0Ep59/qaAv2tKKgt5lzO89vjIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHF0WgqM+NooShXUTkOHM/tDx/7NYnwWPYzJyrrJ8sgHgzpf87whUxQlAzxIzKXg4ORIbPLJZRf/+jRZ67XQ66esTRDw/dfRZ8vmZSAKVWNjHBzTy7dmwS1Up0o84ctxr2J2vaPdO/63YaIgqw2BFvfIYa/v6r3Pf5zGKR4xDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Drj/PTs3; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d93deba52fso40905ab.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746028735; x=1746633535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oxFBEyqGTgNk/NkYnmbUallUIhueyR2i9uRq7jDxM8=;
        b=Drj/PTs3+l7WMoyxtnfngC+WE1VG9Xis2WeYNrEA2XLyTn7CeSUVU3FhOSR0J8uxNQ
         7A2x3ZbGPFPkh7zKkKGoITlWjKlSh4F3XAGhiUFwrIoUijHTq1fZh/djGAwBBJgh/ZPA
         EOhAoRr7lBCdrSU/V+Oc7q62e15JnN88PHho8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746028735; x=1746633535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oxFBEyqGTgNk/NkYnmbUallUIhueyR2i9uRq7jDxM8=;
        b=GtNlJNJaDiD2lgoTPXY0CUZ0csfOkXAfeOqoBJualYt8NeSr5LsEQBznXLcrurEdvs
         b1q2SsYp+BuauV+qstX172GvhXGW/iiVIc8FTQWmGtUDorLbM3srkKyESIAFZ6YlDfhD
         H0/jfvh2vuq4edgaeHGdPb0Z2EVMnJ5cVTQYs4WXT3meQFApBRc+ZFMle/2qFOII7rsu
         AOI8fttpd+Pouph+MQnMnSGDqVtQpmt7W/ZlHs9S0c7zKxUtrYkgwRDGjenJ5fry9ePk
         lAQ9/4SHbVwGmB5czRI5B7RtRI//8ywnRE23JZPyFRm459b2+tPXzF8fkL/hpTmHaV/i
         QVug==
X-Forwarded-Encrypted: i=1; AJvYcCUBl4mANqSKBHkKZBCAtbgeUycEj3pbetdOnG79QMqQULZ33L1B9J+Uwr9guE40I04VZKz9Ptw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXD72CCZGHDQlh1PFugVM6U1zuuy/KdXstmU2Oz8S/haLCAwm
	eAhLGnmihM4xK/132KS7rhUlGRfVymbDsC63pVXdAIuwXBcfnEzY9oubb+AHUUM=
X-Gm-Gg: ASbGncvMNWxYBB5vQCkNckTSUDjfvMuawNT3fLy9fImhViKaDATGODlIaAj9x29uNB7
	r2UYw2N4cEJj4fDF1TiBxiaN8dZNyx1qRX6qi6yXvc4DG3AebjrMV2CuCyz2VFXt9GxFmc07Fep
	X413bwG4UYqqeS8kfJJkLujQZ6IgED5FjbZhbRzKXmxOlvsZEANER5wVpF6BwhuwXW0FDrE0eV8
	JiE74z39zYqH4wgUyNc8TYCO7In7fHbpu1p1ZHiYRJP/hN3DdRBqL39q3VOqBdrPCTt5skIXFuR
	qI72r7KtQVllqFsQUbUezxVh4b9GDov3JYTFa6ACpTzDZtz+8Zg=
X-Google-Smtp-Source: AGHT+IG6FTX2nEYxeimfrY7yoxrShI0y64r96IWSWY/xeIKXCYHxTWjWbue3hjv6fR8whb0OHlHN+Q==
X-Received: by 2002:a05:6e02:270a:b0:3d8:20fb:f060 with SMTP id e9e14a558f8ab-3d967fa3a4dmr31584155ab.4.1746028735325;
        Wed, 30 Apr 2025 08:58:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f2a2d32sm8991965ab.1.2025.04.30.08.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 08:58:54 -0700 (PDT)
Message-ID: <c97a7512-a350-4b13-92b4-52a03e2c0992@linuxfoundation.org>
Date: Wed, 30 Apr 2025 09:58:54 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/204] 6.6.89-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 10:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.89 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.89-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

