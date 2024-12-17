Return-Path: <stable+bounces-105059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3679F574C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 21:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44645188EF18
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED321CDA0B;
	Tue, 17 Dec 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAeAu4qJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622113AA41;
	Tue, 17 Dec 2024 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465663; cv=none; b=RnfWAKBsplPqPlTEmeqp2lluJredN5QNMn6UI7++Fxb1Ccf5uDTWNTayxX7yAyJMo3+9fF4t2RrGeZMJ8YGMOMcA9Cq+LNZnGtJnWWS6urtQgHJR37Nohl5XBIsiQnZqdz4o5nuikUTtX9Vpqo9nPznHQCPaDuMzFTJ/MObefoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465663; c=relaxed/simple;
	bh=HMkJ4fMsVv7r/CWgPRS7Bm+bQe3rXt/McE263qqF/rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIGhQhYecjEDfDrAoX/LQWgNLfRyZPY8T9agX8AnJhs9IsjnvJ7po6C3RO7VWmvy+NGukbIu2KEvrPHjGHLTAQyWzMoFtY1ko5wnO5/eLRGPHBIX5HGv2jyDrJIJvD20yXNQD/M5VFw0cs5XaUkezPQq6K5CPzIda8otO3jcGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAeAu4qJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728f28744c5so5319450b3a.1;
        Tue, 17 Dec 2024 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734465661; x=1735070461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v8qQQWKPluifNb2nf93vDBlkdC3+xnnrtcJTnhZcfDc=;
        b=HAeAu4qJz4js363C6AD+VRzpD2DDlUP7SAudmhT3YpP0mpeAheP2mrSQSO6U3yql7t
         I8ht36z/GhgMBOWEMWgRJuSFX1q6J95Zo56mtLhHxgiK5n8DwSO0g4VSSCV0mZeOZYM0
         9DxZ6Cw3Wdinx/O6STx38IOIoz4zQU9vfrqCN/dgSZ/pdqA6KCFKA5Hi6N3BGc39G/z5
         md8QZQW2DtuL0PcLHhtth/f+y7aDblhN8vPfzXIHlULgT31Pd3PR/Ha9IjEeusDHobIN
         UkQGcgfw7RGm5tzuQ31N9LAZggYEWPieC9muQ0muIuncARSG8lbQ8L/NQFX/EmveG4Du
         YgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734465661; x=1735070461;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8qQQWKPluifNb2nf93vDBlkdC3+xnnrtcJTnhZcfDc=;
        b=N9nx2Iw4GsZ+2c58UcmdGXta6w3tVEpT7tRZzQKN3OxXy8o6LCqO3EIyxdb7SeY1/7
         paod+NKqHWsYEJSE9c6GPzRYU5rJK28NYLRBgYNpFSMcKNMqW3R7f0MkI+kYo+29jVpB
         Q4ktRKH4HekgssU3OEDJj0MV8EgxdLoct+mPwTuNwphY9HnxE+jkuumIYDhgLXzKZUnS
         N725ooFL6tZeLD+C4o1CuZGbhXDVUsc0zNScHE5dSXFin0lSmiT2WCoXY2+p8WpbK4h5
         a28fQVSSOSkOg6ywyBffb9nyyunlSTJfFeYfmS5CPp70RUroddVxanukUnslhe3sc7X7
         A2qA==
X-Forwarded-Encrypted: i=1; AJvYcCVHun3G5axmvndTfnZn4kJ+a3upooaRuaHqHqbmTmf+34nG7IvWvqnrozHANBFhqrmrbGSrt8Y9gLTIoG8=@vger.kernel.org, AJvYcCVgrkBtP286BeDf8AQyr8UnCpFf9/KHMsFDr8Kt0HaklfzVxCa1v+DZHXSc5eVSM+d03emnkR0s@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxDF4qukMlc+iT5HDwiI443NOnckagxmqTj3f7Xm9NOKUTzFH
	1VSXUrZBT0MZDQub5ftXuOCrjYTk7vNBJ7QAGaGiynrqxAJgWFIQ
X-Gm-Gg: ASbGncvAI2Nx/NoQRSwgqJQeuHgq8dh9bq5b+m49k6jX38Co1oSyY/Kh8qRc5mQY5EG
	u3WXpMhW4rweBS0tZT8vv+WBxJu14OwE24PPo7m/6mdjuo5pz6zElEhMTcb5XN084TjMHWOga0G
	d7mym3x+QUClwoAeGw3sKh25TlQDqXgsprCOLrpnGc6cva1fuY+DhB3QFdfQhcSyp8xPFpG6p/h
	g0AJPeZHhGkA9uFjWr3Q0yMDvm2atQur5CFMON/wX/5fp/syTUGzWBIXrZ64JuDBmZp+BLbdggk
	cj7KPLRg
X-Google-Smtp-Source: AGHT+IF3F89YGDK686ZzFCeyUwnyfwy6a803+8VqRR6DYv06k7N1sU73s8QDJ3raSbz3dCuD5iHzEQ==
X-Received: by 2002:a05:6a20:7349:b0:1e0:cc8c:acc4 with SMTP id adf61e73a8af0-1e5b48a310bmr439556637.37.1734465661193;
        Tue, 17 Dec 2024 12:01:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5addbf9sm6187306a12.47.2024.12.17.12.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 12:01:00 -0800 (PST)
Message-ID: <6c36f396-fb6c-4cbe-86e2-39b3ce85ffd3@gmail.com>
Date: Tue, 17 Dec 2024 12:00:51 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/109] 6.6.67-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241217170533.329523616@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 09:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.67 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.67-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

evlist.c: In function '__perf_evlist__propagate_maps':
evlist.c:55:21: error: implicit declaration of function 
'perf_cpu_map__is_empty'; did you mean 'perf_cpu_map__empty'? 
[-Werror=implicit-function-declaration]
    55 |                 if (perf_cpu_map__is_empty(evsel->cpus)) {
       |                     ^~~~~~~~~~~~~~~~~~~~~~
       |                     perf_cpu_map__empty
evlist.c:55:21: error: nested extern declaration of 
'perf_cpu_map__is_empty' [-Werror=nested-externs]
cc1: all warnings being treated as errors
make[6]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:98: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/libperf/evlist.o] 
Error 1

this is caused by 74d444cca1eb616912c3ffe4b8a060a7bb192618 ("libperf: 
evlist: Fix --cpu argument on hybrid platform")
--
Florian

