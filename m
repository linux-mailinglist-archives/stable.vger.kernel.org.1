Return-Path: <stable+bounces-5203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD980BC30
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7396C1C2042F
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B485168DF;
	Sun, 10 Dec 2023 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kW6eErVS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3925F2
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 08:37:44 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d076ebf79cso21474685ad.1
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702226264; x=1702831064; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MoYTHJcQoRbqJxN0/1KAHPoIlj/GZRO4ThXQYaGPxmA=;
        b=kW6eErVSUQhIlEmOdq5F4XI4Ui0dlt2n2TOatqMtyX/hEdKq1I4lWd0O6aJr568vKw
         iFaZZVFpBiqy2osHHXb2eaf061YKudFVhNnIHSan3/OrXvgSpfZOI0n4BcCp4T3vhVm/
         7rmhnI6CZRFbufsr2/pickmJNpX/8ES9o34Gtw5YL+1lOYm2tCp8MmbYMDGhu7BUDyrj
         /DuFP37l/eJcWHGjpiJkt9OpQ+TQaZbk+EkYzyrln19T0h9dPmbC6xdfn0uemlf5wtsX
         XaetuyV66/09cnmbgomOsHUT/FmcNo7SWNcd1v738i2htp34KJHiTFjiwwsHDeOJsBgQ
         EHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702226264; x=1702831064;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoYTHJcQoRbqJxN0/1KAHPoIlj/GZRO4ThXQYaGPxmA=;
        b=Gk7WBpLSMcvaUdDCVlqE5+EShKJwgGus7E4B+U0KHMihHvOu/XC8trwhWpuC1rYoMO
         X/kjGlxMXObYFU0k+DAlGgUFSpqQPd9ERdfbZNnMMXLm1JfUpviyQC4hQnFx42JfMyam
         UUysTNjOBejcaZwyFzpPVMcDFWC0z7YJctr3IqUr6O9RJvckGruYRUsZ2HrC40vahwAo
         rwxVkELKE4KOsXt0yjeWkurBLnP0NYGKGG/6m2dQ0HgWd9PDY5MYlStewDC72bYT15e7
         DPytAAx++ripzvd8xQTmkh60Z7nbOBk9esozzFgMVdOnLGdYwlMk3lGBOBwo5zvxnWFI
         N8Zw==
X-Gm-Message-State: AOJu0YxfKUwc8ByUUM/P/xw0QWUHacqCjPQaKgwcszPVduEtwDuezLrt
	GHB5wSdR8HIStqwJqeAxskjKU88eiRFV+JcqNNPrXQ==
X-Google-Smtp-Source: AGHT+IFQmxkudoHkFo/zUuWb3aFSu6xLisGHEVRU6+1YIKEZ24NJ7O5gaiIHZC9YahOcjEOSTpxokw==
X-Received: by 2002:a17:902:b197:b0:1d0:84f1:6fc5 with SMTP id s23-20020a170902b19700b001d084f16fc5mr1315463plr.88.1702226263974;
        Sun, 10 Dec 2023 08:37:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iy6-20020a170903130600b001c61901ed2esm4982915plb.219.2023.12.10.08.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 08:37:43 -0800 (PST)
Message-ID: <6575e957.170a0220.e37ab.e705@mx.google.com>
Date: Sun, 10 Dec 2023 08:37:43 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-98-g1a1d8f874fa7b
Subject: stable-rc/queue/5.15 build: 20 builds: 4 failed, 16 passed, 4 errors,
 7 warnings (v5.15.142-98-g1a1d8f874fa7b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 4 failed, 16 passed, 4 errors, 7 war=
nings (v5.15.142-98-g1a1d8f874fa7b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.142-98-g1a1d8f874fa7b/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.142-98-g1a1d8f874fa7b
Git Commit: 1a1d8f874fa7b29529608697cce86b6bc1036860
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
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 2 warn=
ings, 0 section mismatches

Errors:
    kernel/trace/trace_kprobe.c:725:2: error: implicit declaration of funct=
ion =E2=80=98kallsyms_on_each_match_symbol=E2=80=99; did you mean =E2=80=98=
kallsyms_on_each_symbol=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>

