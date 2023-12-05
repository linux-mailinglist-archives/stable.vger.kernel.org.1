Return-Path: <stable+bounces-4674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8188E8054F3
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 13:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376672809AB
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F795E0A6;
	Tue,  5 Dec 2023 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="e5CFso+Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB119A5
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 04:40:15 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d05e4a94c3so35551005ad.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 04:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701780014; x=1702384814; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oOL18LCFZoc/S5b2qywEr+sALkFWqOK3ISG8DAUYOXs=;
        b=e5CFso+QI3JRh68IA1LsqdLTmYc6WeKkUddCXsIaU0kL5QPX4syQ3ruFeCFreBBpSM
         TuFBL9R3ri+SC18E+eHeu77Ob6PgchGH05K4gFf+h/eXLKUsz5us8JhQ+VK+P2PbAA3B
         BXlKbIrX0F5i/mTDuEtAfdOtS+GbIQxLnaBM9dzNWQN0Bl3HTJs41A5PX0zlXtIeCKpF
         ODsH6N0WdSf+Phrc7c/lYXeL8PLVi60xOsxS6rev6BC64Lt+QIhfE/H4X5SIs8Tqsgw9
         2yeRe6YnwrsbWQzUeY4w4Pha/9iYNO0lrTh+ldcVZr7aPfQwk3iFMKrFdMD2rF/SEKZf
         VHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701780014; x=1702384814;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOL18LCFZoc/S5b2qywEr+sALkFWqOK3ISG8DAUYOXs=;
        b=IBm+nOUXcOcGMBayWT7FaHak4qF4fb/gzo0PUK21UiftHrCXkEbt6KwXRPsCxY+owO
         BJDkGaw0hzrduVxNre9CCzVEivBiEyNSxx3VWWluFqu4jKyiXvwQMCvIwFoEXBJO93B4
         7MCxGD3bPgarmcwWdw6FLh3lG6bx0kp0tAoWKmsijn3DNMxK63OeXrxwcYiDDuu1Hn2W
         I51h+TUoJOUOGQPYHE/iQnptQAiuxyktigg3Z6/T2sLn/z6G+ClqDTV5ERO1rIXLZgkk
         sLHPHN3gEG0dYPwnvTe+bqlToiCFcA28d6wUeVnZlYKPAb4vugY3IoNz+v/WPLe5z8OH
         xh0Q==
X-Gm-Message-State: AOJu0YxbcIm2r/jKbrtbcqyR6AzxYtEbBpfjnRCbSW3H8iYu1jENKWOH
	KLoesf1vKMdY3V4ffQT8QfFcYu5M+LautPGMbxsvfQ==
X-Google-Smtp-Source: AGHT+IFU59kTYH7eIGW5W4SqVsbGa0Bg4zNBY5FiajgJ64Cg4BDw1pn+vvx5abI7CTiSNhB0fB8W5w==
X-Received: by 2002:a17:902:7005:b0:1d0:6ffe:a2a with SMTP id y5-20020a170902700500b001d06ffe0a2amr4765640plk.136.1701780014644;
        Tue, 05 Dec 2023 04:40:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y21-20020a170902ed5500b001d04c097d32sm8562942plb.270.2023.12.05.04.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:40:14 -0800 (PST)
Message-ID: <656f1a2e.170a0220.17a68.7d04@mx.google.com>
Date: Tue, 05 Dec 2023 04:40:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.141-68-gbff845be423f
Subject: stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed,
 3 warnings (v5.15.141-68-gbff845be423f)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed, 3 warnings (v=
5.15.141-68-gbff845be423f)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.141-68-gbff845be423f/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.141-68-gbff845be423f
Git Commit: bff845be423fe62b2311b342db86a99d9aaa45ae
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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

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

