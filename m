Return-Path: <stable+bounces-104281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300B99F248A
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B87164B81
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325318C03E;
	Sun, 15 Dec 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auXm/NMm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CAA937;
	Sun, 15 Dec 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734275731; cv=none; b=nLtISBLiWvxlbQUoJsWrYy9pP3HpG8fjJv7wbTm3eDkIU5obchnB0n86rUKPjFEyrOeFIyZvCw/TRq128BIVM8lwI03hxpSv+W31TEojDHMv8SqOXkgzdSeJD3FcsNq16XnNgJAa5/86kIhunV3du1yhMxmzR31aN3+I0Y3K4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734275731; c=relaxed/simple;
	bh=nVj1ePUHSdiZszOOne2uSy2yZ+V9p36MnbwMiwYdqHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ck6KlkPFKsL99jvrtWtym01os9ENL+Iap8X50fYYlmkG7FvPhFnr3Xjr5faLLKiBV7Yd+mv+wYYnbzZ9O/UtaYlUu7BILdtabN/w5437hUsGjsBuJdcCZk5OnbDMGV2nFKmIbYD+MG2OT8PX3BZ5nYlkLW5va06tEsBGusc2gog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auXm/NMm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fbd9be84bdso3075850a12.1;
        Sun, 15 Dec 2024 07:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734275727; x=1734880527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zMH1t5TJeAAC5X5Fjv+rFhIKRWsX9ukOPLgoXh+myGU=;
        b=auXm/NMm46LulBZIom+YNcEH6HYiL5n+6hI6CFjonO9tC4/EMJJHXwY/Sb0Xtb8lMg
         yPvLshl9fGV/LoI2LY80rfrwE1psda6SoN5gciLJMWcb2IWHtSJGnoZeO0cML0/paC6Q
         YWU6D8pvn4/wGT05eDCJxbYMCkcr2YsQLlhsWQ0jMRPQgSOJVwVBvu6wuQPfXGqFJiUJ
         Te1uvSZBTjpjRK1YqO7FibhksPJC9uJVT4PhLHA7O2/nsIH0y/DBVi3OfRItr85V0eih
         9qhla+ijLvpfc9F304WXzSm1O3bHH7uYIhiyb7EkX/T3gxisQWTIQgbp0Mxsrq6tvSQg
         utag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734275727; x=1734880527;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMH1t5TJeAAC5X5Fjv+rFhIKRWsX9ukOPLgoXh+myGU=;
        b=lz7eqzQuZFMp3hc02lHAoj/XVdnNmhSPg9ged1GV91/OSE8mMlaU1SSPMY/qpvmfgU
         ZBuQVtrFMsOOXQzT3FH43Dn1f7bGhNbtoGrWEvSuhO253YuumjU4BpJV3znz29d122dO
         zUYSKQ6Fup6KYo5aovtGLLRGVxcSqTu4fQh7/up1YBsV8DISehJwKANu1tpLQCFGee6S
         z48RreU1zQTMXa04Ue9B8ekDzXIzzPRU2cSQxdx/rSpD28LBUKKjnlHbPK7uOW/NP4ic
         tTVC1qOtWBHnMq4kT5nruFfkk2OvvWq0dmrvtAA8iING33h9MLhk1UJzZ4Px/fO9EwNE
         PZGg==
X-Forwarded-Encrypted: i=1; AJvYcCU1ngHh2PTKN8OhBDagqOK3CRNuiDR9LA/ilaU6JTCmpvpmCLZfacaryd8TgGa9yiRsQ1bGy3n1GMwW6yc=@vger.kernel.org, AJvYcCVEiXCosMCO0HIsOOYN4kJQ7u1ob2f1IWzS9SZYr0r5AbJxjv9eFdBeMLmkQml5ZcBcEU45rJk8@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLP+t+UvppwCfin4UwmWo+3W7JMSmLqmav9Ey8Na8Ntw8usCz
	cZjrJX0Oq5ll7T3o6j+gIb7Uxf9EMwDhthecKFnCYqnIUZ5i6CH5
