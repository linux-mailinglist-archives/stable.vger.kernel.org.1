Return-Path: <stable+bounces-2811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426997FAB12
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 21:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB7B212B4
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 20:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE045BF9;
	Mon, 27 Nov 2023 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Mq7G2PFv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A14C2
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 12:10:44 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cb749044a2so4662250b3a.0
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701115844; x=1701720644; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Up5Z15ufiRP1gYWIOKwLzkwa3c+KJVoKEOWuukNLx8=;
        b=Mq7G2PFvPE4omhXhW4CO7E665a32VlUaEvmr/YCRx34s3l9u6bK8RSiMwfsPHc14JE
         1cb6e71O4lJOEi7ofp9aBcKA+b9+bi2KRS5g8rKEcwVZiz4Yq/EArWSN+gT3K2wIEjME
         24/5eOlqqiYO4SwuGH5IXV6W5xot9fRafEHV/lgZMHRLYUDAfkQIzqeMfG98dEWxXSjk
         quMfSjuibGVtKaqHLsZJEvWKgI9EZZGJFdOLHgnOpMwMMPBTc/b+/rNnbyM2vrKdJQo3
         mhFHt+EDyqtHZ9iOkF/s0pTHHO4GdSW6m7TOhXD99fk2hgQg9Gj/Zu9H3o+0wHjTsQBL
         GKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701115844; x=1701720644;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Up5Z15ufiRP1gYWIOKwLzkwa3c+KJVoKEOWuukNLx8=;
        b=HQ/aogNKeW7jbioQcVancrA/rbUrl7FGpDbze3pIUTo1xtuGScWDN6KjZuiyfxGhK8
         T9yJAIeuiGLVieLNUujvAOOLu8RLbHuRKZ3QuYaWTH6BqC2xn0mEyYp5HqLwXslCEuqL
         zPs19rLcoNjuWqbaPdUYdIwQQMgaHem7pihgOngS7DHe87T5HhlCa27nN6YcNTXFosiJ
         K2vdOfEg1+uTcillDSaro0P3m7IesCn568f+21z6g2ErEzt64dappnozYT/Sjxq8dj98
         AAObYe1QYmYAK2NGUjPoEm0h1FP+QdqdX0SWrfpFi6iDPDy1DfXRr+6DDnPWdz+57kzX
         dVtg==
X-Gm-Message-State: AOJu0Yxsr161XhTKtQCxpXnBvDFbWUyJm1nZQgWN3ZYHPgXX5FDSfJzw
	7fMdf7vZPTsw6gLZLfLJ5lWSIrQb6sjLYhakR+8=
X-Google-Smtp-Source: AGHT+IGxkuvJuoBhLfLN9Jn/cI4XlXR4Q4t1OpxkIHOaahC9jZPPsXak61pPBm03kw+nhyewnaOyRg==
X-Received: by 2002:a17:90b:17c1:b0:27d:2dde:5979 with SMTP id me1-20020a17090b17c100b0027d2dde5979mr14632263pjb.5.1701115843596;
        Mon, 27 Nov 2023 12:10:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kb18-20020a17090ae7d200b002804c91633dsm7805999pjb.14.2023.11.27.12.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 12:10:42 -0800 (PST)
Message-ID: <6564f7c2.170a0220.55804.220c@mx.google.com>
Date: Mon, 27 Nov 2023 12:10:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.330-54-g0957336c00be
Subject: stable-rc/linux-4.14.y build: 16 builds: 0 failed, 16 passed,
 21 warnings (v4.14.330-54-g0957336c00be)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.14.y build: 16 builds: 0 failed, 16 passed, 21 warnings (=
v4.14.330-54-g0957336c00be)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.330-54-g0957336c00be/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.330-54-g0957336c00be
Git Commit: 0957336c00bea3193c550b28144cbadfbbbc411f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:
    allnoconfig (gcc-10): 3 warnings
    i386_defconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 3 warnings

mips:

x86_64:
    allnoconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 3 warnings
    x86_64_defconfig+x86-board (gcc-10): 3 warnings


Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    4    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h=
' differs from latest kernel version at 'arch/x86/include/asm/insn.h'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    3    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'

Section mismatches summary:

    3    WARNING: modpost: Found 1 section mismatch(es).

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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section =
mismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 sectio=
n mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

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
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

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
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section=
 mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>

