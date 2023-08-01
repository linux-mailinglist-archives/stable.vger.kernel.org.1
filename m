Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED776AB70
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjHAIzF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjHAIyw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 04:54:52 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957F61FC6
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 01:54:35 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bca3311b4fso1464364a34.0
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690880074; x=1691484874;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yuGmJhpmdLuu9nTjcRb12MoWsKGBg2Xnh0VFKZ5SayM=;
        b=xRHl/nks1ke+jZa+ngZmHw3uBBvW2grKOfOmI/XnA594/9C7T7/NCP1VIaTeZiavy8
         +NM3+hJExTFfCWnICLn8NAwDZBUde4p6viBycMv5cCCYrq1q6aqo/s31Mjcfxd9uq60w
         ScPwSEfm8s7uQfmGtGosF0IVj1T0udcIqmw9yX/P6Yc21o6XZoKkfNZlL775IRXOkbHJ
         df+IJ/QvlG6wOtsZdKXUgN/lORnOLG/678IRyxDQZaI5hygSSLmrxQhse2nrr8IOk+8R
         xACWWz/Sd7tJHnQuGY2QQyaeOmAQAAw/nqADPgTpIJnaCcRLmZZN1VMUfiwkBzoPflq/
         hdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880074; x=1691484874;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuGmJhpmdLuu9nTjcRb12MoWsKGBg2Xnh0VFKZ5SayM=;
        b=iOEIG3+Y9eo21LDFIb4WZlh16HT67gWYiSp7KyaG8IizlFuIbRLblWutFAgvDQLKFC
         k5FLcWzz5JlbyPrwuA53YDjKlSsF2uqe3U6L2/47q2ODrwW5oCG7RjzLbskwyR9gjQtF
         CbdDPFmAvYlEvzzPbmierM8EkgnbTEQKZqFXdIOZ0Vi6CSFUguB102Dy82X5RUUeAIxr
         qAzYLChBPqKdHyPI8JDkIYAlLrMjMv6qZ3pWZ5lzp+tpzC7RuJ4Ziqnq0Fj4S7t9SbEF
         Jwf3zp2t34DCjmd2jAFym2irY3YVWikF2z2hYTzeHGoomCSnXBUFhfdbDA2KZSGTuk0z
         F6lg==
X-Gm-Message-State: ABy/qLaEVBMOgCU279LEpciTxIxJkINZvM5uJ1TnfzDrcH+zN/RcIJBj
        Oaz0uYbvAAgQ/ya3QILXNvjvF2NUj+NjWbUSt6u5jA==
X-Google-Smtp-Source: APBJJlEFzc6GpU9o8MNuoA7wAidk3B5q7T2HAhuxTkXuP43iKpQeC2xQooQK5Amp8ZecbmKEs5M3lA==
X-Received: by 2002:a05:6358:5e15:b0:134:d26d:e27b with SMTP id q21-20020a0563585e1500b00134d26de27bmr2483982rwn.25.1690880074344;
        Tue, 01 Aug 2023 01:54:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j63-20020a638b42000000b005637030d00csm9485709pge.30.2023.08.01.01.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 01:54:33 -0700 (PDT)
Message-ID: <64c8c849.630a0220.a5ff3.1763@mx.google.com>
Date:   Tue, 01 Aug 2023 01:54:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.123-149-gcff76fcf64697
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed,
 3 warnings (v5.15.123-149-gcff76fcf64697)
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

stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed, 3 warnings (v=
5.15.123-149-gcff76fcf64697)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.123-149-gcff76fcf64697/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.123-149-gcff76fcf64697
Git Commit: cff76fcf64697fa08c2f74f401e6c3e32f90f0d9
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
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning


Warnings summary:

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