X-Gm-Gg: ASbGncvogeh5BwVejOkGc+ueTyhWR214LXzkfou/VL/idUwA95FQewuJC4ZQRUuxRvt
	2XDBpg0WBWApTklGdARRs/g+MA7tgFGbttjEH32Q1cm4du0tC+D+ukbOA1KoJU+hXYsz5Qza1wk
	FhfGAadp9o4L9JYs5alZxblklp1u9xbPz571IQj+H4pmiO/ddbWvwikPtzHrwdhRRiw2Ohehwnj
	Qm0K31PwrxQuDXrLgcVtXfAPwOJvM94eRSa/G/oMZr5fndrFShCNC1ci4dKFY0pDfl+iCGp3bW6
	nPg+HE9M+wAHa0kOuh+3LVVitHZ51Q==
X-Google-Smtp-Source: AGHT+IF5aP5DBq5UO81Y5ZI/XhwDXUIXR1lYDrmTONuNGxGgROiWSOt3c57AZdleQXJ6Jk3gG4w9Xw==
X-Received: by 2002:a17:90b:4a04:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2f28fb67655mr15392839a91.15.1734275727446;
        Sun, 15 Dec 2024 07:15:27 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d93470sm6385465a91.4.2024.12.15.07.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 07:15:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <68b0559e-47e8-4756-b3de-67d59242756e@roeck-us.net>
Date: Sun, 15 Dec 2024 07:15:24 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/459] 5.10.231-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
References: <20241212144253.511169641@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 06:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.231 release.
> There are 459 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 147 fail: 9
Failed builds:
	m68k:allnoconfig
	m68k:tinyconfig
	m68k_nommu:m5272c3_defconfig
	m68k_nommu:m5307c3_defconfig
	m68k_nommu:m5249evb_defconfig
	m68k_nommu:m5407c3_defconfig
	m68k_nommu:m5475evb_defconfig
	mips:ar7_defconfig
	nds32:allmodconfig
Qemu test results:
	total: 480 pass: 479 fail: 1
Failed tests:
	m68k:mcf5208evb:m5208:m5208evb_defconfig:initrd

Some details below. Reverting

ef1db3d1d2bf clocksource/drivers:sp804: Make user selectable
d08932bb6e38 clkdev: remove CONFIG_CLKDEV_LOOKUP

fixes the problem for m68k:tinyconfig and m68k:m5272c3_defconfig. I didn't check
if it fixes the other failures, or if the revert affects anything else.

Guenter

---
Building m68k:allnoconfig ... failed
Building m68k:tinyconfig ... failed
--------------
Error log:
m68k-linux-ld: drivers/clk/clkdev.o: in function `clk_get':
clkdev.c:(.text+0x1b8): multiple definition of `clk_get'; arch/m68k/coldfire/clk.o:clk.c:(.text+0x44): first defined here
m68k-linux-ld: drivers/clk/clkdev.o: in function `clk_put':
clkdev.c:(.text+0x23e): multiple definition of `clk_put'; arch/m68k/coldfire/clk.o:clk.c:(.text+0x114): first defined here

Building m68k_nommu:m5272c3_defconfig ... failed
Building m68k_nommu:m5307c3_defconfig ... failed
(affects all nommu builds)
--------------
Error log:
m68k-linux-ld: drivers/clk/clkdev.o: in function `clk_get':
clkdev.c:(.text+0x1b8): multiple definition of `clk_get'; arch/m68k/coldfire/clk.o:clk.c:(.text+0x0): first defined here
m68k-linux-ld: drivers/clk/clkdev.o: in function `clk_put':
clkdev.c:(.text+0x23e): multiple definition of `clk_put'; arch/m68k/coldfire/clk.o:clk.c:(.text+0xe0): first defined here

Building mips:ar7_defconfig ... failed
--------------
Error log:
mips64-linux-ld: drivers/clk/clkdev.o: in function `clk_put':
clkdev.c:(.text+0x0): multiple definition of `clk_put'; arch/mips/ar7/clock.o:clock.c:(.text+0x1f8): first defined here
mips64-linux-ld: drivers/clk/clkdev.o: in function `clk_get':
clkdev.c:(.text+0x654): multiple definition of `clk_get'; arch/mips/ar7/clock.o:clock.c:(.text+0x28): first defined here

Building nds32:allmodconfig ... failed
--------------
Error log:
ipc/sem.o: in function `perform_atomic_semop_slow':
sem.c:(.text+0x834): relocation truncated to fit: R_NDS32_9_PCREL_RELA against `.text'


