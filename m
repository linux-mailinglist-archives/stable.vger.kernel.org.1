Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599057EC3E0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 14:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbjKONiJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 08:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbjKONiI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 08:38:08 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E30AC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 05:38:05 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso6136601b3a.1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 05:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700055484; x=1700660284; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CrsYaKKbTSvv3yYYDxxBQ5gBHMdaq+SEPI4iuWR1A9E=;
        b=KUV1kGAShwAWqoimpO8ixi6/TCoW2Z8IMvq29I9LJ1q7OBDCKFF9R/vi2wbxEfgWLc
         xQW9MQAUGl0X5pRZnRVqH4sQlg69Qi7zTaXJXhwu8zK4L2tKKj37GKe2xweVOaHFU5s9
         ZIkSjAR2FY74rz/uyzGuFA06BSh7OEczliXerGQMxIHIRuVBh/3KUH7S1bRS9okWvlJM
         SykZ2chINZLjuUKEAfeHQ06lj2CBdUYIaUjrXbOQSARz4JKsegMBe2k1oLABctPZ9T5E
         40AWflwLBdA1iyhubrM09sUapINTsCTJji1VrJTmPKXKZXjk9FBDnP61dsiJpR/9fLr4
         ShZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700055484; x=1700660284;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrsYaKKbTSvv3yYYDxxBQ5gBHMdaq+SEPI4iuWR1A9E=;
        b=Wx+ImtCdwPucH1J652K8nu2c+k3LL9Hs29cenF2GIpiYJG/0t0sC99DIbDKupyVrtF
         umWwqNIfPyZyV8tiefg7S6r+aUAb07ZGI8oElxlgH0/TAVoCO8LPWJESu1bQxbw9meMR
         BhYRqZ6jSZ1uGadD1jeN0N5xRTs5EacGmEt+HPamJ4b/cQPlBIGap8i4lAiz/4BxDU37
         lAyy+N0oKzTXhjAyawH+Y51Age2VpOlllmd+NoNhQnlGyN+LlDAz1ZqEAv4urpo/+zd4
         z19Buy3tRSg4tsI1Gg0MD43gwHLYID/nHtkmuAuS415sjGAsPFSnLCdHPU1uJ1MsB2Ne
         ssNQ==
X-Gm-Message-State: AOJu0YxAPEwwiEcTbcNiHu7SSD/GZkb+So0LZ8xVrgEeT7LRyU4MtXZx
        B3Df3b+silhq9DX7Loi591m1G2fhGpC1BmA0qNIxtA==
X-Google-Smtp-Source: AGHT+IGYIajgvCKvkNjR/SjY6C8euAVQU73qhaq5RSdy3jsgqalZ6KMZ2O3EW0ZFd0VE31YV+gJCOA==
X-Received: by 2002:a05:6a20:431f:b0:187:349d:de16 with SMTP id h31-20020a056a20431f00b00187349dde16mr3978512pzk.37.1700055484019;
        Wed, 15 Nov 2023 05:38:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x20-20020aa784d4000000b006be4bb0d2dcsm2923931pfn.149.2023.11.15.05.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:38:03 -0800 (PST)
Message-ID: <6554c9bb.a70a0220.18807.8c45@mx.google.com>
Date:   Wed, 15 Nov 2023 05:38:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.200-207-gc3a1f056425f
Subject: stable-rc/linux-5.10.y build: 16 builds: 2 failed, 14 passed,
 11 warnings (v5.10.200-207-gc3a1f056425f)
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

stable-rc/linux-5.10.y build: 16 builds: 2 failed, 14 passed, 11 warnings (=
v5.10.200-207-gc3a1f056425f)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.200-207-gc3a1f056425f/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.200-207-gc3a1f056425f
Git Commit: c3a1f056425f657e26f2e5d3264afee187b962b4
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
    imx_v6_v7_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning

i386:
    i386_defconfig (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    rv32_defconfig (gcc-10): 4 warnings

x86_64:
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-board (gcc-10): 1 warning


Warnings summary:

    6    kernel/trace/trace_events.c:773:17: warning: unused variable =E2=
=80=98child=E2=80=99 [-Wunused-variable]
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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    kernel/trace/trace_events.c:773:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    kernel/trace/trace_events.c:773:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    kernel/trace/trace_events.c:773:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    kernel/trace/trace_events.c:773:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    kernel/trace/trace_events.c:773:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    kernel/trace/trace_events.c:773:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

---
For more info write to <info@kernelci.org>
