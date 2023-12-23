Return-Path: <stable+bounces-8380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D581D3E7
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 12:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B193DB2142D
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82473CA6A;
	Sat, 23 Dec 2023 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="DVSIozmx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE512CA58
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so1174268b3a.3
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 03:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703332757; x=1703937557; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OE7u3DgjGN4KijBpw3l/deqWUgeRqdzIGvG0sLVcGmk=;
        b=DVSIozmx4oyKY3ZbZ4D0lHnOPJijWpwDrdlL8+8TpKbL0/StjNk+tVFFFUNxgGw7RO
         eFcodazLJ4ajs2yT9aQ5OCdtZjPJ/raO+NFfQG4iY2ato7XUlG+AxIaQ6TpMPjiywcnx
         xCcqn+LOCfZFkNdTMdE61GVtR4Dz+Jfvh0ccFUTuaFernViCYtCteGgAdKKKQqbwzGax
         iJUFUCTL/p6dnvuip2FS7uEHOz26Fc5d6DMgmn4hjriEYslDAlpu8fNRfVjPRxJW2/YY
         XWn75l7TPjydNDaf3x/3J43mq39O4YzpaBiCaBJGIx0hgxzCZL+1WAkPQW9V74z67A/q
         lRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703332757; x=1703937557;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE7u3DgjGN4KijBpw3l/deqWUgeRqdzIGvG0sLVcGmk=;
        b=U8yp3BcEFC4QeT61W3X3pbwsgn3r35ZgkhwpZTxZxQJmhsxDLJbDQi/qx1qP6GfgKj
         rsR0kJbgU3xm2LRUu02i3cgRh3Xu8fyvAZrqDkYEk86lN/4Ia5/BvJulz77T+UOp3Oqi
         V7tpvRi6hF6E+99ucmJFEGo+Z2a9S5Nz/uZ44QMyRJnnFbuuxKUgnhOgJWK2jUJFl6aw
         2FAKDRNQNKMwYq3YUiZgf3wAikfQ8iJr9Wjq141vp29Bt5iGLV5RihspJ13pDNoG/1TP
         18wXQtKdGvoqz74niN7hUet6BjZLvwLIU/jj2lGga/byy0sbkdYNmm8CecRURTDHlMF1
         g7lw==
X-Gm-Message-State: AOJu0YxollQnnCS0+q2BQ7c7ev3tgdrqaq5UV4/m8aZpriXwYkbS2jU8
	mx2qo202eiBv1d+pkKCqSx+YNqB/n0g1l1SKiGxGxD7lVIs=
X-Google-Smtp-Source: AGHT+IHVe29VuLY4SOxPxFM78RkRXG1Vx1E2UjOXUOpLJwuXaP0v7acDuQv3babVin/2V4g57lMPTw==
X-Received: by 2002:a05:6a00:2147:b0:6d9:9447:5f2d with SMTP id o7-20020a056a00214700b006d994475f2dmr1837664pfk.33.1703332757437;
        Sat, 23 Dec 2023 03:59:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a0022d000b006d34d89a163sm925495pfj.157.2023.12.23.03.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 03:59:16 -0800 (PST)
Message-ID: <6586cb94.050a0220.418cd.198f@mx.google.com>
Date: Sat, 23 Dec 2023 03:59:16 -0800 (PST)
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
X-Kernelci-Kernel: v4.14.333-33-geac38e751e34
Subject: stable-rc/queue/4.14 build: 16 builds: 0 failed, 16 passed,
 27 warnings (v4.14.333-33-geac38e751e34)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.14 build: 16 builds: 0 failed, 16 passed, 27 warnings (v4=
.14.333-33-geac38e751e34)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
4/kernel/v4.14.333-33-geac38e751e34/

Tree: stable-rc
Branch: queue/4.14
Git Describe: v4.14.333-33-geac38e751e34
Git Commit: eac38e751e344b93a7c4548c57ede879d299e32c
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

