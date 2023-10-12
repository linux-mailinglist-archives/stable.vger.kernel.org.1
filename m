Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE477C7711
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 21:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442098AbjJLTjM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442138AbjJLTjL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 15:39:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBEDB7
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 12:39:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c8a6aa0cd1so11713075ad.0
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697139549; x=1697744349; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zUQ4FQjNCdihbEI06S349KoFX7DL1Q6XHW38Uz4llSc=;
        b=nU61Kox/oSw9urHoKU5Y7wflMIFhto+rdwS9DGGbIfVcsOo2utkxxLU7Cm02wrXOuW
         ozq170amQE6nMP4mzG4vfCdGhDYwS1Wcdv8EF5w02qs1c9HtHgL6/RrIiEANeRM7yAwP
         8+1qfMe5FvKAJoz1maPsMykPhakny7Dup1XFgBXQVdmBoa18qMj+JXcEsuCrN2HlHTt3
         fl0/lWf7x8/86G5ffQPSUNcLQQAxcRPDfR7DPlvriiuXinYb2B+xcDoHCzQs1Mzt+H2t
         Ef9vqbmb6Q4BpQ+5+ldYaTGW06QZEwv60cP2MVVttTj3npOCXByfVcO5CaWb+Wned3IE
         NvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139549; x=1697744349;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUQ4FQjNCdihbEI06S349KoFX7DL1Q6XHW38Uz4llSc=;
        b=uGKQ1iqiBP1OmJ4JekbR3/lT4Y8AcLjkcUfJXzNv0/Ti8gcy3nuiKVlRSqkI/9W9Ur
         zbNqlnlw3ZwbBEoix1iK+6yhHY5MdK03dVoxvJncKejK/x/y6jXPLtBCfDvLAXCu9qWC
         p6kq3EQf2VzrnnUGfYEkM7uieOqa7vjsfL42FFOpypsulxj8QKhgFi7BvK01hVRDJb6d
         2Amtvx3NReovSKAsEdO024fvQdQJAoashCGuEhjXS3oyjxnbze9T3Y2HbYgT9Hg2Tko0
         x+fYn/i/fhHqoc+mFlc9QPJ6SbuV00vE2Sl6FysmHxPNfK1FtJ+WjUA/b/K12ec7UYSG
         UGoA==
X-Gm-Message-State: AOJu0YyI3qmCBPjKn3DmSTIP+5yd73kXTy16xTRe1KvjSxaoOqzcWgDl
        9hl8IPy6zO8RpFMJU88I9rw5yRVN45WoyqAmiC8djg==
X-Google-Smtp-Source: AGHT+IGzAAb6tdcRvcJffHuuRtgq5hRkI6tXe0b1FIlmmB51t46ApXbEzMqpV09Wt7tODA0ozLdarg==
X-Received: by 2002:a17:902:7248:b0:1bc:10cf:50d8 with SMTP id c8-20020a170902724800b001bc10cf50d8mr22208539pll.23.1697139549466;
        Thu, 12 Oct 2023 12:39:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw9-20020a170903044900b001c3f7fd1ef7sm2384765plb.12.2023.10.12.12.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:39:08 -0700 (PDT)
Message-ID: <65284b5c.170a0220.12486.819a@mx.google.com>
Date:   Thu, 12 Oct 2023 12:39:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.57-7-g3fe61dd155ac
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.57-7-g3fe61dd155ac)
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
1.57-7-g3fe61dd155ac)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.57-7-g3fe61dd155ac/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.57-7-g3fe61dd155ac
Git Commit: 3fe61dd155ac48d1642f5cac17bd41a92ef585b7
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
