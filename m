Return-Path: <stable+bounces-26831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53A8726F5
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 19:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5881F26036
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B281B95D;
	Tue,  5 Mar 2024 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hqFHVFbb"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB1199BC
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664784; cv=none; b=LQjj5K0tG/nXyaTYylHGvSR/fJzzxyUTuOljJYrMKrVVB4MHIA1lWTxgnarWAz0CO71gdf6av2YtP7jQ3Tmyltr8hv/NkuddeKTLjmPevYEM8ONss6JuEihZWoPgN9+ax9mg10mEW8sfdjg63RP1M+oyaCPancqhzuOKeLtaKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664784; c=relaxed/simple;
	bh=M/226HSU/VUf3qLvN65ic9RPPkGkwgft5YY5sbbm7gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GD9HXQVxOkzrinyo8cyiwpU8JVbuqgt0I8gV5vObnYTSLQ6oBVpVYt+pw2kh95jbTnkNpTjxdZtggMiB3x4om8AJTZ4pAA26i5M5HLcFfBid4L4yksT4M5SMrQTMXkR0cX1g9mqJT/yYr10G9QtM9CzP/AebdLHi+pEk8jNuaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hqFHVFbb; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c840d5aab4so37846639f.0
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709664780; x=1710269580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEpeeM5uDTk2y22FrTqvvuOsQMUYfWSmy4vGTzbuVno=;
        b=hqFHVFbb6LRKiwI5WixhRyE98dhFYLTcGyyctMs6ru6iqluqIZ3JRIJQ9b8JRUIm8q
         YpbFZUd93M4y9ye6TdQXvbgdSRyzmg5ZtkDQbC0Z4Wc/ORW8uAdk99qao8CAEKrh2et2
         dpL0UAuGebAOc/rmLaQBLsO8blCVH4R9WWcIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664780; x=1710269580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEpeeM5uDTk2y22FrTqvvuOsQMUYfWSmy4vGTzbuVno=;
        b=oKJ8YqJy8LIKHxFmRlHvqVQJ+vEcxWXdN4AlSDY4E4AXgbpr+RIFRwVJUuSMT7iBa/
         FwkMMoB3aXPiD0H6HSdG60wdsy/J3tWYV4XjndY28EtHaO967KLzow4w5nItdwvglyZt
         xLtUXj0qrL5SDAuc7qUr4f0/GpBjdzuK1cmMqQaKf3n8o/Ua0xDZDOWM8oSqT30+9qJI
         U/NFm87t0ElJlGisTR+VV5E8xxKJBdqtsW+Fy13sK9VLruTm1V8S9HtV+Ke//lLMuTMF
         Gd38lZgYsBSfZYW5tSDfcT8EC2WTxHIIyWAUsJB1ae4La3p9FgIb4JrzRztNE9hdk8gI
         ItMg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Dzx/zYrhYeMR6VpIUERL7CUni0Ppi3v+exz7M1NBhRsMh32D3okPIaQVg4YmFn9XoNiG47RbPU+4F/YYMqu+pFctW2Y+
X-Gm-Message-State: AOJu0YwWDLnzP44Ijs+1jy1LCTXcUgQUhlIXndtfRK46P7PsbP7NykcM
	QU7Q93q1LxEBFMlsDqEmv9nSxSPijjegOOcCVLe8mg7pTAr/yojjcIWMPDNN/68=
X-Google-Smtp-Source: AGHT+IFbzWXOeIi0fJ2CcuZDZeGAyPP24qF/5v6BY/JvvzLzUHWNTrD8gyMXbXDyIPy+7NnluYrAjg==
X-Received: by 2002:a05:6e02:2164:b0:365:4e45:63ee with SMTP id s4-20020a056e02216400b003654e4563eemr1378458ilv.1.1709664780276;
        Tue, 05 Mar 2024 10:53:00 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b6-20020a029586000000b00473e9bd8308sm3045833jai.124.2024.03.05.10.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 10:52:59 -0800 (PST)
Message-ID: <5e9ca92a-ba9c-45d8-abcf-5bbd37a7546c@linuxfoundation.org>
Date: Tue, 5 Mar 2024 11:52:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 14:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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

