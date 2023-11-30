Return-Path: <stable+bounces-3562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA887FFB12
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 20:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A61A1F20F90
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFF239AE5;
	Thu, 30 Nov 2023 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bXdTlPzD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBA0D48
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 11:20:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-285b3a14b12so1256541a91.1
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 11:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701371999; x=1701976799; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XciI7oKz/9s1CEPbWuTM7ViOuP7aqotQFEddnnqUNIw=;
        b=bXdTlPzDV5M2r9wsLvYwOP5FKS6FaZozK1Wk5W/RRAeJ2ail6LwijT36jd3XO23HDz
         ELB/BYOGfLCAWVWJs7T/on7A/sCHdwt0sbKUnZIb3MqzuvTwSWPxJfYF3LNwD8IcqMfy
         atN60coPaSOlIycq10y2AwakM6dTuP0FA18ybLXNOJ0fw3ygxgK29TENjhOqo7GPwTVX
         AhQs9rZlcMXHmfl++4MEiP8a/8Z16O+INWG7hZCSMUMETZX1kF3DD3taEc3kaQRbFLZV
         PwJeu/4KyBmiB28uA/oUrXmZLHkiRg7MErrxxVhw7P6jemq6r+1K6SUzXAQ1N++UtNi3
         jIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371999; x=1701976799;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XciI7oKz/9s1CEPbWuTM7ViOuP7aqotQFEddnnqUNIw=;
        b=YWRUQiaLqKqnSwDrGdGGaJPW2nz+TSqh8aGjCVImajFbmE09HL8l5Ckq5xHePRAWoy
         OIHO/rQlyrK7NhvUu9h7vxPYuM+ufUvz9mLGn5PGeubvhHiwP6x/3bPMWK72rkBe25YR
         86snam6uOtu1tcy/vgWvMLwT0HMLT5RVFp9kdmOo+9FsbB6iYmx5BZpbhlWeRWCLh3BX
         OBoHFg+/CZTf+ycdVfcd/RMc1qamUewr8+MyUtNKiv2vCHqOPRR+9UGMQT3tNk8x0YX0
         LVcqTrwA3mli1eDcRvnSlINJ14htaN2AcfXCPHVooKqLOcpvmvUSsvL50dVR0VI4joUO
         bb5A==
X-Gm-Message-State: AOJu0YytzYKY9jFlm7MK4ji+AmqKt4EwLZPPWTZhgiqSUbxLyUJvLlyY
	uMY9AfLQpH9/ZbOeCbgnOt2HM3JeNb6gOrzyjvVMhg==
X-Google-Smtp-Source: AGHT+IHRqdjMYBg7KmEFB7cdKwVbKph+rdmMcKa4OFZRk1wMKyu0CHUQQ2UsN0qbHLaIjBgl/m5jqQ==
X-Received: by 2002:a17:90b:1e53:b0:285:adca:f979 with SMTP id pi19-20020a17090b1e5300b00285adcaf979mr18405481pjb.37.1701371999036;
        Thu, 30 Nov 2023 11:19:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a1300b002864c14063fsm762686pjk.20.2023.11.30.11.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:19:58 -0800 (PST)
Message-ID: <6568e05e.170a0220.a8039.3a39@mx.google.com>
Date: Thu, 30 Nov 2023 11:19:58 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-71-ga7f0dd50ec8cc
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.202-71-ga7f0dd50ec8cc)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 5 warnings (v=
5.10.202-71-ga7f0dd50ec8cc)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.202-71-ga7f0dd50ec8cc/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.202-71-ga7f0dd50ec8cc
Git Commit: a7f0dd50ec8cc1a1943490b06399a1831d960d7d
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

