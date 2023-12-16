Return-Path: <stable+bounces-6871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9FF815832
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 08:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC371F21B06
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA2C134C0;
	Sat, 16 Dec 2023 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="VrEQ+DAK"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD9134C4
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35fa12d0c29so665325ab.3
        for <stable@vger.kernel.org>; Fri, 15 Dec 2023 23:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702710506; x=1703315306; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jOcdGyyRvmxL3XzxONsXXtSP9tgdvVEDEDzN1UQmeqs=;
        b=VrEQ+DAKSmLfaIeXyK13ERYIChly0rHt9E1q8EXk+8++VWsBjQsdMwLfY2D42JJWaF
         ebB7iChkPGKlADKEE+kbBfQQvZ1+UwhUnTWtVG8pt8OXGLwKxw4XXwk99EIwZ17u1knb
         FZj7d1+WI40idtZ3MiK9Dyd5lwP4RMq7UuxMmkn9RAFeNr0/aUTjq6PoGijvW7VqGQo7
         qpxPBQKMEciiHgg9IMsuYlz3c5opIQBlzPE03Aso2PrYYyPWQ+qMSmgD4AvUtLMJINcn
         qWsDO5dYA9KdRZmnZT91WFDwtQ1q9hAccb9woXRELnhGjTSoE/7ZuX3MVhRJp8ydMYzJ
         FtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702710506; x=1703315306;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOcdGyyRvmxL3XzxONsXXtSP9tgdvVEDEDzN1UQmeqs=;
        b=t2tiINKYgerqs+sTKUsvRCQBATd9UckJDDNL7plIQ54tUizXED9NfQaRd047QHFwSe
         csMidMx7ASzJYPWrbvqmYOt/Frg8KydZpv6/wzVS0//fY+3pC9ukCg5x2LpiwXWB1rzH
         Gwq8vr7xhXwjvwapfFH5ZRdsvRBcSXzIGKz0cn+1sZM+NUz7aAs3p0iGaQ3y9Ug5Hh5C
         Kvip1643RTeN6KHtBTqdBDUhiV9Kr6GHa8o63g74rctTVV+qY7gScaaA4jMB/9x8CVOf
         r5wXLCANREc3hY7h2P7Vw+Utjqky3IdPbcmVLcmuc+c6pCkPcFnmNLd1guyeINlYAyoC
         CdjA==
X-Gm-Message-State: AOJu0YwzE1/UtvYq6ZmJeunO31Sa6Pm1wflQl+zklDIUov6Xwg6tAV+q
	XqPCXdUyaPw+oWI8DH7woCVStXsJ/hXbSIbbJ3o=
X-Google-Smtp-Source: AGHT+IHVSE3dhIhqZ6NKzHLyrK+6yn+7dt1qXfhZJYvw6ZvhizJ8o2bZpgt3OB8KsotnoufUA8vxkw==
X-Received: by 2002:a05:6e02:154c:b0:35f:8014:4b7b with SMTP id j12-20020a056e02154c00b0035f80144b7bmr5842674ilu.21.1702710505982;
        Fri, 15 Dec 2023 23:08:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001d043588122sm15279249plh.142.2023.12.15.23.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 23:08:25 -0800 (PST)
Message-ID: <657d4ce9.170a0220.eae17.fc15@mx.google.com>
Date: Fri, 15 Dec 2023 23:08:25 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-33-g1ff0e69a5e9be
Subject: stable-rc/queue/5.10 build: 18 builds: 0 failed, 18 passed,
 5 warnings (v5.10.204-33-g1ff0e69a5e9be)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 18 builds: 0 failed, 18 passed, 5 warnings (v5.=
10.204-33-g1ff0e69a5e9be)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.204-33-g1ff0e69a5e9be/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.204-33-g1ff0e69a5e9be
Git Commit: 1ff0e69a5e9bee56f32bbbbec8c916c63579f7a6
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

