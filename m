Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9494377A27F
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 22:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHLUb7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 16:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjHLUb6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 16:31:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADA8100
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 13:32:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc8045e09dso20432515ad.0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691872320; x=1692477120;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hhRXhNnPIf4F+Mf6DwzxfKiu2BHtAhqFjzNFLibw6b0=;
        b=Nm6TJih8//oTLGnsubDOF/3mk7VfCfI0iyL2lkzHOfXC6A2lBurSUA0pPS1AZh5xjX
         rZm03Sj2CJ7um2ifK3q0ntmFUPluFgGAyga2GgEVoFhIcAlZctpOdW63CKmsNrocUMhC
         IOoJ0mLN57DUmcZf8rHT7sSYaqXtBBx9gWFTyCGy6kVVajTPcgZVoZxhJVymPRLAww1v
         0KfFkn/G69RdCUZX571XVGU2chuYfN+bErIqvReqNxtejHXSu6wZGImA9QxfBqA3Gf7e
         yQzhKFL0fkZgxJqTShPVOcxGKCa6oBUfSqCiifq/r9GDvmqUGgV7JQd70bsRwi5UcVV+
         106g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691872320; x=1692477120;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhRXhNnPIf4F+Mf6DwzxfKiu2BHtAhqFjzNFLibw6b0=;
        b=gKzl6++ChfIENiWmBmhbxUJLkkcPTndkcscbk7ZRhIBxCWehpAl3i0gHViXshqK7wh
         8BLZ1VFH5frDUrsfKbSdj1azEX1hv+FgCT/Awe8JXk3FAVbnyxWQdsiTaPcW27ey4Etv
         L5a/n21khB6O3uZjy3ZLV/ndvRWy1O4Ow+i7U5ZEgBR8WQ4yvKi5ETKfxxMtNMN3cxGK
         /dgpDc6kT7QEe6pqjCD8GpLj4Oyu1u2JSiyUokcXQSWYnDezxe6lGB6FXR/LFvgpgOaD
         bv7N4Ml5DK7Rd6mq0BTwqAiZ4wjZOBlyKGASqfkWBl9nZzlyZriyDTgYeYOJOslds/Hz
         +m2g==
X-Gm-Message-State: AOJu0YxObQf/3u77DGe13DQlZSe5TojKgOA6styPXh4iZCdXdsWiq5Wa
        lc2w6yfGC3hwk051SU3lPtdia4iHt2DaGVMtDLj+jw==
X-Google-Smtp-Source: AGHT+IEcIje6YWYzt8G0nAGP5d+GPd6YZk1mNLIxt79eWpmNa7IRY3buhQV5ZXHgXB+Cr1fnCtzIDg==
X-Received: by 2002:a17:902:ea03:b0:1bc:4f77:e34f with SMTP id s3-20020a170902ea0300b001bc4f77e34fmr6026015plg.27.1691872319847;
        Sat, 12 Aug 2023 13:31:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001b81a97860asm6332079pln.27.2023.08.12.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 13:31:59 -0700 (PDT)
Message-ID: <64d7ec3f.170a0220.abcf5.bb73@mx.google.com>
Date:   Sat, 12 Aug 2023 13:31:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.4.253-29-gefb31a3fc0b7
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.4.y
Subject: stable-rc/linux-5.4.y build: 17 builds: 0 failed, 17 passed,
 26 warnings (v5.4.253-29-gefb31a3fc0b7)
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

stable-rc/linux-5.4.y build: 17 builds: 0 failed, 17 passed, 26 warnings (v=
5.4.253-29-gefb31a3fc0b7)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.253-29-gefb31a3fc0b7/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.253-29-gefb31a3fc0b7
Git Commit: efb31a3fc0b7a84336ba023b4610872a44c0d7bd
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 2 warnings
    defconfig+arm64-chromebook (gcc-10): 2 warnings

arm:

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 4 warnings
    x86_64_defconfig (gcc-10): 4 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 4 warnings


Warnings summary:

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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warn=
ings, 0 section mismatches

Warnings:
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]

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
    WARNING: vmlinux.o(___ksymtab_gpl+vic_init_cascaded+0x0): Section misma=
tch in reference from the variable __ksymtab_vic_init_cascaded to the funct=
ion .init.text:vic_init_cascaded()

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
4 warnings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1c1: unsuppo=
rted intra-function call
    arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, pl=
ease patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALT=
ERNATIVE.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
