Return-Path: <stable+bounces-6388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38E980E258
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 03:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55539B213F4
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 02:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAAA4436;
	Tue, 12 Dec 2023 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="didVXY2Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE93B0
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 18:51:52 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35d725ac060so23633455ab.2
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 18:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702349511; x=1702954311; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T3yOwhxR5mbKko6tXtZllkyK3w/uG/fAcCivbnau6ds=;
        b=didVXY2QTLEsNDMX2s9QH7hyMG76OhAvBpVyd93aLfEu2wHJCxv75vGhSqaPbSRHkp
         h6Th7MHv3n6j14zv8/mRzA4h0yI90qhfLJVPvuaxot1fIqJruS7LXizcHkRdmi5lbJzk
         9ZAzAa7JdcqRQX7VeoyrzQRX/7Smsk+uWIWxZGxxtQQeabGn7tRggqCdf8p24/QBBG6N
         Oojc0/XNiBd/juJ8RbOwyRMeN8f1DLJXxMzPKJkCESEf7Ml/DJYgu8QN1uABcpFUr0f5
         0/mdRwSe4fRuasLaymO2y9iZdC1JbZXAUKSMcnxkTBDj+6nmTBBVVxbea3QfJCX3W1qT
         E3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702349511; x=1702954311;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3yOwhxR5mbKko6tXtZllkyK3w/uG/fAcCivbnau6ds=;
        b=rm77kC7OuoJqrA3cxJEH3fq0q0gKHK25V+YWiDtrBVBLeT74yTIkceGz1WtbwYYS80
         n+Z+tuwcFM2kFChhEktsCBvTSXx73B0HCV6xhYKkIML/DTGWiyjDudrT5C0MSxMLEzc1
         s4YXbGW4LVg6aZ+2PP6KJw+e2ng8ENOVq9qRG3Vx2OawaTgMyxz88yDtyYtlN1fFhcBF
         C2571vi792FVKk6EZwLXNlMeN8GqwN0VgegywI0Ejm7Q3z1DtDL827nkKlwWbrXnQidZ
         foa/4jaSkF+ISV1l0YdALubrTPD8eo76Koyj6KrG2QNZsT9+wvviwwYd4GQPHZYEMMOD
         TXkQ==
X-Gm-Message-State: AOJu0YxU2KtxM+WVBMq1HouZcQ+7YO7w3go8w1TD2f0f/NIiJkUeCfj0
	YP6uLuRd8AUmaiPJhr7i3osW7NgSYz/Q+jALaaOtuw==
X-Google-Smtp-Source: AGHT+IHUJr6hKGwPr+ss2WF2a47R60yeNpvrrITfPXL/QCSb0mZ4nvo6SeicsSI1Okh4ewr1fdJlwg==
X-Received: by 2002:a05:6e02:1685:b0:35d:5ff1:7842 with SMTP id f5-20020a056e02168500b0035d5ff17842mr10043972ila.53.1702349511177;
        Mon, 11 Dec 2023 18:51:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b001cfd66f31b1sm7412055plx.167.2023.12.11.18.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:51:50 -0800 (PST)
Message-ID: <6577cac6.170a0220.291c4.63cd@mx.google.com>
Date: Mon, 11 Dec 2023 18:51:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.203-97-gf29fb63a5a8b3
Subject: stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.203-97-gf29fb63a5a8b3)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed, 5 warnings (v5.=
10.203-97-gf29fb63a5a8b3)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.203-97-gf29fb63a5a8b3/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.203-97-gf29fb63a5a8b3
Git Commit: f29fb63a5a8b3b8a5e2f77a6ad6b2f6c60f78b5b
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
    rv32_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    2    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]
    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

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
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sect=
ion mismatches

Warnings:
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]

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

