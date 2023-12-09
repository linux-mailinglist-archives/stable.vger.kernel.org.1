Return-Path: <stable+bounces-5096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E689780B2BD
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 08:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9CD28104D
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 07:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A31B1FB7;
	Sat,  9 Dec 2023 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="TU2BKoB2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AA410C4
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 23:24:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfb30ce241so25137995ad.0
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 23:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702106671; x=1702711471; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DcSA+/uew0PyfVvMd9WcCehbFwun30oO9F65wsgs+CA=;
        b=TU2BKoB22xd7hb6PQHuBqDK11cMkaA1LKppWTLHxqM4m03EO+Zu2fs4jYfNWxN9rE6
         51btqe5rf83Evkw6O86kLhw+fiB0/3j6bhG1LYOruTrbsCv1jdLSpcd1wIDsCC5HKTgR
         C6mOR24iHHQj3HFfQhakpHqBEofUSDjFsnIpRuMKiBM3FAaIgCFClHiRxSZnFSIEmkJP
         sWEk9+660A6ctBv6DSe8Av9eOunzEk12JCdstexg/8o5ZQaW7oJiqQ7rjYjVUkSPNPai
         32ymm+4Tryx2y0k3k/ZZ6P04JzHoTH6QJ2jUEJhWAfNtH5B8/cQLK8WGs2y5d7XK78n2
         wa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702106671; x=1702711471;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcSA+/uew0PyfVvMd9WcCehbFwun30oO9F65wsgs+CA=;
        b=rN6X6/9VTaKMVr1jCBxwAS9ztOEnfV4N0SLE+lkajCrgSetma6RsiORh9Mp+AYG7Ql
         T6MhPhZ98istlwgr079azvtrHTpcAczRxS0XrNyCmBh0A6p3Kw6WazKoBvk5j7gmXp2s
         iEwZdnFh75rcUwfqfoLhlPDsOSV6ceNyAftC+dbYpbYcg54oa4sHaPI76lxlVoDVEvgZ
         RHpPQE1+KOCvKJnhwepFjxt9nwdsjvE8945mvb6fK8vmXaql3UGc68kh2jrdZMv8dHK/
         i2hywzGVPIk7I6sjzrWlZZW4NUMuyquikcHMXKZBcJ8RYAeYNjLNDhS2Ra6t5nA29uMy
         Jyig==
X-Gm-Message-State: AOJu0YzXe6ggb/DuEl0rnriwXFmGQUrMo2xkhPifk+b0ot7PNGaHfvUg
	tPz69RFmTIapqTjifv7eRhKakqhi3X9YgNEzXS6Dew==
X-Google-Smtp-Source: AGHT+IHlnRg1rSgJ2xJsbIwfzGtUGaeCBmGc2CONmbY6PGHKGwHQn+MSS+SPm0MbXC4ihsAdJjadbQ==
X-Received: by 2002:a17:903:2311:b0:1cf:c42c:cfbd with SMTP id d17-20020a170903231100b001cfc42ccfbdmr1527646plh.0.1702106670972;
        Fri, 08 Dec 2023 23:24:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm2745361pjb.56.2023.12.08.23.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 23:24:30 -0800 (PST)
Message-ID: <6574162e.170a0220.5f114.8d94@mx.google.com>
Date: Fri, 08 Dec 2023 23:24:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.142-77-ga64dd884b1d57
Subject: stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed,
 6 warnings (v5.15.142-77-ga64dd884b1d57)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed, 6 warnings (v5.=
15.142-77-ga64dd884b1d57)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.142-77-ga64dd884b1d57/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.142-77-ga64dd884b1d57
Git Commit: a64dd884b1d579d1a2868483676b8f63cf7efe28
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:
    i386_defconfig (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-board (gcc-10): 2 warnings


Warnings summary:

    3    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of ne=
gative value [-Wshift-negative-value]
    2    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unr=
eachable instruction
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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 war=
nings, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

---
For more info write to <info@kernelci.org>

