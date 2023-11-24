Return-Path: <stable+bounces-2546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F2C7F8545
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 21:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC97828A61D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B964333CDE;
	Fri, 24 Nov 2023 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="i+b9BRnu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B01990
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 12:44:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfa5a7a9ecso6702995ad.2
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 12:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700858669; x=1701463469; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AH1S09aj58SmN+Js3XXSM+3KYKtuxXBvuZiW6Teeq4c=;
        b=i+b9BRnuhs1zlGdQUALLPWOjh2QeSFvFSk13ZZSvclmk3ePohaRuRcgjyou9zCzKng
         yYMUcP8C7yiie43Wyml38JL2U9TXZkR/LYNrs3GoY25YuOgVr6kA2hq3XnsV5OZMasnX
         KNlnR5tuZXCOSxI0Dezyrf5GTAe7GOd8v+LbUA75a/RKwyl8AT/hB5MXtPYzYkOAKvp5
         xF7a4+rv8odQ9bbLdjHz+RCQ8O+fNi3NP+20CtmRMpcC5tDg20pII9j8gtnPugc7c2V7
         I9m2SpT1XML97nhasqSXbDksmybVODVsr6rqB3sU7rcKl2i4GdKJP//NC2JkcJeuOAlD
         SPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700858669; x=1701463469;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH1S09aj58SmN+Js3XXSM+3KYKtuxXBvuZiW6Teeq4c=;
        b=H7LjYdOTBK6kdS2WCkc0vnOwfNLsXGI7nBIBN9m1E42ngxLqyYyU2jodNf5U9UVrAe
         YbtZf7zxNgtJw7snjewDLOTxrMJyrBtiTdH18U2WSNTXGB6hH0Q9640iNlYym1yeOcd6
         WpJCjCnYelL+WEKltqqASEtZizsKu8LzuqwM8JcoUydfKUk7KtHGSZz1gibMQth/WpPQ
         Fz7Emhk6O9VARcElRw3ElqajvBwZjzqB8HF6PRWoQPs4BcztLLUkqAuymiQu7eqau432
         V9U/7AsnprIasvWkUEQc7aHOAg7kZBV9VWrcbloF0oH+nppymMcIr7+cXdGylJ036PlB
         tjcA==
X-Gm-Message-State: AOJu0Yx/yd+gO6/4+AT9ot7BbM8PJbm6Vs32na8OHigO+g63uqcD4nHj
	3JQjTMfQF8iEyVUkso6O0NSIMj8ypEKzbl0apAE=
X-Google-Smtp-Source: AGHT+IHuxqe+B8tYvDvHz+PGil1RgovoWFATFDpf9U0+7h4b9g7e989BbngX5XqmPohZkRN2FkqHsw==
X-Received: by 2002:a17:902:c086:b0:1cd:fbff:211f with SMTP id j6-20020a170902c08600b001cdfbff211fmr3792572pld.66.1700858669110;
        Fri, 24 Nov 2023 12:44:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b001c3a8b135ebsm3565371plg.282.2023.11.24.12.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 12:44:28 -0800 (PST)
Message-ID: <65610b2c.170a0220.a1265.9167@mx.google.com>
Date: Fri, 24 Nov 2023 12:44:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.299-97-gfe3bb28dbe2d0
Subject: stable-rc/queue/4.19 build: 19 builds: 6 failed, 13 passed, 3 errors,
 14 warnings (v4.19.299-97-gfe3bb28dbe2d0)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 build: 19 builds: 6 failed, 13 passed, 3 errors, 14 wa=
rnings (v4.19.299-97-gfe3bb28dbe2d0)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
9/kernel/v4.19.299-97-gfe3bb28dbe2d0/

Tree: stable-rc
Branch: queue/4.19
Git Describe: v4.19.299-97-gfe3bb28dbe2d0
Git Commit: fe3bb28dbe2d08170a833ae1f6bde4262f2799db
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig: (gcc-10) FAIL
    defconfig+arm64-chromebook: (gcc-10) FAIL

arm:
    multi_v7_defconfig: (gcc-10) FAIL

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 1 error
    defconfig+arm64-chromebook (gcc-10): 1 error

arm:
    multi_v7_defconfig (gcc-10): 1 error

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-board (gcc-10): 2 warnings

Errors summary:

    3    drivers/tty/serial/meson_uart.c:728:6: error: =E2=80=98struct uart=
_port=E2=80=99 has no member named =E2=80=98has_sysrq=E2=80=99

Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

Section mismatches summary:

    1    WARNING: modpost: Found 1 section mismatch(es).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section mi=
smatches

Errors:
    drivers/tty/serial/meson_uart.c:728:6: error: =E2=80=98struct uart_port=
=E2=80=99 has no member named =E2=80=98has_sysrq=E2=80=99

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 0 warni=
ngs, 0 section mismatches

Errors:
    drivers/tty/serial/meson_uart.c:728:6: error: =E2=80=98struct uart_port=
=E2=80=99 has no member named =E2=80=98has_sysrq=E2=80=99

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 secti=
on mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    drivers/tty/serial/meson_uart.c:728:6: error: =E2=80=98struct uart_port=
=E2=80=99 has no member named =E2=80=98has_sysrq=E2=80=99

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

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
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 war=
nings, 0 section mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>

