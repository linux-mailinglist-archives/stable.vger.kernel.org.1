Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13EC7E5858
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 15:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjKHOIH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 09:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjKHOIH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 09:08:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C91BF9
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 06:08:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc29f39e7aso47686335ad.0
        for <stable@vger.kernel.org>; Wed, 08 Nov 2023 06:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699452484; x=1700057284; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sWPl9tXNuJi+TxIViio+kTXV39yWb8RjdfUbBNDBgNE=;
        b=Ytg5sWbLS82KLONa1H9+m7zwXCU0lg4MM4DKDcvNMmSC4fXiv5OtlKd8xD7TYt7qcM
         QXm+70b53z2K0gzdwanx8vAoj6aRv3QdDtuwWa7lMtWtHG5yne6pYqL65TVyYuzrrB6D
         WvLPRXHGHvIoHBu0VU/uLXDK5Jy7tigOGEhHDZsOD5hc2VcZ9cdJ43idHc3k8CxMCCu0
         NlJTIBQLnl5bctX4oup6P+u/kaRnp2x9T3EfxooBjw6+Tumh/xkop73W8r20btAzM3IP
         1B+HtO16FoBOrHJlXTIVyLEj+PrOZWcl7FPTUhN0BUOJP+uThAO0kANzM28pPTghb6Ha
         BlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699452484; x=1700057284;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWPl9tXNuJi+TxIViio+kTXV39yWb8RjdfUbBNDBgNE=;
        b=VVpVBW9ieagZGBhikHjSz5Dczzq9Aq8qXmJ19pGLwNOZvEmvoEPVjLXVw1bNW3t8Xq
         RnTPucgNWroewOyu8bE3Dd5K8pvoLGlNAjOt+KPhOswKot8HpvxJBlwucA7Fpp9+1pbo
         5o6Zn8fwtUSBHjOwP9D5u1RByf78My58Dx3SNTl3g3Kcu5i5t4wLEgWCOCAfPFjCBY4e
         Qebd/By7mEfmq+CmG6eIyHU551Ln2h84mOKx2qEDYXv8ntL7iXIpOwqfhSX6HWkDuA4S
         GLJQoWhRQkJUiFJOU+PY18ML5eHyIAeAgjozUWopgaa488BUe1hfPEai5Lj3Oyrd+IQ1
         WeIA==
X-Gm-Message-State: AOJu0YzloYOIO3j7p8bfLK4vkn5H4/t2uLUY4zfP5SxJ7u/MLUnLZM1s
        I4joyZOWC6v34cZ3Rzxe3DzLsibNVpfJ1QjbHMifUQ==
X-Google-Smtp-Source: AGHT+IHXWMEPOhGKKuLXXGk19sEDZ5MwlfMz1ZlleU5A5O7x2gkHp8sMpcMkMznm1ShcaTJ7lJUoIQ==
X-Received: by 2002:a17:902:e995:b0:1cc:e76e:f216 with SMTP id f21-20020a170902e99500b001cce76ef216mr1901519plb.24.1699452483983;
        Wed, 08 Nov 2023 06:08:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e80100b001cc3a6813f8sm1781955plg.154.2023.11.08.06.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:08:03 -0800 (PST)
Message-ID: <654b9643.170a0220.b5656.51d9@mx.google.com>
Date:   Wed, 08 Nov 2023 06:08:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.62
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.62)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.6=
2)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.62/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.62
Git Commit: fb2635ac69abac0060cc2be2873dc4f524f12e66
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
