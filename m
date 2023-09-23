Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9A7AC1AB
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 14:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjIWMGd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 08:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjIWMGc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 08:06:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C72199
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 05:06:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso29071515ad.1
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 05:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695470786; x=1696075586; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YRqBrBVp+Kt7AnzFYxmel9FW3AEmBIsZvhsYyXypctE=;
        b=GHnfG+Cj8WeBGnATyXbkN3xXBnGegd9MTZi98J74NvTF47e1z44qOj78+mhmh8ctF2
         l+rgK0chMAFaOIyNKIZWmJo1EFPdNOTPT+0ezEo4wTTiQL1mVv/8hqwXnRzb801nVgHV
         vmZ+ETlk+bMwlFQsUmmH2SCKHx7imx9dSpkyrKhKlOFBCsEdh6Bv02Wq6iLTZsbuIm2Q
         Htk8tmwP5+ndIjVytb3wHdXvjCTEusrN+1VKPtVElkDECn7tK3+eBS1jwTPQoSnu3Ny2
         uVNbLe+N3nv2Rat5410GFBlxitUPUmDbYxXbvktPOeYzPrjf5GVncdEXQh/SfdAkpyKe
         FHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695470786; x=1696075586;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRqBrBVp+Kt7AnzFYxmel9FW3AEmBIsZvhsYyXypctE=;
        b=NS9lQrxKFnAIxPhYCHYv0iI1qtEI3fJuxrMnYdXMmJN4uhwEK/5huzA7f4+lfhdTio
         SEt9KTKbNOr9dOTmQtPu5MSNT7Vxe4LZGtY4M6rI0w+b5EN3iOaL7xHZcidIuWLXh7rG
         RAWOGJEME30Fy5Oewgs2hJZDqoi+U9ODkNXpZVdPvXs/2whhkZ+1vdfedWEW1zYn3IWR
         G5yOdBJzuPKecAORGkrYxuT0kSgdDcO7UzWSrQuluZWJkf8jASdlf8cZgYAXp0xk0Ir3
         a0Rm1S3PHSXiHMy/wscF0O1j+2GUQoyctR5HFBHcG5kmQ5Kb4qZ4iZ6RHiFo41rEaH8M
         DDfA==
X-Gm-Message-State: AOJu0Yy2qdWtUecnMvOk6Rt7JpkCJs7EA7LsQ4OUCJyL+NdvEHLAa5Sb
        H1RAhIDxeKewQUdWHaFgRz1FLqsaStJUHW2FsD8yBg==
X-Google-Smtp-Source: AGHT+IFn4GlsNwkb1rl8kWIVDL+0mA7XLUcmkCjqlUw9JmiV4478KidC9dXEjQs7z+cEF5gdNByvAQ==
X-Received: by 2002:a17:902:cec3:b0:1bf:fcc:d047 with SMTP id d3-20020a170902cec300b001bf0fccd047mr1847617plg.17.1695470785751;
        Sat, 23 Sep 2023 05:06:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001b9e86e05b7sm5215954pld.0.2023.09.23.05.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 05:06:25 -0700 (PDT)
Message-ID: <650ed4c1.170a0220.8840f.9d41@mx.google.com>
Date:   Sat, 23 Sep 2023 05:06:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.133
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed, 4 errors,
 5 warnings (v5.15.133)
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

stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed, 4 errors, 5 w=
arnings (v5.15.133)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.133/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.133
Git Commit: b911329317b4218e63baf78f3f422efbaa7198ed
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig: (gcc-10) FAIL
    defconfig+arm64-chromebook: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 2 errors, 1 warning
    defconfig+arm64-chromebook (gcc-10): 2 errors, 1 warning

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning

Errors summary:

    2    drivers/interconnect/core.c:1150:2: error: implicit declaration of=
 function =E2=80=98fs_reclaim_release=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
    2    drivers/interconnect/core.c:1148:2: error: implicit declaration of=
 function =E2=80=98fs_reclaim_acquire=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]

Warnings summary:

    2    cc1: some warnings being treated as errors
    2    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unr=
eachable instruction
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
defconfig (arm64, gcc-10) =E2=80=94 FAIL, 2 errors, 1 warning, 0 section mi=
smatches

Errors:
    drivers/interconnect/core.c:1148:2: error: implicit declaration of func=
tion =E2=80=98fs_reclaim_acquire=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
    drivers/interconnect/core.c:1150:2: error: implicit declaration of func=
tion =E2=80=98fs_reclaim_release=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 2 errors, 1 warn=
ing, 0 section mismatches

Errors:
    drivers/interconnect/core.c:1148:2: error: implicit declaration of func=
tion =E2=80=98fs_reclaim_acquire=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
    drivers/interconnect/core.c:1150:2: error: implicit declaration of func=
tion =E2=80=98fs_reclaim_release=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]

Warnings:
    cc1: some warnings being treated as errors

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
