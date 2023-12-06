Return-Path: <stable+bounces-4856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF6380774E
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 19:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D34281F2E
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229C96E2DE;
	Wed,  6 Dec 2023 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="V7iiVRz/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A67139
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 10:08:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-286ceba3f3eso112759a91.0
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701886122; x=1702490922; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4z2412uCtTC1uMbEmsiOCn+B2FoqLWiPLOmd9AHSxK4=;
        b=V7iiVRz/oCHSKuXtioxpTryms+SLeTIpx1wuV3RaXpf5YgyEGpJC5pImviJ6ifZnxH
         ejSDHFnLiP6ZpXkTuhhr31IfG+CTlLz4ZN6M2tkIpU8OFG++eXL6IOBq7TLV2kLrUdAL
         YFBUOoV1MN+y5MPQsxExhEq5I/uBFQkkN2NB7RoE+12UMr0CUdrpSPh8FESmBj8NrXWi
         zbKsJniaU/ARiVJlXUie1nvjMbmXanHjpphD6zRvN43930DdsVU9s6a5CXP9QUDHSHz4
         ddRwQRJqd3Q/ARdOWZCO4y6ZWJIrOm0fhTrdB6jUfmTGimcpplR21MZ9kc5g7xug3iu1
         MCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886122; x=1702490922;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z2412uCtTC1uMbEmsiOCn+B2FoqLWiPLOmd9AHSxK4=;
        b=GPCTr+PQ4Bs7AkKblCglo+hFGzbmjlrSQac0TD/9+91D1DUOSV99CT05eiMILtS8zn
         JfZSkfQdJf86wZXrYZ+700I7oyvwhPiTWDNKi/xe2g7YCf/HY71geziaL2M4zHe4AMtg
         /CxJwMDfQtqbBjHejbvNxzWDpe3tCy0UFrVu99FLU8j9auPJVRzVilY8qBuXgJqkAXrd
         yYUO9hGkNJl8rDhv3zMiuR6HZQ496ZQejhWhbq/Lp4CJqeSE4e9cdBDTM9FFdGO+buM9
         4msmdD4r5LrO9GGCFq/LMriMR5vIW7DbsdpnVLU+Dt1IevDgsxI2j+CSoyrsj7Eg9+0o
         ubYg==
X-Gm-Message-State: AOJu0YzA1ZO0MNm+/6W98GTKXqvSgPC0GCAYpB5uTlALg/HdJLPG+o56
	aZugHSMw5mobbhwl6s8g/7HCg4LWRcx1kYgzS2DwFA==
X-Google-Smtp-Source: AGHT+IHaW3DtBO7/Qk0v/t48SxiaLy/iriplCUWuT6KookKwJY7Wkfx6FuhRrKb0LT/7dj64oIXy4A==
X-Received: by 2002:a17:90b:1e04:b0:286:d42d:e6a with SMTP id pg4-20020a17090b1e0400b00286d42d0e6amr1343620pjb.28.1701886121931;
        Wed, 06 Dec 2023 10:08:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gp6-20020a17090adf0600b002867594de40sm171774pjb.14.2023.12.06.10.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:08:41 -0800 (PST)
Message-ID: <6570b8a9.170a0220.b7d7c.0efd@mx.google.com>
Date: Wed, 06 Dec 2023 10:08:41 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.141-64-g41591b7f348c5
Subject: stable-rc/queue/5.15 build: 18 builds: 0 failed, 18 passed,
 3 warnings (v5.15.141-64-g41591b7f348c5)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 18 builds: 0 failed, 18 passed, 3 warnings (v5.=
15.141-64-g41591b7f348c5)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.141-64-g41591b7f348c5/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.141-64-g41591b7f348c5
Git Commit: 41591b7f348c5e24dfe8663461cd674125e63e34
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
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-board (gcc-10): 1 warning


Warnings summary:

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
nommu_k210_sdcard_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>

