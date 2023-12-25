Return-Path: <stable+bounces-8439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AE681DE2B
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 06:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C901C21003
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 05:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6AED3;
	Mon, 25 Dec 2023 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="CWSQvCJl"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314F23B0
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35fe456b94cso13104575ab.3
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 21:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703481703; x=1704086503; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=12EwQCRwY8MPoXnd0+/Olhs/HRyGXajScaXeZW57Vs0=;
        b=CWSQvCJlLM491jNsTpjTf7yADRAIPCaJ2S+kMUp5ueV5IF6JSMNPy1Nhqz1rKkOVLV
         J4g3i/lH769uLAzzVhsAwGIbssGKsX48w6zXKpMTslwZFKfX8Xpqt2yyvBx4F4NXQ0+k
         Imuu9kq/TkLJfQB1BQp34UxlDQENMM/Z5WiKJA4qTzeHbKA9o9etBz5OB0D+y9/4PyTc
         M7+qD+03LRx1yRRMO7BR1CULqZt23KPy5Y41OCWFMSWe1OaKjFLSPWaMHLiMZ9JGEmHm
         SzzzhK2hse+V5WR8+4JYWZHY1IsBch7xWrhHPmeYy4nJZUkVOx0SmqwLdFSEkQT1qbTf
         NhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703481703; x=1704086503;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12EwQCRwY8MPoXnd0+/Olhs/HRyGXajScaXeZW57Vs0=;
        b=htoxGVjr5IpGkKpyzOnvSKCFs9iJ0V0X6AoRL280UY6bYS9wzSUy4T87OE/VhmVAFt
         qZwVqlT8IHzQVCtITof/dTLc5MfvPZN0sgk67QX61tb3AxGm6hWZmmPt/IdmN1vAqXtM
         nCx2kG1dWpcBno+4zdx3Ua5A8nH5NE3GWKyyMrfaeaXmHs0+z6tdGjiffZMTSRcAaLBa
         xJ+RVK9VqredZ26efLUxcwDSSNEkfN272eN6zE7b2DJKocYRWg9XoA6EIjG2LbDOlDDP
         eJQAq1gcyAL9qJI+nAT9AN3o1MN/2VzcyN/dzml0quBgykLR17QUy7+yIX3bneWb5YPT
         pQmg==
X-Gm-Message-State: AOJu0Yz+ccW3Kob+1ssz4XtM+KK62plPU1jhitOR5rIPvj43+Rr82nej
	+/rVm3QEFyg5tZ/ec4qnUruzgRNKoJd84U2BZVlKUYqy0ws=
X-Google-Smtp-Source: AGHT+IFvdiyjMv24ykVn2ph1Arz7zyxK812WJnEXCk/Fp10X+LLn86SJV3CwCPJWB8jBKqSscZmxwA==
X-Received: by 2002:a05:6e02:2146:b0:360:c2:2840 with SMTP id d6-20020a056e02214600b0036000c22840mr1325053ilv.11.1703481702732;
        Sun, 24 Dec 2023 21:21:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902b60800b001cf65844874sm7348847pls.45.2023.12.24.21.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 21:21:42 -0800 (PST)
Message-ID: <65891166.170a0220.7f879.37b2@mx.google.com>
Date: Sun, 24 Dec 2023 21:21:42 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-92-g6d473b4ebbfa1
Subject: stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.204-92-g6d473b4ebbfa1)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed, 5 warnings (v5.=
10.204-92-g6d473b4ebbfa1)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.204-92-g6d473b4ebbfa1/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.204-92-g6d473b4ebbfa1
Git Commit: 6d473b4ebbfa146bcb84fb8695675526dde5af82
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

