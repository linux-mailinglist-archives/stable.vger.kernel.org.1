Return-Path: <stable+bounces-1187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F37847F7E6E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA02B2179C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900902D792;
	Fri, 24 Nov 2023 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="MIqEpXpQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095A21BC2
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 10:31:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfa36bfe0cso6439545ad.1
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 10:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700850663; x=1701455463; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PjOJMrJdTP3N64Aueews0X6nnNenN5B5dWEI4M8Hb/I=;
        b=MIqEpXpQZdRerNJ+IBKS0sKVLGQT7/i90pE/nEl47T7Je3eefhmQL5zQ9hPT+Vzr4k
         s9nX1brF2VLC0At86FVQ1CkJ567nDrxSp3L8rPePEK+vcjjUUuvKUyGCGjuWwYpU7kzK
         StRnlWm3i64fn58Sja4n4JFe2+ns8O2ykqEsCdV1fPyD+EMbOtSX/z3ImZZdfgH76oxn
         PC58eICiiufTq2Nxi0PMsfkmI3jOuJEk/qa1NN/xtWqOXTDzsCExWspmQTeZKtXjxX6i
         nTalSDCM+wjfLifBFy3MtE1+449WQI1BhMkYrbQjapkLghpJKGk+UvsbWx0F2IiGAtMS
         TKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700850663; x=1701455463;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjOJMrJdTP3N64Aueews0X6nnNenN5B5dWEI4M8Hb/I=;
        b=E/BLCnCmk5mcZfrSF776qho6PdTGuAqzrRnf9eYA3mkvrbPtqlfn5jnuH6up4twwrz
         I7D3YcUr6XxX3GOBGoFFjM8zobWNLJbnmZ2jDt3PK0c8pzIG3gR3mUkvfe9wiMEdyEXG
         SLqfQZdbnFkF0ssdAfqNyEcUPk2m6WMFKy7CNrcNxx7RiIlbB3mkGsjVVntWXu1tzGwA
         Wp3/1AHGpy7GSF+c4qQRgG7EeTFQX9quuTIDmraWBzNhmrCE9LwrBwn6gwmYLLvHtkmv
         C06HGIwcX7O+G1RRRf/JMlBIEwy9G7LPb/PvhAdDCEU81KsX3f4iFuxi/QekgID9VN6z
         V6Sw==
X-Gm-Message-State: AOJu0Yy03r3UZZBQl6+QgLJ/ODNVJ5bYfvXvFrxfoO38fF4edxAIUrrI
	8U8lE51ZPvSJKEhaFB7zBjmKwDVd+744UawtIVk=
X-Google-Smtp-Source: AGHT+IFaL9ZQV1kRVD4GtX5lRqyZ+5E+74LfJiVLIKJN0zwdoy4VWAU7KGW7Y02j6lsDeMocclSJjw==
X-Received: by 2002:a17:903:1207:b0:1c6:11ca:8861 with SMTP id l7-20020a170903120700b001c611ca8861mr9622155plh.21.1700850662974;
        Fri, 24 Nov 2023 10:31:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902c1cc00b001cf96a0e4e6sm2829972plc.242.2023.11.24.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:31:02 -0800 (PST)
Message-ID: <6560ebe6.170a0220.11552.7407@mx.google.com>
Date: Fri, 24 Nov 2023 10:31:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63-373-g1c7c44f0ebc86
Subject: stable-rc/linux-6.1.y build: 22 builds: 6 failed, 16 passed, 7 errors,
 6 warnings (v6.1.63-373-g1c7c44f0ebc86)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y build: 22 builds: 6 failed, 16 passed, 7 errors, 6 wa=
rnings (v6.1.63-373-g1c7c44f0ebc86)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.63-373-g1c7c44f0ebc86/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.63-373-g1c7c44f0ebc86
Git Commit: 1c7c44f0ebc86aed1ff4cb85ea5ef3507e6e3ca8
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
    tinyconfig (gcc-10): 2 errors, 2 warnings

x86_64:
    tinyconfig (gcc-10): 1 error, 1 warning

Errors summary:

    4    kernel/rcu/rcu.h:218:3: error: implicit declaration of function =
=E2=80=98kmem_dump_obj=E2=80=99; did you mean =E2=80=98mem_dump_obj=E2=80=
=99? [-Werror=3Dimplicit-function-declaration]
    2    drivers/perf/riscv_pmu_sbi.c:582:26: error: =E2=80=98riscv_pmu_irq=
_num=E2=80=99 undeclared (first use in this function); did you mean =E2=80=
=98riscv_pmu_irq=E2=80=99?
    1    kernel/rcu/rcu.h:218:3: error: implicit declaration of function =
=E2=80=98kmem_dump_obj=E2=80=99; did you mean =E2=80=98kmemdup_nul=E2=80=99=
? [-Werror=3Dimplicit-function-declaration]

Warnings summary:

    5    cc1: some warnings being treated as errors
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
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 section =
mismatches

Errors:
    kernel/rcu/rcu.h:218:3: error: implicit declaration of function =E2=80=
=98kmem_dump_obj=E2=80=99; did you mean =E2=80=98mem_dump_obj=E2=80=99? [-W=
error=3Dimplicit-function-declaration]
    kernel/rcu/rcu.h:218:3: error: implicit declaration of function =E2=80=
=98kmem_dump_obj=E2=80=99; did you mean =E2=80=98kmemdup_nul=E2=80=99? [-We=
rror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors
    cc1: some warnings being treated as errors

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

