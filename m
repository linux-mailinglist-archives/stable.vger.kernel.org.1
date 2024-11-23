Return-Path: <stable+bounces-94685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE049D69B7
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AF0281B71
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E9022EED;
	Sat, 23 Nov 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6JzT1af"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370B18C0C;
	Sat, 23 Nov 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732376836; cv=none; b=JNLN5UL+yvtIamhQX6DfJV6FLIqOqoOaNOtrdDp4P3G5YvzIpYU+NIsnZj71+psoUWbNLfvaQOsyxaqmKdkAKov4pqRWVsiGynt7yFtrOHgMyrdXlXxKgej37q9niVhEa+mdt0ARNrR+taacx2vEsMaqVUnfRVTxmMorONdrNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732376836; c=relaxed/simple;
	bh=dM+5ko50bGiW4wHpFwr20fCurV0azlaaaFZSbdSB3Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzTXu9OS2VO730jNK4r8yhborcXXqqXjbXfIqMNSDJyFCnfWaweaHLMGjHqn7BGD0JOCRl2KT7divxL3WDxdlmPSdDSh3VZeKJyPUufiMckkddYmpfFfykCFZxJRN/tl9FeyxgsmOw2NMD8DPnGpFoeTvdyygOZxYYdSmI80yRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6JzT1af; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724d23df764so2268759b3a.1;
        Sat, 23 Nov 2024 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732376834; x=1732981634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zoc3uOg+1Kbv5BtwHRLLwZziawPdUmTdDZwLPRtzZQ=;
        b=l6JzT1afN8jBy6JxOBfBp7wNrG0lz1viL4xI4lanjg51JHpQ0kK7RsX4ksq3yKuiNw
         auCl2D/jngXVoE+Nf/dK97RHewSbv3KX5WcGy5VqQkxgxSzk1CNRpLLkt+my4RiIRiFF
         afLhxoQOQUMA0lN2uZxvJJ54gY/6ugnHXFl2s0xzpYl/i6Q1Xmpm+GwBPCGGxs9Q+oQy
         9kBfV/AM6cvayt1DCdQ/9xmpM5lE0cn9IOXKxvkTCdTGINmhxKkoxO1SKLqzlem7KV8y
         9nfILSyybmPq7s/kuF/VQCprs5+Q3nBTL9SWqzAhVTLa8WsUSKVjuSgjMh3HfSrzXWVF
         YStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732376834; x=1732981634;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zoc3uOg+1Kbv5BtwHRLLwZziawPdUmTdDZwLPRtzZQ=;
        b=VUaa5D3GgVdNdDtkzLvIKvKtioKjE0+sEpotvPU8pffBxSiYsqtRdSlKZFI3UCZr/D
         T9bifM7EHVe3A+PfUkiz1HHiAIF6baEguk9G9PWKrJr0VqPSv9b2BaY3tYLCDY+V8UWa
         fZYObl30zPClbKHv2yxnsVlqVoI6wlU6PLv6DpxI+wBv601RceGL08o8FwDZEwTNsjzy
         F7WFkJb4DpAJuhmdBi4hGn5o2tZChiOUnWLlP8kROVW848otBtxvXXBAFJoOgRio5JTJ
         v5ohs/CwvurAXbAT8MUfiW+dREAFlK8tXWwArP6dA3R2ZyzzOLPSctvUMP5HILRPyOTv
         HE7A==
X-Forwarded-Encrypted: i=1; AJvYcCUsWFJ/M/CP79bvSlx9b9FYeg3dy2jezG88Mz92lwuK7uPlSDRuh6L2+/Ov0YGeD1eKAmrVDEhO83mhiy8=@vger.kernel.org, AJvYcCXeGJtM5r00gOQ5VYNR2hhJV3DNHXJsTyKz3GpqQ+32G9gKL/d58k6TE6g8WobHvSZf++IA3HnR@vger.kernel.org
X-Gm-Message-State: AOJu0YwUf5G9vhLpeYJnRaGLLvxpOonl8Gfcln/9fDfo5/wKuEKj1oZw
	NYX3k2PfBb8R2Tkb3trXwsBvY8EjD+Vh80gKnbkADIOKKkYl8ovP
X-Gm-Gg: ASbGncu49o85Xb3tl1gwMCwWEQyUxBlzfibnMJhCpn4bQgdgFrB8CEWVAyycX+XcdNq
	u2qUE8v3+K9Medd7rTjQOaxNH8wxUVcnxq47fsNf9Zy2Farur7b2nrieznSXif+LRbBfV5iA6/n
	wzVk8JOhMNAv/0zwdRzMyT0sJ32KzEoAAROWR1mdgOPdIaq/rFzfyPQSo45fyFTj4TPzOhxWIfq
	X1ofEarzMVrNHLqouavUDTyrdqS+xeagbRLZwTtWI2AflTn5GLzInmC5gbymfaV7JYywloWHEZh
	Tj+rImlNzeyN8XbmhuDO8rs=
X-Google-Smtp-Source: AGHT+IF12Jep8KG9jUE9XRJlTG32rmbBK46bF+i8nvM0V2w3eR7Y4Lmk7oegrh8wwIzZuS3cqEaFNg==
X-Received: by 2002:a05:6a00:23cc:b0:71e:4c18:8e3b with SMTP id d2e1a72fcca58-724df3cd479mr9893050b3a.2.1732376832465;
        Sat, 23 Nov 2024 07:47:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de57a9a7sm3376142b3a.200.2024.11.23.07.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 07:47:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eda70745-0ea2-43bd-bee3-8905e3a1d3cc@roeck-us.net>
Date: Sat, 23 Nov 2024 07:47:09 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/73] 6.1.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
References: <20241120125809.623237564@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 04:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.119 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:57:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Linux 6.1.119-rc1
> 
> Michal Luczaj <mhal@rbox.co>
>      net: Make copy_safe_from_sockptr() match documentation
> 
> Eli Billauer <eli.billauer@gmail.com>
>      char: xillybus: Fix trivial bug with mutex
> 
> Mikulas Patocka <mpatocka@redhat.com>
>      parisc: fix a possible DMA corruption
> 

This results in:

include/linux/slab.h:229: warning: "ARCH_KMALLOC_MINALIGN" redefined
   229 | #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
       |
In file included from include/linux/cache.h:6,
                  from include/linux/mmzone.h:12,
                  from include/linux/gfp.h:7,
                  from include/linux/mm.h:7:
arch/parisc/include/asm/cache.h:28: note: this is the location of the previous definition
    28 | #define ARCH_KMALLOC_MINALIGN   16      /* ldcw requires 16-byte alignment */

because commit 4ab5f8ec7d71a ("mm/slab: decouple ARCH_KMALLOC_MINALIGN
from ARCH_DMA_MINALIGN") was not applied as well.

Then there is

include/linux/dma-mapping.h:546:47: error: macro "cache_line_size" passed 1 arguments, but takes just 0
   546 | static inline int dma_get_cache_alignment(void)
       |                                               ^
arch/parisc/include/asm/cache.h:31: note: macro "cache_line_size" defined here
    31 | #define cache_line_size()       dcache_stride
       |
include/linux/dma-mapping.h:547:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token

because commit 8c57da28dc3df ("dma: allow dma_get_cache_alignment()
to be overridden by the arch code") is missing as well.

Those two patches fix the compile errors. I have not tested if the resulting
images boot.

Guenter


