Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92F3761E35
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGYQP7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 12:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjGYQPz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 12:15:55 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A40E273E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 09:15:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-563d3e4f73cso315986a12.3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690301698; x=1690906498;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AReYKAhWaDE9WsDVyPcEwFS9YeBSxpsCvD+wbKtTLuY=;
        b=w6wMbnxD8ILO4nUWpHf+kRRpfhcRJ7s+9uAONeVIgzqNe8Uf/JTbuvZJ8hzkCFHt8X
         3QWW99jhaU0L3HvDOil7SOUhU5o1DoQ0UEcU8tq9S8/g95+qylIQ5ahjjBcjYwm/J4/3
         HcpV32q4E8mCMpdu264/LT3kxsfi5NmYcDaCkAVQWEB30dVaeUAnVb9tWE7n8qNlGZ9l
         3FqbInG0tZMuyfGNNFaJGz78DRiz3jh+WOORqK4co9Vv22HsaK/3JWNVRQuHzV7F/0Qp
         O7HL9AsybYv64Xpq+/pxZTovlBIlA6FQ5/fNzTUqJZZWW6OKysbaityEosUukgYkH6ms
         5VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690301698; x=1690906498;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AReYKAhWaDE9WsDVyPcEwFS9YeBSxpsCvD+wbKtTLuY=;
        b=lwCPrJ47gFEo7s02iBnf0b+8T33axGv7nzjSxlLAVVN1E9UjKCmXIwDttLGXqhhFKE
         QTDkDE8pL8BxIgTxVQntLQHMccAQ3rYBsOhqs/R782yul3WLcSv+T5Md1LHNnirDeGxL
         ZwrmtALHHbMgTdAZd2vrZwBzWx/W+47ps1orSQNNOH1YiC5tPqkLO9/YZKKvuo4wfDHf
         jVpcMOZd2DR4VT2yiye8wsxowUJpB8ytxno2KNfRoyjbF4JrAuaBcUUuHmROfoOGY0aZ
         wB/jrLfRwuLChtsjcxPX1WpP1Fx06RZqw1tE8EKVDKSVFJLhJX2QvriIIyueZAiPGPnH
         +3hw==
X-Gm-Message-State: ABy/qLaxmrb38dnj0Qvoui4mgvMnAUdKUNHzdoJss5EQ7vnCZVy+b1a4
        JuxoWm9NCLgnrbSd2s0LQmTD3K0SCOauZtJn6GMaMg==
X-Google-Smtp-Source: APBJJlGdQI+ikbYY9TT2IwGIUlXDQRPiRZmTqgb+5NEpKs6pNcHrE/U4v8VXdv9vt0OT/ayetT4Y4g==
X-Received: by 2002:a17:90b:4b90:b0:268:f38:b2a1 with SMTP id lr16-20020a17090b4b9000b002680f38b2a1mr5836425pjb.41.1690301698541;
        Tue, 25 Jul 2023 09:14:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090a0c8300b00263f33eef41sm10758209pja.37.2023.07.25.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:14:58 -0700 (PDT)
Message-ID: <64bff502.170a0220.70c7e.3b42@mx.google.com>
Date:   Tue, 25 Jul 2023 09:14:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Kernel: v5.4.250-314-g1362bbd1b27c7
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.4.y build: 17 builds: 0 failed, 17 passed,
 38 warnings (v5.4.250-314-g1362bbd1b27c7)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y build: 17 builds: 0 failed, 17 passed, 38 warnings (v=
5.4.250-314-g1362bbd1b27c7)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.250-314-g1362bbd1b27c7/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.250-314-g1362bbd1b27c7
Git Commit: 1362bbd1b27c72f90eb34039a8d1b0f8b8468a5e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    multi_v5_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning
    vexpress_defconfig (gcc-10): 1 warning

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 2 warnings

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 warning

x86_64:
    allnoconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 4 warnings
    x86_64_defconfig (gcc-10): 5 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 5 warnings


Warnings summary:

    12   fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=
=99 from =E2=80=98struct super_block *=E2=80=99 makes integer from pointer =
without a cast [-Wint-conversion]
    7    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    4    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer=
 to integer of different size [-Wpointer-to-int-cast]
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    2    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpolin=
e, please patch it in with alternatives and annotate it with ANNOTATE_NOSPE=
C_ALTERNATIVE.
    2    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: un=
supported intra-function call
    2    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x151: un=
supported intra-function call
    2    arch/x86/entry/entry_64.S:1756: Warning: no instruction mnemonic s=
uffix given and no register operands; using default for `sysret'

Section mismatches summary:

    1    WARNING: vmlinux.o(___ksymtab_gpl+vic_init_cascaded+0x0): Section =
mismatch in reference from the variable __ksymtab_vic_init_cascaded to the =
function .init.text:vic_init_cascaded()

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sectio=
n mismatches

Warnings:
    arch/x86/entry/entry_64.S:1756: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x151: unsuppo=
rted intra-function call
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warn=
ings, 0 section mismatches

Warnings:
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 secti=
on mismatches

Warnings:
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

Section mismatches:
    WARNING: vmlinux.o(___ksymtab_gpl+vic_init_cascaded+0x0): Section misma=
tch in reference from the variable __ksymtab_vic_init_cascaded to the funct=
ion .init.text:vic_init_cascaded()

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

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
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 section=
 mismatches

Warnings:
    arch/x86/entry/entry_64.S:1756: Warning: no instruction mnemonic suffix=
 given and no register operands; using default for `sysret'
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x151: unsuppo=
rted intra-function call
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
5 warnings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    fs/ext4/ioctl.c:595:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
