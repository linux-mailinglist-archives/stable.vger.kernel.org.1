Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED767ED76A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjKOWke (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjKOWkd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:40:33 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF7898
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:40:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc1e1e74beso1809155ad.1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700088027; x=1700692827; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Lsi+e3jjd+aPvCdhKcHOzZ7le1fXkMd8bxYDIqjsi8=;
        b=v2V6gVokZicT2X6RWCgdFPeqpgwSfeMxwu80dtxT2F4G/E+X6B0dAZyWmsAl/CBHcY
         bPgjs3BQTWqeJz4bDX713L5NWYLXveTyX9ApE85xW5AlG7fG/5nVmcNTR4HaIEmizmAC
         TgJ/7ws9VkJ2fekVAvXH6wQEA4T6mGLHmC1JUxgYrmmmdNLjkGJEqBJGuBaRvnYRZpaQ
         9AB0Uujnfg98zra23lx17G5D1EMtKNcPsme9xE6spyGL8gdmF9IYLIuL6/QYSUqYvtEE
         znQaOkXxFzG6iHfKvWE2O8kYiSSBZTpjoyeARNbIxcA1ch0SyGybrVLdSi+s+BqFD0/1
         fpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700088027; x=1700692827;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Lsi+e3jjd+aPvCdhKcHOzZ7le1fXkMd8bxYDIqjsi8=;
        b=ssN+M3XarqL72u4EqjMFzGyXo7Cy2dhJm11eix17DKPnoxwSMs8ims2nxdABrYdOBh
         8h+Uhomi1ahoiMtpAZL5sE+m1Md8MyzbunM9/gSaePq9a5SO4NNp4m28ZQ+2xU7ZKQvV
         PVLwDWQc1wJEmd2Lu6j6u2YBnuTDk8UmiEXN+ff8/xjqkHrQHbOAiIaor3P++k9Qe1cu
         pQZ22vJb1P+uluTdLO0W7Cy9JpHXrJeyK/Wv5ITmsqbKrZpLf6DrltoAydKqHLtGnVKd
         wNCXyZRSGvm0J5PjmeBnKjN0MaI/nNem09pXY/o3g0U0p5iCRQhgsq6mLOJXdGEDTIRE
         9CcQ==
X-Gm-Message-State: AOJu0YxhYKSWxW7mprKZJ6jPBD8IGsZIpMxxS9VS8/VrVUn1PIolFOsp
        5Kuh+4jkgGG7Bu66M0pjsI02Gu4nOy4AhgKJS2MUsA==
X-Google-Smtp-Source: AGHT+IH5PS06Aly2pgJh3sih8l4wugB7fTtZ+eEo2yI1Olg/Hmpu5IcYbdA3uXMmpHywWEG4NLwQKw==
X-Received: by 2002:a17:902:ea82:b0:1cc:5aef:f2d1 with SMTP id x2-20020a170902ea8200b001cc5aeff2d1mr7110559plb.25.1700088027050;
        Wed, 15 Nov 2023 14:40:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902740400b001bda42a216bsm7804640pll.100.2023.11.15.14.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 14:40:26 -0800 (PST)
Message-ID: <655548da.170a0220.55488.55c7@mx.google.com>
Date:   Wed, 15 Nov 2023 14:40:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.200-192-g550b7e1fee20
Subject: stable-rc/linux-5.10.y build: 19 builds: 2 failed, 17 passed,
 5 warnings (v5.10.200-192-g550b7e1fee20)
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
5.10.200-192-g550b7e1fee20)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.200-192-g550b7e1fee20/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.200-192-g550b7e1fee20
Git Commit: 550b7e1fee20e8840f9c1028c89dd3fc9c959fff
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
