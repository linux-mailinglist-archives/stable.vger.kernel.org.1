Return-Path: <stable+bounces-150606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D340EACB9D7
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88DF3BFFD2
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90C18FDD5;
	Mon,  2 Jun 2025 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq+t6lrJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75A42A8F;
	Mon,  2 Jun 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748883029; cv=none; b=cJ3mrGsMUWNpukhqe6sCc0XsCF6fSc7mLDTl2GUzhjCaRrDdSkUHrz21StF/lNJc0xI8BT2QvkOHqdalmT5Dm0pDrssN75y7PXxCkZWxZnD8dlI0qDCiDHjRhAbZSzffSRKpfpOZSAOS+8dHSe1rYJjP/CtMQmeiW3OLrHsmPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748883029; c=relaxed/simple;
	bh=ZIwZgPHNcQ18TGkQe8WeINE1XIXHcXzAPb10jgUSEeA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j7SW7/q7GjjjctrQjQtQ/1hVZ4Qr6oDjTOHm0yxnN0P8fyvbgidSl69xORwhLdYHi1Vi2FltQZ6bzn/cYE3un3zOAdHu1bIFbmfkLCjCi92350AxBCJfrkmbuCxOgLKQzSRqc/sRg9lNfzv6GawoSKRFQiiLKsx90r+BJE3RcFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq+t6lrJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2352400344aso31512005ad.2;
        Mon, 02 Jun 2025 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748883027; x=1749487827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EDoZvXIVFg1ip/4QjVxd1zFeSBPY4719u7+jKFjyKxY=;
        b=dq+t6lrJIy2J5iDyTcMCqdajtwK74QWooMhrT7M5fs7ooPY6cFBsLJriejaCKd8oen
         rX0/2QGJQRdk7FNpkOa7iF8vNhiFYT8b8Duv1MIHiT+ZMXdEAtzV1ViNgxGyM1nJwcwK
         LmGaJVksXyJMzpy4FMs2zwjX6D+v91h8eB18MYsfRLV0hF2Xt3E7GffmnOzo7C33l5G6
         XZjI5z2QI53nzk2t1LH68aDf4l6/WDfaIHpo83xWWTn9cmCmLHvwYZkfUaiz7LaJF8A8
         PzJqZHOiW8bhusXsu5aOlhcb957V+3RTn5hYBZixE4O3JAZdzonr/l6jXWzMOnCZPcjh
         wZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748883027; x=1749487827;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDoZvXIVFg1ip/4QjVxd1zFeSBPY4719u7+jKFjyKxY=;
        b=tSPw/JQW09k1hqz5+yeklpxJUdvSJ5Ts2B3EySjSXhZA0nTSOlTzBry5l8DMehOcOU
         YV/fLrOv3OiuoKYMwGaPr2PwYTCjjaP0KmNfyqcmRbuyi5nM1eK6BBjUL2S4ZZFSvTwC
         vs9iU7Gout1Ff1wkotkWh3PTZAJEFZYFfZ5Szeb8OtSjZDmQ7ocjFdddl4CHXAEnbwH1
         zB0RA/kpj2GTyFgpr4LOJyHrGA5TEVZNY5Fh7q4HyRaSL8816MygrM4FOnO5Kc+MKRDn
         RSqQXT6rUnJPVyUmTNIagkw2k4pBZWWCgCPtqvIKU1CWlMJYVo+d9VWmU3diDLTc/rvr
         7new==
X-Forwarded-Encrypted: i=1; AJvYcCUp2nHJu9HUzVjW/5Tk/i8Jex3XWx06kFeid8GiCrfncOyO46xmU25AbEUk4aJ2BO3EqKk/YWBq@vger.kernel.org, AJvYcCUtLqoUOkoqJ36ERuhvTpTy2GcoQ+KKDslhVXUPzyT5qQPyMZOUKCRp9WdTMJ9Xzdf6ZN7g1PFzNL6QhnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3hwp9GPghHXkR2bkVKHOFJ21/cqHOnkBYdd2jcOp0EWJIP6Q
	X/8E70BjzSJVqP9I/TRdkADO0jWcOlBtipkvB6Q0KywWZeGS3GGIwVqu
