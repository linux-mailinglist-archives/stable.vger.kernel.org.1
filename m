Return-Path: <stable+bounces-146182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7E6AC1FB2
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 11:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4C61BA3966
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFF1224AE9;
	Fri, 23 May 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hExjUL8o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04B5D8F0;
	Fri, 23 May 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992324; cv=none; b=hIVu4L3Eer5DaLSrM7Xemxc7p76xczz0fVqvbI3q6n6vQ5AFRkfCwJCwdrvVlzkkx1XmYYHb7OuKueN3Ag6JLzeTKeA89bbPaHVQvDqsE+XWeU+qe0XpB/STpv8vmhmLZTXCB6/sHTQzWGBCXDK2HMnZE66kqjzAYlX/nCRBn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992324; c=relaxed/simple;
	bh=PGA0Ad3C1HpTjHVROgn9fZ9oWXGJ/ly5wqU3G/dAykY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHz0Mtlaa+Fcepkz6QMTt3gVKSon9fqgIbIzdNwlurmPGO+7DJjbH3WVeu6WLfvGmG5lqJV63GtwE6dj8s1YEqEeeWvGQSU5k1p4uQ6ga/Ct4cmVREapYc18tcSQQfKrvs6dT2XTnySZcIGcXMDI8b315lUgKI+ktWRN22zhheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hExjUL8o; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so584295b3a.0;
        Fri, 23 May 2025 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747992322; x=1748597122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4yPM5GHZurT6WiMDMIjRa6sRdT6oGbPUbwT9Dc0gQR0=;
        b=hExjUL8oGT9jSw/dpTR04eCsUjBIRMTBx519qGxmxpxm9unbytgdGhBG9gKic9rJ4T
         gZ/v9o6kCKYeE96vASWpie2kI03yJUUov3f7ii/SR7y3fuqk4Ky7XkArWuK/sgOfGqlI
         OFtb4JeXY8/y18kceHN3yvSq6b7lV6Q/IQHqMfJ4zirkBMjzo5JMBMqGTycGbGrFUX6l
         f0iUaNeoFCiTasF9jMi6NCrMs+b/W3ktOETV/6e2j2rJPUsbhjKwgRng/kLwkFF6SpXO
         REor9BM/lQB3izObuhDOg07pd5Zy2R8nNkJ5EuFZjmhCisYFw17FiD/jfKFWGYZc4d81
         o0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747992322; x=1748597122;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yPM5GHZurT6WiMDMIjRa6sRdT6oGbPUbwT9Dc0gQR0=;
        b=mYxDUBe9IMAlUOv+AlU8kUuZtmaTcSjszz4r+joYxm0IigjzMR04uq0H0B7cbuu4AY
         JYzL0QuQ01pHbAKVLHLkFQxdethG6hwXAi9MQodzzjhAViBACOrQ+kfXaYKqvkwwgQq1
         WMwfpRuXGldC1/OkdJK7E44dVLUvR1kwl5lH5unGW5G4oatmM3R9UlFcx4O3rq83mxLi
         j145m0642t7PVZb743Zx4m1WUZAMHsvUZ8GNe+oRPdjO5DFA/O+tFB6ljh070j+zkdu/
         k/d+K802CUu8McpuTr+T9lYjuy2RS+5cj02hMDr9lLEg5AZrLhGJokswyDb1rPinzkF8
         4+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr6S3wU4IUX6qOpirbfWnd/Zxp57+DH2LLbSAlhQhGCQE6CTHRgg/epgPCK8CBEupNaQrwgET0m8+vvfg=@vger.kernel.org, AJvYcCXKsNL1V8V5/DLMDHYJjAJ2bT35uH7D2lcHZLpXzhYF/CkxLoqIZ5s5ZZOpFHSHLXGILmA9I6t8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0zDxyyu+2eZXa2lD6q6UyaENCK9nGtI6Qr6S8lz+taavcP0mY
	aGyUcUaIRBVlnx2EUG4XDqzsOJYDE0zbg/BElaHSumPkeQY0061g8OGl
X-Gm-Gg: ASbGncsgv9DWg9Z48itnduPwtCr9BLXV01ofRYYEOSJLGaZp/Z77wneEphTYN8CVS3s
	55t1kXupblwxAUfvhyxm1uAAZzze+BgdaVNZjVGn7X6DM6ZySDleq0rMJ/nQL7Hp6kZk/7FBud0
	JXZY60rhXY5gA+MaM5sHQ3FJz2psfJWUIJEb2URfOddkN1/kozB9itfPJxX8Wdwc5sRzsjtg7DA
	plsMlL4MXFw9K8csfUJhcoNvJ6fu6SR1g4+8z1VUNFzDxE3y5m9OzlI34zjCmdhEEeIWD2Qlb9m
	ZZJO5mfvtf+4bo07KyHnOy+OAaHUnHVMvAN7T1sGs7NfmFaDn596AB0l2IDxGs9FXLT1rOQQhGX
	+wg97M+9txL/oX3Ok0Wwmitmf
X-Google-Smtp-Source: AGHT+IEhjREyA9R1vAN2c4/XfdKgzwcSq1mlFAlayao0uKzK/2HNIFI6IHqVfNJCeEOSTbLaiN65VA==
X-Received: by 2002:a05:6a20:12d2:b0:1e1:9e9f:ae4 with SMTP id adf61e73a8af0-21877ab0e3dmr4125419637.13.1747992321797;
        Fri, 23 May 2025 02:25:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98770eesm12335068b3a.154.2025.05.23.02.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 02:25:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net>
Date: Fri, 23 May 2025 02:25:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/59] 5.15.184-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
References: <20250520125753.836407405@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.184 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
> 

Build reference: v5.15.184
Compiler version: x86_64-linux-gcc (GCC) 12.4.0
Assembler version: GNU assembler (GNU Binutils) 2.40

Configuration file workarounds:
     "s/CONFIG_FRAME_WARN=.*/CONFIG_FRAME_WARN=0/"

Building i386:defconfig ... passed
Building i386:allyesconfig ... failed
--------------
Error log:
x86_64-linux-ld: arch/x86/kernel/static_call.o: in function `__static_call_transform':
static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
--------------
Building i386:allmodconfig ... failed
--------------
Error log:
x86_64-linux-ld: arch/x86/kernel/static_call.o: in function `__static_call_transform':
static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
make[1]: [Makefile:1234: vmlinux] Error 1 (ignored)
--------------

In v5.15.y, cpu_wants_rethunk_at is only built if CONFIG_STACK_VALIDATION=y,
but that is not supported for i386 builds. The dummy function in
arch/x86/include/asm/alternative.h doesn't take that dependency into account.

Guenter


