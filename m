Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B617E6A66
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 13:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjKIMRa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 07:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKIMR3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 07:17:29 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74611B1
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 04:17:27 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5b980391d7cso637061a12.0
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 04:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699532247; x=1700137047; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u3M5UHNuOkNEtQmpJlUmXYnhWJhhDZFDLcP6LOW/WZE=;
        b=EoewHDwYwH7Wit+cPUytvr8UU84yZipJuxyS2vTT3dhOaDMiHHTM0E2NXJwCREnaUO
         64fXoB0PFC726sgzqBL2RvSuze/RGU0pYOI64AQBcns+34u+iBXvTX7TfrnPbvJuQBqI
         kX3Nq20X5OHsHpYCr+AmJEWTIvvWgtYGdSte8itjisl4QnxwUbkiwu1pCfRIfhJByT9V
         +U3/9M98jGXYSUPoZAewkgJ0ooCEyLcCD5A+wiFb0aNuT8cMZbbUKRLBYBe4fUIIQgLe
         MJwmZ74S/JX2x2OEKjenZNZTUSPs22hDVaPQ6bSdDnRLkFJacnyO3/uFfTE8uom+hPxY
         50Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699532247; x=1700137047;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3M5UHNuOkNEtQmpJlUmXYnhWJhhDZFDLcP6LOW/WZE=;
        b=vCZAZpWe+TdkIzNEkCxxyfuC1fYgIUs1pU7BOEOdKFRwGUvoS6HTZPmXnZ8c0zecR0
         lIk+bkj0GhAzNj8P0UyMTZNkutFIr0DVVMuvmEe5a+tbpX4lY3/7SG2jRtInBX3gFlMJ
         OMzVZ0kFE+xv2O5FSaQ9FeaFF6qctxMqbj5+SQADgOCogFOulEBzs9tMGvOCm44U3Mj2
         a4jwbV59CglFtd+y/QJQh4sOh/zAQPw9eAI4GI6EoD28sq4K6gVDLHUtMKFRRRw35kyl
         YPWrjo80QTToVsulkzGRj8cmRYT6uocyq+wUK/4q8/GaFcAT1bKvTzQpX53uYbWctlVh
         NjGA==
X-Gm-Message-State: AOJu0Yw2rYUsyH/n4BTa7I1WfdYwuqG2dgAPvEbYHvV4DUcHyOY/7j7z
        Q3z5YQkTesexI1Fw8pkaocxeUEX+O0L/p4cWZMoFVQ==
X-Google-Smtp-Source: AGHT+IEuTjcvu12ShG9cs6VqeRlw+IhDcI9gYWkdpnPGwmXoORKenpELBojt9rW96G3TxqRB9wADnQ==
X-Received: by 2002:a05:6a20:8f29:b0:180:d81b:65e0 with SMTP id b41-20020a056a208f2900b00180d81b65e0mr5466303pzk.3.1699532246787;
        Thu, 09 Nov 2023 04:17:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g7-20020a63e607000000b005897bfc2ed3sm4578034pgh.93.2023.11.09.04.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:17:26 -0800 (PST)
Message-ID: <654ccdd6.630a0220.ff8c9.cbf1@mx.google.com>
Date:   Thu, 09 Nov 2023 04:17:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.138
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed,
 3 warnings (v5.15.138)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed, 3 warnings (v=
5.15.138)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.138/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.138
Git Commit: 80529b4968a8052f894d00021a576d8a2d89aa08
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+x86-board: (gcc-10) FAIL

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
    x86_64_defconfig+x86-board (gcc-10): 1 warning


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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warn=
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
