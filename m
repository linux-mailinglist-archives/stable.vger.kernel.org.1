Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0CA75D20C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjGUSzn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjGUSzl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:55:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6B53AAD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:55:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666eec46206so1990104b3a.3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689965725; x=1690570525;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3lKI4Mo9d66lEc4WMviNOsPpaWUYxmngdxYB5YN5GFk=;
        b=FhgNFLszSyBW8RXzyj+t+JIaBVmoa10Xc4sMYL/WrszXzbLZRYwyWegSkOjfitd5TU
         WpYOLXSpCvIrRgQRzRoY4Ord9l32hyHQ09kewwpI7B2PZ8J17Wd3hUI7UKl9L46mV8/l
         4PwygFQb2T3xB7kw6E+PvIU01Ho0X0vZ20Qpr0SIFd/HuSlFsK+colullA7el0n7MYDP
         zJsxA9UsTVtX+CS9t4VtPoqc57HiRnRw07YRFUMnJSsvN7UXT5pE3ILQlSdvDLGXi96v
         LqlrKpA34fAB7evpRVLUQg7NR3w1Qs7Tz8RGqCmma/kJSM72EkD6OEC2SIUyUNq+zV+V
         f/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689965725; x=1690570525;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lKI4Mo9d66lEc4WMviNOsPpaWUYxmngdxYB5YN5GFk=;
        b=h8X1Gvv7jyCtA5TEvF77uvv4ZjU8381DV+OZddcf7otrrDO818KWszZZoL+tjdNbll
         EM9nfLPdmqjOJ29ZivlwpQb+gtuWnkhWXRfbiswo0UjqvvnHaZTcJibge4pVloOtLcmj
         yaifSADVzni2ObirGG3669GHVtbkk8uU0pT6NmNuzGDmBhH9JNnFPQ/SgYhxe8h6G7d+
         tgGE1eIbazJN7sFqNDWFK99KxastkLR9wdZpJw/SIDp8TMNGYQV/EP/O5dx4+KJQX0A6
         udF0pzoKhbxjzmfM94vaHoghihm2iInJ/ZUeTN7zY0/inAPDVlLLR+X1O6zKm7MgjVvB
         9zSw==
X-Gm-Message-State: ABy/qLZP0l7pfGxG8Yeg3nW+YJ0p9PIDrUrl+gNzl7eNyqRkyFr+omtJ
        q9eXXMEqJjUn6YjahABzdH/+/usxdG0oVg2qopk=
X-Google-Smtp-Source: APBJJlE+ST3h/YaH1O17kXPA/uBnYyQKDnuEqkPCBw9ussWEiOUhpV9snuabiMj7UYMd5M5CBCmk2A==
X-Received: by 2002:a05:6a00:2ea6:b0:682:4e4c:48bc with SMTP id fd38-20020a056a002ea600b006824e4c48bcmr1087899pfb.21.1689965724995;
        Fri, 21 Jul 2023 11:55:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7854b000000b006687b41c4dasm3294856pfn.110.2023.07.21.11.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:55:24 -0700 (PDT)
Message-ID: <64bad49c.a70a0220.d7bda.62be@mx.google.com>
Date:   Fri, 21 Jul 2023 11:55:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.320-125-g5cffa7b2aa8b
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-4.14.y build: 6 builds: 0 failed, 6 passed,
 18 warnings (v4.14.320-125-g5cffa7b2aa8b)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.14.y build: 6 builds: 0 failed, 6 passed, 18 warnings (v4=
.14.320-125-g5cffa7b2aa8b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.320-125-g5cffa7b2aa8b/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.320-125-g5cffa7b2aa8b
Git Commit: 5cffa7b2aa8b04d9314eff634a714e0c6fc2b754
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 3 unique architectures

Warnings Detected:

arm:
    multi_v7_defconfig (gcc-10): 1 warning
    vexpress_defconfig (gcc-10): 1 warning

i386:
    allnoconfig (gcc-10): 3 warnings
    i386_defconfig (gcc-10): 4 warnings

x86_64:
    allnoconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 6 warnings


Warnings summary:

    4    ld: warning: creating DT_TEXTREL in a PIE
    4    fs/ext4/ioctl.c:523:7: warning: assignment to =E2=80=98int=E2=80=
=99 from =E2=80=98struct super_block *=E2=80=99 makes integer from pointer =
without a cast [-Wint-conversion]
    2    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    2    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    2    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    2    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h=
' differs from latest kernel version at 'arch/x86/include/asm/insn.h'
    1    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x73: return with modified stack frame
    1    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x0: stack state mismatch: cfa1=3D7+104 cfa2=3D7+8

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 secti=
on mismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    fs/ext4/ioctl.c:523:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:523:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:523:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 6 warnings, 0 s=
ection mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    fs/ext4/ioctl.c:523:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x73: return with modified stack frame
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x0: stack state mismatch: cfa1=3D7+104 cfa2=3D7+8
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
