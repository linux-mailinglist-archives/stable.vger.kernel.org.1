Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7BE7897C8
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjHZPnQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjHZPnB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 11:43:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519041BC6
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 08:42:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68a41035828so1429717b3a.1
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693064578; x=1693669378;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T0zHUy3tvINM6AnEojUy59EZS2kfCRAP2EixAk4HEfs=;
        b=KoEsqTiYM6LGFX8iyA10TKYbwN/8q2MR/lixrsm8hAt7jbMVeqIgmKal0+ymUS7vBc
         VpP/dZ6uK3bzTOnflpCM2zaTm3AqHH8aMsw+BCubzRqJP38TIxCjRuQDaAZv+wERbQKh
         EfRDBjvuuSmbf6JYvgt7fq2uuXSyp/C2XxA+q/h115iP1VNhWIzwWiYXiB4hpAY14DBN
         qpPa5Lq3ntRbVtobvOztYPECSAHweCz/VUSjnjl4DYUwH8bVmoDez3pytAFz9GeP4SPi
         BCjWKg7f89Tv8RUWKIqjm7kelCjXZy4kzn7n1N2m6+rMhoP/9wSh51Cm/kjd97T4uXbY
         p+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693064578; x=1693669378;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0zHUy3tvINM6AnEojUy59EZS2kfCRAP2EixAk4HEfs=;
        b=ehWdoy/FIqAnvVgq76dWh9p1kPEJ+JV4QIMm0Z82e1o5QcvT3flEVgIo9sN4k8MKfu
         82076mgGbFQ9uViWV/UXsIFb/g9fCBsERzKQNnHFLFjYWnViEVr7M+lCWWs0yUfyKXpT
         x9wXom6QK7GLHg+DgQdQUxfm+igKUgfoumPDS/xw8L4AiB3w5nq70rCcdUpa+2R9m6WO
         fkREzHvhN/RAhQ3AhWesTEKeJGDGhhk3yjAjOyhPkV7SbfD+Hjj7ICGUh1sDIYH4BG/5
         /e4jWv+nhB0lotj/AgFN0xDsYK+Q9zhf6JL+EjFhtKSvknp5PzzCoAdOC6D+7EHZWi7i
         4jIQ==
X-Gm-Message-State: AOJu0YxuLRGxG+W798R0LVtd9JyCsiEtjLlApUSpBDAmb+7fsHpRBsba
        Ur/adMFfTOecpPLHEzHLlR7OYpXbtQbS6xETyjI=
X-Google-Smtp-Source: AGHT+IFUbD8VMQ1t4c4JakD6ZA/wVZJxK+0bWkRcekA0Eklb/t0YwbFLGsS9T/aaHCDPXu0j2oMQrA==
X-Received: by 2002:a05:6a20:6a05:b0:13d:ee19:771f with SMTP id p5-20020a056a206a0500b0013dee19771fmr21552360pzk.8.1693064578025;
        Sat, 26 Aug 2023 08:42:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a22-20020a62e216000000b0068842ebfd10sm3413103pfi.160.2023.08.26.08.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 08:42:57 -0700 (PDT)
Message-ID: <64ea1d81.620a0220.f2251.567b@mx.google.com>
Date:   Sat, 26 Aug 2023 08:42:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.192
Subject: stable/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 7 warnings (v5.10.192)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 7 warnings (v5.1=
0.192)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-5.10.y/k=
ernel/v5.10.192/

Tree: stable
Branch: linux-5.10.y
Git Describe: v5.10.192
Git Commit: 1599cb60bace881ce05fa520e5251be341e380d2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
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

    2    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement+=
0x90: unsupported relocation in alternatives section
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement+0x90:=
 unsupported relocation in alternatives section

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement+0x90:=
 unsupported relocation in alternatives section

---
For more info write to <info@kernelci.org>
