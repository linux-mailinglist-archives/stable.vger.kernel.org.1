Return-Path: <stable+bounces-3149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8A7FD7CC
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 14:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525FD282580
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 13:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4181E53C;
	Wed, 29 Nov 2023 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pALhbj+/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0C99A
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 05:19:36 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cdce15f0a3so648857b3a.1
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 05:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701263976; x=1701868776; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D3iIBGr0QZHeizFoTqBE32ZbnGanA/OKQAvw4+wq9uI=;
        b=pALhbj+/thPdME2Jpul/y55cX4cmc/UsP4pXwduGRdXO0UOUizq/3dp5UhcgiaHVPA
         3yeGYYFQBl2XJeGWxh1GbOx6oqNdzGQWLBuDRa1LDJjiSwYr/IieaE2UL5htC1MRZdQN
         V/1wts+PEaR6S82Ed9GStDJ8uYZxIOewLjb5Jqoay+ivpqYsjnzK2kL24cnb7GHOcd7x
         6gdER3YRX8NGqOwFNXmZH3crWH8ewXRyBYOarpeMyy8X4jM/bhJFCD5rj9nUCRMRGm9T
         ZdGB0s6ThJJQg/axRM1s5JdyMCw204VwOoTWgOuaRR0NK117hzGIADrzUqDfXPV2MNZa
         ilhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263976; x=1701868776;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3iIBGr0QZHeizFoTqBE32ZbnGanA/OKQAvw4+wq9uI=;
        b=Jd4KABb+8uULZhXjktjAzPwUAcPetCIaBNYDKSoI/nhsI4MfsZwq5EB16n9oWNpkZr
         ZqTaBZLQRhwvdyn+dY/0EqMG3ddRLVj6+LrKHNg3owVKkL6IxaWo0+vpWvFy1OebeAWv
         kKunHWVCuMe+vwVbY5uvBy08/j4OeXgNluvr3iGlaDf6HmNZUlENZUQ45IjptXw6rZPd
         I+5q3oh6VzNq0RA6g/JINJPnw4dIOYIo3R2ZEAQ2DIaI34GOuRotv53GHsyWWMYhnmis
         IXfvVGhZSsRxI65kVuprKX1+WvT97QWT+Ob+rDfBlZwMvRFVAhjr2PRAyrWZ7JUCgf+E
         WU9Q==
X-Gm-Message-State: AOJu0YxcT6aHQwq8Uwn/UBrlQkS+F+MEbACFVT+jA2vaApLJJXYhnVqC
	I5vgyP8Qyq1fw8zg8Ny5veohfm/0ywZym0ZkJIY=
X-Google-Smtp-Source: AGHT+IGvYuO7VQMPgAAUDLQvQkdfQsbsJT8QSWfRQmwjC65020ksb/Wvy6VuDnPn8/vT8pm9So8rfg==
X-Received: by 2002:a05:6a20:7da0:b0:159:c07d:66f0 with SMTP id v32-20020a056a207da000b00159c07d66f0mr26077600pzj.6.1701263975734;
        Wed, 29 Nov 2023 05:19:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d10-20020aa7814a000000b006cb94e20014sm10795551pfn.41.2023.11.29.05.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:19:35 -0800 (PST)
Message-ID: <65673a67.a70a0220.474e1.bd6a@mx.google.com>
Date: Wed, 29 Nov 2023 05:19:35 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-53-gc4c658517011c
Subject: stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.202-53-gc4c658517011c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed, 5 warnings (v5.=
10.202-53-gc4c658517011c)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.202-53-gc4c658517011c/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.202-53-gc4c658517011c
Git Commit: c4c658517011c81c8211b3afe4502dffc3e090d7
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

