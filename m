Return-Path: <stable+bounces-2552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706567F85B8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 22:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E391C20A32
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D453C46A;
	Fri, 24 Nov 2023 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="DL/INOYf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DD5C6
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:59:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2859966cf81so503349a91.3
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700863175; x=1701467975; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AxPtyfgmVKonJD2S8Ah2OMGQ4DbdytMqYtXVV8DcIx0=;
        b=DL/INOYfPWShycVq5wfiDSqCLU6KnhY4A/K2EifLnJvmx/GsZ9Axm9sabjoZYeo2QW
         GdvvewqSFAPMesx3abJYMCEqN47JuZXYLdtrB/pR1QSD//2Lbo+W51W2zjkPqHpVL4C2
         GK0RXNL+UCsMaFN/zC5AhoRrAx3Vfs4GdA4DlMVQRYwVNMRmTfK82vp2f/WtJu+QGHw0
         HytFC6FMbfCgnc0JxmUMX6NrNhhPIAGHLE8iml9xHpDbUnf7FST5K5wKQOSMUOGvmZ8f
         bAFCmUKSwSAy8fX38ZX3YQlHtlx1dwEVxaddUYPBrSxcTiwI8E0gdTrESAmtVuiW4+lP
         JIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700863175; x=1701467975;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxPtyfgmVKonJD2S8Ah2OMGQ4DbdytMqYtXVV8DcIx0=;
        b=GEGSpI9J+f3GRkPXdSESKLqGQjCBJv7kPzAIoFJbXPJvnWHU4bl3AQDUo+aPv0XkRN
         h5hgSv+alfWwVnTFW+59IKgtONr0SaWrFEaVlm8QMf50kRCdbEK02uKnF/c0a724DSNc
         qXKsnSpX5Ptc/38/IopNDPav2I3mxfediO2heY3SFr8oZroWQd1hmP3C3Okn3B2jLD2G
         o9wkUl7LjIu5KuwEspDNXgNivh3PHVKznaAkG3yIv+18REoKFwbchHhF0wQxPN29XZZ9
         Svuzry8FtzHQGTwqkCN3pcf4QWktxhjFM4tsgH3DyvjNVNSBRdnQjR391/HpnEDCJ2Y9
         k4QQ==
X-Gm-Message-State: AOJu0Yyk52BpQOgLOawCD4HlqCkYhLebCXc4WwFDiym+oNQiDfZNSNDK
	pd+auNXjfAMfvMUPf6Nv1Sn1CJThN7UpV+7t3fY=
X-Google-Smtp-Source: AGHT+IGO+xQh+ZH1ZhGoZG4osg3jmG8kO88EBAajk+id3PUkuuGS0dcWGtF7tTHWs70dUJhqAYGwKQ==
X-Received: by 2002:a17:90b:3846:b0:285:9408:2fb8 with SMTP id nl6-20020a17090b384600b0028594082fb8mr3116740pjb.43.1700863174829;
        Fri, 24 Nov 2023 13:59:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ob14-20020a17090b390e00b00285a17f9da1sm109597pjb.43.2023.11.24.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:59:34 -0800 (PST)
Message-ID: <65611cc6.170a0220.bb7d4.06ed@mx.google.com>
Date: Fri, 24 Nov 2023 13:59:34 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.63-372-g864c65286fa4c
Subject: stable-rc/queue/6.1 build: 22 builds: 6 failed, 16 passed, 6 errors,
 5 warnings (v6.1.63-372-g864c65286fa4c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 22 builds: 6 failed, 16 passed, 6 errors, 5 warn=
ings (v6.1.63-372-g864c65286fa4c)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.63-372-g864c65286fa4c/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.63-372-g864c65286fa4c
Git Commit: 864c65286fa4c167631e562c3be95b8b75f8e912
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

