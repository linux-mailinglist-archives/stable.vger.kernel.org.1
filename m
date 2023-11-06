Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A677E2C92
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 20:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjKFTCl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 14:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFTCk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 14:02:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81982A2
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 11:02:37 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-280cc5f3fdcso4558835a91.1
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 11:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699297356; x=1699902156; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E5uCwD7Jm22T45YfRZiUiJRWsygbnKGB3tdLNCqhMnI=;
        b=gvIqs8jX1HJ6NTuZLvs9Opr9L4paI4JH15E1oRMvQK8/ol9JCvXMdyD8oYxnheuYA2
         4ilAU31xY8Mgrex+Tfpo4r+O/5KAr/lncCE5oJ8dtJUgw+ZAKZ+ZF64+hMKEcqDuNRhQ
         OD711ItElxw5Thqj5aIpw/j01O39542gUDByK0z9OQyfAEegIyul9GkHdyH4OCNCECRX
         IUvmHagiEhAUCXFWR6T5bGSenLsQZpjvSFj3OrtT1IEejEXVB4F76+yr0C/zOZ7VKrBd
         9CXFRKsHE4VFfSsmOgNbmcwQQVOLR2v8ZI2YaYSC7vsFIIBefWH2Zr1Qo9lSYipa+q13
         qCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699297356; x=1699902156;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5uCwD7Jm22T45YfRZiUiJRWsygbnKGB3tdLNCqhMnI=;
        b=imtgj0TYNv9XR/SqxrgdV212chEAy68r2hBHy6Oroj//5A04HSkS0rPRIOmA+uEYsl
         aUPtBmN6spTOcg3F7IHaE/rbsMYX4XrHkOT8Qia22AGiQnTLEpz4uSoT4bwSzfx5hjhl
         +hWkhyJ0lfNGz16OeY0m99Mp44QxT1kkHlRuzCg4uQiIBh/7UsDiqppt2oMAaMGuj5Ru
         bD3SSoJ/0+21qSf4hi5BoNBXLaqtYS5gREXSoosow1n1A2jhm5+xfWTOxF9ELJkL1eqX
         VWahdoDb4BjZvZWg2bUs7hIrmHcDyDyIYPv44GJC1iLADj/lcHFgFmNhqNNB9gHlSjpx
         se7A==
X-Gm-Message-State: AOJu0YydOlPdIBn5Wp/Wy4A64UVcWXD/XFfw8zIcRmeN4RKlz6WKoHze
        M9Zn//c2JTLzfKNpGSC+EnrCBDC2op9BFfX6+gzYdA==
X-Google-Smtp-Source: AGHT+IEmDU2g6WgGd6Cv5R+ehDn+WcswUExVwSGpalffP12EehE5RZzAMFITbrWwZopPPDlaR5/Haw==
X-Received: by 2002:a17:90a:fd8a:b0:27d:ba33:6990 with SMTP id cx10-20020a17090afd8a00b0027dba336990mr22914157pjb.10.1699297356467;
        Mon, 06 Nov 2023 11:02:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c34-20020a17090a492500b0027768cd88d7sm8870842pjh.1.2023.11.06.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:02:35 -0800 (PST)
Message-ID: <6549384b.170a0220.9cccc.81ed@mx.google.com>
Date:   Mon, 06 Nov 2023 11:02:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.199-96-gfed6441dbe524
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y build: 22 builds: 6 failed, 16 passed, 6 errors,
 9 warnings (v5.10.199-96-gfed6441dbe524)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 22 builds: 6 failed, 16 passed, 6 errors, 9 w=
arnings (v5.10.199-96-gfed6441dbe524)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.199-96-gfed6441dbe524/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.199-96-gfed6441dbe524
Git Commit: fed6441dbe524de2cf3a6a40d5d65c369bf583a0
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    nommu_k210_defconfig: (gcc-10) FAIL
    nommu_virt_defconfig: (gcc-10) FAIL
    rv32_defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    allnoconfig (gcc-10): 1 error, 1 warning
    defconfig (gcc-10): 1 error, 1 warning
    nommu_k210_defconfig (gcc-10): 1 error, 1 warning
    nommu_virt_defconfig (gcc-10): 1 error, 1 warning
    rv32_defconfig (gcc-10): 1 error, 3 warnings
    tinyconfig (gcc-10): 1 error, 1 warning

x86_64:

Errors summary:

    6    drivers/irqchip/irq-riscv-intc.c:119:3: error: implicit declaratio=
n of function =E2=80=98fwnode_dev_initialized=E2=80=99; did you mean =E2=80=
=98zone_is_initialized=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings summary:

    6    cc1: some warnings being treated as errors
    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.
    1    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    1    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]

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
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section m=
ismatches

Errors:
    drivers/irqchip/irq-riscv-intc.c:119:3: error: implicit declaration of =
function =E2=80=98fwnode_dev_initialized=E2=80=99; did you mean =E2=80=98zo=
ne_is_initialized=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

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
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section mis=
matches

Errors:
    drivers/irqchip/irq-riscv-intc.c:119:3: error: implicit declaration of =
function =E2=80=98fwnode_dev_initialized=E2=80=99; did you mean =E2=80=98zo=
ne_is_initialized=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

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
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 =
section mismatches

Errors:
    drivers/irqchip/irq-riscv-intc.c:119:3: error: implicit declaration of =
function =E2=80=98fwnode_dev_initialized=E2=80=99; did you mean =E2=80=98zo=
ne_is_initialized=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
nommu_virt_defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 =
section mismatches

Errors:
    drivers/irqchip/irq-riscv-intc.c:119:3: error: implicit declaration of =
function =E2=80=98fwnode_dev_initialized=E2=80=99; did you mean =E2=80=98zo=
ne_is_initialized=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 3 warnings, 0 secti=
on mismatches

Errors:
    drivers/irqchip/irq-riscv-intc.c:119:3: error: implicit declaration of =
function =E2=80=98fwnode_dev_initialized=E2=80=99; did you mean =E2=80=98zo=
ne_is_initialized=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section mi=
smatches

Errors:
    drivers/irqchip/irq-riscv-intc.c:119:3: error: implicit declaration of =
function =E2=80=98fwnode_dev_initialized=E2=80=99; did you mean =E2=80=98zo=
ne_is_initialized=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
