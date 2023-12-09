Return-Path: <stable+bounces-5101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C677480B308
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 09:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B121C209FD
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA276FBF;
	Sat,  9 Dec 2023 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="a885YPew"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909910CF
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 00:04:26 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b9e7f4a0d7so1176729b6e.1
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 00:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702109065; x=1702713865; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4lFh3iRI0cJrqRMn+RtsCVHKB9vB7OUyEixkXiwz8Ro=;
        b=a885YPewSlEe1lIzCKhCeIACnXUjQEa7GATBiMltau8MTr0EKL8acOaeiFuQGZw/Q0
         dpAi6KsE+YSK2w/INDjcfe2OCerUNFLOrqLiyd0XOEo4R8xJiqD/IXFc/zSMPeBUd2QE
         5xjwfdhjiKr1lMYWqQ0Nj8GKJuhwfS79dI/z3slyZzsplfiUT7hOAP0KuIh5O4RZw6tx
         ifOtrPDDWnUwogGhXRpe4sTBCMgHN+qu7wBIgI1Pwh35uSPOZpiYpV8ijBwLvonIiLEa
         S6St5QR6ICIvAYKTGg5ZBBJb4LO4t5buy7SRs46nW4cJnU2Kc2ce1REog1jemUaCVd7v
         Msgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702109065; x=1702713865;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lFh3iRI0cJrqRMn+RtsCVHKB9vB7OUyEixkXiwz8Ro=;
        b=piGpGJY3ZzoJ9Gy3BQkaidzkGHFGl7pQRuamDQQ3b7LjziABLp/f/jSehJccWceCLv
         0M7+e08LdtiIte5xLzMRDukaBOPaJ8szn3WrSt8BvAT5W8ygI0gDjjevC43DTbBVOMt7
         DTVvLVKJBTEte3NdBPY0BcZTX6o5ouUI0xJNTeEKnW+Sw0ujf2mFC4PlQ9Z+fh3ZwJBd
         9Bfr5z2biVn6FhDnT9WJbi8ymIX2MhEMMk/VrlCE9lhZ4M5n0tbvTbFa5QaO1We5MtJZ
         mcDrkaykRZLm/ZiJZ+DIg3FhucWHHkG2duAAbLczktufHeT/skpfRBca62cieowMty8p
         OwoA==
X-Gm-Message-State: AOJu0Yz0TRcPHa1p8R3tafRNDAgTZy3kHq1baxcIjHLqgdu/EH6YFiMp
	hJncgLFf3BZD3ObTYeO+alEXN/SlpTmsfLWVcY93UA==
X-Google-Smtp-Source: AGHT+IHz/8uyJjvgQVTX4mEhk46Ge3zvyIsR/mL3+2yuuUOuYFcsrn3wSiL33pkzSn98C7wecTiWEQ==
X-Received: by 2002:a05:6808:1441:b0:3b9:ec87:84b with SMTP id x1-20020a056808144100b003b9ec87084bmr1860302oiv.69.1702109065423;
        Sat, 09 Dec 2023 00:04:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w4-20020aa78584000000b006ce5c583c89sm2842418pfn.15.2023.12.09.00.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 00:04:24 -0800 (PST)
Message-ID: <65741f88.a70a0220.959ba.9a86@mx.google.com>
Date: Sat, 09 Dec 2023 00:04:24 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-98-g1985fd91c0333
Subject: stable-rc/queue/6.1 build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.66-98-g1985fd91c0333)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 19 builds: 0 failed, 19 passed, 1 warning (v6.1.=
66-98-g1985fd91c0333)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.66-98-g1985fd91c0333/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.66-98-g1985fd91c0333
Git Commit: 1985fd91c0333212253b0bf5d3d970dbd267553c
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

