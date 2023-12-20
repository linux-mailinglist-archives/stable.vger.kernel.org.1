Return-Path: <stable+bounces-8198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D481A8B1
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 23:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E65B21286
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 22:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B37E482DC;
	Wed, 20 Dec 2023 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="11wOsT0x"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4094A983
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d5c4cb8a4cso110940b3a.3
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 14:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703109864; x=1703714664; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DvxK7yH963vtEJVSIyYgkjNImO/4nYvApM1damlzLy4=;
        b=11wOsT0x0qkG4CerndLxQmjg66ye4o4Q9XUpCDiOxSjGRtYaRLokQtlTz17peEHGfZ
         nT3G6OpQ74Bseb3ivSXpQOikOjmNWzVPDt8RZ4+OYCQiP1xHEiTlPbikc/02T+Mlf346
         OrQQY/xEo+XBNuC/UcLPMizY35bq7KsBXZdQySXjvFyt17K2tNmVwPwHbtUvVnVa0kTw
         ob8YvEh2YxqfPREKKlQe1TaBg3vSZN4Irmav0IfFpPQlxFhWM4V9LwciawO6MNJXBvO9
         nFohV4zxS65QtmlqG61oszY4G6dTt44xxKUjOpTIWTQ5sS2TRCeV/WJyFrvTGJ4og4Tc
         dzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703109864; x=1703714664;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvxK7yH963vtEJVSIyYgkjNImO/4nYvApM1damlzLy4=;
        b=ZYa/M/Fxtc3nx68e7ioR8WZuh+davc5mlNgtG7qnD6p8rLnhI518AL8oOtZNwVNwZu
         Q6DJdIl5vq6NLqelYqIU9BIV9Gg6vf4by+7QSG1bd1UatYwVVvQltrKcxQUUU5i5J/Mw
         UMAzQ0pTn4wfcOTPMnkJCN65OSArf0Y5jzEpEjcewDiv5yePo4vfVO19DHtSiRxp1I0g
         hf9XD2hF489vECrvqfdwp518v/1cbpyz0PUQl8bNpZMtnHNnbHf/LIaLrE/JIz2aDXMZ
         tIRQDM+kwVSeOIkCAWWsS2rvvkOrmFTPUN78hxQIgSFBy57sPFecCxxPvRQBLt1B7ACz
         uxfw==
X-Gm-Message-State: AOJu0Yx8rz2VtQI2fg5UNcWvesK4WHolW2tpxBz9o9lsSzKPOZwYoOPJ
	D7m12sZunyKDiSg4l6HLaqhkWNjnwST/KVLSt8I=
X-Google-Smtp-Source: AGHT+IF8LxKwLoPdrkJwBPbjtCWBdd1z5HJgBc3nlxU7WuiM8Dj52mvlg/dV+cUbQlRQMv/0/LQ1Hg==
X-Received: by 2002:a05:6a00:1743:b0:6d9:5b9b:afa8 with SMTP id j3-20020a056a00174300b006d95b9bafa8mr1578552pfc.65.1703109863812;
        Wed, 20 Dec 2023 14:04:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7991d000000b006cea1db00cbsm238930pff.204.2023.12.20.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:04:22 -0800 (PST)
Message-ID: <658364e6.a70a0220.4f8c9.13da@mx.google.com>
Date: Wed, 20 Dec 2023 14:04:22 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-83-g1d146b1875fc9
Subject: stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed,
 3 warnings (v5.15.143-83-g1d146b1875fc9)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed, 3 warnings (v5.=
15.143-83-g1d146b1875fc9)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.143-83-g1d146b1875fc9/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.143-83-g1d146b1875fc9
Git Commit: 1d146b1875fc901ae6bfe26ec8fed15b8dcd97ae
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

