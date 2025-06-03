Return-Path: <stable+bounces-150728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76BAACCADF
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7744C3A8DD7
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033EE231833;
	Tue,  3 Jun 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGC/VezN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7762C325E;
	Tue,  3 Jun 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966464; cv=none; b=HHHzukmdZzZh9/5Gv+qwaGU3FoRItIsq160/6qG4WDVPrgdENNd7DaEtn0G3gitQSv4bzOipRLPT+ESn/2fR9ycF2CYmZHBYrb+GBfxUeUYA09N5oCXQrPeAIXuuAVs0s0V3Emh40llCK0sLnd0rDB2C/sJKzcjWTEtDeSiw5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966464; c=relaxed/simple;
	bh=ZVoYbU3pUfM0RpcnSPakC4wWN5k+VVWnBDElT6WsJJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNs4flHCfaveDpad/loD9SBSiwvyEL5sKdX6tmsnqqkyPS3Zs/eIn1SC+BdxL9fml97bzK4Bk0rubcIBMLPpqG8MTOu80bnV1ZMi2yB20vZTQRdNZV65LCHPfwlXQdlpHq3WAtE14ODTOkBJmAJyY3pQf7YnuL90iYvF/TrXzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGC/VezN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so4618452b3a.1;
        Tue, 03 Jun 2025 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748966462; x=1749571262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BsXZQ/uyRY+qTVpEgGFJZCGzcexP2bgbyKWMgllZm/A=;
        b=KGC/VezNFA9t36JrLh7Q9B05pw/8wRpNcCPcYX+eqNi0v82bAJsYNvHdk/VDPywluh
         DOC/Y8Yj2fvXgOadNIziaVhPvawGSYzRvZyk0OyGz2mTwS7wCYrdD3Q/yfq3f1Uv+K3H
         hft8UYWHv0nBEtODJEKosrr8oU0AJQRUUeHafoWHmiXJvloK2cItOrwlx73xbVFOCObI
         eeizWy3AJNvfg3KBeliFd/sii8/y5st145JEa+kLDn7ktXtsGjx6fCaq0+KzKOQ2GNrs
         xwAIWHaNxUGP/j7zkJwWrxMwzaH4BAAfZyAPjHU8CG8qCuikLIZytq4CgU+1KYXg7hHW
         W7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748966462; x=1749571262;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsXZQ/uyRY+qTVpEgGFJZCGzcexP2bgbyKWMgllZm/A=;
        b=GiEpJU0BppbQOPhuswE1jWLee17Nipadth4FFp2lL78PY4Ivy7U1HIhN0W6OTsZg9X
         t12XB1CCzHmlVigHtBK/uqHs7TXM0IRyfQZxdp0ilhABqoDIPwjctG9DheKBFl+HYvbf
         /vNhP0OR7L0oUTGUK07wg926fXm399xsJAHmD1o36aNVQ+Lznv7v5eB4iizA0ChELAn+
         ULBiNG8P/M3J+a9skfm8FsK+XQiPTHFJTeI0SlrVFZzqJMphb0ZnDJELgytqzqXiasSD
         zyKCK5dAxnsgqtjOuSxU+MxUHx5H1SjaowPIrnxq4wAw3Smb7dmhdXj4X2ZAT7sZZWpC
         v6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRoRHdnHprRq5B8uAjqkFEwWOtLelsNB7CQ48G00S9rh4yRrQvyEr6EP4EjFlx91ze6uQQrY/APD0prFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE5wX04cAZmvcuAWDpwJ8dcXE0EqAKuUnudvSQSdeF6C0pCH+k
	+ync/iAM5MwS9fNHmtyIr7LnQn7CMJ6Nd5Tp3N8QOv0PISnBNQ4jm1Y5
X-Gm-Gg: ASbGncuUZ+Tx099FBjoDcZhy8zY+78Z9TEmNbVc0ARgMrst3U2Aj8sTxzkCsrqpZDxd
	w2HqO8wATnF/YpMT+vktidA56anHJzVTGAfRfbdW+NOPlf5/EMQ4zlRUlvcL+HTALwXz16HSgMb
	23lCT6ndkQUcFVTad++JRqxBuQ6KrphykptXqnYbjy1kRXHTuemZL/JvGlTj2nY00DKoq3Sh2Ue
	ZlwM9pE/Zk+cuPppGVMbPjOh+c2t0pUSqIs+3Yh5FDxIa0dGe5yqH/2T25Da+BheYxXXj9PaPcb
	gvxQPnqpQtr1zOeuetVxIwfRhFpyx7TgbJvylRkJ/mlTLcgOe0NZWTxKi56Z93z9mQnGHka378t
	i+gA=
