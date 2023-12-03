Return-Path: <stable+bounces-3795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8228025CB
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82371F20F89
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 16:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA841642A;
	Sun,  3 Dec 2023 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="teo6SPpv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51917E6
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 08:57:31 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d06d42a58aso13464485ad.0
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 08:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701622650; x=1702227450; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JClxhS9Vokpwht56F0fdX31teYFI7yM84X43ZkB7ixY=;
        b=teo6SPpvpKLWAFGh9slR3YTMydCgIIBqYj7xmZFRXwgECsgPbyFizr7tvEokySFTQj
         AB2Zu9HoG3FGe6kv3jtdbsEOWFMog/fxNfQzbGEGN1a9iI01hByek/mn0T++UbH+BKr1
         HrV0LSRPh1dvgDYZKuBFr8KnNMtodioxJNQKF38MdgnuzLiF6w5z0H4pGjy9EsiUHfIs
         rcAorN7Ohvn/4wRDqkRHq2XpLj/kUNRLkIl/v1RZmdqcqkPEsZLODdojuaiNDmDFd6lK
         giqsWHAwPMzldwgWBbMQHaek1MeJZ4y6iRVy0wl9tm48Vt1o7H1wt+yR52Si9ZaYwk90
         qr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701622650; x=1702227450;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JClxhS9Vokpwht56F0fdX31teYFI7yM84X43ZkB7ixY=;
        b=ArBDPj8BFWplD6gGsTRExr1hFwPku8SnzalS4mdpKq2mI+yKuT+gl3OHk6lRHbWrKc
         HUX11t2achLPH2EdoXMj5MK3odShyDeSGKaGUaN83+SMlIpo+SjWLEfnlArxeQW5O+jh
         KmnfnIlqfE8FnfghLD12MxYkBVXqPN1k9wdzrVefd+yhQphE3R4DnL/aQ/cDRWm7iK+Q
         xJIJK/68wyUSEmVVwVEvU8vNfPRcWXPU7L2c9WsghsW2+KwR99r/LNrcfY79plzGg/lX
         Hq3KB99tGcfXMHlsBFmzSKHXYkH7eoxLlI5/WNdGqEe+Og89yOcVw6tvvMhYent3HvJg
         rB4w==
X-Gm-Message-State: AOJu0YzRDLgzWCHuMbSXFixWhrEKVP+GZymW489aDredrr1RYHIQ0OyE
	0IyHL45GGnAVJpyjuxE4G28Zx4d7p174XPRQaOVskA==
X-Google-Smtp-Source: AGHT+IGfdmExUAbJpPJFAekukqhn/6E4dCWR0N0vVkz0nuQwrvF3eokKTvGtjKn593HTJ+xxcdhHnA==
X-Received: by 2002:a17:902:968d:b0:1d0:6ffd:e2d8 with SMTP id n13-20020a170902968d00b001d06ffde2d8mr2645943plp.114.1701622650320;
        Sun, 03 Dec 2023 08:57:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001c71ec1866fsm6972444plk.258.2023.12.03.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 08:57:29 -0800 (PST)
Message-ID: <656cb379.170a0220.c01bf.32aa@mx.google.com>
Date: Sun, 03 Dec 2023 08:57:29 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.141-27-g91ec262d44f0f
Subject: stable-rc/queue/5.15 build: 19 builds: 0 failed, 19 passed,
 3 warnings (v5.15.141-27-g91ec262d44f0f)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 19 builds: 0 failed, 19 passed, 3 warnings (v5.=
15.141-27-g91ec262d44f0f)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.141-27-g91ec262d44f0f/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.141-27-g91ec262d44f0f
Git Commit: 91ec262d44f0f06a48ade1d4626a905dd283696e
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

