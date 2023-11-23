Return-Path: <stable+bounces-78-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E983A7F643A
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 17:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CD2281AAC
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4119833CC3;
	Thu, 23 Nov 2023 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wYyaP3hJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC35910D0
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 08:42:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf89e31773so6804015ad.0
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700757740; x=1701362540; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QwNnyCLsZiUC1V++eDiiOFL9Y2FD5AIw9phIIVNpjXU=;
        b=wYyaP3hJbXo7uYQyLZncudg08QgEGObSOEXKMq5cWMPb+V0QE1mi/xQ/9kcvt38svl
         /wbAdR1ng7nnmqOoz6oy8nmaUZpKdPH+hhGqJx5fqgwcJ2BT0HnZEKGK5WW7SiSkLRWn
         Fva/sS0Jptpe67Xf7d0hz49Rxlq1yi+MsCBITRYK5XfHyfLtYwbUhAdLJ6vTwDL+F8vA
         pcuNdIn6wz7z5PXA5jQ/psh8cVmVDKVFQTBP9whAtHg2BkUlqIi5jNYGJhu2AGWsNLSi
         9F90Y5pd/LboepePSWo6SkBhIAVYJpUQQcs8ciktmLZDfr/c5tDhGxMaVbqbfnYuGisl
         hBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757740; x=1701362540;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwNnyCLsZiUC1V++eDiiOFL9Y2FD5AIw9phIIVNpjXU=;
        b=Z1CDfz+TsOMLCm6oS12TvJoDU7cmY2jed/3wldMFaR48alqzG0g5thIVIxiou8hiir
         5VgAFlb1cpSa+jwr7v/HQjOpYDDK2OYJuGB0qII6BzwGHXC8FQb3AjW3MrnVMmo8CGye
         Bwk2GLF1Z6URC+ME5BPJUVK4A50W6FK8Us37c8ZcAOiSN1inxHoARwQnsTMUPgZDhvW1
         ebDVjsnKxlP8+bttE6SNwUymK3e74p54UQlkbwNRVnZsTdGKjnDX+JSb25y+YztOvm3z
         zd907nopbtjGicfWo0du6ObKScBnyT1OAiEHqUnVsqmW5HaQrVtmTMseDyWf5VvnWmni
         G2ZA==
X-Gm-Message-State: AOJu0YwQ3YZr/5l83srx/cYOk4kU3Vlk3rrIh/q+vcCjOkTmpb+eWEtC
	VAO4lNuB7n37rN+Pr9zTM+lrLbu9UZ6ddKxQPlg=
X-Google-Smtp-Source: AGHT+IHS6k/1MDJ1bTNbx0hAlQPJPWjyW4HKylCCx3XBumKS0wwOR+vVHVspSmCrmtobvnsN9dSSfw==
X-Received: by 2002:a17:903:234c:b0:1cf:7e0b:e808 with SMTP id c12-20020a170903234c00b001cf7e0be808mr16221plh.53.1700757739992;
        Thu, 23 Nov 2023 08:42:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902b94700b001cc2ebd2c2csm1548039pls.256.2023.11.23.08.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:42:19 -0800 (PST)
Message-ID: <655f80eb.170a0220.44d96.34b8@mx.google.com>
Date: Thu, 23 Nov 2023 08:42:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.139-235-ga5c4e9d1cfc8
Subject: stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed,
 3 warnings (v5.15.139-235-ga5c4e9d1cfc8)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed, 3 warnings (v5.=
15.139-235-ga5c4e9d1cfc8)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.139-235-ga5c4e9d1cfc8/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.139-235-ga5c4e9d1cfc8
Git Commit: a5c4e9d1cfc86ab7f9cb2741a33b76f8f4de03a2
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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

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

