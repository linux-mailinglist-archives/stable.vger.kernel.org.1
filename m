Return-Path: <stable+bounces-99-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377F27F6C7C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 07:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE5BB20BDD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 06:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38075A34;
	Fri, 24 Nov 2023 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="CGWjObPP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC7DD5E
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 22:54:58 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cb55001124so1892211b3a.0
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 22:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700808897; x=1701413697; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7nfGeBwVTBBRQz45kXL2S2YAVP4o7Avv4Ciu6Y4+rlI=;
        b=CGWjObPPGFvNJwGx61l2ckzh7ci+FRYiwQIIQgOtscT16D3M6wmT1piRsfTFs6c71E
         Y7Zdu10QtPG9NRu6adFUadUwWcSwZc0/fyUsUF3asu/JVWiJex5uwYQ8GdMrLU4w2NBN
         goF23yh8szi1EEu7S0Gbl4l4F8IctpjAV/hy8pY61Ts/oWrZWSGNOucxDyGdF+TYwlZX
         HArSsptqnsB1yweGR8VDBefnEBOu2qJ2tBJSyrJcQh9fisZTzxpX7WbfrcXUsEBKE6sY
         x6DPGFf/5ackZ4/zpsN2AXYafMWIuqiZMS089qM6MoO5bSNjHX7HE3EImDn/VE5yCK9H
         3VlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700808897; x=1701413697;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nfGeBwVTBBRQz45kXL2S2YAVP4o7Avv4Ciu6Y4+rlI=;
        b=eqefMkjDVVcHVw6O03xlBx3JJyaJAvoP0kbcJzRx876r9H/Nd5a7+p0t2/uATlOHIT
         08DsRJq5EnuxZh7/byEaDnKiMn1aVLcBC09Blom0qIQ2SKEBjdbAx3+cOlp2YVASck/s
         w0GRuiK2vQuIfdHnhFRgIvcd3TnCB+g1oRTTZwi3RnyZTXTYnWKIJzl7Vl83dgoXkCre
         fYkMvUUfZdsObqTNXYXlj3PSBQ/YGW2y6A3s8P977C4anHTsQxg55NO9YWoTugpCzAc2
         SPq9+zwd9w2bPv0eAqN/LvFHXeiAUoPSjdVoW4DjpNHLly6xDC2uvBINwvBTCQpCBnAF
         pKFQ==
X-Gm-Message-State: AOJu0YyhdvJjrI4M4HjQWmXSKD8CnaRihLNk1zDzhGjwaVl0AlIEw9Vx
	zxy1pAETmEY2+qwaNK5LkGw8jo4ftWGg/ge/2K0=
X-Google-Smtp-Source: AGHT+IEA2IP7ZJ887gcT7JKHICnkwPdyOSVai9GAGlzQ0kIIplydq0B+xtzHQpZvW+H/q5nwu9NbbQ==
X-Received: by 2002:a05:6a20:3c9f:b0:187:e3a5:b35d with SMTP id b31-20020a056a203c9f00b00187e3a5b35dmr2034959pzj.13.1700808897553;
        Thu, 23 Nov 2023 22:54:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o5-20020a056a001b4500b006c69d4c9b24sm2201331pfv.167.2023.11.23.22.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 22:54:57 -0800 (PST)
Message-ID: <656048c1.050a0220.1b1de.5989@mx.google.com>
Date: Thu, 23 Nov 2023 22:54:57 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.299-76-ge745246f71bf0
Subject: stable-rc/queue/4.19 build: 19 builds: 6 failed, 13 passed, 3 errors,
 14 warnings (v4.19.299-76-ge745246f71bf0)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 build: 19 builds: 6 failed, 13 passed, 3 errors, 14 wa=
rnings (v4.19.299-76-ge745246f71bf0)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
9/kernel/v4.19.299-76-ge745246f71bf0/

Tree: stable-rc
Branch: queue/4.19
Git Describe: v4.19.299-76-ge745246f71bf0
Git Commit: e745246f71bf06d88a79d5a08f23374e648e001b
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