X-Google-Smtp-Source: AGHT+IEeh8MaQQrJVyQuQPlgts4cAcQISPbKUr8e3jCFPU5I/LAIGT3xID1897d3eJde7cnMp3B/fg==
X-Received: by 2002:a05:6a20:e607:b0:1fe:5921:44f2 with SMTP id adf61e73a8af0-21ba11fb422mr17620215637.20.1748966460631;
        Tue, 03 Jun 2025 09:01:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affcf9ffsm9875523b3a.135.2025.06.03.09.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 09:01:00 -0700 (PDT)
Message-ID: <b60e753c-eb13-46af-9365-1b33ae2e7859@gmail.com>
Date: Tue, 3 Jun 2025 09:00:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/270] 5.10.238-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134307.195171844@linuxfoundation.org>
 <4c608184-5a64-4814-a70a-d2395662d437@gmail.com>
 <52e321d9-2695-4677-b8bf-4be99fc0d681@gmail.com>
 <2025060344-kiwi-anagram-fc9e@gregkh>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <2025060344-kiwi-anagram-fc9e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/25 00:58, Greg Kroah-Hartman wrote:
> On Mon, Jun 02, 2025 at 09:50:24AM -0700, Florian Fainelli wrote:
>> On 6/2/25 09:49, Florian Fainelli wrote:
>>> On 6/2/25 06:44, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 5.10.238 release.
>>>> There are 270 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>> The whole patch series can be found in one patch at:
>>>>      https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/
>>>> patch-5.10.238-rc1.gz
>>>> or in the git tree and branch at:
>>>>      git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-
>>>> rc.git linux-5.10.y
>>>> and the diffstat can be found below.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on
>>> BMIPS_GENERIC:
>>>
>>> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>
>>> Similar build warning as reported for 5.4, due to the same commit:
>>>
>>> commit b47e6abc7dc5772ecb45383d9956f9fcb7fdf33c
>>> Author: Jeongjun Park <aha310510@gmail.com>
>>> Date:   Tue Apr 22 20:30:25 2025 +0900
>>>
>>>       tracing: Fix oob write in trace_seq_to_buffer()
>>>
>>>       commit f5178c41bb43444a6008150fe6094497135d07cb upstream.
>>>
>>> In file included from ./include/linux/kernel.h:15,
>>>                    from ./include/asm-generic/bug.h:20,
>>>                    from ./arch/arm/include/asm/bug.h:60,
>>>                    from ./include/linux/bug.h:5,
>>>                    from ./include/linux/mmdebug.h:5,
>>>                    from ./include/linux/mm.h:9,
>>>                    from ./include/linux/ring_buffer.h:5,
>>>                    from kernel/trace/trace.c:15:
>>> kernel/trace/trace.c: In function 'tracing_splice_read_pipe':
>>> ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer
>>> types lacks a cast
>>>      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>>>         |                                   ^~
>>> ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>>>      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>>>         |                  ^~~~~~~~~~~
>>> ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>>>      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>>>         |                               ^~~~~~~~~~
>>> ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
>>>      45 | #define min(x, y)       __careful_cmp(x, y, <)
>>>         |                         ^~~~~~~~~~~~~
>>> kernel/trace/trace.c:6688:43: note: in expansion of macro 'min'
>>>    6688 | min((size_t)trace_seq_used(&iter->seq),
>>>         |                                           ^~~
>>>
>>
>> And also this one:
>>
>> commit e0a3a33cecd3ce2fde1de4ff0e223dc1db484a8d
>> Author: Eric Dumazet <edumazet@google.com>
>> Date:   Wed Mar 5 13:05:50 2025 +0000
>>
>>      tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
>>
>>      [ Upstream commit f8ece40786c9342249aa0a1b55e148ee23b2a746 ]
>>
>>
>> on ARM64:
>>
>> In file included from ./include/linux/kernel.h:15,
>>                   from ./include/linux/list.h:9,
>>                   from ./include/linux/module.h:12,
>>                   from net/ipv4/inet_hashtables.c:12:
>> net/ipv4/inet_hashtables.c: In function 'inet_ehash_locks_alloc':
>> ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer
>> types lacks a cast
>>     20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>>        |                                   ^~
>> ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>>     26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>>        |                  ^~~~~~~~~~~
>> ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>>     36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>>        |                               ^~~~~~~~~~
>> ./include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
>>     52 | #define max(x, y)       __careful_cmp(x, y, >)
>>        |                         ^~~~~~~~~~~~~
>> net/ipv4/inet_hashtables.c:946:19: note: in expansion of macro 'max'
>>    946 |         nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE /
>> locksz);
>>        |                   ^~~
>>
> 
> For both of these, I'll just let them be as they are ok, it's just the
> mess of our min/max macro unwinding causes these issues.
> 
> Unless they really bother someone, and in that case, a patch to add the
> correct type to the backport to make the noise go away would be greatly
> appreciated.

Yeah that's a reasonable resolution, I will try to track down the 
missing patches for minmax.h so we are warning free for the stable kernels.

Thanks
-- 
Florian

