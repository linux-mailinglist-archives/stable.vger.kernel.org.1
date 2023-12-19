Return-Path: <stable+bounces-7849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5BB817FF9
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 03:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79611F23FC0
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 02:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F017F3;
	Tue, 19 Dec 2023 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3MLiC30q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A84409
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 02:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d337dc9697so32563925ad.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 18:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702954646; x=1703559446; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iDgRocHnFzkgz3rLJz/AKj28UCMcNVlErimsdsi6kzA=;
        b=3MLiC30qIxg6ItsPOhdEyeYvvjcZAiP1iIIlg0a2+23FZobkv4bbGWsQpfDoIbxCTB
         Eb3BaMZE8VJ2TODIjHNno3ICKgd3sqC7qaV2peXvywEjrPEKaFBmvzQeabOI7n+l8BXA
         KYSTjf7RYk3LM51XG7nQDu39NMCvrmYWI1cx1CUlSBiGAF47wIN0oUImZIBsqf33PIVp
         TvHAi6fbIdAKgwyN9Sc0bVkvbRQ17wLwOQuSp6DWxdiaxfoD66spaw8BZ94kEaOX2Q8O
         M6vXc86ENcB2GB+NKkbf6PQWzpY+Hxs1WP2+nHBxmlMsKFAeNgBufDc9I2fQ+9pF+rZK
         aqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702954646; x=1703559446;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDgRocHnFzkgz3rLJz/AKj28UCMcNVlErimsdsi6kzA=;
        b=bJjulemoDHCStJtcN2xb3oZJsfIKzUAI1dnTcDqnhhS1/ALTs4DtlqwM08YUAqh8Nn
         n9ZNh9MAGTd3/STHuOfGS1jSi/O9cR55yjpZXjkGNosIqM/R7Q72G7RngIZ5JyHkuWkG
         ZeIl5gibOgDFs4SR/HjHXo7UjF2uUgVNElbMB35PKKfHZAVsB+WtebpYSELSbkE9qJdm
         GtPGJBdsgHXz3MW+or53lN5wnh0tF8yNRtwrk93SJFnfvtHRIolVsgpGMotLZBow1W2O
         IE9jFCdRW7sZoMzebKV7P5+bSqbk1cyRrhwAP30GbNlpehuICCBfogmXeoGNkEZkYwbT
         prvQ==
X-Gm-Message-State: AOJu0Yxa8pYdFgTdTSN/XtB3IZ2fa8BdQELtqKne05XU1SKmG2FVbW+D
	LUHzG8z2VhsLEZ68UcTlJ0P27FmY9MvVhU8S62s=
X-Google-Smtp-Source: AGHT+IGGwTrJAlp/CpWsdyk0zKTEBoPs3qFgFOvqpYrPDuUgVyAWEjSEWs4K5Ra3eT77RUD6iWU4IA==
X-Received: by 2002:a17:902:bd88:b0:1d0:4706:60fc with SMTP id q8-20020a170902bd8800b001d0470660fcmr16900995pls.17.1702954646399;
        Mon, 18 Dec 2023 18:57:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902f78300b001d083fed5f3sm19893014pln.60.2023.12.18.18.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:57:25 -0800 (PST)
Message-ID: <65810695.170a0220.5fb71.b97c@mx.google.com>
Date: Mon, 18 Dec 2023 18:57:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.6.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.6.7
Subject: stable/linux-6.6.y build: 19 builds: 0 failed, 19 passed (v6.6.7)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-6.6.y build: 19 builds: 0 failed, 19 passed (v6.6.7)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.6.y/ke=
rnel/v6.6.7/

Tree: stable
Branch: linux-6.6.y
Git Describe: v6.6.7
Git Commit: ac25535242acb0d0042b920e5232b10e76ad169b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
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

