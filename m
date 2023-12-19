Return-Path: <stable+bounces-7890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9CA8184F4
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 11:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53A11C23BF1
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 10:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A477D1401E;
	Tue, 19 Dec 2023 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="IzvqVq0n"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DD14A92
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5906eac104bso2944157eaf.2
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702980159; x=1703584959; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rgxMmkhWChvnaD5jtHub7X7kI5ccfaYKdIx/p76Uh9E=;
        b=IzvqVq0nJWcyRhcKBR5hGM8slhkaDKayzH3LZwWG25xpEqtzcyoaGWqXfknpY3J2F7
         gBeGnmGpSdos2eyhfM9LRvzzMApolTmKDDuiw7lrdUCF2b/Ymv2EMWKxQGSj/IfVUSoE
         uoh//IOZM+x6rw+etT+BQInP8l/goP8sV9O3eK+A8Ln11jBKdYRF//e2+H8FWl61nm3y
         MZkboVznMWr3w5UB7Ha/O3UjY5se+NLPIm2trZ7QlcZ31ojVvEwqrJy11APdw3w7gUCF
         Rc5VHv3/0DXTllW9oWgIf7ULHAQeeMWWmBVWhDhN6pBuevM4+RRxf8o4r8gw5JcWja3y
         /S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980159; x=1703584959;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgxMmkhWChvnaD5jtHub7X7kI5ccfaYKdIx/p76Uh9E=;
        b=Q6NPeYOB+otrUgIRRkp3olzmruFNwzSCUZwopNWuCcT2eO4fr16OKS2aDhqEqCYw2J
         yOsLsr/pGPnbmfyp+FM880q5PgriitDIBwfI0YPjtnVJVX8k0O8mQ/4lhTs8cvdHAyQH
         Vb8/BkVkEFgQoXix6Q7HFDIHCDGdCxyQT1povDeuUMMxwuacIlE6cjsxhGAc+20XXJjd
         R2EdwTpW5iCfACnP9HgUqfKN2BMzBnamK7KYo9K0/PZznyzUeGwoNd5dkev2rrhz1acq
         M531ItWYAei4p4D3YG+y9KgkH/43bhZ98AtY94JDihgDBFNrmxqwmbseFzWlou4zKRJF
         x08g==
X-Gm-Message-State: AOJu0Yx0sHV+mZzY6p6XJdnvih0m8QhSnv+nngrkpmmTLwYqH1MJuNWE
	mpysJdAk5UcSQGVqp9TcZcGMQ0Oi1mHJmDkhM4w=
X-Google-Smtp-Source: AGHT+IHYIuHQ1TyZQyEgMGPQo+anjf31QKPFwFEvdBBjNDCRPG0iL3EgGJAzBPNTS7CTIEihqR4UMw==
X-Received: by 2002:a05:6358:2484:b0:172:eba7:5184 with SMTP id m4-20020a056358248400b00172eba75184mr1828683rwc.12.1702980159427;
        Tue, 19 Dec 2023 02:02:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t43-20020aa78fab000000b006d28e01e2a9sm6049224pfs.1.2023.12.19.02.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:02:38 -0800 (PST)
Message-ID: <65816a3e.a70a0220.bc0e5.eabd@mx.google.com>
Date: Tue, 19 Dec 2023 02:02:38 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-82-g6d719f63e58e
Subject: stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed,
 3 warnings (v5.15.143-82-g6d719f63e58e)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed, 3 warnings (v5.=
15.143-82-g6d719f63e58e)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.143-82-g6d719f63e58e/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.143-82-g6d719f63e58e
Git Commit: 6d719f63e58e10cb9f5926405764d5087906abbc
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
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-board (gcc-10): 1 warning


Warnings summary:

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>

