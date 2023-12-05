Return-Path: <stable+bounces-4684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821638056EB
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 15:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4ED31C20FD6
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F961FCE;
	Tue,  5 Dec 2023 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZpM0957k"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FC490
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 06:13:26 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cda22140f2so5483993b3a.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701785605; x=1702390405; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1e9WfMHupdfJN3Y1vz/yt/sPBRo2BEoyQyJKrJKH+JI=;
        b=ZpM0957kzdfLW0lDv9tZ78BPDLB//hBXNbBE3W8wDW4sqIMDig6KTERX0YQPkaUuxU
         E1liMfVOLNMB5rUcF81+HK+CJmMDrY6QglD0gRbRr2nrlGMlWExpYv/SxWEQIk5a4C8/
         kqRGt+GNXuv62C7PJk8l8KjEJzI1wlsm2U2Q3tlj3yCASwlk4lbZd8rI6xlP2FnAU8R9
         i0sxl7PYvWojmNrLxkvMZz5M5Zi35vxTFO8874n2xvXXjCyHb4iD/4Koepc7aS+eEE1T
         NXaWzbz5TiQ0p4ZkwxknvUxxB7o9pF508ryUrpyiOMcvdDOcv9nBGaoUA+TgkMhjDzCK
         ww0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701785605; x=1702390405;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1e9WfMHupdfJN3Y1vz/yt/sPBRo2BEoyQyJKrJKH+JI=;
        b=h85gOO28FtTcaMOqNAnKne3mTMDBAeJdTedQayOm0CsfnrtK8mB7hQLMiG2GUljQ9o
         f/yXWcSepx6bXyVbUz3JxMjPoNW6E9NXTGqYww1as12GiMTFzAr9a+E6z636aQDZ9VQx
         pwyf+8KbeJ66L1HmsC3asJxmizHNHJaSp/xakdTsaNMSuD4W4XmRBXKicb+PwYLszO+1
         Ttoc3fg/EG74K+4+h7bfHrq8omqopQhMftLoCGTFSJI7KNvxlMOgtyx35lOBnip7IjLo
         /XRjqqRfIIo7rsE+Sa8p7XAf+Tl3IqsMS8fw2Iv+70Ym+xJ5TDhYMfK4w7pQ9kBg/bCM
         c2Vw==
X-Gm-Message-State: AOJu0YxEvdw+i7WYBd2i5HuN83uJrtfBGs2HPntezO8wac/ijOQmTaDi
	EV4QaT15RRTAlZ7C7GFD0tXR05cFeEdU98QVFAUJlg==
X-Google-Smtp-Source: AGHT+IEHYlDIT36opWBrIP8mc8ktHL+/xTG9W5rw80D72YwxwNS7HqBbGyrnTgelVuM5+cnctHZKGg==
X-Received: by 2002:a05:6a21:6d85:b0:189:6cf5:7901 with SMTP id wl5-20020a056a216d8500b001896cf57901mr7669763pzb.33.1701785605290;
        Tue, 05 Dec 2023 06:13:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm9208376pgh.14.2023.12.05.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:13:24 -0800 (PST)
Message-ID: <656f3004.630a0220.25044.9f3b@mx.google.com>
Date: Tue, 05 Dec 2023 06:13:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.65-108-gc1e513337d8b
Subject: stable-rc/linux-6.1.y build: 20 builds: 2 failed, 18 passed, 2 errors,
 1 warning (v6.1.65-108-gc1e513337d8b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y build: 20 builds: 2 failed, 18 passed, 2 errors, 1 wa=
rning (v6.1.65-108-gc1e513337d8b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.65-108-gc1e513337d8b/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.65-108-gc1e513337d8b
Git Commit: c1e513337d8bc4364ceea88e27b9398de2d18f58
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

riscv:
    defconfig: (gcc-10) FAIL
    rv32_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 error
    rv32_defconfig (gcc-10): 1 error

x86_64:

Errors summary:

    2    drivers/perf/riscv_pmu_sbi.c:582:26: error: =E2=80=98riscv_pmu_irq=
_num=E2=80=99 undeclared (first use in this function); did you mean =E2=80=
=98riscv_pmu_irq=E2=80=99?

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section mi=
smatches

Errors:
    drivers/perf/riscv_pmu_sbi.c:582:26: error: =E2=80=98riscv_pmu_irq_num=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98ri=
scv_pmu_irq=E2=80=99?

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
rv32_defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 secti=
on mismatches

Errors:
    drivers/perf/riscv_pmu_sbi.c:582:26: error: =E2=80=98riscv_pmu_irq_num=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98ri=
scv_pmu_irq=E2=80=99?

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

