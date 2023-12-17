Return-Path: <stable+bounces-6922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE188161D3
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE50E1F21AEC
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D24847F78;
	Sun, 17 Dec 2023 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xNK6ARd4"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC6481A4
	for <stable@vger.kernel.org>; Sun, 17 Dec 2023 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35f71436397so22601365ab.3
        for <stable@vger.kernel.org>; Sun, 17 Dec 2023 11:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702842494; x=1703447294; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nu9cXQ1ioTXIftS63m0QPmnl0vU/nnYIbVBzu3srLC0=;
        b=xNK6ARd4sF4sjUeQvo36MPt+9PiC/kFe4XrZHYxx8+ovyi2ksaGnqCAN0z1BOn6S/E
         QKNrq8qQtOoMqKtpVGSePnfGE7e+vfsiF4jbSXkle5FVhf/qtw3zA2T5+N/uXQ99uORI
         x9QvllXnTgU1/cK2GxglDkllEKXt1MkkTjvu/kbfBAAYaAYofGWOL2u4vDrOZ+F00X8T
         6oRdctLDdtTxnNtxRSxdWGPFoBqOEf0XEkF34VZVekaTnMqkuqxwrvEHfbi8HX9T8k4h
         8BoHP9TjqwLUqwZaoJBESvBO1zTb1+n1pAbhYGjfAv9krNk+n4kGa1k7z+xPNX5LI2V2
         +M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702842494; x=1703447294;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nu9cXQ1ioTXIftS63m0QPmnl0vU/nnYIbVBzu3srLC0=;
        b=ljcvk3cJBukI3ZY2hxmYOPONGPfBOk0IoOSxHlbqMUgRJGk/pXLl3WhKvp7q1ymGtQ
         BI1qzqDynISVj0hgnTWN1fDhrdlP+dXnQUIgyCe+qBogjvFrWIdPaIp4ytU0MZ5ClGTL
         XykEZnP/P1ojt6kpTwAHw2q1Hja13e5+VxMDn6L584zfl+YFUxygScLB1UH4Rip1RG5G
         XxpT1+oLZSqmsnweeEASEGM6jZ4HnUtw4SjwnpRTRSQr/gDi18l7P+zH78QT5y1JA/aZ
         5fULBOtlI496h38AnoR1U9I6d1ANwK2laL83UyicR6wx+JY5Hj8zo6+4PYKio+bIatW7
         Eniw==
X-Gm-Message-State: AOJu0YwDocRtxu0JR3vaAysm8g2qSi+ANDO6cz7mOLvBkFl70YyLuNgU
	5Yv9iSvtTS0ys9rbfzPDr2bC06+nNbHa3VLtKWA=
X-Google-Smtp-Source: AGHT+IHjPBmhCamGTCFoNvMeGEJ+8FnKz4Z1321vI69NdnFWVgoGDML/P+7dKVM3eht33Nx9YG34HQ==
X-Received: by 2002:a05:6e02:1524:b0:35f:ae90:e4c2 with SMTP id i4-20020a056e02152400b0035fae90e4c2mr1907572ilu.122.1702842494707;
        Sun, 17 Dec 2023 11:48:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b001d364210979sm61645plb.224.2023.12.17.11.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 11:48:13 -0800 (PST)
Message-ID: <657f507d.170a0220.1cb62.03c6@mx.google.com>
Date: Sun, 17 Dec 2023 11:48:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.19.302-29-g84122b7d25e4a
Subject: stable-rc/queue/4.19 build: 19 builds: 3 failed, 16 passed,
 33 warnings (v4.19.302-29-g84122b7d25e4a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 build: 19 builds: 3 failed, 16 passed, 33 warnings (v4=
.19.302-29-g84122b7d25e4a)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
9/kernel/v4.19.302-29-g84122b7d25e4a/

Tree: stable-rc
Branch: queue/4.19
Git Describe: v4.19.302-29-g84122b7d25e4a
Git Commit: 84122b7d25e4ac7f488881bdc4ae9aacf3b34efb
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Warnings Detected:

arc:
    haps_hs_smp_defconfig (gcc-10): 1 warning

arm64:
    defconfig (gcc-10): 4 warnings
    defconfig+arm64-chromebook (gcc-10): 4 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    multi_v5_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning
    vexpress_defconfig (gcc-10): 1 warning

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 2 warnings

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 warning

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 3 warnings
    x86_64_defconfig+x86-board (gcc-10): 3 warnings


Warnings summary:

    13   include/linux/kernel.h:847:29: warning: comparison of distinct poi=
nter types lacks a cast
    7    ld: warning: creating DT_TEXTREL in a PIE
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

Section mismatches summary:

    4    WARNING: modpost: Found 1 section mismatch(es).

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
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 section m=
ismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warn=
ings, 0 section mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 secti=
on mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    include/linux/kernel.h:847:29: warning: comparison of distinct pointer =
types lacks a cast
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>

