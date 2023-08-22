Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FB77837DA
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 04:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjHVCVG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 22:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjHVCVF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 22:21:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718F1194
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:21:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdbf10333bso31346985ad.1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692670861; x=1693275661;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sOw+BOYGey5QPLmaloJEvfHasbySpXQ78n3CImSaSFk=;
        b=CfFec4Q56Dyg3fqMSuPluPsiYjHkNWDUFU7Gp15Zt40a3c2Ya1DIHv+39NaFbw+Dvh
         cLMlUOReeq5w0mlUkysniHjySyAglZ4hH8Ofj8KSBiVZdamEXJ7p9mXTIVNO4vAqFk/7
         6wwyqBgYn4BUInughqtx20dgwawOGZhPRlsPoTW8c2mqdPYHzA1aZFtwaO08TsCy+ODh
         WfjoMrJJnKxf1QKimwy2uiQxiIXve/orcs6fWU+CeOADMSSbir0hawrrR3CoGujJSpPV
         zIHjefN/viUCPyg6yeaNEk+LqLmOBzT9Kvw2xBkirNvns33HeV2Ek5gJKKSiSVsBK6GN
         SF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692670861; x=1693275661;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOw+BOYGey5QPLmaloJEvfHasbySpXQ78n3CImSaSFk=;
        b=mH1mZDL6knOpOBmNooIJGBDLmMl4132yl/pxuDGtVdAgfIe6Sq9S2nMcFH4ez9req8
         y8B0RVVgvhAIQr5bqf/NLMNrsnmYYJOI1desAQQhFB92C9DW+wEwRrKJXC/dQcib8kMY
         w72jDFOKQDcqoKEHbSRz66cRMQreisXfdCBq5B3eKpZmUjQGeM8jc47cV9f4blYF9dI6
         wAGr6JHljdzZ8dZYCVDjeOot1QYBcUFajMeQ6Pu+kg2n5AMwOYvUzriqVFk9i4k8yQTJ
         ogOfNvTwPA9HrPcPb2Bl9p7RV1u4L3u/ahVKDLo6uwGgG5s2vVHWBeKVqjm7Ee0jxMtR
         mKeQ==
X-Gm-Message-State: AOJu0YyC0d40SfQ5KwU5TcOiTBlcYaMgrwOnpAXYRbCi8YFEvlNpSVFW
        nThkzh/2QBty5Vwhw8RB3Be04vXHnYoyNJNS50x/jg==
X-Google-Smtp-Source: AGHT+IHwPJdYU2O/JfzPERGYGNmwyY9FqPTFvp3zaiDA45p4ZDaVHLX6hY+whdTskpqS6I3NRR/LOA==
X-Received: by 2002:a17:902:fe83:b0:1b8:76ce:9d91 with SMTP id x3-20020a170902fe8300b001b876ce9d91mr4460864plm.1.1692670861409;
        Mon, 21 Aug 2023 19:21:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001bdea189261sm7719978plb.229.2023.08.21.19.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 19:21:00 -0700 (PDT)
Message-ID: <64e41b8c.170a0220.8df4b.e112@mx.google.com>
Date:   Mon, 21 Aug 2023 19:21:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.127-138-gfc9952e796d10
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed, 6 errors,
 3 warnings (v5.15.127-138-gfc9952e796d10)
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

stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed, 6 errors, 3 w=
arnings (v5.15.127-138-gfc9952e796d10)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.127-138-gfc9952e796d10/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.127-138-gfc9952e796d10
Git Commit: fc9952e796d10f995ee74ab63b7f990fec0d8eca
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

x86_64:
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-chromebook: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 3 errors, 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 3 errors, 1 warning

Errors summary:

    2    arch/x86/lib/retpoline.S:260: Error: no such instruction: `annotat=
e_noendbr'
    2    arch/x86/lib/retpoline.S:246: Error: no such instruction: `annotat=
e_noendbr'
    2    arch/x86/lib/retpoline.S:125: Error: no such instruction: `annotat=
e_noendbr'

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 3 errors, 1 warning, 0 se=
ction mismatches

Errors:
    arch/x86/lib/retpoline.S:125: Error: no such instruction: `annotate_noe=
ndbr'
    arch/x86/lib/retpoline.S:246: Error: no such instruction: `annotate_noe=
ndbr'
    arch/x86/lib/retpoline.S:260: Error: no such instruction: `annotate_noe=
ndbr'

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 FAIL, 3 errors, =
1 warning, 0 section mismatches

Errors:
    arch/x86/lib/retpoline.S:125: Error: no such instruction: `annotate_noe=
ndbr'
    arch/x86/lib/retpoline.S:246: Error: no such instruction: `annotate_noe=
ndbr'
    arch/x86/lib/retpoline.S:260: Error: no such instruction: `annotate_noe=
ndbr'

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
