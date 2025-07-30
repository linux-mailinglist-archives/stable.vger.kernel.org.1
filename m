Return-Path: <stable+bounces-165598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F6AB167CF
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 22:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B01AA343F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 20:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15AC21E0BA;
	Wed, 30 Jul 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KpGuxUoP"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18C215191
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908819; cv=none; b=qwOOlO3hnVyTxg9xUITC+FdyWvgVxZNGkICvef9PatRGSm6UkOSON/EzHznN5iOnnDmBXgMxpeK3P9kj8FPF4SeEFqpcAIqxUZLc2tqG65adeW79RXKpQMBwQYYFAHH6eyb0gnxsGfje7v46cEF4Wh7zgZXVJlffG8/3UYZOuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908819; c=relaxed/simple;
	bh=n7aPMwh4cnGZD3nLxV4Huj267B+JgGm5eIqZlxQB+fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOE785MgIyYiQhMGWTFf8qmYVcm5C7Lccno9VyIoT5zRNaBhLzYxeoQIOoMvLua32x/mFBGjkSOiMbQb1bhDSCeiH1Zc3Q6J1DOJ9MHnG//Q9ih37RVJ9lWoar7vI/OtpgasNFlRBG2zRQ7Ysfbg9mGX9RYbp2Ja8WxhvmU9y+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KpGuxUoP; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e40050551bso1529585ab.2
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753908816; x=1754513616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvlseZLHeeF6YAR9S3/qHnVzi0UmrI59s2OOwlGbvPw=;
        b=KpGuxUoPP1rR2e09gHU1YPm3sMW7CzVqp2RT7dhh6zQ0AJy152crVs+Qi0M0Ps5GSg
         iZjmWhbW5fraRSmocoJzbefXtC6QjmRZ9o28hDK/CyOJ1b3o/Kdn3Bqk3ctfinGMR++j
         RJ67hivhvoRbzkhuHXzKBx4rKcgfIpvHhf6ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908816; x=1754513616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvlseZLHeeF6YAR9S3/qHnVzi0UmrI59s2OOwlGbvPw=;
        b=Ve3ueg80hHp+URY4PThRJqxbcO+qqmc1Mh3GWMT5ct8kXA5s1m5w5gqYvbPHBk5/pU
         RwoFyvmTIXSBa63ahGdahvLW0uP+HEDVLdlpROW/q0tpE6X0gmCc+jrpdNAjEqLmjXVj
         B07sCOw5tVWYNfUjqPi9Z95L3BpH39ig8kVebIordxprzc/w9vwxLUGZ1rOkmdXxIq4E
         kBkcAfrYp0FRXU6FI2FiTVBjoPAfruTccB1cW/X5PSnaC+kxikWI4LBbJPUXkC8Igl07
         QgjUT06eUJtOP0eAw4ZHyrAl0HQnO176cEiz5xnpmBvKJDQ4b4dAXkE2gW6JYEV6Atl/
         zhNg==
X-Forwarded-Encrypted: i=1; AJvYcCWRmF4oskU/BfpaF1JpV/NsqMzZcxPxto/tf1X1FgRdmQkZOVRKGFZ9aBnK0UnINlmcx9XbNPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6Wrd+xQ8V0k9Ll/sDAiqVnWxTX77ILepqEbZV34ql5+deKuC
	bgsQ31tI/IE+X8Gwf7R6Qrn9EgV4JiFLudv1qthq1ok+BLjTkvM4MtD1JKSGPsbpsZ8=
X-Gm-Gg: ASbGncv3CRZ6wsXZIxYplddDH00P0uBSjRfrmHQmx05Z69x3GuyzYhOirrUGpmjLLoM
	YDmXC++WxFZuLqapKDCPGQs/wh+d0Aj9RCv5Y8+T05cyTMTtSdStRMQi0/sRTiGFmVxapQBVZWG
	vA0YnP4tS7AtZ7Id47S/JsCGpMsd3TecZfYwExM8rP93yAxCHCu7BKhHu4h1AgoTnBpwX+YVLW0
	O2zB+81AfAEF09u+TfVjHsIFOA7R4O8rnOc8eXVOgHOeG42FkrBN/jfqS0OyGiRmIdgC0dFnvJo
	mFffD+UaXCTtu/Zs1d/kSS/vn6LUF3jL+PYWMm59fxIAwFH5MGp7L89fIX+uwYsSUfLMtbsebkX
	Rw6fMhOe321RWKQb+fmhakclodeol18q8tDOorBZzs0SZ
X-Google-Smtp-Source: AGHT+IHBFCaotfb0CL4mgLRGNZuJ1u9L03txLX5ARtebB/M33t/uep6REz1q37wHqFu6wDRvJxAqNg==
X-Received: by 2002:a05:6e02:216a:b0:3e0:4f66:310a with SMTP id e9e14a558f8ab-3e3f624ff19mr76742445ab.16.1753908815891;
        Wed, 30 Jul 2025 13:53:35 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55da3444sm48655173.80.2025.07.30.13.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 13:53:35 -0700 (PDT)
Message-ID: <4611d075-1db2-46cd-8e93-9d25d27650d3@linuxfoundation.org>
Date: Wed, 30 Jul 2025 14:53:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/117] 6.12.41-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 03:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.41 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.41-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

