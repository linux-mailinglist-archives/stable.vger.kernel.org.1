Return-Path: <stable+bounces-5252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AC380C181
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 07:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8563A1C2094A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282201F60A;
	Mon, 11 Dec 2023 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SM7Hthqr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26BDD5
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 22:49:00 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d05199f34dso22933205ad.3
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 22:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702277340; x=1702882140; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lbKOuaLHJ5n5G6yv5Q/d5++mtnZFl8GUS8MbXNoUd2I=;
        b=SM7HthqrYaKD4w+tq/ZdKljD09200zxd66oyLQuR0E98TzxpI83AWQPSSjnV5A0vxx
         cGKwbIia5aBYimXpa+iTQPAYgV/a7+Nmw2TQwKDu4D2InUSLGc9dhqehz5Vg00CdTz+R
         kP7G76B11xSMMIPtOxfu0K6kTq5Qb+XQ5+q+K5V7tUwniIrjdAgL/kQ/VYBz9WbItg4x
         23r9PuSMcNS/LD68GidrP0bMfw0fYPtKnmpgVPikJCVvAGux8LzLbW0w7MqZ7HEbbnTF
         56GN9nMB9bQWZWLvfTTYQSreysyp/AWgVMa56sOridSslv048CZtIgiUCD6D8muYG8aY
         K4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702277340; x=1702882140;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbKOuaLHJ5n5G6yv5Q/d5++mtnZFl8GUS8MbXNoUd2I=;
        b=etdOKUiM+syRd/iRaiDiwhv22/5aOJ0NplZ7N0+bHMa6jSIXFe4ihw06TQRWXaQXPq
         Oy59s8VQF7i+QLuL3ZL/xIiI1H8TSioP/o3mMUCk/xMAh0bERqCMVMB6nXuxcgOp97c9
         cwIHIXDgIS9GNbA/ATteDOV5ZW8cy6899VBTB7/RqIRfJPs/9B5Mc3C23leVtYPdk/V9
         fJCzg5+61SXj1EbH1PZy7j4yWJ6FtOxEFDU6b66SEAh5JveskvQXea7LjWedkpS7uSTt
         xWg9okoQsWjiuaYQSvPwltz4ya2TZ7Y/jB+w1LfkUpPOX2kEvP/FFkimHMjfGWMe+sBg
         UwnA==
X-Gm-Message-State: AOJu0YydRw4kn+/+2WoJtavjnNozw8QPvaYbXhoqNCMvYKY0KO2vHTYH
	qY0La5OfsVPUuFsG6uvjXl1clOXFSQPKH0AsNOZCIQ==
X-Google-Smtp-Source: AGHT+IHy/MSnDNJDCqbq918r2B9pkBfVAUd92EgXBEOjroN6SVL78hGREGZe0JYTnQ7Uj/hWI1/TXw==
X-Received: by 2002:a17:903:2346:b0:1d0:b789:d7b8 with SMTP id c6-20020a170903234600b001d0b789d7b8mr1836825plh.9.1702277339848;
        Sun, 10 Dec 2023 22:48:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b001d07554254esm5836706plb.160.2023.12.10.22.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 22:48:59 -0800 (PST)
Message-ID: <6576b0db.170a0220.a13db.fd37@mx.google.com>
Date: Sun, 10 Dec 2023 22:48:59 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-165-g5921722632a98
Subject: stable-rc/queue/6.1 build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.66-165-g5921722632a98)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 19 builds: 0 failed, 19 passed, 1 warning (v6.1.=
66-165-g5921722632a98)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.66-165-g5921722632a98/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.66-165-g5921722632a98
Git Commit: 5921722632a9847bb0be4acec8f02106952f5189
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

