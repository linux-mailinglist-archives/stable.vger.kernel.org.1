Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C5E7E69E6
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 12:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjKILsm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 06:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjKILse (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 06:48:34 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79262D73
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 03:48:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b8c39a2dceso607242a12.2
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 03:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699530512; x=1700135312; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7CqRzQ7aouS9jOXkomd2hNElflr779e/JXKFuODd6V4=;
        b=d31+W6VmoVv8WwGp/Y9BCADZ5CQfjdLOcPKJMnFq837v1ijU3xkN4kzborwRugW2TC
         HwPOCqfUSTaSXJxe/WntmGUGKCu2vm5Q9oEtEBdaJ0gha+2l0mnmoaLqbmmDsWT9dQIc
         YojL55lqZ7OL3hTEpob6p9IQxfOOhb1lv7pDHgiP7WECavmlYGpnqbw3DurLfd3BM/lB
         gia0bDCwOFkk0pqNPeGh50KzOjsQ7PsxtpIsUxdILK1PUdu8OQ+lmcYQwQyo6egzQG2l
         UB63iIc/nwJnLOxS8ZUFH8aBQVMHlZSWmKbTi/DeC6YH0uEAjq/5gPLTxXa/kU/Eg9Vu
         j6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699530512; x=1700135312;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CqRzQ7aouS9jOXkomd2hNElflr779e/JXKFuODd6V4=;
        b=OV8tqINkq/pY+Hl1yIAYoKYFoQ5ivyHinCOhcMExxONvW85NXItkxRTrcY15Kc07UE
         n/1h64yow/u263uMfncWA14Mmb/eXLWOs2sOidgI4Zx5fkvuH82dhKStRnHu9JNoOnlP
         EsoZnNrgsM7ce54WGbx2Ln3hl0jYzIYvw3IA/VxctUCSVg0t4RscHlAn/8p0lPwdDmQ/
         G4/uzRmLSoZbX4FKVVtO8UgFCRtIJvwY1DhTlluvsL+IzAwC4loReSH0TeKwxKaYcHPa
         3jgsuCvelSSffn11Jal2ZPf0b+spwTn8iZwF/EwiklCXsrNvURWiZr/aIIl8Vgcag+Ae
         zFBw==
X-Gm-Message-State: AOJu0YzYX6/JYnH67I1uZGBSTRSbH7Kkz1NN4Gvyy60FFEMR5MAzRklV
        vSJi+9k2AgCLZ3kPoERxj+Bzz0i8iWoOhBx7btDJng==
X-Google-Smtp-Source: AGHT+IGAdVmGS1eQNP4Dsx8U3oo+wDWILAgbHv5FIPSaevGEviKgmLS3W903blH79Zwt859GfWrzzw==
X-Received: by 2002:a05:6a20:3d95:b0:181:74fe:ba83 with SMTP id s21-20020a056a203d9500b0018174feba83mr5344542pzi.40.1699530511595;
        Thu, 09 Nov 2023 03:48:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001cc3141b8fcsm3334044plg.118.2023.11.09.03.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:48:30 -0800 (PST)
Message-ID: <654cc70e.170a0220.3d750.99fc@mx.google.com>
Date:   Thu, 09 Nov 2023 03:48:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y build: 19 builds: 2 failed, 17 passed,
 5 warnings (v5.10.200)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 19 builds: 2 failed, 17 passed, 5 warnings (v=
5.10.200)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.200/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.200
Git Commit: 3e55583405ac3f8651966dcd23590adb3db1d8c2
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
