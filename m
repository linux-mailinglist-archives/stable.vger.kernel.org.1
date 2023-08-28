Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65B78A7C8
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 10:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjH1Ifu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 04:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjH1IfR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 04:35:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C632E1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 01:35:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a6f6a66e1so2049245b3a.2
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 01:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693211713; x=1693816513;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rmQF6oZ+3BMkEVfPyyDujwuZ7AIiNaSufF5WMLCX6RM=;
        b=DzIDfrUTwbM/siKi+m7KmtFG07LY7ivHh15vQGVr2bdkY8lK7tbQyAOFtThTY1+7Wy
         8e+b9O41rf0xB5hK6IRx2TfUTxg2PZ5TO+fsFbLplZAyDi6ZfXXUumt7zJYKYXSgJXtr
         QyT1AYuE0wZ0vJTfvLQfOWT9gpt7jKIG5uRyVtTcOnc6UbiDQlKbO7f5PG2FzKRibUr8
         7X3GTeSHWOnNk+h2VgXtEp8CUR0Jyhpa0e2lK6IilfMuGD41KaZxCQP8XJIL0LnGq49w
         Qsj44azRrn0GzDWI4snRdD0gqqmyhfk9ABO6PyE2IU941QRsymUeLeVSiZmEwqOWosWl
         mFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693211713; x=1693816513;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmQF6oZ+3BMkEVfPyyDujwuZ7AIiNaSufF5WMLCX6RM=;
        b=F/okPZCvxqucOgvMxQelNnXWJLhfDtfZ0rho2j3cyVE4mNTe9IMatSAOACqL8JJk+Y
         rxoVsQLkVhdBaFFSG0i9NSpj+Bo2iGIo0r3uz4rpBhpfJbHu8qOPhem9p74ThqhFv0mZ
         9y5SDj3N6cjNGZlQMBoG7PVmKfDqYX0RdzX0tKvgLpt9Yc+VBumgUtpCO+OTvglFMwQa
         6unKKT138BE9/B5ECWrVM0GaqT7c9AL7eEsmwR0uIqq9d4VyDkxj7YJQ0IHbJfJzsqeo
         C60Lpt1LhdAab0WGW2zfl5fXr1oebqPbNBoQao5NyClpPYvnXicXKZib/qWqfJqsZS/V
         N49g==
X-Gm-Message-State: AOJu0Yzi0MgipfvTO+sBJNt9vFIjs7HWtyt3U9g64rc+Shx5dWyxJ4xo
        7VBMmgFFyv5S+DM2w8eBOBxhy/dONODVGT+/Cjk=
X-Google-Smtp-Source: AGHT+IEz/7sMZ1+hWpMKWeipXV8SDcOtH8np7lBZPsTaaExVpFJFi9J8t/V3qkHSEVpH0mj53fB+Kw==
X-Received: by 2002:a17:90b:300d:b0:26d:1eec:1fc4 with SMTP id hg13-20020a17090b300d00b0026d1eec1fc4mr18563301pjb.19.1693211713258;
        Mon, 28 Aug 2023 01:35:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090a804800b002693505391csm8304978pjw.37.2023.08.28.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:35:12 -0700 (PDT)
Message-ID: <64ec5c40.170a0220.6880b.ce2e@mx.google.com>
Date:   Mon, 28 Aug 2023 01:35:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.48-128-g360b24c05a932
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.48-128-g360b24c05a932)
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
1.48-128-g360b24c05a932)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.48-128-g360b24c05a932/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.48-128-g360b24c05a932
Git Commit: 360b24c05a9322e4e5536a9531bd38702f48dccc
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
