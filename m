Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF9765025
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjG0Jqy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjG0Jqt (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 05:46:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF634C3
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 02:46:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbc87ded50so4517725ad.1
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690451204; x=1691056004;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ENMl4DFyZRpb6/fHYHm4jLFPVrruFuEj7waOd3uM8aE=;
        b=n5f0SbXLo7ogXXltR3/32wJpv7lxEQkL8pYMZ70+bRhZDgcJOz3OpGYE8ccIa7ngcv
         7TLs6kf8Z5ok1I7aHgqUSVtuehszqb2+wsEdPaj96yRsDDQ7igS7w0nLx6MUZUZpdGXt
         fVeQpbh5ojrSOp1dT+UN+Ps9U23ulOmh5jgBTZAFQbyPb11+PowY/89F9FYQWphjjbqQ
         L/K6y4z1LpsQfW0tv9uyhObJrIivCmXsSCNGbE7dMqjUmjzMaiRapo9FedMbxh1GR0LS
         eZSeIw+1hiZX/oibxYhwxZoJZ/1LBY84/ef/IBw4mU7NQ1ytp0F7/T4XEUObz3Cps65c
         jKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690451204; x=1691056004;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENMl4DFyZRpb6/fHYHm4jLFPVrruFuEj7waOd3uM8aE=;
        b=l5wh1PnR+uPDmd1YJTIk974fyJrv6LusebYDCS45PL54zmPazX2CwUyuTm0aS6FG6M
         mGD4TFtNb7Y9p387yi2dvUHyoZhZudpWdM53qBvrm69Udz9h7cv7pla6RQO0AeVivMgB
         nWUQ9FGCeMEtJ4mCmw+EXbVFWr7MTpRHcYKubKwCm05xqhAwSV33T5Wyz9GQK16IATdi
         pc4khGDK3SKwsKIh5IlP9XjQKD3oqWg7GRYKpKv3EbFeXxAq1GjfIwh5ai9YgDLWJLIf
         u2WSd5Mysrs5JrQ0TymzdbtDvUE9czFUvVMBHdGMwinv2ZnEXNNr1rdNI2U9/8Zfyr1L
         aOqg==
X-Gm-Message-State: ABy/qLZD1DB3T/R2o7h2zKHcbhnbs9tC7b063XVFo0tQqoJpWVKxSpZZ
        qhqAErs4GAMRyLvYrs9vUulr3pRCkKWwdHCVkLgOGQ==
X-Google-Smtp-Source: APBJJlGeVB+9LfOMnu4EWYR1QPBHf5f+Ih0P6USw9BzGkzLLVMQT9objo2OVtoToXbFENpEV6CeA2g==
X-Received: by 2002:a17:902:d503:b0:1b6:8863:8c9f with SMTP id b3-20020a170902d50300b001b688638c9fmr3941560plg.6.1690451203892;
        Thu, 27 Jul 2023 02:46:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001b869410ed2sm1172475plx.72.2023.07.27.02.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 02:46:43 -0700 (PDT)
Message-ID: <64c23d03.170a0220.cbd0e.1cb0@mx.google.com>
Date:   Thu, 27 Jul 2023 02:46:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.42
X-Kernelci-Report-Type: build
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.42)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.4=
2)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.42/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.42
Git Commit: d2a6dc4eaf6d50ba32a9b39b4c6ec713a92072ab
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

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

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
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
nommu_k210_sdcard_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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
