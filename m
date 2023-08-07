Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E08771DB0
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjHGKA3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjHGKA1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 06:00:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D526A10F8
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 03:00:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so26786795ad.3
        for <stable@vger.kernel.org>; Mon, 07 Aug 2023 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691402424; x=1692007224;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bnZyPkEf6tk/QQ2qKM+rS4FMo4zAxq7wZEDCNtm1gnY=;
        b=TLrIRePxRscLAxA3GgdCx9wwCunCV+zqBv2l7Mpf7xBGFTnGHtZaF0sq9oow2F955w
         lNNhYDtXKK4UVlMLnnezPhW1LEaTHf41kX+Gvhm8Q74Drft4cTt22q9JnyB1ieattWOG
         bw9UgzIzVwA3AOOBZa871vCdEhq7bhnJKZUMG5f7IOLYeFfJnW8hXbj+JBBznw6r0r1g
         Bk/HB1Fb1Lke6sfAdJMX/IDMIyc49CN2Aml1yy2GcA8me1ch5ZnqYqnUF45kHKUSsFRR
         kjKvmFKdz2fv+imunXwoSVWfzH/4Wy3G8oM4+yTJGG7N0a9JEthceRvS8wPe+L5TkiEb
         EPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691402424; x=1692007224;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnZyPkEf6tk/QQ2qKM+rS4FMo4zAxq7wZEDCNtm1gnY=;
        b=RpTF/dWYG7HzU+Er1NuciSBoi/nA9ryXFQuT3z3BrAlHt7pBXFbfunq7kFe2ILzpCP
         +JDllgYskJEHOOnGOdog0VGfevWIkfNsfYXaTbNYiD0w5YmTUHjGoG7qc/R5TF+pGgeW
         YUWHAIFbOxHF74/it2bWObGrDDfch6364mwlwGKKv67HS7bKRCGPyD3V7r7dX7zmqcO3
         oQpSlfzCqQaCXqX51NZALQEIP8yFAfWIPskGj+lSuFdrBe4Xt2YsEkeyMfedKoTTg/pS
         zDHxwKe3IswD14WMiar3w9mKYMg5N/dC0HxVpsqdo5OuKgnHrbaLe6D2oaLYDE1b3VHw
         XIXg==
X-Gm-Message-State: AOJu0YxBlcXH14n0rs/Fmh75XTEQknbwTlJfzJcRBA69M4YZHxmQThuX
        k1dUgaAuOYVpNVZIZkA3lCO7adZ/uNQDDF4vIYvw/Q==
X-Google-Smtp-Source: AGHT+IE1DoooqMDsyW4+cxPTM5QlzE2EpRLl7xDLlCjhIs1T63SC/rvOkI0XJXxGeO+jcKWCAvpO8A==
X-Received: by 2002:a17:903:32d1:b0:1bb:9675:8c06 with SMTP id i17-20020a17090332d100b001bb96758c06mr8222102plr.35.1691402424576;
        Mon, 07 Aug 2023 03:00:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ix14-20020a170902f80e00b001bc7306d321sm1155555plb.282.2023.08.07.03.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 03:00:23 -0700 (PDT)
Message-ID: <64d0c0b7.170a0220.a592b.1d04@mx.google.com>
Date:   Mon, 07 Aug 2023 03:00:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.124-80-g6a5dd0772845f
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y build: 20 builds: 3 failed, 17 passed, 6 errors,
 3 warnings (v5.15.124-80-g6a5dd0772845f)
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

stable-rc/linux-5.15.y build: 20 builds: 3 failed, 17 passed, 6 errors, 3 w=
arnings (v5.15.124-80-g6a5dd0772845f)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.124-80-g6a5dd0772845f/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.124-80-g6a5dd0772845f
Git Commit: 6a5dd0772845f2aa538ac5a4aeaf609d54892791
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
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning

Errors summary:

    3    drivers/firmware/arm_scmi/smc.c:39:6: error: duplicate member =E2=
=80=98irq=E2=80=99
    3    drivers/firmware/arm_scmi/smc.c:118:20: error: =E2=80=98irq=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98rq=E2=80=
=99?

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
