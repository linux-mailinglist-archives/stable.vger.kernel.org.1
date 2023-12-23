Return-Path: <stable+bounces-8378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0781D3B4
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 12:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5A41C21631
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85D89472;
	Sat, 23 Dec 2023 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="274pnoGd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D917CA48
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3eb299e2eso16182665ad.2
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 03:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703329901; x=1703934701; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ovbHZe8owrQtAAXU0knyDNtBvAseXPAeAuB5rj1kzE4=;
        b=274pnoGd/vmeVwP2VdTlCpYjNhLK4CztCAQZHPP5xT0XJRacs56XpOQqwcgHNMtQz7
         DZxMw0CHpyAz9My2GexE5ZVraB/z6ucJay0OfpLGKGs+xDZPGdflCTJGhpFPaj/qqldY
         MdgjW6VOwn/3iTRiutBzYwem3qxEl8QRaY1bwEK7iMVWOMF0q+ZeDEnLnsJ9zEh+Flwh
         ACL0rUpVe9AK58VCv6qb/X2WdODjVm7vT+LPFkgk+kSOnxPZi/+8SpQdytjpwd73Gz18
         lDXK6bxrQ6PVmKNmdh79C7YF96n5w5BPb6fKhiHRSOpE0hxwNLaJNOtTU2YEn1NGLlaE
         vx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703329901; x=1703934701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovbHZe8owrQtAAXU0knyDNtBvAseXPAeAuB5rj1kzE4=;
        b=kb+4VSEZteTcVVhF5GsEYdztBPc/OZSV5ulOdmesT0mUGiY7/RUvJIVhxJ6zZQU0tP
         Czr+nPIKykbiX/D2mkwsyetv38e9RNPeLFoujCJGOdXErsDaLoHthjel5X4enbzurH22
         e9zwI3Zrh39e8QsFBVMh9PgSmqMFJJrfTJ6+Q4hOOUUMka+uXZ/MprSW7iSullSxyjWe
         03HyYcXD5kw6WpFhxhWIFd5UBfo9bkp0GJsT8vZscArsCoiMgv2W+OHhdl1kXfitHXUF
         G3BI4TpsviNZ7Hnr5ZwF4zhHZjS324wTidhILft4SYL9mJQTFaDR9QLx5Cf4kS5Vftok
         e9UQ==
X-Gm-Message-State: AOJu0Yxjoj5Qnh5hUVNyJjpcspIVZAlFQFpQod2wMD9JSXnqBQdpsLP0
	OQx4ZA/uf87o0J1Biy+UZWgspfkZgTo3HO2UsAue7+E8NF4=
X-Google-Smtp-Source: AGHT+IFwiLkCucAHqJ0WawiTA3RNdd+bCwx3BnLzb0L7Gw5pCN2MY24vAIA+A0NwcQ08ld7APN1FHg==
X-Received: by 2002:a17:902:6947:b0:1d0:8db6:17d0 with SMTP id k7-20020a170902694700b001d08db617d0mr1262010plt.25.1703329900781;
        Sat, 23 Dec 2023 03:11:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709029a4100b001d43d129c30sm715451plv.200.2023.12.23.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 03:11:40 -0800 (PST)
Message-ID: <6586c06c.170a0220.6d909.0fe3@mx.google.com>
Date: Sat, 23 Dec 2023 03:11:40 -0800 (PST)
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
X-Kernelci-Kernel: v6.6.7-236-g0ddffa163cd8
Subject: stable-rc/queue/6.6 build: 19 builds: 0 failed,
 19 passed (v6.6.7-236-g0ddffa163cd8)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 build: 19 builds: 0 failed, 19 passed (v6.6.7-236-g0ddf=
fa163cd8)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.6=
/kernel/v6.6.7-236-g0ddffa163cd8/

Tree: stable-rc
Branch: queue/6.6
Git Describe: v6.6.7-236-g0ddffa163cd8
Git Commit: 0ddffa163cd841bd63e048102ab1bc5b6d5f8a21
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

