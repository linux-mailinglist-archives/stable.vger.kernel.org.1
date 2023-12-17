Return-Path: <stable+bounces-6926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F698816225
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 21:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DC61C2121D
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D535F0D;
	Sun, 17 Dec 2023 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KOiiFB+F"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB8481C0
	for <stable@vger.kernel.org>; Sun, 17 Dec 2023 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6da579e6858so1607967a34.3
        for <stable@vger.kernel.org>; Sun, 17 Dec 2023 12:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702845862; x=1703450662; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PXVF1zhJ9VZ9exrKsukMUSZ51MK3VzVEgd10zII9k8k=;
        b=KOiiFB+FGOmriUG2HUQpuiEr9PiukgqRH4p4+X8D7Cpvsx8pwaHYRuvJ+FuQ9uGW/5
         FY4x/9qWZQ0BJPlYo71fCpcyW/5Tpza+mhre7cz36tshwCylArR2u/bFbzmUYq4n0zlX
         xWUzY4rSTY68eyW0ppDovI/cAzsCMe5cXNfhAeJNwDS+D/BR5CaA2SkRmnY0fuGJBbjv
         +T4qwgFXj0xTX94CYqkEqjRdyQs86Hd0DOvPEQ0c8jVtktuPojla3RRnfQzOBc6u3Sdi
         T0dNKjcB7EwpYv6JalP5vAO94LOH8OH2Rq+yVWyjaZOYvTKTzuTWqRAy1TnkvON2RuRI
         XFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702845862; x=1703450662;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXVF1zhJ9VZ9exrKsukMUSZ51MK3VzVEgd10zII9k8k=;
        b=XN5kS/Ylnc47OsTlKkdnZHlsGiydwWw/m8wNwHUWK9j8+IqtCdKyRWlWRdsrlxRwEj
         StM673B03C0mtmz5tEYNzxqjC4U69A6EFkFXLP2igjZh8ZZl9BcgAFEng2HP3vidIUBQ
         v+Zcs0uwfu7YDNrc8qVvaOqpiOSXHiWRlLxiNWy002hc56Enp1Oh5T3ytUmKM5YWwfyq
         50nvcUAD4uzpYvs9zd/siN1Nr6d90OUflD++YvtUKQriChOBLAK4kOhB0Ik8pxlVzbMX
         9hvjk0BRzkFu4pBPtM93vUS3rt0uP+YcXJFg4/i0a8NgsbC3GM97yPz4jxPfEJEAeyJ8
         mOCw==
X-Gm-Message-State: AOJu0Yz+5RLNAXKZmu1Jt/4Kkn5L0aJt8mYaFnV6gBWVyl9+5/HsHdUQ
	2eLmohQwWswNFh8qR4CeuB0XcZ+HbzBwB4MPRl0=
X-Google-Smtp-Source: AGHT+IFQxHrrlg6odFz9EuVORk98dp4WfAfsSwQbylUdte+t8aKz9xZwJolRrTpuSbASjDUnB7aqCw==
X-Received: by 2002:a05:6830:1282:b0:6da:6a31:fd08 with SMTP id z2-20020a056830128200b006da6a31fd08mr766657otp.73.1702845862509;
        Sun, 17 Dec 2023 12:44:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t22-20020a056a0021d600b006d6015297d4sm1232037pfj.49.2023.12.17.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 12:44:22 -0800 (PST)
Message-ID: <657f5da6.050a0220.1095.2593@mx.google.com>
Date: Sun, 17 Dec 2023 12:44:22 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-56-g66e9372e76961
Subject: stable-rc/queue/5.10 build: 19 builds: 3 failed, 16 passed, 3 errors,
 11 warnings (v5.10.204-56-g66e9372e76961)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 3 failed, 16 passed, 3 errors, 11 wa=
rnings (v5.10.204-56-g66e9372e76961)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.204-56-g66e9372e76961/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.204-56-g66e9372e76961
Git Commit: 66e9372e7696129bb675a1b93821e3594f96ca0b
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

