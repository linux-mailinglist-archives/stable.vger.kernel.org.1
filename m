Return-Path: <stable+bounces-3877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4088033BC
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 14:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50331B20819
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222C8249F1;
	Mon,  4 Dec 2023 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ArlObEPQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1125DAC
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 05:01:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cb55001124so4113791b3a.0
        for <stable@vger.kernel.org>; Mon, 04 Dec 2023 05:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701694896; x=1702299696; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts5UE/Yv7yxWvWF5KQMDisuwTihhhCbGUhNjtjic7GQ=;
        b=ArlObEPQH72HQu8H2zAlcdvC2XvVja0J0cKuvS/+GZ5wdmt7iMcRHiprazOKauiW1V
         S681ZTx+wBdm+Quv1nw6fMhCGsjM23yCIhWJ1GOnMeKQ7pmy+ZvMnXseP6lVuyc0PXDV
         cITfH4TxL1yHBISEQ2Y7lmly47ydH5ardOdwKZtyDQFIY+VYSGOiMV4ieKGdcNmoKrdq
         n4bIoQYGJBSS6961itQ3XXzJ5SaT2XMGZeEQ18SatC27lSV7G3Rr2tgoA5d58vonouJA
         mTBH1Us09IEGG0IK4YcL4LNSfrQDJOIvLaH1ctPeJu4OVbpKumFr46dvkm2YIOEYx8gw
         fzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694896; x=1702299696;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ts5UE/Yv7yxWvWF5KQMDisuwTihhhCbGUhNjtjic7GQ=;
        b=IdEJSR0PBPYQ9OnVCuJRe7RD2KFaEndFu6eywomNtISAI6oWRSvqGHsVV4UkyVmPlO
         xwiryXsdEwKdGpi2dA4FYCjVpbog1Qti5+eeM2BHNw5ai0hURQn45bWH/P1b+um0Zxse
         qoeIEomDbJnng7Ineo8OYW5zJt4NaWJMgvc/VD8rOPXYJPaTurYXN1A4scHSAPIByvHt
         MMDTZ1Kfei7goZ0FI4Qt4Lrrprh9FupLCU7YLy/hHrOgya+Lx4enbp3vaaXmhrzLABVu
         KcuEX1S3EO1gm49vJKDk4fIdVdURTmuccxHGiU0KAo+kuWawWRXdola4fGQaZzIpiKtA
         n7og==
X-Gm-Message-State: AOJu0Yx91TMfHHx36QHDycQTZWYA35uc4vk9ItAbbgoDFrfDyl5FqAAB
	OjYTAUh7Huq7rlYciMNn6BvrZwFYUHbEyI76vZljBw==
X-Google-Smtp-Source: AGHT+IHcZXuUZcHX6OXXf5tfUtq00i6s6PTqwfYrjztRTmKlHymfQRrhtEAu/a8UgW5om2FX8+IoMg==
X-Received: by 2002:a05:6a20:1454:b0:18c:fc4:df13 with SMTP id a20-20020a056a20145400b0018c0fc4df13mr4416602pzi.27.1701694895873;
        Mon, 04 Dec 2023 05:01:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w18-20020a639352000000b005af08f65227sm3748044pgm.80.2023.12.04.05.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:01:35 -0800 (PST)
Message-ID: <656dcdaf.630a0220.1201e.738d@mx.google.com>
Date: Mon, 04 Dec 2023 05:01:35 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.141-66-gb1cbb2de711a1
Subject: stable-rc/queue/5.15 build: 19 builds: 0 failed, 19 passed,
 3 warnings (v5.15.141-66-gb1cbb2de711a1)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 19 builds: 0 failed, 19 passed, 3 warnings (v5.=
15.141-66-gb1cbb2de711a1)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.141-66-gb1cbb2de711a1/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.141-66-gb1cbb2de711a1
Git Commit: b1cbb2de711a1d58b0c9783ad24fec35ba25b583
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

