Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1965A78981B
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 18:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHZQgK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 12:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjHZQgB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 12:36:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453F31991
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 09:35:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso12715655ad.0
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693067758; x=1693672558;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tsEbEVIyWLEApTi1WghRkcW2BxkdueFNm3U7pNRY3g4=;
        b=jcUyc26W4IBMpdh2ufccwBizR490eN1ToM5wJo4mRAF4e0rdvvdvjiE93uDcRYzPws
         HI7mhGlbMGNxQrHUhb3ik1IwuFpfjMHVTkBRgbhdwqjXU5Ca/4QyoNgQmictxmr51C6C
         kDLUK2HC5m+H8qYJBQFhn7UhKZe94tYrW+0YDSUTak4/1mt0+Vz5ABgYIV9yMQYkAFe+
         UNWITcbwzglYQCTErRB947S4d0wRQD783Hjzor9q24/3Ilnt0N5uz6DCR8y7qlJjDdZh
         zjU3B5QtLlNVm+A6grPVfYqOnHb41LxY+XTyzwT5Y0PXO2AkivcG9HAp/4drRAJGug+r
         G1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693067758; x=1693672558;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsEbEVIyWLEApTi1WghRkcW2BxkdueFNm3U7pNRY3g4=;
        b=JVTgWYpEyfF5AGW/pZaJWkFka/n2O/3pCrn1bkNh6e3HWfWd0en23CfN5m3cDy0YUv
         BfaHr1QE8PEuhmJFvOBvaHUDj0vGdoadP3Bt9n40VpKFIgIM2HGc6RATHzquZJYfT5eS
         Qyn1Rqps9upv3rRuP9vEGD7IjJpMpsm7vdtD8tK+8sr6XlMSQaRneSRo8ToFzOaQcaXf
         Tm1fLG17+Ic5ul++SpzX0v3t7Nwd+nlZHH2juZKVQjGFaWzPxB4GvVsSo9jmkWZeI8h5
         Nqs00o/7X2uJbhd+dFGpA8N8TagIDfPu88/W9XFSx2Rmwc7e7FF9zva1YRn9Rwl9Edos
         QVCQ==
X-Gm-Message-State: AOJu0YwzgYws9vkckMldJLnSF4fDkW9SXOGcNtaou21IsX4bk8iIc9hf
        0nzBPOA3HfqFkRKddHy5nI+e12b4iXZMvL2HLMw=
X-Google-Smtp-Source: AGHT+IGjV2m42qJ6KttNfFvzgFPg4QuJz9w3FzsKPg1dx7tZt96oWCjymIYDJJijgCKCVeCMrsPXNQ==
X-Received: by 2002:a17:902:d488:b0:1bd:f71d:52ab with SMTP id c8-20020a170902d48800b001bdf71d52abmr21473915plg.56.1693067758269;
        Sat, 26 Aug 2023 09:35:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902ed4300b001bdd512df9csm3919197plb.74.2023.08.26.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 09:35:57 -0700 (PDT)
Message-ID: <64ea29ed.170a0220.a3450.62f5@mx.google.com>
Date:   Sat, 26 Aug 2023 09:35:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.128
Subject: stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed,
 5 warnings (v5.15.128)
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

stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed, 5 warnings (v=
5.15.128)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.128/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.128
Git Commit: 5ddfe5cc87167343bd4c17f776de7b7aa1475b0c
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
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 2 warnings


Warnings summary:

    2    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement+=
0x90: unsupported relocation in alternatives section
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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement+0x90:=
 unsupported relocation in alternatives section

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
2 warnings, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement+0x90:=
 unsupported relocation in alternatives section

---
For more info write to <info@kernelci.org>
