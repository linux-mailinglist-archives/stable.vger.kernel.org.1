Return-Path: <stable+bounces-322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1537F7A90
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11AE281335
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1205131740;
	Fri, 24 Nov 2023 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="w9h3gAIK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6430C1718
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 09:47:58 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so1482177a12.3
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700848077; x=1701452877; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BBX7ir5+mSHRWOr1zNO7f5bHq9VoJmyI33H4ZFw6hLs=;
        b=w9h3gAIK35Fm4Kin7ZOSMbYgeuRd8HTXKLYHvDSKLSgXacOa6ba0JlfXRTYyyYEIYo
         KazxwUW1CpxzykvTtITUKAzQQc/FsONU38vg8a9AQCu8ccV8jeYrZ4jMsDl+1nMLUArX
         V9jnAXUg2JU7SuWnvdLB8Vc02NuGj1CmEqb7F+79lsdMOLj9CiotNkdTZKcAi/d7VQT6
         CfYzWVJBmXhCIg1ZFh0bf+F/xbBiEpBLDzIFARTdvUwdZU3vLcAWl3bqkOEukb1ggKLI
         I1dXZAxZPg9H+xdsZ6k8XSMmAo2Kb0XDnDPptGyHmaGKT64+h1iKir3d3Z9kwaw8gKMs
         bNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700848077; x=1701452877;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBX7ir5+mSHRWOr1zNO7f5bHq9VoJmyI33H4ZFw6hLs=;
        b=mCOnIB41kNcm1n+oObNkp8ZcGaxVxD06plKF5k13JBXdgmt71JzWDlKKmJn9SN5i2f
         deCT3IfiySMgS1lDBKC/KGTUYkVZboTICAgqWyo49Kt31d5G6Ti0KoANeEEDKOXIvXqE
         sXeCA2BH3qbwzDi2HDYFeHEZZJ2aw9Q+cXVUcRUhI56TEPpWTV3Y2QoB7G+HNBOnPsWO
         kZvnVuhxxaBh0FpkcH5ZEUxsRxqg5gtyMag4oUJpjsHmiVPLjMGdejxe1ck5EbwtCVVs
         i1xqVvBO4OOJJj5if0m7ueXeG5hQHQ1Txww9AD+jeQTe3xT7BUthGJ0tIUM1vQZwJqGq
         AO9g==
X-Gm-Message-State: AOJu0YxdOw/PVI6+X4naXc/U4DfUG33dIqKVolE/J8QcHUAJa0vsDirx
	5f/dSyhZX3r4zElVeL4oJjwvKd6eBTMpzQBZWYA=
X-Google-Smtp-Source: AGHT+IFbzcXbIfs248wpCnB6sGdq7uYN1mbTrKWsolg9YDl4t9dwaIawTOcDvzXXJcI0ANoea1snaA==
X-Received: by 2002:a17:90b:3545:b0:283:2c19:c9bb with SMTP id lt5-20020a17090b354500b002832c19c9bbmr3932400pjb.13.1700848077384;
        Fri, 24 Nov 2023 09:47:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id rs11-20020a17090b2b8b00b002802d9d4e96sm3514765pjb.54.2023.11.24.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 09:47:56 -0800 (PST)
Message-ID: <6560e1cc.170a0220.7d5ca.96b9@mx.google.com>
Date: Fri, 24 Nov 2023 09:47:56 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.299-97-g7841746109202
Subject: stable-rc/queue/4.19 build: 19 builds: 6 failed, 13 passed, 3 errors,
 14 warnings (v4.19.299-97-g7841746109202)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 build: 19 builds: 6 failed, 13 passed, 3 errors, 14 wa=
rnings (v4.19.299-97-g7841746109202)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
9/kernel/v4.19.299-97-g7841746109202/

Tree: stable-rc
Branch: queue/4.19
Git Describe: v4.19.299-97-g7841746109202
Git Commit: 7841746109202b3ce2043656626af75730a07859
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
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

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
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

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

