Return-Path: <stable+bounces-8277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367D081C235
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 01:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3245281E42
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 00:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634EB199;
	Fri, 22 Dec 2023 00:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="t5GZ2HQu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD8191
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3e05abcaeso9814235ad.1
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 16:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703203683; x=1703808483; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6MkwJ7FRK2kR2FGjY7P+fvgnWWv7rMj8+Y9ZLwM/jZY=;
        b=t5GZ2HQuE/Qu+LTUsLafqnEOC6oM1prmYRudEwkjsKZpVtIGUoVeqVWhwHX0oOe0EN
         rZlqMilTDfrFxNlkVkSUf/mLXGKnCH/9+0fxglfy/UdFeg7CiOm5/gH/z3FIBxyCHZ5a
         SaXnuDI1V2ZjZemLvp3pHzdAzH4e6LmZYNTzoYdj6jSnECZRdnOjBEXZlUCXemrdCSkt
         f8ZTEjqFVMjdttm7m1tQ20bMqkzOqdvY4asWRy2OuES6xcPG5qKYMwFctuJeB0jtV+kb
         SK2Id0RvClv3bv9DfWTk/IjB7ibagNpf8rtaIZv6t9nrvBdxCscVgbnH3YbH05JEnGuH
         EsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703203683; x=1703808483;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MkwJ7FRK2kR2FGjY7P+fvgnWWv7rMj8+Y9ZLwM/jZY=;
        b=cd/yjDZUaGkyqqYgHkXMbOVf6so1wjizfaWWbhbFp97r3RLSZt+qjX2YTTGpyDUVPF
         VHK6LqC7P8dArBwrqBKqlkEMv/kbNgHMU3NDgBCZ0hhsMd3kcG3wTMPRrgBST3IzWZPn
         2u4z0ecENzeVsdI+QZYlwaVfLzJPx8n/qzak65mPSmtHtylWLpOBL8bLQD3J3VUjA674
         9a+jxh7vfihOiRUvVEMS3K4NT0BLqCmZk2/icIC6C/EKp0QLOrAVn07JG8fX6nTWWE89
         JQaNPAeDahsD39xe1DI0dyRCdchrupQldVW096RFI+trG29Cvkq5Pirv4jMD/0WWZOIJ
         MmHA==
X-Gm-Message-State: AOJu0Yy5FoS2Nv4UXTHAgpZo25ZLUT2Sj+qmRUvcvcpN+2Vo+SeD7sbv
	Qk0Ixi75vu0ic8BYp9iSuP7J8XU61zWJw+LwyOCqUwJy8R0=
X-Google-Smtp-Source: AGHT+IEQ0MvRQon6B/rB4PmlHGunIVxkkkcpdaav+svNQabs9D9+8DgELmjHsQCy3SVqbw3livWq8w==
X-Received: by 2002:a17:903:298b:b0:1d3:a13a:e2b2 with SMTP id lm11-20020a170903298b00b001d3a13ae2b2mr374799plb.135.1703203683247;
        Thu, 21 Dec 2023 16:08:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jm7-20020a17090304c700b001d3e6f58e5esm2191035plb.6.2023.12.21.16.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 16:08:02 -0800 (PST)
Message-ID: <6584d362.170a0220.7f3c5.7ac8@mx.google.com>
Date: Thu, 21 Dec 2023 16:08:02 -0800 (PST)
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
X-Kernelci-Kernel: v6.6.7-180-g89c7ea9a70938
Subject: stable-rc/queue/6.6 build: 20 builds: 0 failed,
 20 passed (v6.6.7-180-g89c7ea9a70938)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 build: 20 builds: 0 failed, 20 passed (v6.6.7-180-g89c7=
ea9a70938)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.6=
/kernel/v6.6.7-180-g89c7ea9a70938/

Tree: stable-rc
Branch: queue/6.6
Git Describe: v6.6.7-180-g89c7ea9a70938
Git Commit: 89c7ea9a70938038e9e759200a87b92b1f6d4a29
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

