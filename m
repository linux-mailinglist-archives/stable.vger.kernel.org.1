Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28FC764F02
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 11:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjG0JOK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjG0JNV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 05:13:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623DFE75
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 02:03:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bba54f7eefso12608165ad.1
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690448620; x=1691053420;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U8dEJo3+soeCfp57WxAWOENrzHcTpnQhYikCZNeBN5Q=;
        b=nQ9AwPlVENwrkPsAniciC1rTXt0ATSPCmvcpmZVXkoXu99Y6FYeVBo2SS5w0HEzcdg
         fTaF4ocE6CYCt+FC3ND0EmSOXmb63T0dKE58VoxNUuB0Xz3ah853XNVmR6LXy/lmqvvu
         r311E1b63j/4v5tg4ml+mwkUYvvjfzYlx+BrEIt0vW/7zUBstzyRd2u/LhVB53iBl8A3
         D0573cGSNhWUBjCakXAWtdGT90iFaOtR76eGjPjvPw0JpT0yyhzh/UXBLu5R3Kmcv+Ss
         8rr+/OAjduGGxDs1h6N2cpl6xcUEpmT5fpHYodWyUwj5CC98RerIDIvP/Hqg1rmWFsOZ
         heVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448620; x=1691053420;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8dEJo3+soeCfp57WxAWOENrzHcTpnQhYikCZNeBN5Q=;
        b=U93+3D0M2m67yf358ckPD9grLimYLB5eHiXkE2oDcdOIYrb9qbEJSmzDnVJjnrAyhC
         /tAydHcvNKzAvRT/8ijznIUURDXdAmHJhO5Raqwg2AGnySfpKTKLX9BK2PgrXFNq9yrG
         7jMmOMrEVQ39UwIlHOSS289935C7fAojW5DCEgiFVyidCJnpnBIbRN89gSxvopEiLTRj
         jUtWsX3KdXUuOILI+weFUBpJefTV/vJYZYWga+pgcAlHlVNfSAduOz2z0w+L1aYp+nEI
         egzFZ+4T6nFXj8xHQiso9lT2UjZQWFP2kstXtMA1x3NbEY24VJ290KwOy1VtdtbHKTOU
         Nf8Q==
X-Gm-Message-State: ABy/qLYWb9ID4V/WUr5JRnmGRQ0HrREWhspYqHrZPh9hUo/jZAL4bRMp
        anMPJLUrV+cp2Dh26yS0eqAOdOMXd80DXWSUwmUfSw==
X-Google-Smtp-Source: APBJJlFzHrUyJCVfHLTtoUDX6AvuQZ5q46yekxoDr+8CJEiIhWVZmDHYBEOxmPDIgJHVSDbN2z1Xqw==
X-Received: by 2002:a17:903:486:b0:1b5:5162:53bd with SMTP id jj6-20020a170903048600b001b5516253bdmr1973310plb.33.1690448620138;
        Thu, 27 Jul 2023 02:03:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001ab39cd875csm1063851plb.133.2023.07.27.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 02:03:39 -0700 (PDT)
Message-ID: <64c232eb.170a0220.a473c.1a85@mx.google.com>
Date:   Thu, 27 Jul 2023 02:03:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.42
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.42)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.42/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.42
Git Commit: d2a6dc4eaf6d50ba32a9b39b4c6ec713a92072ab
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
