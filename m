Return-Path: <stable+bounces-6405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A4480E443
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 07:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1C61F220B3
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C5715AC5;
	Tue, 12 Dec 2023 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uOdqchXD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED53EBF
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 22:27:55 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4420345a12.3
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 22:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702362475; x=1702967275; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UiNmu4t8uHSS0jQ1ARTXJYbLhaZy4YstxtsON0An/9c=;
        b=uOdqchXDzZ4ZJ9ZdMwvqYUhvix7WALVhJjWO30NL1eGyI1Sg0RgdpVHJ4P/IvOdy+6
         2EcHvUkSHXkmfS1qR0PMrBum78cFT/wo5iJevhK37FR+1mgUFeMWO6/NsFEM5E8LwXlW
         TVwXFjtCTMXXf0ca+aV9XoVpTDraE9Y9HMrTeWvWBmRt9VYG3fQKCnxFQvhdXgSXd3ap
         Yl4M++CLHjbBnSXle0LSsCIxQd0oKv7w1+RsK/dbD4WHWkjmLczIzi9oZyiYoyfyP9WZ
         oRIkU1DuVU4M4xt4LC7zg0N+C95GUI+g2GfHvR4NIVVTG0HjJ/bseTTJlEq9wAOcumYr
         T7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702362475; x=1702967275;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiNmu4t8uHSS0jQ1ARTXJYbLhaZy4YstxtsON0An/9c=;
        b=gjlY6ahVC+KmBLtwvtXN43Kh5p2mTW5mqtydd3OeFqYL1FxG85JOCXtxjKjvHryDLo
         Yz6Szu4SKjSKnho7K3N0otLu5/fGAtL9Ktn2ytYMXKHvPEXDggOCNV18jFGI5ymSwyrJ
         e8ePMmMafQondLU3FXZLtgM2sUKCwKTZqKZFazHtZjeNptHkQpngOCXbzxQb7yr3BnYp
         TF1IeDneKwtrnxnJIVgRm9Et1/BzjRLDr4kGvw+ghifRJV4Zm7S2a6gY+ZPSNLQH76op
         6veR5m94iw71LlsqCmR7yBPx6VlV1dYmocUzWTc6S5Z0NZ6wu7qOMFcF4BlBTpHlpHok
         F+9Q==
X-Gm-Message-State: AOJu0YxcdMo4xlq9tcmPPF+lIfJIPfmioSsgvfVzFmhZfQo1ihwwI7MN
	Dzj+cvDUO7MQx0BAyXvM6/23tRLk2uewXlDTtCs3Ag==
X-Google-Smtp-Source: AGHT+IGSYspWI55Bt+/s4YqMZqkF9j0UNVD+vfe7lJxVqjRPH0WkcgyFqDG5xrIro0uIWugETCJ1YA==
X-Received: by 2002:a05:6a20:1609:b0:18a:181b:146b with SMTP id l9-20020a056a20160900b0018a181b146bmr6990884pzj.29.1702362474973;
        Mon, 11 Dec 2023 22:27:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001ce664c05b0sm7784857pll.33.2023.12.11.22.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 22:27:54 -0800 (PST)
Message-ID: <6577fd6a.170a0220.27d4e.6e65@mx.google.com>
Date: Mon, 11 Dec 2023 22:27:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.19.301-56-g47e943e888e77
Subject: stable-rc/linux-4.19.y build: 19 builds: 6 failed, 13 passed, 3 errors,
 14 warnings (v4.19.301-56-g47e943e888e77)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y build: 19 builds: 6 failed, 13 passed, 3 errors, 14 =
warnings (v4.19.301-56-g47e943e888e77)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.301-56-g47e943e888e77/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.301-56-g47e943e888e77
Git Commit: 47e943e888e77ca2629ef0cb4b60c5d5d1581e2d
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

    3    drivers/tty/serial/amba-pl011.c:644:20: error: =E2=80=98DMA_MAPPIN=
G_ERROR=E2=80=99 undeclared (first use in this function)

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
defconfig (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section mi=
smatches

Errors:
    drivers/tty/serial/amba-pl011.c:644:20: error: =E2=80=98DMA_MAPPING_ERR=
OR=E2=80=99 undeclared (first use in this function)

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 0 warni=
ngs, 0 section mismatches

Errors:
    drivers/tty/serial/amba-pl011.c:644:20: error: =E2=80=98DMA_MAPPING_ERR=
OR=E2=80=99 undeclared (first use in this function)

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
    drivers/tty/serial/amba-pl011.c:644:20: error: =E2=80=98DMA_MAPPING_ERR=
OR=E2=80=99 undeclared (first use in this function)

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

