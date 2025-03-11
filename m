Return-Path: <stable+bounces-124046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD0DA5CB0C
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736073B8D7D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B177260A2E;
	Tue, 11 Mar 2025 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KybhA1Q8"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A2260395
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711492; cv=none; b=kL5fonJ1h3rPMWU7xhOm/Mwi+s9f+tlARmQ1jvD0kkqSaId5BWG0Vq5myfyf6WMuG/FqM6/+1TKet732/FdpUP1YYZ5cpatc/e3dd/VLEB9Ok21NENWBU3OiHzCpe/QwTd+fOxpUsAHi0VnqdJTTPCsWN61bCN8fyY6xfJl1k9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711492; c=relaxed/simple;
	bh=CFlZUAocSaDCXWGn3dMPc0Nzh3K2elHq0BNPfszI2Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quG0V1pES9ICmcZLqbMwFEAQP9yQbUIOoKB5vOwNnUVeBu7rgYyU/VximOyxLhbUrW39V31JejwAkWLwwXjPkOenF9WkzAlyrshVxXYYFlvSuW7PBPG93e0HZ3uLkUAt5ie7UXnkT/7jVBZK41sGFfnfjsFz6lp059r2mdDX1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KybhA1Q8; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso98123339f.2
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741711489; x=1742316289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrH+kNIJIiWCh3H6rvZdYxZUqPJqXFDTzqMH9zIOUuE=;
        b=KybhA1Q8CjzcqS+1d/wecNEYPoaeHvaDB4CLHsx7Mt8i/PXHOWYytsTsutuu9X587a
         9zUsKEmqI2aaJXMqLp+4aIzzZuY/Z483XnKiuyXVWjEI9JEcByYBW84OMpPCNydrxcbd
         rxeNc+LBDqbzoYDV6BufUTLH2q028cD60sO7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711489; x=1742316289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrH+kNIJIiWCh3H6rvZdYxZUqPJqXFDTzqMH9zIOUuE=;
        b=SMBZbct1Hjtq2WWh2+wrBmwsODc3K9qhfvWgNXEdjfkABeD9hdnh2czLduoAuk8OeE
         6XqIDBufcG+hMRppjYGoLHigQmH59eJJGJ+ENgZp/GQ2gAlgIQ67ryJVnliJzLfrPxXX
         SUgoWhFvuzsPutyyvn/kDlR/U2vReOXh8djpoIgXdlT7P26XMJgLnl5z+9w3cH2eDN4B
         IjR20y+hNaJwb3PbSaE2z6vABBraX8Qww9LD58QalUck8YUni9i5RHwIlYn/11j6gRQ4
         /ERTDcFkSGd901PePUimNN66mRa3SJzMg3zHIEaV+GtMhIzsv9/VwOeBYzfCPToW4yzf
         GsNg==
X-Forwarded-Encrypted: i=1; AJvYcCVCiPbIcLGxOiYZJvZh+PQGtTAN+h3xqE78QIVAHEjUs/NOG52Ud0sjsItbXPfdrp97d/tebYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7x3OeaDFBwVV85dxcHDAJV8GzWqZ1PlOytSwI9RW5tV51i+7C
	b5DJUc7F8w/mF/D874jKICCMQ/DvP8EyGDycfwRaXkn+VHfDyoR60WzCVkYnvlQ=
X-Gm-Gg: ASbGncvA+6UxJaH/WnwP/NMIlNrKpRxZ19BrMFSoJ7jZYz4xc2Y3VOGm1wWSXmsOFxi
	q6sNlYbEJmzax7F8umpszXYRytxre2xG84PQ6cS2mqptZdHEvdlY+ynI6RcvO+eSzlPXUoPwsD8
	qhTVrSPbfKdqATGCCf6iHsg5jl1c73d9hlmvsD6gk7pF0lJHDqoZ0g6/QuJcD10jDDGZ3xFw2RU
	tD/d6mT9SYzbdvdF9eHGHJI1uk8+vIaAZePRnqqjB4spRKjUMKKQES0z/PRF/zLKiDtrDW18bO4
	s6+ivwyOEWD1hh+H/r1S4M0PhCiXqIvltLuMvfgUFm+4Q9eLLCF0ilE=
X-Google-Smtp-Source: AGHT+IHrb2zFlSXoeeuX8IlI/WoFm/acPhdpIFoy6HtCqLdyW+KyMDolqqVQT4wQsO6WnDlvn4+BoQ==
X-Received: by 2002:a05:6602:3e81:b0:85b:5d92:35b4 with SMTP id ca18e2360f4ac-85b5d923763mr831411739f.3.1741711489174;
        Tue, 11 Mar 2025 09:44:49 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f225d0af78sm1882165173.17.2025.03.11.09.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:44:48 -0700 (PDT)
Message-ID: <df71bef3-822d-40b2-870f-ba7ada74580a@linuxfoundation.org>
Date: Tue, 11 Mar 2025 10:44:47 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 11:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

