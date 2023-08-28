Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B178AE61
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjH1LDv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 07:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjH1LDo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 07:03:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ACCAB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 04:03:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so1958369b3a.2
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693220620; x=1693825420;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SfOXs1tkNRCFGTcbWOr7MOoXY9AXHnGfeo2qgOrPtJs=;
        b=gmgw18BPnlwLO8Wev+zBrdQFNrEOQKtHsVKP16zxsPBO8VAyOuj/qXeqvBGc5fU2vN
         9zfGuXlDHYt5CyJXUYD/4udxUKH18bZI9QfNNYFEgMlZuQIXVoVtnOXuS3yyr5QwHxUp
         Z73GOpRKrNsqI2lZ3n2ORqJTOwC49UhNT+a5F5yRX0/oyIEaUefGcFxwnZLdlcBxCXbX
         q8+N/brGpgzeqcs3Q9kX0710FuqCuTr2x2eGHBm5h9CxX25evw9id/B9qTGGJlTOmLO4
         tHbO8QzRvmzHkyDh1hjNJpq59cuLqxqrAu6bQi7EhCvXyJPCorYKtNK46yMIaKSrEAR9
         AbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693220620; x=1693825420;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfOXs1tkNRCFGTcbWOr7MOoXY9AXHnGfeo2qgOrPtJs=;
        b=FZnvAJP32NzIS6MerdfzwhlrVPdxbR8pS34bcoxJ0gtwqZ+Q/4e/AIfCq8iq9dA6Lc
         2z1/RwxOX5tZufCiqkWizROnVaxnSgd3iR82PtgbwOdqYhoF03CuXX774/ogzT6nsoGc
         UHq4O6TjGYQiqd9UdErnHkZNSpslObT8YKZJbCHzQMSEgVewURCxlb9u4KjKMLkKiSLx
         clLSdSgohVyB0mmQJFRGw9yF6S27+uDCDgH99JNqgDEu3yJ22CvtybttMM5ZXxvWf/YP
         5UPDmlaf7cSh2qczDuTguHRGWSpb6zlclV1Z2ZZFdrj4BiRyMsaeJWAcQiEC5jL9B8gH
         MloA==
X-Gm-Message-State: AOJu0Yxnsm6T4GWeJfUuWg1Ig/93S75ahoA9n1uookH43NPiDMsLRI+E
        YE5Q8ICMX6LKnKijYPEH6Z8ejmFrjXJtymKpW+k=
X-Google-Smtp-Source: AGHT+IEL0tLLC/PQ76d04qRSYHKRTHfSXkeuFx2T6C9zA8gVmYgE7hjW59s9tzA/IV6fg7syPAhpvg==
X-Received: by 2002:a05:6a00:1786:b0:68a:3ba3:e249 with SMTP id s6-20020a056a00178600b0068a3ba3e249mr30971949pfg.16.1693220619799;
        Mon, 28 Aug 2023 04:03:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0068702b66ab1sm6567788pfn.174.2023.08.28.04.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 04:03:39 -0700 (PDT)
Message-ID: <64ec7f0b.a70a0220.62f5f.9836@mx.google.com>
Date:   Mon, 28 Aug 2023 04:03:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.48-128-g1aa86af84d82
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.48-128-g1aa86af84d82)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.48-128-g1aa86af84d82)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.48-128-g1aa86af84d82/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.48-128-g1aa86af84d82
Git Commit: 1aa86af84d82ad518de80697bddd58a9df5dee09
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
