Return-Path: <stable+bounces-6392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C080E2D2
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 04:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8E31F2029C
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 03:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0568F48;
	Tue, 12 Dec 2023 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="y6m74mS7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B9AC
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 19:35:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28abda2fc0bso167720a91.1
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 19:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702352150; x=1702956950; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fiFshZ2lIPONKvxid97ftT0au79oVY1qBH78HaOHiVo=;
        b=y6m74mS7SNP2fnx3eTyrvokrq4rOr1KOGEm5ddEl/QUFxolfC+1M7u3m5ART8FvRsD
         ldQee6N+ppOE67NGOSVA3+jpY2roMeu10Pv49kn8HgqcjBeqyhEzAS4XpFW+1ckxr3JG
         niyK7YEZmcfyKTUlmSFYwDKXg2Wh93jFQ0qRwZ1zghwIFoXGoso5TVzNU+JzE1ZzVZQM
         TcKgFlPamv5Z4PRRivlFJjwLZhO9it8LnL7mEWM+aNpjai3hhP5zIIwmjJ0TM1EVavfH
         HGsXEOwdjHsUWxNsS5qpX41xvBqL5VdfTKUMs+UogA8Wj+szeiw/HXHPiaUYkc0m74ca
         88XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702352150; x=1702956950;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiFshZ2lIPONKvxid97ftT0au79oVY1qBH78HaOHiVo=;
        b=tQxLaKzS49F//Wq6NhHGR4uBVPiJGCttIiGWdktrISf8oSuQoWBheJez3dR18JIm15
         eFEx6+9Gp9K4VcuNfQ0BSoNMnnRZGdt5CtAUD7AXfgZs0g183XPoNFIphu4Hr93Y8Zmc
         pUXcHp6umRnMHMA4R8A5eAYUSiDrrg6+98MY8CgI7/J3VdaEQUSI16RW94sdb7Rd89Yp
         arb2qJIOKW91S5opWRrLAPu6G6U4STQ98BNkujWR3fuQTDUmfzeV3KQPMPdVLctraD0d
         NSs7+1NgSxEvSUWTZGxDl/OMNoY9Gu1fD/lD5shPCEVt+8kHxu2CoYP5+T1UkN6aEZ3U
         lYTQ==
X-Gm-Message-State: AOJu0YwJ7Ipbgk9Qg5SbHIdGTn1T0XAl3Ap6N4vFkbVh9GPEquM5Tlac
	3O7Y7wC7bp6HdIMI3xX0CjV/wvfmZwMc4+eNUp+8oA==
X-Google-Smtp-Source: AGHT+IGSeKz60M3XRotMgL4/TcuUt1KZZBDVkbYSEsYVClgxyx0PvoaoXbtJlvQhC2ZcEMO1EgPUZQ==
X-Received: by 2002:a17:90b:4a49:b0:286:f3ab:72c with SMTP id lb9-20020a17090b4a4900b00286f3ab072cmr3991165pjb.13.1702352150217;
        Mon, 11 Dec 2023 19:35:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a031b00b00286c1303cdasm8551270pje.45.2023.12.11.19.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 19:35:49 -0800 (PST)
Message-ID: <6577d515.170a0220.de10b.a511@mx.google.com>
Date: Mon, 11 Dec 2023 19:35:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.67
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.67)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.6=
7)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.67/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.67
Git Commit: e7cddbb41b63252ddb5b7f8247da5d0b24adfac5
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

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

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
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
nommu_k210_sdcard_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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

