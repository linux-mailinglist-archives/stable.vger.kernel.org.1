Return-Path: <stable+bounces-199896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6807CA1639
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D134B301473A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 19:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA723446CB;
	Wed,  3 Dec 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al+F0NKF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6443446C7
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783205; cv=none; b=i3nnx/gursLdm/g4ae+l842nfc+ojB4CQT0mvLMbCMuuTsAiMwh7rdfXg7P+e2S0jlVaxY3MOgivARpofXiteHbfBW78JHJzC8rpdKClExD1CTgAKkEv993et0Kgwp8Ie90+p1JP5clyZGN1zQAPyqAb0QrxcKsprP860FcZGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783205; c=relaxed/simple;
	bh=sjUmzhwrSpbGiFQFS+CfvvfSPMIH1gw++YX7SKEckOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNh80sIPqd47Rw7EhGp7HYr5zkl9ehptSBVSTSzIFM+0aeifMj15jx3eZQdr8JviWun8JI2/Ic2RopUDpfXcE/uEdKVQT25dMV/J8Osy2GFY+DTCTAd1mGL+WFZOp4Vj1y9JFmdHYunchyFopMni98IflroYyMpJIgvd1gpmrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al+F0NKF; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b3016c311bso861841485a.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764783203; x=1765388003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAySZyoVUYZcty/scbJ6Onf/leg2X+nER5+BrR1/QFw=;
        b=al+F0NKF/UMsr37WJ8S7sfhL1dTweWHjJG7TY/7iDVVing39lt+Byrg1Blib+qiZja
         SSmTepuCyTU+rdHFQ7NLyGDxoqj7zZAQ1+zwbTRAqKB2THTH+6gQkjwTE4zhX1zp/BPK
         G09NuUNkb+rCnYtietJMeOqeUy25P7vEidaCOdxO1PcD1UzeZyi81JH4Z2HkTgxSszaC
         YBqDVp9i0B1fq3ALEKdUMnQfzW8uAfDcrXWXjbEt22dv4C83kC2ftTE854GDFQwb0tpC
         2KKIQkuYVtraJ/t95NsrSHD8L7rJ5KduvJz8mF6mvhlxU46l47QB8e1dMG5hFiklYbnp
         I+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764783203; x=1765388003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAySZyoVUYZcty/scbJ6Onf/leg2X+nER5+BrR1/QFw=;
        b=bG87WuMgrJYGdxViDG+G9L69jGGZLis7ktWKwVdVpo+VORoY2LFnyBwtbuSmdGQoOa
         nw4RMm45ctFs+altRYYhk0p+jgjJ5Oy7vifF15Z1dqgNMnPTRjzzhAB6sZ/AeIQrU5L7
         94xFOkk9+tIPbAHL6msnur25qAwP//GyqwmpraVgQtPuiKkn48HbT7n/QU4pLono4yq8
         3+9QYNq5zR4ocLozyzaS97WVGndq4bDMKdYaunExCqSfuqjTkbibjdmMLyuWMOVaqG9e
         LYpNWzIJWJBtt8bLMw2cxNGKo+cY/9g8k9/bgHtAUd8YJAOB4ao7G1gxH7Ciu7yLTymK
         RcQg==
X-Forwarded-Encrypted: i=1; AJvYcCXeEwm1CVv0iewCtscCOhu6+iWzZVeL9q/7iI17pHrxrkQY2/0cYBT6w4nmUhqYcapMp5eu7GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGD1LbMABVfr183TFkRNwn03hHrNFcdVzX8xj/I4s1eqdWzlq
	I+tPw3nU1/EYekufeP6GIlvoZzYbZrnBYjW37g3ve4TfxHJ/D+MtS6jh
X-Gm-Gg: ASbGncuLnQxLDqBE9MKN9PQkUxCfv/RU9UCqJVKPQ2nfUCkcXXOzUe+3+or22GlAcAn
	uAIYtzEI3zoTexRTxSSc+HkNkGRbKx9n6tSaFEKoCgZbbKUMNaOfxs2l+TDhKVo1gogtd0LLOPa
	2LNHkQf1RETqBr8FZfsQVXXbzyvFUsDtktR4/+ynoSnmcbDo577wE95B8TBJRY0td5fa39JC1ZQ
	ZQv8RZM7usgYHbJJ/ESElBbbFL+BIlJx+VcYrnC7xOgfl3wMy80knA3zEyXYZ+YfcxyLNaCnNNx
	NjyIkHnnwZ3Ocg66qUdtIZdZgkY6dNM/FbshcW30GC0SMRXOZCJWy3IMuZ3A1KBwue2rpakwxEH
	Z9qocMIpmiY5asxC+nkods4w023RUcBI0+MhcBMSIAWiNv9IiVwhEfcNhPZmQdWw9qXP1yiOywD
	pfocmvmXoHJUA8pJ+XTVGlsG5L4B6++gSr0qgVOg==
X-Google-Smtp-Source: AGHT+IGr/13cEMHjcnMqt4Gm84Jo/I/ZJcPV6vXbwW6ARVpoUUQCSul2/FTG3CF5U56R7EkUSB7O+g==
X-Received: by 2002:a05:620a:7082:b0:8b2:effe:b4d4 with SMTP id af79cd13be357-8b5e7451300mr436873885a.78.1764783202619;
        Wed, 03 Dec 2025 09:33:22 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b6f72sm1342785585a.29.2025.12.03.09.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 09:33:21 -0800 (PST)
Message-ID: <139db995-0ff6-49f1-b7c9-9c213bf36e35@gmail.com>
Date: Wed, 3 Dec 2025 09:33:16 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/300] 5.10.247-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251203152400.447697997@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.247 release.
> There are 300 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.247-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

MIPS fails to build with:

arch/mips/mm/tlb-r4k.c: In function 'r4k_tlb_uniquify':
arch/mips/mm/tlb-r4k.c:591:17: error: passing argument 1 of 
'memblock_free' makes integer from pointer without a cast 
[-Werror=int-conversion]
    memblock_free(tlb_vpns, tlb_vpn_size);
                  ^~~~~~~~
In file included from arch/mips/mm/tlb-r4k.c:15:
./include/linux/memblock.h:107:31: note: expected 'phys_addr_t' {aka 
'unsigned int'} but argument is of type 'long unsigned int *'
  int memblock_free(phys_addr_t base, phys_addr_t size);
                    ~~~~~~~~~~~~^~~~
cc1: all warnings being treated as errors
host-make[4]: *** [scripts/Makefile.build:286: arch/mips/mm/tlb-r4k.o] 
Error 1
host-make[4]: *** Waiting for unfinished jobs....

Caused by:

commit 97ddb0e2389b4a53d395ed47ea83540ff495d1b6
Author: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:   Fri Nov 28 16:53:46 2025 +0000

     MIPS: mm: kmalloc tlb_vpn array to avoid stack overflow

It seems like we might have to cast to a phys_addr_t before passing that 
to memblock_free().
-- 
Florian

