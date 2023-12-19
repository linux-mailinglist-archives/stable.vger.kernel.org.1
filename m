Return-Path: <stable+bounces-7855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F34818049
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 04:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C6E28379B
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 03:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E385232;
	Tue, 19 Dec 2023 03:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bwb3WbRM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2B4C78
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d728c75240so1766047b3a.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 19:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702957746; x=1703562546; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pERubsIjgtvk4k/S/uzOvEKgYu9butClOv9J1KGQh98=;
        b=bwb3WbRMQsjzhtETnQchDJPL7oALPIR4v2+smtFD/fanM0VpiY5e7YDD0pSgPPpK73
         6+lq0HWVlhqp0Hs3kLFZvkV+sfmEuE2bB9c4YFvezEvk7kyqmf62/ZUSfDjs1Ij8UV2V
         EMaGszWtcLg02loweTIIQ8+ybYNUjjYHa6ZMniiCg/7v/5gP+lQa0mu/MxsyaEsp2I4x
         SrtgB3ZQdVz3vth7yBU36SA2DbX1wHNGz7y8U/z/lCqDdvJ1BL5FMQOpuxaISpWn/rSf
         qIUXf9C9EuIYRuE7Eey/DI4YaA/Q1ZxATT10V7dNzrOH9gRSSoa7gXlQmHX8X7gNRlr/
         PbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702957746; x=1703562546;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pERubsIjgtvk4k/S/uzOvEKgYu9butClOv9J1KGQh98=;
        b=kuyDydAHbv55s6+2nfMTH/8YLwwX+QWm5VPhNWY5UZaNx/q4MzleOtB0wOZ1YBs2lR
         M7ZlemVJgWTLkO4MztGj5VBOJ8VhDJ6DPSAo16TtimLxvrf3GaUUIaet2LHiWIim8MpR
         rlvriIXYBl1TR07uWY+uxPkncWm5vE4FNssP/VjJlVNjhOLc8sITxIQ5P4gPgz9LORaV
         8hcKjaEJC2HL4/LNXWku5MGme9yAfCNrxwQdmmQy79Cg2vUeH+iqr7QAR3WM/es31phA
         P1XydCOyUMeIby4YamC2GRtK1GMtLJa1eJErC47dvk/CjfWg2+VTZ5aZp7+RloBp3HpD
         N/Aw==
X-Gm-Message-State: AOJu0YzlWutXd+oeSOcqCY1gZSak7Ey8K52UYfWFkzsjpMg6PoyO9b3Z
	y+Prj3WP5CI5Nqh+xPdPO9yIfv7nX4Gbq/ArvcA=
X-Google-Smtp-Source: AGHT+IG6WyU7RZAfkM+Pjk7pdq8OzuxtibWEnmmhMCT9xhWBBBVNyAuQcxCOqPRHWOdCVIu/nET2yQ==
X-Received: by 2002:a05:6a20:3942:b0:18d:b43:78ea with SMTP id r2-20020a056a20394200b0018d0b4378eamr23081362pzg.43.1702957746466;
        Mon, 18 Dec 2023 19:49:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h16-20020a056a00219000b006d5d74cbcf9sm3479213pfi.58.2023.12.18.19.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 19:49:05 -0800 (PST)
Message-ID: <658112b1.050a0220.fa1f1.8cdd@mx.google.com>
Date: Mon, 18 Dec 2023 19:49:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.6
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.6.7-166-g6a5518dcff6f
Subject: stable-rc/queue/6.6 build: 20 builds: 0 failed,
 20 passed (v6.6.7-166-g6a5518dcff6f)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 build: 20 builds: 0 failed, 20 passed (v6.6.7-166-g6a55=
18dcff6f)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.6=
/kernel/v6.6.7-166-g6a5518dcff6f/

Tree: stable-rc
Branch: queue/6.6
Git Describe: v6.6.7-166-g6a5518dcff6f
Git Commit: 6a5518dcff6f8d059d613bf4850c3ea0fecbceec
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
nommu_k210_sdcard_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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

