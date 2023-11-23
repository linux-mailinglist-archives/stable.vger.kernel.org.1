Return-Path: <stable+bounces-71-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4701D7F61D3
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 15:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B932B21586
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B762E843;
	Thu, 23 Nov 2023 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="fumc/vgV"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4671B3
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 06:45:13 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35b0fc91c81so3003215ab.1
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700750713; x=1701355513; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LLeABsJzOPJ3qror8PweXB944CNSV58aAntkfypgKR8=;
        b=fumc/vgVwahl8Dsle3XFpvQvvSt3SI23i6/qJ7BQUiIxBo6xY+jWhW0ceoqFKm7aGy
         tfUNklnAcng1HqF9ll9paf+sq3RvJMNbcSpBoa+7zcajMWZb7iT6wEsOF8t701m4F9ou
         7G8+4x+mAYqm6Y+Su/RR2lTITF71KXbf80k5Nk3aHN5CjRAd6ajWZtdz96pqemnkuxGc
         evyQkZmF0CagRpwoNiWEzM+8yufcGpsnxAn3qb6HWaqZvuLqd8i4tuayDqKDGEws8D9Z
         p6FHt7os6fn7E4MfgI2DT7YAWZA2Qo3I2vrhtETPYdqVEsODkVUXzf7bnQvETbSfwELx
         pJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700750713; x=1701355513;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLeABsJzOPJ3qror8PweXB944CNSV58aAntkfypgKR8=;
        b=eMH0ty2EJoT4Emwuuvv3ukOdN5EKEpd4m/SQ6Ddjbr7u4u0x5Ja7GevXsT0KQYaJJs
         Hjx98Kv7R7RqGI5PHKMlNqSZ71LKo2WTBFl1YWbxKbjau+yKMJ7omC6uUp5OY6KeVW4O
         klYR90esB/91rJbDSW9P8ZFnDx+doj2JKQRTsL/DArdBguKRF8QurHOM2iIDkz8nTIxM
         wtaITQIfC0EG9xKLELh66mRqv/5UaMZMSMGxoMx3g+2QNy5Pw0yv+G5hRRAAeDFBYmae
         0PQblHfSEUeYyJG1ruw1veq/K9HyLLbjG/SZC2/3pleSNYEzDr7kU97sE6xyyBD++HEc
         T16g==
X-Gm-Message-State: AOJu0Yz06xWn/bE6S7VUy35AjwPhNEsSIfZBo2lu//BnBR97vCJlpm1n
	Iiyw0IhKxxJ7ufk2sEkSfgP5OI/eT5DIcgbPVWc=
X-Google-Smtp-Source: AGHT+IHfwQ9Xv0PssQQJutBvfwzv0rRGKAhLCA2hG+Cly5WPFSpXQVXrVj10KzkGMY4BfbT+hdJXog==
X-Received: by 2002:a92:dac6:0:b0:35b:28e3:9023 with SMTP id o6-20020a92dac6000000b0035b28e39023mr5825432ilq.21.1700750712688;
        Thu, 23 Nov 2023 06:45:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b38-20020a630c26000000b005b7dd356f75sm1396881pgl.32.2023.11.23.06.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:45:12 -0800 (PST)
Message-ID: <655f6578.630a0220.ab70e.2fd8@mx.google.com>
Date: Thu, 23 Nov 2023 06:45:12 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.63-262-gc57a2560e7ce
Subject: stable-rc/queue/6.1 build: 22 builds: 6 failed, 16 passed, 6 errors,
 5 warnings (v6.1.63-262-gc57a2560e7ce)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 22 builds: 6 failed, 16 passed, 6 errors, 5 warn=
ings (v6.1.63-262-gc57a2560e7ce)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.63-262-gc57a2560e7ce/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.63-262-gc57a2560e7ce
Git Commit: c57a2560e7ce0f2a2c5ef9429fe1146b6fd191c8
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

