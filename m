Return-Path: <stable+bounces-8383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE581D404
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 13:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0984B22245
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2DD28A;
	Sat, 23 Dec 2023 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KlwGoZ7q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5CD288
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28bc870c540so2041491a91.2
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 04:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703335049; x=1703939849; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BXyVal75cv1477pL4yvHxAxTiC3klM1wcHYo0saFGhg=;
        b=KlwGoZ7qwjkxYiFRUSZ3qthghigPqpZBR+UOifVcakcC7QW5LkvHKgBMg1tth47sz7
         Jx42TwgKFAy4fq6xbYlbw4UmrKMLNJyLh6aEEwHMgTP05i1LRx2n183mtlD5LnCzmSDz
         kuwUb3RKeLJ04ubbUjSjV9i6beiZlLMEH8tlyhQGBgXhPjk2PsqS2JEK2VoubK5O8d6c
         OlriYjYpf9hD/UIc1Am+SmlAhy39Gay3zC49lV0HoxUVcO6R14PNeTVLSmjJhhvwVgKW
         GAAtPTMcUHjko+Oopiufdst/LkaMqCYOK4zga0B/2ygk/s9xrECyB7+F4/JSbu6eFPBN
         ZefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703335049; x=1703939849;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXyVal75cv1477pL4yvHxAxTiC3klM1wcHYo0saFGhg=;
        b=UDQB8wbAyv2dL8W3HnGtzQMMBTXB4g11vgVhEfsam7eSenKc45HpwIpN5coJwfx8BO
         u/ITNcPA3QekjW8bdso36KcWTXktsnuleODtQ9UCHdix3KnW3XY7MG9B+i7YMYdyiDpa
         6haLOn69SRyzC8iNfqeMWDXFRbjZSvOSZxGCtH6lARzhfL2BI1KSbbYTm4PQfQeu9Q0U
         7rPNGXhLv4iTrMVXCSYzZ7ZkvEgMgJJyrLsm3JJ+kYubPK92QBlKQsK0sw0QPbsbxPHR
         m8WY+T8C3nENu/lrwzrZeNutbA/BPzfaXxcYqXBQS19vQZOOzZBO2A/6LRFbhpTrIxcN
         GHCA==
X-Gm-Message-State: AOJu0Yxp46/+tGEvUgnf4CWDt00TDu1LRcH9O9387Fb5ICWXHess/tub
	TUjjuvANHbBejV9GymhBEAVSi7S8KhPJfY9W2rRJjUyl5gs=
X-Google-Smtp-Source: AGHT+IF1shViGURAqBlg9XL2tA6GghOyFzpIhQc5MhRKT31H/x+EVPSLAMvskbAf1Xq7LPQdIhTmNA==
X-Received: by 2002:a17:90a:6587:b0:28b:86ad:5693 with SMTP id k7-20020a17090a658700b0028b86ad5693mr1582865pjj.43.1703335049393;
        Sat, 23 Dec 2023 04:37:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902a50400b001d3eaab6fb5sm5024858plq.198.2023.12.23.04.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 04:37:28 -0800 (PST)
Message-ID: <6586d488.170a0220.f9eab.ed53@mx.google.com>
Date: Sat, 23 Dec 2023 04:37:28 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-81-g4f4182acc8f5a
Subject: stable-rc/queue/5.10 build: 18 builds: 0 failed, 18 passed,
 1 warning (v5.10.204-81-g4f4182acc8f5a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 build: 18 builds: 0 failed, 18 passed, 1 warning (v5.1=
0.204-81-g4f4182acc8f5a)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
0/kernel/v5.10.204-81-g4f4182acc8f5a/

Tree: stable-rc
Branch: queue/5.10
Git Describe: v5.10.204-81-g4f4182acc8f5a
Git Commit: 4f4182acc8f5a0e65f8737442cf948eb6a7ec2a4
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

x86_64:


Warnings summary:

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

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

