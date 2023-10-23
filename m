Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FA97D384C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJWNm4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjJWNmz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 09:42:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22E6E4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 06:42:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so3286032b3a.0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698068572; x=1698673372; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=blMeHra8SjoTecPzlZ/5s3XcNc1PP0KfuitkYlFgCHo=;
        b=wCoo4i9d/AOJsP4n2brZac5Gnq+Py64Qc8PmhA+ofGqno3kgDlo40AckGq/C0Jaxxr
         weVMH1cG1Ll1K94JZC7zLLWxWx6VLaEiOBh7NYBEiTOO7Z8ZM98LQUss1Reqtdocmauk
         VeOM6CqV4b8kAZFazE3RnTBj86dgESaodBxYwuWK8SNYZkrgAQOzS1fd+GsN7Wy65Lt8
         DN+sw0JSgV+PdbvAbh/fqA5FB/WO7K9X29uTrIdkWLPnitZF/Bt6HV+1UcTwdRnLOnsp
         vaZiPKrV9XMO8TCXqJp3tIx3A2Mv198Ger2zQRlSxERNIsrImoecP3+TZrEAa2UKbvbH
         RR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698068572; x=1698673372;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blMeHra8SjoTecPzlZ/5s3XcNc1PP0KfuitkYlFgCHo=;
        b=n8ZQ94yp8JsXiQ8/88WQnVhpzGYJdAseYaIH7ybJRiXNBVRoTlGYdy7gsUck1E80QX
         ye5KxdDPtEA9fpz6BFgcH9MXgvB1wbPUfx757JeK+1iriJvl0sRHt7TbWzofKwXBhfdm
         wXoBtgqqC1nw8LpPgBUa/7ZDGLa9dkZ20JRBnCbnStnww6jf3WkTIULfsvdNX8HSWbm9
         C92ZeUB9ScoBfFjctUxXDSy+RZQhLLVfk4jX5tK0GDNLzgfzSPtiA8OTgFjX6iu+tWPD
         NzqO4eO9IvwHw8MEwpnKhVn2liY89m1Z0nd+zqY+MnUPtsjadQShmKNUjV/KWM90ss9B
         x/3w==
X-Gm-Message-State: AOJu0Yy3YJTz1DI5kRkRo42PahQOJa0kdCel9hZ4SezZ97WvUan6o0qE
        C2wCdS4CVHCcwMpwu/xpl2fcoflt3+5Ksdb6dE1j7g==
X-Google-Smtp-Source: AGHT+IFdzHrDPcXVDjqU1D8D1n53xzFJkljku3Cj0tkPI+LPhjsFZFQVfFCqu8N2c5QfBVXrUcrpXw==
X-Received: by 2002:a05:6a21:a59b:b0:17a:e941:b0a3 with SMTP id gd27-20020a056a21a59b00b0017ae941b0a3mr12408033pzc.39.1698068571717;
        Mon, 23 Oct 2023 06:42:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k126-20020a628484000000b006bddd1ee5f0sm6409718pfd.5.2023.10.23.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 06:42:51 -0700 (PDT)
Message-ID: <6536785b.620a0220.4e101.2f29@mx.google.com>
Date:   Mon, 23 Oct 2023 06:42:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.198-203-g38f629e2a1b6
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y build: 19 builds: 2 failed, 17 passed, 6 errors,
 9 warnings (v5.10.198-203-g38f629e2a1b6)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 19 builds: 2 failed, 17 passed, 6 errors, 9 w=
arnings (v5.10.198-203-g38f629e2a1b6)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.198-203-g38f629e2a1b6/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.198-203-g38f629e2a1b6
Git Commit: 38f629e2a1b66d0f082821ff1a5eb5af0a8e4862
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
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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
