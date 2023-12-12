Return-Path: <stable+bounces-6397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3898580E34B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 05:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E049D282D89
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 04:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52526C8F8;
	Tue, 12 Dec 2023 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="r175PmXK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF766BC
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 20:28:11 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d33574f64eso52681227b3.3
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 20:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702355290; x=1702960090; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cfdxccAt4KdhaumEJfLYqcTeFvU+v4ADLR+2LOCzY4E=;
        b=r175PmXKHQE4GvcHt2ikO72qaLsOdaq3x0lknp+/5qjT+xGlCESQonFMatMabTtE4F
         br2aROL6g8kiNjoxbezyXu+/0zclJ8UrQoxfUTh8FNYnaCfzgLte8r+NCXLMI7QzwCEc
         HyoN0ruB6SecJM98luf9IaBEa11r71kuQCvado/5YTzTg1i4XNeROx4mewuopHPQgbkL
         o2l3Plng5kTZIOeWe8G6nsQr9w0u288iqcTtNe9qbnkvRvxk4W1OuDWLI6GKqbd5yvJ0
         D+qF7IjJqTK2Qe25fEV8wEGt/oQv5RbJ3xfDCEzQC7DFfJ5ye1JqKu9rEmnoULALRTOF
         DABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702355290; x=1702960090;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfdxccAt4KdhaumEJfLYqcTeFvU+v4ADLR+2LOCzY4E=;
        b=ZHqc7y6P6fF8tG1ibH/IZESbSdNXbIl9HcQH/xUxIHnqi2C3JIaOlotxevNnlMn31+
         WJ0BjchUyKmcdUB0f5ZG6KnCQ/D8Z95l9kp0gtn9GFmLCcAgjiBw5ePBw3Z/JjXSfQqL
         65UaE5gTo08ABnDFISkr2aqC3cQr39v78pgQyEtsUYGUDypUE4tz13YV/6NPfnQtgxet
         xSZrZtZrqQjJFMG1iGflDRJAWfL5ATdor2FU5yiFbOJqNrcBlhRGW3VVs0EAQcJBfl0E
         Qj3iFBXOKRbm2PSy8lEhB7dgrmOBIX6EkeMCEK5ss0CzN7cvIZViVWbAb5c+rAURmK6f
         msMA==
X-Gm-Message-State: AOJu0Yz8In0rCy+5HtSMuUb3FNTZuWr4lb81j8iRT8BybH893C63+5xG
	ShSer/XWibB/0AjNYxN0pMzrJOo913nuY73M8eUilQ==
X-Google-Smtp-Source: AGHT+IGDZI/TAnkUNM3eXw0DG7zLoz1GHs1t70YnKAL2JKn0fRxz7r+JLh0FPbuuocKm+L+cQ80Frw==
X-Received: by 2002:a0d:e851:0:b0:5de:a261:9076 with SMTP id r78-20020a0de851000000b005dea2619076mr4667015ywe.5.1702355290525;
        Mon, 11 Dec 2023 20:28:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902aa4a00b001b86dd825e7sm7456728plr.108.2023.12.11.20.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:28:10 -0800 (PST)
Message-ID: <6577e15a.170a0220.5c569.5e63@mx.google.com>
Date: Mon, 11 Dec 2023 20:28:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.142-142-g83fb9eaaf8115
Subject: stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed,
 6 warnings (v5.15.142-142-g83fb9eaaf8115)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed, 6 warnings (v=
5.15.142-142-g83fb9eaaf8115)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.142-142-g83fb9eaaf8115/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.142-142-g83fb9eaaf8115
Git Commit: 83fb9eaaf811580c8f9c768023db10686fd30985
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:
    i386_defconfig (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-board (gcc-10): 2 warnings


Warnings summary:

    3    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of ne=
gative value [-Wshift-negative-value]
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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

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
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 war=
nings, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

---
For more info write to <info@kernelci.org>

