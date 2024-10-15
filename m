Return-Path: <stable+bounces-86358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C56299EFD9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 16:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3523C1F217A2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C61D5173;
	Tue, 15 Oct 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yl1xxQy0"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0041D5169
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003244; cv=none; b=ig4ztxmPk2I1Lc1n3nmg9j0xe0Y/93TdD7kvqEOegXM5qK46KNVuj+Hy8XKS+nsFLyLOASw0c8ssWPLIvzNv9b4OmtQkFSSw+VQy8B3a1LbHxRltN/+i5QHvWkxNtO911uu7E+bG2MRXQqvDMq/7LOYRtt0Zdmw45NTv2vWISMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003244; c=relaxed/simple;
	bh=9j/iM9ZFOnXJ8Pq4EAuSjpyDlhqwQ5ndLD3SAv/tylQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suhPYt8Y6Omkmta95BsylPr4SNWZwL8unZRnYSttKPdHgLCKgEL9MS+O9B4v0SHD5f22GySxopjyDZypIFjkXOETkudCGJMO+4/33fy1/UpPHkD0TkL3FjB+7N7tldWfPCdvdXHseRwbO57EDg++4wGz1jSdjB1UwQoICa0ilJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yl1xxQy0; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-837ec133784so151155339f.3
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729003242; x=1729608042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dt0BlX7ghZTRqrFsNZjMr0j0wMiPy8jkYnWp/1A16kg=;
        b=Yl1xxQy0jFESj8oH6O3sPxlpCyPv1Ax4uy1984qU/WcuKbUWHwVC/XdXIyqjxllAZ3
         DOgi6JNu+IY+7w37SbEAij/qUiaxLxGlB4qoEa59NXT2H1Xs7gTPdZQhiWk5Ex62Qm9k
         VfqkcdHzbyKEZz+PCB96mVMH0CWKgW5+JC2sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003242; x=1729608042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dt0BlX7ghZTRqrFsNZjMr0j0wMiPy8jkYnWp/1A16kg=;
        b=Ec6M8qpJ4TH/iD6Zqmm4WgX2pJjdnQYqQuA35fdX2eFYUFn0tamH/Rrbycjt32OU9v
         sDSGH8vE0uR6dVub5xmYM10yTpUCE9X2hUad5JwosWdQDWXX8mssKO5gGi3ayR+UcKA/
         yWqf1+wBRA64RjDGqqv3R8idINLsoNDgFEMh4qOvDc7suhljfbZCKs8S9okjoDPdLarT
         1BrnRBQfZzh8RrLa7lsoKp5G1Dj/WX8B12jwrY57zSrFf2fP7/m9Yyl3h7sgBo1E7hz6
         rukvRzf5mtarUvu5/48dfVOZPWqzpGlsw7RMGCH4MjQ9uI9RqDamzM9IQ7z3ISQK1R4u
         jl/g==
X-Forwarded-Encrypted: i=1; AJvYcCXSJ+cXZSWp4uKihfs8HbGwKZPDlkBGctv2CTbL/WXWKK1elgc507ugzQz1aNIC5cen2B5apFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+3aeSjtN9pPZfbT5fvcP46OsZhlOt6OBZ8o4c3pNxdEkOg/H
	iTbVqXAtGhK7a+AyZd9PiCo2NPYdVf6vrPyPcLVS+rEtJijsTDbq4fqO00YIYbjcPn5/jkhsXlm
	E
X-Google-Smtp-Source: AGHT+IE8j3afbFFAJaUzf/DFsIbH2c/+ncqZt9lRW/uO0WSLuyNF5qt3dAKoftbomXfEkEynRLRBBg==
X-Received: by 2002:a92:cda4:0:b0:3a0:98cd:3754 with SMTP id e9e14a558f8ab-3a3b5f237d3mr136176475ab.4.1729003242255;
        Tue, 15 Oct 2024 07:40:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70cd07csm3412505ab.37.2024.10.15.07.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:40:41 -0700 (PDT)
Message-ID: <1a173476-ccdc-4007-adbf-812229520b3d@linuxfoundation.org>
Date: Tue, 15 Oct 2024 08:40:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/798] 6.1.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 08:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.113 release.
> There are 798 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.113-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

