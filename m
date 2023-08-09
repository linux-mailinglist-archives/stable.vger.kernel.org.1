Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15C977606A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjHINRb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjHINRb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 09:17:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089EB2113
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 06:17:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc73a2b0easo19624825ad.0
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691587047; x=1692191847;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lxU5eq7ivldBkLHCffcP5HYn7kyARlPjNlnfoOZcZ3I=;
        b=W4aPY/08JbSKNIore+RhDef1gtHx+FfyOfOCl9IkIt6QQi4sGwMf0TWkkvrCJaHYUP
         YvXgDqhMCS1xyo/1lx93u5A0oj3gBQRWy/hiqcaTQNy9DAz4Nc/24rF1HnpGtTHCYKSU
         UKZiKzR2UGjUuHo+seXusp0PH+WOeK+XXvmmrvB/zjH3xnpwM4/7YTTDVW3ZkZBnqRjg
         yPCb23Mk8kAR2TionHGHjByrbao5BsI4tcPtT8YBoJqal3eACRGIdxhrVDaYrplS6HqY
         ld9dFPz2XKjTIFSC9fOZsp/tfUJgsqmhVpzFz23Y5UR4G4JHMf8jkGeTcuOUdiobzbH2
         6DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691587047; x=1692191847;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxU5eq7ivldBkLHCffcP5HYn7kyARlPjNlnfoOZcZ3I=;
        b=TZEew/f81taWbOOyPYT5n973hZL8hDhI4TKBdj3L5l76v1AeitdV+gbNe0Nq455eyW
         I5O/n/RW3l7iJA1ZTTOxyuY8TmXgh4eSEPbhe4Glknkp4K0b5vyOEx/gBk9gUix5Lv2B
         ZMvDj46gReYaryx8+RODslOuJ3On5d9TlpOEXlyooXKTxNm2sAZgO1rq/ks0N58CkP6O
         CjKsjGqM6JSxqlH54HhfXLnuNtWtYEPLMRuR6Hc9IrFqN0jAz4ctZa8bHC4g/5HHvdkF
         kC3aPmsX/Ky3QKxTuTWdlx5G9mZCzKvd14Dff/hkld4zSKIeu0rEt9IaOR3BI3xzaQ+L
         OHMg==
X-Gm-Message-State: AOJu0YwfaPaEZKLfAE2M/hfn8TXT/ZZlkhgFHXDwyJkvfcna3Wg5UEPt
        RuwV8FX8381/d1P3M8HVIR1q+DfFQT4SrKoZk3YyDQ==
X-Google-Smtp-Source: AGHT+IGQqDqrlOOE7igoCux0J7pCr33vZSJS8kpxxbORunr7WRlMiM/DT7+sl061aMCJttSwdlA87A==
X-Received: by 2002:a17:902:be08:b0:1bb:b855:db3c with SMTP id r8-20020a170902be0800b001bbb855db3cmr2243393pls.41.1691587046904;
        Wed, 09 Aug 2023 06:17:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001bc65360526sm7540512plg.125.2023.08.09.06.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:17:26 -0700 (PDT)
Message-ID: <64d391e6.170a0220.88a4b.daf9@mx.google.com>
Date:   Wed, 09 Aug 2023 06:17:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.125-93-gae7f23cbf199
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y build: 20 builds: 3 failed, 17 passed, 6 errors,
 5 warnings (v5.15.125-93-gae7f23cbf199)
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
arnings (v5.15.125-93-gae7f23cbf199)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.125-93-gae7f23cbf199/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.125-93-gae7f23cbf199
Git Commit: ae7f23cbf199ef4564263bdf82cbcedca2f4d60c
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
