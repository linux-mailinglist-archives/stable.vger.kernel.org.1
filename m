Return-Path: <stable+bounces-184037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7224BCEAFF
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 00:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C44794E25BA
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 22:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A12749CA;
	Fri, 10 Oct 2025 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D9sC882M"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D732749EA
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134849; cv=none; b=exMOzWubeFiZwf1VvTv1QvdUHvZyVKaXjwG3XAOu32Hfhy7+lT9EfWAALH4RTfX/jsJUrOae2sA2du3tCBbdz4mz266x9kSTb54zDYjxdv96XnlAzVr2mhMA3RN2/gPTS2rJ0WWFbnEQE1H4BZFBUYzoPh/GUDV5wVVSDjadQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134849; c=relaxed/simple;
	bh=cFf5WMYj7i8FlQb17nvjOopoXo8xhjRrXfWeuIY4meg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYX96BjEd10FIpwp5xHK2v+4q/X1y7cvTuQeCBDZEEJHAfpxPIiOBFuDE5DIjlMtIIBJz9KfP/dRNtWLPAP3R9vbJ0DETVYMKFdp40YTe7jHrtIRnP6wDKiYnaNJZUCdii1BauLSN7Nm2IiaZ8xyqHF44UhldNGVVLctaEhIUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D9sC882M; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-91f6ccdbfc8so127791439f.1
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760134846; x=1760739646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcgyS5h12h/YMXurt2BySXwQEIYv+y3F4YEj1VF0AY8=;
        b=D9sC882MTZnZ+9pIzWh7OdKgYwuVNJ5Yl894tmhvJdvtOK5Imug51+yRwuTNc5M213
         8/8YE5e4iRB7y/0AZkrgWc+v/soATFd1JnE+DYWw4L/8U5Sxpk/LX5iDvGLDLpTWOQE1
         z5qt0Zc9/ddEBxAvNroxW7PEI2Xqojb6i3C3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134846; x=1760739646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcgyS5h12h/YMXurt2BySXwQEIYv+y3F4YEj1VF0AY8=;
        b=iK8uiS1hioc7Y+dMYCG2pIhj3HsWrTfcg9Fy3/GG57UypbqIlEHyOqx4vnWcrToDp8
         /+BghkJoMUKAaMLRBKfIIiG0FqMGFT5W/5befNr9oUoyjbgcZURHpPKJMUFLvUCEfv8s
         r5Nh0hCRCc+5PFfGrfQji9hrG0cd6z3GfFxC1antjBkIqMA7jKiaBlvqk3qjguxAuxq5
         xFAFeBl8/kgk9OG6TgeXm9n+0DrIaU8s49GBfd3gPxCYqLcvxviZZFiDQiAE6PevWywx
         0OGu3q7IXf6pG9CQQvZc5DCpokl3LqnuK9Y5a/q5m3yqU5IDjRg/3YrTA4LKXcKWKWFR
         q2NA==
X-Forwarded-Encrypted: i=1; AJvYcCWOaHBeUfKgHCgKxAnlSTcehEHoUJ1Np3S43gQdIut2oP2EuUvYeqos4UY4OsDVHZuzBbhl4GU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jaWGiQ6ePnTOgheFnCb5LWlTwMUoVOGHBOxmn63w1emM/fqm
	wxA6f4iyMQj1snd+KOBJCZUoBGYRD2rwHg81qO8syyTTsTz6906IHvNIcwhr0b1NF2k=
X-Gm-Gg: ASbGncvifuY3imag4X/NcsrL6TYr6C5VJoUoZP6mqBojr1rrqh8ZPJ7tUicvHzDWQpA
	woNwgdhg8tyA8V8loEER1UJWGeELAjYhNFQ8r6sWXkY4OMYpyimgC5Hd+uQdGoleXTYwh8oqvR+
	XNi10SFMtAJexTTutVFhM3zjpmYvf3JTaqnJ8f2PSkOuMvYNVVACDFH5Svez2K8N4gtuKz6QIUU
	nQ9qiRPzKe0qzUoXHchjnU2z0UI+sOR6s0UURz2pghSj4z21MFoCJdeaSJme0FT7zTYY0D7xWAP
	03lc9BdT+bu8gDP5upS3Cx8nfB9pUQaw/X4gFYcLRpEvo9f/rPtryFDwkCnj6scSSKOdo48bwvC
	ChtDlw89A49KuVmdD0L9RvDdlxflN6I8u9ezn8rlOoZqGUwdU7CGVew==
X-Google-Smtp-Source: AGHT+IEzkaLyZxfVHWfPQPq+ejARtvPQr645Z5Tu8T35RonlMZrPGBKctzylzQITvc64Ns8COdYcqw==
X-Received: by 2002:a92:c248:0:b0:42f:9353:c7bc with SMTP id e9e14a558f8ab-42f9353c88dmr107126965ab.6.1760134845664;
        Fri, 10 Oct 2025 15:20:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49553esm1299727173.15.2025.10.10.15.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 15:20:45 -0700 (PDT)
Message-ID: <10eb6d94-5655-4e8f-9b2b-728d14e91e7d@linuxfoundation.org>
Date: Fri, 10 Oct 2025 16:20:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 00/41] 6.16.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251010131333.420766773@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251010131333.420766773@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 07:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

