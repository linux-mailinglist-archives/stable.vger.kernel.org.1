Return-Path: <stable+bounces-3541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DA17FF878
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 18:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8152817FF
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD6258108;
	Thu, 30 Nov 2023 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1v99vVhV"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569A2197
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 09:39:44 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b85dcecc62so724791b6e.2
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 09:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701365983; x=1701970783; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4e7uJbBOX8VgHBkd/bhZiP8lFdZcHhexSQoV2QxsKqc=;
        b=1v99vVhVuAF44g1Evbi3E3YUth8bMsuL6FyNV9xDuatPZaCq+mrLdODNx6eIWorAFz
         xw63r1jA9lZYdz9DvcAvDqLci/XSlh8v7GkVzvaiXVW8PB6UxRQffeTnjkNWdm+hjbXd
         DV6b+JLdDytY9x+msAYFY+CCMRBtTxXGX/fEZBCNRaS8lvFY96GjMW0HsDY+KBd1WjSt
         cDE68SiQfODqfKpKubf1BXMZG5XJQTOhfn6X0n5Y1TfioMcooJc/7gA4Ub3SPY84QoB3
         PRK18zgJbBAe9nrKVx5sMRoCN/lbGwFHXDaMudhp1GCn/ZpBMWJRo9O8qzaUKtjiVmwz
         CIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365983; x=1701970783;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4e7uJbBOX8VgHBkd/bhZiP8lFdZcHhexSQoV2QxsKqc=;
        b=RD95XUTqEAv4Lqoa0fihp9Lfh/X8ctqji81ZybZri/3lsfsTNfvQWv9gxroeOEl3cK
         SR7p1lrLPxAz59st8Px4j01TZB+PwpxISyf1hRH1CaqzTrYQ+JcvJ0MDSB63LGYLK8QF
         jAPCfOfgxAw5oxb+VWG+JYAaCjG5id5TOW8Hv7jD9if+HbY2/w5xMCgasKF50VJw1GPq
         J7aFrT3AtGAWVo52r/qoBEImNgr+GLxrsUuxNT64eGVMIQV5bdfdbR/s3B2XbsAJt614
         Wv4JtBocN/od/7Y9oIR/K8fQHngQhAY8Ql4ecfGpO/YsO2OQkDUjlZfopFqkEIbKbn62
         fLzw==
X-Gm-Message-State: AOJu0YyB2FtT6jwAKQED1McYdC8xzQUugtXHC8Gmtg0omkx9TuTeTbeS
	Hx13hHcej6bpVttOnzRzMVL8w3++sTrsaIuszLNIHg==
X-Google-Smtp-Source: AGHT+IGBYa+Hd19KsqX+wKOrl9c+aHfvSih4OFm7khLz7wzHszAogXZt2spcXD+SbSKxU0m92ovv7w==
X-Received: by 2002:a05:6808:171a:b0:3b5:9724:9687 with SMTP id bc26-20020a056808171a00b003b597249687mr343719oib.1.1701365983217;
        Thu, 30 Nov 2023 09:39:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v4-20020a544d04000000b003ae3768ba4csm243065oix.58.2023.11.30.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:39:42 -0800 (PST)
Message-ID: <6568c8de.540a0220.ef60e.2a73@mx.google.com>
Date: Thu, 30 Nov 2023 09:39:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.64-82-g2d2fb90f0a9f2
Subject: stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.64-82-g2d2fb90f0a9f2)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.=
64-82-g2d2fb90f0a9f2)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F6.1=
/kernel/v6.1.64-82-g2d2fb90f0a9f2/

Tree: stable-rc
Branch: queue/6.1
Git Describe: v6.1.64-82-g2d2fb90f0a9f2
Git Commit: 2d2fb90f0a9f293af6d831c0afc257763b073529
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

