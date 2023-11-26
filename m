Return-Path: <stable+bounces-2702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5361C7F94A4
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 18:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EFA1F20EC6
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA7FE56B;
	Sun, 26 Nov 2023 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cIwCcb/E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A49CFD
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 09:40:54 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cd8579096eso583557b3a.0
        for <stable@vger.kernel.org>; Sun, 26 Nov 2023 09:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701020453; x=1701625253; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RMjd4ZopryiqN7x9qDUxEoXo+6tqLEudVfKdmcNLGuc=;
        b=cIwCcb/EzkGDElX1+JMx78VnbULrbrTvuzSNYvFLWIKkjyJp0ylX9LBTKXDv5Bx8ys
         NIWoYwpSV9LFF/OAxBvIM+T2Q3Z75EVvKiszdNqzDsVuwqtBAzAcZyYph9HNViTM6cKE
         Qm5FCEmXR+d1kqQAPfrOYR9JMZfT8KTY0ExA/XWr6pGHXLS/2Ym+EvBRZXcBJmo5vytZ
         qI9N5K77ApWVUfWf7+fDLJgsrzN9fxcg73QIllMiWJQVc66Sf0SMtTc++wJ8Io83OpJq
         ASAcUedKisDut88pQnX+aHFhkcKYVNKvQQUaYZEYJuBzU7lxeOAw1hxbBQ5qRATK7IiR
         lDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701020453; x=1701625253;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMjd4ZopryiqN7x9qDUxEoXo+6tqLEudVfKdmcNLGuc=;
        b=kvs7qXaBw9SYPam/h4W/5dMUSeTIVZR0nli4AZeSBPbm7mXZWKwxOtLIe4eaAQ+Hwp
         97Y0hHKJlkoJRWAMkHz3YPHbdcZ8msM2MMueH9hw16LcZi/2zoKVyrCbw9jhmVyVsRFF
         /sp4mrDG1Mp5MUBsBtYRq5J/eAl9kwZaCkINkEkSwbZ93gaLZFGP4cbXyY4HTn8q9uTe
         p/gUtsLGK3D5Fno1V7mvuoDbxr/VwjO7wmF6gBrAkTWw0I8i7lRIadZWrvtRxVdxDdgk
         LGi4ch/HCMLFXfJZHRdV6ngyRLMazuFUgAxtVMIviMG1i7yjafOkemZ+gjInX9505uCP
         S9xg==
X-Gm-Message-State: AOJu0Yzv2gcj8p4NKVfzmpFC/siENhM3/NQGNpDmFezuhN3Nkj1X60RQ
	tOqu8ErqTqB8wXU6J4Gzw0QXsg52GVNPVjP8pcY=
X-Google-Smtp-Source: AGHT+IEWd5g2edL7E1UjfpkLnNPA469h9MeRJg0upFG+1FdCN3Cf3mmU5Km8Lt5cXZqajQSewJXu0g==
X-Received: by 2002:a05:6a00:4ac2:b0:6b6:5ed4:dd42 with SMTP id ds2-20020a056a004ac200b006b65ed4dd42mr12599723pfb.31.1701020453643;
        Sun, 26 Nov 2023 09:40:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t18-20020a62ea12000000b006cb94825843sm5871779pfh.180.2023.11.26.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 09:40:53 -0800 (PST)
Message-ID: <65638325.620a0220.5b97d.d127@mx.google.com>
Date: Sun, 26 Nov 2023 09:40:53 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.201-187-g1c10a6db4286a
Subject: stable-rc/queue/5.10 build: 19 builds: 1 failed, 18 passed, 1 error,
 5 warnings (v5.10.201-187-g1c10a6db4286a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 1 failed, 18 passed, 1 error, 5 warn=
ings (v5.10.201-187-g1c10a6db4286a)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.201-187-g1c10a6db4286a/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.201-187-g1c10a6db4286a
Git Commit: 1c10a6db4286ae97118521b3a68a08a7dac41cea
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

