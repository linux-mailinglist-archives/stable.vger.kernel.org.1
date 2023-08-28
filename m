Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E282678A6C9
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 09:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjH1HuI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 03:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjH1HuE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 03:50:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA514114
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 00:49:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so2302556b3a.1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693208999; x=1693813799;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3mxrFm+rnzsSwmcUFsGWcf5WHCV9NJLbCj2wDXYh390=;
        b=xJokI6mcpVAesbkhpiCMTPfRIvGwyx3iTcjM2XizqCRgskbkWxbfmzB/sx3Cdgc+TE
         3f6iV9fAZlqi4DmxMxxSh/wgdwe0iJFQaG0qmhM/K99tvqYjkmzwnbD7ElhwtpvzExo2
         4qkV0WKwzQ+zCF/FeBz3iCOu/+FxZ4IItWQielWCoNBkMWvP1MyLPKEys/8Pmlx+RCCJ
         exX2UHiaiReVy+LNoJ+RlBLBgJApuShskWBseQQkh6+okRlXZcSTbi4hHyUNFWFsHXbD
         BvgWnonz3vQTxIdde1C/sqiaR1LUDq+J8W9pbvlucp3sl4wNPctAAwhHgw7u+uFfhtEU
         9v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693208999; x=1693813799;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mxrFm+rnzsSwmcUFsGWcf5WHCV9NJLbCj2wDXYh390=;
        b=heRMv3DSRNqVaBx36tick33XM9BYHx3KfnGMWpJaH7n/ZKHZJVou/ivtdh8gQEcmMw
         Y0+s3LQIyzywoVGVAHleoJZ4RMfNb83MzN6FDhRCAuAtrPxb1SMwd44QdUpYBYnH4jQe
         maxEuRYwT+qIs/Vnh3Hdi6L5p2sYzIOC6VyF+eD9FrNYxBspFlaH5B3wIrzyYURU+hW1
         ZwKZRJW4rZr4dCLrfygqjIHbRw6NbSXiG+AGqxh3lHibfzRBLp8eQ/cpTiPHVJbGEnli
         HeqhIMdgeTAZXS8n7FSApEmzXT4HKEQfvczBH4mKF7FS02dzEcNPFygLHbX7/5/4RgHo
         LOkA==
X-Gm-Message-State: AOJu0Yx1Jn1b5hgoPnZRMqC3k5bF/BcAffILJgEm8fi9IV2sv/40KEhr
        G2BT42BKbp/jRhDSTLOHx/eviZ5wBE94C+QAJh4=
X-Google-Smtp-Source: AGHT+IGyUwhticvMpqITdzNhnzri/HEW351Q4yeHnpxYA3C54jBFLiw+2Q1ekWmnC0ep2XrH20nItw==
X-Received: by 2002:a05:6a20:430a:b0:14d:6309:fc94 with SMTP id h10-20020a056a20430a00b0014d6309fc94mr3634349pzk.36.1693208998764;
        Mon, 28 Aug 2023 00:49:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79153000000b0068a49aad7d4sm5990250pfi.79.2023.08.28.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 00:49:58 -0700 (PDT)
Message-ID: <64ec51a6.a70a0220.f1019.8b80@mx.google.com>
Date:   Mon, 28 Aug 2023 00:49:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.19.292-130-g3489ce05dafa4
Subject: stable-rc/linux-4.19.y build: 19 builds: 5 failed, 14 passed, 2 errors,
 22 warnings (v4.19.292-130-g3489ce05dafa4)
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

stable-rc/linux-4.19.y build: 19 builds: 5 failed, 14 passed, 2 errors, 22 =
warnings (v4.19.292-130-g3489ce05dafa4)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.292-130-g3489ce05dafa4/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.292-130-g3489ce05dafa4
Git Commit: 3489ce05dafa4644fb69bd28124e70e5b8aae881
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm:
    multi_v7_defconfig: (gcc-10) FAIL
    omap2plus_defconfig: (gcc-10) FAIL

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

arm:
    multi_v7_defconfig (gcc-10): 1 error, 1 warning
    omap2plus_defconfig (gcc-10): 1 error, 1 warning

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 2 warnings

Errors summary:

    2    drivers/bus/ti-sysc.c:982:8: error: implicit declaration of functi=
on =E2=80=98sysc_read_sysconfig=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]

Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    2    cc1: some warnings being treated as errors

Section mismatches summary:

    3    WARNING: modpost: Found 1 section mismatch(es).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warn=
ings, 0 section mismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 secti=
on mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    drivers/bus/ti-sysc.c:982:8: error: implicit declaration of function =
=E2=80=98sysc_read_sysconfig=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    drivers/bus/ti-sysc.c:982:8: error: implicit declaration of function =
=E2=80=98sysc_read_sysconfig=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
2 warnings, 0 section mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
