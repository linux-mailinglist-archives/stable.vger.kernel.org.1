Return-Path: <stable+bounces-6411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BB980E618
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A071F2187C
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B470218AEB;
	Tue, 12 Dec 2023 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="niOYaDLI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07285FFD
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 00:25:12 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d045097b4cso30684165ad.0
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 00:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702369511; x=1702974311; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gQrFzF5gl1BVXKoVxye8ZaWhWfddpxWtCV/RZF/6WMU=;
        b=niOYaDLI1pZJpUwKn9HCdBsgIPQauPX1Ee6uAmBhDV6kxalRTHZqRELaAusI1Gh9eH
         rJlbJQ6fAKbk8bw3nAwhtNlfQiTBFskd5ddiRcBsQFkhcumqqU1NZXeNGVA8PsV3dSEt
         Ttt3HaF41YCZXd3KQaicrXVQG5Y2PnLAY8a3Oa/qyznUi3BTnkT0BRPYFConr9wy0zcN
         kCAcTQ1DUGsNIZMHVjZYP8xOcC5FCG8A6z870pXAsslFcYz0llmCEJ8K6QZfhuYNy4i1
         5i8kAF7RVJQhlZAtdAUvc4P64SOhc5LE1nRtFBdXBw1RiojhjCoK/4nXDQkhCSkl6iYC
         GktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702369511; x=1702974311;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQrFzF5gl1BVXKoVxye8ZaWhWfddpxWtCV/RZF/6WMU=;
        b=laT+guFvFyeuEgBEZs+23gRNRJseZr7zNzrewMzziB1da5rIlx4hzEkrGJRZJZyApB
         hHFTukR5Vsl3gUOg8NFJz1RjBarLycVZRasNl2+LR9YE6Q0Utdp9I6aUFbzvoHTICWij
         K9FJs8lCvFleaTNvb3OeORg9FtOjIRawHpBH+HRSOuJBVb2Klw6E2P3rKxTzibk62lH6
         imPbPvn1I19BXc8SPYomfEWTbgvCY1JjPQOZiSUFdMKtIs2+Rn/8QbjzpIXnpMsNAgBy
         dVR8Uk2dnBz1Ua8Z8GlokrokArkKjLHT/NIt/U3nmi0QgBC6q0rkDPn60ofj0TzrOY1P
         Z5tg==
X-Gm-Message-State: AOJu0YxvJpgYmPkPvzttZifaLIznuRhez0rVOpIF8NMTNCzWekxrDC5G
	a94yypNJ7pfk0AjaVh2Nt84XlBGO7HLpKjiYMZ46qA==
X-Google-Smtp-Source: AGHT+IGE+30wXkHMQTOy3nDRBuHzgCQPyEG51SAa+lMYp0RMeo30vpqrkjsfpMlfUtBFVQglY8lP5A==
X-Received: by 2002:a17:903:11d0:b0:1d0:a084:b002 with SMTP id q16-20020a17090311d000b001d0a084b002mr2828279plh.68.1702369511412;
        Tue, 12 Dec 2023 00:25:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902ead400b001d0b5a97cabsm7997506pld.124.2023.12.12.00.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:25:10 -0800 (PST)
Message-ID: <657818e6.170a0220.2e2a3.6e5a@mx.google.com>
Date: Tue, 12 Dec 2023 00:25:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.67-195-g807435a379b45
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.67-195-g807435a379b45)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.67-195-g807435a379b45)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.67-195-g807435a379b45/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.67-195-g807435a379b45
Git Commit: 807435a379b45e6eec975857b7daf5ac2b3fbf93
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

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

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
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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

