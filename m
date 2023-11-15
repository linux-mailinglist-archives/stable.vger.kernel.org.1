Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577017ED1FD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjKOUaI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjKOUaH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:30:07 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C577DD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:30:03 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc5b705769so985385ad.0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700080202; x=1700685002; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GF3ILCh6Hkx9kDDmHyhWrAylhHzp92zEMc6VyY2nyvc=;
        b=c2wXZqegK+jREwpyRNwYMPZarxqL3RhJMX8RuWA++HN3U6gB846XelalPZVu2BDJHi
         8c3E2dZUefr8pXXeZrByDPXU95PB296JAVbp3lrXcfPBfm8RzqqZyxfRGrIX0A6f0+OG
         eZLQSq36eY1p+loHFx9FyT/QxDWOGxI49s449Vc9Oe9yZBk+TTrq0XK6eYCm1XoOjQrR
         NKmjUo9qUiKiKFY27VOoQn1+sn+n/8fT47XS6JSay34kqEJkZSW5uqEtxfuaClgVWqsX
         XUIyJNQ/aiIEUeZXMaYGNgPfRlwIoHrpE9M9OF4TDbEW6DM0m2L39b2aIjnlHfbRarHs
         U29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700080202; x=1700685002;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GF3ILCh6Hkx9kDDmHyhWrAylhHzp92zEMc6VyY2nyvc=;
        b=Ozao5dj0McleDVYRc1XMv8dpaI44Q6MvPe80FLvq+bK5wyYCgfBViGoSL2JtWUxdyb
         fpKnLs60em495kXK1UWLOWcenkbahmbC0AlxvHJhzfvrzWyR/xoKGbqaHIZocqIKINUw
         4u5xMQVRl9Ns1HC5q65BGgWWLfF3Aw3dOs1iigfv8f/HRPWWYOJOE2gbR/4s49W0xF3O
         ksopVLYwFb0NPo5IPUVRaUQpzZV1/o3w4frJvSMEvpKm+SLZLPokwfCfoDvD0HyCHGiW
         CMFFDMe5xmvjqlihtNugcsI9UqW6SG2c0ohs/H1Fx+IlScIMP4F0SUlYB03F6JlMW5TM
         gWxw==
X-Gm-Message-State: AOJu0Yxqk2CTuY8c80tSjWqlFgxVVhSTC4gzuF5oBAKuKUB9DSgat32O
        nHqR/DbX9t5LQokWidnWb1yJBseiGL918CmSd6q/Kw==
X-Google-Smtp-Source: AGHT+IHCxcHPRkSAphrJ78FWS4MMiAIhley4X1zBQded+BFlOAhkWYeldccT5XP47YYk+O5I5aBAaw==
X-Received: by 2002:a17:902:f7d6:b0:1c3:3b5c:1fbf with SMTP id h22-20020a170902f7d600b001c33b5c1fbfmr6115276plw.10.1700080202458;
        Wed, 15 Nov 2023 12:30:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jd14-20020a170903260e00b001cc3fae08basm7788933plb.52.2023.11.15.12.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 12:30:01 -0800 (PST)
Message-ID: <65552a49.170a0220.f0891.4fce@mx.google.com>
Date:   Wed, 15 Nov 2023 12:30:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.200-208-g56d7b7f72001
Subject: stable-rc/linux-5.10.y build: 19 builds: 2 failed, 17 passed,
 5 warnings (v5.10.200-208-g56d7b7f72001)
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

stable-rc/linux-5.10.y build: 19 builds: 2 failed, 17 passed, 5 warnings (v=
5.10.200-208-g56d7b7f72001)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.200-208-g56d7b7f72001/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.200-208-g56d7b7f72001
Git Commit: 56d7b7f72001d6cdd7f5e67809115743b1ad99be
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+x86-board: (gcc-10) FAIL

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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warn=
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
