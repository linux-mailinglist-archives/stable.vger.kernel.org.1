Return-Path: <stable+bounces-3156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311907FD8F8
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 15:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4AF28241C
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE172375D;
	Wed, 29 Nov 2023 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZXI59rsM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A4B5
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 06:09:28 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so4831721a12.3
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 06:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701266967; x=1701871767; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iBXt5eSvAGS7fDn9qZEyVxNxaVrxA1AwV48Ec88qZfc=;
        b=ZXI59rsMsvmB22GPccPF3WCm0xiB93S004E56Z8+U7Jrex6i0gBjZSl+xum9j69dmU
         ohGNqSnLhKBGr77/9zop6nzXK/B1iw6AHSss3bW9RqjBXrfN92EMbPRYQNFjh+wqb4vs
         Jp6YCHCf7tUBEGd3X6gO+oDo1hlgjoyzGr+rhdXK4KKxbTVptK+ALb9YdGU/DqAD/zx1
         5eC6lPW2zrpHcP1FExgORvlMsdMa1cGcVp5lmAaAsg6Q7hrtw/XmnDnKAO8ksLl2VCir
         c9hOH7e0Bvc0x8pbes69dO/vzqQU0NiME8I62Clamqdp+FdfyOgxQbelAu8cmvS2dwMV
         6wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266967; x=1701871767;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBXt5eSvAGS7fDn9qZEyVxNxaVrxA1AwV48Ec88qZfc=;
        b=s3ggPG2FlTIqUy1XiaSdsCCjbqL1o5v+FC1uGJSeVzSZHDbJKB0eSNYYiHCM8pCYbD
         nPwQhEdfJa396GRwtZSsrdNC2gnB2xkQuv/ZZf4jOKF1Wry/wM8uWkcsueaAABZGyer8
         6wZTq7wcKRaKudBurmLEQ3TR84QsVMu8FhRAOGTAr41XqEBXL1ULhPFeRxeLGA8yfjt5
         c8go7pNsLe+2Lue0LigCFiPN9f8oIx12I6eXGfWr2qx7oqhwPLKBZkp+1PuprbbvTQne
         Kop54qw6kphLZRanLkNnpkbpXjyNd1SoFI7sf6K5IhjSyUG6boHpldELyRvlYvaCip+S
         M/PQ==
X-Gm-Message-State: AOJu0Yy888Q7Gm226j4i1md3CjLAkGhVpvzfz0jt2+L6Uupo6gVsD3gG
	Fa/cVhbUMQHXHP/0VNYas60/tgtlsZ6R233XtLk=
X-Google-Smtp-Source: AGHT+IGWb7SvL0dPotY3Pi6xfscUAJNQAfOsfPvZdr4YHtziD6zmo+ag8hLuE76Jkur5o/27d82O/A==
X-Received: by 2002:a17:90b:1643:b0:285:9a7f:30cc with SMTP id il3-20020a17090b164300b002859a7f30ccmr17519075pjb.46.1701266967447;
        Wed, 29 Nov 2023 06:09:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gz7-20020a17090b0ec700b002859a1d9fb7sm1416586pjb.2.2023.11.29.06.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:09:26 -0800 (PST)
Message-ID: <65674616.170a0220.e38bd.35f6@mx.google.com>
Date: Wed, 29 Nov 2023 06:09:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.300-13-g218eaa1412efc
Subject: stable-rc/queue/4.19 build: 19 builds: 3 failed, 16 passed,
 20 warnings (v4.19.300-13-g218eaa1412efc)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 build: 19 builds: 3 failed, 16 passed, 20 warnings (v4=
.19.300-13-g218eaa1412efc)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
9/kernel/v4.19.300-13-g218eaa1412efc/

Tree: stable-rc
Branch: queue/4.19
Git Describe: v4.19.300-13-g218eaa1412efc
Git Commit: 218eaa1412efccf163a6175e3a0af92f06c8ad3b
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
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

arm:

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-board (gcc-10): 2 warnings


Warnings summary:

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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

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
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warn=
ings, 0 section mismatches

Warnings:
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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 secti=
on mismatches

Warnings:
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

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

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
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

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
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 war=
nings, 0 section mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>

