Return-Path: <stable+bounces-25393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800F886B530
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA76285C5E
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08341EA7D;
	Wed, 28 Feb 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XxkY+JPI"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040886EEE2
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138493; cv=none; b=hxmtWBqqvl9KtjwZBcLU5oG6UACWztn1A3PHBLSVVBSIrw7rLsp7VM+xX2oqZAdyPP43VY9+4Frp2ZVBept/H5l8+BhI6W+FRh+kBWydwLAd3GZ/HBD0Q38VWiW+fomkmnBh6hYyg2o4SYRCNI9ikZNwsH89OWlH1YMYZxY9b7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138493; c=relaxed/simple;
	bh=TMSEQ1DwvaNLQs2sR+09rtomP5hVhyZrbPg6TZDQrZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOXO3ygBeBUPQ6Zfugit8JndLMv/bMf/vZOJGTF3c2+AlvwtDfuskq3gIfcrHtvza3ZjPu+PJ/OAOAfmlQY4ej8e0sl3y/BjHl3FrQpMY1yRllFW67k1umDgRIFgqRxW1kdhNpxNKG7SAIck6bAQeTU4LCEXwDOq1APoQSk+Gyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XxkY+JPI; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-365c0dfc769so415045ab.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709138491; x=1709743291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsnH6cWddi0m8DzE0iTefNtxyP9czfqdJz+Tpy09Cf0=;
        b=XxkY+JPIcGAwbM2CSs7gqNepHXxxR07ydCpRMKsgJsMYbKGVpICOktVjmTYwsYtzcd
         NoDfwjfv6i8ilmZGpuZKEtZTJ5yJdor5KfVqIM9HtVbIZcBD+1JIT6/CYuvsBMsF/25u
         gA6ipBAdgbSteNbxeNAzyAeWSqkNzIfUWZ7x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138491; x=1709743291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsnH6cWddi0m8DzE0iTefNtxyP9czfqdJz+Tpy09Cf0=;
        b=jWv66y15gzqNcqDy/TxA8QOHodbxOq5iYxpmZI/IuRZWHxmqnKDHrtOZxHHQJFB31n
         431SGYEMSGgG8NCbzhgCCLS9IfH7vgnDohi5ayeqIcVWEN+WjQNIG1IiYDeXPnsyw49O
         ho1HAc3gkxIWXC1Trn4PJ0zztHbOsyED8DkZ/G4iCh2IOEYdKl7w56HaMDjIAs0zKbz+
         fk/iNStCJdIJivwSLgc22Xo0fIDCnrnIfU01WFiUJ93bjP9FVptK5vlkNozG9BvIxhNj
         tENptEZCDoE9Yj/kF4GzB+tq1WABVorHVtrNpaXJx8U8l+lhWTTsxTDdkThiisvgLEH7
         uT1A==
X-Forwarded-Encrypted: i=1; AJvYcCV5Ei7rroYrqmLeW+L+sqORyEDKSIqZZZQfeBh0cL1YhgJaoRu2O6BrZCd3wWAMiA9gu1KJSOlcRUQz3nZHFzCksQD6uw5K
X-Gm-Message-State: AOJu0Yz3RgE+ny4YIsOcE1yiFY8dccETbARIZ/Auj7Hfe8fkC83qPAwT
	P2Zx+xkfiQMHhHPv9l6OOka+H88gteSwloELurFQEkeAYCafg6tpwwbIZ5yZr1U=
X-Google-Smtp-Source: AGHT+IFimdqecE4SJGAfQoDywQAZJJvabdZpvtekbx7ZJni0NQBheGQk47VQD7g+bEax4Ag+pN+ZUA==
X-Received: by 2002:a05:6e02:1d86:b0:363:b545:3a97 with SMTP id h6-20020a056e021d8600b00363b5453a97mr12995175ila.0.1709138491242;
        Wed, 28 Feb 2024 08:41:31 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bs17-20020a056e02241100b003642400c96bsm2891272ilb.63.2024.02.28.08.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:41:30 -0800 (PST)
Message-ID: <5f248be8-0c93-4656-8ebf-e9d29fb36f09@linuxfoundation.org>
Date: Wed, 28 Feb 2024 09:41:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/195] 6.1.80-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.80 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.80-rc1.gz
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

