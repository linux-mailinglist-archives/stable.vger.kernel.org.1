Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB7759AA4
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 18:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGSQUM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 12:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGSQUL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 12:20:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C891733
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 09:20:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e6541c98so7116588b3a.2
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689783609; x=1692375609;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xNLJRYfqa+6mgTv9zVNs0hfXDhMKx5CmzJBjyLGiOLQ=;
        b=BKhC65pr0BJ4gXOvu+eoJxaxPad+K8VyOVYof3SQi6cgDcUWTnkb9SHPVH1HvdUIlN
         2u8QskcIFJy+ZA+7YpQWIk0oXVKeIO9Fo8Hf1Zk9qsyTDIPjY/dbaVqFkVTL3LIlI1fq
         JeVy4neWT4C/8nOS9Hj2sFP1t2c69hU9EgY8yILCXj5DVs9FlhF8paSThC8Zq5SxjYyt
         fxOgoJI8rwphGaHHDjd6yvxbOvh2VuiQZCEjU6gJsyMIyyPyi4M1ySx1YYpVveaLQF7u
         sQB4VILulJ0X8x+Kk6xrUYs+KPeXchUCaOAd7HRYnbTCQQo9NEyAhM1ow6B4IwiSTqmC
         C1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689783609; x=1692375609;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNLJRYfqa+6mgTv9zVNs0hfXDhMKx5CmzJBjyLGiOLQ=;
        b=gHieUbOx8e+VLcvA5dBqSShZB08z6sx+zMbPIqm1NITH/4IJktoOMbZ8NA7pwUZeMj
         v8KQmcHeLY2M5XsEhoQDAcs0/kr3wCDUH2qNEfOsUOvwrfQwiio+YklJivXp1JXXJnkd
         WJNgbpYBVOpdhdfIL2335rN3xB5bk/8VCiQVQRcGJFJ9qegp7RVpa85qcTtbIqzoo3Rt
         js2cojJ2enHpa4VAbGJC3d+nV/NF5sL9Vn80GSutmX7zJbfBf4Sz9wES73n4coyf7Tri
         Ergx06Z2H2bOpacrewCy1XPFfUci2SkH3Kp5vw8XjmYjnxVSiNpemYpiBkWMwgz/iaA7
         zo9g==
X-Gm-Message-State: ABy/qLbj90pRQqKNuswT8+KQzu0q56bEOzKJYKuZh5cMx0M628XFqCd9
        uidCMmFmD8tkOTnzmQbRupTQJQ4+Y8xR9vsvspaCEQ==
X-Google-Smtp-Source: APBJJlEeA412gBrR0CxDSFnW4OIj43rBZTVjxkZTkeJQy6Pil63bVqm78XOJ9H34Db0t1qZTI2SccA==
X-Received: by 2002:a17:90a:72ce:b0:267:7743:9850 with SMTP id l14-20020a17090a72ce00b0026777439850mr4460563pjk.14.1689783608641;
        Wed, 19 Jul 2023 09:20:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id nm8-20020a17090b19c800b0025c2c398d33sm1358125pjb.39.2023.07.19.09.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:20:07 -0700 (PDT)
Message-ID: <64b80d37.170a0220.93309.25df@mx.google.com>
Date:   Wed, 19 Jul 2023 09:20:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.39
X-Kernelci-Report-Type: build
Subject: stable/linux-6.1.y build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.39)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y build: 19 builds: 0 failed, 19 passed, 1 warning (v6.1.3=
9)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.39/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.39
Git Commit: a456e17438819ed77f63d16926f96101ca215f09
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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
