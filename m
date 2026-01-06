Return-Path: <stable+bounces-206044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F0DCFB4C4
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 23:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95C5F3047AC8
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 22:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF772FB965;
	Tue,  6 Jan 2026 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h34cZq83"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C2941C63
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740138; cv=none; b=DX25fMhhBpK/QKvvXMvXXkqyuvG+mabZ87lxr+FVpFwO48eooOebuQQ5dEU3fF4FLCLdtZy92xnxyIQyYHDBwWnBxQT/69p/6u09OCV2SRjmqh9uwo8r24sVIrnG/8AOFG+jNvVWER3WHF+G9F7/r5HnqcIarKzqnBhjTA4RN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740138; c=relaxed/simple;
	bh=iCMfYaoWFeFSV9Y0pyjpD0RHZifqrHMwZSJd/TScT3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbg4i25PvOKrYCAGnR7MYTYIuuscXCBRyIewWC+VWeLFf8p24Z0d7ICXWwdghjFExVtCjzsf4Rn5wOwcNidvM3d/qb8D+z2wzDDFsad8Q8SIRBhulk9PID0/qV6wY4Uj1RE96mzOi8HeJofxmkuN3eGrFjti91VmxcoQWbG6Khg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h34cZq83; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-450b3f60c31so732219b6e.3
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 14:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767740134; x=1768344934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EegBch+UWSACyeAnsvO43oyJ9/0p41ZTPW+U8w1/Vok=;
        b=h34cZq83j4BrhVhi8fSw2GN87Q9UvMyosfiUJIcCm7gNfRSGrvjzI34ovpOMJiWk1D
         mCGxhna3ik9K8g1CXGKJnF8HsoGh8siEonlM1rYYk6k6oAdiyRgeDvYlJ0nExy9ZuY7o
         vTbJzi8iE4mVaPTLy5WcWyzEBD/+3itOUFqxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767740134; x=1768344934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EegBch+UWSACyeAnsvO43oyJ9/0p41ZTPW+U8w1/Vok=;
        b=KX8FubNsJrLYD3wG8qa1QPIhgCwam6yQ3j8kHtZkD+bSfVY8sWRgDMxXjQDDtlzp3K
         IlNrXaq+BsunCXjWN+ruywAQ6NcJ4FDzS1CJzsCyr9+ymVUhAA+CTNpFOt5a5nB6U6x2
         DRczZd0pXygoKtlRQOmnZkR2nkxyVtAYPMCtpMba8Gsa1egNAZYrTGHqBVFgZH74RoEV
         DTUC+YFWjjeEvnZ8I1w7WGft1tulvlBN3Ba9qLZ1xgAA7PrniP2/rvs2rHROgkrhbzWe
         CoUN/JFWml1bZVfu/exiQMIU9tt06Lf2XdcNj11c6bp/IZLucNgSgDd0Tnxxvw17phyA
         tyyA==
X-Forwarded-Encrypted: i=1; AJvYcCUf7GWRC+16rQntAP8n0A3/gfwA9Y6nWQ/A31R3IJ0RxGu4XslCceAdTDOT0ZBaKyAI0z+e7Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqpvM2TQJpBHD7nI7s4AVYJkkTk0q/JQydOIkX50OiZvCOGRK/
	VCe3M3hdbhcUGECh+IQqtk8UUtABclnptChjdZy4P4WIsgz05dOLwhCKu/0J98Smuyw=
X-Gm-Gg: AY/fxX7a7mGsvVUlMxV8FbnPa/1mgQj2pSnT9+gDPiT0FsA9oqMy9fwXtidd+s0Q1ZC
	wToirbzpwDtbj+YJzrlXFbkjfC5wb527jRtv1tTXfVypKmbWcEliQXzew9O3i5G8OD4cg3m6fL/
	N5GFVio45zpUj20Xmd3dCV1otXw8zWTq2XGc2YadBCAWtF1j+7kj5RMkLsMt8Jp0ZL9b1R8yYL4
	SbgcbLzxwN30yIC5qoSPyjMYxn6bk+iM9pNJokSUxPjFdO17diNPINCKXkl7NaQIFF2eOS8AzEk
	xcj8dd5ol+NvXne6vrqAam9FIDolR1cAym2Tp6Ugvmq1KJLy2XNLbieDel3dyEGWW4B4N6IjqbL
	9lSiJRXvvsQ5fOAUhNR1FgfX4hl7t3OpUByF6DUWt6A/rkLyBXr4zw+MKYLspmysOr7pQJALSr2
	rdUn2/z/7szx2ioQ8wl7bgG2A=
X-Google-Smtp-Source: AGHT+IHaquhJ9jlDTyWBwhE/0CSN8AQ2a6ssqgxNHLwzbVtdcx3wH7bytu1D/nkLFdPudltgI8pLrQ==
X-Received: by 2002:a05:6808:3084:b0:450:d7fb:85c2 with SMTP id 5614622812f47-45a6bd173d1mr354652b6e.19.1767740134568;
        Tue, 06 Jan 2026 14:55:34 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47801d58sm2311308a34.2.2026.01.06.14.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 14:55:34 -0800 (PST)
Message-ID: <2859a466-54af-466f-973e-2d679837a60c@linuxfoundation.org>
Date: Tue, 6 Jan 2026 15:55:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 10:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.4 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Jan 2026 17:04:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

