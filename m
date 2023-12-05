Return-Path: <stable+bounces-4699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0FD8058ED
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F81281C39
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CFE5F1E5;
	Tue,  5 Dec 2023 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="t6wDn2DV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1ED1A2
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 07:39:15 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ce3df4c282so1927889b3a.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 07:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701790754; x=1702395554; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g2GCJmXodMd650coFxHDCI4njdIDvYe5v38HGJZIWGY=;
        b=t6wDn2DVKOhKNrIlj3nnlm9geAC0rDuzDd9cUPvTBtmUO9RV6ox1DUnIIUjsnC79bG
         j3b8N2tmfCiCrBYQKHKkR0hNqZ5nFOUeY16s6PsDEhUa+Pcu+w2AtLNgmtPXGOOQhh9R
         fxrO/klNh2BuGStL12oFk7dOZSYsKS7sasbDMc3TdNKSh2jRPEjO7blp2hatRim52NAe
         Ji6BkWyJShTJButJSbUMECNJ2gRFUjhAci867okpERG1pB1Wx21+QK7UTcNrjjImpPpD
         ZcHzH4eAhGv3UNKcuBmM7OYDjOitp21ZHddIsea2SCYF2PE8BoOxoGIJgu8YNhtAS5Bo
         KOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790754; x=1702395554;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2GCJmXodMd650coFxHDCI4njdIDvYe5v38HGJZIWGY=;
        b=A12G2Bkms9Q2A55pyerHXFiPtkswD12oxas+D6P+RCS9tqVxihWNwntqZYLE1RKsjd
         sgUnAl3pcv/GYE800EG6IcbbupmoUIqs3RxtoqwlWo9BTWGHtwqaq5ixBMETjF7nBG/y
         kMypJ/xP2JLpC65Uf2TdUXlDNG/Xk5R/TpVklIqLVRg1u24buvJmQTyP5Qfb3MA05Gxv
         HA4zNpklJmRaU2jHgkl+GAV91PFOR1iommlqoVhUlsnYxgrSkUnSdNq6LoPWm+CcM9Pu
         dUDh/PhRcZgmXCS/ywkHYZvlBCbo0XeNthfBsyDqKLO+qKl9UP1THVdCMikEEUIfXMUX
         X3aA==
X-Gm-Message-State: AOJu0YyEBdB8aA/PZCb6wBOYQxAHV78eFg9tn62BSvf89gQkKfkicSDC
	kXAdF/5xdswAjt0qTAwGGycYllyLK1CBI9vWu634cg==
X-Google-Smtp-Source: AGHT+IGvPYwNXP88YVU9fjJD43XTAhQj7BA1B/sw+HTYUd/Z4aog3IneT9KewsBgcHTuiUxHXD//Yw==
X-Received: by 2002:a05:6a00:8d96:b0:6cd:9033:b3d0 with SMTP id im22-20020a056a008d9600b006cd9033b3d0mr1322422pfb.28.1701790754595;
        Tue, 05 Dec 2023 07:39:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z123-20020a636581000000b005b458aa0541sm9261802pgb.15.2023.12.05.07.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:39:14 -0800 (PST)
Message-ID: <656f4422.630a0220.fe5e8.a6df@mx.google.com>
Date: Tue, 05 Dec 2023 07:39:14 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-134-gb8afb76acc05
Subject: stable-rc/queue/5.10 build: 18 builds: 0 failed, 18 passed,
 5 warnings (v5.10.202-134-gb8afb76acc05)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 18 builds: 0 failed, 18 passed, 5 warnings (v5.=
10.202-134-gb8afb76acc05)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.202-134-gb8afb76acc05/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.202-134-gb8afb76acc05
Git Commit: b8afb76acc05bf9e983382e534fb58e7a85ab79a
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

