Return-Path: <stable+bounces-2708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F81E7F94FC
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 20:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7CF1C2033E
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516EB11708;
	Sun, 26 Nov 2023 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ceO/WUqC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB2C10A
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 11:10:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso3444877b3a.2
        for <stable@vger.kernel.org>; Sun, 26 Nov 2023 11:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701025803; x=1701630603; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rzgmzn7UWPkCDkK959awdvyc+LGIKgZfxkx3YCUEnnA=;
        b=ceO/WUqCxEDKPEDc4ma0FdsmdIl1Fjevw/dwdi85TJ59VunI3d147Vmgwg6kBkRufE
         QvOINp1XYolqbSjhsyBwLf5sgfOB+Aj+mXw6o0pP68mc5/XzOSA65Bn9YxuHpE7NwQsF
         GWsVb/Pv4F89iEZ0mo0Y9QrZDfV09mK2tH7K7qVYlYp43wRVrRsMnmBixbDYlnjRy8NG
         0CpRg2TQ8oBVoYCrIf46KpMSAMnOuJ6iBLWnAct++V40rRqd1mgfZ4HhWqnRm0+FBs/Z
         TqInjK7ot123c1vj7xW0pk4suTbOON9qnB8FqGwL/Rc5BL9MuTWAei4NSuOWBzF9KYQF
         D8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701025803; x=1701630603;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzgmzn7UWPkCDkK959awdvyc+LGIKgZfxkx3YCUEnnA=;
        b=uyqzc+9Vnyp+BF8CQNrwAWtO0JlooUfwWS828GbJ78FFJO+P0mVrFBQNtLnJNQSDKR
         qN9OFgnRKXvhWwPxQ19lsG5iOOQUKdfLcVXXeoY7xDLyghUgPml+Q4oEmAFsCyvibJ3H
         uPEiEixh8dXG8AF9qVClyC4qNeq/ylOXpvLTaoPImVrwfcrQElqj5bjWa1ONkriUzXDi
         2xXa4W9CrgxJOy2+GlVhOc+ylkiMgQ8sytMJ4w0OKaX6b7Yz1vryTLbCl9moTHj0EoL1
         L+hTyrarndqLCOpxFbWvjndQz57LugCpp1hea/XNZnX1oeoBqwVCX07jm2K30XUsrsPd
         0+cQ==
X-Gm-Message-State: AOJu0YzPwTuy7UxbmtM5TJzTt39U9vK/Ygyqso6wEMImC7Q79Aulmuwd
	lSuLvwCPpXMABuc/eGS+AvzeYbwFSY3Op+mwlQA=
X-Google-Smtp-Source: AGHT+IH6WdxetGt8s/ntW0+mIo0eEAumugtrHV6PbNvjuDScHiKG093Iz1t11ZYtZh8KVv2bTHXBXA==
X-Received: by 2002:a05:6a20:729c:b0:18b:826c:411b with SMTP id o28-20020a056a20729c00b0018b826c411bmr11890503pzk.17.1701025802955;
        Sun, 26 Nov 2023 11:10:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id du4-20020a056a002b4400b006cb9a43ae4esm5854386pfb.215.2023.11.26.11.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 11:10:02 -0800 (PST)
Message-ID: <6563980a.050a0220.f80a4.d28e@mx.google.com>
Date: Sun, 26 Nov 2023 11:10:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.299-93-g263cae4d5493f
Subject: stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed,
 20 warnings (v4.19.299-93-g263cae4d5493f)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed, 20 warnings (=
v4.19.299-93-g263cae4d5493f)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.299-93-g263cae4d5493f/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.299-93-g263cae4d5493f
Git Commit: 263cae4d5493fd62387a61e60908e48685259989
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
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

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

