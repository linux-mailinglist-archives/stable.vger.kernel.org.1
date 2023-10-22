Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF62A7D262A
	for <lists+stable@lfdr.de>; Sun, 22 Oct 2023 23:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJVV6D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 17:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVV6D (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 17:58:03 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF0E6
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 14:58:00 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so2066587fac.0
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698011879; x=1698616679; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jM7xtUN8+FMFzdg+qEgYZbWhwBxi6uyoJ7cyLWmTpFY=;
        b=XRaWcekHEDT+by3BhORVYsDjpBqjEa72uVU5k8GJe5FnNJMMHHB1xgGtBaWXyqVNli
         SwvT+bYKtP+/s26n+oCz0rCL7wfAlSJPwWGdX5sTqU43HROJO436KD4q79KVzJwe20Fd
         EMooS57HetXx7rtHQr0MJDSV0pkbAA3NfYQaa3UCsEJTGjgt8k67juOGckT81/wk2ilr
         m/x1d8iXUb5AmjKMhNdfbtKg/tmqfhexFrFDX15dSaujOsPG8LQmgbhhMgLZNrvuxwrz
         7ExEKBWjuamLJ6JwV4Gwz9SgiVjzVYnChfmOP6mPMAjPbOpl821vid/F7xTSz6c4kME3
         k7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698011879; x=1698616679;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jM7xtUN8+FMFzdg+qEgYZbWhwBxi6uyoJ7cyLWmTpFY=;
        b=hzd71gX7HrOxvxhruE0r0B2bvk7f6hV36DYmSmi7kJE2iYoRiL5dukivBFONHYoOLl
         Y1KHDevp60jmGUlo+Ve00o1gmX/nMQqfO9dynWJcfo/t9lHQ5GLR4tEZrqDUnicaX0st
         fbAp7+c8YlLEyjIxwxQO3Dnq5K64uN3ztFT0zti5FWOVq76sDsuIXWa5BGw9kAaithzR
         G3DtLlGTtk7jKI1jYuPthucUS2El8Nws5utAD51Pwca7Ba9Dlo/FPnmm9gxrIOJpsKdW
         tVZCLmS92pbtfLyYrFjsEXzWZgSP5Af12X67wZuj5UPA2TjqX06mWhQ/jT75yo8x/AnJ
         y+Zw==
X-Gm-Message-State: AOJu0Yw+ZbltAdBkIRfmuiuxL1wJ1k9rVsER+WU7iXVKNpcotF02/+fO
        NLrXNdqNgRXhi6PFFfGC4CV1FSMlbkVOMrJpz4pJTQ==
X-Google-Smtp-Source: AGHT+IGzjQyqPgxAShxk+TrUXpKqj/d2E9HS/Xe40Fw/gtOM2EADjPgR1ZNqGitmOAleAKky39wtuQ==
X-Received: by 2002:a05:6871:530f:b0:1c5:56f:ac08 with SMTP id hx15-20020a056871530f00b001c5056fac08mr10991323oac.12.1698011879574;
        Sun, 22 Oct 2023 14:57:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g16-20020a056a001a1000b0069302c3c050sm4914838pfv.218.2023.10.22.14.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 14:57:59 -0700 (PDT)
Message-ID: <65359ae7.050a0220.320c9.e7df@mx.google.com>
Date:   Sun, 22 Oct 2023 14:57:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.198-202-g380033a2840c
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y build: 19 builds: 2 failed, 17 passed, 6 errors,
 9 warnings (v5.10.198-202-g380033a2840c)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 19 builds: 2 failed, 17 passed, 6 errors, 9 w=
arnings (v5.10.198-202-g380033a2840c)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.198-202-g380033a2840c/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.198-202-g380033a2840c
Git Commit: 380033a2840c0b70c0b22ea637a3b20ea8691c8c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm:
    imx_v6_v7_defconfig: (gcc-10) FAIL
    multi_v7_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:
    imx_v6_v7_defconfig (gcc-10): 3 errors, 2 warnings
    multi_v7_defconfig (gcc-10): 3 errors, 2 warnings

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    rv32_defconfig (gcc-10): 4 warnings

x86_64:

Errors summary:

    2    drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of fu=
nction =E2=80=98gpio_irq_chip_set_chip=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
    2    drivers/gpio/gpio-vf610.c:251:2: error: =E2=80=98GPIOCHIP_IRQ_RESO=
URCE_HELPERS=E2=80=99 undeclared here (not in a function)
    2    drivers/gpio/gpio-vf610.c:249:11: error: =E2=80=98IRQCHIP_IMMUTABL=
E=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98IS_IM=
MUTABLE=E2=80=99?

Warnings summary:

    2    drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struc=
t initializer
    2    cc1: some warnings being treated as errors
    2    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    2    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]
    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 3 errors, 2 warnings, 0 s=
ection mismatches

Errors:
    drivers/gpio/gpio-vf610.c:249:11: error: =E2=80=98IRQCHIP_IMMUTABLE=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98IS_IMMUTA=
BLE=E2=80=99?
    drivers/gpio/gpio-vf610.c:251:2: error: =E2=80=98GPIOCHIP_IRQ_RESOURCE_=
HELPERS=E2=80=99 undeclared here (not in a function)
    drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of functio=
n =E2=80=98gpio_irq_chip_set_chip=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]

Warnings:
    drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct ini=
tializer
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 3 errors, 2 warnings, 0 se=
ction mismatches

Errors:
    drivers/gpio/gpio-vf610.c:249:11: error: =E2=80=98IRQCHIP_IMMUTABLE=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98IS_IMMUTA=
BLE=E2=80=99?
    drivers/gpio/gpio-vf610.c:251:2: error: =E2=80=98GPIOCHIP_IRQ_RESOURCE_=
HELPERS=E2=80=99 undeclared here (not in a function)
    drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of functio=
n =E2=80=98gpio_irq_chip_set_chip=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]

Warnings:
    drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct ini=
tializer
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sect=
ion mismatches

Warnings:
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
