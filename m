Return-Path: <stable+bounces-7621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938CB8173AF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D54E281C2E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DE01D144;
	Mon, 18 Dec 2023 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="CiQuAEK5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34EB372
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3cfb1568eso3029535ad.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 06:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702910127; x=1703514927; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zx+IBGslEomqJb2HRxOHcfB2iHRAkjQ/uJpjXlIwcxI=;
        b=CiQuAEK5QxekQts23mO/Y+P37HRW36P4YI7r2aga6e47OomItcgYK3d0Ze9D9z4cCB
         DimL4mUTggk49+4lYTUMIRaFDL3djU+/9DXxZ8j0pVmYQh/ewu7V+ozEazPoN2qFIZX7
         RhRmBf602jQBDW+hfVsoSqtDeiCm1Y5tN7nekdRiYL3T9b1ooa6DRz2aIi4IZEE6GZoN
         QTiudOXkNyFnUOdhoF2G+xXMCLsT5y8BXE3fHvh0Qld0hRyKg6ASNjwsEqYo57l2MkdQ
         pdwkEQK3ROVK3w1cORuswvpf1dSyjSF2BzQA3DZjt7FdjC5+Iu/RaXJ1Eur3AWb5fv4z
         +c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910127; x=1703514927;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zx+IBGslEomqJb2HRxOHcfB2iHRAkjQ/uJpjXlIwcxI=;
        b=Wa1I3LxhbsRV5hpmD4oMSOmwyO6ipg5YD7BzB5P8MfULBhlXHgbFb+YAkolHki2C2y
         b16KogL2GRVdsVhyuUq9bxBuix76J3gSrioBUh8qdjvgf54pPBZNy/Grz3qvRf6F5z5R
         NPkfE1WW3eSe6gB3TyQ4987jdCdji2lznMjbl8DavXglEFXMdsEqlMT7iUPJEW1XHZij
         34EaRxQPKUpkhwhR1fI0wp55rdNjhJJnaN3dLmNEiThv0n9xrn7IIDh4iHe7mX/HuQ82
         V16VUQRjcbVyfEhjA8OhKu/vJ4PKChtGo3VLmIdQ32qJAeoohzUu5zF2Rmpb/QiHpWpT
         qC1w==
X-Gm-Message-State: AOJu0Yw2chNEpQvL2+R5tvIgLc1dRTMUhjXQw6OTk4vB77XQtaLi8yFP
	7iD8WfryUurEGPzXdUJb45HFWlmiNohsTn/ChF4=
X-Google-Smtp-Source: AGHT+IGYvng06NHU1zYZ+BvFzECfZz5ZmwpMfYy4RGZ7/2XBXjoJHD6lh+JC4nFyAM/2y2iYjiUU9A==
X-Received: by 2002:a17:903:22cd:b0:1d3:c08d:ba9d with SMTP id y13-20020a17090322cd00b001d3c08dba9dmr1572746plg.68.1702910127571;
        Mon, 18 Dec 2023 06:35:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001d08e08003esm19149133plx.174.2023.12.18.06.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:35:27 -0800 (PST)
Message-ID: <658058af.170a0220.1ccc6.9171@mx.google.com>
Date: Mon, 18 Dec 2023 06:35:27 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-62-gd1ec28a08d6ea
Subject: stable-rc/queue/5.10 build: 19 builds: 3 failed, 16 passed, 3 errors,
 11 warnings (v5.10.204-62-gd1ec28a08d6ea)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 3 failed, 16 passed, 3 errors, 11 wa=
rnings (v5.10.204-62-gd1ec28a08d6ea)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.204-62-gd1ec28a08d6ea/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.204-62-gd1ec28a08d6ea
Git Commit: d1ec28a08d6ea016241f2ce60f801546b75de141
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig: (gcc-10) FAIL
    defconfig+arm64-chromebook: (gcc-10) FAIL

arm:
    multi_v7_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 1 error, 2 warnings
    defconfig+arm64-chromebook (gcc-10): 1 error, 2 warnings

arm:
    multi_v7_defconfig (gcc-10): 1 error, 2 warnings

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    rv32_defconfig (gcc-10): 4 warnings

x86_64:

Errors summary:

    3    drivers/gpu/drm/sun4i/sun4i_crtc.c:63:37: error: implicit declarat=
ion of function =E2=80=98drm_atomic_get_old_crtc_state=E2=80=99 [-Werror=3D=
implicit-function-declaration]

Warnings summary:

    3    drivers/gpu/drm/sun4i/sun4i_crtc.c:63:37: warning: initialization =
of =E2=80=98struct drm_crtc_state *=E2=80=99 from =E2=80=98int=E2=80=99 mak=
es pointer from integer without a cast [-Wint-conversion]
    3    cc1: some warnings being treated as errors
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
defconfig (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 section mi=
smatches

Errors:
    drivers/gpu/drm/sun4i/sun4i_crtc.c:63:37: error: implicit declaration o=
f function =E2=80=98drm_atomic_get_old_crtc_state=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]

Warnings:
    drivers/gpu/drm/sun4i/sun4i_crtc.c:63:37: warning: initialization of =
=E2=80=98struct drm_crtc_state *=E2=80=99 from =E2=80=98int=E2=80=99 makes =
pointer from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 2 warni=
ngs, 0 section mismatches

Errors:
    drivers/gpu/drm/sun4i/sun4i_crtc.c:63:37: error: implicit declaration o=
f function =E2=80=98drm_atomic_get_old_crtc_state=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]

Warnings:
    drivers/gpu/drm/sun4i/sun4i_crtc.c:63:37: warning: initialization of =
=E2=80=98struct drm_crtc_state *=E2=80=99 from =E2=80=98int=E2=80=99 makes =
pointer from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 sec=
tion mismatches

Errors:
    drivers/gpu/drm/sun4i/sun4i_crtc.c:63:37: error: implicit declaration o=
f function =E2=80=98drm_atomic_get_old_crtc_state=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]

Warnings:
    drivers/gpu/drm/sun4i/sun4i_crtc.c:63:37: warning: initialization of =
=E2=80=98struct drm_crtc_state *=E2=80=99 from =E2=80=98int=E2=80=99 makes =
pointer from integer without a cast [-Wint-conversion]
    cc1: some warnings being treated as errors

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

