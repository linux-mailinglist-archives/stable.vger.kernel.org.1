Return-Path: <stable+bounces-3553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC367FF9C4
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 19:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA071C20FC6
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85AB53802;
	Thu, 30 Nov 2023 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gDrxAADp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D804E10E2
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 10:44:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso1285617b3a.0
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 10:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701369874; x=1701974674; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YrCQtimaPIje5tKRZNaRqq/cK6VJVGi1C60AhmxCMqk=;
        b=gDrxAADpIEwmIdTRbPPBUxzaXvZLEsqyDwaR50DR8XgyUUxfNdq7Lx6pWlOVn4hiMZ
         1mXKgl5kuUsAq19BWWT4nXZG/WaTqjWX7xCQgscKGAM0T4gPzXGP0sUz+nvgAsy8ptcJ
         M2alxDeA4Rj6XuFuHFkjzmShvylCoACtOYiNqOZxS0ORbnYH1zLWUtwWLgnk6XaqyiMb
         8S/CqYt6w/7dt95cYl9DStC2hnfHAzn3XsOVSMG2V+FmgXYyV/VZBLr2X1TOpSBfO4A2
         GeuS2LDEO033TK3BJ75My8L21AsUSHP/2cTtAJ/uF+7KOqg7MtuuVRaEWcnadY/vwwC9
         Ckag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369874; x=1701974674;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrCQtimaPIje5tKRZNaRqq/cK6VJVGi1C60AhmxCMqk=;
        b=Tv42BDA47+9F5nfud8Y2qu16R+C0QO/4GMz6/lip7WlIhkU6F3ehMaNs1vyL6UOgQe
         nblH2WGURsi29RQxoBNzU8+nqcqLttrXt6bUn7jqizCvs0Qf8sTIrBXk7msJWtcC3hV3
         gRlyQ7Mz9LAtXRHpoN2UtRoHtM6pexzHcRnbixEaEEfSIhmUqdwoU7oOQHhXUFs6eiHs
         fHPosOEp8jUpGjUiWyaochNoY1qiazBGIx+BrCn7eBF79LSLfME3RuFpjYCU3n4AJos6
         AoLt+/D0XUeRAYhmALkcIzGp5/YuRk/w0biBp4I/v2tLwm8Du5txUmN4Z/MWx60XyYVn
         PWlw==
X-Gm-Message-State: AOJu0Yy7F4AN0p6faf9ZGfO7cu3Jlk0TAmcxxGTy2I3iYPY8OZPx66Lq
	k91jX5K8xwLNQRWfoyAXV2IdvVUZhYDYfCZS2zgl1Q==
X-Google-Smtp-Source: AGHT+IEpnWcoBihPSz6XlJXky/4A2TFQIPGpPFBumjQ3biOGTlBdUMajym8f6PkeGLQI9K90Kj3R6Q==
X-Received: by 2002:a05:6a20:7294:b0:18c:ad4d:3469 with SMTP id o20-20020a056a20729400b0018cad4d3469mr14727178pzk.53.1701369873983;
        Thu, 30 Nov 2023 10:44:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7990b000000b0069343e474bcsm1536765pff.104.2023.11.30.10.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:44:33 -0800 (PST)
Message-ID: <6568d811.a70a0220.11e9d.4d7f@mx.google.com>
Date: Thu, 30 Nov 2023 10:44:33 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.140-69-g6578fee152e7b
Subject: stable-rc/queue/5.15 build: 20 builds: 4 failed, 16 passed, 8 errors,
 3 warnings (v5.15.140-69-g6578fee152e7b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 4 failed, 16 passed, 8 errors, 3 war=
nings (v5.15.140-69-g6578fee152e7b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.140-69-g6578fee152e7b/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.140-69-g6578fee152e7b
Git Commit: 6578fee152e7b208be3614569ef7c0b0e95bf592
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

