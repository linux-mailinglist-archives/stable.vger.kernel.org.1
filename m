Return-Path: <stable+bounces-6970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A11E8168DB
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 09:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B021F22ED5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB7F1094F;
	Mon, 18 Dec 2023 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="yh3OyGQU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DDD1118B
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3ac28ae81so8602975ad.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 00:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702889724; x=1703494524; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ulInoqqZ8B0REhG2npl6ThGdYgMabBl1++tyzhqbVE=;
        b=yh3OyGQUCth0rxuO4UKBoxzScHg3qixZzoroBGTItqhbDCm/BcCKJxm1Rn2XzP3+Oi
         JQGExjbRpF9RzJqN6gTofvg6ycWelayOqpb8kaAwJRJWvmT6d42Vc4RssjoNgEEiGYm4
         Chh4IAXsLHBy/ao54jRdOCVX829mQmCU9PsTqnYXUbZGXPkVQWc2KkAPID51sLMAbvnl
         De3o1Kgvs4VSHucMgVH7dEUq7Dt4cd/0TW0/bpvTpbaOri3CJkjn7mnb3xUglePoRkmm
         JLoqpFbJDGOHQGjkBaIu1mDpuBnNTy9fFmmtxDeS6M/EAkg3Y6gCOF77/RAO+RZqEJLs
         rIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702889724; x=1703494524;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ulInoqqZ8B0REhG2npl6ThGdYgMabBl1++tyzhqbVE=;
        b=j0ZtXSUKCvsiU3olNLKwMgMMjNeVFE3MR1OYrV4LYjy+/nRh/g8hLaJISPeIOMLXUP
         S6zsIzP4053NeK0fraEserlY9LqbM3hRkLXZ7wWFgt+BpExDwiTO24u96IRoVOTR+GZc
         bNUQZ4HStOoM1NahHGe7p0mwiXwo/Wap1136xXft88SsZDxcsPxdGtEbciBiIgUWkSPK
         RtZJTkwrF0qm+4GtzhrghiiAopY/8cdCebb5twQqez6P77Z8iqnZTuAdBD03H66Wp+WZ
         oYjV0e8HhVLxbxGLiByexnbpKvnUvsEZA0FJ8wx/7Le+NVMNmP9cnv0olxULCIa5TLRT
         ZVKQ==
X-Gm-Message-State: AOJu0Yz+rZKehuNW/8atnfifry/ahhvkNQoMhrHIXT7/sssq5wq1iJzC
	BSQHCWS3CQR8wwugPHps1lOG/q+CclMENvDULZ8=
X-Google-Smtp-Source: AGHT+IHXHjVI/DNsz5gO9RnG0kIZDXbpEGwHtv9wkJCbL2rH7bzfMW6FxIkGvXlqHbwfpT3KIcpy2w==
X-Received: by 2002:a17:90a:bf0f:b0:28b:831f:187 with SMTP id c15-20020a17090abf0f00b0028b831f0187mr606053pjs.19.1702889724346;
        Mon, 18 Dec 2023 00:55:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ml22-20020a17090b361600b0028699a25207sm2074845pjb.12.2023.12.18.00.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:55:23 -0800 (PST)
Message-ID: <658008fb.170a0220.39800.4198@mx.google.com>
Date: Mon, 18 Dec 2023 00:55:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.204-60-ga2fe278fb3ec2
Subject: stable-rc/linux-5.10.y build: 19 builds: 3 failed, 16 passed, 3 errors,
 11 warnings (v5.10.204-60-ga2fe278fb3ec2)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y build: 19 builds: 3 failed, 16 passed, 3 errors, 11 =
warnings (v5.10.204-60-ga2fe278fb3ec2)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.204-60-ga2fe278fb3ec2/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.204-60-ga2fe278fb3ec2
Git Commit: a2fe278fb3ec2561efa4d3aabcd9e393e192f8fb
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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

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

