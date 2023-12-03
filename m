Return-Path: <stable+bounces-3789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E13802537
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 16:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E537F1C208FF
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F353154AC;
	Sun,  3 Dec 2023 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="YoSDpK86"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624D0EB
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 07:41:03 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ce46470647so49171b3a.1
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 07:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701618062; x=1702222862; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u3kmm6SOKyLu2Eva82DgdmuT4Fi5XxOpvYeBsQl0ciQ=;
        b=YoSDpK86x5muhd5MXBZ9X5dzyaOucsc7E1ybswgQzKURqKv2E3/vNrofnCfOiJkO5e
         Qds4vsi3dPv0tnqBulHGRBUK2Cc1Je2F8y6C/82bdtuhBoCMuPyYcoqDJYkTKECEvbRc
         UTrLu/0ghn3V6wSoFzzEjK2NwyaiVe/wLA3zjXhRwcI1BRu2T0K/Zo8MEPLHEHQHtVBq
         r65kOKFSeg5tBHCnVy9HKSfQAx733fs4I7Ge9+RmJwd1WdUCgjvKhmGeu13qLWecUaV+
         FJ8NcjlyYtM70VLUZYtlcWkMNPZueCi0oOs8auB8dlCk0Yb8H1EVY0KfEyY9DugxzdYv
         tWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701618062; x=1702222862;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3kmm6SOKyLu2Eva82DgdmuT4Fi5XxOpvYeBsQl0ciQ=;
        b=NFjcfd6Epdk2kba4fvzxEIWuOMSHYZX2O6MTsAXX1MUsiYJ1xaFOVFtlc64RTPumHy
         KcFkV+Hn9fPMraCOO0kujLk7VAFYwgDqL1pYUux+/vaBKIpkonOLs23RNwq8egXXW6yt
         i30uHCrzQOX/Ilh4Qku3JXBw/I+iCEf14ZTiJUFLpxhCCJ/ThBDyzJ09WZmk86A2WD8f
         so+BUS59UJlzqcXvlLJ8x5XG76MPs087BPUMPPcJW+SKB71E7bskYBKYWUjbDAHEBPFH
         Co9IU2QjvHJpkZYk//FPrlXnlOaP9HmtMqPiz/VGn+a7EofrmEZpJyX5nDvjNI99IaEq
         QY7g==
X-Gm-Message-State: AOJu0YzR0sylyRnQlbSPRd7RA4YqjzNVO9m5tv2nQhPLBW32nuzGxn7f
	Zwyy3yo5qcUz4ydINx3Nm+O4dMBxdEKEKH2q9v0zuA==
X-Google-Smtp-Source: AGHT+IFS9q38qNC05FWOvuGddz0dZtKMTVO51+GtPFhIqBsh2fGBxuZjyfftEXs+9Ns+qhb9I+x35w==
X-Received: by 2002:a05:6a20:a103:b0:189:11e8:6237 with SMTP id q3-20020a056a20a10300b0018911e86237mr1090477pzk.51.1701618062280;
        Sun, 03 Dec 2023 07:41:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o10-20020a056a00214a00b006cbb40669b1sm6068710pfk.23.2023.12.03.07.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 07:41:01 -0800 (PST)
Message-ID: <656ca18d.050a0220.9d2cc.10d8@mx.google.com>
Date: Sun, 03 Dec 2023 07:41:01 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.65-53-gab9d7fb08abaf
Subject: stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.65-53-gab9d7fb08abaf)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.=
65-53-gab9d7fb08abaf)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.65-53-gab9d7fb08abaf/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.65-53-gab9d7fb08abaf
Git Commit: ab9d7fb08abaf2f6455d82c8d98d1e2e16804529
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
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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

