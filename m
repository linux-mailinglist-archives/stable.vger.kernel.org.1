Return-Path: <stable+bounces-150603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A0ACB9B6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067DC7A81C0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA891224893;
	Mon,  2 Jun 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRPpRUzk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D832236E8;
	Mon,  2 Jun 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748882277; cv=none; b=uF9kPlM1et9jrnFb9fjVkD2B9o7Nfqmyv/gxTcMBoBc7YoRl6Y6vsqwI4LsqlkRgyJfAusWFnCnQ+pRWyFCx9CBFjvR6IwK+dRsGy2XHFmHF5f4KVS/g1bxJztOhkKCBygO1NZVG9lzTstorT6pGPMEOpYnCSBNiU4ctlUVJnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748882277; c=relaxed/simple;
	bh=gDw36C9JJ84sojUew6KOpDxduP4kIIttVjTpDEC1/mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8tQ9K7yUP932wBh0b5FY0NEM47H9xuuBuMAvCCm6lQwCE1Jzl4GpQ0nK3LQExAIvlXGs8VT/JJeUtq7NnP9YKcD7kYygDQOsLJPgr5FlosdZYaL+EZHz5hIp0WW6wPOe3Myv0wASHtjE2nrQp0GbpW6a8+DRnzFmRKXF78pvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRPpRUzk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33677183so36524515ad.2;
        Mon, 02 Jun 2025 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748882275; x=1749487075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MmXw2l8FMIf0uGzWa/3J8IzCYl0tCLz5lsdHJPea0V8=;
        b=mRPpRUzkenmQ43aOTNuQKSWeN+hNb4zxh038gU3pcr4k9Zpx1LOMDPZFswiCd9T5na
         8fvzMVrjd6WA54+waEcnQ9ZyeFNCup/uNfwL5DwbBQtQV+xRRF7J+e2Zt5Q67pbfni9s
         UD5gYg/CMTEg5yV9FZm3kvUX5ReZ0vRZcHUGcLgJY5Yfa1vCHT2QLuGJsQVTmunTH5Xl
         jwq7Spp42PjO7e4KsQ0sFcA4YTRqJeqNnDdddIQfkkH7vLRwLCYsmz5zQTv2hG6ZdBRs
         UkuRKOrrVMNFe2mrcaz7eiOvyyyiXR3ik2JAYiOC5cqq7KAYI6SOjJn+0Pww0Jom0FV2
         JEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748882275; x=1749487075;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmXw2l8FMIf0uGzWa/3J8IzCYl0tCLz5lsdHJPea0V8=;
        b=hhASc5N0/tcklMOQM9eE8HrXYhzSQP3Y6YOX5hMdYYMJ03jnqb7kVSESIujsrVAUuQ
         LOHkxcChUTNiGJB2XU55s2fRQi+AxPfNiGj8wROPL23rThsjtcB4xHkbh7RvXA/EyMD0
         KWiYbpFPok1Fy9HDWmMxfWQ6Drs0qe6Uv6OxS0k5Maq1EWUIg4d03GZfUCkh1q3QGZnG
         cxqkYvixBhHJu+IzDgeyfurya/MtnwWpM1g6YcZ+DnLStPUwU6iIxtjv8OgzQzXBD9Zd
         Wdm6L4uYPZBf49y/VCTQGRoNeJ+imw0KdldGioqXByMMsj95JxDgPHOabF0PrrHgKVa6
         annQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMFz/LkiSh4G/V33TCBactGZVVEIqTngK5Vi8jNn+BCzk0egHevSMTfoJBof/j/N3QKfcMZLd3@vger.kernel.org, AJvYcCWO9+44ZGI2AnhumBeIVIe78PRUDpTz9M+bG/gl4ObbH0gNjZh4fQobd/Mmpl+8WzoCfuNrnegWMx/p9Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdlWBn3ynY7ZTwWsXiZ+eDObzH5qVQ1BFUIpieJAa3xPbj9wDq
	2+ueL3O+WKh4mtN+MOdmzog/C0bd1K7Bp8KJnsp352kuqWYckvOCk7HC
X-Gm-Gg: ASbGncsYcgZEwrf00VrscK88NmELXpwRvyCNDaqEAm4sSwHkY2pQth+CGP3H96wbTUu
	WnLtmPE1BUxS7wTjHdGGd17oav9O0sVUkHLHCzUgvPtds9/YKf6VhTFvu+v2ucFiCn6YEsCXNvG
	pUBgJdhqy55WpHFbtxparHp5/u5ClakTGO3K4JB0Z4l1g9u71hbjBZVbd9iMuUNOHSugA6yqFAv
	TopJ2EkSSwm6nyEf3yAHXrfa3VbHupekA79mgPcR05WF+Wfmd0BrGN1z6LcT1psMbO/+KBoAD5C
	ARGjXLsOWtKAIhsKoyzaPTgoGJoquhT1SHyICLq2nvIL9DroZoEibkTp9fEr1H0QwJ9nPZfm5ut
	ffKg=
X-Google-Smtp-Source: AGHT+IGcDhel5Qw6HBaQiI++3aX1Y1xFFeF7mQF3JtAnLb3+M9Y+l0edPLdqjr2/xICu28xWxO3Q3A==
X-Received: by 2002:a17:902:f710:b0:234:f6ba:e68a with SMTP id d9443c01a7336-23539624288mr183799545ad.45.1748882275318;
        Mon, 02 Jun 2025 09:37:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf9100sm72761655ad.198.2025.06.02.09.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 09:37:54 -0700 (PDT)
Message-ID: <a0bd19fe-7283-413d-9d35-8f82edb6f755@gmail.com>
Date: Mon, 2 Jun 2025 09:37:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/204] 5.4.294-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134255.449974357@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 06:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.294 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.294-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

There is a new warning showing up due to:

commit d2dd45288b46f39ee8ee8756d14dadd63b64b14a
Author: Jeongjun Park <aha310510@gmail.com>
Date:   Tue Apr 22 20:30:25 2025 +0900

     tracing: Fix oob write in trace_seq_to_buffer()

as seen below:

In file included from ./include/asm-generic/bug.h:19,
                  from ./arch/arm/include/asm/bug.h:60,
                  from ./include/linux/bug.h:5,
                  from ./include/linux/mmdebug.h:5,
                  from ./include/linux/mm.h:9,
                  from ./include/linux/ring_buffer.h:5,
                  from kernel/trace/trace.c:15:
kernel/trace/trace.c: In function 'tracing_splice_read_pipe':
./include/linux/kernel.h:843:43: warning: comparison of distinct pointer 
types lacks a cast
   843 |                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
       |                                           ^~
./include/linux/kernel.h:857:18: note: in expansion of macro '__typecheck'
   857 |                 (__typecheck(x, y) && __no_side_effects(x, y))
       |                  ^~~~~~~~~~~
./include/linux/kernel.h:867:31: note: in expansion of macro '__safe_cmp'
   867 |         __builtin_choose_expr(__safe_cmp(x, y), \
       |                               ^~~~~~~~~~
./include/linux/kernel.h:876:25: note: in expansion of macro '__careful_cmp'
   876 | #define min(x, y)       __careful_cmp(x, y, <)
       |                         ^~~~~~~~~~~~~
kernel/trace/trace.c:6334:43: note: in expansion of macro 'min'
  6334 | 
min((size_t)trace_seq_used(&iter->seq),
       |                                           ^~~

-- 
Florian

