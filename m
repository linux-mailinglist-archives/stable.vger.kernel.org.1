Return-Path: <stable+bounces-8353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6123681D0B4
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 00:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14521F239E0
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 23:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE941EB31;
	Fri, 22 Dec 2023 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="t2j+5mB6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAB35EF0
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d93d15db24so2167089b3a.0
        for <stable@vger.kernel.org>; Fri, 22 Dec 2023 15:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703289436; x=1703894236; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=msooW/enySrGXDZQQSoRlsGm7uWTm4avWILgrbcJNn4=;
        b=t2j+5mB6W6awoNGUOQg4bab4mFOWNtLBWKNOO4fNn/8gNwLpu4UnZNA1fs1dvS+hDX
         DRpjDO8wxlHDPlcl/ivZ/kISQnsntbTxrmDWcFSjmjdwIa29cOR30egYB3oJEoTDpui7
         sirgkOAuTQ3WrqPQ5PRJZTy3HanPPWFmnm+DJqegd9uekHGabiO5wc0ZITviHEiLgKLj
         CeJ9V2b1w8crZJkpavmuTd8/ngUmhjR4ljMav5VqMs5qweB1PVKCAEXNigJ7FH8n8KCF
         xw+yG2+e/GwlRTwjfDLPqf5sCWn3u75QpXIJc1qMiWdMXBfTUT/t6S3YzczT4e06PTsT
         xdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703289436; x=1703894236;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msooW/enySrGXDZQQSoRlsGm7uWTm4avWILgrbcJNn4=;
        b=uuPPGmYqQNuop4C0oCliAu1ht2Ge22r2W2ufff70xjVy+et7E6cqY4NrKFivZ3R0Ty
         /um4yEB2QiBdngwKtEHzaGwTg1/UWlI53ivSoUNeHU5JCU5c+lSaLwIJ3cK+U3H4yQ4x
         odeNu2YWrBlWxWcwDYwzJfJp2g6R0RxzoVGJBw0U2cGyb8TaUxCKayjTzQbYY1QkpN2U
         9MQeZwSIwx5LNOi7oi3tX4ZBErAIQtdKG9BIjTDVrUg5gcNEwL+CWB8bMk8+RT0J+XG1
         xTgspGMjfngysptj7v64pHcnlAyhT3vPOCCrUjVqX7yS/TNVz6mBkrL5d4rTNOVn3ixG
         YUAw==
X-Gm-Message-State: AOJu0Ywi3n1kKqbVxP9qCV7D7hIf5YOGbkozZ+NZykxu0eabTD4rqQYH
	qpT+uko1eg6lOjLRDv8vpOT4y+odRpylmEko0LykQ9ybEg4=
X-Google-Smtp-Source: AGHT+IHfYk1h9nhdfhqW55j1KhNn8Eob4iccn6Epg8F7Cc1kh5+NpUD3H/o5sajn89KfTAEoiXCF8Q==
X-Received: by 2002:a05:6a21:192:b0:195:607e:3055 with SMTP id le18-20020a056a21019200b00195607e3055mr307866pzb.6.1703289435753;
        Fri, 22 Dec 2023 15:57:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028be5732f01sm4083344pjq.0.2023.12.22.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 15:57:15 -0800 (PST)
Message-ID: <6586225b.170a0220.a55ac.d43e@mx.google.com>
Date: Fri, 22 Dec 2023 15:57:15 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.14
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.14.333-33-g0f28486c4ae28
Subject: stable-rc/queue/4.14 build: 16 builds: 0 failed, 16 passed,
 27 warnings (v4.14.333-33-g0f28486c4ae28)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.14 build: 16 builds: 0 failed, 16 passed, 27 warnings (v4=
.14.333-33-g0f28486c4ae28)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
4/kernel/v4.14.333-33-g0f28486c4ae28/

Tree: stable-rc
Branch: queue/4.14
Git Describe: v4.14.333-33-g0f28486c4ae28
Git Commit: 0f28486c4ae28e28ea58aa249dd4ea4e60a53a64
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

arm:

i386:
    allnoconfig (gcc-10): 3 warnings
    i386_defconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 3 warnings

mips:

x86_64:
    allnoconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 3 warnings
    x86_64_defconfig+x86-board (gcc-10): 3 warnings


Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    4    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h=
' differs from latest kernel version at 'arch/x86/include/asm/insn.h'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    3    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    2    net/8021q/vlan_core.c:366:47: warning: passing argument 2 of =E2=
=80=98vlan_hw_filter_capable=E2=80=99 makes pointer from integer without a =
cast [-Wint-conversion]
    2    net/8021q/vlan_core.c:344:47: warning: passing argument 2 of =E2=
=80=98vlan_hw_filter_capable=E2=80=99 makes pointer from integer without a =
cast [-Wint-conversion]
    2    net/8021q/vlan_core.c:332:47: warning: passing argument 2 of =E2=
=80=98vlan_hw_filter_capable=E2=80=99 makes pointer from integer without a =
cast [-Wint-conversion]

Section mismatches summary:

    3    WARNING: modpost: Found 1 section mismatch(es).

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 sectio=
n mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section =
mismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    net/8021q/vlan_core.c:332:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]
    net/8021q/vlan_core.c:344:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]
    net/8021q/vlan_core.c:366:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warn=
ings, 0 section mismatches

Warnings:
    net/8021q/vlan_core.c:332:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]
    net/8021q/vlan_core.c:344:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]
    net/8021q/vlan_core.c:366:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 secti=
on mismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
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

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section=
 mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>

