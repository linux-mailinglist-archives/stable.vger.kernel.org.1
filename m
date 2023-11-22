Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A110A7F4DA4
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 18:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjKVRAC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 12:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjKVQ77 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 11:59:59 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941871A8
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 08:59:52 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cbbfdf72ecso11998b3a.2
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 08:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700672391; x=1701277191; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pZLLhY/aHNJFq8+H5zmAX3VGPGSRvAiIbtiUULtEuIA=;
        b=LBPEvH2WI972XJFwaa+nwKV+MVLFmeEhfcb1jnc9T+Cp9jzo9wQQJ7TG7nVu+th5LS
         dCyDl9C+7f7M2vF4/xHOp1QyVRvjoWi1sVpdxAd7lS6Udql0v5ojeB3uGWBDzhQUPOns
         UIBxrm6CgwTdTlIzyzSc4+eNDJl3cp1wkKVbntco/+JpwfR2JJeB/NSn6dkMZ3lX+Yft
         aGHfcfe9liZuPex+JveiqFPPVdfIGn9Msod4XIZUIz/yVW3JovUSnCwYH7g15xR1HzG/
         8fBKggRfk1tkPCeqBfc8mCKgIaDi8C/mEbnyvstdUiC4nMCFcYE2C2Q6U8M30dD54Psn
         skVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700672391; x=1701277191;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZLLhY/aHNJFq8+H5zmAX3VGPGSRvAiIbtiUULtEuIA=;
        b=FbKHllcVXL91GTGlJfPaL8xmyRgGeA5sAtfrcfq8K0J8+JKHAb2FXqtRh8FtMjdxjE
         6zidoyZcr2031qKcqctNDQ4bj4B1EszEgKuPze974cfPIvY1FtDfXGhlB3/8XifQ7Luq
         UfPKYzwEPh1T0BKsclIuHaC/t3bVnXW2VTZJx3VJCEMvlbwIP6nOtLgha3iSkhzwIfY3
         yK/Ch0iQirTgBYgKvKPVuzxoMq7OhAvD8UJ71xT/tDSiaVd6TASy3a4lFt01N0AS99oh
         Y6tf6Aq0oRUprrMyXPWPqYXj3n9W8MMozoS6d/m848LKUkgeOwkC9ZdtlVeaUl6fnSvi
         sYXA==
X-Gm-Message-State: AOJu0YzOD9JisPvcnJBT5xtAxDG6ADkUJIge6Ntthtc5Ey+pf1VTdfUj
        ahIha9HWA6muH6pq1maHDMwkEIIsR4Yf7fJ0MdY=
X-Google-Smtp-Source: AGHT+IEmjnRfVxjsfmoIBaGJSKXuLhqU0vz/100K8GAci0hXGu0jmroE4LdpgT6RjLqHXFRAbfiddQ==
X-Received: by 2002:a05:6a00:1a87:b0:6cb:b7b5:389f with SMTP id e7-20020a056a001a8700b006cbb7b5389fmr3706071pfv.6.1700672391103;
        Wed, 22 Nov 2023 08:59:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o73-20020a62cd4c000000b006930db1e6cfsm10484768pfg.62.2023.11.22.08.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:59:50 -0800 (PST)
Message-ID: <655e3386.620a0220.396ec.dbdc@mx.google.com>
Date:   Wed, 22 Nov 2023 08:59:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63-176-gecc0fed1ffa4
Subject: stable-rc/queue/6.1 build: 22 builds: 6 failed, 16 passed, 6 errors,
 5 warnings (v6.1.63-176-gecc0fed1ffa4)
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

stable-rc/queue/6.1 build: 22 builds: 6 failed, 16 passed, 6 errors, 5 warn=
ings (v6.1.63-176-gecc0fed1ffa4)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.63-176-gecc0fed1ffa4/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.63-176-gecc0fed1ffa4
Git Commit: ecc0fed1ffa4a325e93ac9121a6b1dbdfbd9fa95
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
