Return-Path: <stable+bounces-3863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BED803237
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 13:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82CA1F20FDA
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 12:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E47F2375B;
	Mon,  4 Dec 2023 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kC+zmh2E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DFBE6
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 04:12:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce3373be0cso1659013b3a.3
        for <stable@vger.kernel.org>; Mon, 04 Dec 2023 04:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701691923; x=1702296723; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OI6sPjp6nnD7W+vF9y5lZXXhy3bLHTCwjDX9EQP1LTU=;
        b=kC+zmh2EP4CwZj54pAhn38yqaxyJ+HOrFDrpevNQ9iVagFdZd1VZvJn2MwT/H3EriD
         JOtWz4IJrm2UOlPtzeEdTzWnUEPA3aoXKQGbcDqz7LU50Q7b9GPeCR6oDR1CftiDof17
         pK2DcKfAD/lzmWz9U7shCvg5F8wy2aID+yHrKxORy6O3GlwOHUMYmAV7Slg2idRFIqhQ
         MoCAceB7iNMl7sLZFyfeAZihu4nExP2+cxvOHyJwpoky6Y5v1IzeDFlCyNyPXDyUgvh9
         quCQUo8LZSK+LVzToKpoDAMD8UtR1i6x2OzpVvz7k5MTteBUQeuE1cXYdtb0/lH+3146
         29nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691923; x=1702296723;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OI6sPjp6nnD7W+vF9y5lZXXhy3bLHTCwjDX9EQP1LTU=;
        b=PhjocUUMTMT0TU5KTox+kxIWa+tz37WmgKWs9UrrDikHVXfi8M/HNoROFsG+P3ni/n
         Sud/koG4rYRcSlJHPydCaFW7KKj8c2R1hRFEeh0QzquSZQBH35NdIWzNseJHICBQGqF0
         0aBXN3BufSpGgIArFx3WWCkJPYXIq88ebbHH/k1/UtC/Veb4YPQxciNdaKmiRY2tzjY6
         3xWq+VjlDC8CCi9jXeXACaKkFGKPHydsJOY0FG+w8i8ZG0k8rRG6TANtv9lCx6YiZ5eA
         RZlm61ZLICa6mzVb3/OZwmKhH27mF1sXYcgQD/Tfe3oN6xD7+GqrleK+TJSkQ18XOPcW
         JfMQ==
X-Gm-Message-State: AOJu0YxrTqJ92gSZuHn9nd3VhQfpl5qhFIpKT5d7pizCy6NkTI9FJHg+
	Pp/BbKsZQrK3awdfYsltnmarmZ27SZfFLYHaoameXg==
X-Google-Smtp-Source: AGHT+IEumVDjTAhw9ChmbX6l6VMtoeG7UwNscy17EFgKHLByUc8WmAUzCu4F2kZamlffsimYQIZ7tw==
X-Received: by 2002:a05:6a00:3994:b0:6cb:a93c:dfd1 with SMTP id fi20-20020a056a00399400b006cba93cdfd1mr3926095pfb.14.1701691923278;
        Mon, 04 Dec 2023 04:12:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b006ce19a67840sm4180031pfo.199.2023.12.04.04.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:12:02 -0800 (PST)
Message-ID: <656dc212.a70a0220.27b86.8b94@mx.google.com>
Date: Mon, 04 Dec 2023 04:12:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.65-95-g9ea643fb97f9d
Subject: stable-rc/queue/6.1 build: 20 builds: 2 failed, 18 passed, 2 errors,
 1 warning (v6.1.65-95-g9ea643fb97f9d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 20 builds: 2 failed, 18 passed, 2 errors, 1 warn=
ing (v6.1.65-95-g9ea643fb97f9d)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.65-95-g9ea643fb97f9d/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.65-95-g9ea643fb97f9d
Git Commit: 9ea643fb97f9d02c5de515a8f66a8207ebd53596
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

riscv:
    defconfig: (gcc-10) FAIL
    rv32_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 error
    rv32_defconfig (gcc-10): 1 error

x86_64:

Errors summary:

    2    drivers/perf/riscv_pmu_sbi.c:582:26: error: =E2=80=98riscv_pmu_irq=
_num=E2=80=99 undeclared (first use in this function); did you mean =E2=80=
=98riscv_pmu_irq=E2=80=99?

Warnings summary:

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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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

