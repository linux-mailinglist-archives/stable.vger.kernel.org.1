Return-Path: <stable+bounces-3794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36F802594
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC64280CB1
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B011156C9;
	Sun,  3 Dec 2023 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bR3yHIZy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A70E3
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 08:41:31 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce46470647so68113b3a.1
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701621690; x=1702226490; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2r5mgetO9YfLNqLp1t41WZrGwc/CV5ZTgs4ELH6y7+4=;
        b=bR3yHIZyuBPPqhF60jYwj7DunGJFx8svyM4797kjfuuKfqmJ8+kkhViHwo/PV4F9Zp
         d/D6B9k4Acc6oDewMZMCm7PF9VMP4jp5wi16OYzF1oBC7QHm3qRdwGJrtD75xX3w2KIR
         ESfJI2esD9YUNpHT1cAejYRxksIwLRSCxx0o+cK2Exr4bqGdvPoI2Tvd3NRzn0UaV3Ra
         mxiNnknY5F/1ADntT3pVYsYtZBulN+vQ7Ob2Q7yKFdfCowR0OsY2qd1yes9PsKsP396R
         HFk7F7+sI6q9nNVcUkYUqrGMM0ucyE6nICdOfMC4XzUud5DmCjcKSvvPh5oFRKTejqOy
         aAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701621690; x=1702226490;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2r5mgetO9YfLNqLp1t41WZrGwc/CV5ZTgs4ELH6y7+4=;
        b=kSjOV55/y4+zoUbqouVXDrVaRHu/DoAq6mjFR6QOTpJlNf4cr0Te9nhNwGoiAvqVZZ
         4cUQOGB65uYcHn6hnIUf2OifVbWAtUL199fMOiM55w+PlzNob0n+3bTv9E6+NWiWFfA0
         uh7H8oovez+jQh00B6cCJVmGGlGpXMHPne1S6L6xtcSO5GmHL+chg2vKyYa7JDJVyeyL
         j4u4vjdIXs+RzGWInFZ1hSfKIY4Hw5EX3LZ1bMqapC2lwxWzxpO8e5OVpPjU6qUu8jJ5
         qnee+8Jxhdi4zW1XV1LFCDELdjWpGExz+iYljR/mivwWakoPgqTBRPySh+VaI0zfObkT
         fkbA==
X-Gm-Message-State: AOJu0YybKrx7z7iFQdfaD1jYZuDBYD4gESwTy/vum2xoRTzEKrQu7oIV
	zgMCB/xM02sB8Ppi0RcIIyNf87aGJ85oOIsJkCj/jQ==
X-Google-Smtp-Source: AGHT+IFe+t+o5PQyL6CP5m99pCt3oB86mVkv9VUEIY7U8PwrPJKchrQJby9JLHr0Y7uUUk2ueDuaFQ==
X-Received: by 2002:a05:6a00:2d95:b0:6cd:dece:b73d with SMTP id fb21-20020a056a002d9500b006cddeceb73dmr1221632pfb.18.1701621690334;
        Sun, 03 Dec 2023 08:41:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ka16-20020a056a00939000b006933f85bc29sm6166639pfb.111.2023.12.03.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 08:41:29 -0800 (PST)
Message-ID: <656cafb9.050a0220.ea91d.10f8@mx.google.com>
Date: Sun, 03 Dec 2023 08:41:29 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-89-g101afac3a6283
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.202-89-g101afac3a6283)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 5 warnings (v=
5.10.202-89-g101afac3a6283)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.202-89-g101afac3a6283/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.202-89-g101afac3a6283
Git Commit: 101afac3a62836f4295abf27f5add57c4acd1190
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

