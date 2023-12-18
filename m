Return-Path: <stable+bounces-7793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0F281775B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 17:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8CC1C25A9A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7CC4239F;
	Mon, 18 Dec 2023 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="VxgsF7ty"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A23F519
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3cfb1568eso4371795ad.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 08:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702916617; x=1703521417; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jzEVxoM9RzTu8hbgHI8sTwflcaI3H2H+LvzpxT+pa3o=;
        b=VxgsF7tyS8BzR1NwjSHUF3pvw4edCwxo0HD3/IISRqtfxCo6mzlIVLEiDhqRMKvLPF
         WSer8V7fYKmTr5dcop2qWO3kfn121IbkXcY7DtEc1v90tAFSHmdjyM1Hmk1Tlp5Qg1UC
         CPnPWPrd/Q0hCjl+T2ExzCkcU8+L5DBv85xqYvzQPsnlRLbIDX2oF0YuU9Ncltnturqt
         Rc2a0/mCgRmiLDpubdam2sFJVejfXGV62EM7XhFRD7WLvvwH8tAjSBDbBZu/tFb/K0Tq
         XP68T5dChpuGqD2CBW7SlNQNJDWvazvoX138Sg1mmIF29bL4AvBT3OwofBhbS+3EWPLl
         Yklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702916617; x=1703521417;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzEVxoM9RzTu8hbgHI8sTwflcaI3H2H+LvzpxT+pa3o=;
        b=hHliJsEmHtXse6Qq7O70utREluKaC0pKTK+q0QS+UUhY+pmL01QDVeaFIrCqr8OqOv
         nQxZzv2/s0L3qDSphPHS/LEzJthj2sZ2FceFc5C/uVkuwpBN9Sy7NIr9PB8HwprhnCPD
         sr3TTOwncwoufNweTXItHugmCT8Xmn21XnsWd0Rw04FfZpjYH15Dqy6A2W+s4WbI4irJ
         xCJJlpBg7PeJId0Ufad6y+8GOZH0Y6aOJOYoqMs6W/6X66A311523uoAyuiIxHtSO+cw
         kr+y7DCeCs2qZIGlIrcNS3+pOguXoE+AHB7nTFo2i1EDsUhhpatemD1cXJFkpuJXCtzM
         Wj3A==
X-Gm-Message-State: AOJu0YywVNlnYBlAYLfF4bzSR67QHhi1Kyje3B5106MKmQQiCZJTEGp1
	FFjacqxGoMm5mTO0cI7Yna6kE0Y6BeGiUCCCRvM=
X-Google-Smtp-Source: AGHT+IEO4OvbafuCLWSIFCpaFDugYMp8HLM2qKWJDlxlHcflJFJxK3JXuVDUkxes+PY4FmfWFI9DQg==
X-Received: by 2002:a17:903:41d1:b0:1d3:d81c:795e with SMTP id u17-20020a17090341d100b001d3d81c795emr94927ple.106.1702916616928;
        Mon, 18 Dec 2023 08:23:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a1a1100b0028b6e4ecc9asm3450302pjk.52.2023.12.18.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:23:36 -0800 (PST)
Message-ID: <65807208.170a0220.76b56.8509@mx.google.com>
Date: Mon, 18 Dec 2023 08:23:36 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-63-g17eb2653990e3
Subject: stable-rc/linux-5.10.y build: 19 builds: 3 failed, 16 passed, 3 errors,
 11 warnings (v5.10.204-63-g17eb2653990e3)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y build: 19 builds: 3 failed, 16 passed, 3 errors, 11 =
warnings (v5.10.204-63-g17eb2653990e3)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.204-63-g17eb2653990e3/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.204-63-g17eb2653990e3
Git Commit: 17eb2653990e369bcef47f69a554147997ac4dd3
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

