Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5497B8D73
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 21:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjJDTcS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 15:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243508AbjJDTcS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 15:32:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC54890
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 12:32:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso130882b3a.2
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696447933; x=1697052733; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CbYByfmUEFN7X8/lqAbk13GKPbhTJAKFYFzF6CgR258=;
        b=WULJtvqP+HLQSaDs2J/JPAEDqWlQ8hkp7TQvtLkzW5db/TXbIpTJ3wzgXSfcD0/xte
         ftzUexqY7ccCAze3afEI5EeaMIVmiUcYy6xTLTcP6QsoRGWSqHuc4qagodxTIleJ8XAG
         umIZVw1l7iNDAuwfDIKol48Az43DgaX/TmWBXCdGwe+VdCdUh9Nb2GRpQXSw/+3n6xGs
         OyNxkoUqnu7QsPkSSUwaaLOak5dKG6PDSM7VZ0//HSZoaF1JTVERxQoV9K6OHy3ey4OX
         HMBhyGITLx8XA9nh13rkij5P8yv4WsCP1CnCfzTMqxe6hgyehDeO+bAWtFQU3Gp+ChWL
         O1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447933; x=1697052733;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbYByfmUEFN7X8/lqAbk13GKPbhTJAKFYFzF6CgR258=;
        b=jLU3S+8eM7Sbut1UlYDeenRDzX0fIKSYK0JvUdDoorlC3cfjHDI++AGBKsze4d9hNo
         19ve5qxRkkRvPjwmp7jzOVEJUnOzhBODSJXTwAMPkeliKqZPV87gmegkpkVyTJI8LoAl
         k4axBtkHJX98mxMLR2Gtat0yTRwrrAgsRkp3Hpw4YGSfDf5428HYgUx2FCOU/+vyzvP9
         pF2hrRIV8bJ8zfKEZ1MzfLVuMx9jEOe94UJyKDNp1FUsVm3wfAdmBHp6IemVpOMWdDNJ
         ZHLoL5/Xkza2l5c4zVee0X4AFa/eiSlBz2edKgxFuAP1INRHe83WcbCmMj/I9D6jhl76
         aOsQ==
X-Gm-Message-State: AOJu0YxbFK21F+p6gRGs0z7Q8O5LakPpMRzvhi3piF3i+TNgz+CD3aZb
        uD82t83PU4L3OBmITxkqT8QC22075nupmhoQPP7pHA==
X-Google-Smtp-Source: AGHT+IHhrOxDoHzcS7naIkBkOZZx06KZ2UzXIvspKc0Ufh4R3jmuGamf++R96Pa2vXENli6+BA32GQ==
X-Received: by 2002:a05:6a20:6a1a:b0:154:fb34:5f09 with SMTP id p26-20020a056a206a1a00b00154fb345f09mr3683439pzk.15.1696447933592;
        Wed, 04 Oct 2023 12:32:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r25-20020aa78b99000000b006933f657db3sm3591058pfd.21.2023.10.04.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:32:12 -0700 (PDT)
Message-ID: <651dbdbc.a70a0220.601eb.ad83@mx.google.com>
Date:   Wed, 04 Oct 2023 12:32:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.197-168-g3eccb060a778
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 6 warnings (v5.10.197-168-g3eccb060a778)
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

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 6 warnings (v=
5.10.197-168-g3eccb060a778)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.197-168-g3eccb060a778/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.197-168-g3eccb060a778
Git Commit: 3eccb060a778f65d98facaf79eac58c90836cda2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig+arm64-chromebook (gcc-10): 1 warning

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
    1    drivers/gpu/drm/mediatek/mtk_drm_gem.c:255:10: warning: returning =
=E2=80=98int=E2=80=99 from a function with return type =E2=80=98void *=E2=
=80=99 makes pointer from integer without a cast [-Wint-conversion]
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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

Warnings:
    drivers/gpu/drm/mediatek/mtk_drm_gem.c:255:10: warning: returning =E2=
=80=98int=E2=80=99 from a function with return type =E2=80=98void *=E2=80=
=99 makes pointer from integer without a cast [-Wint-conversion]

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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
