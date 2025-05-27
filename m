Return-Path: <stable+bounces-147888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1522BAC5CCE
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 00:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0315A4A32C0
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D252163B2;
	Tue, 27 May 2025 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TmmbvuLt"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B41FBE8C
	for <stable@vger.kernel.org>; Tue, 27 May 2025 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384081; cv=none; b=dFqCAY39CTMcGak81avM6S9fIdDtFyJ9V+Oh3JEHuBSwy+Yo6YOWlShFE3vgKBaU/ylkP6AVyg5S2+wOFjosIJ8gDO5JJK4l3WFakO6OWCK/4zluaOvkDmQXRlZXDXUTdl2e3+O6s0OiS44JLIkl08zQdPJHwLcsF6JGT1uZQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384081; c=relaxed/simple;
	bh=9udHDpAYAvxKPviZiivuKs3/emxHMcNVOQEErxHRjS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7rNvDBQWQFsWKbRmjxIoKPSyLkBLNJ/8P3K/jBKleCbwbus+5gxAcJMOCSAwTb9tw7KmT6tm/FHr5I5cKePo9BJEIu5DTt9+hWSu4jshspK/yj56VlSEUMtKcoYTfLFVwl3CGEeiNFReu8KxRZsLnXg/kluah7Z3ja29Lwd6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TmmbvuLt; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3dc978d5265so14397435ab.0
        for <stable@vger.kernel.org>; Tue, 27 May 2025 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748384078; x=1748988878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lFjcs9eaUw90jHcgEZEicT+OU2FTsE9C+Uzz54aKOIs=;
        b=TmmbvuLtdXl7o4JRVz2LZ/G2bp64Vclb/7DjFeYJvzFH3QXo0H4dEfEhE6Y4fnExFV
         Wj0FGZk9MzlBL+I1oyf+qw+GXXsCH7sWvJvaaJy5Wa45ugwbulEJ/D3b/RqwTRxcDmhA
         +vLqzEtkniBdcboC7IiKmslBbHLLYPAWROTpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748384078; x=1748988878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFjcs9eaUw90jHcgEZEicT+OU2FTsE9C+Uzz54aKOIs=;
        b=mECi+OYUpmQm2vgVp3aXyUjS07C2otfOVd55DGlCZ5esaOpAVqsmwWm+GTqH4XMHWo
         OnHWtYNVY54QEXXYdAwygSmqiiGCFNg7AU1fhfQJFegoTSej95Gz7hn021ipIE3z8Xh1
         wYhEwp40oBgu3f/IpWm7E/yOThC2pooLDextXNcA76cMcy6hnxw7aRxOp3VBnmbkwsWH
         J7i+27UtqFu4rdosjK/ldmciH9JF6uneMQ8zybSUJEEbR56qBJM08hixafIAkR0EnAb2
         l+cBfidCTxY7I16hKM1Tw+UbxXYPzLNOLvCdnDRdGEUEbfWLSgOyh9NSaq5tUu1gwQAK
         t0kw==
X-Forwarded-Encrypted: i=1; AJvYcCUscZIOlWC22s/mjldgwrWgEIZs7M0M1hiv/k1UiRBJiejY7ZwsbQGpGOA+xpFcm6b5LEPKz88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoh6O4LzmB9gz1/JNq3S0DZqOloUv2VOLEzpCl9aPz8kVy1HOp
	CNfClY04PIWN/0uThoPhxBTpV41V6ZfLs9PnCVB4BE/C6z4aNiAm3NbVVZZcvdPeb70=
X-Gm-Gg: ASbGnctYMNZfvJRfYzoKXAsxPlSsmmrRDHydrvVY0i0iFtArdldkB0mETKA54FWtZ+y
	w5Ww7FUNx9oB2kIcP5tuCDGNNkXbF7I0HpKi/sKeG2qk7XF/APOty2CbqmoHIRPik8Eb+sOS0y1
	65bVTk4mFVPpFnUKpnvNebwoqm2/uTnvmfn5ebAbsSqHDtZOFXFv4W+ax7nju+J8JR0P2geFAQq
	PILmJqPryLXv4P3tKXfFe5M7FENzfhVg2PUfnTzNM8hvRS4Z0tetNNCkcNzBIANrkx2/dgO7Xcl
	4qlhCTbeHxYBLhk5ZVGTm4z7WrDKMywkg+slm6j7moWiRh7wdu77t4VNnFLrvMw5i67UHGZK
X-Google-Smtp-Source: AGHT+IE7r/xzWEX6isdmF1z1Xc3VKhaKMmnxHU3LTROHn0/Zm9/kosE8qJWqlOrrf4zs/FMpG2JziA==
X-Received: by 2002:a05:6e02:1488:b0:3dc:8746:962b with SMTP id e9e14a558f8ab-3dc9b6e58d3mr143356275ab.15.1748384078310;
        Tue, 27 May 2025 15:14:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd89b833a5sm635645ab.23.2025.05.27.15.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 15:14:37 -0700 (PDT)
Message-ID: <94de490a-3cf3-44f1-aab3-32309725725f@linuxfoundation.org>
Date: Tue, 27 May 2025 16:14:36 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/783] 6.14.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 10:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.9 release.
> There are 783 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

