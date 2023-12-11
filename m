Return-Path: <stable+bounces-5242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D580C10F
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 06:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15571C20918
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 05:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C341EB4E;
	Mon, 11 Dec 2023 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GYJkc9NQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FDDB
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 21:59:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0521554ddso24206795ad.2
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 21:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702274354; x=1702879154; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sd7lBIoB7nVtliA9Okr7MRGWLrooFTld8XYMn+5o1NA=;
        b=GYJkc9NQrwgRCcHVKBET9/K1de3dNxRDPolgsLKUgL9koxSfogjaUgOoQFZDLi6/Nv
         RK4U9/UK8kw/CAXvyUChrfmwCj2JA91Kg4dN51459TuD9Pha4/oXBh/6lvd0TkEFAulJ
         i7KWeMk6Vz8QdR0/hpsRyXDUwKcRBshEbG1rrGPvDsTDFI72WM9ZRRdFZBmdsdl5mT4O
         46yHsrPlm1NZmDBHYAiKRv/Ewr1ZFMcYd2cKVEvYb4HB1HQgJMTX1g5f7poRx+xhN4oW
         BjPM4TLbQZGpnsD2g2FtSmcLR93yTtC8zvinwDrV4CvDG7LNaNZokPk+mQQC5l3h0SFi
         ti+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702274354; x=1702879154;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sd7lBIoB7nVtliA9Okr7MRGWLrooFTld8XYMn+5o1NA=;
        b=i0YfssGSsMOMpI32f0ifW+0P6aikj5K+b664emIA9KWuNorN26YI6E9uErxn/wua7F
         CEO4kMzJ/yHQnwkEfCXEw0F1EfvWRaZDFMHyut8Yyk0NTZKH+3Ax4Rbj2D7fEkqnnS49
         HVY6mNl+dq7hw+vCysECWSJ+tbcf7jzAZE7sYRBZi81FPd05dAIErC0RUtk0bZ1unU8O
         zouU+dkoHd4kTt6KKaB74UGPGWeU20QBqqBmclGDLQJdVqP8Bx/rxZDdUOg+xyHYCiY3
         VijYj2FNsV0kLWWrvtsSDbwWqofv84e2x4BaihBLkZVpvnFQEDq6va9uFFCY+50NctX7
         mPLg==
X-Gm-Message-State: AOJu0YyRm9ja8tS8pyhSwWhrTq8obmNHXC7NtzwOBNHZEIoP2pJ6lS2y
	OI4YBRdNpwb5RT9WODq9DkzzImmJML6kiVjkYlqJAQ==
X-Google-Smtp-Source: AGHT+IEcXhuDVJj0Xi5UbyUATQVeYYsjS3iqPVXVemwpUxI7k0GnnCEY5cWsCs5CagfETYXS0mNfYg==
X-Received: by 2002:a17:902:e5c3:b0:1d0:5a43:2a2e with SMTP id u3-20020a170902e5c300b001d05a432a2emr1527739plf.68.1702274354508;
        Sun, 10 Dec 2023 21:59:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b001d0a0ee28desm5720863pld.251.2023.12.10.21.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 21:59:14 -0800 (PST)
Message-ID: <6576a532.170a0220.60847.00cd@mx.google.com>
Date: Sun, 10 Dec 2023 21:59:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.142-118-g2880d631f2413
Subject: stable-rc/queue/5.15 build: 19 builds: 0 failed, 19 passed,
 6 warnings (v5.15.142-118-g2880d631f2413)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 19 builds: 0 failed, 19 passed, 6 warnings (v5.=
15.142-118-g2880d631f2413)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.142-118-g2880d631f2413/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.142-118-g2880d631f2413
Git Commit: 2880d631f241366533324ff746a1c66dcf61fd85
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:
    i386_defconfig (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-board (gcc-10): 2 warnings


Warnings summary:

    3    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of ne=
gative value [-Wshift-negative-value]
    2    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unr=
eachable instruction
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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 war=
nings, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

---
For more info write to <info@kernelci.org>

