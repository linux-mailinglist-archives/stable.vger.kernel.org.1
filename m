Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E5791F16
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 23:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjIDVqi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 17:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIDVqh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 17:46:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98B5180
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 14:46:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c336f3f449so10964295ad.3
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693863994; x=1694468794; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SNupM+N+JhKi30WMxuMI8PDynWzeh54JtjOmzInXRTQ=;
        b=CxoOdjtnTayvdGAKAUDl94RD+M5erBrBZJ4UjCnV95C0ybDH5BFucH6mQdNZx5Z5Nc
         MkPOl708yTfGWFI4pfUKhOUsigWm+h7rWEOnNlNJjcaqnGJZNOj99txz+cE0eiTC/MX+
         yd2dZvwFfj0bgCDfKvPYp2NpEiUF9LmWhFBY/ahxBxHDDcT/JNnTnOksNIjkJmKs2N+3
         TgW3CRagSiklgmyFyuYOWjEk7ZiYBxrVNhMvcSQWzLVO15rxCS150UPyO4UyugaSOg84
         M4Rln0P0z+sAgATNj/cY8cIVFTN+f/z24nj1GhF7cp2YEz3bSCeFX1J/k+LN9k07Rq+Y
         8b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693863994; x=1694468794;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNupM+N+JhKi30WMxuMI8PDynWzeh54JtjOmzInXRTQ=;
        b=YcTalkudGdA3rzBh3X9/R9V4gZC8x6gLsDuE5XP9MFAZ/I3ab6PSYvqXJrxypDHZeU
         0aaBVbBQMsb4/q6N8kklyDNEXUys1jAl3IiPr6DROCEC8vsmj68g7kVQr1s9kiuWWQ6H
         r0D/PFGiXQuweWFIlWZgpdSs3gcRSGc758m85hZUCMqfe4Jna2j0zA86/cUxfLJSabhJ
         P9dcSCPU0BfADtj1souAInLWMMf90QuepzGJ4K5QBXm6IiAtTwiMOYlPJRBH7IxcWfzm
         uDXK7HAcPM3JT3kN/HtG+5GAW0xCTyq/mC5miOuVi/C0ZIwd5VEZjaPoeahXVGz6O4/Y
         0Otg==
X-Gm-Message-State: AOJu0Yx9+EXheRpCMgHjKg87916HV43OSJurS5grWprafEib3AujXonY
        xjDxZq4YVblQRFeZZajlUY3eDTmZfaePCZipbck=
X-Google-Smtp-Source: AGHT+IGwdJZvY7Cyy31GWLUxhrhnJQRe+lkUCwb9haAhFpUQ3/b0Dmplhsw41lViz+tt7UM7Xwy3xA==
X-Received: by 2002:a17:903:2653:b0:1b8:90bd:d157 with SMTP id je19-20020a170903265300b001b890bdd157mr11127247plb.26.1693863993803;
        Mon, 04 Sep 2023 14:46:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b001bdc8a5e96csm7986498plr.169.2023.09.04.14.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 14:46:33 -0700 (PDT)
Message-ID: <64f65039.170a0220.e5c40.fcb0@mx.google.com>
Date:   Mon, 04 Sep 2023 14:46:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.51-32-gd0abe9b6003a
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.51-32-gd0abe9b6003a)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.51-32-gd0abe9b6003a)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.51-32-gd0abe9b6003a/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.51-32-gd0abe9b6003a
Git Commit: d0abe9b6003aae74696bf546c325193113e4b56e
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
