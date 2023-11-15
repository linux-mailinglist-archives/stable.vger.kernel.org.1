Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EE07EC44A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 15:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbjKOOBr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 09:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344045AbjKOOBq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 09:01:46 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD1E1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 06:01:42 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b58d96a3bbso3842919b6e.1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 06:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700056901; x=1700661701; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nPR/b0ruaoxhfEUcvGs4XBHlISKLQqHDiO+dJIjKCwg=;
        b=ikdW0wIOK7qjf1ObOGXFy1E+9IlglruZMLLQmjH4Z6oF19wx9GIi71/OxyLxrAXNxo
         m5dBXx7zw4IN0FIAGPmXJ80ygUDs4e6t5/Zhg3oWEHG9fExcLe4PaH0KiCajGXSvt9iK
         1q5L1+77yo054D5sc0zfw2d/nlXVZVl2vtv2pkH1ukqq8RF/oTbRW/X5fCyJW/Kl8kZZ
         FDS6ltWHg2xDjLbvhal7FO4SDs0fvJnr6/s/Q1tXdfGQ1A2sLxYtBqJMxEoeELzzxtDp
         /TjxavCV99JJazKVFHdQlIzoCwv1sEqlDl9/uFShVPzSQZFWDYhvjDCqY4njk86lc52+
         sNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700056901; x=1700661701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPR/b0ruaoxhfEUcvGs4XBHlISKLQqHDiO+dJIjKCwg=;
        b=jLl7zqhMY+OLLYzCxm4/shrEqtxza93i7//QZD0iSo2tnVp5y5vaPgWIPX5ZsBLLzW
         h/eYuQox2Cj9C9MdEwrzKQ/4mRxUS0DCZ5DYtznar5ITfIq0wYPZGEKQxPDvokF4Tlqt
         1PhSRzT1PqDn6WYBvmb/Z2oDD4rWRP5OCnv0+JfAX4gDnOUhoipsJJpyWi9MNyT4GWDk
         S/lPAssB2PMk56imh90DeAZkLL8mosZtVRYUw6K5vlJ3thcXU5Fcn0LBp6VOQ0ANozYS
         ydWVj3uBVyZUSAyEWnUma0X12MX7Of5tIo6+7PLyPaBqbu+b2FDSExKYxPOPbXUOKoc1
         hfJw==
X-Gm-Message-State: AOJu0YwBpvbHMUka4UQiyrGlGG9Aj5/qg6N9Z3r7fWlsX3DgPaJNpHmI
        ejOJuZGOrkNjgW3zHBtwAgXBYo+09Aakh7yAwemqOw==
X-Google-Smtp-Source: AGHT+IEAWTWikU6fEEAnMMlXuzZqb5HDnFBgj2BtFq7uSLd1Qeyizdz2tftAB0fE1j2IkiEflo2tIQ==
X-Received: by 2002:a05:6808:1804:b0:3b6:cdc2:51a0 with SMTP id bh4-20020a056808180400b003b6cdc251a0mr16008011oib.29.1700056900878;
        Wed, 15 Nov 2023 06:01:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l127-20020a632585000000b005acd5d7e11bsm1227159pgl.35.2023.11.15.06.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:01:40 -0800 (PST)
Message-ID: <6554cf44.630a0220.850aa.2fee@mx.google.com>
Date:   Wed, 15 Nov 2023 06:01:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.62-378-g9ce5a8fc2d2c
Subject: stable-rc/linux-6.1.y build: 20 builds: 4 failed, 16 passed, 3 errors,
 9 warnings (v6.1.62-378-g9ce5a8fc2d2c)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 20 builds: 4 failed, 16 passed, 3 errors, 9 wa=
rnings (v6.1.62-378-g9ce5a8fc2d2c)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.62-378-g9ce5a8fc2d2c/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.62-378-g9ce5a8fc2d2c
Git Commit: 9ce5a8fc2d2ca8f3eb9ba50c48a535163ea71d0e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

i386:
    i386_defconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-board: (gcc-10) FAIL

Errors and Warnings Detected:

arc:
    haps_hs_smp_defconfig (gcc-10): 1 warning

arm64:

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning
    vexpress_defconfig (gcc-10): 1 warning

i386:
    i386_defconfig (gcc-10): 1 error, 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 1 error, 1 warning
    x86_64_defconfig+x86-board (gcc-10): 1 error, 1 warning

Errors summary:

    3    kernel/trace/trace_events.c:1015:17: error: unused variable =E2=80=
=98child=E2=80=99 [-Werror=3Dunused-variable]

Warnings summary:

    4    kernel/trace/trace_events.c:1015:17: warning: unused variable =E2=
=80=98child=E2=80=99 [-Wunused-variable]
    3    cc1: all warnings being treated as errors
    1    kernel/trace/trace_events.c:1015:17: warning: unused variable 'chi=
ld' [-Wunused-variable]
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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    kernel/trace/trace_events.c:1015:17: warning: unused variable 'child' [=
-Wunused-variable]

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    kernel/trace/trace_events.c:1015:17: error: unused variable =E2=80=98ch=
ild=E2=80=99 [-Werror=3Dunused-variable]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    kernel/trace/trace_events.c:1015:17: warning: unused variable =E2=80=98=
child=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    kernel/trace/trace_events.c:1015:17: warning: unused variable =E2=80=98=
child=E2=80=99 [-Wunused-variable]

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    kernel/trace/trace_events.c:1015:17: warning: unused variable =E2=80=98=
child=E2=80=99 [-Wunused-variable]

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
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    kernel/trace/trace_events.c:1015:17: warning: unused variable =E2=80=98=
child=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    kernel/trace/trace_events.c:1015:17: error: unused variable =E2=80=98ch=
ild=E2=80=99 [-Werror=3Dunused-variable]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warn=
ing, 0 section mismatches

Errors:
    kernel/trace/trace_events.c:1015:17: error: unused variable =E2=80=98ch=
ild=E2=80=99 [-Werror=3Dunused-variable]

Warnings:
    cc1: all warnings being treated as errors

---
For more info write to <info@kernelci.org>
