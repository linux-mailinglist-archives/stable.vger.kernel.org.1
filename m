Return-Path: <stable+bounces-65947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB494AF96
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 20:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DAF28139B
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF22D482E2;
	Wed,  7 Aug 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEZXMK+H"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E00413F43A
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054955; cv=none; b=sL3OJAJMrhz/jxyVEcDLqLvwDotZxslxGrts0xTWmF39xkh54AYTqPWPgMu/sIJgVP06z7UeH0iwy2MiQwfc0GK5V9E+7qmEGIJvyZ49YSydv+6l59QFKKgw5bHZDG2hTppfZZM2nX065mx7iedX6QSvz/tzhX0XYE81B+zaXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054955; c=relaxed/simple;
	bh=DYdsVlyg7drIWq2ZvwnPQj6pYo01O2qmVRaRyE4nV9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqK+jH9gfmty+4FWzfmIGVjexDNQANPk1gYrsU52R++FZcVWFgkKc+u5WwoWZ43G4bIBgiObAbTOQF4LF5YCPbh+0cCFp9YJ49IHJN4OF8tzkL4yLR8H8EyxtAU1dLmHQjQna0f0H+BtyZCiuET7FkVTpxHfv13v9s6Pfd2z+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEZXMK+H; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7093b53f315so43335a34.2
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 11:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723054951; x=1723659751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2a5gwKJnS3ln2m/beFUHLu530BIgX8IlloupPMeXcM=;
        b=FEZXMK+HV/l0JjYcwofEtAK5d3EqszNs7IWB09NPN//fQs6mJJDFQ6vaxP4FYhNk0f
         7gpXvJnombcaOM2gVeRl0xD1jsx5bhRNZhmgs8Wnz1Za88DlN1pRH6s+XD36j5RX4YA3
         H582By+iIwEX6UNJZqC3I6XlecR8qJAZTpBa5bKf5FOzWOHgIK+7fHiC8Q+FgTbZRe+h
         663T0unqddfLo01mIzYFHmNg00MsMvRGSrjRGXi0Dn8WA1Uwj+jhe2d/T6nClNNBMtjm
         wZIt9zl0PocJmjFeWxglfRCGucPzjRwBXG1lBCdN5wvedXWh6CTqGrO1UowqKgqdwSld
         e+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054951; x=1723659751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2a5gwKJnS3ln2m/beFUHLu530BIgX8IlloupPMeXcM=;
        b=fRu/k7DKc69+hLEq0QnvPdDZAGZbcPKA+afkjoya8/ReVy6RcOgoUzpLF/w+fhmcN3
         L9+i9M3t1FlYtJ3mBufsX8ix4We6fKrXarv1Dar/ajijOVsJd6oLZ4ipS7hDgIsndmrg
         YdXJwAuM1mMiweKNzM9VQHKmuOk0OqEJxbq8DL0I07qMR90d9b/yIEsPAOHsZzyFezt3
         r5JowUBmmweoaAcR31yUH63btnIM0CK21WUWW5ozeEhceepEoSIOXBlaGWzQ5MT6WTnN
         C3G3nGAcAvedSVIlHAjz/BlYHHshKz88ThvEsOOEq0HOpAv+mgOjYcB0KuiTFqF8LRfQ
         S12w==
X-Gm-Message-State: AOJu0YxFJqwF9S4Z690p838qHiuDzjOJlWPACi4KT77glg4EneXPsy4K
	KAzvINhyxDUaRpEtCfPN7dsHufG9+rU6VIQNqGLfraF4DfsBunUfk3v7Ing0loIAkJMb1ov33AH
	vPoMt90UwguxV/XtlCRMe5Fw7lP13p+mzFgxNKw==
