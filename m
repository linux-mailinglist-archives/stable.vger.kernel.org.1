Return-Path: <stable+bounces-6754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A894D8138D2
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE501F21637
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 17:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D365EDE;
	Thu, 14 Dec 2023 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Wz3aPvl0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F12BB7
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 09:39:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d0bcc0c313so46336635ad.3
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 09:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702575577; x=1703180377; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fXJGWbxqjeUm9JQvfAtCGUhersVnDiqfd+eihCUv9tE=;
        b=Wz3aPvl0EwVUy90Cc5gGiUtJx0a25KYs0Z4/hoA19jam4xMK40vopQR3hIFnVaYf5k
         EXcaBwDlO8VfWyeKaRVgyAV7jh1uHQuCNV79kpL+4eFv4je+BxbbZoVNmAvKFmjp8zlQ
         PnyoXSfMTt/PfP9fD3pJYcqXZS1Hsj/JPKbiG168DKNMVpmEVn3RtvkuWLdkI/9yCA8p
         ngF2mJ6u5JakZSEhcqV3sEhh9v6gkr13SQRZh2RMUj6ZWJ+fVQj94xRVBZKWvggPvjJs
         bmMk7YsFYokkO0jZM7aUSpZ7W8+jzsyu6Kbx9UxtOs2rLsz3v7Hc9jl/czOukFksHH4Q
         5U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702575577; x=1703180377;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXJGWbxqjeUm9JQvfAtCGUhersVnDiqfd+eihCUv9tE=;
        b=omZrFfahwtbzFaHPeyx816pdWNO10J+tTZ8epcxACUZ/R6CqL6aDzUGh6sHqLTYrQQ
         PJHn06CTaYUwsuwGGs25EW/oTjnv45spc52DpQrAicbqmg08mbfd8HXIaY6JPTD0Ip2O
         Ry8j/0KTNgvt8ies2tZIM0PI1wLt6ijV9PcnvbD3hDl6eL2K96Td9XichzkILqO7S0/a
         MIzhhk7ls13QWm70dUQVeyEDTTQ+sYMH37uZ3X3hAaqjxy4zReJIS6GRPBJNtuQwHpaW
         SzTMcESu9YcBnm/uewZKv0imBgscjj2YQkhIV6/YNspOZcD0JMLX36TDZn2lIlAjfD5l
         8QRg==
X-Gm-Message-State: AOJu0YyTygO+asAslLh+18YXOVMqovfeB5EqekqHFCnRSz24M+w03G6Z
	UXQNsH1q9wHoys5wRxnsyCJKp4JSM5680gDkZGU=
X-Google-Smtp-Source: AGHT+IHRmqLe0jpMVukXHJRVMMido2OB+dnz+bRpyFyBxP+0iAbUqEwBi4G6x9130pH+4sAxx/IcdQ==
X-Received: by 2002:a17:90a:7025:b0:28b:11b4:caea with SMTP id f34-20020a17090a702500b0028b11b4caeamr495174pjk.70.1702575577240;
        Thu, 14 Dec 2023 09:39:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id rs14-20020a17090b2b8e00b00288628acf6dsm13393462pjb.14.2023.12.14.09.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:39:36 -0800 (PST)
Message-ID: <657b3dd8.170a0220.dee8a.9ed2@mx.google.com>
Date: Thu, 14 Dec 2023 09:39:36 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-10-gfcce3e8006ffb
Subject: stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.68-10-gfcce3e8006ffb)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.=
68-10-gfcce3e8006ffb)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.68-10-gfcce3e8006ffb/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.68-10-gfcce3e8006ffb
Git Commit: fcce3e8006ffb5a4298ac9fe5a60fa68dcf8dd3b
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

