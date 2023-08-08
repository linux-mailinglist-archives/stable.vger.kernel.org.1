Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE37774D8B
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 23:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjHHV6y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 17:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjHHV6x (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 17:58:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDE212D
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 14:58:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc6624623cso27420485ad.3
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691531932; x=1692136732;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7x24Cod73+6cyCaSZYsH3iOXKWYPhq8K/Dhux0G98lc=;
        b=Fstehiw9ClyfI1hncDplVu6HR8HsZX+n1brU3WolRA4HMvh7c+91ouNinBRsTMNhKH
         2Nzqaul0jHerIpUtqhfovGnhf2oxGUb8pMXHsGt0F3wAUyEJbCOM4o7XLbdEuaCD5f9z
         0/EOKbi2HZonZuhstQQqcUwOS61JmQ0PpNZvJVNMbkCmxchrrGzAY1gkdwkxd0CGUF3x
         kl5FfZ0OaFWTZUYeut+KLZzqi4HaG80RHDsJ9oKJKL1YYJJ+BbvZ1vIytbAOAGpJYvmb
         tK81cZl8ipVHBly3CGd/YMtlAJdG98By26CuEwR448Mq1lcrbNiEVarGqbRBoUzh6vJJ
         J4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531932; x=1692136732;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7x24Cod73+6cyCaSZYsH3iOXKWYPhq8K/Dhux0G98lc=;
        b=iryOUTh2iHW5Wz4g1hr8vdfG3mpb+Ye1M6UEf7Vl0gXgvdLhZ4YADWdUeWgTitCcQd
         kcgQS3blXMxvgXU876DbGCZhebsO75MNKHLN40vJ14Jy/JVnRsfW/3ArWDyC42MMWA/E
         AIYmBNZqc0aZ0fJksx5zZuK+ENvRrAGynx4KxrYmyQIwL/7+xZN5IVTHqzS+Ej/8JDO5
         1QI++Yeriu+a/xwb4gz3QozEjLMKGgbpBjqKJYzppzY562iDs9soDBHeKCI7Kq+Susl3
         jjeppGxucc8kB02MB27BPUG7Gyyb8m7u8y5XRS6yhkW+4Aed30yDCMi9IENB0L1OSWwn
         nl3Q==
X-Gm-Message-State: AOJu0YxVRYLIxMV7T7a9vLybMzAC8j7dL/Tfb01h8wdKpdntWCR1XDAy
        nszo0OJITw7kH8vOmms3jQJv3OXQnxAGbFEdZK20NQ==
X-Google-Smtp-Source: AGHT+IEm8+OilBSliXvUdNvKUV+jXe0beuCsN8JRZvNSBoua0k4WUIWAY0LWNU46u4sB5m4xkJJjyw==
X-Received: by 2002:a17:902:be01:b0:1b8:36a8:faf9 with SMTP id r1-20020a170902be0100b001b836a8faf9mr1044771pls.38.1691531932084;
        Tue, 08 Aug 2023 14:58:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001b0358848b0sm9488058pll.161.2023.08.08.14.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:58:51 -0700 (PDT)
Message-ID: <64d2ba9b.170a0220.8cd5f.18e9@mx.google.com>
Date:   Tue, 08 Aug 2023 14:58:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.125-87-g976c140e8e74d
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y build: 20 builds: 3 failed, 17 passed, 6 errors,
 5 warnings (v5.15.125-87-g976c140e8e74d)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y build: 20 builds: 3 failed, 17 passed, 6 errors, 5 w=
arnings (v5.15.125-87-g976c140e8e74d)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.125-87-g976c140e8e74d/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.125-87-g976c140e8e74d
Git Commit: 976c140e8e74d70e726e90031451db14373cdec1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig: (gcc-10) FAIL
    defconfig+arm64-chromebook: (gcc-10) FAIL

arm:
    multi_v7_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 2 errors
    defconfig+arm64-chromebook (gcc-10): 2 errors

arm:
    multi_v7_defconfig (gcc-10): 2 errors

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 2 warnings

Errors summary:

    3    drivers/firmware/arm_scmi/smc.c:39:6: error: duplicate member =E2=
=80=98irq=E2=80=99
    3    drivers/firmware/arm_scmi/smc.c:118:20: error: =E2=80=98irq=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98rq=E2=80=
=99?

Warnings summary:

    2    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:=
 unexpected end of section
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
defconfig (arm64, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section m=
ismatches

Errors:
    drivers/firmware/arm_scmi/smc.c:39:6: error: duplicate member =E2=80=98=
irq=E2=80=99
    drivers/firmware/arm_scmi/smc.c:118:20: error: =E2=80=98irq=E2=80=99 un=
declared (first use in this function); did you mean =E2=80=98rq=E2=80=99?

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warn=
ings, 0 section mismatches

Errors:
    drivers/firmware/arm_scmi/smc.c:39:6: error: duplicate member =E2=80=98=
irq=E2=80=99
    drivers/firmware/arm_scmi/smc.c:118:20: error: =E2=80=98irq=E2=80=99 un=
declared (first use in this function); did you mean =E2=80=98rq=E2=80=99?

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 se=
ction mismatches

Errors:
    drivers/firmware/arm_scmi/smc.c:39:6: error: duplicate member =E2=80=98=
irq=E2=80=99
    drivers/firmware/arm_scmi/smc.c:118:20: error: =E2=80=98irq=E2=80=99 un=
declared (first use in this function); did you mean =E2=80=98rq=E2=80=99?

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
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement: unex=
pected end of section

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
2 warnings, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement: unex=
pected end of section

---
For more info write to <info@kernelci.org>
