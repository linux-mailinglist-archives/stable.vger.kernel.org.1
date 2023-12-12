Return-Path: <stable+bounces-6462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE6780F1D0
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C592812C5
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506E37763B;
	Tue, 12 Dec 2023 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="H2ZhIRkR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11599A
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:06:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so5054403b3a.0
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702397170; x=1703001970; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X0uWX3xI4wif0jcBRPcdtwNrnmw3HbGGO3gPEUxsN/Y=;
        b=H2ZhIRkRFQB50tRPNxCrJUWrbQJdEO/7JeCvmkP/qAXhtZ+DZZl5S/p3WC0fdJosUf
         lpfTm/nZTWPDCYN4MavIRHuod5/fW9Bqyd5lh6ckp8OIjbRLp4GKb+TgeeeIdqjs93a9
         A0THPw6zyyiSUvvbeqHg7LFMUzX03KuE24rQhLd4I90Pi8Wcg+seL/Wz8TnsPu2f9sLS
         dw0yOH5gWj6jjTXVB4tYehqRN2Kuyxhp2Z0E5jaTflrJlfd6Jyqbb95F98ahv+bxDwuf
         AAgTz0RIgQA9fPBx4JJiZyM369EK6qdAOaAHfpl2woHLa9VkjMtxaDnQfp4nDSvi6aKy
         cmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397170; x=1703001970;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0uWX3xI4wif0jcBRPcdtwNrnmw3HbGGO3gPEUxsN/Y=;
        b=anru86H+FKiFg81KVPcLpuzt28/2+h4qGCy5lh2Hjg3AseC7WVJw76wBj2hzROexld
         NMSqdGmofmgbSIW4eIQwSm0Opg+DY+ysYN9bGL7JCavM6WRrARpm109CHsXlPkiAwF2+
         icj7TZVgAH3YOpcwpIyNG3y8xdxkpCAp83q2Gb0++drJHVCp62HYiQb/MNDGVeZGir0m
         l2PJ06PVV/limCsxRBCOU9JCvVsURbpgN7CCDV4l5yJlFa9el4ZyXPJVsnA30PUjFXrS
         wbB63QpWnvAL4wdkvAd6mjrYh19d73B77WwP0n9wp1jN+ez6huA7FV5oa/VN0ZWCPd57
         d8pA==
X-Gm-Message-State: AOJu0YzdkEqECxcd6gtVUQETiwbvz7HGfC7Qh5s2RW9Hdn1DGSbvxG2e
	v/XiqDeYY8A5ujTGSsMNf5dzR3QLiCZu9SRyLSCaww==
X-Google-Smtp-Source: AGHT+IHZ4fpq2CwLCsKfjXyBxnN/c8x5fERRUE1ahADCrNCrXq7ppbVOGupuQfdG5RzLsOfK8icNLg==
X-Received: by 2002:a05:6a00:198b:b0:6cb:913d:2cc6 with SMTP id d11-20020a056a00198b00b006cb913d2cc6mr6833062pfl.15.1702397169753;
        Tue, 12 Dec 2023 08:06:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o73-20020a62cd4c000000b006c875abecbcsm8641147pfg.121.2023.12.12.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:06:09 -0800 (PST)
Message-ID: <657884f1.620a0220.4b8f7.9cc0@mx.google.com>
Date: Tue, 12 Dec 2023 08:06:09 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-139-ga4ffe767de538
Subject: stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed,
 3 warnings (v5.15.142-139-ga4ffe767de538)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed, 3 warnings (v5.=
15.142-139-ga4ffe767de538)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.142-139-ga4ffe767de538/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.142-139-ga4ffe767de538
Git Commit: a4ffe767de5380b7766e1604b9517e635ee15953
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

