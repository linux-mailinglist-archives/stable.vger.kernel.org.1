Return-Path: <stable+bounces-5029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB6680A651
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 15:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7471F20F33
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF311200C0;
	Fri,  8 Dec 2023 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Qq1UyMJx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832473277
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 06:55:15 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cebbf51742so1229308b3a.1
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 06:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702047314; x=1702652114; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zsV8GN8g4qkoDQYh+/qI0n/Lr10MyzUVOITf333oAI0=;
        b=Qq1UyMJxyMfE+VE28+Me1JfHFidkRGk49QxBdrTAy4UJHMdx5LCQqz1ltMviptVb87
         6CqvaAveeo0ypw1NRiQBsaD5RAJhuqCMWq4r2e08gvES8rrtawAtN30yPKmiV1Qo9RhF
         rSIcDfnwaTR3mN7GRmc7qlIgcu1EzeVTlCZPK/sowqv4qGiY6HL1BVWZxwUGwco2L7JV
         sQ/oYvKHaj3Eo6oE8+qk2B7dyZLBDtyeqoLl/poSULYvJmYKb1FNz+kFzcXVDCEOS6ws
         uomP2cSC6EqrGA4qdfuIYp3gc6itii9Yfr3HOd6ROXo5evjfXi8QBdLojVVP17kxKsAF
         B/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047314; x=1702652114;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsV8GN8g4qkoDQYh+/qI0n/Lr10MyzUVOITf333oAI0=;
        b=kdSkkCm2vCFZ9ZJOzhvgrKC6M8Ez0CmbXRj9ffHwe+Jg7Lb1bD5XVMPADF3hpGgBrp
         S/zO6lNx+Ef4fnw3t/ZsdBXrBBtlU4Fpoz6nkBQhGI8wctDwH6QQlAnmJ0+WorSRGL+W
         zXLyCPEmWcTZJZ5DbwdnAol07sCe2T8ZvRO/kWoFza9UQto4RxX5dj3KD9FNDNbf/a7f
         xCmWkDldPXnwIbNO2wrIosod7OZmBhkDl302W1agqHRiFqH+0wAzhWPYFvvAJY+6lAQK
         XA4ZyIkT7CU7CyG0zE/GKRCwOEdWogrpsPxjuBCAoqtQWeifFNKAUCQW6A730g9KFV9y
         og2A==
X-Gm-Message-State: AOJu0YwRJ/JIXDtXhyZWwotakgzL1dCJ4lG3D0wZ1dfWcOfUazqJW3Rc
	vqPoXfRVRrjLvR92sHiZnbaFuaV5qPxQx2xMbVZh7Q==
X-Google-Smtp-Source: AGHT+IGZ8ftFjibraVrYt+VqzxtqbSCf2/rjyS08ffms3xfcnjpxWIJqTYH/QxhRMUwopc1WkueJ2A==
X-Received: by 2002:aa7:888b:0:b0:6ce:6448:4961 with SMTP id z11-20020aa7888b000000b006ce64484961mr1358428pfe.12.1702047314422;
        Fri, 08 Dec 2023 06:55:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n23-20020a056a000d5700b006cbb40669b1sm1674632pfv.23.2023.12.08.06.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:55:14 -0800 (PST)
Message-ID: <65732e52.050a0220.baa9c.5517@mx.google.com>
Date: Fri, 08 Dec 2023 06:55:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.203
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.203)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 5 warnings (v=
5.10.203)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.203/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.203
Git Commit: d330ef1d295df26d38e7c6d8e74462ab8a396527
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    rv32_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    2    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]
    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

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
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sect=
ion mismatches

Warnings:
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]

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

