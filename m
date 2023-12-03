Return-Path: <stable+bounces-3716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEC58021A7
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 09:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BE5B20A5F
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 08:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA62F38;
	Sun,  3 Dec 2023 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KJfWjYGq"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336D6ED
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 00:18:22 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-35d54d7e4bfso9114505ab.3
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 00:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701591501; x=1702196301; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2D2LXBlGlB6IXADeaqmyZoe+xcbIhpOVZzcd3qFHm/I=;
        b=KJfWjYGq4nYj99nLvwOPVQSH0FpxWLV9B8LObsATccHbKcI4j9/rM/ukFhvZdkwicZ
         N38xq46I+xo5bWHxT3S2S2gDCi8iGYUPCm35dgK5m3TrcfnrppSpApyFBfgbvMuyAVxg
         QOJKQRTa/te1dzUp2NsdrdBULz7j2uEjFZFNtp6NSgDwU7zLVaeLaom0KVrIUVE8WFG3
         6M4KQvaZm/we7nC940atwYit0Sn+KZl6IqKQPG1oaX2sub9NOUPUoWyr5IN3VJ4rnkqf
         noEEi5g8r80Cnt93RlvlzFi4AxXwN9XpF0tlEzzWKcvEyrefZSUSP1/3kV0VCmISP+wd
         nG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701591501; x=1702196301;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2D2LXBlGlB6IXADeaqmyZoe+xcbIhpOVZzcd3qFHm/I=;
        b=iS3cnFzaYoy0LRtHO4zFJEbuPcfERM6/p7k3w5rPCeoHpcaA8zkJNfzIOUegjkgNIg
         lQ2IXrDIkoa3YKEBeMmGulMv6N9TNQbUpd7eyBbr+v7fkpDXTWMmOcURhwnfOhTgBiU6
         skHtbJICzt+7OgnbpE5V+f0J7+LROnHzyI3gswZEfp2wuRVtD5QXKAH2T0uhRAvsf3s5
         sT1c23y7k5NhYLikgjLfNppYX9Ap1Y8FzMbReI3ZyUNgDQRGP5OOJm+65mwYvaYMGdTn
         SdHYXeuHr/PD+/029RgwzHiyZh7FFjgto5yR8rvC1dsSpgaCczV1gCEG4Wgid8GSuiEU
         0VpA==
X-Gm-Message-State: AOJu0YysLlkDHmSMAiNAbha8ZpUixJBFJV4LjJJVz/JsYuTc6ZH1s2rz
	YcAV6ks9tmOGf79JVJLN++CNsh1SuONZ6oEJCojjUg==
X-Google-Smtp-Source: AGHT+IHRIyVJlKsClN6hIsBcribgdD7CuGxaqMqz6NTHqeWBp2kr7HgzKYRnqAIGnmYF87sYmu03qg==
X-Received: by 2002:a05:6e02:ded:b0:35d:5995:1d77 with SMTP id m13-20020a056e020ded00b0035d59951d77mr2802362ilj.60.1701591500914;
        Sun, 03 Dec 2023 00:18:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p24-20020a170902b09800b001cf684bf8d8sm6294148plr.107.2023.12.03.00.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 00:18:20 -0800 (PST)
Message-ID: <656c39cc.170a0220.3be5d.255b@mx.google.com>
Date: Sun, 03 Dec 2023 00:18:20 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.65
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.65)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.65)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.65/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.65
Git Commit: c6114c845984144944f1abc07c61de219367a4da
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

