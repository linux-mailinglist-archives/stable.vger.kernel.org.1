Return-Path: <stable+bounces-5183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E2580B889
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 04:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E021F20FDB
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 03:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42A15AB;
	Sun, 10 Dec 2023 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="XVoDDjUa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B62102
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 19:20:43 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ceba6c4b8dso2442075b3a.1
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 19:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702178442; x=1702783242; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P7IGxVm3h3uU9i3X2oJzMfbMdeIUWr3U8cOmq/4jEQo=;
        b=XVoDDjUayYfAguFWY93+ERiVstld76gK6pbo9L0jeTGPFdiJn+u2f4xrYpqYXsyajs
         Us68lNEvdZgs3TyWwskdeGGPXxsZfCTN/v/K8jPIUUYjJilGNpOi701oL6Wems4QUAvl
         ZVjzXvkg0UAbHSWKtEKnDpfafgNPZZui1R4xv4ykPRff9nm2j1OBXAbf3NDti7Idlw7i
         vBvAXo8Ssmw/R2Kh3gRGY09ilDcwnqACSqxMa5EFqJAIl7as/dQjFavJhfijP2AzLm5W
         e5ztjQF+4SJvcpdxNgBeKQP9FhzEUhCocHb6k9hphwGWgKSLcoMH+U2Kt9oltsbHC98z
         QlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702178442; x=1702783242;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7IGxVm3h3uU9i3X2oJzMfbMdeIUWr3U8cOmq/4jEQo=;
        b=R3/rfSyn+Npgsv3YUcCDa5OLgSLsONYihM43qxM4o8KoGQjaSYCjfLmRn65btd1IrK
         U4mBumLMWCXvhuNfblvkWN8RiXGdFy/YMFdTQpCEZhx8Q1djnX3DfSyuo3e7GmjcU6ng
         O3ffKvx1LcpwlxwpyDxG/j1XZAijCv+eRBkdXDgdjz+Yxme9NOj2jLDs5F44JDc5YMpm
         iADiuJo0lu1cgh75eCk86maNgHgsiwTDglVM5yem0JuMLH4D+d/X8c51M45CmrWLGNZT
         AjakzkmZFkMJxwuPdGG9qXibeyMVOMtDJEEt5d6PQsljGCr+5LEUNWf2/AgiJroWmnYY
         b1FQ==
X-Gm-Message-State: AOJu0YyvE9k2glFaXPTt8tcrSWzVGy0nOTEkGFPKNtegQAXZZAzdFsWB
	Q7Cdumz86nM4OO6wbGy58c/etTxsUk6Pn18p9RC8oA==
X-Google-Smtp-Source: AGHT+IGtX/CkAmLevLaTsU8J+0PwwB3G/Q8NFP9iHgYMl7qSJUKYbZrh0UqgBRWvZVMYqegbFBcxDg==
X-Received: by 2002:a05:6a20:7d8e:b0:18f:c81c:4484 with SMTP id v14-20020a056a207d8e00b0018fc81c4484mr3390327pzj.29.1702178442655;
        Sat, 09 Dec 2023 19:20:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b006cde2090154sm3899560pff.218.2023.12.09.19.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 19:20:41 -0800 (PST)
Message-ID: <65752e89.a70a0220.f767b.c42e@mx.google.com>
Date: Sat, 09 Dec 2023 19:20:41 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-100-g260ab6cf1c061
Subject: stable-rc/queue/5.15 build: 20 builds: 4 failed, 16 passed, 4 errors,
 7 warnings (v5.15.142-100-g260ab6cf1c061)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 4 failed, 16 passed, 4 errors, 7 war=
nings (v5.15.142-100-g260ab6cf1c061)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.142-100-g260ab6cf1c061/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.142-100-g260ab6cf1c061
Git Commit: 260ab6cf1c061b6e3840d7823672857bc777aa04
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm:
    omap2plus_defconfig: (gcc-10) FAIL

i386:
    i386_defconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-board: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:
    omap2plus_defconfig (gcc-10): 1 error, 1 warning

i386:
    i386_defconfig (gcc-10): 1 error, 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 1 error, 2 warnings
    x86_64_defconfig+x86-board (gcc-10): 1 error, 2 warnings

Errors summary:

    4    kernel/trace/trace_kprobe.c:725:2: error: implicit declaration of =
function =E2=80=98kallsyms_on_each_match_symbol=E2=80=99; did you mean =E2=
=80=98kallsyms_on_each_symbol=E2=80=99? [-Werror=3Dimplicit-function-declar=
ation]

Warnings summary:

    4    cc1: some warnings being treated as errors
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
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section=
 mismatches

Errors:
    kernel/trace/trace_kprobe.c:725:2: error: implicit declaration of funct=
ion =E2=80=98kallsyms_on_each_match_symbol=E2=80=99; did you mean =E2=80=98=
kallsyms_on_each_symbol=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    kernel/trace/trace_kprobe.c:725:2: error: implicit declaration of funct=
ion =E2=80=98kallsyms_on_each_match_symbol=E2=80=99; did you mean =E2=80=98=
kallsyms_on_each_symbol=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 2 warnings, 0 se=
ction mismatches

Errors:
    kernel/trace/trace_kprobe.c:725:2: error: implicit declaration of funct=
ion =E2=80=98kallsyms_on_each_match_symbol=E2=80=99; did you mean =E2=80=98=
kallsyms_on_each_symbol=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 2 warn=
ings, 0 section mismatches

Errors:
    kernel/trace/trace_kprobe.c:725:2: error: implicit declaration of funct=
ion =E2=80=98kallsyms_on_each_match_symbol=E2=80=99; did you mean =E2=80=98=
kallsyms_on_each_symbol=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    cc1: some warnings being treated as errors

---
For more info write to <info@kernelci.org>

