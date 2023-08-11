Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4530E778F00
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 14:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbjHKMRM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjHKMQy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 08:16:54 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732123C1E
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 05:16:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f94328a4so1382338b3a.0
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691756153; x=1692360953;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CraMKefUdmfLGJAp+/iwjmleHEO/k9+yrKzJYibSwkw=;
        b=vtqDSB8C0TS/bzcrsQ+cbQ/xLIsFb6UowVdGFjJKHJ4WYnyOXPHgfho6rFXzKzSv5z
         OohM45cGJZUyjIR8d+5B7JOEa433HDjGP3yFFUG5YaIrZ/Ff/WmxGB1ZteqvbgPUuiB7
         gsCCBEdqSUM/3nTzLwkRgfDD7dQCeuoXUrvAergdNwxVYU4yd1TY6UH5lMgr1xdRZY2l
         2VI9KEETgCaXVFHrVaU1u4B1s59FxGCRI+2/ndhDYPpbvBtzX37Negmz2R/MdXzh4MyP
         U8dxm6Ve0KoGwwotjSik83Ij/BfgYY8JCcuPg63wHuw99ak4at2a2O5zHr1JxqcZizbZ
         sz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756153; x=1692360953;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CraMKefUdmfLGJAp+/iwjmleHEO/k9+yrKzJYibSwkw=;
        b=l0ntId/37HaFp5aOtBHUnmM75JVClMIG1e6rRrHYL4IGd+NA71jh7OFSzxPHOf4jIo
         78lVo/DBnPjEjAQgHWkanqG0LXjFN9DIaNUC1qiyNDXKXGh9O6rveIlh5vnwiOnG9dpc
         0812EWCJDaYZvHzhBM6ia/yHp2cNP0IZtdtAi7Rw0r2Fgq6pbJVTkoPuvSg6ic2zBlem
         LVmqbJXN703bAZiaeFSdmuBeiCcV4xZid6zIk8bBZ6ckCVKmU9VygGYa+YfpOHbPryyk
         isiMyynbbgtz+NWdIeGb43ccX+15YGJgQfIXIYppEv3rahYerL2f3n9FPF5GMq8ETN33
         1n2Q==
X-Gm-Message-State: AOJu0YxKab5LOUXtD+1K1VfDGSYbLwLsqsDZaifaCJx2i77vqJlB3yzS
        2A3I383JrVy520o5i8LKYLVnmF11A4k71mKIyM/W0Q==
X-Google-Smtp-Source: AGHT+IHBLNP10xzX5Aq/aES5aJYoD9NwXfScETiAaotiT6CCgbAoEPiNpJiiITqt7+ORUoj8zvNyEA==
X-Received: by 2002:a05:6a00:f8e:b0:687:903a:beb9 with SMTP id ct14-20020a056a000f8e00b00687903abeb9mr6843220pfb.9.1691756152772;
        Fri, 11 Aug 2023 05:15:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7850e000000b00679a4b56e41sm3175421pfn.43.2023.08.11.05.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:51 -0700 (PDT)
Message-ID: <64d62677.a70a0220.32774.5bb8@mx.google.com>
Date:   Fri, 11 Aug 2023 05:15:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.190
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y build: 18 builds: 0 failed, 18 passed,
 7 warnings (v5.10.190)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 18 builds: 0 failed, 18 passed, 7 warnings (v=
5.10.190)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.190/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.190
Git Commit: ec585727b63d12f9683140fe4b8eb8e564dd3aa0
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
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning


Warnings summary:

    2    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:=
 unexpected end of section
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement: unex=
pected end of section

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement: unex=
pected end of section

---
For more info write to <info@kernelci.org>
