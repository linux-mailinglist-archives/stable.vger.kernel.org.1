Return-Path: <stable+bounces-6972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88248169D3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 10:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD302853F7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B52101F0;
	Mon, 18 Dec 2023 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="C/G1xKlB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B6111C92
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3c1a0d91eso915745ad.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702891551; x=1703496351; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+i+lb8IxVri/t54EoeCmcDMZPCUzwYhDHK+QMBPdanw=;
        b=C/G1xKlBFy/p35Q8mwCHfx2atrRB7Uz/s9vSCR4z+63Hm+IaGOSZ9krVSzN5D2eDQ9
         8uW/wvAeiSsvkqqBhhxcta3csPKkFgQhwJGtpjcu6e0WhG00WTqGOa8ltOEj+yuum/SI
         Yixn8jR2S8enGm3AcZ4NcjZRaEe31E7jWjmSKx2WIhTSQOxVIXzW9843FYZnlxVC/NoB
         S+WPuPKs3bFxLOWXhJCzHL88Xm/7Mje5QL8BIEDzhhsKWwydDuPOlUSBCx66MWB+9X0C
         SjCP9W4nrIviYrmCNRm6Rod9KPocUUJa5SlC7RWONeFtmg3JWl3bbOj5zeCHC0pcdrIO
         QGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702891551; x=1703496351;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+i+lb8IxVri/t54EoeCmcDMZPCUzwYhDHK+QMBPdanw=;
        b=ZFCJtWeN5AxH8UtyGhB2lW2BsKaEbWRPwyySMTcy2Q/MTRbmnLinxeco1+33V91v0m
         zeyTTCb8g5DnD8Jrq48HHCT1bOXBdYvamE/ee+pV7qejfr1SPLws5yh2F1KSIVxT1va3
         x98J2fJEsQhThbJiM7uoVArqOGvcjAkHPUGY5k/t7U1GIwu/XUSQHLVHIVwmGbMssH7D
         V9hY0Qv0QsDlGFuFS+/vMmSJ63CMHyO4jmtrjpnhI3hGYvU7pJAvfMfzC3NBl5ZJMKj4
         tfTsvmykfP/vnZhPCFnFoQ0rlm702vk+n7uQJyusN60si90Ke+lAmNSUePA9gePH9Tm7
         3aHA==
X-Gm-Message-State: AOJu0YzlAuIjMcJdFywv01MpY7oh1xPJg1ao3g6NuMEySVoBC+MXN/gv
	GeJCDIaFR+GW6lQmcJFlvPbrj1rdWQo47BIdTsI=
X-Google-Smtp-Source: AGHT+IHepXLq4KsK67EMsjQhm7m3n18c8nwLZW/PLDR9NYWt5ZlIcJd/TXwx0gvXccmch3XL9XSGPg==
X-Received: by 2002:a17:902:f682:b0:1d3:bb5b:c38 with SMTP id l2-20020a170902f68200b001d3bb5b0c38mr334989plg.46.1702891551020;
        Mon, 18 Dec 2023 01:25:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902704800b001d0c09cc6ebsm18599748plt.92.2023.12.18.01.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:25:50 -0800 (PST)
Message-ID: <6580101e.170a0220.30cf6.76da@mx.google.com>
Date: Mon, 18 Dec 2023 01:25:50 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-66-g147920d742a6c
Subject: stable-rc/queue/5.10 build: 19 builds: 3 failed, 16 passed, 3 errors,
 11 warnings (v5.10.204-66-g147920d742a6c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 3 failed, 16 passed, 3 errors, 11 wa=
rnings (v5.10.204-66-g147920d742a6c)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.204-66-g147920d742a6c/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.204-66-g147920d742a6c
Git Commit: 147920d742a6ce19f0764993a21f5bfa60c080eb
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

