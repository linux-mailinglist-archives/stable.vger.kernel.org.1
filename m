Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3376AA82
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 10:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjHAIEx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 04:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjHAIEw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 04:04:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B335CE6
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 01:04:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b4749013so42496185ad.2
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 01:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690877089; x=1691481889;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9aRfZKQdrmE/5zSTLZo++nc06Hr5OqyAjAtIy91h8wk=;
        b=X5is6zMIGB7GC2L0SHVTPw7M13DQt+tzVi6ggLpN9CknJrE37yXntw5c5j4lRAqNZ5
         x1ARNgCbLE9XAoX+bqx+OoeivXGzdy12SiSDc66fxGZHp7eCiJJjs9TkBoX9x7PSCTa4
         cS6EMxHSDeeBQRI2NF6pcz8FvI/u3jMdb9GGB0A7WOp6UK6gD8f2KdwzSPOdl0fnJN93
         545VfaLu7OZ8H7DZxr7kWSZSDKDZH6hPiCvZM2L66ANs9faFOP+oHZcaZ3M3/yQYhody
         T92GBp+BVCGl958fLKTl+KighTZnDtgzF4V+V2rpo+u2r/bNKtGaWT+GwyL1sV1CYP3s
         g/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690877089; x=1691481889;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aRfZKQdrmE/5zSTLZo++nc06Hr5OqyAjAtIy91h8wk=;
        b=CoL/MqieZsu98BfZWm41hvP6iMnbH96qx/fN3vZ4vZBXCT4WDHOMu7Ncgi7EAT+nij
         PFmOf8bMomOgLfxCJ3raSGw1zhcAoibj5tQEY/uvqk4AsV2+Gp20thbaZpda9Ccs2Vz0
         OvfLwHADQcovSBVp0MFqnfuvDRNXP1bmQSm20Y1QBGCqxqbvss7iCDMOw4PElTXnW+MV
         E8eGkaOZoc0SB1961gTdlgZx4B9pb8n5Jnsll877AFTYlVV0SJLAbAhzyfI+z77h5Ecu
         OjD9otLH3PkBJrc2oPRF9B6yRiSUM1WtUZi6mMUt64jAJrld4vU/T7eP+/iljq5myk1K
         gJtQ==
X-Gm-Message-State: ABy/qLZkDQvu8XCVJuPNjdh6KLGmnt0L6SdYoXFoa/HaQZdYRKuvgzcS
        RMK7idG3EJEXvftRVXZaW2x1FOzQ/xioPYXhltUuhw==
X-Google-Smtp-Source: APBJJlHH7MfYSmeuCGvnHI91rtCfoV9Tv1H6uSfvHlmlVz2EAxg0e7b/7rLaJHa4AyW4uNjmj6BcWg==
X-Received: by 2002:a17:903:1246:b0:1b6:9fec:8134 with SMTP id u6-20020a170903124600b001b69fec8134mr14135209plh.46.1690877088757;
        Tue, 01 Aug 2023 01:04:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902bf4c00b001b3fb2f0296sm9867422pls.120.2023.08.01.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 01:04:48 -0700 (PDT)
Message-ID: <64c8bca0.170a0220.f4508.324e@mx.google.com>
Date:   Tue, 01 Aug 2023 01:04:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.42-221-gf40ed79b9e80
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.42-221-gf40ed79b9e80)
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
1.42-221-gf40ed79b9e80)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.42-221-gf40ed79b9e80/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.42-221-gf40ed79b9e80
Git Commit: f40ed79b9e80b61b5ef079dbb21b2c7b450191a2
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
