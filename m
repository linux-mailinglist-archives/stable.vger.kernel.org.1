Return-Path: <stable+bounces-6673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5795881212B
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 23:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501721C20EAC
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EB57FBCD;
	Wed, 13 Dec 2023 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="WoHZNJHb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C98A3
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 14:05:34 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cea0fd9b53so4852086b3a.1
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 14:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702505133; x=1703109933; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g/WuwXAfXM6D2w39esE6Us0fxgk+R5oEBLgZEF6f5WM=;
        b=WoHZNJHbJXNEdGQRU6LSHxWhk9MyFNAXiHor+6MzYssEjllKvHK8SlZWydlfcJBHB1
         H5ITDNHs0tCsNVxXil2BTtKIeQnDtOtvxdFDqnx2vdAv6ywwB3/zRboE8OQ1dmwXcrVC
         wXs40P1Th5C3nDr8O37IZ5KHfTELwF+rn3HxOI35FFDHsh8ZqBm1Nau3McVIuWYShoOH
         fJBQvYtQS0scORAC9Lag1D52szKpwYKDD9sYEkdOJxbMvfVK9oLponUnpaLhx3O+DYsJ
         mHoTwo41OcmXYeCb0ZQjMrOlOTKGN6hrcJ6Ti+HuIoHyvQg3k2tjdiUvNmyHj4iIvW95
         13wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702505133; x=1703109933;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/WuwXAfXM6D2w39esE6Us0fxgk+R5oEBLgZEF6f5WM=;
        b=P+lXZR+e3JyrE79NADGAjYgkkW9WVe721/6Vjl50/wWx8ZGEYkx60TNJwEID9gxeKl
         IV50iD029oHBNRRaSEVgX5exzG80YR0o0Rx0hHvD8mJx9aIW//a+UpfLst4vBya5ygeI
         sagmE4T4UKSMYD8st0emHWiGphE6TtVTSoffyjZ/obXCpiKAlZpsTQweZUKtBL57NXer
         BdtQvdG2YN8KIxKgTgpRn45QmYWhD1h6Ye8GCjSeTZpmBsX0++jGw6qUW1qMgP+VQI2Z
         FySXc+6q3oASHINkn4gLEVRaDExnZqjD0u2+AhbasYSeEqyP3eVB+IhnTRpLM90i5T9Y
         rkZA==
X-Gm-Message-State: AOJu0YzV4EnL4x+F+zDP0j84csL1JvUMEbxi0Fk9yLDL6uqq46LdEHEF
	czSpwp7FxE79mmnadF5EWBJHDFv3TxeSImSXrAaqYQ==
X-Google-Smtp-Source: AGHT+IF49+ehdjRyiyd2pz5nF9n0pSYn96d7WYKrwXirqXeFmPYNprH+eGT/vPvix1Vr9a2ONRSk3A==
X-Received: by 2002:a05:6a00:1909:b0:6ce:8387:e4dd with SMTP id y9-20020a056a00190900b006ce8387e4ddmr6064789pfi.32.1702505133227;
        Wed, 13 Dec 2023 14:05:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a000bc300b006cea17d08ebsm10425982pfu.120.2023.12.13.14.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:05:32 -0800 (PST)
Message-ID: <657a2aac.050a0220.666bb.0e46@mx.google.com>
Date: Wed, 13 Dec 2023 14:05:32 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.203-97-g284f46c131b10
Subject: stable-rc/queue/5.10 build: 18 builds: 0 failed, 18 passed,
 5 warnings (v5.10.203-97-g284f46c131b10)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 18 builds: 0 failed, 18 passed, 5 warnings (v5.=
10.203-97-g284f46c131b10)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.203-97-g284f46c131b10/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.203-97-g284f46c131b10
Git Commit: 284f46c131b1068cb8de6e74991ba286dc62a74b
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

