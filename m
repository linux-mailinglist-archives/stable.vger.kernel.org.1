Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D57D26EC
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 01:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjJVXOT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 19:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVXOS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 19:14:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34257E4
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 16:14:16 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-564af0ac494so1413854a12.0
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698016455; x=1698621255; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jtt51zjlmO1dOkqmvOpZuUtsmtI1i7oPdK4MaS6+Yg=;
        b=CUyViFXDQiPZqZKFm776FBtJNwUrLWrhd7+C35tdJd1WKvbXivGHbLPLvGX9Zidio0
         HS1YO8Wu1v7p4YT538Ur3ssyi1xczY4F7qaDO3Ud8xu3fZOzxbn8SGy5BLOQQavIb1C1
         TUroTFHFEuP1rOFDAAIv44b2gTSyPsvV1hNNSTJrRyv3X/+DysFCNWVMSKvbcbMxdKjW
         nIfnwUfVedYjkArRQmBt7gXKtCgOf2Z/ENaKjyI5k9u7+N3sWEOg3y9F4Km+kYlC62ol
         dhpo3xvNFfGPcDIgNUhANAfmAXEpuv/v5w1Y704Yk73/9DqRmqCNnM0YhmYw/Wg8AMty
         I5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698016455; x=1698621255;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Jtt51zjlmO1dOkqmvOpZuUtsmtI1i7oPdK4MaS6+Yg=;
        b=Jkz1pJEjm5rqJyyxCUodIq0TqnK/mDJurJ3KdoiuzHCXhjdKg6ZSnIIy3cu5C89ydV
         WLoVVphEp56FIDiCnsSWjWHEkg4A+eRhXGXjxJjH14a3P4r3uKyqsssCQ4hZzU6TorG5
         2n5C2xiOLIXOwICU1MO3ZQShAMY7+PNtujM5Px+WutA9IfhZvF6wNCX+5UF4+iWZFH2e
         1B0pUynWBWYQLVHCq43s6nCRvobJoVeBzxyvwtYR39B4j0/G9TFJT52wjVGA67NTonKS
         WkfWBydQOwL35UYlf//Ch1UPEY/YVH3A0VeyDTjCbI5y6oku6wtHeMKVjUikpfc0ByAM
         exaw==
X-Gm-Message-State: AOJu0YxSs86+1aWe8OUwpWl5igULpQ5t45GtjxU42XMDxNglwAXTc46p
        pVo0H++vAvqC+/S9+9Vfo3uwk+Krf1o/cdTMA7fWDw==
X-Google-Smtp-Source: AGHT+IEWGVdLdMvuwxJea23ftpIbI333dCOSLwMv8vT33SGWE72Ec5EtRxhWIYaCqWO6Twf3xJnjuw==
X-Received: by 2002:a05:6a20:8f26:b0:17e:45d0:7036 with SMTP id b38-20020a056a208f2600b0017e45d07036mr515330pzk.11.1698016455204;
        Sun, 22 Oct 2023 16:14:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b006bee5ad4efasm5039357pfn.67.2023.10.22.16.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 16:14:14 -0700 (PDT)
Message-ID: <6535acc6.a70a0220.6ddac.f312@mx.google.com>
Date:   Sun, 22 Oct 2023 16:14:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.135-238-g07ec13925385
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed, 6 errors,
 7 warnings (v5.15.135-238-g07ec13925385)
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

stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed, 6 errors, 7 w=
arnings (v5.15.135-238-g07ec13925385)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.135-238-g07ec13925385/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.135-238-g07ec13925385
Git Commit: 07ec1392538558957c4a37a8a5428190020c8f50
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

x86_64:
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning

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
    2    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unr=
eachable instruction
    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

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
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
nommu_k210_sdcard_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
