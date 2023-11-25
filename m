Return-Path: <stable+bounces-2641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E07F8F71
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 22:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4191C20BCC
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81430D14;
	Sat, 25 Nov 2023 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="dCLXn0hN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406BEEA
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 13:23:45 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfae5ca719so8417545ad.0
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700947424; x=1701552224; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XKvmktErUAyG5uDQichn36kSqIif3BbDwr4UAPJN1yI=;
        b=dCLXn0hNd9Tnh8hPH9rXNFIK86+T+rCu0Jwq9e+N/k5JvEnPGvySnWFxqS4hw6vNUL
         YgX/2ktpk2kWd8qt7DUStsBn1j9N+pEZvDdFtxZnPLLGwNBo8Xn74Ox2yDmCmQSPlx5G
         C2qNZsl5UJsf0l69rrp7hr3ZjunNmFgo3/0dd3SQgYnHZN4JdguZClYRDYBgdYsRIHqT
         HjK4z+b4AT3BxkzXGt/vNHP9qDrwH98aUHsNeo3Zq40wLzaq1YsIy1R5wDlbHQL14K5g
         mBM7LOdP1b9orgt47bVY57YZP0j1fq/P4cLwgiWAEYRnNeCuzq4hmWDzGFuq/LAMu9jq
         H+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700947424; x=1701552224;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKvmktErUAyG5uDQichn36kSqIif3BbDwr4UAPJN1yI=;
        b=HZQBo4SR9HGxcPK+ruItSIkibJeyuzYmzmEXzP20kQV27IBKTG6zK5KOK1jdzu3bQT
         HVl9gkduWKEKskkBZFCY/ipjT18nl5inK+USln3M8JqRuQ4+rld5+7vVGM9Bft021h4V
         rd5YE/JE0NW0/2bPpebIN/YVoa09rFIpp8PwsYXWRakdDa0v0aiXQfuqKOXOuwr8oN5l
         QVaApGkEnfj8X+1XTrQpuxl0qG+DRUA9D4E+ACTnF6ks7Gy/rlVTJ/scxzSqmVbBzswO
         wKEZPC5hJfOn9Xo7z/Bh2dOowfipoIVovFD4leEEtF5dk9+5e6KemJJ/68hAP53en83j
         93ww==
X-Gm-Message-State: AOJu0Yz5eaI4jxWpD2rsyL4yx1tvjbqe4bf9XrI1svaAaQfmUmJLj986
	gSCRX7cTSBpGqUq3MKvjdzxGjUk7/39IW4XriR8=
X-Google-Smtp-Source: AGHT+IFUFKqeyiZeh/EHb7Y155uctucXkRF/E3pq6fUnL4YG6VKBJ9cEMpoQK2gFl9P7C77Uc4mDUA==
X-Received: by 2002:a17:903:40cb:b0:1ce:5bb1:4e19 with SMTP id t11-20020a17090340cb00b001ce5bb14e19mr6586305pld.66.1700947424267;
        Sat, 25 Nov 2023 13:23:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001c3f7fd1ef7sm5370504plk.12.2023.11.25.13.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 13:23:43 -0800 (PST)
Message-ID: <656265df.170a0220.105c4.c931@mx.google.com>
Date: Sat, 25 Nov 2023 13:23:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-189-gf8438240ed9e5
Subject: stable-rc/linux-5.10.y build: 19 builds: 1 failed, 18 passed, 1 error,
 5 warnings (v5.10.201-189-gf8438240ed9e5)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y build: 19 builds: 1 failed, 18 passed, 1 error, 5 wa=
rnings (v5.10.201-189-gf8438240ed9e5)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.201-189-gf8438240ed9e5/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.201-189-gf8438240ed9e5
Git Commit: f8438240ed9e569bc85dde03dc0683f8cbe60be3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failure Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig+arm64-chromebook (gcc-10): 1 error

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    rv32_defconfig (gcc-10): 4 warnings

x86_64:

Errors summary:

    1    drivers/interconnect/qcom/sc7180.c:158:3: error: =E2=80=98struct q=
com_icc_bcm=E2=80=99 has no member named =E2=80=98enable_mask=E2=80=99

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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 0 warni=
ngs, 0 section mismatches

Errors:
    drivers/interconnect/qcom/sc7180.c:158:3: error: =E2=80=98struct qcom_i=
cc_bcm=E2=80=99 has no member named =E2=80=98enable_mask=E2=80=99

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

