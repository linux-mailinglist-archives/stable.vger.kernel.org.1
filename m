Return-Path: <stable+bounces-3572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C717FFC7A
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 21:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB04B20FD0
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2DB5674E;
	Thu, 30 Nov 2023 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pa+W3A9+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2541C1708
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 12:30:33 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf98ffc257so13332315ad.3
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 12:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701376232; x=1701981032; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fEgG5Ce5VBv1/bXTgrOy+gcilNenJb/YS3sQTpSXO70=;
        b=pa+W3A9+zczazVsU4sx/S3N9MovND5Fg0A/7/Q6q3dng1djEyvqUL5BMHp4yRjWJv1
         uTghH951hlhhYM5oyApVKITuslACLWuecQVrKCrJMOWRDFEEV3fE5kWvrfmR8LQwgPYL
         DIuBG6/Wocr9MEJAkRYtcRC7JQVaThaPhOkfvfmua7MSgTGr7X8F2mP+5JUbunM3LzU5
         RdZvaWidOlEe4z0gehuGyhjp8ZUSgKQDMhINFB7mFRGr9xhnTynwkmU5MJOJDO0ueVdu
         8XFUd41hCt9Qc/k13xcW2594pMHBiZjVTI97ZcvJZoBzYcjkh1KlNALKl9gaW9Y7EHD4
         BR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376232; x=1701981032;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEgG5Ce5VBv1/bXTgrOy+gcilNenJb/YS3sQTpSXO70=;
        b=M5uVKK1dLixlZemPQ7SvKgJY4ogxfA/LhSoGvqiKKrYWT+eZULvxGM6qEnDvUpvld/
         iHKSaMFRfkLR9jBa5z4M3XN2nJEMYNP8Y6q2Os1FuiBkiGcqJF7VaFLbL8KURedMkBt4
         lDGoRVM+eEBy3/V+JupKOrIkRbuF4iyyUieoq2P4sTT8Fc54Uu1YLorZIT9fyji4T7/9
         itDPsHxVMNv68zCF1SC2xgTIzhpEF8w/A6gaIyzrwFYhnA/efXrCNOsixiP/cQdJhvbs
         fSFc9IT10P0uR1Xw/n+EXQYgZtrQoai2lriBGIEltdQJ8M8yQU21IcYQEJjfp/RfX4wT
         LE9A==
X-Gm-Message-State: AOJu0Yw4dvYpmQeJSjiQNUVCgMX3Tx4UfHIMrG/Wuh/1nPFlYBfSdRss
	2gE/auoNVk7nhztmwFU29nUJX5FWS9b/AnFzkKwxPQ==
X-Google-Smtp-Source: AGHT+IFHZ1Uh79pom2ioTeE+eHDHp/nH/U180Z2+x9IOVKHzBK5sJmNbYKhL7wl5Tzed/PkQDrpEjA==
X-Received: by 2002:a17:903:1107:b0:1cc:5a74:b1df with SMTP id n7-20020a170903110700b001cc5a74b1dfmr29336184plh.2.1701376232142;
        Thu, 30 Nov 2023 12:30:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090332d200b001cfb971edf3sm1829943plr.8.2023.11.30.12.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:30:31 -0800 (PST)
Message-ID: <6568f0e7.170a0220.3e374.5db7@mx.google.com>
Date: Thu, 30 Nov 2023 12:30:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.64-83-g49ac60b65ef71
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.64-83-g49ac60b65ef71)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.64-83-g49ac60b65ef71)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.64-83-g49ac60b65ef71/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.64-83-g49ac60b65ef71
Git Commit: 49ac60b65ef717d2d74b3b83ca97b61a011557de
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

