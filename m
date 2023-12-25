Return-Path: <stable+bounces-8437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8492081DE16
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 05:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D47B281697
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 04:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E00EA4;
	Mon, 25 Dec 2023 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="zxMazaxw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B416A56
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3cfb1568eso29496185ad.1
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 20:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703478359; x=1704083159; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2XfeSIZ9Qr7tmPvlc3Fm9Eov33er9KqG4Sx31TDTFOc=;
        b=zxMazaxwPSmWgyMQiAyh5N6U5D6qm1pg8Kbw1k3U9QyFK5qo7UBm5j+/NWlvCoYn3m
         lMQ+wqCcig5/SCIAnerb4tpXS3z56jns0icQMm/W5vCA4JYnLUotlMSkVks61TVVFHdC
         aGBJNl+7+lohofuGZcTyHzhrDldk1VwU1ADV6yyo+tDjKcjWIDz44AflWTjzqrzuWFHg
         HroiLCl48FJgjTOZ8LzCrJ5qZDDWuafTsV+M0HxF3LosF8HH8YUKX55aNCp6X0aO0c4X
         t8HNL8KFHWVUM7K83nFn6ErWXCjIeVhnQDkt8UmMB+BmmNbT1JzyCu3OA1nciC+qMpNv
         0aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703478359; x=1704083159;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XfeSIZ9Qr7tmPvlc3Fm9Eov33er9KqG4Sx31TDTFOc=;
        b=ZqwLqvyNSXB5ITtBU3J+bFmsYoXc/kg8Ly588SQF2qapI92F17jvZJvCLfgZWcF1P8
         qcvalcog3kK2aHnvXD5agm4u2edUr/DJopAf20v6YfhMB3bfS9lBUgvfb+UGQTzzB3ww
         N6RCKbJvf33phH+et9OnnTHo1UmkX+WYJi6mC/CfLd1jHvMD+h+G0Hp21l4wkpVsccxh
         3UgfUzFsmYzAJIKDUtV6puW93amjuaU3TUEomCGPSXFuWiE1PHFEVbX4nVVVEh9E84Zj
         4I085r/uMmKyORdsVT+fVQyaO2/nf3sdQH6k2GGQWjfvNvPHFmN7+FAuvIkE0SqiwU23
         RjQw==
X-Gm-Message-State: AOJu0Yy5GxywhVNMZWV6FtWZFQ1oCRh3wM1rc5K4xrVNGD+LlevE38Ua
	YE8yMp+tNPhbl2PKKpwqNKB3X2kFy6hD5M3f3gwCm+UC7uY=
X-Google-Smtp-Source: AGHT+IHLE0K4FDKtjLfIW8qrOwmvvuHHBnGgeOn3t4sOC12+SxmN2XZhwGcbVYRB4xDJd9JjCXvVMg==
X-Received: by 2002:a17:903:230b:b0:1d3:6419:ca60 with SMTP id d11-20020a170903230b00b001d36419ca60mr7514752plh.92.1703478359435;
        Sun, 24 Dec 2023 20:25:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902c1cc00b001d0969c5b68sm7327846plc.139.2023.12.24.20.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 20:25:58 -0800 (PST)
Message-ID: <65890456.170a0220.c3520.32bc@mx.google.com>
Date: Sun, 24 Dec 2023 20:25:58 -0800 (PST)
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
X-Kernelci-Kernel: v4.14.333-36-gdaa4e12019a82
Subject: stable-rc/queue/4.14 build: 16 builds: 1 failed, 15 passed, 1 error,
 27 warnings (v4.14.333-36-gdaa4e12019a82)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.14 build: 16 builds: 1 failed, 15 passed, 1 error, 27 war=
nings (v4.14.333-36-gdaa4e12019a82)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
4/kernel/v4.14.333-36-gdaa4e12019a82/

Tree: stable-rc
Branch: queue/4.14
Git Describe: v4.14.333-36-gdaa4e12019a82
Git Commit: daa4e12019a8235158c0943e528183a5bed300c4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 6 unique architectures

Build Failure Detected:

arm:
    multi_v7_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

arm:
    multi_v7_defconfig (gcc-10): 1 error

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

Errors summary:

    1    drivers/pinctrl/pinctrl-at91-pio4.c:1054:3: error: too many argume=
nts to function =E2=80=98irq_set_lockdep_class=E2=80=99

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    drivers/pinctrl/pinctrl-at91-pio4.c:1054:3: error: too many arguments t=
o function =E2=80=98irq_set_lockdep_class=E2=80=99

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

