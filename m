Return-Path: <stable+bounces-4797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB28064EA
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 03:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0981C20E8E
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EDD5697;
	Wed,  6 Dec 2023 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="p3oV1PGu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6359188
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 18:22:21 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d0bcc0c313so15090235ad.3
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 18:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701829341; x=1702434141; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SqpAkhZycZz3yAamMqpVuobKTOG8ByCEtML/wqsYXDM=;
        b=p3oV1PGuYqpSHzxYSIBIr5hadsudoODnrPD2EUMCYT1idxpnxvBffDcOUeMY6/W0UB
         ucoBPMdyZG6XP4Mpzl/JlGTPhMuZ/xehzZJG+WJc/SHRrfrQ2QXNu/boKQkOwm7OiCkT
         1QjqVVf28YUZHepas/fV5PUg3kFbvZzW52wBPHPFHK4m3pJKhjudr6Od4i9EkkOSGoXa
         68jRj9/gCZ3UhOZRZqxhDZaHwECLvdY6X5LssIwLFL3HYzXFNKUAg62vk07dqKN+/0ot
         oF68b8SdgQVqEQ4GxXDOIU0/QgNmGntmoesiFfWFEqN8VQzKoDBDQflkWgfCd8W0IjTD
         qOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701829341; x=1702434141;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqpAkhZycZz3yAamMqpVuobKTOG8ByCEtML/wqsYXDM=;
        b=enzvRN5hBQ0ZFEefv7q6lxNIZnIB9QR9T9qTHIuVoPGJmLx/9rCD+6wQIpU8vLWNcb
         pvDPa32l7OvgGULWizore6zRzP5ysIvpVqBvOcgyp06FW3CjpYvoZMvn1aNGXLArggMa
         WAj5G5Z4bfl5gIFR7a4yJWMNo8oTinEhqsVFAM2EdqPfo1p22aqZlrNHiOlSagzooJ8p
         2h8PlFehZ5zSfP71ZTlFU9ghSOIxVpPlmbQCxcSuaG2RPxTfTOriMdd8DnVzyGAPb1Mi
         uCHLq2uRQZtS65yIpLe4sM6S4IQUAvdHvzPZgEMDpdbsU1H+G4dtpHs92XcElLxK4Fo5
         k8BA==
X-Gm-Message-State: AOJu0YyvERN10KYDIwNR218rmQty1VEqlZZtCysqk+72SCVVEaP4i4Hg
	RUTVGeeISTck6fk7mFzf5IgeT+ofNSCvw4WblQSorQ==
X-Google-Smtp-Source: AGHT+IEzz9sBJwrmCSkIYU6Ardq3vsN3qGelRqHC8iY2TMpUz9aER1NRhsPXsreEi09V8YIxxDhfMw==
X-Received: by 2002:a17:903:191:b0:1d0:7407:355e with SMTP id z17-20020a170903019100b001d07407355emr103247plg.16.1701829340804;
        Tue, 05 Dec 2023 18:22:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709029a9600b001cffd42711csm10812422plp.199.2023.12.05.18.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 18:22:20 -0800 (PST)
Message-ID: <656fdadc.170a0220.84f3b.f639@mx.google.com>
Date: Tue, 05 Dec 2023 18:22:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.14.331-31-g874af89949e4
Subject: stable-rc/linux-4.14.y build: 16 builds: 0 failed, 16 passed,
 21 warnings (v4.14.331-31-g874af89949e4)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.14.y build: 16 builds: 0 failed, 16 passed, 21 warnings (=
v4.14.331-31-g874af89949e4)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.331-31-g874af89949e4/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.331-31-g874af89949e4
Git Commit: 874af89949e42c7561778651b85458150d9d60ce
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

