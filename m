Return-Path: <stable+bounces-2936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310BB7FC47A
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 20:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01B4B2153A
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5243D0D0;
	Tue, 28 Nov 2023 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="b1wuumpL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016E41988
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 11:53:46 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ce3084c2d1so49240855ad.3
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 11:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701201225; x=1701806025; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fpBtoK8dgNP5wpP8v3Rkgo/urXtMdPrlM5IT5Mnuetk=;
        b=b1wuumpLRC9+F6O2OJcFhffx7bKBDhiRZi9A3BviVzzxc8SA3gqxzkEdWKLCW3bMfW
         ORwaXpUwn8LlG28sJWQBijs//FYBT105C+CSr3ene0XWYGYQb/euCoVYxZUf3FfhQ+aQ
         xBr2Vh6CWzeJlJmdxXoaTqb/iCJNvhyFwq1pf5KrrKhI0BoyIZ50RIdkwCNk2v1YkPHA
         K9ntCh/j53X7tcIHxNeo2PWfzlrshkQh9XZxuTiTkxJUv3AgG45ILah+d7IakMhNHAzQ
         iOrL5rRcQYqOHp4zQJBWeyt2l4ahP7BNdIbF1OfON3ottsXK/34QvjQaEU+v/4+2SGVG
         vKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701201225; x=1701806025;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpBtoK8dgNP5wpP8v3Rkgo/urXtMdPrlM5IT5Mnuetk=;
        b=vrQiTvfBXna9uoxwnErHyVKUMUvrUIsOxeGf23WzYMhH9IccAHPbNU4FcCePf/I+qz
         Y6yc6rRYTQSaBKd4uKxHCCvgd8fLNRDrnMIUAwyfzO/8WowGSN1hfiTFkbjDYxypDJgk
         yTBQzRJmrnPmsSVKPkkStH0zArePrxSvXh/TFq22qL/++guV74U2mvXmZ5k4lc1MS2eE
         2DXkmdjO1t4xL9PR2ns1RktF4jx0C4ppvdhqu6WWQf6UQBbjR2bLw49WoyWLIcu+2Mi0
         JfJmC0fNdtQlQZ40TVfkI4J/V5e3smLx0F9cnkcba0Rk+4EMtyUZkcFNmetr+M4Unl4D
         IO5Q==
X-Gm-Message-State: AOJu0YycDJUNkxZDzzXVvmaoHzKq0UA0+t59/Z7x9xVvYeOq8tSiE7d+
	kbEPR9rp30v9zd4i31qcOpPNirmIq3ZVc2YD4DY=
X-Google-Smtp-Source: AGHT+IGAAsvRJXR9pZn9xHYA0+x4+05rOCBxPQGj77iDZrMxG5hUqztmHMFxom/xjTUUZW+wu2TJ8Q==
X-Received: by 2002:a17:902:db0b:b0:1cf:c42c:cfbd with SMTP id m11-20020a170902db0b00b001cfc42ccfbdmr12540623plx.0.1701201222870;
        Tue, 28 Nov 2023 11:53:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902b94700b001cc2ebd2c2csm10598456pls.256.2023.11.28.11.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:53:42 -0800 (PST)
Message-ID: <65664546.170a0220.44d96.9c46@mx.google.com>
Date: Tue, 28 Nov 2023 11:53:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v6.1.64
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.64)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.6=
4)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.64/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.64
Git Commit: 6ac30d748bb080752d4078d482534b68d62f685f
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

