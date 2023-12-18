Return-Path: <stable+bounces-7623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BBA81746A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F762284EA6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866B4200C0;
	Mon, 18 Dec 2023 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="CFPKpmMp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF52101DB
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d39e2f1089so16019595ad.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 06:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702911487; x=1703516287; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4x6vGpNJZKHNKpuVuXF5zq6fYJyeLV8ki7zx1A4SL7Q=;
        b=CFPKpmMpeyDI6C4ufbajPqMz5OGwcYSgY068NeYoxo7y5+ai8sNBZuNMG4JYq2L2H0
         OTb/AJsDhPT2TfYr/b6f/EXYqyaUTEB14y7ErlFxH0R61HtXZF0rbCfQQaMAFDPiUBCW
         AdWtVFlmn+Kxt+F/QjLUfMJsMTjTpCc00zSI3/QEtvis9Fj6b+JvOt9WLNcGvZgfPFAg
         /GlkEzdoAZFTuhi7N9zgSJqOaoC0ViOdjOieRc8qYYcv2V0hIkhsdLBgKB4cTwIG7944
         Omk5pyrgqumsd3pU/dHNjQ9WKHef31QpB8KZ7b8QOwQFZkUsVL5fBJnROCPebMZBjrsx
         tgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911487; x=1703516287;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4x6vGpNJZKHNKpuVuXF5zq6fYJyeLV8ki7zx1A4SL7Q=;
        b=AjZdmq0ceIcdC8aGEQZHXzxjR4pg2YT+rfHrucs20+iDeK7azR2CitrQbR8NgLkS8d
         vfHQ4xhAtmk+vmS5FTy1868Hr4UCSgNrATlUYkY/BgG9Go7MFJac93ipHoKziVnwuP6s
         Hmnh7PT+D2+mS32udtOKBYx125Ic+VuNjekP2eAmX2wurzmZRiijau1Gq+fOAAAJC9bZ
         icCUlbsj8aGLY7isrDxQrM9VoumsQth9lIgODWSRfvhaQbuRnxJlbt+fy+gQOUQq2C/t
         /9deDsWwSAHJ8yVk+ShBsrF2es2DSOfkjzDxmDTYGeUbp/O0ivvWmkFVyvm/M2ESnEPj
         6rmg==
X-Gm-Message-State: AOJu0YzTHRckuNALsDuajdLUQaTXXUtZWrjqa3F98n0CVCixQuUfbB4k
	lBI/LYzxMmcvlp/KCRM5PLXjBT7hyhWp2r3knb8=
X-Google-Smtp-Source: AGHT+IGp8SF/yNyR6FAE5tvj4480LQHC3/hopOZuwqMOcc81ccsJ5CDXqXinx40gVc4RiaMsgjhSSA==
X-Received: by 2002:a17:902:da89:b0:1d3:5a7b:7ced with SMTP id j9-20020a170902da8900b001d35a7b7cedmr11490284plx.63.1702911487403;
        Mon, 18 Dec 2023 06:58:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id je11-20020a170903264b00b001d09be1bcf9sm2951751plb.80.2023.12.18.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:58:06 -0800 (PST)
Message-ID: <65805dfe.170a0220.2418b.6e64@mx.google.com>
Date: Mon, 18 Dec 2023 06:58:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.19.302-36-ge049e5b8ef404
Subject: stable-rc/queue/4.19 build: 19 builds: 3 failed, 16 passed,
 33 warnings (v4.19.302-36-ge049e5b8ef404)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 build: 19 builds: 3 failed, 16 passed, 33 warnings (v4=
.19.302-36-ge049e5b8ef404)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
9/kernel/v4.19.302-36-ge049e5b8ef404/

Tree: stable-rc
Branch: queue/4.19
Git Describe: v4.19.302-36-ge049e5b8ef404
Git Commit: e049e5b8ef404a5d70e76a7de06375177a7c57ea
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
    haps_hs_smp_defconfig (gcc-10): 1 warning

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
    x86_64_defconfig (gcc-10): 3 warnings
    x86_64_defconfig+x86-board (gcc-10): 3 warnings


Warnings summary:

    13   include/linux/kernel.h:847:29: warning: comparison of distinct poi=
nter types lacks a cast
    7    ld: warning: creating DT_TEXTREL in a PIE
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

Section mismatches summary:

    4    WARNING: modpost: Found 1 section mismatch(es).

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
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

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
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 section m=
ismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast
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
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 secti=
on mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

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
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>

