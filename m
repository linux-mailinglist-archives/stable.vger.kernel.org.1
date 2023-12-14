Return-Path: <stable+bounces-6701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1228D812534
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 03:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AB71C214B6
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 02:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BCEC7;
	Thu, 14 Dec 2023 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1CFo8Hb4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9B4106
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 18:23:15 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso6410131a12.0
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 18:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702520594; x=1703125394; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=40fPLMgp3itPhdyAP1iHzW7RkoGpyvl6gY+frpNnJ1c=;
        b=1CFo8Hb4/sB+sB6B4TRw7yB2p7YtMTSxzsrlyboWU54nD2dP20H1GGUqvIOyswWHI7
         rhZv6UJurV/S1JWnD2Xl55T27/im5bBTscl01u/bu6ZlMOg4pcUNQPa1UPgl/LHGeewP
         SXPSa3iLKBFFxFFjbIiNv8y4AiNn71xEi+RNZ2nBM+Q5rzxIpGIG+5SscqU2ni0Gb0th
         M9FQRcG9H5LLpTCfzIn60m/HHgN0HnFUTWQTLEIWAIy2N+3316AJsQ2Ch9KXe0kePhD1
         l1nVgsQx/NBb/u1furGx1Bph0wmKWeR71T55m2BHpl9tCHlCH+AIzEh0gs9dWzHUgGWM
         UIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702520594; x=1703125394;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40fPLMgp3itPhdyAP1iHzW7RkoGpyvl6gY+frpNnJ1c=;
        b=xH6S6FLaKrp36iHnxoR2V6QBUHbo8GschzcweJWrWW4vIdCLShWAUqBjEANZwPlBev
         I/GbXWTInBYB+CkgAf2PpTXfzBsq3xylUA3SoQUXEE+8lZJiejH7UbTXd858rZuT+Ttn
         mZAkj1x+0+QHD5l4WDt4HTjX8BODgqWsSUduj49Tru+1kxXuIwyIDCMXQexHxdq1qLIb
         KerjjHp3HodOAaBkfvVDmxYvC4a/pkuyGGAWQFTX+VOD+gDb/cEl7GxsAc49ZDv673Md
         94J5hNXez8SRZXT89liMepEHW5pZ0cvT3P9Gz12cNQR9+owUlQ/NeC8XEE9CTBqB1wle
         FbaA==
X-Gm-Message-State: AOJu0YzMoH0M+zm6gGc2PlXn/Enw8DuZSq6pR07hz8IXof4eVhHRkhop
	upbcU1D/sEd5Tfy14Vpw7AsiznNDS4mTS+uoR0v1mA==
X-Google-Smtp-Source: AGHT+IHAkMZY9iF2sGQzcJBQJW26CmH+L6u3+RoU1OxR1S/UQBoYxw6t6oaarKK5kSC5tYmGBD4pkQ==
X-Received: by 2002:a05:6a20:9390:b0:18f:c737:1c9f with SMTP id x16-20020a056a20939000b0018fc7371c9fmr11134860pzh.5.1702520594530;
        Wed, 13 Dec 2023 18:23:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 3-20020a630c43000000b005bdbe9a597fsm10384211pgm.57.2023.12.13.18.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 18:23:13 -0800 (PST)
Message-ID: <657a6711.630a0220.ed389.fb52@mx.google.com>
Date: Wed, 13 Dec 2023 18:23:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.67-194-gb1f34ec337363
Subject: stable-rc/queue/6.1 build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.67-194-gb1f34ec337363)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 19 builds: 0 failed, 19 passed, 1 warning (v6.1.=
67-194-gb1f34ec337363)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.67-194-gb1f34ec337363/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.67-194-gb1f34ec337363
Git Commit: b1f34ec337363d820a35e7e5ae939996ed093f3b
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

