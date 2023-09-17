Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703FD7A34D7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 11:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjIQJM3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 05:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjIQJMJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 05:12:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2987F196
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 02:12:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c4194f7635so20695015ad.0
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694941919; x=1695546719; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rKxImO+nzVIHhuaVtqT+E0oBqJx5k0Jckv3kn2RVPjU=;
        b=svcmrhwuj41nesO8R6U+7SmcuMYgLle+jSzqWruWEioASD0ShO0TWfyuPD1R6hykhH
         7zXdhNiIg4t5mNjIWay7ZRF65W81KSGlkwqJbnDpnTSwsGlSeKJxa+ZSZQRWynEAjvtb
         YsszGPGnwcvmJIA33V2bOY5Nmj3SBUWqY9ab27UPPbu9cAX82qum4P51ABjsezgaxcEn
         MImYakPRKx39ZoVbUusOjEAVX/7BsTKebrPDQFoDB5pSiV1kBWk3G+WthdEA6Y4vdl9/
         Bohe3D3HHYTZDJpoIiXGW9haweTGi3M64RLebwQxVGYObGbUfHYlsQavE5gQkgp2X+EF
         rz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694941919; x=1695546719;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKxImO+nzVIHhuaVtqT+E0oBqJx5k0Jckv3kn2RVPjU=;
        b=qkPABA/Lck5V/QCwMwGU6e5yMoORple6Pxshgosc1KLfDfnoz7hGP+7//OEv564B8W
         YgDPyg0lLom7FZvMM7pdOL3pbSXKWomVRg9+rgHxAzoarg7GlrrHfHBT6dxMhQyEz3vh
         EAwk9zhYVTrfu1HKPbL2u3QxhuwGCnBHEUr6oOip1OIuFM7ig6vU8i/HujBRopeDfdOX
         1ur65dNEnvLmeqDJPwXFIaIsHeDVYuzBvphxF8Edx9q1pHQJGVHTZCeXmeli14J/CXaI
         wizVvtKhZw0PKjxyhSILLujJ7jD/SQa+GrWfKqlf1W87wldGUjDojwxWM4anZ9ugqEzh
         HXxg==
X-Gm-Message-State: AOJu0Yxittj/OXUxK5n/gA6ME2LawEjfGbxlfb0G6q378VZoy2yxLbNM
        k2aDgnMYn4QSDWiw+/BAAGHbH5oG7vN99/s7NpWVDw==
X-Google-Smtp-Source: AGHT+IHRZLjqtnYcFFHXFfsnxMHv2YILtr75fraBpaIXk0b39nOAYhFHvl9TdKOBagO8xhi8QD2jtw==
X-Received: by 2002:a17:902:e884:b0:1b0:3ab6:5140 with SMTP id w4-20020a170902e88400b001b03ab65140mr8128564plg.4.1694941919011;
        Sun, 17 Sep 2023 02:11:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b001b8b26fa6c1sm6319019plg.115.2023.09.17.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 02:11:58 -0700 (PDT)
Message-ID: <6506c2de.170a0220.d1790.7ee7@mx.google.com>
Date:   Sun, 17 Sep 2023 02:11:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.294-234-gc7e129a87be2
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed,
 27 warnings (v4.19.294-234-gc7e129a87be2)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed, 27 warnings (=
v4.19.294-234-gc7e129a87be2)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.294-234-gc7e129a87be2/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.294-234-gc7e129a87be2
Git Commit: c7e129a87be27fff6d3b4af755300137107852e6
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
    defconfig (gcc-10): 4 warnings
    defconfig+arm64-chromebook (gcc-10): 4 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 2 warnings

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 3 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 3 warnings


Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    7    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defi=
ned but not used [-Wunused-label]
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 section m=
ismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
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
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 secti=
on mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
3 warnings, 0 section mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
