Return-Path: <stable+bounces-76-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D52067F6386
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 17:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327C5B21116
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6C335F0F;
	Thu, 23 Nov 2023 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bY+9+yud"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C710C9
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 08:04:41 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso875113b3a.2
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 08:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700755480; x=1701360280; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sxPIFCe6OBJsmfIDqttmlvlNIXFJfHlHdp2B/AnZxOc=;
        b=bY+9+yudVSLPCvg88nHVctpboJEOc8s+tUHX7sRy5XI5CmB1piCEFz6g1rEWWW/lF0
         wV6uaMDsZWCETSwGyf51Y5h6B3RewVcnrWTuRabjEplCGfDzJa1cBJjbbB+5Dsf1QtGv
         Eren3tw7zv7sLbxtHOrKQ/MH74KrvplX0uYGyHuyshG1H+NxWRxFeKXvR/TtQ6dQDacO
         LBspI9ixhRzzO2hD//PuOGaBCNn1xafO+Mi/H/DGse9/LvyH1edBE1JKqWxh9HBG2LCz
         26Pq2szutnWPWJQuX8HcT6EjJraa0ZEE2+M/q/KoVhzluJHpM4kshHO4hujQQqd8nSia
         9YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755480; x=1701360280;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxPIFCe6OBJsmfIDqttmlvlNIXFJfHlHdp2B/AnZxOc=;
        b=OIg2snDQP9l83SCxJaqLavCb6KWUr5bRIMObbUEt5NisG8x1+dj8s4UTzUc7jT4kZ4
         U/6QbDRzBD95Cmv2/TLqVW2/2BUQV4VarD/xWpk9Cb2UH6VZ3FmEnfD4k3nkNWoTaJbt
         De1fP9XphdcD+ZPEhENcIhoqD91LxOpAr6gr6A5HSIbNsuYA2mF0Tjy39Mw9VZs+s7rS
         t8zMEWzvrLsHTJ1uZUJKBtJERmQV0Ka6/F8zatqYUNwzdcRes9npx6V+ZEPAjkTIBydL
         c2m0kb3aJ44deprjaD5n868PJwX1NJtqwY430FuOtyJP3Xwp98XYKTXBfjUKblSPtzG8
         sXsQ==
X-Gm-Message-State: AOJu0Yxvnud6lY9yymyuFKd1qFJHLqAGAgywNhrr4sMqS5IYpFyGxevM
	JWdPjuQu6dzqcgaLqZRoYfks2oGs/puIHIuVXoA=
X-Google-Smtp-Source: AGHT+IE7n/mj92iheCJIXh/yn3FyYvwShslTw490/T4pzU7XU0Ofi1isVfRjCrmiY3/l6vF1tL0e5w==
X-Received: by 2002:a17:90b:4d90:b0:281:8e9:7b86 with SMTP id oj16-20020a17090b4d9000b0028108e97b86mr6120428pjb.23.1700755480279;
        Thu, 23 Nov 2023 08:04:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090a158900b00283a2488643sm1569084pja.41.2023.11.23.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:04:39 -0800 (PST)
Message-ID: <655f7817.170a0220.15827.391e@mx.google.com>
Date: Thu, 23 Nov 2023 08:04:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-140-g682e7cb9e7b7
Subject: stable-rc/queue/5.10 build: 19 builds: 1 failed, 18 passed, 1 error,
 5 warnings (v5.10.201-140-g682e7cb9e7b7)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 1 failed, 18 passed, 1 error, 5 warn=
ings (v5.10.201-140-g682e7cb9e7b7)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.201-140-g682e7cb9e7b7/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.201-140-g682e7cb9e7b7
Git Commit: 682e7cb9e7b7be647b4c476e48478cec9c43eee7
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

