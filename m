Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB880761E67
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 18:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjGYQYL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 12:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGYQYL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 12:24:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225142118
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 09:24:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55ae2075990so3053342a12.0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690302245; x=1690907045;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpHB8QjGn5O6Y5h37s23WA2dKQ/pqtTxncQL8KAQlYs=;
        b=xo7CL03QODIFjgMJZY2K4Fjl+XedKC0wM4mJu+kSsy38UyIa8hDhwHc11YUrfi3UxX
         0nw0RM3M99DVMtt2HoxvZb/C5fxLdiRXbh7f5qAxGmAJrn/1Q3I1LDjrwr3c8VhBNJZ9
         6k5HKeVC2mUmzWFh5ckNjN+7Ub2K6p/m0Vf3BcBnfjoaKGChLx2EhKsoDLp+fZxjwQgf
         LaoRBZSOf0FMRI3M+xP+xiW/xSiq/+WnGQPdWtlj2mGOwmaWZRxArssYJGJ1CrxB3BLx
         MZTTW1fDxuxBwJFx50Nsd2E0DYQvhBmVIo9EWqvoKaHKYrGoP0xEiT00Siz2jX/to5UN
         DeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302245; x=1690907045;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpHB8QjGn5O6Y5h37s23WA2dKQ/pqtTxncQL8KAQlYs=;
        b=NKXBscslzcyKG/EMkkuv3pkspERYeUWYcvrAj1Zre3zDQ80AYayQ2LBLQFADqM0QkR
         dMoZ1zL5s4BV787Z81A7BYiFiEMw1Eyqw3cZ0E1dgs92AIIgYJHlG1A7lk64QFAhWu0A
         gc/Q3R9DtnWY3cGFeUPZH0qsB4AwzmU+SJbhcxX4cv+erTKE91Vj+bGSkDenBPs82bCh
         KmhmA1MkT9I67+LBJQwUBxsvgw289iIjxbAH55yfWcEJ88UXatnmzP1JCLMo3Rwd1LBa
         DhZcHdy1L4iFT/kI9R5TnOHAykvWi5oZ060yFXqyYmegePW+V/D9QbcK1SUvibStHZxU
         BiIw==
X-Gm-Message-State: ABy/qLaGyM3TAxPoP/4wuOee/tL2jqxrae61fH/fwPLSBWIgB933p++M
        asDeGmBpyrxMJECspR2+xdadppDcaoWfQhT2Q+8UhQ==
X-Google-Smtp-Source: APBJJlHkhAk5+L14xS1Xrw8QMG6gLP2KaEJeHxN0/p53KAI34dEvd0ASkkByUGugu9E/LxSoQi4HfA==
X-Received: by 2002:a17:90a:f411:b0:268:1e9:53bf with SMTP id ch17-20020a17090af41100b0026801e953bfmr7763446pjb.37.1690302245007;
        Tue, 25 Jul 2023 09:24:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090a0c8300b00263f33eef41sm10766003pja.37.2023.07.25.09.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:24:04 -0700 (PDT)
Message-ID: <64bff724.170a0220.70c7e.3bc3@mx.google.com>
Date:   Tue, 25 Jul 2023 09:24:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.289-218-gd8e587288fc49
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed,
 36 warnings (v4.19.289-218-gd8e587288fc49)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed, 36 warnings (=
v4.19.289-218-gd8e587288fc49)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.289-218-gd8e587288fc49/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.289-218-gd8e587288fc49
Git Commit: d8e587288fc49f0aa86b6a4986af9c617572bc4f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 4 warnings
    defconfig+arm64-chromebook (gcc-10): 4 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    multi_v5_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning
    vexpress_defconfig (gcc-10): 1 warning

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 2 warnings

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 warning

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 5 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 5 warnings


Warnings summary:

    12   fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=
=99 from =E2=80=98struct super_block *=E2=80=99 makes integer from pointer =
without a cast [-Wint-conversion]
    7    ld: warning: creating DT_TEXTREL in a PIE
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    2    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x6a: return with modified stack frame
    2    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8

Section mismatches summary:

    3    WARNING: modpost: Found 1 section mismatch(es).

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
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 section m=
ismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warn=
ings, 0 section mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 secti=
on mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 s=
ection mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x6a: return with modified stack frame
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
5 warnings, 0 section mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x6a: return with modified stack frame
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
