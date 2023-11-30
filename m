Return-Path: <stable+bounces-3565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148AB7FFBA5
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 20:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259EF1C20C6E
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E869E53E03;
	Thu, 30 Nov 2023 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="A6qzD/uf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621A19B9
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 11:41:42 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfc34b6890so11499425ad.1
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 11:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701373301; x=1701978101; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xkjOFW8iIRzrboEU6CI7fcRC+4rSvCf9ycgbTzE74z0=;
        b=A6qzD/ufM/qkDbPP382eoN2ZaxNWsGFh796L41rMOFX0/58vNQHsOaBP5OQVvEY+DC
         d41KgdW0y+/qZ7LQsZfCgrwzwpP9qfe4NYuEs2VM9mdRxkZw1NdIsTrBJLhFQb5mF/rX
         66ynseDFqkRoyMjLzT68gx6jG431cw7Wh+6Y403glwDEkUNm596aHTAHoXqhXaQqKPUf
         CAx2XFvmpCkTw8cY6emmPino48+iRb8amkXBpDQDrINZFId4MSlCCqt3JoboOXOk1F0v
         WxHCacjsyazRSZCEF8MYNgLmXd9bItEdsK7hE/pppOLsWRMu4pXU9mzcO6GpY4mvVaRK
         EAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373301; x=1701978101;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkjOFW8iIRzrboEU6CI7fcRC+4rSvCf9ycgbTzE74z0=;
        b=iu81UsAcC9MmNrW5HbHzIBxkBpAbzTFB/jspGT3c7B5LiYxnPbQAJHu+RiWA2/U1Cz
         c5vA3O2ZbHImp6uDIB+zabGu15wCrRFqCBjqNeAHaa4OrffE/zOlXosw3SHArR/hqNjH
         QL5EhubvPuawIfm66Eww5H+dws3QEvMqgn+SDjzQczM+QT0OGp0CIZSYPm5j79RnR0r3
         FYDXY049hCZ3zMKR8rgD9LtFfv8lDh5ZUvr1BIydxyHe7G/RZ9tfHU6ZUmXRI/x/Hkrw
         gbHkC9X9QvFfh/kNHGD+6j0DiuynFkizlbuqQfiPxMq0Q6dbeAZEtYpuKnB0cHK4Wh68
         0ttQ==
X-Gm-Message-State: AOJu0YzPb6m/hAiN/hhl1pBxTEB5Tq5VTq/LEvZuzUkhgP7Xht42cht6
	Y6pt8DM3sf4H8ugoFIodzmahiMdRkjUTVKJiluyStQ==
X-Google-Smtp-Source: AGHT+IEM1BUEXu0lDQQM0de+hAq3pNUEsefyKe5TW8c8q8eJChd0qgjkdqfo9advO0peD0+dd3GC/g==
X-Received: by 2002:a17:902:d2cf:b0:1cf:d8c5:22a8 with SMTP id n15-20020a170902d2cf00b001cfd8c522a8mr18877831plc.21.1701373300733;
        Thu, 30 Nov 2023 11:41:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902a70300b001cfc34965aesm1783578plq.50.2023.11.30.11.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:41:40 -0800 (PST)
Message-ID: <6568e574.170a0220.e1df1.58e8@mx.google.com>
Date: Thu, 30 Nov 2023 11:41:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.140-70-g66b7d5ed6e672
Subject: stable-rc/linux-5.15.y build: 20 builds: 4 failed, 16 passed, 8 errors,
 3 warnings (v5.15.140-70-g66b7d5ed6e672)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.15.y build: 20 builds: 4 failed, 16 passed, 8 errors, 3 w=
arnings (v5.15.140-70-g66b7d5ed6e672)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.140-70-g66b7d5ed6e672/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.140-70-g66b7d5ed6e672
Git Commit: 66b7d5ed6e672f126e1cfd6c53868c6610ca5686
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm:
    omap2plus_defconfig: (gcc-10) FAIL

i386:
    i386_defconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-board: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:
    omap2plus_defconfig (gcc-10): 2 errors

i386:
    i386_defconfig (gcc-10): 2 errors

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 2 errors, 1 warning
    x86_64_defconfig+x86-board (gcc-10): 2 errors, 1 warning

Errors summary:

    2    trace_kprobe.c:(.text+0x3228): undefined reference to `kallsyms_on=
_each_symbol'
    2    trace_kprobe.c:(.text+0x29f5): undefined reference to `kallsyms_on=
_each_symbol'
    2    /tmp/kci/linux/build/../kernel/trace/trace_kprobe.c:736: undefined=
 reference to `kallsyms_on_each_symbol'
    1    trace_kprobe.c:(.text+0x2d9b): undefined reference to `kallsyms_on=
_each_symbol'
    1    trace_kprobe.c:(.text+0x25d6): undefined reference to `kallsyms_on=
_each_symbol'

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
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 secti=
on mismatches

Errors:
    trace_kprobe.c:(.text+0x25d6): undefined reference to `kallsyms_on_each=
_symbol'
    trace_kprobe.c:(.text+0x2d9b): undefined reference to `kallsyms_on_each=
_symbol'

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 s=
ection mismatches

Errors:
    /tmp/kci/linux/build/../kernel/trace/trace_kprobe.c:736: undefined refe=
rence to `kallsyms_on_each_symbol'
    /tmp/kci/linux/build/../kernel/trace/trace_kprobe.c:736: undefined refe=
rence to `kallsyms_on_each_symbol'

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 2 errors, 1 warning, 0 se=
ction mismatches

Errors:
    trace_kprobe.c:(.text+0x29f5): undefined reference to `kallsyms_on_each=
_symbol'
    trace_kprobe.c:(.text+0x3228): undefined reference to `kallsyms_on_each=
_symbol'

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 2 errors, 1 war=
ning, 0 section mismatches

Errors:
    trace_kprobe.c:(.text+0x29f5): undefined reference to `kallsyms_on_each=
_symbol'
    trace_kprobe.c:(.text+0x3228): undefined reference to `kallsyms_on_each=
_symbol'

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>

