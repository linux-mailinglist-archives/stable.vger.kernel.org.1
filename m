Return-Path: <stable+bounces-3195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB447FE4FF
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 01:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF9AFB20FA2
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 00:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB63388;
	Thu, 30 Nov 2023 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uSe0OL2p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F91BC
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 16:38:10 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c2ad6a5515so342576a12.2
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 16:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701304690; x=1701909490; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6JJtXQRmDyqaN0xH4h8jullEPz9wgrCByKH3kovmXDs=;
        b=uSe0OL2px7x9Alqose3meHUXQkKSgn0XcHGS7hF5BsXKDcHJbA4D+K3YI1WgBRbxhy
         1EMmnSs9L18hqfTzI5F+esWXqqsXuzi8UROtUxNUqNnO5l6/H6pUBNmqeX0nWRKMZ0Ha
         zh26/Vd6qOv+IQW1RIdsAbJ0JgXwdrPGqt2vDYywPUXfq2RfHbcPJKGIBAzGtETIMhrX
         hynW75+qLyoRdXcGFkERmbTPfuBeCgwfb2WoWu1uZh2QdpJahEAck1JPWMVs+HoAYznB
         WGhkCNnSCw1ZiHaeXTnjbWthGgCTu2pNaHWdhF9souwqCUHf1B8AvjQ4txyN7Iwv0/Nm
         xPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701304690; x=1701909490;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JJtXQRmDyqaN0xH4h8jullEPz9wgrCByKH3kovmXDs=;
        b=qKHa9QfPf/0v7/vwlA898gPX92vxjyGvHSgW2eMaZ5lEY6PYs9g5oktysseRqAbVyi
         xgNLJAvUmc2dPyF0Snj8QXvpdwJDh7krcFj09L2dea42C4MwlM2JcqezqQ/Vlo1ub8WP
         ka9/6pEbdsF4UV/iZbzXOQ4Y/wkB5UfgKocJojU3D+oI2F7AsrrWiOviphtGQP8UDxs/
         YvhkrEpO1X2iCjXLvwRiztSbqj5yDaRxuFEd3DNPAr8MW7wqxceurYGVWyV/SkAERh7y
         ZQEaTRV0Xpirr/TT6xjBXPJJOo1uVYqBGouwh0TOo5nnIJduZ6RStPyIqMM+x004fbPn
         S/dg==
X-Gm-Message-State: AOJu0YywK5YgTFPDkUhAkEQBCRpBroAptTpWC4iFEhnrGdRkSFLmywG2
	5SGcVAw1IAQuqN1L91jUNHnSlvane7jIo1cLziwQEA==
X-Google-Smtp-Source: AGHT+IH8LV+nVfVjZYi1IlHMmBzXmwjcs74I1Y65rXMzooM2id1oE2UtN+55XrLRTcZHkLQjkoG5Vw==
X-Received: by 2002:a05:6a20:d396:b0:18b:d31f:7d25 with SMTP id iq22-20020a056a20d39600b0018bd31f7d25mr23808397pzb.38.1701304689693;
        Wed, 29 Nov 2023 16:38:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001cfba9dac6esm8669264plb.115.2023.11.29.16.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:38:09 -0800 (PST)
Message-ID: <6567d971.170a0220.bd94.6a93@mx.google.com>
Date: Wed, 29 Nov 2023 16:38:09 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-53-ga1e0fa8fccd1b
Subject: stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.202-53-ga1e0fa8fccd1b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 19 builds: 0 failed, 19 passed, 5 warnings (v5.=
10.202-53-ga1e0fa8fccd1b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.202-53-ga1e0fa8fccd1b/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.202-53-ga1e0fa8fccd1b
Git Commit: a1e0fa8fccd1b3bc456aad06901708c2127860d9
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

