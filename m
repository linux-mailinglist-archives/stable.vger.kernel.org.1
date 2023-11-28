Return-Path: <stable+bounces-2938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0302A7FC57B
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C221C20F5F
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A5358AC2;
	Tue, 28 Nov 2023 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cZNssCZq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4CA1988
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 12:32:20 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso71913b3a.0
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 12:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701203539; x=1701808339; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6g9cglm4v/5xmOI0Ze2F0+vkB/IBQ8nB2gjAXxphVKk=;
        b=cZNssCZqD47a1w6mawElU3r++mFcZv2IygJAhXDRimV/8ECNzku563dnmz+gTiaJXp
         hxVB6AK34oJENlM4G+P8bxVeB/X9MdVxBpzcZjHKskA5BNcnkAPj4mtwxXms4uCU60jf
         VJpWrTNPQ1rqkPZc9qguxhDX7ggg/ZyquLqOiwYzV+OG1TIbImxOM2nzyqe3RuTxmeSV
         B00Re9pBtOQmCsYk1ymm8NBjv7xlP3BbX7PxR4V1oSYETbVwqUNIf9YqT2R30ZXs4wmI
         1Tw/67UHbKBTVDUbtyac3JhaankFsXtWYnQnKTBDaxhakzfEoT38f4YolXMMx/hRG2MV
         8cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701203539; x=1701808339;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6g9cglm4v/5xmOI0Ze2F0+vkB/IBQ8nB2gjAXxphVKk=;
        b=wayWQ6Bjhn7JNzAGhmZc2ZIfo+zxgfFHE4TSVq7mzu3fWMrdiuYO4eOgx+RseT/1Gp
         543W3FIHZW6vzR8SVlnj4YHD4/QRa+lNZSM2c2rPCeWEKfn1crz5hi4Oq5ZzmY6GxP9o
         m+XmwRZ7cE5KSeHrcMh0JNCLyrzOVRIEgNb2TLxsaW30sIthaVC3t6ytvSATnQKPL+SG
         yyLz2DfZzUkxoPQlWJuwtr67JYbfms3mv/FRFvE6OkqEVbCvdSA0lt6CU0Vqcm21XLdP
         +7xo+q28id3vfKldaUeZnursjJeA/8hue1NJFC0yCROo5XY4RMD3PVhlsQKDjyyR3H7h
         X+gQ==
X-Gm-Message-State: AOJu0Yzp5ssiVqRTtigpGbwx7oPHc/hLy3S0fjkaZLjwqQu0CF7eCRbO
	3VYDQbQPE1140ERJ2GnIdzKJuInAYiP6fyavumY=
X-Google-Smtp-Source: AGHT+IFRzD2tGvZtbzaUxhymGiksQKwB2pveKeyMxl3Ht9PdVM0+DnUF72ZDExm5FqhZ3UKWTdWrdQ==
X-Received: by 2002:a05:6a20:8e26:b0:18c:abeb:b0db with SMTP id y38-20020a056a208e2600b0018cabebb0dbmr7862158pzj.49.1701203538890;
        Tue, 28 Nov 2023 12:32:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m3-20020aa78a03000000b006cdcfd814e9sm17497pfa.147.2023.11.28.12.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:32:18 -0800 (PST)
Message-ID: <65664e52.a70a0220.f3d88.0117@mx.google.com>
Date: Tue, 28 Nov 2023 12:32:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.10.202
Subject: stable/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.202)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 5 warnings (v5.1=
0.202)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-5.10.y/k=
ernel/v5.10.202/

Tree: stable
Branch: linux-5.10.y
Git Describe: v5.10.202
Git Commit: 479e8b8925415420b31e2aa65f9b0db3dea2adf4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
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

