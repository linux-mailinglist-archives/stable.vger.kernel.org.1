Return-Path: <stable+bounces-8435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADBF81DE02
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 04:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF461C2116F
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 03:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F6812;
	Mon, 25 Dec 2023 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="197cO0sc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1DBA4C
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dbc2914825so1481353a34.1
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 19:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703475377; x=1704080177; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VsivA4LVBEVebd1yyPhjao0eLJFwwUMRJvW5TXmHhKc=;
        b=197cO0sc4Kme8Ia5tf2nAjCRmcUoPwkkZmYVwFjxm7VZRjbP3RgKrtjcz0zVO2INLV
         Y5DT81ww5l9YbBZdrw/9bg++nyTnhfeTYE41Q72jCw4wfg/AdKEnTKLdMOoU559q6pWl
         uLp9Xk+Kro7ZADzoPMILEYrnTgCfKy7uSAD0wTQbA4BV/jQZIRocd4yW5Zz4G1Ungrls
         wfpvWmDgkeVaUXalYVtqzlW7lFBH3JAn7ciMT7BjrXTROMmdhKEXXkCq6bmT0BRo+/+F
         5+H738djI/yLCZ2vAkrlm3ZNhP9qbJMA2/SRDRzHHjxYRHsyNpyxN20nLkLPBy775/qG
         stJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703475377; x=1704080177;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsivA4LVBEVebd1yyPhjao0eLJFwwUMRJvW5TXmHhKc=;
        b=BchNtl5G7Ej+g3jdP4UGe5BHn7kCMkoTBuQvWG6VVIXu8YxPRF34/cK9f9FM0Xi2fl
         d8RysXSPW9oCZ/O4ag4Un4LWjSERQrjbu7LHyYQYd7GNX1bZKEJ1zV0Kvl8vnvWKAerC
         yJMTQ6Wj5wrx9SVf5YUydpF+ZNRR6bIF5w9Jlh8un0zHCA8jyg/+V/KQqWYnHfTLYEps
         f8jyRe3Op8Apjh8/3L/UAjlea8qVoGkLuS6D8n9+v9b4HFI8lY789pLSw+XU6r0uwaZ1
         1nZNxfDQk/nMfB1t6Xz/5f6/6TYL5ebqm+tmEGt2dQ9gSSBTTOtM+fRzD4TxCs1b7TeI
         IYog==
X-Gm-Message-State: AOJu0YwTtmET7vcPSQpo9pKGVAQYWZljzDWNKyjNFG1HUaV10xgXBBcR
	zc71TuAykCvTZGlCVf/gpulUfDc5RdR7Z8U5JxQCpC6MzR0=
X-Google-Smtp-Source: AGHT+IE1RdJqnuLBLb5psaxJ1+h9j6Lb2RpfTZD+gmAAYdQ/jKU/yXjPanlv7e1s30RExJJCSfL2Wg==
X-Received: by 2002:a05:6359:8084:b0:172:b6ac:7f8a with SMTP id re4-20020a056359808400b00172b6ac7f8amr2542214rwb.24.1703475376740;
        Sun, 24 Dec 2023 19:36:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o7-20020a634e47000000b005bdf59618f9sm6860242pgl.69.2023.12.24.19.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 19:36:16 -0800 (PST)
Message-ID: <6588f8b0.630a0220.8fe91.22a6@mx.google.com>
Date: Sun, 24 Dec 2023 19:36:16 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-165-g5fc04d6b4e97d
Subject: stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.68-165-g5fc04d6b4e97d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.=
68-165-g5fc04d6b4e97d)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.68-165-g5fc04d6b4e97d/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.68-165-g5fc04d6b4e97d
Git Commit: 5fc04d6b4e97db031aaba0590121c108eb39a9a0
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

