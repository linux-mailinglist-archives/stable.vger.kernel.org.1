Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224278384C
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 05:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjHVDIv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 23:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHVDIu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 23:08:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BB9185
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a3e271491so1451610b3a.0
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692673728; x=1693278528;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg1UKl5V6ZT3Xr+yLrZcQn4DVIXEJzlyRfVzyKQMYHQ=;
        b=dCe73e84O/b4Bbb936QRYo4ki2GHv+ighxpXOLbb9wlEErMYsrDNT4vM2ROL4cupWX
         Dw2LVGrt9U8T7gXcDw4JzB/HdwzV15iTqe4K7+GhjINrLG0hxxR7piD9u+OIV613qNcA
         8U2DkhUkDQDaYWGtlPvQ3pku1GRruLslq6/sxKA79p/nMdozJ/GYG4LyPyq+wxnJbSRF
         7bsEMKgGgm2v2l64JGRHRlpWLhnwDA8MFTQtNCWyYRgL/v2BXMlkCJPvfkE2VNweWQ8q
         TF3LTMaA796cMC9XsVJKhoinaFrEygcD8AyD5Wwe6G3jtXJaS0Jaj5WvTbWUAnRxuChg
         8y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692673728; x=1693278528;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yg1UKl5V6ZT3Xr+yLrZcQn4DVIXEJzlyRfVzyKQMYHQ=;
        b=gl9u/wxwA+4EbWxPFyT7tmqiOsEj6x21MstUn7hMZABjjMMhMQEnJX5MHKH5ycxzG7
         JtnlyRViQzfFqCYfLDF9SSd2aCYcPAg7YPtPlMDUmN0xTJ/D7gtP9wwu8ZVn2ev0e0k+
         iPPc8NE9CRsCffhrouB+9exhOyqnhWo3c32ERxlO0hIL1TG+dN0bqosW38qwMEVqGEfc
         nMJrvM5CqTvm33pfs9N6T1hNWYUUDchK1OU20niMTv6NgVOE9a/oyT88Wz6R9AxN0Rxs
         mt+OGVQghUgrb2WOd3nQdx16wwVEEfmMJS6Nq3ed6lB7SLU8CfWF/umaVQUuOSalNHxe
         teoA==
X-Gm-Message-State: AOJu0YzKc50GNBkHoqq/xnDEGPn0Nta6+UZblHoCiedODurZ7Pg4vEmr
        SOaLcU9ZG21IFnIRnsoQq1f2sPmsRmPIeD9jwg3lmg==
X-Google-Smtp-Source: AGHT+IFkQUmxP3SlStB3p7+hRMB8xQ0phi8yq6ltlHPNNd9bGmUhprvH25Aq97aci27YrPXcA2Mj6w==
X-Received: by 2002:a05:6a20:8f04:b0:132:ce27:d29e with SMTP id b4-20020a056a208f0400b00132ce27d29emr8389968pzk.10.1692673727695;
        Mon, 21 Aug 2023 20:08:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm7106399pgo.86.2023.08.21.20.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 20:08:46 -0700 (PDT)
Message-ID: <64e426be.630a0220.b2756.d6ad@mx.google.com>
Date:   Mon, 21 Aug 2023 20:08:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.190-123-gec001faa2c729
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 7 warnings (v5.10.190-123-gec001faa2c729)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 7 warnings (v=
5.10.190-123-gec001faa2c729)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.190-123-gec001faa2c729/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.190-123-gec001faa2c729
Git Commit: ec001faa2c7293e38e8dcdc5fcce1e8e3298316c
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

    2    arch/x86/lib/retpoline.o: warning: objtool: .text.__x86.return_thu=
nk+0xe0: unreachable instruction
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .text.__x86.return_thunk+0x=
e0: unreachable instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .text.__x86.return_thunk+0x=
e0: unreachable instruction

---
For more info write to <info@kernelci.org>
