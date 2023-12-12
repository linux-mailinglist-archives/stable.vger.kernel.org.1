Return-Path: <stable+bounces-6408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598CF80E4BE
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E312835B2
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 07:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E2116431;
	Tue, 12 Dec 2023 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="QNCnDXNV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53070A1
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 23:18:40 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce6dd83945so4635697b3a.3
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 23:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702365519; x=1702970319; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UORNWQMgvuQOp2OW1M+lDyerMrpl3y4tPzU2WOkHKIA=;
        b=QNCnDXNVSrQStQ4H9IgoebnBzuCoFkIjCmLMCn3yVsYowvy6GoaLAZz6WxdfkOnL4d
         A638CLcn8GyMQkxDhmZ+YRvjcqNjr8gZL4GXZOMcQIlwPpWC4wQvzzJVacLXbZSvbm2y
         +Rf4aj7Y8zjT1PzceE6tH89EoVqsJ83UTiEB7E1py2zq0kqqfTQ/NJGD8z44znBo+z7a
         LuhtmQN5SmIqQyClRMpwAQPTlBJZn6tSNqnoHtR7qqLWM3nU3NRsI3MJWfVfOT/7C8pj
         4UMaXfRfWRB2aOjN0///nSL+khfaJjWwPxj/Q63pbcHxPyweE/+i6hkYp4Bz2OMmgO9t
         tSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702365519; x=1702970319;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UORNWQMgvuQOp2OW1M+lDyerMrpl3y4tPzU2WOkHKIA=;
        b=S+tgXjta56prCh0rMKYaphsiluR5ttNZWAEoa9DGxsXAEP6PAHeKBFa27t4zMhuUbx
         35Y8dvGs6oCIhfA5xmHrzQmEwnVAc5qeDao5fEGZ8qacPEeD0AsCkK8hghDM9s0Gys6s
         Cyw7r86rV4/KTe38Pnw+QjrmxtdATTaFqUjvT4B54EM0vAMM2L16uM999hd8e8RxukeH
         rQ9LAGFZWd8xudZGnvLsyfLKtjkTRVYilwnLp3eVPwyld+B6qCCC5mp6W2JobgnJi0Xu
         u4nTsSuAy/b84Jzr1yFnqnM/YySNHslduvwk/Yg+9PR/lOwXNyZTaOTUZgQZwGC210TD
         BewQ==
X-Gm-Message-State: AOJu0YwZL5nc4oT5AyYrh3fpEK3SmIgfbacqoiNE2QLzt4X2ojFPw1Vl
	kgVa93VyNfVbX+Ftos5s103woQeQ9zf/sMvSk59/qg==
X-Google-Smtp-Source: AGHT+IFfJY8ptwrLH2zO7f7tSQRUe79eOn8HF3YhOThYMZ2UFEWhkoWOsEYUPBi6Ol/pcB8pmacEIA==
X-Received: by 2002:a05:6a00:4b4a:b0:6ce:2731:a089 with SMTP id kr10-20020a056a004b4a00b006ce2731a089mr5720249pfb.56.1702365519326;
        Mon, 11 Dec 2023 23:18:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j17-20020a056a00175100b006ce6bf5491dsm7441714pfc.198.2023.12.11.23.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:18:38 -0800 (PST)
Message-ID: <6578094e.050a0220.65701.5a16@mx.google.com>
Date: Mon, 11 Dec 2023 23:18:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.67-194-g4d98cff86b0fc
Subject: stable-rc/queue/6.1 build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.67-194-g4d98cff86b0fc)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 19 builds: 0 failed, 19 passed, 1 warning (v6.1.=
67-194-g4d98cff86b0fc)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.67-194-g4d98cff86b0fc/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.67-194-g4d98cff86b0fc
Git Commit: 4d98cff86b0fc36bff804a47ed7f62b0c09c58e2
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

