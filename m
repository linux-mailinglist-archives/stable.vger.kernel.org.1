Return-Path: <stable+bounces-2631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96657F8E47
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 21:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FF3280D97
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 20:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D317D2FC43;
	Sat, 25 Nov 2023 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Ajtyo4A0"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B64F13E
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 12:00:13 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b844e3e817so1863800b6e.0
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700942412; x=1701547212; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=53DNDpNRMAslJDzfmwzfO7mAdRbjy7urTFcMMnTVJpE=;
        b=Ajtyo4A06bpFrBU1KGd/AKw8bj4dTrMBmA0dTzRQa5cv6ZmbxHC6CP6lY28GFnSc2h
         uzquFpkcR8TR6ZwAwtjm1e139kXHks95/evAK7Pi/zAOWerl1G2lwwjMOMgVXXZrm7td
         Ep27RVxDlggRYv1heEq2KPLyAtoOTk1Iv5H6e0OXf3OOhzGn5zTvfsMJpknYk4kEdwNf
         Ja9h7o57B4sNPS1F+i0MjQMrtb6pi2Z0Sj8k37XkNAtVfkZJB0cVKmwQ1YTYOsfyZZk9
         ZhgtaGN9kn9KGZI8mIZeHDUOsN4c+ln38J9d7hFKAa0q6jM0cwu95755mELfDffi6MTw
         4PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700942412; x=1701547212;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53DNDpNRMAslJDzfmwzfO7mAdRbjy7urTFcMMnTVJpE=;
        b=pk7Fnz/a1+Uy4GajNfacK5Xz9qNPb77+lNDRvYjlaCVdQZAG2DZsvEk0PDz862+EQZ
         7uiCZ8YQXTSxShrrZZoKgzfTlPU50UnE4okeVvAq0aNAP2f7eVVymUhQN75EoB030OH6
         17EGLTntYlg9DH8tp3HZJh9HduPGYhzkopBee7t/TQnrIooKOf0OtoImiJGlBRahXxlA
         19dzgZ+EvM21s8aggWXyftsWJdLCoz5B2EwzhvOBDUuUPpI20TWrXY+wI/aeeJBPCnVD
         mAyZcGkY1pl/lrZRsi9QklF0DFIFamnAoK2k8tYDHrbGuZ5KfqWen1aGfs8n5TJ2inGf
         fbKQ==
X-Gm-Message-State: AOJu0YxwJg2TFCCe5rZKcSSUzuVaC5nqV6v68PpW4Ptz56ahxp1dawDi
	e5aKSWC+jc8x6a8hnRoADTLlFinF6vazARHLLj8=
X-Google-Smtp-Source: AGHT+IEsIkHrhkffeFxb7K7wmwobGfxvFDFpiNbYhlksIv0GmVFFRa+yszdMfPuPm2O7o/eTtNY4UQ==
X-Received: by 2002:a05:6808:1190:b0:3b5:9724:9687 with SMTP id j16-20020a056808119000b003b597249687mr9301386oil.1.1700942412181;
        Sat, 25 Nov 2023 12:00:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78388000000b006cc09bd8591sm1067176pfm.20.2023.11.25.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 12:00:11 -0800 (PST)
Message-ID: <6562524b.a70a0220.bd05f.1ab3@mx.google.com>
Date: Sat, 25 Nov 2023 12:00:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-189-gd26c78c8f941c
Subject: stable-rc/linux-5.10.y build: 19 builds: 1 failed, 18 passed, 1 error,
 5 warnings (v5.10.201-189-gd26c78c8f941c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y build: 19 builds: 1 failed, 18 passed, 1 error, 5 wa=
rnings (v5.10.201-189-gd26c78c8f941c)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.201-189-gd26c78c8f941c/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.201-189-gd26c78c8f941c
Git Commit: d26c78c8f941c537dd7bf539fd4148257a231d8a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failure Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig+arm64-chromebook (gcc-10): 1 error

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    rv32_defconfig (gcc-10): 4 warnings

x86_64:

Errors summary:

    1    drivers/interconnect/qcom/sc7180.c:158:3: error: =E2=80=98struct q=
com_icc_bcm=E2=80=99 has no member named =E2=80=98enable_mask=E2=80=99

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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 0 warni=
ngs, 0 section mismatches

Errors:
    drivers/interconnect/qcom/sc7180.c:158:3: error: =E2=80=98struct qcom_i=
cc_bcm=E2=80=99 has no member named =E2=80=98enable_mask=E2=80=99

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
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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

