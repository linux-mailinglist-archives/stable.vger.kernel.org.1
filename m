Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E604274FAFF
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 00:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGKWiK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 18:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGKWiJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 18:38:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9A7E4F
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:38:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5553505b3a.0
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689115087; x=1691707087;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7h95+LZrnqAR0PNkWbqwh+S453lQga2cBhqade1TgY=;
        b=igGngchSxAislbtrZdL8X7IrATLdvZr1tsjNHRE8ngFrwGkKmqQNobj27eeW9/R+sU
         mvVsBb2esDLMAK4/tFJImn07TcHDT0yh7wgkYiUBnYgkgERyOT0TW597+x9Z8Pbb0/fr
         4vN3IyBWoraqQQn8YREwR4GL1iSLFRq5NJ6+kYAfa1Ju9Rq2ZVMfK4QPnnmkxKUKyqYs
         NMoM3H59UqaNaO3HwzsXf8TKNW3YOaq9pdxMkVYSVHfe4vtjJFcQsMCnVX7kjogykPL/
         QqIYEXB9Rdc6f2tPS6kXh3wFbx3N2OzyvgbP8kbrmjtABZLszzAKcXv3CaSvgcXD2s07
         hF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689115087; x=1691707087;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7h95+LZrnqAR0PNkWbqwh+S453lQga2cBhqade1TgY=;
        b=JT2rEMlUXCUsef0R7OYoqP1CvBklI75cnvvEAsVS7ZEqrfxrL/aCbcu181+mXfF2ec
         ttTPeajmuBGhldvOjeX68npEVtaZTq/iJzPIq8t3GEW9r9i/qRBu5MDPIiLaXujohr1m
         RrgHYQQ8PcuSVIuQ5zmLLi4WOGS1jytCw2bRY4MrR5LAK2hl1NKHgVyeQWB/OzukFopY
         SHumM+oTZ+Kj+n5EzOkPXNS2VGOeGemsId+7HaA7aghLgkvAqjFsH1tLOBLC7V3Pln6L
         p0WdrGpB43OrB6ZR4I3nXaWqxKDKWNE2aQkZ70K6BwIa+ElDbrghmxjolzhRlkkKgXBd
         50pA==
X-Gm-Message-State: ABy/qLajupF7B3N4L/OINWUUgQGfRA1MYzgTem1755lDhLqi/xVxVyhx
        bqupS3vUuluU5dp74XKEncr9YtOEpoFCj2lvcPLJng==
X-Google-Smtp-Source: APBJJlGwGWLn0Sn473O7XiopfzV3K/YikT/r6N1Ho6aUkVZs3q7Z1m1lj4Q9BRy1L8A5SQIRPGm7Wg==
X-Received: by 2002:a05:6a00:21ca:b0:666:e42c:d5fb with SMTP id t10-20020a056a0021ca00b00666e42cd5fbmr22265200pfj.32.1689115087027;
        Tue, 11 Jul 2023 15:38:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i1-20020aa78d81000000b0063d24fcc2besm2197392pfr.125.2023.07.11.15.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:38:06 -0700 (PDT)
Message-ID: <64add9ce.a70a0220.d5c6e.51d7@mx.google.com>
Date:   Tue, 11 Jul 2023 15:38:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.4.249-126-g6582ccd8f339
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.4.y
Subject: stable-rc/linux-5.4.y build: 14 builds: 0 failed, 14 passed,
 22 warnings (v5.4.249-126-g6582ccd8f339)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y build: 14 builds: 0 failed, 14 passed, 22 warnings (v=
5.4.249-126-g6582ccd8f339)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.249-126-g6582ccd8f339/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.249-126-g6582ccd8f339
Git Commit: 6582ccd8f3392481047905744b4ac01384c0a725
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 2 warnings
    defconfig+arm64-chromebook (gcc-10): 2 warnings

arm:

i386:
    tinyconfig (gcc-10): 2 warnings

mips:

x86_64:
    allnoconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 4 warnings
    x86_64_defconfig (gcc-10): 4 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 4 warnings


Warnings summary:

    5    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    4    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer=
 to integer of different size [-Wpointer-to-int-cast]
    2    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpolin=
e, please patch it in with alternatives and annotate it with ANNOTATE_NOSPE=
C_ALTERNATIVE.
    2    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: un=
supported intra-function call
    2    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x151: un=
supported intra-function call
    2    arch/x86/entry/entry_64.S:1756: Warning: no instruction mnemonic s=
uffix given and no register operands; using default for `sysret'
    1    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

Section mismatches summary:

    1    WARNING: vmlinux.o(___ksymtab_gpl+vic_init_cascaded+0x0): Section =
mismatch in reference from the variable __ksymtab_vic_init_cascaded to the =
function .init.text:vic_init_cascaded()

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sectio=
n mismatches

Warnings:
    arch/x86/entry/entry_64.S:1756: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x151: unsuppo=
rted intra-function call
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warn=
ings, 0 section mismatches

Warnings:
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

Section mismatches:
    WARNING: vmlinux.o(___ksymtab_gpl+vic_init_cascaded+0x0): Section misma=
tch in reference from the variable __ksymtab_vic_init_cascaded to the funct=
ion .init.text:vic_init_cascaded()

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 section=
 mismatches

Warnings:
    arch/x86/entry/entry_64.S:1756: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x151: unsuppo=
rted intra-function call
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

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
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
4 warnings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