X-Gm-Gg: ASbGnctziuEOnhPBoOLTm8ldDvokjxmr6eFFkJw+VKwavy9YoasuII7jYlULp7/mCdQ
	SOt+rI+EXZsZUzhmcAuY8nGlbL1aOokJrDfmj7epG5svjxJh9JzmB3OJAkXHpjyfEi2QdX9+zsT
	cwiJpFO9HV8AkMI7iFpnJS1q4feoJ9P4u06pLjOsdlQfg2GZU5lc6ZStiyKvrvVbui9eXTYgPzt
	YKjqo/N152Tjz7MUvSGR6ZHBGeHoeUyN5wJviqG1EsmZhtg5+JgEDtxyJQnmWbl/jMFvnqaJlWF
	kbFHU1e/hj3HIhFZM5Er5krdpBDcfzMSCOKxSKGfsrHnPHLJ8CoVeNflJt54E0e/eNZcfWMnG6l
	Y9K+ed0rDHPii/w==
X-Google-Smtp-Source: AGHT+IGNxiRDe4Ud/5BHEt0ATTLDAtxMlUa3cyZcjVWxv+ZVbNDDtpY239lMj23catSMWAOUQW65KQ==
X-Received: by 2002:a17:902:f690:b0:234:c8f6:1afb with SMTP id d9443c01a7336-23527bcfd20mr221813195ad.0.1748883026573;
        Mon, 02 Jun 2025 09:50:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3438sm72742015ad.136.2025.06.02.09.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 09:50:26 -0700 (PDT)
Message-ID: <52e321d9-2695-4677-b8bf-4be99fc0d681@gmail.com>
Date: Mon, 2 Jun 2025 09:50:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/270] 5.10.238-rc1 review
From: Florian Fainelli <f.fainelli@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134307.195171844@linuxfoundation.org>
 <4c608184-5a64-4814-a70a-d2395662d437@gmail.com>
Content-Language: en-US
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <4c608184-5a64-4814-a70a-d2395662d437@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/2/25 09:49, Florian Fainelli wrote:
> On 6/2/25 06:44, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.10.238 release.
>> There are 270 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/ 
>> patch-5.10.238-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable- 
>> rc.git linux-5.10.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
> BMIPS_GENERIC:
> 
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Similar build warning as reported for 5.4, due to the same commit:
> 
> commit b47e6abc7dc5772ecb45383d9956f9fcb7fdf33c
> Author: Jeongjun Park <aha310510@gmail.com>
> Date:   Tue Apr 22 20:30:25 2025 +0900
> 
>      tracing: Fix oob write in trace_seq_to_buffer()
> 
>      commit f5178c41bb43444a6008150fe6094497135d07cb upstream.
> 
> In file included from ./include/linux/kernel.h:15,
>                   from ./include/asm-generic/bug.h:20,
>                   from ./arch/arm/include/asm/bug.h:60,
>                   from ./include/linux/bug.h:5,
>                   from ./include/linux/mmdebug.h:5,
>                   from ./include/linux/mm.h:9,
>                   from ./include/linux/ring_buffer.h:5,
>                   from kernel/trace/trace.c:15:
> kernel/trace/trace.c: In function 'tracing_splice_read_pipe':
> ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer 
> types lacks a cast
>     20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>        |                                   ^~
> ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>     26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>        |                  ^~~~~~~~~~~
> ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>     36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>        |                               ^~~~~~~~~~
> ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
>     45 | #define min(x, y)       __careful_cmp(x, y, <)
>        |                         ^~~~~~~~~~~~~
> kernel/trace/trace.c:6688:43: note: in expansion of macro 'min'
>   6688 | min((size_t)trace_seq_used(&iter->seq),
>        |                                           ^~~
> 

And also this one:

commit e0a3a33cecd3ce2fde1de4ff0e223dc1db484a8d
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Mar 5 13:05:50 2025 +0000

     tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()

     [ Upstream commit f8ece40786c9342249aa0a1b55e148ee23b2a746 ]


on ARM64:

In file included from ./include/linux/kernel.h:15,
                  from ./include/linux/list.h:9,
                  from ./include/linux/module.h:12,
                  from net/ipv4/inet_hashtables.c:12:
net/ipv4/inet_hashtables.c: In function 'inet_ehash_locks_alloc':
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer 
types lacks a cast
    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
       |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
       |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
       |                               ^~~~~~~~~~
./include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
    52 | #define max(x, y)       __careful_cmp(x, y, >)
       |                         ^~~~~~~~~~~~~
net/ipv4/inet_hashtables.c:946:19: note: in expansion of macro 'max'
   946 |         nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / 
locksz);
       |                   ^~~


-- 
Florian

