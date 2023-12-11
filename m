Return-Path: <stable+bounces-5235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B5680BFE4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 04:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAF41F20F01
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 03:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A41640D;
	Mon, 11 Dec 2023 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ygTp8BSg"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF6EA
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 19:31:56 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b8958b32a2so3210685b6e.2
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 19:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702265515; x=1702870315; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UgDsch3O7Ob7emYzY+p6Duid0GoZhtrDqeXffeN0iRM=;
        b=ygTp8BSgPyBvcmsUgr2NyNizXXpus2KBiDJfxDL8CsRXcrsF68S/62BWqgd+eSsEdr
         aTo8kPGinhVz8KOFRYcWA1NyvbL7jsZUPsJ0T14HVSRoVMdxGmn1TpuF2uvZi3mET+zR
         i2NYZRIOs7H3vq07W2+LBLIMwhYWPUR/pqRfHoJjcayFlDW7Jc6lQo0GMNZjeVEMoOa/
         ne6YHwp8EmSD6PIdUle8jsx0cvp+UIJr1xIVOQRza5/23J12XHQ4+5BpFz24fz9SIrQ/
         4B/9A/GLzrqdcSC+/Wcz16vB14GSmutaJ7phC0fvO5u4w61hbrNmtfubncI+eJCwg+Qo
         +mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702265515; x=1702870315;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgDsch3O7Ob7emYzY+p6Duid0GoZhtrDqeXffeN0iRM=;
        b=Hx0qGjv+BQp1L9vDZlg97UixQeCf86CdQJ11qdD2/Yd2WzybLevzCymrjn+qEQQXgE
         z3P/r/bI+vgtG0xtQgJG15V8MnPk7Ka922WnvvuRFDaN7zE4Xz91n/SAoCFfEBMWD30L
         IPZO6f9uYpZ/pD+QxNfz/nZ26GSgkCZfPFdXYka0GyurktV9w+4DEjYKvE/oMi5z9eGO
         ClBiOU1/gVwmc6eOd7w++FEqlgZ0InWUpUpB2RpmuEBBmEfPrKl0Keud4vVvlGeRZSyP
         2X5FOWcktBr8ay75Qubd6rj2Iu3rZe61c4TkHAXvC9reQmcb2vO8sG9UEPJh5F8vIpbE
         ZVMw==
X-Gm-Message-State: AOJu0Yw1Ed1HCwwe7CLdKI+SNQQSYWwgpodnIgos2sOHvNwUHF3Fnz4z
	hfAUL9H6jxTHRnDLpJwABIVgETlx10eGzlcwpdf6bg==
X-Google-Smtp-Source: AGHT+IGg4TW8rUDSm5vQmZuRIrJZWFf/NCZVKMOR/LybsRAQgsQTmgMezs8p3pwszTiJ73csO+elPA==
X-Received: by 2002:a05:6808:2126:b0:3b9:dddb:2927 with SMTP id r38-20020a056808212600b003b9dddb2927mr4529958oiw.64.1702265515111;
        Sun, 10 Dec 2023 19:31:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b4-20020aa78704000000b006ce41b1ba8csm5101556pfo.131.2023.12.10.19.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 19:31:54 -0800 (PST)
Message-ID: <657682aa.a70a0220.5c12b.e38b@mx.google.com>
Date: Sun, 10 Dec 2023 19:31:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.203-64-g1e733f0ca3a85
Subject: stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.203-64-g1e733f0ca3a85)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed, 5 warnings (v5.=
10.203-64-g1e733f0ca3a85)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.203-64-g1e733f0ca3a85/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.203-64-g1e733f0ca3a85
Git Commit: 1e733f0ca3a85e35e63c9accc64152985e23d62c
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
    rv32_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    2    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]
    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

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
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sect=
ion mismatches

Warnings:
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]

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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

