Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEBA7621C7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 20:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGYSuP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 14:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGYSuO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 14:50:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F291BC2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:50:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bb775625e2so1145165ad.1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690311012; x=1690915812;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o5xhlxGEciICrpf0FcyGddC4Vw0Sbuv5sLXo1epkNUA=;
        b=oI9g3bUBoo274PWD5ZO5MYWPd58zD4BvIYrq/0W0kOFIeQYLWOam+U9vRWvHhmkD4p
         uRflMG/VNe7/uPpJ6+skG/UN2vEUBw9lUOdnUtBpbuMWd4DT2OyNXdqW2BJFh1xEi2Zy
         7+GfaELDnvfQyzkOxkl/XWkSOYzsmVRPCKvz5Xl2bE7WW63yXGSU9hqP3focf5Lsf7rt
         DagfMv98xbDfRrcWNGZO4RBLyTdgsSfIdiJ0GwXD2+EtKqErL7s8gRCxYRwfQSBbepnL
         /XOSVI6+pc0ArYGxKfplT4JKCWsUCKjBy38xCGBRlP521o4ucyrLPt3yqZZ64FeA9AGx
         uQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690311012; x=1690915812;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5xhlxGEciICrpf0FcyGddC4Vw0Sbuv5sLXo1epkNUA=;
        b=fI7bhBUoWASatd97Y47/397XYKq4qcr/gSqlPW2ColrE1OPxPgcNHKNzpbcKExHuoz
         y3XjIB0jla6giuySYm+SZBCIGME3/Cy8mV1AvZDnvIZ8g6+GmJYCa8E35IuwqeiKHziT
         Q2SMgORwKNPeHpEovrCPP1Jvz1m/clW83NwkAUBsmzSSb7/5byu6xzoeDy2Z8aSdsPgn
         IkNlW/hOp/J98WzOlgH00vF7fXPZwan76yCGYnicwEfJjcVj/7iFz47UQTMEkc1HW8HK
         0koNgVCfCuA3Z/CG3qshJd74NIlyG2vj0Um1hoku38nHaHADHhdY+5iQeUr2QdAJugAW
         MtRw==
X-Gm-Message-State: ABy/qLbJXGSATXURSfY0SgbAo1TCW4zjmUlK5putKoGSf00/mE79vs3s
        6YFOXDfvr5JVEJytVFpFR+Qr+zTO2U/Tux3t2kZbRw==
X-Google-Smtp-Source: APBJJlFEN8eQPVjL8U8KwMp6/uqQvoqS5ErmqLf9c2G365p5HPRVEVdRkpyduoRVybEFQtyWMoPRAQ==
X-Received: by 2002:a17:902:da87:b0:1b8:954c:1fb with SMTP id j7-20020a170902da8700b001b8954c01fbmr56740plx.7.1690311010481;
        Tue, 25 Jul 2023 11:50:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902c38400b001b8b26fa6a9sm342329plg.19.2023.07.25.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 11:50:09 -0700 (PDT)
Message-ID: <64c01961.170a0220.8befb.155b@mx.google.com>
Date:   Tue, 25 Jul 2023 11:50:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.41-184-gb3f8a9d2b1371
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.41-184-gb3f8a9d2b1371)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.41-184-gb3f8a9d2b1371)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.41-184-gb3f8a9d2b1371/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.41-184-gb3f8a9d2b1371
Git Commit: b3f8a9d2b13712777c36667183b782dd7efa5039
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
