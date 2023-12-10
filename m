Return-Path: <stable+bounces-5218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACB480BD67
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 22:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D14E1C203A9
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9F51CFAF;
	Sun, 10 Dec 2023 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Akh5jEy9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C768FCD
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 13:46:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28a1625b503so3250646a91.2
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 13:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702244782; x=1702849582; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CyVXEoJSB2RPGZY53I7YLEqAuMghY/KbIMVesLx8S6Q=;
        b=Akh5jEy9OV/8OKm0UwXkOLbJjxHovLgXKwmSmSUyZ/1vejSsvs127zn1NG8ghCKNrF
         qdb7QHe1ZrDg6VsRnlxwmkYAnBx1yBmpVS3NpYTzaOSiSyoBvlONM5wH3sLY4nMr2pYf
         fFipbkBJ7LKeqqkcWERMw9UjaKELVEFzDPSdZsv+AYvp7PO0JKKbbs9ZSFPhaEUL8q+Y
         QgNUSRo7nKhvDEggVaIYhddNdtRUgVeN/ylxKRSFq/MwNntX3LYY2lyeDC/qDJcsq74l
         TsCm32UgoTpcIG7LodRI+pkMtf8ZzBUUFJxq0Dbg/nUq7cxxGXQFPOuJYCzJ02lazi54
         7nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702244782; x=1702849582;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyVXEoJSB2RPGZY53I7YLEqAuMghY/KbIMVesLx8S6Q=;
        b=j1IWDRZx+0st55KQSq0dImvgIkFl0ONbffatYtg4HebweikxLpG5inKvaP8H9O9oK1
         Of+wYXXelpXpJicq0reI1JblQpsUwRp43zl+7P2vyft8xboJ9cOHuWfoKqpJOiHzcMR7
         RdxWEgoEVuQ7O9u/MmhgplSx2r3KNukJ7XfxxMR3DH7B/IT9/73Ee18oVqZMQHX1oLuC
         D9mzgWNBVbqAkG/qEkBSB9x/AJaNBD908IEZwuBM6qOD3CtUhLJomQHmTSstsmgKR6x4
         VAUaK9NgZP9GLhZcEzPKi98VQ+CnO/1pqxJnWGJpsXiuV1mgKB/BnDDi7izQWbRzXRWt
         WpZQ==
X-Gm-Message-State: AOJu0YyVTxKRewPLzMbqAIZmq65aiNRH1X1oDkziNUXaO9qlwHx3gwY2
	1Vb5+DUTyLa1l+S6LDuDtDjjj5ItWjU9Qn3fQpHTbw==
X-Google-Smtp-Source: AGHT+IFkO3qoxeB6rtQXsB7/Z74lwMOTyHdGD2YRBp6uU3GIbOoHNdlQFhem9Ei7lmfT7NDPPCuZFQ==
X-Received: by 2002:a17:90b:3846:b0:28a:8123:f975 with SMTP id nl6-20020a17090b384600b0028a8123f975mr831994pjb.83.1702244781809;
        Sun, 10 Dec 2023 13:46:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a191a00b00286e69c8fb1sm5972934pjg.52.2023.12.10.13.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 13:46:21 -0800 (PST)
Message-ID: <657631ad.170a0220.8d4c2.0b6b@mx.google.com>
Date: Sun, 10 Dec 2023 13:46:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.14
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.14.332-16-g0a53e9f04489b
Subject: stable-rc/queue/4.14 build: 16 builds: 0 failed, 16 passed,
 21 warnings (v4.14.332-16-g0a53e9f04489b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.14 build: 16 builds: 0 failed, 16 passed, 21 warnings (v4=
.14.332-16-g0a53e9f04489b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
4/kernel/v4.14.332-16-g0a53e9f04489b/

Tree: stable-rc
Branch: queue/4.14
Git Describe: v4.14.332-16-g0a53e9f04489b
Git Commit: 0a53e9f04489bec7e725501ec67f1f501865afd5
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

