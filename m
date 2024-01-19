Return-Path: <stable+bounces-12225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530348322B7
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 01:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B04B287C3C
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 00:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5457645;
	Fri, 19 Jan 2024 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AliS7Sjk"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF78EC2
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625068; cv=none; b=WOJXr+sglW8x7lDbuMmhExOTvOK6qJeH46J7EAbgyASprtEnjMJek/VoCO10xitwR7tv58Pjwnst7Egc5pj19ZR9p3EvoVQGrGBl9fXvYvBy16PcYvUVGhyISLoOEN8d+R9gHgS+8yCZ+zB5GXcgJlaaQsMk5XgDMYV469wLAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625068; c=relaxed/simple;
	bh=NhNSIFSj5aUXE+QTTjNv47GccG4WWL8n1fqMzGxB0Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuwormaM88EMsihifxDJlU3054dhGZHlhcNybFMX6fMoRH6MjQyHaGE2Bob1HLIgcXxvU7D6RQSnoe1GRbCW2OPuvIgE8iKIHfn68Ppafa8cqX4qlufqwKqnIvvKPiTxXVWgl8ppYcWzxg5Q+8d9npgmjPElJw+W7bbI8xeMMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AliS7Sjk; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so3932739f.0
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 16:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705625065; x=1706229865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4QJjs3CBTSn4kYRm7kePCBqPYpjZWflZ8aVDGne+Lc=;
        b=AliS7SjkhAj8Gzfj/m7N65r3edfRv239QyPUEbchMNuI/6wb8Zng4y147YJ9Sd3xt7
         QZv16GwYeKFTd8SNpIyCg0vJQK2hYrvAMz8FIwndFLHCqCicFv0zKo5m/F4+ribnxtIx
         eAHyYtJSw0Gk73DSnYmdn7rIF2RTfA0PxL7L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625065; x=1706229865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4QJjs3CBTSn4kYRm7kePCBqPYpjZWflZ8aVDGne+Lc=;
        b=ht8mzJV//JJcKjUEWZEM62iYra+rUL8JmyanAOlb30ymQfmCyxF3uXwzswIYDyvtk3
         ZvmtdlE4TvKfLEDdiceQNH3APt1y9yVjx8X+gni22DyiQ41PPqZ+Pxrf9WmPxEd8cNfi
         KJ7vxPJ8cXQiPm9a6jV8zKDMx0qel4peltiX2aCDP6cT3XTc97g0PiWVie3xOxXgT1/q
         /am3nPKX9CxNJOgan1f78CWLNVVvQEE0ZZVZeq5DL2xG4+Jbt+K1/HlZgQKFTG3suglk
         qIvyfJU5uUivHahMaM7oX9eRwZ5S0EaN1MPT61xhYhl5I8OL8rPrgotJVtH5LNPkPnqc
         LUCw==
X-Gm-Message-State: AOJu0YzxI2k4g+rYJ6sMQ1zF6fA1I5N9JyrWyk+zC89EQYcpaxf0Njmr
	WNp3OVefEvA0Fx2N2xtuapiGRL96mQLOCzd+eYs+DCgDc1CyU4+l0+x6qsQqNp0DUvOmsPq8M4K
	A
X-Google-Smtp-Source: AGHT+IEzKBDhU5ko5vWu4xZJmpYcfFyuo9g09ySkVHfAtQDtjkz4Xi73BJZ5kZmOang3z1mK3rWCLA==
X-Received: by 2002:a05:6602:255b:b0:7be:e080:6869 with SMTP id cg27-20020a056602255b00b007bee0806869mr1123197iob.1.1705625065102;
        Thu, 18 Jan 2024 16:44:25 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l10-20020a056638144a00b0046d18e358b3sm1323950jad.63.2024.01.18.16.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:44:24 -0800 (PST)
Message-ID: <1c27da34-1134-42ae-b6c6-925e6e94e64f@linuxfoundation.org>
Date: Thu, 18 Jan 2024 17:44:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240118104310.892180084@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 03:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.74 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.74-rc1.gz
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

