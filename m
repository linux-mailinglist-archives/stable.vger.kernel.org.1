Return-Path: <stable+bounces-6387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3D80E205
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 03:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EFF1C216F8
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 02:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9FC1FC5;
	Tue, 12 Dec 2023 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="rh8knubU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EABB5
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 18:43:54 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce72730548so4457400b3a.1
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 18:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702349034; x=1702953834; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lJXHhRahGXryOSSiyB4vAJPQa6F6yjpKTyRhvMQ7ci4=;
        b=rh8knubUdf4u3XBTJve8dZrBoW1DGTDADnTSaYqwVN8iUdEoVIaIrI2x1MuMj0dHJe
         Jc6ButvZVfjpdm21M0XmJbZGLD01RDRbH2R3VRHt7M1lQjYLU3CSQcEtK0FLpbghMzGp
         A+ft0fOB379OPWiWMI+S2a1sZvJDUwT+hWtrfQLQHB5IUhqAAzzHHUhQ9FmoYAzBL95+
         rlEyAF33pzrl1EoFZ3+VGvBZRdpaBxTHG81p6eXlxl87Qw2Rb1wkolkx+8OETrJ1pxBB
         sv1ln40W0y5Q6jgO7u748lE75aESKd4rUEUvE1PhyvFZ8mDIMUUN02NABd2K89isyM5K
         Rwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702349034; x=1702953834;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJXHhRahGXryOSSiyB4vAJPQa6F6yjpKTyRhvMQ7ci4=;
        b=Or7/FFH3tIo4asxLqGqrwCnF2niGeFoby+VeTU3EPzsyL17iZ1q3I3Pb//Fec4GNsi
         OHvUVcQIkxJNzCK9F7lDIzby8c2s3OiDN/3HWT4X/LfOSmuztLded+gts/2SAR9/0CAm
         PQIw7mfH1dkjgZaP0BD+6Gb2hNzyvsFdriv7Oewgs8yTT3uS/DICCI2m+XZeFDK/A4SJ
         +xsszp4zV46mqa6Qgay+0yTbMS4nrglvUru2ezwIppYtnJBxl4R0e/u83s2uwvfCN9ZT
         ghLSRs45yQCXXcdhIVYNCOa6IuxePMzpZtF+x1rCEBt9lKLZxSDwbRTZ+cE6y857lVJ1
         5KTw==
X-Gm-Message-State: AOJu0Yyh6NpMvS4HQmlO8Nvp5MoHmy3+qYmVC28cGV3bSg3584DBLjuR
	oTbW8szrR0VQuhJ0mcHzYb2xvYONZioj3byKayaNLQ==
X-Google-Smtp-Source: AGHT+IGtYcE+MitpVEoR6WVzNQa0ms8uTS3B0al/YjvAs2mPy2swKgPxu1/Ijx79m+M6KV/7z17BLA==
X-Received: by 2002:aa7:88cf:0:b0:6ce:7a8f:af7c with SMTP id k15-20020aa788cf000000b006ce7a8faf7cmr6236544pff.12.1702349033812;
        Mon, 11 Dec 2023 18:43:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e23-20020a62aa17000000b006d0a424f0basm605862pff.42.2023.12.11.18.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:43:53 -0800 (PST)
Message-ID: <6577c8e9.620a0220.13342.32ea@mx.google.com>
Date: Mon, 11 Dec 2023 18:43:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.142-141-g2244f7059734c
Subject: stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed,
 6 warnings (v5.15.142-141-g2244f7059734c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed, 6 warnings (v5.=
15.142-141-g2244f7059734c)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.142-141-g2244f7059734c/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.142-141-g2244f7059734c
Git Commit: 2244f7059734cf86b4882d73b7953fbaa3e59712
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

