Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7397835DB
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 00:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjHUWji (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 18:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUWjh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 18:39:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE45FD
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 15:39:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdcb800594so23036595ad.1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692657575; x=1693262375;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EbdrZWJcdcFj0FD0tLUbfcJWqUMA8xE2/FcP4b5OcUc=;
        b=RM5hiIeOtyCd+YNbLgxr2vH3s8/4goDIVN3QnEH9l4LemWjTGNaMZsf56KcSdZy642
         0LVN9/WGyBmJkKC/p87tdbEaQm/bzAw/iijvJQuUy+xRzmWnxfWNRipDAtVdigsPN+PQ
         CZxNWK8TKgSn3ioVvZdtOmfmcTSul1YqShknsGpY76fSUYadzHOMCrQUf6ST1FwKu6/Q
         i3n/nwd6nymbsK7Za/0tMkDy5TjmGbSDgZIyo+11gbgOgX86937CuxhvhucZm+Wqxxvx
         3TU2cahHyMZvVJFoJWsWsinJrFBMQG1B3T5dYBqKtnv9zxC/6Q2CFz1scclhn7riih8v
         ChSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692657575; x=1693262375;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbdrZWJcdcFj0FD0tLUbfcJWqUMA8xE2/FcP4b5OcUc=;
        b=Emdul6/STJILjv1cxjDV23PVFb16Za4hIAtIjN1Ey58GwshiYCCt747pR1abtBZH7u
         54uXc7TovY1OmFyZTzGQN0uB56bH3V4G5XS2BrHYX+3y6/4boekQhggHH1md0HofURfe
         B9DAITUAaECgfV4I4xvU6OYcxOCakMK1o6ArumIJMduEk/PSTKUho0K5e3BfifcQQ5y0
         sGfuqj+9K/c4/KeDoOHp6JtoLh5qvn/6iOdzsGsn7AjqmVEMVrXsgOr2aHiM5Dcv5EE5
         155m380yqwjt7tCF/bDM/f3PQwEFkd7zd0eo8ZlAH4v8c7zZR8n+ApiHOhzuNWfRDs1M
         WzhA==
X-Gm-Message-State: AOJu0YwgG+/uh0mhbCnFVBqkoHKzeaBMYikPQ8OmPfkopF9PamRivwV7
        2wUTZj7yr1KpPWv28w8/ldpN80dvR0p7i3GK1JLORQ==
X-Google-Smtp-Source: AGHT+IHYHrw8ZuuSkX5AhCZk8FpoiEpJXYx2lYyt20C/kTK6v/1PYtQU3cXewf6mPlizWFvVU2Pucw==
X-Received: by 2002:a17:902:b617:b0:1be:f76e:7664 with SMTP id b23-20020a170902b61700b001bef76e7664mr4965319pls.29.1692657575126;
        Mon, 21 Aug 2023 15:39:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v4-20020a170902b7c400b001b243a20f26sm7548581plz.273.2023.08.21.15.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:39:34 -0700 (PDT)
Message-ID: <64e3e7a6.170a0220.f59e6.e4a2@mx.google.com>
Date:   Mon, 21 Aug 2023 15:39:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.46-195-g5165f4e9738c4
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.46-195-g5165f4e9738c4)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.46-195-g5165f4e9738c4)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.46-195-g5165f4e9738c4/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.46-195-g5165f4e9738c4
Git Commit: 5165f4e9738c48a220a13b073c6ccc24824aeb74
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
