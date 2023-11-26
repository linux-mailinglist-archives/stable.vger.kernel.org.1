Return-Path: <stable+bounces-2660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BF77F9066
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 01:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734281C20A94
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 00:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87D218F;
	Sun, 26 Nov 2023 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uBjyHbsq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167B0127
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 16:05:26 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfb3ee8bc7so6404655ad.1
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 16:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700957125; x=1701561925; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I8MnCcpnrjJuD4L6vr4gKuzM3hQAZcmfcqcWh7Pt7Bg=;
        b=uBjyHbsqnyzDJ9+pkI0dgrqmN6TBcQO2ybCAAc7xJJUrwsYpvXgTocBpCxrmDeOG6Q
         CdqjzLbZNlpgJNRebjcKv1eunIFT7L59I0qwWHh8U/wTRICZ2HL//HCHWTL3/EcSMMbv
         Mcxpd91OeU83+0VLNMTOUpd3U8PaOWWBHb14zX3jP2F2d/5h1pOAXLqc7ySwm8tdhtgi
         WTzztJ0jCl7azV6GufG9YHvRS3vJqr1SdfW8LbbFIJ98H0EayJNHS905dKOSGewEf/QG
         5AsOhsxWeJ2saRCHXwJhy6eov2uQf9XG6Tb45SuXyYVe4tsK7H+lMD24sSu0s3iEZxjc
         QA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700957125; x=1701561925;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8MnCcpnrjJuD4L6vr4gKuzM3hQAZcmfcqcWh7Pt7Bg=;
        b=Uutua4etj6zTtn7DT3XP/fi/eYR083APbKn/PUyOSOwJY7pjSPIV4xVtXFHNfRGMY2
         NCYcZa0aBZ6mm+gMYoFbkt/GlkahdPy5yjpnhsgl4d3oVdEjFN7BB4Xj6j8Es3W/p+6R
         TPWCJWQt503d/u8DjGMGYhctURQs3+avYwif3KqUBzG25IzL9/xF+3g68ZpXi4ufEYzO
         wUemThHKaGTyWJppSRSFf+ND5UP6XC4BqLffEHILUFVuhyVZU1tj/BtA3TQCvtnsxqvl
         hCbkGH5ZzlbxZ36eRy+56aTzcDzTjljqsjns/2/lht5dgRC8PPRmimYKbcfcx227Xy/R
         o/rA==
X-Gm-Message-State: AOJu0YzRmT4LGQfbktDFMIFqYRKna5GKwc9+tVnXiihMMNgn9N+FnCcw
	g5djcFyorQ/jj+3edGqiZu3k0ovd/xgz7gAv9lo=
X-Google-Smtp-Source: AGHT+IHrbzsEo4l5RBSJ67DEeMNtZPhxg803uUb/deJIRcU2RX8QOJb1TWbqriJegwMYwpoYsE2KXw==
X-Received: by 2002:a17:903:22d2:b0:1c9:c6f4:e0c3 with SMTP id y18-20020a17090322d200b001c9c6f4e0c3mr8408025plg.62.1700957125018;
        Sat, 25 Nov 2023 16:05:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709028c9800b001c59f23a3fesm5428768plo.251.2023.11.25.16.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 16:05:24 -0800 (PST)
Message-ID: <65628bc4.170a0220.ce274.c94d@mx.google.com>
Date: Sat, 25 Nov 2023 16:05:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-188-g4d68658fe2c97
Subject: stable-rc/queue/5.10 build: 19 builds: 1 failed, 18 passed, 1 error,
 5 warnings (v5.10.201-188-g4d68658fe2c97)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 1 failed, 18 passed, 1 error, 5 warn=
ings (v5.10.201-188-g4d68658fe2c97)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.201-188-g4d68658fe2c97/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.201-188-g4d68658fe2c97
Git Commit: 4d68658fe2c97983cdc603e08cfaf5a06380db5a
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

