Return-Path: <stable+bounces-3554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7F57FF9F7
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 19:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FD0B20F6F
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113DD54FB6;
	Thu, 30 Nov 2023 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="00C7s4mi"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CBF10E2
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 10:48:50 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35ca9a9719cso3738925ab.1
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 10:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701370129; x=1701974929; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs8C69EwrK9N3SWmUFx+9jBcgAu7Aymrg4gG7ThRtVc=;
        b=00C7s4migfysOEM3AzKoFaatj1tX/yFH5clkG7s44QIxL5OnS/zsiH5pj5344cgHr4
         eMcWE1TpKzBAC+X7D9oiKsrWjXjxa1GT6SW0BLollByWRwviZaD7kZwasUSSVVW/j/Ph
         8BpqGDW41NaU9G2b/3f9Xzd5KDgIo46cBXIwt9bTulPn7cB6D0zVE7C91+GVzfEaCAQ5
         Jqq9Y54md96YQg3fwmKIuoyT2GnX0r+6zPWIXRYjITEuE9XI+fHblf7TDPVShsOruNh4
         /Y2oAKZ8ZLyTa4Wf+BPgEJEfUbRHUg+8+RBg06RJ1u9C9itZYlggB1Sb6DSfub47rf+w
         Qk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701370129; x=1701974929;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rs8C69EwrK9N3SWmUFx+9jBcgAu7Aymrg4gG7ThRtVc=;
        b=cxHWrgaAQmUqRjU+A61EVVIbLW+RSiBR1On3+nJXcZ36rAWUBMT2kDSIZEbyX+3kdl
         LhmfOYA01jPFhReEzt/JGZbRgzVMe9bLt+rUqYTXelXnI70LpE3xC9TXPz/Ko9f6Pr3d
         LghVra2+JwrWARrVmk4of/WOfOCBtUWV5gu+pNKbnzNbwk5LLedynTTEcSK2wASfFTg3
         lWFaH4ZHb9GsGl+3cjMTVx2hcym7eDZzOD0FnucUeetqHLv/XbZSRBiiCDRV7TanCRFi
         Dutz9h37f/lTvbu3ASC/HwkrbbJMfP9qmunieB8j1Y8Z0QhuN/sIdXeNvZGFkcfeF6SS
         +P6w==
X-Gm-Message-State: AOJu0Yw4Atphn1UwQSmxjNThJyBuIaI8V5PIhd6O2N5arjgzzE164SgJ
	cgfkIkd6x0W82u23nK9/8M5dOYiszAMUXgj4BXEqxg==
X-Google-Smtp-Source: AGHT+IE511aK28xTCCT+1l09dN8FHQW56e/Os4r0EkHW4dtzF97QK3WK2tRmprjnq434ltz2GXYI5Q==
X-Received: by 2002:a05:6e02:811:b0:35c:e1fc:8b83 with SMTP id u17-20020a056e02081100b0035ce1fc8b83mr15912402ilm.16.1701370129657;
        Thu, 30 Nov 2023 10:48:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gx12-20020a056a001e0c00b0068a13b0b300sm1591755pfb.11.2023.11.30.10.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:48:49 -0800 (PST)
Message-ID: <6568d911.050a0220.33f75.4d72@mx.google.com>
Date: Thu, 30 Nov 2023 10:48:49 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.300-32-gf6042b025e256
Subject: stable-rc/queue/4.19 build: 19 builds: 3 failed, 16 passed,
 20 warnings (v4.19.300-32-gf6042b025e256)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 build: 19 builds: 3 failed, 16 passed, 20 warnings (v4=
.19.300-32-gf6042b025e256)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
9/kernel/v4.19.300-32-gf6042b025e256/

Tree: stable-rc
Branch: queue/4.19
Git Describe: v4.19.300-32-gf6042b025e256
Git Commit: f6042b025e256ee3ccd5c7172ae20e4e4861f2d9
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

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

arm:

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


Warnings summary:

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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warn=
ings, 0 section mismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

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

