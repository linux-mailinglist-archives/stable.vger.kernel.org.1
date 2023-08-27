Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5649878A154
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjH0UOq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 16:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjH0UO1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 16:14:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03452103
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 13:14:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so2043559b3a.3
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693167264; x=1693772064;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jOZvqNec2SsnhlhBZjwQQ5UUgJ5WDB1PrlubWErrQIw=;
        b=aL3OounB7m8hmR5cYQqlfPDSbZAkxH20eVlx6GkhvO44C8jhEogCgjdTvMOTzay1rf
         4MSHoIRed/dah5ecICiNYWuMImuP8NCuv6DgLuTcr5ya+ucoTjBj7oEZJEL+096rinhH
         x9wDJt6G2FE/z9fRATeIMIysf7TRzpwrkdxYsJZ+qGzyFGvDgphx3qvBDLeLhl4ETult
         eaMpxSLiAqE4K6G0XFc+oNBr0hn7+4NkI2n2lSiR6MGlVrPUF667dJOUq+TRTSeB+L3W
         kQP3HobBrdHSfaMYjVTD9YFbY5+Sg3Lu4oE084Gha+vpoJqZ3fz9c8LSTHtHCjxrMh0s
         vEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693167264; x=1693772064;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOZvqNec2SsnhlhBZjwQQ5UUgJ5WDB1PrlubWErrQIw=;
        b=HIDbroxzH6ayDTnMtk2LBFcvgN+LZlbQYchKVQJJuRFbkZ9spUs945sTTnPsDW9OGW
         288IPn9C5D9jWj/3PSKh1hNvQZoa4Z3cgiBIi7eBv8bpSbHJ2Fw5ZGtmUVMk17fdnMED
         zZvgOQSFnpcXbXK5pqZ+g9hiNOtBgcHpOEkt52JlJuIMBglv+Sbj3nR7kV2xqDKZ2c5c
         Jb01SU5ImS6VMkY1n3NgWomRhUvv1Fl1G81zz1bXkHeRwodnybMSMT2i3gtiVQxDTd5j
         VgbLHEXzEuOed5yF7Yuh97Bc/dOJ57Coc8HjMvmzW9Z+SWprn0UNeUe+5m90Y+DghDyD
         Bj4w==
X-Gm-Message-State: AOJu0YxL+wSFsCTm89uOlH7aNk8jLGHIIlFSN+77RD3upjtkEKJvqHHT
        652GMYbeucWhJtHkC0xsw8IPsnLwKBzHJCc/DFE=
X-Google-Smtp-Source: AGHT+IEItjl4w7TEAODOaeU+dRjsGMuq0GBP3VSDt+awCqYFoULDf8dLqWpFQUC2GKO4U8/JazwvnA==
X-Received: by 2002:a05:6a00:850:b0:68b:a137:372b with SMTP id q16-20020a056a00085000b0068ba137372bmr19355945pfk.19.1693167263876;
        Sun, 27 Aug 2023 13:14:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b0064d57ecaa1dsm5180800pfh.28.2023.08.27.13.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 13:14:22 -0700 (PDT)
Message-ID: <64ebae9e.620a0220.65e4e.7e24@mx.google.com>
Date:   Sun, 27 Aug 2023 13:14:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.49
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.49)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.4=
9)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.49/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.49
Git Commit: 024f76bca9d0e29513fa99e1cd0f86bfa841743b
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
