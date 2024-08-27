Return-Path: <stable+bounces-71334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 764BD9615C1
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 19:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6E21C233F6
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA21D1F52;
	Tue, 27 Aug 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbYJbH7r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31257126F1E;
	Tue, 27 Aug 2024 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780878; cv=none; b=R9TFCVp+965dP0Nif7Pko4uvANQckx5A9GFJbUxaOMH+UGUwiikGm1msLqnrd5tpIaYoyOp39VedQLIzFppZ/xoYRxxL4Us6yYKjniJKozsr+7DB/LL4CIKiTYL440AKUiwJLI7YoCApp1EtN31PlUCeXPnzloHEbAcFYYVOWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780878; c=relaxed/simple;
	bh=dYHoc8tAXja1j/gy+quwz+VAVNvuZkG5hw3yiikQ1eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WudWNXPTLga/9cjY5NYJcUD14RDu45G5mYW9G/1ug9eCsyrHc87GeC7mzh5P1Wf0f6mzk5FpuQTqYCo8DFnIuXv7uOA1hgJ/qU3S3jFycvw1Bqc/+HZsjLL3X3MHXfWXsT/Ke8vfHJFedja6iW/AwvDyLZQ6p8ogkyDMI7WuZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbYJbH7r; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7141d7b270dso4428763b3a.2;
        Tue, 27 Aug 2024 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724780876; x=1725385676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCUSrgJ+TJUnurxjMntJCkv6+wXwXOpsEspjhz3H0Yw=;
        b=XbYJbH7rBpjD/HDL1RGX4gq675Ui6ijwGuPRro2XRZjsPmekCJcrME+MHzRSFtkf3j
         snmvaBvPFio0FzTWX3fFWIh54p3I56jH8YVgNTZg4KmnA3Tcxc5I1CX/tzO08urfO20n
         4JLBxclLSI0Rr8NHn26iNHfKf4+rpn/GWE/Z0UdcCmLaEXb14elAx9j/yCurrSIrZser
         Y+rzHT62gzzYfx/nFHuTlbXl3sRAjTERAcalNJi+cDyhwYuiZXOgPYvMQYE2KD5flC8p
         FvECKPKoj0wgTjDUfzomnuuQBXkUxiU8qzqgh8qRvOatWmlBBpSLJnXLbBpQA8z6pLPG
         pSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724780876; x=1725385676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCUSrgJ+TJUnurxjMntJCkv6+wXwXOpsEspjhz3H0Yw=;
        b=Xsk4d6rUx4FgTdBEPdw8U5BbVeKATxy/xYKstHbEwKrnSC+gg7rCkXpNVef8eE4MYq
         Ux5yyXZmXqG8xzFOGWE7SR4lTGJOtcD6V9qMpU0+pV2VtIX9AZrrg8+NXFHLt5JuV3IL
         7qyPfd8iljEDXI1wJdEOtcvqR0Pyxez10Sm9LJrw4r4rMOFQWmxO7Z460f2OX+2WEW0d
         hZagtsx+5sP1VVmMU+QOGwTeEJFyekVk3473KctSQE1P+yQigjVu/hg+BbttkLf+hxIP
         b/3pQYsho/20sfKChjxl9UNu7MkiGXEMWVPb3dxw4d9kFN3mOpZuBkQCKzcJAVGH8Nq3
         JlVg==
X-Forwarded-Encrypted: i=1; AJvYcCUsUuL2lrAygkPv3x4aKB7sfe7bUo0kVqzAlG4UxY3c41LaLdkkYaduYaaihk0KrWkcp+TJ8mGN@vger.kernel.org, AJvYcCWM2ReZ2+0v7Z2qXBs/rHO8qL/D7N+XkvIEW66zfOi5RGZKb85X1mg9RFb3xs00pUl0/kZEQfeI2S76FGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywis1sGc6HHjzmK1iXRI6V3qq5QDN+Gxa7BUxUILlUv54Vp+Km4
	VjdNfxCPByVTgBa4Eym/79Q44otVSiI8/FKCmZe8zXewXz9QsJAQ
X-Google-Smtp-Source: AGHT+IES6okLZnfj/yTGFxwPWh7nsD/tI3mz++Ei4dyFWneiXSsFd3im9erE2HEYmM+cxnd9sViCiA==
X-Received: by 2002:a05:6a20:4f18:b0:1cc:9f24:3d with SMTP id adf61e73a8af0-1cc9f240253mr7540278637.25.1724780876432;
        Tue, 27 Aug 2024 10:47:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2038556686asm86076995ad.40.2024.08.27.10.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 10:47:55 -0700 (PDT)
Message-ID: <ffd773a0-d71c-4647-b7de-b22a008849ab@gmail.com>
Date: Tue, 27 Aug 2024 10:47:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/341] 6.6.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240827143843.399359062@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.48 release.
> There are 341 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.48-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same problem as with the 6.1-rc, perf fails to build with:

In file included from ./util/header.h:10,
                  from pmu-events/pmu-events.c:9:
../include/linux/bitmap.h: In function 'bitmap_zero':
../include/linux/bitmap.h:28:34: warning: implicit declaration of 
function 'ALIGN' [-Wimplicit-function-declaration]
    28 | #define bitmap_size(nbits)      (ALIGN(nbits, BITS_PER_LONG) / 
BITS_PER_BYTE)
       |                                  ^~~~~
../include/linux/bitmap.h:35:32: note: in expansion of macro 'bitmap_size'
    35 |                 memset(dst, 0, bitmap_size(nbits));
       |                                ^~~~~~~~~~~
   LD 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/pmu-events-in.o
   LINK 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `record__mmap_read_evlist':
builtin-record.c:(.text+0x13578): undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `record__init_thread_masks_spec.constprop.0':
builtin-record.c:(.text+0x13b10): undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
builtin-record.c:(.text+0x13b68): undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
builtin-record.c:(.text+0x13b9c): undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
builtin-record.c:(.text+0x13bd8): undefined reference to `ALIGN'
/local/stbopt_p/toolchains_303/stbgcc-12.3-1.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.3.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o:builtin-record.c:(.text+0x13c14): 
more undefined references to `ALIGN' follow
collect2: error: ld returned 1 exit status
make[4]: *** [Makefile.perf:672: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf] 
Error 1
make[3]: *** [Makefile.perf:242: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [package/pkg-generic.mk:294: 
/local/users/fainelli/buildroot/output/arm/build/linux-tools/.stamp_built] 
Error 2
make: *** [Makefile:29: _all] Error 2
-- 
Florian


