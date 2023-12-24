Return-Path: <stable+bounces-8413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B9A81DB0B
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFCEB21343
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A88610D;
	Sun, 24 Dec 2023 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="k+T6VSVn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AF747F
	for <stable@vger.kernel.org>; Sun, 24 Dec 2023 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d7750e2265so1591881b3a.3
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 07:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703432089; x=1704036889; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pMsLrCsXJ6ZWzDggL85F8bRwZv5cvtxQ9jDPGZRBeOE=;
        b=k+T6VSVnEZG0/okeGF6AXr2dv2Jh+/zG57ZIMW3PQv5QxhNRyI/DDqX8LjIkFpIW85
         V/2B1z9DtObVMJz69ock5dO6IA+qdkyTKbCQD4jcKZPUWsUncS56hpaKT9JXVzeQoVFK
         El5Zvn8QGZG2/rl9J2R+IguzVz0ZehrEofs3Cxw/kzKFWpIRiibTE8QvGpZtQo6UOrj9
         68IhToN0rU7OtO7suY8NhYM4c1T3/G6xtz92d63OpOxgAd+mvvgogS4x+d63TlQL6AKK
         nj/6vgcezjJDhcGpU4yHDgTaHzlJC2IqS2Yb2b5LEaAmwtNweANTxZqEBjsFxfLVMiSU
         r5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703432089; x=1704036889;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMsLrCsXJ6ZWzDggL85F8bRwZv5cvtxQ9jDPGZRBeOE=;
        b=K55GjJr6rUHz3QcO9qDu6Rk7O/sh1juTN1b8mBFUwKGOvsc9U2SSNpJp8UY/WzPzEg
         LSAQgg01bZYIsTPH8w1uO73b3a2AysbeqGqnG/lWFWm3Vrhj84K740odTf/7RMb5wVLJ
         jFF7HxfFDfMpN9IAQBjkH14YgI9xD5O5PL6gOD3QSzvWkIi6G4ZVOY14V1kAJQhx0Crw
         6iGtN9OIcbDOpV0F9FQ4536h6HkEyHk9RpRF+a0D2Tnlsu9kB2ABOM81JG+++gHQv3Vo
         nzyQpBWXTyBSapth+wOtfT81U+ZsCsSaZWwOWxVnJYatJY/hcS62AZwLzbMt2YOwjN8n
         HBSg==
X-Gm-Message-State: AOJu0YxogB+75E+ZZzjeefz9hJ0D5j4u1U1vsUYPAa/wvHx95PoclA1u
	m+fhQfDI8wlATidn52UuEYUe+V21xmxJmMDidykG1N0Jfwk=
X-Google-Smtp-Source: AGHT+IH5Hu/xxnyEezckwkhrO7lLd1iYPB2D+BtdHYQwQSvPk9LpRtEGD2JgrINVAenxiVPhnz/5sA==
X-Received: by 2002:a05:6a20:7347:b0:194:bb2d:e337 with SMTP id v7-20020a056a20734700b00194bb2de337mr2387835pzc.89.1703432089343;
        Sun, 24 Dec 2023 07:34:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y136-20020a62ce8e000000b006d99842ab78sm3255452pfg.184.2023.12.24.07.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 07:34:48 -0800 (PST)
Message-ID: <65884f98.620a0220.14148.6d0d@mx.google.com>
Date: Sun, 24 Dec 2023 07:34:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.68-160-gf04523f89ac68
Subject: stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.68-160-gf04523f89ac68)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.=
68-160-gf04523f89ac68)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.68-160-gf04523f89ac68/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.68-160-gf04523f89ac68
Git Commit: f04523f89ac681f2f93fa00908376cfaf4cd5dee
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

