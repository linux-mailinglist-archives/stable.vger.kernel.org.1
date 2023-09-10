Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491C5799DEB
	for <lists+stable@lfdr.de>; Sun, 10 Sep 2023 13:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjIJLxt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 10 Sep 2023 07:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIJLxs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 10 Sep 2023 07:53:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B98D9
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 04:53:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c0d5b16aacso28112705ad.1
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694346823; x=1694951623; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xff5KSj3gRXEb6YozzAhYDY784ua6s6LLt6cntj+97w=;
        b=KHVVfZikRikj7PwsbVjlpMfgY5Bfo7zu0gpXoBmMsu8+nNFViD67yTBHJDSFnKbC6y
         HLuk3ADxsWlYVBuNbn+ztnNsAL/6WEWELw03Qe1IHNncwv6kryZx84IlyFkKK+WhkShx
         2ompv79T3i1ZczYIQxxTuD6tHKxN1x613uD5TDyIcoG75vgA88xV+xxsxC7HoNm/wcz1
         auV7kGLedsM7hxEDaY5K0D2E2qzFDt6PwXn95u6hRn0Pa+jYc4U+Cx6cufuMDLbmccZe
         124rDWx0U10CRhJsJmFaLEtqNyz7TN1rERbYJ5Xk5rRFrGaVmyT2gckpI/FOipJ2Pun7
         LlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694346823; x=1694951623;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xff5KSj3gRXEb6YozzAhYDY784ua6s6LLt6cntj+97w=;
        b=L4ddGeTuwwThu/UuqWDpyOKBZZ9+X/iseUc4UOghFPFaRdtGURQc0Zd+jYgaQDMkd8
         YDIO2R/CAVhku/qURX74PWCuYXQk55qn4hmrgm2fVZYrfByvaLUFKYF3zteLjZX6trrN
         726upgY79dKRMSeSOp0Ld1fNnvMkoLHLowNOsIPqonpGjxbQgzfElqqJhT5NJXUe1RIi
         Fdr2swrwb5BJ8HpeeKwNcQbkGVVVmyEnL0SgyujnL2+Sc71Xc1GTtYjIK1pSmWYjPhbw
         3aBNKkvCS9BAmst+fIWrLQxA5bBCx0wvVXUKQ+zeFhrBFbRZ5YVrfBA9NR6vEAWi78RS
         J4mg==
X-Gm-Message-State: AOJu0YxYB/pIwJrWc97vDc0/JyuDTu9uRSjwgOLrnuSN1CX9p25mqX5Z
        pR4RbZ5ufmokRNR3ZP74sFXD58oz+AWbhPzgixM=
X-Google-Smtp-Source: AGHT+IEEcDEcQwf/+SdckmADTavH44w46PLT6CpWMdbnbZXVfGDW7/tht+fSxfUHEdgO+arnmwKoIg==
X-Received: by 2002:a17:902:7589:b0:1b9:e937:9763 with SMTP id j9-20020a170902758900b001b9e9379763mr5693569pll.12.1694346822872;
        Sun, 10 Sep 2023 04:53:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902f68b00b001bdc9daadc9sm4563546plg.89.2023.09.10.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 04:53:42 -0700 (PDT)
Message-ID: <64fdae46.170a0220.4f5fb.a4c9@mx.google.com>
Date:   Sun, 10 Sep 2023 04:53:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.4.256-237-g0e16f8cb79ad
Subject: stable-rc/linux-5.4.y build: 17 builds: 0 failed, 17 passed,
 34 warnings (v5.4.256-237-g0e16f8cb79ad)
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

stable-rc/linux-5.4.y build: 17 builds: 0 failed, 17 passed, 34 warnings (v=
5.4.256-237-g0e16f8cb79ad)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.256-237-g0e16f8cb79ad/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.256-237-g0e16f8cb79ad
Git Commit: 0e16f8cb79ad967e6662347809d6cd40bd0909a7
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 4 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 2 warnings

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 4 warnings
    x86_64_defconfig (gcc-10): 5 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 5 warnings


Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    7    fs/quota/dquot.c:2611:1: warning: label =E2=80=98out=E2=80=99 defi=
ned but not used [-Wunused-label]
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    4    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer=
 to integer of different size [-Wpointer-to-int-cast]
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    2    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpolin=
e, please patch it in with alternatives and annotate it with ANNOTATE_NOSPE=
C_ALTERNATIVE.
    2    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: un=
supported intra-function call
    2    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x151: un=
supported intra-function call
    2    arch/x86/entry/entry_64.S:1756: Warning: no instruction mnemonic s=
uffix given and no register operands; using default for `sysret'
    1    drivers/gpu/drm/mediatek/mtk_drm_gem.c:273:10: warning: returning =
=E2=80=98int=E2=80=99 from a function with return type =E2=80=98void *=E2=
=80=99 makes pointer from integer without a cast [-Wint-conversion]

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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

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
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    fs/quota/dquot.c:2611:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warn=
ings, 0 section mismatches

Warnings:
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    fs/quota/dquot.c:2611:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    drivers/gpu/drm/mediatek/mtk_drm_gem.c:273:10: warning: returning =E2=
=80=98int=E2=80=99 from a function with return type =E2=80=98void *=E2=80=
=99 makes pointer from integer without a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 secti=
on mismatches

Warnings:
    fs/quota/dquot.c:2611:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    fs/quota/dquot.c:2611:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    fs/quota/dquot.c:2611:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    fs/quota/dquot.c:2611:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
5 warnings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    fs/quota/dquot.c:2611:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
