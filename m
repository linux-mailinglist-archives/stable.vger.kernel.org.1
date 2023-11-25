Return-Path: <stable+bounces-2654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DB67F8FE0
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 23:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B642813C8
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2212F84B;
	Sat, 25 Nov 2023 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="yoPqVYiO"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DACFE
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 14:50:30 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-359343e399fso9879805ab.0
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 14:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700952629; x=1701557429; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lreIikiL9iZ99r1CDqP0wGQPWGnmkquQcwzWkNt1bAs=;
        b=yoPqVYiOPbP4g7WolDEstoYTUejxRKLPsXURRmfPWENYDmyLwyRwaYFN63wj8nLMmH
         SIjAJ5cKYEqG3nfcO9oR8auYcym9k3/ydC3ubW+QFXj5hjuNwt+u9CrTh1HOK3rTiBS7
         HGh3Qu+E1cSrPnucxLpUkLtSc8oyHZ5iTrh5D8E2fYnoYDf/mOvxBSBh/Br4p5qRLvHB
         GamPjPJto9e+k4EOF4LiIh+ng3H3PdaI+S1es9m1hT6OVxlvQnPO0d3uZXjEWkiYLlVl
         dQsk2zacu3D9fW06lVCd3FTGOO6d/Zna/ujm2Pab0Lei6dtcaiBmQgahrhi3ObSplhan
         prhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700952629; x=1701557429;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lreIikiL9iZ99r1CDqP0wGQPWGnmkquQcwzWkNt1bAs=;
        b=eM+KZMMVtfI5HZJIfyhLTB79a15qmPUT9lOkxBBRoF/We7t2++c4MQAOYljw9FD8Fw
         5PeojhsJXcz3D3oI0HyOpUNmyvzYtBmcaNkE5Q/xPjG+IDDv6INiIc/oznbo3wJuTczR
         UHFpIqKN7QuXq0/FTKkrzoM/XtDNpgFhpjBIzm8LjVElnc9fA4tFP4F4mhkhvrTDVi5D
         Q5cs3IMiWVnJ4n58gUaYMEyxpneoeNuHRHWygGhyLLnqRorByWGMP5vSTvk9SKulc9D3
         srPqiMoQAs/yh9YF25c0dOzqP8os9lVtTu0v5phekLzmT9I7pxurz6OUCXUo+siw6iDp
         Hgvg==
X-Gm-Message-State: AOJu0YzvcS8/6QpuLciDsWaZ21GHr9a7X2FfXDO267l/LLvdM653zrxm
	GGS4kajF3KBnlpSmGJ3tvPpcrkR5+7PwVSS5r78=
X-Google-Smtp-Source: AGHT+IF/Z9GXkn4hICfFIEahHM413DPvPgubcClIzdE3bybU74bo6BOqltoew0yHCh1D4oHP2Weazg==
X-Received: by 2002:a92:cc49:0:b0:35c:8738:7e52 with SMTP id t9-20020a92cc49000000b0035c87387e52mr3897668ilq.4.1700952629692;
        Sat, 25 Nov 2023 14:50:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902748c00b001c9d011581dsm5405828pll.164.2023.11.25.14.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 14:50:29 -0800 (PST)
Message-ID: <65627a35.170a0220.b83b9.cd0d@mx.google.com>
Date: Sat, 25 Nov 2023 14:50:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63-369-g95c73b9f848ae
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.63-369-g95c73b9f848ae)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.63-369-g95c73b9f848ae)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.63-369-g95c73b9f848ae/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.63-369-g95c73b9f848ae
Git Commit: 95c73b9f848aecf4bbfe56ddb063d0255fae00c0
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

