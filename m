Return-Path: <stable+bounces-8354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BC381D0D8
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 01:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763AF285047
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 00:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0A396;
	Sat, 23 Dec 2023 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ljaNmLCa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181EF384
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so914296b3a.3
        for <stable@vger.kernel.org>; Fri, 22 Dec 2023 16:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703291958; x=1703896758; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zCKDY53SGp+tT7wRiFV/iu2FqoxEz1ORC+WDl1fD8o8=;
        b=ljaNmLCakVb1yruB+IvwTIZ2ZHNLjldcubOJxVtV6I05H/uM/0EnTwFeFA5IpYtBKP
         CclfUonPu8TVc4n7Jt4OmyBkV7JAt2LsQg2MtOrzGL0szcCmNF0efcS/upTqXxg0zBc9
         pVxCEDm0mrjVGv9LIpHbLnfG8BvKM0ggCjTA0gOqO+SpeO0nWIm81JWhCyk0Ce91KG07
         nU9EkvvFvilj/xs+5fFAV8zxbmasTw/lhx6IdNYFan/nRMQ+REv8FJa1Oe8yH8BPLjI8
         VEPwvaVmu/jE+J9LIruJlDVkg9Y/v2bI7jxHQnW1v1F1sC3Z3AbFeUPeSsH1sxOT+sOY
         Jvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703291958; x=1703896758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCKDY53SGp+tT7wRiFV/iu2FqoxEz1ORC+WDl1fD8o8=;
        b=Lb2+YFDmHIHWbCPs34Qn6gcU4KT7oqNdCQsOYZih2YBANI1R3xodpBMXBoQPd/iuDy
         RMbis2FcWk9MxKIsD+p1SfqDPPnB0V3RvBNRvZPTwV0iEZ71BNUbLkOq1E4+QX/e01rA
         P6XRf5Lw62vt5cbf2/H1ClPAr5l22hIW309gEutQq/3rrNh+UpxwxXEHwNDcC68RSGp2
         M2s/wT3KvU2R+5CXax0bTg5yAHvw8HkBMhmAqbybDTpwskmSM8OeEUV/SUaIfQ8+dFtD
         oWgNoH+pwKnWkYL6bFPUR616W5kiGZtoVdFvLNu1exSHToG/y96dcnW9nl2pqXYb8EuF
         xDmw==
X-Gm-Message-State: AOJu0YwBbLciJJeNTQY21KDKV80U5H5BPSv7To6InPg8S8DczuJdLCgh
	Vo7eylX1bnry9ACkxCkH9H2IxjX7Pi0+FjNPyFzfaDFx1KU=
X-Google-Smtp-Source: AGHT+IHBG4SmXnjDf2yUWI7ewDpHX9cugTPM7XaOV+zJmNWy5A8sfNtndJOXXvMKvg005jRXeclApQ==
X-Received: by 2002:a05:6a00:999:b0:6d8:835b:b0d1 with SMTP id u25-20020a056a00099900b006d8835bb0d1mr2204100pfg.5.1703291957824;
        Fri, 22 Dec 2023 16:39:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z9-20020a630a49000000b005c2422a1171sm3806750pgk.66.2023.12.22.16.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 16:39:17 -0800 (PST)
Message-ID: <65862c35.630a0220.54ebd.cbba@mx.google.com>
Date: Fri, 22 Dec 2023 16:39:17 -0800 (PST)
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
X-Kernelci-Kernel: v6.6.7-236-g5f9f9b8ff175a
Subject: stable-rc/queue/6.6 build: 20 builds: 0 failed,
 20 passed (v6.6.7-236-g5f9f9b8ff175a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 build: 20 builds: 0 failed, 20 passed (v6.6.7-236-g5f9f=
9b8ff175a)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.6=
/kernel/v6.6.7-236-g5f9f9b8ff175a/

Tree: stable-rc
Branch: queue/6.6
Git Describe: v6.6.7-236-g5f9f9b8ff175a
Git Commit: 5f9f9b8ff175a296e677a58aaf34c09f676f7b39
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

