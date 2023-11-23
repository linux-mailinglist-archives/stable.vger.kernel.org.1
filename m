Return-Path: <stable+bounces-4-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC3A7F5645
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 03:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDDA1C20B91
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 02:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4371FB8;
	Thu, 23 Nov 2023 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2Hy54M41"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2818A1B2
	for <stable@vger.kernel.org>; Wed, 22 Nov 2023 18:06:57 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f5d2e4326fso289867fac.0
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 18:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700705216; x=1701310016; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W4a+e8jeIKASuqC74dRGabApvN069y5fxa5auiufRYQ=;
        b=2Hy54M41KnfhmmFp+dZLPPxj9ePakJen4Pn4lOeRAYoYXgOof6uqXEhV2GwhJQYJt/
         oj6Dm4zUYIF2/pIDCZcBrXHacCr1kXLrKh4bhNSA9yS+xtA4BlkhE5tjSqr3FWPcvssV
         L3mp9q+cZxGojTthmYtdJGKF+43LgmqXBw8h02pa/YV3SKnisaVWx1puF1JjFAW7rEKg
         sr28o/3/7r+OxNcGuE6V5eNYziF3GtQw2cgrubfoML+NX+Bk8ESDIVmK4LFR5aNCcBog
         KKabghDzhc8vnqhvSdQDSiTZiCplwICiGVK0pDPmbfuY0k5s7eDO1Ivm9aqmE0D0hRaI
         8f8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700705216; x=1701310016;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4a+e8jeIKASuqC74dRGabApvN069y5fxa5auiufRYQ=;
        b=G7mULJdSCm2mt05IQexq2mrEDfLkEsJkJNtxNPQJT8f3ofGMR9HpJO47dgs93IgdVd
         RP54cgw/xMKf67bFNHwJ2vhZbABH+Gsm4KVa4+nuOR9hbT5tLrOh1gCftL9wr38COh/k
         zuUHSJNUh5Bgbxsq5ghSSZNzXwUI34isoN0PQLOf0sz+yUpXLqoFv+OwejZNsCGLo514
         AO/xfsBWXl0Hsk2ckO3o+184dXUvVDUVJD3Yh5/TdNcdMu/vXOz/HcNxajTxzF6eJ3H1
         2o3Nujny9jVvcVKEZToTShX6yUpgOZoWdYUIOoYC5diIYmd2aoSc+M/OYYFKCe7NVAW/
         0eIQ==
X-Gm-Message-State: AOJu0YzMjYNtQtho4hT5aICQEX2fQYccHXL/F8rLVoD+4BZJCEoS+JVg
	GPY1C0XpkK2hQ1dp2vSruFkBnzWxSE1fXze0C5U=
X-Google-Smtp-Source: AGHT+IENlXRGrWijunIVjr8AtaBBRcYll2+/tl0imP3+bw+9X/X1aH2/GPgCRU2BBtzw+5tVit5w4A==
X-Received: by 2002:a05:6870:b91:b0:1ef:b591:5733 with SMTP id lg17-20020a0568700b9100b001efb5915733mr4698630oab.15.1700705215821;
        Wed, 22 Nov 2023 18:06:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b006c33c82da67sm133738pfe.213.2023.11.22.18.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 18:06:55 -0800 (PST)
Message-ID: <655eb3bf.a70a0220.3e4e.07d1@mx.google.com>
Date: Wed, 22 Nov 2023 18:06:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63-236-gfd300c969e06
Subject: stable-rc/queue/6.1 build: 22 builds: 6 failed, 16 passed, 6 errors,
 5 warnings (v6.1.63-236-gfd300c969e06)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 22 builds: 6 failed, 16 passed, 6 errors, 5 warn=
ings (v6.1.63-236-gfd300c969e06)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.63-236-gfd300c969e06/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.63-236-gfd300c969e06
Git Commit: fd300c969e06ce802c2fd24217f52eea87204999
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    tinyconfig: (gcc-10) FAIL

i386:
    tinyconfig: (gcc-10) FAIL

riscv:
    defconfig: (gcc-10) FAIL
    rv32_defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

x86_64:
    tinyconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    tinyconfig (gcc-10): 1 error, 1 warning

arm:

i386:
    tinyconfig (gcc-10): 1 error, 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 error
    rv32_defconfig (gcc-10): 1 error
    tinyconfig (gcc-10): 1 error, 1 warning

x86_64:
    tinyconfig (gcc-10): 1 error, 1 warning

Errors summary:

    4    kernel/rcu/rcu.h:218:3: error: implicit declaration of function =
=E2=80=98kmem_dump_obj=E2=80=99; did you mean =E2=80=98mem_dump_obj=E2=80=
=99? [-Werror=3Dimplicit-function-declaration]
    2    drivers/perf/riscv_pmu_sbi.c:582:26: error: =E2=80=98riscv_pmu_irq=
_num=E2=80=99 undeclared (first use in this function); did you mean =E2=80=
=98riscv_pmu_irq=E2=80=99?

Warnings summary:

    4    cc1: some warnings being treated as errors
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
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section mi=
smatches

Errors:
    drivers/perf/riscv_pmu_sbi.c:582:26: error: =E2=80=98riscv_pmu_irq_num=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98ri=
scv_pmu_irq=E2=80=99?

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
rv32_defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    drivers/perf/riscv_pmu_sbi.c:582:26: error: =E2=80=98riscv_pmu_irq_num=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98ri=
scv_pmu_irq=E2=80=99?

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section mis=
matches

Errors:
    kernel/rcu/rcu.h:218:3: error: implicit declaration of function =E2=80=
=98kmem_dump_obj=E2=80=99; did you mean =E2=80=98mem_dump_obj=E2=80=99? [-W=
error=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section mi=
smatches

Errors:
    kernel/rcu/rcu.h:218:3: error: implicit declaration of function =E2=80=
=98kmem_dump_obj=E2=80=99; did you mean =E2=80=98mem_dump_obj=E2=80=99? [-W=
error=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
tinyconfig (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section mi=
smatches

Errors:
    kernel/rcu/rcu.h:218:3: error: implicit declaration of function =E2=80=
=98kmem_dump_obj=E2=80=99; did you mean =E2=80=98mem_dump_obj=E2=80=99? [-W=
error=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section m=
ismatches

Errors:
    kernel/rcu/rcu.h:218:3: error: implicit declaration of function =E2=80=
=98kmem_dump_obj=E2=80=99; did you mean =E2=80=98mem_dump_obj=E2=80=99? [-W=
error=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

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

