Return-Path: <stable+bounces-71333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B99615B4
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 19:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD411F2370D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7F81745;
	Tue, 27 Aug 2024 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjVjmYRY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207631C7B63;
	Tue, 27 Aug 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780783; cv=none; b=bP/HGYHtc+U+ZvdZ4/1GQsBR1s2kBLGO9JRuPdw2auVqSJiDKQfe+bMYpPII69ktWYQVZOQFiqb2uC9kHGJhXyNQp/tJY+B+nexiq2CMGc8+2x+H9eLHfs/PvC3dNc2GWNcD4RWvQSXgibAV1mrGwIVMduk3sULp+luZPCpiAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780783; c=relaxed/simple;
	bh=eOyNGEmTLD27An2vpi67uo7UjKLCKax+jWOJwOGKrOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD86wyYzauBUm3hA1oIj/PmEY5CTCaBbesV9ft6HxJNAcEv4Oji+vvBfTriRHIbLSd88tC0Me0GDXhA8kVxWRFct3omJJMtOpYPpXGNGya1T9mBxNNAJ84/A06zqOrFnNvGUCvXcrO0P/peOXTCT2VwrvYPqRz5UseYNTOCgza4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjVjmYRY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201e52ca0caso40973845ad.3;
        Tue, 27 Aug 2024 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724780781; x=1725385581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5s3YAABYrMbP+Js2IaEndStvu7oMvLUb7JcLN3rS6YU=;
        b=NjVjmYRYWcaRoEwYJLB5dyWzPQ+AitepiULJG8eJnxz+QUrIBo/EPwHH4IUJhSUg5r
         yQppzPFr8yR0S4QSKcDR8IIRDMj4rSXXKsfS10pCQhHX6BFeASTq9ZV4pdAljLOfF2vL
         GpuU3fszu7THBzRcJ/Kzdx0kFRk/hO7kAU9ZgSRowC9BbMKoVKJ9rk+OSY5OIrRD5H9P
         13NUr7zIvFxfeMpznH41O2I2dZhVn2UkYBbitlovyFNqJ83QnzY8y2GJTatJKJ0tPv/6
         GYWb0Pd3h0YaHPGQFoMqWnS5K3ygBIGqvB1UczwmoBMV70LUtLPRnb7kjc/sTi05V+Zj
         8M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724780781; x=1725385581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5s3YAABYrMbP+Js2IaEndStvu7oMvLUb7JcLN3rS6YU=;
        b=Rpz7D4QwCs3OfNfBVbvxY/c1SvZOHXBwT7gKB26SQIpnSdxPizVABRxpKKEp9nCPZ+
         VCpFwUBiKZiiq95C5NSxNb8TzpwBoneeQ77i482F+IsDoF6EZ1IBt4bCYb6sLR1CTaHo
         HCDOUVZMpI3PLx+j7B+aHDvtYwtVYWHvB8UqUEGMJqxr1Tqw2aLkdrSYNOO8nlk4FiI1
         PtlxM/56VS8CSZ7n/eRDnAi+P41WtkXbFT9gkL3p3Gt8poX1JsXyQaB57BjF8Wr4q6QD
         b6TVDnUY72CT3h/9yZA/Sf45KXyy25uRmXOrk55+pdoupiJY03WokcasV7d2RHvz+KDS
         eYOg==
X-Forwarded-Encrypted: i=1; AJvYcCWW2IcbPzFSFDfDOXV2oW44qvcA3QF8hjXmkvZ4uX/VagBrJMfFVtssHQlLSa7mJ6NSmaHzIRHY@vger.kernel.org, AJvYcCWgXI2I9Cr0RQBZ51+4LHmH4NBI3CT8VoAH4IpbQ0pCWYtxATs6oWXbbMN5smzaRcyJOxaTsR8s/bt5Gck=@vger.kernel.org
X-Gm-Message-State: AOJu0YySLsUKA+L/xTMP+dABCk6a7d7jKQVf4nujaLaGvLmwSdbTWZXX
	jNp9+KtG4q5Qa7n3XIY9auB9TJaFklALkFY2s1fu4hB+0EpPsLuj
X-Google-Smtp-Source: AGHT+IGwgC5fluupGUSSSCBjGFmyd2CCuVbz0MB5XZL5BC5ZQZh3Ak+CPzHAQ5WagxrDBmLdBcvsPg==
X-Received: by 2002:a17:902:cecb:b0:1fb:8cab:ccc9 with SMTP id d9443c01a7336-2039e4e8468mr129533605ad.45.1724780781284;
        Tue, 27 Aug 2024 10:46:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203859f0121sm85724665ad.246.2024.08.27.10.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 10:46:20 -0700 (PDT)
Message-ID: <45689fa1-ad89-4360-9d09-c99597e17595@gmail.com>
Date: Tue, 27 Aug 2024 10:46:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/321] 6.1.107-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240827143838.192435816@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 07:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.107 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.107-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Loads and loads of the below warning plus linking failure building perf:

../include/linux/bitmap.h: In function 'bitmap_zero':
../include/linux/bitmap.h:28:34: warning: implicit declaration of 
function 'ALIGN' [-Wimplicit-function-declaration]
    28 | #define bitmap_size(nbits)      (ALIGN(nbits, BITS_PER_LONG) / 
BITS_PER_BYTE)
       |                                  ^~~~~
../include/linux/bitmap.h:35:32: note: in expansion of macro 'bitmap_size'
    35 |                 memset(dst, 0, bitmap_size(nbits));
       |                                ^~~~~~~~~~~
   CC      /local/users/fainelli/buildroot/output/arm/build/li

/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `bitmap_zero':
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:35: 
undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `bitmap_zalloc':
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:121: 
undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:121: 
undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:121: 
undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:121: 
undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o:/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/../include/linux/bitmap.h:121: 
more undefined references to `ALIGN' follow
collect2: error: ld returned 1 exit status
make[4]: *** [Makefile.perf:675: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf] 
Error 1
make[3]: *** [Makefile.perf:240: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [package/pkg-generic.mk:294: 
/local/users/fainelli/buildroot/output/arm/build/linux-tools/.stamp_built] 
Error 2
make: *** [Makefile:29: _all] Error 2

This was already reported here for 5.10.225-rc1:

https://lore.kernel.org/all/96ad9bc6-1cac-4ebf-8385-661c0d4f1b99@gmail.com/

and it is the same root cause.
--
Florian

