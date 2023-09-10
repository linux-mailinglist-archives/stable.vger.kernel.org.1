Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BCA799F98
	for <lists+stable@lfdr.de>; Sun, 10 Sep 2023 21:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjIJTvi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 10 Sep 2023 15:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIJTvi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 10 Sep 2023 15:51:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D7110F
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 12:51:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bdbf10333bso30873005ad.1
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694375492; x=1694980292; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VYwjvFi+GbtnAzzHWR/XTqRHU9cZVXP2Q9/aY32Ykls=;
        b=KMa5pc/odXNYD9mtJej2AYYxgN+BMMo78i1pnBGBNU58rea7tAwwbAJWDKX0OEMUy4
         qO4TlHyHcLyVHuBULSSYDSisBK3OUYSINW1HdsR3YAPNnApsQsFkZNvQ3aWhwVq1udPI
         zuaEZ5TMxH16TCQRBXrdg9VnYkw6+KrY5iCa7Iur6jGOvq0mBzGNoGcf0lJ4FkXInJto
         G18HFB+rHfp5kuJZ6J88erRzLXEInhSWSeen/zpkJgNyQppniWteDl+8PxKXHITiFOX/
         qTJJXt/+kPd2+pKihFIssrbGHDhDALXSC+buyg6K3v+my29b7hosyXWQH1ofjeTRYC2p
         8EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694375492; x=1694980292;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYwjvFi+GbtnAzzHWR/XTqRHU9cZVXP2Q9/aY32Ykls=;
        b=Xnnm7sKO3YFnz9HcBmnoet88vFGtqtoKB1hM5qEOBjFzrWi9rXuGCz0MAVo3+U2LTN
         4E1yRxwjIID5wV8L9rnYea7D2Jy7W8LzP1esZRLgygrLxEjfd8R5xwUZiMLPIh4TUyQe
         na6l8D/HCLkVhEwmaBbMWYXRD0WqYGpnfvbX8UbbDxEh9pInicIR75jTMVPLtbB5UTNC
         NQk4A0oCpd/CW8dLrvwInXXsnDmAELFWVMVsfFVjNGafmJwTSDDB9+MucbIrre2T3kDc
         BzKHqsdYADPDZKoOWW/NmGvnmFTYGZralXnbyka4vMwryXF24ljus1w0Nd1VU/G0SFfh
         eJ6Q==
X-Gm-Message-State: AOJu0Yxojqw6LSv3WpLgNBAKsyVjzUd1WIesHAHQzJHScg44E8fZma5i
        XaSCqxX2/08mCdE5+PvvHTPHKMx3WnTdSN5/KDU=
X-Google-Smtp-Source: AGHT+IGj96dpVGAvNKyTyCsNODKqmZA1fVgwyz8v7hyUP9FKOhGbSMdaQhAGqDIiYqb8f0aIm1BWRw==
X-Received: by 2002:a17:903:245:b0:1c1:fe87:f550 with SMTP id j5-20020a170903024500b001c1fe87f550mr11181562plh.7.1694375491865;
        Sun, 10 Sep 2023 12:51:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709029a0a00b001b2069072ccsm4936538plp.18.2023.09.10.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 12:51:31 -0700 (PDT)
Message-ID: <64fe1e43.170a0220.8177.b29c@mx.google.com>
Date:   Sun, 10 Sep 2023 12:51:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.4.256-240-ga44590c54f02
Subject: stable-rc/linux-5.4.y build: 17 builds: 0 failed, 17 passed,
 34 warnings (v5.4.256-240-ga44590c54f02)
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
5.4.256-240-ga44590c54f02)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.256-240-ga44590c54f02/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.256-240-ga44590c54f02
Git Commit: a44590c54f0290f6978aed83db34dee74728f9c4
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
