Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297097D26DB
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 00:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjJVWoH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 18:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVWoH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 18:44:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C71DE4
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 15:44:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2122904a12.1
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698014643; x=1698619443; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WISGDkNBNcYJo05HBBRLQYwXVwq8z2uGs5wWp2WBwG8=;
        b=KHMtXoSiwJGDfoXInMaNLYT1/hnDO4xViC6xJouKn6PU4H/MtxLNk9QnAy0prcwIj3
         tTRASfdtI5MfkklVarxSdkIyoKaLD3IsBnfDdaSOSSn3dfefTavs/CDvZLo0mzYkA32Y
         Ao1XOR1oTK79/nQRjPc71hQvBOPzCMsp9bPod3KQGCpQN/31qjQP2nVG4bqlUSErBNMK
         bP67NqDdoR2kbre/Yb+Qa3ZfM3lbOsOHOKU4L+s2TES1zlSq9wMAR8/1VvU7Br3h6hD5
         JWZitU2mbTndbAn472Oa/GTHk3d5fVVlDrp/oHS2/SVJboe5+Gegldyzr6dn8uKUcyzK
         3iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698014643; x=1698619443;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WISGDkNBNcYJo05HBBRLQYwXVwq8z2uGs5wWp2WBwG8=;
        b=TKl0KeF/aN1Bd3qYezkzdccEO6QhLd/Xb/SCsctSl9BtkaUXPOftRNGQYH49054u2j
         mkmvtONNe73FBuFsaWmMxG31txMr7YVlrs+jfAwnzOMcprB62TFoPiH3sgJfVx4QM5v2
         qtygjXek3RzDE09l94HN9CjTdUwZ3uA3oz571zqtuiikDEGL1Y8eqEzmWc5C+SCZZcK2
         bjbesaYCOc8lWUq0pdx2gi6ODTZqydlv4RduXvrPukeY5hBPgOORU1EmKMSCiHz3Sq3f
         XskqkHjW0Iyc70YgoASv7n8ZfMSJ1KL4PL6A4UO0CIPMKi+Kko1IDQH4i27OGGYMJBwA
         UYNQ==
X-Gm-Message-State: AOJu0Yxp+sD3dS/6sH4DHl8ILgdOKYvls7ZQ5wt61vqywmTagt5jX5wD
        8t967gEjU+WI1tV+8JLwbC7bsFQpPe+q15FrTN0bNA==
X-Google-Smtp-Source: AGHT+IF+9E/lApc8tHrDmvAZz3yQ+IiKXD38CUkA1OUWRe5ErK+lysqOks/sS1SUlrgXIGdM1uKKqw==
X-Received: by 2002:a05:6a20:6a05:b0:154:fb34:5f09 with SMTP id p5-20020a056a206a0500b00154fb345f09mr10217967pzk.15.1698014643450;
        Sun, 22 Oct 2023 15:44:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7990e000000b006b4ac8885b4sm5112074pff.14.2023.10.22.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 15:44:02 -0700 (PDT)
Message-ID: <6535a5b2.a70a0220.4534e.f31c@mx.google.com>
Date:   Sun, 22 Oct 2023 15:44:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.4.258-119-g9842aef4b12b
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.4.y build: 17 builds: 2 failed, 15 passed, 8 errors,
 30 warnings (v5.4.258-119-g9842aef4b12b)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y build: 17 builds: 2 failed, 15 passed, 8 errors, 30 w=
arnings (v5.4.258-119-g9842aef4b12b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.258-119-g9842aef4b12b/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.258-119-g9842aef4b12b
Git Commit: 9842aef4b12b300a40f0bc2d408313e89a790d20
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm:
    imx_v6_v7_defconfig: (gcc-10) FAIL
    multi_v7_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 2 warnings
    defconfig+arm64-chromebook (gcc-10): 2 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 4 errors, 2 warnings
    multi_v7_defconfig (gcc-10): 4 errors, 2 warnings

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

Errors summary:

    2    drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of fu=
nction =E2=80=98gpio_irq_chip_set_chip=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
    2    drivers/gpio/gpio-vf610.c:251:2: error: =E2=80=98GPIOCHIP_IRQ_RESO=
URCE_HELPERS=E2=80=99 undeclared here (not in a function)
    2    drivers/gpio/gpio-vf610.c:250:6: error: =E2=80=98IRQCHIP_ENABLE_WA=
KEUP_ON_SUSPEND=E2=80=99 undeclared here (not in a function); did you mean =
=E2=80=98IRQCHIP_MASK_ON_SUSPEND=E2=80=99?
    2    drivers/gpio/gpio-vf610.c:249:11: error: =E2=80=98IRQCHIP_IMMUTABL=
E=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98IS_IM=
MUTABLE=E2=80=99?

Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    4    arch/arm64/include/asm/memory.h:238:15: warning: cast from pointer=
 to integer of different size [-Wpointer-to-int-cast]
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    2    drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struc=
t initializer
    2    cc1: some warnings being treated as errors
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
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 4 errors, 2 warnings, 0 s=
ection mismatches

Errors:
    drivers/gpio/gpio-vf610.c:249:11: error: =E2=80=98IRQCHIP_IMMUTABLE=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98IS_IMMUTA=
BLE=E2=80=99?
    drivers/gpio/gpio-vf610.c:250:6: error: =E2=80=98IRQCHIP_ENABLE_WAKEUP_=
ON_SUSPEND=E2=80=99 undeclared here (not in a function); did you mean =E2=
=80=98IRQCHIP_MASK_ON_SUSPEND=E2=80=99?
    drivers/gpio/gpio-vf610.c:251:2: error: =E2=80=98GPIOCHIP_IRQ_RESOURCE_=
HELPERS=E2=80=99 undeclared here (not in a function)
    drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of functio=
n =E2=80=98gpio_irq_chip_set_chip=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]

Warnings:
    drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct ini=
tializer
    cc1: some warnings being treated as errors

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 4 errors, 2 warnings, 0 se=
ction mismatches

Errors:
    drivers/gpio/gpio-vf610.c:249:11: error: =E2=80=98IRQCHIP_IMMUTABLE=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98IS_IMMUTA=
BLE=E2=80=99?
    drivers/gpio/gpio-vf610.c:250:6: error: =E2=80=98IRQCHIP_ENABLE_WAKEUP_=
ON_SUSPEND=E2=80=99 undeclared here (not in a function); did you mean =E2=
=80=98IRQCHIP_MASK_ON_SUSPEND=E2=80=99?
    drivers/gpio/gpio-vf610.c:251:2: error: =E2=80=98GPIOCHIP_IRQ_RESOURCE_=
HELPERS=E2=80=99 undeclared here (not in a function)
    drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of functio=
n =E2=80=98gpio_irq_chip_set_chip=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]

Warnings:
    drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct ini=
tializer
    cc1: some warnings being treated as errors

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