X-Google-Smtp-Source: AGHT+IFZ1nAFr030oa9R5aIs6OoTYFYue3ihojrDjSX2FR8yDRlkkM18UrBwPRgt2PB0EDlQJykjHoClLour8qFtiNg=
X-Received: by 2002:a05:6830:6318:b0:709:41c2:5104 with SMTP id
 46e09a7af769-709b3218e10mr26258465a34.8.1723054951256; Wed, 07 Aug 2024
 11:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807150039.247123516@linuxfoundation.org>
In-Reply-To: <20240807150039.247123516@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 7 Aug 2024 20:22:20 +0200
Message-ID: <CADYN=9Jbqec210z5wZXVJV0vsi2QJK4TBJ6DULObW+bZRd4Q-g@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 17:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.104 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Aug 2024 15:00:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.104-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following kernel panic noticed on stable-rc linux-6.1.y on while booting
qemu-arm64 and qemu-arm.

  GOOD: v6.1.102-441-gdbbffaaee188
  BAD:  v6.1.103-87-gb22fe5fc2a45

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The git bisect results pointing to,

    irqdomain: Use return value of strreplace()

    [ Upstream commit 67a4e1a3bf7c68ed3fbefc4213648165d912cabb ]

Kernel panic:
--------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.1.104-rc1 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils
for Debian) 2.42) #1 SMP PREEMPT @1723045420
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
...
<6>[    0.000000] GICv3: GICv3 features: 16 PPIs
<6>[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000080a0000
<1>[    0.000000] Unable to handle kernel paging request at virtual
address ffff0000c003150d
<1>[    0.000000] Mem abort info:
<1>[    0.000000]   ESR = 0x0000000096000061
<1>[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[    0.000000]   SET = 0, FnV = 0
<1>[    0.000000]   EA = 0, S1PTW = 0
<1>[    0.000000]   FSC = 0x21: alignment fault
<1>[    0.000000] Data abort info:
<1>[    0.000000]   ISV = 0, ISS = 0x00000061
<1>[    0.000000]   CM = 0, WnR = 1
<1>[    0.000000] swapper pgtable: 64k pages, 48-bit VAs, pgdp=0000000042120000
<1>[    0.000000] [ffff0000c003150d] pgd=180000013dfd0003,
p4d=180000013dfd0003, pud=180000013dfd0003, pmd=180000013df60003,
pte=0068000100030707
<0>[    0.000000] Internal error: Oops: 0000000096000061 [#1] PREEMPT SMP
<4>[    0.000000] Modules linked in:
<4>[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.104-rc1 #1
<4>[    0.000000] Hardware name: linux,dummy-virt (DT)
<4>[    0.000000] pstate: 600000c9 (nZCv daIF -PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
<4>[ 0.000000] pc : irq_percpu_enable
(arch/arm64/include/asm/atomic_ll_sc.h:203 (discriminator 2)
arch/arm64/include/asm/atomic.h:65 (discriminator 2)
include/linux/atomic/atomic-long.h:329 (discriminator 2)
include/asm-generic/bitops/atomic.h:18 (discriminator 2)
include/asm-generic/bitops/instrumented-atomic.h:29 (discriminator 2)
include/linux/cpumask.h:411 (discriminator 2) kernel/irq/chip.c:396
(discriminator 2))
<4>[ 0.000000] lr : irq_percpu_enable
(include/asm-generic/bitops/atomic.h:17
include/asm-generic/bitops/instrumented-atomic.h:29
include/linux/cpumask.h:411 kernel/irq/chip.c:396)
<4>[    0.000000] sp : ffffc6d51bd6fb00
<4>[    0.000000] x29: ffffc6d51bd6fb00 x28: 0000000000000018 x27:
0000000000000001
<4>[    0.000000] x26: ffffc6d519227000 x25: ffffc6d51bd98000 x24:
0000000000000008
<4>[    0.000000] x23: ffffc6d51b3c0008 x22: 0000000000000000 x21:
0000000000000001
<4>[    0.000000] x20: 0000000000000000 x19: ffff0000c0061800 x18:
0000000000000006
<4>[    0.000000] x17: 000000000000003f x16: 00000000ffffffff x15:
ffffc6d51bd6f5f0
<4>[    0.000000] x14: 0000000000003f9f x13: 0000000000004000 x12:
0000000000000000
<4>[    0.000000] x11: 0000000000000040 x10: ffffc6d51be2db60 x9 :
ffffc6d51989695c
<4>[    0.000000] x8 : ffff000020000270 x7 : 0000000000000000 x6 :
0000000000000000
<4>[    0.000000] x5 : ffff000020000248 x4 : ffff392be25e0000 x3 :
ffff0000c003150d
<4>[    0.000000] x2 : 0000000000000001 x1 : 0000000000000001 x0 :
ffff0000c003150d
<4>[    0.000000] Call trace:
<4>[ 0.000000] irq_percpu_enable
(arch/arm64/include/asm/atomic_ll_sc.h:203 (discriminator 2)
arch/arm64/include/asm/atomic.h:65 (discriminator 2)
include/linux/atomic/atomic-long.h:329 (discriminator 2)
include/asm-generic/bitops/atomic.h:18 (discriminator 2)
include/asm-generic/bitops/instrumented-atomic.h:29 (discriminator 2)
include/linux/cpumask.h:411 (discriminator 2) kernel/irq/chip.c:396
(discriminator 2))
<4>[ 0.000000] enable_percpu_irq (kernel/irq/internals.h:194
kernel/irq/manage.c:2396)
<4>[ 0.000000] ipi_setup.isra.0 (arch/arm64/kernel/smp.c:939
(discriminator 3) arch/arm64/kernel/smp.c:932 (discriminator 3))
<4>[ 0.000000] set_smp_ipi_range (arch/arm64/kernel/smp.c:978)
<4>[ 0.000000] gic_init_bases (drivers/irqchip/irq-gic.c:568)
<4>[ 0.000000] gic_of_init (drivers/irqchip/irq-gic-v3.c:2227)
<4>[ 0.000000] of_irq_init (drivers/of/irq.c:607)
<4>[ 0.000000] irqchip_init (drivers/irqchip/irqchip.c:32)
<4>[ 0.000000] init_IRQ (arch/arm64/kernel/irq.c:136)
<4>[ 0.000000] start_kernel (init/main.c:1045)
<4>[ 0.000000] __primary_switched (arch/arm64/kernel/head.S:469)
<0>[ 0.000000] Code: a8c27bfd d50323bf d65f03c0 f9800011 (c85f7c02)
All code
========
   0: a8c27bfd ldp x29, x30, [sp], #32
   4: d50323bf autiasp
   8: d65f03c0 ret
   c: f9800011 prfm pstl1strm, [x0]
  10:* c85f7c02 ldxr x2, [x0] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: c85f7c02 ldxr x2, [x0]
<4>[    0.000000] ---[ end trace 0000000000000000 ]---
<0>[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
<0>[    0.000000] ---[ end Kernel panic - not syncing: Attempted to
kill the idle task! ]---


boot log:
-------
   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.103-87-gb22fe5fc2a45/testrun/24787696/suite/boot/test/gcc-13-lkftconfig-rcutorture/log

details log:
-----------
   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.103-87-gb22fe5fc2a45/testrun/24787696/suite/boot/test/gcc-13-lkftconfig-rcutorture/details/

Build log links:
-----
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2kKvVPIRvZ26DxUefAqM4a0PwOs/
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2kKvVPIRvZ26DxUefAqM4a0PwOs/config

metadata:
----
  git_describe: v6.1.103-87-gb22fe5fc2a45
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: b22fe5fc2a455ab65a78fe39d86ef3a300d87243
  git_short_log: b22fe5fc2a45 ("Linux 6.1.104-rc1")


--
Linaro LKFT
https://lkft.linaro.org

