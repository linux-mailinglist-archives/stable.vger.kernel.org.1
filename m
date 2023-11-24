Return-Path: <stable+bounces-101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800B27F6CE4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 08:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA321C20952
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 07:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82AF5699;
	Fri, 24 Nov 2023 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0ELRcJ2P"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8944ED6E
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 23:24:45 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf8c462766so9842245ad.1
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 23:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700810684; x=1701415484; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t1TgQLZG0tG+D44Di89+urdFLfKHQHqulrZzT+/pnq8=;
        b=0ELRcJ2PtqVDq3tT7TVofgdglL+3ymuibiLp8utL5pF3Qii7jRBmPptXCWjJrNIO5n
         0kupKP8AU87VLWgX+lmiCs1D7MvIRA81pSy/G7UtnG18yOt2c/wVjzKYjyEBrkA9g96t
         NG6CpY7zQnOIPD068VzSgcktWhK9iP3ccBH07rwyxwjArAdW6cOPxzcRGjLfZKzNN1eP
         UqytabL/8GMBJDSNABlzmYoBaGYtWvvCKQI+OEJDQWP3nVb12E+P+llQ1Q65KPn7OZ7d
         y9x36JOdXScBsoCzEiPRwCOgyPh+4LOXzFNBY10ce8DoMxtEXgy2iIz0OP8JFs/rbXf7
         Zg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700810684; x=1701415484;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1TgQLZG0tG+D44Di89+urdFLfKHQHqulrZzT+/pnq8=;
        b=e3slB9CYp2WDmRz9/ueD5B2sb/CzvE/uPphwN2cj4xrw87atN72P3KeOEgoNQuQZq4
         RfTOKxNJjEnX0Hts9jqu6wqoOGBOu75Ibet8a/tXsq2v5GOXQDfyUmM95ZxcvuS+BW3j
         STE+fnivwa+lYDBprgNEX6tgc9+TmvjbU3SmdJBQh60ZsSfRkL8WZ79cLffduDpYMsNW
         fzv99ysYGGamnvHS41cqfRT9m93zUlskbdAQq3qmt0e8pSjkX2QL2MFFRhVbcVlEaNuw
         MFw+C6eyEHOBLP3HEj4m+OMdd4Y4KfVl+dseVksLPZR3Y67vCUr9dsd94ZIiA3CSuF2q
         cM9A==
X-Gm-Message-State: AOJu0YzPdgI/BHnMCKJf4slneYHw5VdG4E3Q88M6XNrLuJ9Rcb2YJNGU
	UyvNcuevWCJRMmW7cxYMn/P2BzgBVrSaC4xRXVg=
X-Google-Smtp-Source: AGHT+IHNWC4PkRaNy4BoOPgWq3pb2jbkMaCRAYJ6tLhA8qtly9MsPwhA14QCJr8RlPTYTEzNOL4AHQ==
X-Received: by 2002:a17:903:32c2:b0:1cf:6f62:890f with SMTP id i2-20020a17090332c200b001cf6f62890fmr2067987plr.38.1700810684464;
        Thu, 23 Nov 2023 23:24:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ff0100b001cf53784833sm2519126plj.60.2023.11.23.23.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:24:43 -0800 (PST)
Message-ID: <65604fbb.170a0220.14a6d.6282@mx.google.com>
Date: Thu, 23 Nov 2023 23:24:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.139-253-ga1533ecb841a9
Subject: stable-rc/queue/5.15 build: 13 builds: 0 failed, 13 passed,
 2 warnings (v5.15.139-253-ga1533ecb841a9)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 13 builds: 0 failed, 13 passed, 2 warnings (v5.=
15.139-253-ga1533ecb841a9)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.139-253-ga1533ecb841a9/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.139-253-ga1533ecb841a9
Git Commit: a1533ecb841a98d106c2a0664b1b18cb3b28b872
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 1 warning


Warnings summary:

    1    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unr=
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
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>

