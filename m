Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0142791EE9
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjIDVK1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjIDVK0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 17:10:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DBC1B4
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 14:10:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf7423ef3eso8789915ad.3
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 14:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693861820; x=1694466620; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AFrJPCDrpAj78QO+owpX6nO1XUv0IOmDfVmOVf6Styg=;
        b=IfP0WKYposzPATAvLj6kOgwEXncSdO7PSZ/ZdeFl+ErfOHQTK1Cdb/jZf8La4V4cKW
         lhF6ufhXXK3CCRypfp9OtE0+u0lr9twy9ZYqnVEoSs4+JvWokPkerxLomroPc8HZ6ps9
         kC8bMxSggGU+SDEO+/xQ/WVIipnMiwSSxNhcB+PvCY8Vlq0S6gpJcNPeIOSruiYGhe9n
         qNhv+ox/nSrSHJQRAqQlk8tQhMmPk9qC7V9U8vAIXNMCCHi1olh+JKzZDYzU+4BKVo1Q
         mdagg+rmeAAFtZ1p1daHxGPRRUKpFWC5Bg50H7fEibUgRpyeGeFCnLKZoE+knjq5APVI
         84UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693861820; x=1694466620;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFrJPCDrpAj78QO+owpX6nO1XUv0IOmDfVmOVf6Styg=;
        b=Wc3OqcjMMUbhR3X/DNlpmxS++kY2xRQtO/y0c1/61QAmg9mctozgjuy886hHH8TSeR
         srZ7yME87AM+m3EsCQWkHoNbIuhhE1SpLxcDsNwbde/GocNALZnNxJDMHYRQ9ShLNIs9
         KoTp1tMH7rOJkygW9gm6em3LI2yWafw8oBfE4jHFUhDZ6wp5Bc2skPBPU1DZK0ynjE6f
         dH7PNiECYGLfZTjFwTGhEf2e0UOqmakJwxEDye6t5EZi+XVwuE3yl/Seqger8SCwaP7e
         sbrwR2wjcSap7Ae8J5Rc3cW6wyvFsLJ7XMduYK4fQnzyBjn+KXTNk5yTJR+5gb9YpYiq
         Lfiw==
X-Gm-Message-State: AOJu0YzrddANznYut7KZqfXDlOMOhjoYRtSP0x3Ayqr725k7HwF+7an3
        etmcruLpDarxbyOZ6pqc9vNvUg2YwYGyVNomWSc=
X-Google-Smtp-Source: AGHT+IElvRVNNALltMgSgPx5Eccfin+WuUijY0y0CT/KUT+JRvgPmvT31oJpWc/LFWCq7gCCYTHvdw==
X-Received: by 2002:a17:903:32cd:b0:1bc:56c3:ebb7 with SMTP id i13-20020a17090332cd00b001bc56c3ebb7mr10567141plr.20.1693861820428;
        Mon, 04 Sep 2023 14:10:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001bb9bc8d232sm7975552pli.61.2023.09.04.14.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 14:10:19 -0700 (PDT)
Message-ID: <64f647bb.170a0220.a7ac6.026f@mx.google.com>
Date:   Mon, 04 Sep 2023 14:10:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.130-29-gbec292fb85c5
Subject: stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed,
 3 warnings (v5.15.130-29-gbec292fb85c5)
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

stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed, 3 warnings (v=
5.15.130-29-gbec292fb85c5)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.130-29-gbec292fb85c5/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.130-29-gbec292fb85c5
Git Commit: bec292fb85c525832713d1aa73f07c39a477e2ab
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
