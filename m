Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FFB74FA84
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 00:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjGKWCu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 18:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGKWCs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 18:02:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9831705
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:02:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8a8154f9cso615045ad.1
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689112966; x=1691704966;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7N2yuDkljTaH1Ot+EkZZoi+TUU9jeLw+0Renoy2cPTI=;
        b=EP9HZL43fZcxmnkrmFvspJOeqgB+YvtKKV/cRti4EnbX4HuDfzdz9Z8vsnyAIYaP4O
         KW9kQTP1G+s46/nRBj1RyQ8mWC8qk7/TsEggq5uxEhZCm/GJ/Tte3RK2NDTUWnjw6EOn
         iriQoiJY2dL8WJkbJg9Hqcde6aPw9NfQ4TLeDfQX79EfOhYDNbt35+vumO81+ehKDH0B
         20/XBMJAf9GFXaA8pxao4u/RRNBMpePeu8pNY7BfEHO3oWOZNlr/nCuqDc+cANw0cfuK
         dytjdW2lzJLLrJKs5zWNUSxDtCLYp4QRvwNC1M7ed2NXrQ8UlnhCAdfggnCNIVMuFRns
         jkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689112966; x=1691704966;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7N2yuDkljTaH1Ot+EkZZoi+TUU9jeLw+0Renoy2cPTI=;
        b=OqXyGFjdPzzjdv7qNNaNeX+aB/5DrE/gfgj89VEcjyvJBlLuqV0KjsVLQPuOaQl891
         2Xf5zYB0933A6v7hxdWV9q+GiS3U0u+wwnQLlamOWXJeveFhHaYkN5yU3qKePCCxoqFQ
         e7XcpE9WhkkH/ZYY1tDym6fggnd8jSU1oozvptxCzDDhL3mQZFtKUqhbXCM2ypbg+E1r
         eEqV6JoXu16ItbOFhVfdQJZc3p0uZnnCQNrkH0JjBFEqXz9GgHJ5vaYpG1Z5DNoqbf/X
         nTIas5ZGp+wFdiLTfs+C8jn1phN+cgz5NbMQ9GcFSgA1SWgMp8AVMdpNAKtTJOY9x7Zy
         0SAA==
X-Gm-Message-State: ABy/qLYMzGgRq+ZmHzOc77pCjNnIO9JHC1u9FXKCgQzkT1K1unruWhhH
        OeBZmpsUqv03ERmGwmE6XXPNV1ixrTJ5UZFsFI9t4g==
X-Google-Smtp-Source: APBJJlEyQyJHgOfuKemTRb+9g8CC1pIg+VuhWg8YpUpT7tOzJ6kE8qGNU0I9VyBzxM7yvbp6RkJwMA==
X-Received: by 2002:a17:902:e74f:b0:1b6:6b03:10e7 with SMTP id p15-20020a170902e74f00b001b66b0310e7mr158494plf.5.1689112966350;
        Tue, 11 Jul 2023 15:02:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001b66e3a77easm2445855plb.50.2023.07.11.15.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:02:45 -0700 (PDT)
Message-ID: <64add185.170a0220.1c880.5921@mx.google.com>
Date:   Tue, 11 Jul 2023 15:02:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.186-221-gf178eace6e074
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y build: 18 builds: 0 failed, 18 passed,
 5 warnings (v5.10.186-221-gf178eace6e074)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 18 builds: 0 failed, 18 passed, 5 warnings (v=
5.10.186-221-gf178eace6e074)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.186-221-gf178eace6e074/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.186-221-gf178eace6e074
Git Commit: f178eace6e0740ae5eab86eb3d05df94e91e8192
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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
