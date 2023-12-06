Return-Path: <stable+bounces-4851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F8A8075D8
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CDC282073
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9B495D4;
	Wed,  6 Dec 2023 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="RdEvsSaF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D77DD4E
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 08:54:50 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cb749044a2so35787b3a.0
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 08:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701881689; x=1702486489; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sVb4/yc/aMB/Tic0g/S8Ny0TLIaobhMAzjhLvbRh4BM=;
        b=RdEvsSaFVVTCtMPkfxV4Pv47tEJyZpSQHXjnrkDKZX+KX/9Nsq9TEqEYevxverZ7N+
         HNP32pjRWxVjauSws4c2ULQOG0WpCAtQE/9Usgl4POkM/eP5FBAeNISc1LXsdq7/CuOV
         Z8FesKN28eMSrFMov5XQ0VVejTCLe89b2kdXE22eiAz1qTobebIs67CWBhBtA8HJjKu4
         YCzWYsrMmuA+OnysAq7Q1e9K9jhp2zIOEkemwFPO3LSGSnnU5DytTbNmECAxLigRXJ8T
         6tp6MlB8vA6sBbD9IU3JCBAHrW3quPkF/KZzXH30f0vEypfTnrAM8RyeZDuoZUv5GoY/
         8arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881689; x=1702486489;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVb4/yc/aMB/Tic0g/S8Ny0TLIaobhMAzjhLvbRh4BM=;
        b=UtXQ6KiYnMthV0ynYDohusYAMMdcCGsMPjq6fdUXzYcUC29L6z+g2uUPKkrU5p+mla
         iRlC6hNdIqFA8i7x/hRiQfsG+s5sFgdXsfe6jeof2vWX6URs5PaDN4cfoSiDaGkMuhNV
         6AVrTHHN1EXPbNf+y1PjuAAJcG7LnOhk8dBEolDLdw+XJWklGc4kkUA1nBiNUSFI7o44
         9kABxippJuu0rqzCWcnZLQNkg2xOgaBYptBFc4lvWb5uQOYhcVssxJwnWHAiSFzUYUoa
         pxNUH/JeidFw1YnSzOvmfU4o8rI15Qr7d01qEJoT/YShiQJeLsefWzu2pFnQr1gn8WZP
         Ufqg==
X-Gm-Message-State: AOJu0Ywrm1/LYlqIaxdxAcxekwPq53NkuPN5FUjv8zE3sC3n5vvoccw0
	dTaQeVGVfntRs5hiVHoHo3CstVwMQo9s5k+NfYVMFA==
X-Google-Smtp-Source: AGHT+IHkSUFmVL1EFCuVwkyQjY+hR7yjamty7pvrePNSFsScALYR9ezX3nsZXC+qnu5w6ffMA5nJGA==
X-Received: by 2002:a05:6a21:a59c:b0:18f:97c:8a28 with SMTP id gd28-20020a056a21a59c00b0018f097c8a28mr1642709pzc.83.1701881689113;
        Wed, 06 Dec 2023 08:54:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y66-20020a62ce45000000b006ce96d62243sm224051pfg.26.2023.12.06.08.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:54:48 -0800 (PST)
Message-ID: <6570a758.620a0220.80547.15a3@mx.google.com>
Date: Wed, 06 Dec 2023 08:54:48 -0800 (PST)
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
X-Kernelci-Kernel: v4.14.331-30-gc14aa1b8a1d5b
Subject: stable-rc/queue/4.14 build: 16 builds: 0 failed, 16 passed,
 21 warnings (v4.14.331-30-gc14aa1b8a1d5b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.14 build: 16 builds: 0 failed, 16 passed, 21 warnings (v4=
.14.331-30-gc14aa1b8a1d5b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
4/kernel/v4.14.331-30-gc14aa1b8a1d5b/

Tree: stable-rc
Branch: queue/4.14
Git Describe: v4.14.331-30-gc14aa1b8a1d5b
Git Commit: c14aa1b8a1d5b2423ce18d505df49c8c1c03ebbb
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

